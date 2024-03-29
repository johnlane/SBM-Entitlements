USE [TeamTrack_Db]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_TT_EntitlementsReport]
AS

/*
    Copyright (c) 2012 John Lane

    License: MIT. See LICENSE file. 

    ----------------------------------------------------------------------
    -- SBM ENTITLEMENTS REPORT                                          --
    ----------------------------------------------------------------------

This is a rather large file.

This query generates an entitlements report listing users and their entitlements.

Users gain entitlements in one or more of five ways:

•	By direct assignment to the user.
•	By direct assignment to a group of which the user is a member.
•	By assignment to a role that is given to directly to the user.
•	By assignment to a role that is given to directly to a group of which the 
    user is a member.
•	By inheritance.

It is possible for a user to be granted the same entitlement in more than one
way, so removing an entitlement may require removing it from multiple places.

There are two mechansims in SBM for entitlement control. These are called 
"privileges" and "permissions"; I use the term “entitlement” to collectively
refer to both of these. 

The older "privilege" system gives entitlements directly to groups and/or users. 
In this context the entitlements are called “privileges” and are maintained
using the Serena Administrator tool. They can be effected on demand.

The newer "permission" system gives entitlements to roles and then assigns those 
roles to groups and/or users. In this context the entitlements are called 
“permissions” and are maintained using the Serena Composer which means that a
deploy cycle is required to effect any changes. 

This query is in two sections, one providing a "PRIVILEGES_REPORT" and one providing
a "PERMISSIONS_REPORT". These are unioned into a single "ENTITLEMENTS_REPORT".
Each section can operate on its own if cut and pasted into a new file.

There is a mapping between “permissions” and the equivalent “privileges”. 
Permission records contain privilege id values. These id values are enumerations 
defined in the SBM header file (TSDef.h). The queries do not depend on this 
mapping.

The "ENTITLEMENTS_REPORT" shows entitlements per user. Each granted entitltment
is represented as a record and contains one or more of user, group, role depending
on how the entitlement is assigned:

	• An entitlement assigned directly to a user will contain a user.
    • An entitlement assigned directly to a group will contain a user and group.
    • An entitlement assigned to a role given to a user will contain a user and role.
    • An entitlement assigned to a role given to a group will contain a user, group 
      and role.

The privilege and permission sections are documented separately.

The ENTITLEMENTS_REPORT (vw_TT_EntitlementsReport) is processed further to produce 
another report called ENTITLEMENTS_REPORT_INHERITED (vw_TT_EntitlementsReportInherited)
that also lists inherited entitlements.

*/


--------------------------------------------------------------------
-- BEGINNING OF CODE FOR THE USER/GROUP PRIVILEGES QUERIES ---------
--------------------------------------------------------------------

/*

 TeamTrack Privilege Analysis Report

 The primary privilege allocation table is called TS_PRIVILEGES. It contains one row
 for each user or group that has privileges directly assigned. Privileges are 
 assigned to "system", "table" and "project" items.

 If there is no record for project privileges then the privileges of its 
 parent project are inherited. 

 if there is no record for system or table privileges then there are no privileges
 assigned. System and table privileges are not inherited.

 A row in the TS_PRIVILEGES table contans five bitmap fields called TS_MASK1
 through TS_MASK5 (each of which contains 32 bits) for a total of 160 privilege
 bits. 

 A row in the TS_PRIVILEGES table has a privilege type (in field TS_TYPE) and the
 meaning of the privilege bits depends on that privilege type (i.e. "system", 
 "table" or "project". This allows up to 160 privieleges to be represented for 
 each privilege type. 

 A row in the TS_PRIVILEGES table also has an item name (in field TS_NAME) which
 is a specific instance of the privilege type. For example a row for table privileges
 includes the name of the table to which the privileges apply. 

 A row will apply to a user or to a group but never both: one of the TS_USERID
 and TS_GROUP_ID fields will be zero.

 The meaning of the bits in the privilege bitmap fields is stored in the table
 TT_PRIVILEGE_BITMAPS which is a mapping from bit value to privilege name. This table
 is not part of the standard TeamTrack database but has been created internally
 by reverse-engineering the privileges (Serena could not provide the information).

 The query below is complex. There are 8 CTEs ("WITH" clauses) used to organise 
 and manipulate the data in TS_PRIVILEGES and TT_PRIVILEGE_BITMAPS to provide a 
 PRIVILEGES_REPORT.
 
 PRIVILEGE_BITMAPS denormalises TS_PRIVILEGES.
 GROUP_PRIVILEGE_BITMAPS takes group records from PRIVILEGE_BITMAPS  
 and makes one user record for every user in each group.
 USER_PRIVILEGE_BITMAPS takes user records from PRIVILEGE_BITMAPS.
 PRIVILEGE_BITMAPS_ALL is the union of GROUP_PRIVILEGE_BITMAPS and USER_PRIVILEGE_BITMAPS.
 PRIVILEGES sets up the data we want to use from TT_PRIVILEGE_BITMAPS.
 PRIVILEGE_BITMAPS_UNPIVOTED presents each row in PRIVILEGE_BITMAPS_ALL as five
 rows, each with one bitmap field and a bitmap id.
 PRIVILEGES_JOINED is each unpivoted row joined to the PRIVILEGES by the privilege bit 
 mask. This results in one row per bit in the mask. Neat.

 PRIVILEGES_REPORT contains one row per user per privilege obtained directly or 
 via group membership.

*/

WITH PRIVILEGE_BITMAPS AS
(
     SELECT p.[TS_ID] as ID
      ,CASE p.[TS_TYPE] 
         WHEN 0x00000010 THEN 'USERSYS' 
         WHEN 0x00000011 THEN 'USERPRJ'
         WHEN 0x00000012 THEN 'USERWKF'
         WHEN 0x00000013 THEN 'USERFLD'
         WHEN 0x00000014 THEN 'USERTBL'
		 WHEN 0x00000020 THEN 'ADMSYS'
		 WHEN 0x00000021 THEN 'ADMPRJ'
		 WHEN 0x00000022 THEN 'ADMWKF'
		 WHEN 0x00000023 THEN 'ADMFLD_PRJ'
		 WHEN 0x00000025 THEN 'ADMFLD_WKF'
		 WHEN 0x00000040 THEN 'ADMCON'
		 WHEN 0x1000000f THEN 'UNKNOWN'
		 WHEN 0x0000000f THEN 'SYSMASK'
	--	 WHEN 0x00000020 THEN 'ADMMASK' duplicated in TSDef.h
		 WHEN 0x00000004 THEN 'TBLNMASK'
         ELSE master.sys.fn_varbintohexstr (p.[TS_TYPE]) 
       END as PRIVTYPE

      ,u.[TS_NAME] as USERNAME       
      ,p.[TS_USERID] as USERID
      ,g.[TS_NAME] as GROUPNAME      
      ,p.[TS_GROUPID] as GROUPID

      ,CASE p.[TS_TYPE]              -- ,p.[TS_PROJECTID]
         WHEN 0x00000010 /* System  */ THEN 'USERSYS'
         WHEN 0x00000011 /* project */ THEN prj.[TS_NAME]
         WHEN 0x00000012 THEN 'USERWKF'
         WHEN 0x00000013 /* folder  */ THEN fld.[TS_NAME]
         WHEN 0x00000014 /* table   */ THEN tbl.[TS_NAME]
         WHEN 0x00000020 THEN 'ADMSYS'
         WHEN 0x00000021 THEN 'ADMPRJ'
         WHEN 0x00000022 THEN 'ADMWKF'
		 WHEN 0x00000023 THEN 'ADMFLD_PRJ'
		 WHEN 0x00000025 THEN 'ADMFLD_WKF'
		 WHEN 0x00000040 THEN 'ADMCON'
		 WHEN 0x1000000f THEN 'UNKNOWN'
		 WHEN 0x0000000f THEN 'SYSMASK'
	--	 WHEN 0x00000020 THEN 'ADMMASK'
		 WHEN 0x00000004 THEN 'TBLNMASK'
         ELSE master.sys.fn_varbintohexstr (p.[TS_TYPE]) 

       END as ITEMNAME

      ,CASE p.[TS_TYPE]              -- ,p.[TS_PROJECTID]
         WHEN 0x00000011 /* project */ THEN prj.[TS_ID]
         WHEN 0x00000013 /* folder  */ THEN fld.[TS_ID]
         WHEN 0x00000014 /* table   */ THEN tbl.[TS_ID]
         ELSE NULL 
       END as ITEMID

      ,CASE p.[TS_TYPE]              -- ,p.[TS_PROJECTID]
         WHEN 0x00000010 /* System  */ THEN 'System'
         WHEN 0x00000011 /* project */ THEN 'Project'
         WHEN 0x00000013 /* folder  */ THEN 'Folder'
         WHEN 0x00000014 /* table   */ THEN 'Table'
         ELSE master.sys.fn_varbintohexstr (p.[TS_TYPE])
       END as ITEMTYPE

      ,CASE p.[TS_TYPE]
         WHEN 0x00000011 /* project */ THEN pprj.[TS_NAME]
         WHEN 0x00000013 /* folder  */ THEN pfld.[TS_NAME]
         ELSE NULL
       END as PARENTITEMNAME

      ,CASE p.[TS_TYPE]
         WHEN 0x00000011 /* project */ THEN pprj.[TS_ID]
         WHEN 0x00000013 /* folder  */ THEN pfld.[TS_ID]
         ELSE NULL
       END as PARENTITEMID


 --   ,p.[TS_REPORTID] Reserved for future use by Serena
 --   ,p.[TS_TRANSID]  Reserved for future use by Serena
      ,p.[TS_MASK1] as BITMAP1
      ,p.[TS_MASK2] as BITMAP2
      ,p.[TS_MASK3] as BITMAP3
      ,p.[TS_MASK4] as BITMAP4
--    ,p.[TS_FOLDERID] Deprecated in Database Version 500
      ,p.[TS_MASK5] as BITMAP5

  FROM [TS_PRIVILEGES] p

  left outer join [TS_USERS] u      on p.[TS_USERID]    = u.[TS_ID]
  left outer join [TS_GROUPS] g     on p.[TS_GROUPID]   = g.[TS_ID]
  left outer join [TS_TABLES] tbl   on p.[TS_PROJECTID] = tbl.[TS_ID]
  left outer join [TS_FOLDERS] fld  on p.[TS_PROJECTID] = fld.[TS_ID]
  left outer join [TS_PROJECTS] prj on p.[TS_PROJECTID] = prj.[TS_ID]
  left outer join [TS_PROJECTS] pprj on prj.[TS_PARENTID] = pprj.[TS_ID]
  left outer join [TS_FOLDERS] pfld on fld.[TS_PARENTID] = pfld.[TS_ID]

), GROUP_PRIVILEGE_BITMAPS AS
(
    SELECT p.[ID]
          ,p.[PRIVTYPE]
          ,u.[TS_NAME] AS USERNAME
          ,m.[TS_USERID] AS USERID
          ,p.[GROUPNAME]
          ,p.[GROUPID]
          ,p.[ITEMNAME]
          ,p.[ITEMID]
          ,p.[ITEMTYPE]
          ,p.[PARENTITEMNAME]
          ,p.[PARENTITEMID]
          ,p.[BITMAP1]
          ,p.[BITMAP2]
          ,p.[BITMAP3]
          ,p.[BITMAP4]
          ,p.[BITMAP5]

          FROM PRIVILEGE_BITMAPS p

    left outer join [TS_MEMBERS] m on p.[GROUPID]    = m.[TS_GROUPID]
    left outer join [TS_USERS] u   on m.[TS_USERID]  = u.[TS_ID]

    where p.[GROUPID] >0 
), USER_PRIVILEGE_BITMAPS AS
(
    SELECT * from PRIVILEGE_BITMAPS p
    WHERE p.[USERID] > 0

), PRIVILEGE_BITMAPS_ALL AS
(
    SELECT * from GROUP_PRIVILEGE_BITMAPS
    UNION
    SELECT * from USER_PRIVILEGE_BITMAPS

), PRIVILEGES AS
(
    SELECT PRIVILEGE_TYPE as PRIVTYPE 
          ,BITMAP_ID
          ,BIT_VALUE as BITVALUE
          ,PRIVILEGE_NAME
    FROM TT_PRIVILEGE_BITMAPS

), PRIVILEGE_BITMAPS_UNPIVOTED AS (
  SELECT
    ID,
    PRIVTYPE,
    USERID,
    USERNAME,
    GROUPID,
    GROUPNAME,
    ITEMNAME,
    ITEMTYPE,
    ITEMID,
    PARENTITEMNAME,
    PARENTITEMID,
    RIGHT(BITMAP_ID, 1) AS BITMAP_ID,  
    BITMAP_VAL
  FROM PRIVILEGE_BITMAPS_ALL
  UNPIVOT (
    BITMAP_VAL FOR BITMAP_ID IN (
      BITMAP1, BITMAP2, BITMAP3, BITMAP4, BITMAP5
    )
  ) u
),
PRIVILEGES_JOINED AS (
  SELECT
    u.ID AS PRIVILEGEBITMAPID,
    u.USERID,
    u.USERNAME,
    u.GROUPID,
    u.GROUPNAME,
    u.PRIVTYPE,
    u.ITEMNAME,
    u.ITEMTYPE,
    u.ITEMID,
    u.PARENTITEMNAME,
    u.PARENTITEMID,
    p.PRIVILEGE_NAME
  FROM PRIVILEGE_BITMAPS_UNPIVOTED u
    INNER JOIN PRIVILEGES p
       ON u.PRIVTYPE = p.PRIVTYPE
      AND u.BITMAP_ID = p.BITMAP_ID
      AND u.BITMAP_VAL & p.BITVALUE <> 0
)

, PRIVILEGES_REPORT AS
(
SELECT  USERID
       ,USERNAME
       ,GROUPID
       ,GROUPNAME
       ,NULL as ROLEID
       ,NULL as ROLENAME
       ,ITEMNAME
       ,ITEMID
       ,ITEMTYPE
       ,PARENTITEMNAME
       ,PARENTITEMID
       ,PRIVILEGE_NAME AS PERMISSIONNAME

 FROM PRIVILEGES_JOINED
)

--------------------------------------------------------------------
-- END OF CODE FOR THE USER/GROUP PRIVILEGES QUERIES ---------------
--------------------------------------------------------------------

--------------------------------------------------------------------
-- BEGINNING OF CODE FOR THE ROLE_PERMISSIONS QUERIES --------------
--------------------------------------------------------------------

/*

 TeamTrack Permission Analysis Report

 Permissions are allocated to roles and roles are allocated to users
 and/or groups.

 The primary permission allocation table is called TS_ROLEPERMISSIONS. It 
 contains one row for each permission allocated to a role.

 The primary role allocation table is called TS_SECURITYCONTROLS. It contains
 one row for each user or group allocated to a role.

 Permissions are not inherited.
 
 The query below has 8 CTEs ("WITH" clauses) used to organise 
 and manipulate the data in TS_PRIVILEGES and TT_PRIVILEGE_BITMAPS to provide a 
 PRIVILEGES_REPORT.

 PERMISSIONS denormalises TS_PERMISSIONS
 ROLES denormalises TS_ROLES
 ROLEPERMISSIONS denormalises TS_ROLEPERMISSIONS
 SECURITYCONTROLS  denormalises TS_ROLEPERMISSIONS
 USER_SECURITYCONTROLS takes user records from SECURITYCONTROLS
 GROUP_SECURITYCONTROLS takes group records from SECURITYCONTROLS  
 and makes one user record for every user in each group.
 SECURITYCONTROLS_ALL is the union of GROUP_SECURITYCONTROLS and USER_SECURITYCONTROLS.
 
 PERMISSIONS_REPORT contains one row per user per permission obtained directly or 
 via group membership.
 
*/


, PERMISSIONS AS
(
/*

    Permissions are defined in the TS_PERMISSIONS table.

    The textual description refers to strings defined in
    TS_PERMISSIONACTIONS, TS_PERMISSIONOBJECTS and TS_PERMISSIONCONDITIONS
    and these are referenced via TS_ACTIONID, TS_OBJECTID and TS_CONDITIONID.
    
    The equivalent "privilege" enumerations from TSDef.h (privId_e) are 
    referenced in fields:
    * TS_PROJECTPRIVID for project privileges 
    * TS_TABLEPRIVID for table privileges.

    (there is no SBM table for looking up those enumerations but 
     I created one in file "TTPrivileges_Enumerations.sql")
    
*/

SELECT p.[TS_ID] AS PERMISSIONID
      ,REPLACE(REPLACE(REPLACE(p.[TS_NAME],'{0}',pa.[TS_NAME]),'{1}',po.[TS_NAME]),'{2}',pc.[TS_NAME]) AS PERMISSIONNAME
      ,p.[TS_PROJECTPRIVID] AS PROJECTPRIVID
      ,p.[TS_TABLEPRIVID]   AS TABLEPRIVID
  FROM [TS_PERMISSIONS] p
  JOIN [TS_PERMISSIONACTIONS] pa    ON pa.[TS_ID] = p.[TS_ACTIONID]
  JOIN [TS_PERMISSIONOBJECTS] po    ON po.[TS_ID] = p.[TS_OBJECTID]
  JOIN [TS_PERMISSIONCONDITIONS] pc ON pc.[TS_ID] = p.[TS_CONDITIONID]
)

/* 

    Roles are defined in the TS_ROLES table.

    Roles are assigned for an application (previously called "solutions" - these are 
    found in the TS_SOLUTIONS table). This query displays the application id and name.

*/

, ROLES AS
(

SELECT r.[TS_ID]   as ROLEID
      ,r.[TS_NAME] as ROLENAME
      ,s.[TS_ID] as APPLICATIONID
      ,s.[TS_NAME] as APPLICATIONNAME
      ,r.[TS_DESCRIPTION] as ROLEDESCRIPTION
  FROM [TS_ROLES] r
  JOIN [TS_SOLUTIONS] s ON s.[TS_ID] = r.[TS_SOLUTIONID] 
)

, ROLEPERMISSIONS AS
(   

/* 

    Permissions allocated to roles are controlled by the TS_ROLEPERMISSIONS table.

    This query denormalises the data and presents all the permissions granted
    by role.

    Role permissions are assigned for an application (previously called "solutions"
    these are found in the TS_SOLUTIONS table). This query displays the application name.

    Role permissions relate to either a table or workflow. The field TS_CONTEXTTYPE
    is an enumeration that describes the type of table/workflow. The field TS_CONTEXTID
    refers to the relevant table or workflow. This query displays the name of the related
    table or workflow as CONTEXTNAME.

*/

SELECT r.[ROLEID]
      ,p.[PERMISSIONID]
      ,r.[ROLENAME]          -- rp.[TS_ROLEID]  
      ,r.[APPLICATIONNAME]
      ,p.[PERMISSIONNAME]
    ,CASE rp.[TS_CONTEXTTYPE]
         WHEN 0 THEN 'TS_TYPECONTEXT_NONE'
         WHEN 1 THEN 'TS_TYPECONTEXT_PROJECT'
         WHEN 2 THEN 'TS_TYPECONTEXT_PRIMARY_TABLE'
         WHEN 3 THEN 'TS_TYPECONTEXT_AUX_TABLE'
         WHEN 4 THEN 'TS_TYPECONTEXT_WORKFLOW'
         ELSE CAST (rp.[TS_CONTEXTTYPE] AS VARCHAR)
     END AS CONTEXTTYPE
      ,CASE rp.[TS_CONTEXTTYPE]
           WHEN 1 THEN w.[TS_NAME]
           WHEN 2 THEN t.[TS_NAME]
           WHEN 3 THEN t.[TS_NAME]
           WHEN 4 THEN w.[TS_NAME]
       END AS CONTEXTNAME
      ,CASE rp.[TS_CONTEXTTYPE]
           WHEN 1 THEN p.[PROJECTPRIVID]
           WHEN 2 THEN p.[PROJECTPRIVID]
           WHEN 3 THEN p.[TABLEPRIVID]
           WHEN 4 THEN p.[PROJECTPRIVID]
       END AS PRIVILEGEID
  FROM [TS_ROLEPERMISSIONS] rp
  JOIN ROLES r ON r.[ROLEID] = rp.[TS_ROLEID]
  JOIN [PERMISSIONS] p ON p.[PERMISSIONID] = rp.[TS_PERMISSIONID]
  LEFT OUTER JOIN [TS_TABLES] t ON t.[TS_ID] = rp.[TS_CONTEXTID]
  LEFT OUTER JOIN [TS_WORKFLOWS] w ON w.[TS_ID] = rp.[TS_CONTEXTID]
)

, SECURITYCONTROLS AS
(

/*

   Role assignment is controlled via the TS_SECURITYCONTROLS table.

   Records in the TS_SECURITYCONTROLS table grant role entitlement to
   a user or group. The user or group then get the permissions that
   are assigned to the role. This is denoted by the value of the enumerated
   field TS_SUBJECT. This query displays the enumerated value ("group" or "user").

   The actual user or group is specified in TS_SUBJECTID. This query returns
   the relevant group name or user name.

   This query denormalises the data and presents all the roles 
   that are assigned to groups and users.

*/

SELECT sc.[TS_ID]
      ,CASE sc.[TS_SUBJECTTYPE]
           WHEN 1 THEN 'User'
           WHEN 2 THEN 'Group'
           ELSE CAST(sc.[TS_SUBJECTTYPE] AS VARCHAR)
       END AS SUBJECT
      ,CASE sc.[TS_SUBJECTTYPE] -- ,sc.[TS_SUBJECTID]
           WHEN 1 THEN u.[TS_NAME]
           WHEN 2 THEN g.[TS_NAME]
           ELSE CAST(sc.[TS_SUBJECTID] AS VARCHAR)
       END AS NAME
      ,CASE sc.[TS_SUBJECTTYPE] -- ,sc.[TS_SUBJECTID]
           WHEN 1 THEN u.[TS_ID]
           WHEN 2 THEN g.[TS_ID]
       END AS ID

      ,r.[ROLEID]
      ,r.[ROLENAME]  --,sc.[TS_PERMISSIONID]
      ,p.[TS_NAME] AS PROJECTNAME
      ,p.[TS_ID] AS PROJECTID
      ,sc.[TS_GRANTED] AS GRANTED
  FROM [TS_SECURITYCONTROLS] sc
  LEFT OUTER JOIN [TS_USERS] u ON u.[TS_ID] = sc.[TS_SUBJECTID]
  LEFT OUTER JOIN [TS_GROUPS] g ON g.[TS_ID] = sc.[TS_SUBJECTID]
  LEFT OUTER JOIN [TS_PROJECTS] p ON p.[TS_ID] = sc.[TS_CONTEXTID]
  LEFT OUTER JOIN ROLES r ON r.[ROLEID] = sc.[TS_PERMISSIONID]

)
, GROUP_SECURITYCONTROLS AS
(

/*
    GROUP_SECURITYCONTROLS takes group records from SECURITYCONTROLS  
    and makes one user record for every user in each group.

*/

SELECT u.[TS_ID] AS USERID
      ,u.[TS_NAME] AS USERNAME
      ,sc.ID AS GROUPID
      ,sc.NAME AS GROUPNAME
      ,sc.[ROLEID]
      ,sc.[ROLENAME]
      ,sc.PROJECTNAME
      ,sc.PROJECTID
   FROM SECURITYCONTROLS sc
    left outer join [TS_MEMBERS] m on sc.[ID]    = m.[TS_GROUPID]
    left outer join [TS_USERS] u   on m.[TS_USERID]  = u.[TS_ID]

  WHERE sc.SUBJECT='Group' and sc.GRANTED=1

)

, USER_SECURITYCONTROLS AS
(
/*
    USER_SECURITYCONTROLS takes user records from SECURITYCONTROLS.  
*/

SELECT sc.ID AS USERID
      ,sc.NAME AS USERNAME
      ,NULL AS GROUPID
      ,NULL AS GROUPNAME
      ,sc.[ROLEID]
      ,sc.[ROLENAME]
      ,sc.PROJECTNAME
      ,sc.PROJECTID
   FROM SECURITYCONTROLS sc

  WHERE sc.SUBJECT='User' and sc.GRANTED=1

)

, SECURITYCONTROLS_ALL AS
(

/* 
  SECURITYCONTROLS_ALL is the union of GROUP_SECURITYCONTROLS and USER_SECURITYCONTROLS.
*/

   SELECT * from GROUP_SECURITYCONTROLS
   UNION
   SELECT * from USER_SECURITYCONTROLS

)


, PERMISSIONS_REPORT AS
(
SELECT sc.[USERID]
      ,sc.[USERNAME]
      ,sc.[GROUPID]
      ,sc.[GROUPNAME]
      ,sc.[ROLEID]
      ,sc.[ROLENAME]
      ,sc.[PROJECTNAME] as ITEMNAME
      ,sc.[PROJECTID] as ITEMID
      ,'Project' as ITEMTYPE
      ,NULL as PARENTITEMNAME
      ,NULL as PARENTITEMID
  --    ,rp.[APPLICATIONNAME]
  --    ,rp.[PERMISSIONID]
      ,rp.[PERMISSIONNAME]
  --    ,rp.[PRIVILEGEID]
  --    ,rp.[CONTEXTNAME]
  --    ,rp.[CONTEXTTYPE]
  FROM SECURITYCONTROLS_ALL sc
  JOIN ROLEPERMISSIONS rp ON rp.[ROLEID] = sc.[ROLEID]
 
)

--------------------------------------------------------------------
-- END OF CODE FOR THE ROLE_PERMISSIONS QUERIES --------------------
--------------------------------------------------------------------

--------------------------------------------------------------------
-- CODE BELOW COLLATES OUTPUT---------------------------------------
--------------------------------------------------------------------

SELECT --'1' AS 'UNION',
       ITEMTYPE
      ,ITEMNAME
      ,ITEMID
      ,USERNAME
      ,USERID
      ,GROUPNAME
      ,GROUPID
      ,ROLENAME
      ,ROLEID
      ,ITEMNAME AS PERMISSIONEDITEMNAME -- for compatibility with inheritance report
      ,ITEMID AS PERMISSIONEDITEMID     -- for compatibility with inheritance report
      ,PARENTITEMNAME
      ,PARENTITEMID
      ,PERMISSIONNAME
--      ,PERMISSIONID
FROM PRIVILEGES_REPORT
UNION
SELECT --'2' AS 'UNION',
       ITEMTYPE
      ,ITEMNAME, ITEMID
      ,USERNAME, USERID
      ,GROUPNAME, GROUPID
      ,ROLENAME, ROLEID
      ,ITEMNAME AS PERMISSIONEDITEMNAME -- for compatibility with inheritance report
      ,ITEMID AS PERMISSIONEDITEMID     -- for compatibility with inheritance report
      ,PARENTITEMNAME, PARENTITEMID
      ,PERMISSIONNAME--, PERMISSIONID
FROM PERMISSIONS_REPORT
