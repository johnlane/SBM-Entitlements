/*
    Copyright (c) 2012 John Lane

    License: MIT. See LICENSE file. 
*/

USE [TeamTrack_Db]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_TT_EntitlementsReportInherited]
AS

-- directly assigned entitlements (not inherited)
SELECT --'1' AS 'UNION',
       er.ITEMTYPE
      ,er.ITEMNAME, er.ITEMID
      ,er.USERNAME, er.USERID
      ,er.GROUPNAME, er.GROUPID
      ,er.ROLENAME, er.ROLEID
      ,er.ITEMNAME AS PERMISSIONEDITEMNAME
      ,er.ITEMID AS PERMISSIONEDITEMID
      ,er.PARENTITEMNAME, er.PARENTITEMID
      ,er.PERMISSIONNAME--, er.PERMISSIONID 
FROM [vw_TT_EntitlementsReport] er 
UNION
-- project item entitlements inherited from parent item
SELECT --'2' AS 'UNION',
       er.ITEMTYPE
      ,p.TS_NAME AS ITEMNAME, p.TS_ID AS ITEMID
      ,er.USERNAME, er.USERID
      ,er.GROUPNAME, er.GROUPID
      ,er.ROLENAME, er.ROLEID
      ,er.ITEMNAME AS PERMISSIONEDITEMNAME
      ,er.ITEMID AS PERMISSIONEDITEMID
      ,er.PARENTITEMNAME, er.PARENTITEMID
      ,er.PERMISSIONNAME--, er.PERMISSIONID 
FROM TS_PROJECTS p 
JOIN [vw_TT_EntitlementsReport] er ON er.ITEMID = p.TS_PARENTID AND er.ITEMTYPE = 'Project' 
UNION
-- project item entitlements inherited from grandparent item
SELECT --'3' AS 'UNION',
       er.ITEMTYPE
      ,p.TS_NAME AS ITEMNAME, p.TS_ID AS ITEMID
      ,er.USERNAME, er.USERID
      ,er.GROUPNAME, er.GROUPID
      ,er.ROLENAME, er.ROLEID
      ,er.ITEMNAME AS PERMISSIONEDITEMNAME
      ,er.ITEMID AS PERMISSIONEDITEMID
      ,er.PARENTITEMNAME, er.PARENTITEMID
      ,er.PERMISSIONNAME--, er.PERMISSIONID 
FROM TS_PROJECTS p 
JOIN TS_PROJECTS gp ON gp.TS_ID = p.TS_PARENTID
JOIN [vw_TT_EntitlementsReport] er ON er.ITEMID = gp.TS_PARENTID AND er.ITEMTYPE = 'Project'
UNION
-- project item entitlements inherited from great grandparent item
SELECT --'4' AS 'UNION',
       er.ITEMTYPE
      ,p.TS_NAME AS ITEMNAME, p.TS_ID AS ITEMID
      ,er.USERNAME, er.USERID
      ,er.GROUPNAME, er.GROUPID
      ,er.ROLENAME, er.ROLEID
      ,er.ITEMNAME AS PERMISSIONEDITEMNAME
      ,er.ITEMID AS PERMISSIONEDITEMID
      ,er.PARENTITEMNAME, er.PARENTITEMID
      ,er.PERMISSIONNAME--, er.PERMISSIONID 
FROM TS_PROJECTS p 
JOIN TS_PROJECTS gp ON gp.TS_ID = p.TS_PARENTID
JOIN TS_PROJECTS ggp ON ggp.TS_ID = gp.TS_PARENTID
JOIN [vw_TT_EntitlementsReport] er ON er.ITEMID = ggp.TS_PARENTID AND er.ITEMTYPE = 'Project'
UNION
-- project item entitlements inherited from great great grandparent item
SELECT --'5' AS 'UNION',
       er.ITEMTYPE
      ,p.TS_NAME AS ITEMNAME, p.TS_ID AS ITEMID
      ,er.USERNAME, er.USERID
      ,er.GROUPNAME, er.GROUPID
      ,er.ROLENAME, er.ROLEID
      ,er.ITEMNAME AS PERMISSIONEDITEMNAME
      ,er.ITEMID AS PERMISSIONEDITEMID
      ,er.PARENTITEMNAME, er.PARENTITEMID
      ,er.PERMISSIONNAME--, er.PERMISSIONID 
FROM TS_PROJECTS p 
JOIN TS_PROJECTS gp ON gp.TS_ID = p.TS_PARENTID
JOIN TS_PROJECTS ggp ON ggp.TS_ID = gp.TS_PARENTID
JOIN TS_PROJECTS gggp ON gggp.TS_ID = ggp.TS_PARENTID
JOIN [vw_TT_EntitlementsReport] er ON er.ITEMID = gggp.TS_PARENTID AND er.ITEMTYPE = 'Project'
UNION
-- folder item entitlements inherited from parent item
SELECT --'6' AS 'UNION',
       er.ITEMTYPE
      ,f.TS_NAME AS ITEMNAME, f.TS_ID AS ITEMID
      ,er.USERNAME, er.USERID
      ,er.GROUPNAME, er.GROUPID
      ,er.ROLENAME, er.ROLEID
      ,er.ITEMNAME AS PERMISSIONEDITEMNAME
      ,er.ITEMID AS PERMISSIONEDITEMID
      ,er.PARENTITEMNAME, er.PARENTITEMID
      ,er.PERMISSIONNAME--, er.PERMISSIONID 
FROM TS_FOLDERS f 
JOIN [vw_TT_EntitlementsReport] er ON er.ITEMID = f.TS_PARENTID AND er.ITEMTYPE = 'Folder' 
UNION
-- project item entitlements inherited from grandparent item
SELECT --'7' AS 'UNION',
       er.ITEMTYPE
      ,f.TS_NAME AS ITEMNAME, f.TS_ID AS ITEMID
      ,er.USERNAME, er.USERID
      ,er.GROUPNAME, er.GROUPID
      ,er.ROLENAME, er.ROLEID
      ,er.ITEMNAME AS PERMISSIONEDITEMNAME
      ,er.ITEMID AS PERMISSIONEDITEMID
      ,er.PARENTITEMNAME, er.PARENTITEMID
      ,er.PERMISSIONNAME--, er.PERMISSIONID 
FROM TS_FOLDERS f 
JOIN TS_FOLDERS gp ON gp.TS_ID = f.TS_PARENTID
JOIN [vw_TT_EntitlementsReport] er ON er.ITEMID = gp.TS_PARENTID AND er.ITEMTYPE = 'Folder'
UNION
-- folder item entitlements inherited from great grandparent item
SELECT --'8' AS 'UNION',
       er.ITEMTYPE
      ,f.TS_NAME AS ITEMNAME, f.TS_ID AS ITEMID
      ,er.USERNAME, er.USERID
      ,er.GROUPNAME, er.GROUPID
      ,er.ROLENAME, er.ROLEID
      ,er.ITEMNAME AS PERMISSIONEDITEMNAME
      ,er.ITEMID AS PERMISSIONEDITEMID
      ,er.PARENTITEMNAME, er.PARENTITEMID
      ,er.PERMISSIONNAME--, er.PERMISSIONID 
FROM TS_FOLDERS f 
JOIN TS_FOLDERS gp ON gp.TS_ID = f.TS_PARENTID
JOIN TS_FOLDERS ggp ON ggp.TS_ID = gp.TS_PARENTID
JOIN [vw_TT_EntitlementsReport] er ON er.ITEMID = ggp.TS_PARENTID AND er.ITEMTYPE = 'Folder'
UNION
-- project item entitlements inherited from great great grandparent item
SELECT --'9' AS 'UNION',
       er.ITEMTYPE
      ,f.TS_NAME AS ITEMNAME, f.TS_ID AS ITEMID
      ,er.USERNAME, er.USERID
      ,er.GROUPNAME, er.GROUPID
      ,er.ROLENAME, er.ROLEID
      ,er.ITEMNAME AS PERMISSIONEDITEMNAME
      ,er.ITEMID AS PERMISSIONEDITEMID
      ,er.PARENTITEMNAME, er.PARENTITEMID
      ,er.PERMISSIONNAME--, er.PERMISSIONID 
FROM TS_FOLDERS f 
JOIN TS_FOLDERS gp ON gp.TS_ID = f.TS_PARENTID
JOIN TS_FOLDERS ggp ON ggp.TS_ID = gp.TS_PARENTID
JOIN TS_FOLDERS gggp ON gggp.TS_ID = ggp.TS_PARENTID
JOIN [vw_TT_EntitlementsReport] er ON er.ITEMID = gggp.TS_PARENTID AND er.ITEMTYPE = 'Folder'

