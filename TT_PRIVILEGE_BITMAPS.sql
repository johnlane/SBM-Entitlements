/*

 TeamTrack Privilege Bitmap Masks for the Entitlements Reports

 This table is used by views vw_TT_EntitlementsReport and vw_TT_EntitlementsReportInherited

 The meaning of the bits in the privilege bitmap fields is stored in the table
 TT_PRIVILEGE_BITMAPS which is a mapping from bit value to privilege name. This table is not part of the standard TeamTrack database. 

 Copyright (c) 2012 John Lane

 License: MIT. See LICENSE file. 

*/


use TeamTrack_Db

/* Table of privileges */
DROP TABLE TT_PRIVILEGE_BITMAPS
CREATE TABLE TT_PRIVILEGE_BITMAPS (
     PRIVILEGE_TYPE  VARCHAR(8)  -- privilege type USERSYS|USERPRJ|USERWKF|USERFLD|USERTBL defined in TSDef.h
    ,BITMAP_ID       INT         -- the bitmap id (1..5) for fields TS_MASKn in TS_PRIVILEGES table
    ,BIT_POSITION    INT         -- the bit position number number (least significant bit is 0)
    ,BIT_VALUE       INT         -- the bit value ( 1 << bitNumber)
    ,PRIVILEGE_ENUM  VARCHAR(40) -- the enum of the privilege as enumerated in privId_e in TSDef.h
    ,PRIVILEGE_NAME VARCHAR(40)  -- the name of the privilege as displayed in Serena Administrator
CONSTRAINT cTT_PRIVILEGE_BITMAPS UNIQUE (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION));

/* Mask 1 privileges */
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1, 0, 0x1, 'TS_USRTBLPRIV_SUBMIT', 'Submit')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1, 1, 0x2, 'TS_USRTBLPRIV_UPDATE', 'Update')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1, 2, 0x4, 'TS_USRTBLPRIV_DELETE', 'Delete')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1, 3, 0x8, 'TS_USRTBLPRIV_VIEW',   'View')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1, 4,0x10, 'TS_USRTBLPRIV_VIEWALLATTACHMENTS',   'View Attachments on Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1, 5,0x20, 'TS_USRTBLPRIV_VIEWATTACHIFAUTHOR',   'View Attachments You Authored')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1, 6,0x40, 'TS_USRTBLPRIV_VIEWALLNOTES',   'View Notes on Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1, 7,0x80, 'TS_USRTBLPRIV_VIEWNOTEIFAUTHOR',   'View Notes You Authored')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1, 8,0x100, 'TS_USRTBLPRIV_DONTKNOW',   'Set Unrestricted Status of Notes/Email')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1, 9,0x200, 'TS_USRTBLPRIV_DONTKNOW',   'Set Unrestricted Status of Attachments')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1,10,0x400, 'TS_USRTBLPRIV_VIEWCHANGEHISTORY',   'View Change History')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1,11,0x800, 'TS_USRTBLPRIV_MASSTRANS',   'Mass Update Items')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1,12,0x1000, 'TS_USRTBLPRIV_ADDATTACHANY',   'Add Attachments to Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1,13,0x2000, 'TS_USRTBLPRIV_EDITATTACHANY',   'Edit Attachments to Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1,14,0x4000, 'TS_USRTBLPRIV_EDITATTACHIFAUTHOR',   'Edit Attachments You Authored')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1,15,0x8000, 'TS_USRTBLPRIV_DELATTACHANY',   'Delete Attachments on Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1,16,0x10000, 'TS_USRTBLPRIV_DELATTACHIFAUTHOR',   'Delete Attachments You Authored')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1,17,0x20000, 'TS_USRTBLPRIV_ADDNOTEANY',   'Add Notes to Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1,18,0x40000, 'TS_USRTBLPRIV_EDITNOTEANY',   'Edit Notes to Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1,19,0x80000, 'TS_USRTBLPRIV_EDITNOTEIFAUTHOR',   'Edit Notes You Authored')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1,20,0x100000, 'TS_USRTBLPRIV_DELNOTEANY',   'Delete Notes On Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 1,21,0x200000, 'TS_USRTBLPRIV_DELNOTEIFAUTHOR',   'Delete Notes You Authored')

INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 1, 1,02, 'TS_USRSYSPRIV_VIEWFOLDERS',   'View Folders')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 1,15,0x8000, 'TS_USRSYSPRIV_EDITPROFILE',   'Modify User Profile Settings')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 1,26,0x4000000, 'TS_USRSYSPRIV_LOGONASUSER',   'Log on as another user')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 1,27,0x8000000, 'TS_USRSYSPRIV_REMOTEADMIN',   'Remote Administration')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 1,28,0x10000000, 'TS_USRSYSPRIV_SOURCEBRIDGE',   'Logon From SourceBridge')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 1,29,0x20000000, 'TS_USRSYSPRIV_CALENDAR',   'Select Calendar For Hours Of Operation')

INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1, 0, 0x1, 'TS_USRPRJPRIV_SUBMITITEMS', 'Submit New Items')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1, 2, 0x4, 'TS_USRPRJPRIV_VIEWUSER', 'View User Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1, 3, 0x8, 'TS_USRPRJPRIV_VIEWADVANCED', 'View Advanced Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1, 4,0x10, 'TS_USRPRJPRIV_VIEWMANAGER', 'View Manager Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1, 5, 0x20, 'TS_USRPRJPRIV_ALLTRANS', 'Transition All Items')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1, 6, 0x40, 'TS_USRPRJPRIV_VIEWSYSTEM', 'View System Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1, 7, 0x80, 'TS_USRPRJPRIV_EDITUSER', 'Update User Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1, 8, 0x100, 'TS_USRPRJPRIV_EDITADVANCED', 'Update Advanced Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1, 9, 0x200, 'TS_USRPRJPRIV_EDITMANAGER', 'Update Manager Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,10, 0x400, 'TS_USRPRJPRIV_EDITSYSTEM', 'Update System Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,12, 0x1000, 'TS_USRPRJPRIV_VIEWALLARCHIVED', 'View All Archived Items')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,13, 0x2000, 'TS_USRPRJPRIV_RESTOREFROMARCHIVE', 'Restore Item From Archive')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,14, 0x4000, 'TS_USRPRJPRIV_MASSTRANS', 'Mass Update Items')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,16, 0x10000, 'TS_USRPRJPRIV_VIEWALLITEMS', 'View All Items')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,17, 0x20000, 'TS_USRPRJPRIV_UPDATEALL', 'Update All Items')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,18, 0x40000, 'TS_USRPRJPRIV_UPDATEIFOWNER', 'Update Item If Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,19, 0x80000, 'TS_USRPRJPRIV_UPDATEIFSUBMITTER', 'Update Item If Submitter')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,20, 0x100000, 'TS_USRPRJPRIV_VIEWIFOWNER', 'Update Item If Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,21, 0x200000, 'TS_USRPRJPRIV_VIEWIFSUBMITTER', 'View Item If Submitter')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,22, 0x400000, 'TS_USRPRJPRIV_TRANSIFOWNER', 'Transition Item If Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,23, 0x800000, 'TS_USRPRJPRIV_TRANSIFSUBMITTER', 'Transition Item If Submitter')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,24, 0x1000000, 'TS_USRPRJPRIV_OWN', 'Own Items')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,25, 0x02000000, 'TS_USRPRJPRIV_DELETE', 'Delete Items')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 1,30, 0x40000000, 'TS_USRPRJPRIV_OWNIFSUBMITTER', 'Own Items If Submitter')

INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERFLD', 1, 0, 0x1, 'TS_USRFLDPRIV_VIEWFOLDERITEMS', 'View Items In Folder')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERFLD', 1, 1, 0x2, 'TS_USRFLDPRIV_ADDTOFOLDER', 'Add Items To Folder')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERFLD', 1, 2, 0x4, 'TS_USRFLDPRIV_REMOVEFROMFOLDER', 'Remove Items From Folder')



/* Mask 2 privileges */
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2, 0, 0x1, 'TS_USRTBLPRIV_DONTKNOW',   'Manage Private Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2, 1, 0x2, 'TS_USRTBLPRIV_DONTKNOW',   'Create Guest-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2, 2, 0x4, 'TS_USRTBLPRIV_DONTKNOW',   'Create User-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2, 3, 0x8, 'TS_USRTBLPRIV_DONTKNOW',   'Create Manager-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2, 4, 0x10, 'TS_USRTBLPRIV_DONTKNOW',   'Modify Guest-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2, 5, 0x20, 'TS_USRTBLPRIV_DONTKNOW',   'Modify User-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2, 6, 0x40, 'TS_USRTBLPRIV_DONTKNOW',   'Modify Manager-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2, 7, 0x80, 'TS_USRTBLPRIV_DONTKNOW',   'Run Guest-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2, 8, 0x100, 'TS_USRTBLPRIV_DONTKNOW',   'Run User-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2, 9, 0x200, 'TS_USRTBLPRIV_DONTKNOW',   'Run Manager-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2,10, 0x400, 'TS_USRTBLPRIV_DONTKNOW',   'Delete Guest-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2,11, 0x800, 'TS_USRTBLPRIV_DONTKNOW',   'Delete User-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2,12, 0x1000, 'TS_USRTBLPRIV_DONTKNOW',   'Delete Manager-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2,14, 0x4000, 'TS_USRTBLPRIV_DONTKNOW',   'Access Public Reports You Authored')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 2,15, 0x8000, 'TS_USRTBLPRIV_DONTKNOW',   'Create/Modify Advanced SQL Queries')

INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 2,13, 0x2000, 'TS_USRTBLPRIV_EXECSYSTEM',   'Run System Scripts')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 2,15, 0x8000, 'TS_USRSYSPRIV_ATADVANCEDSQL',   'Create/Modify Pass-Through SQL Queries')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 2,16, 0x10000, 'TS_USRSYSPRIV_CREATEMULTITABLERPTS',   'Create/Edit/Delete Multi-Table Reports')

INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2, 0, 0x1, 'TS_USRPRJPRIV_DONTKNOW',   'Manage Private Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2, 1, 0x2, 'TS_USRPRJPRIV_DONTKNOW',   'Create Guest-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2, 2, 0x4, 'TS_USRPRJPRIV_DONTKNOW',   'Create User-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2, 3, 0x8, 'TS_USRPRJPRIV_DONTKNOW',   'Create Manager-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2, 4, 0x10, 'TS_USRPRJPRIV_DONTKNOW',   'Modify Guest-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2, 5, 0x20, 'TS_USRPRJPRIV_DONTKNOW',   'Modify User-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2, 6, 0x40, 'TS_USRPRJPRIV_DONTKNOW',   'Modify Manager-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2, 7, 0x80, 'TS_USRPRJPRIV_DONTKNOW',   'Run Guest-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2, 8, 0x100, 'TS_USRPRJPRIV_DONTKNOW',   'Run User-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2, 9, 0x200, 'TS_USRPRJPRIV_DONTKNOW',   'Run Manager-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2,10, 0x400, 'TS_USRPRJPRIV_DONTKNOW',   'Delete Guest-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2,11, 0x800, 'TS_USRPRJPRIV_DONTKNOW',   'Delete User-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2,12, 0x1000, 'TS_USRPRJPRIV_DONTKNOW',   'Delete Manager-Level Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2,14, 0x4000, 'TS_USRPRJPRIV_DONTKNOW',   'Manage Public Reports You Authored')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 2,15, 0x8000, 'TS_USRPRJPRIV_DONTKNOW',   'Create/Modify Advanced SQL Queries')

/* Mask 3 privileges */
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 3, 2, 0x4, 'TS_USRTBLPRIV_VIEWUSER',   'View User Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 3, 3, 0x8, 'TS_USRTBLPRIV_VIEWADVANCED',   'View Advanced Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 3, 4, 0x10, 'TS_USRTBLPRIV_VIEWMANAGER',   'View Manager Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 3, 6, 0x40, 'TS_USRTBLPRIV_VIEWSYSTEM',   'View System Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 3, 7, 0x80, 'TS_USRTBLPRIV_EDITUSER',   'Update User Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 3, 8, 0x100, 'TS_USRTBLPRIV_EDITADVANCED',   'Update Advanced Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 3, 9, 0x200, 'TS_USRTBLPRIV_EDITMANAGER',   'Update Manager Fields')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 3,10, 0x400, 'TS_USRTBLPRIV_EDITSYSTEM',   'Update System Fields')

INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3, 0, 0x1, 'TS_USRTBLPRIV_ADDATTACHANY', 'Add Attachments To Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3, 1, 0x2, 'TS_USRPRJPRIV_ADDATTACHIFOWNER', 'Add Attachments If Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3, 2, 0x4, 'TS_USRPRJPRIV_ADDATTACHIFSUBMITTER', 'Add Attachments If Submitter')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3, 3, 0x8, 'TS_USRTBLPRIV_DELATTACHANY', 'Delete Attachments On Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3, 4, 0x10, 'TS_USRTBLPRIV_DELATTACHIFOWNER', 'Delete Attachments If Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3, 5, 0x20, 'TS_USRPRJPRIV_DELATTACHIFSUBMITTER', 'Delete Attachments If Submitter')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3, 6, 0x40, 'TS_USRPRJPRIV_DELATTACHIFAUTHOR', 'Delete Attachments You Authored')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3, 7, 0x80, 'TS_USRTBLPRIV_ADDNOTEANY', 'Add Notes To Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3, 8, 0x100, 'TS_USRTBLPRIV_ADDNOTEIFOWNER', 'Add Note If Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3, 9, 0x200, 'TS_USRTBLPRIV_ADDNOTEIFSUBMITTER', 'Add Note If Submitter')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,10, 0x400, 'TS_USRTBLPRIV_EDITNOTEANY', 'Edit Notes On Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,11, 0x800, 'TS_USRTBLPRIV_EDITNOTEIFOWNER', 'Edit Note If Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,12, 0x1000, 'TS_USRTBLPRIV_EDITNOTEIFSUBMITTER', 'Edit Note If Submitter')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,13, 0x2000, 'TS_USRTBLPRIV_EDITNOTEIFAUTHOR', 'Edit Note You Authored')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,14, 0x4000, 'TS_USRTBLPRIV_DELNOTEANY', 'Delete Notes On Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,15, 0x8000, 'TS_USRTBLPRIV_DELNOTEIFOWNER', 'Delete Notes If Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,16, 0x10000, 'TS_USRTBLPRIV_DELNOTEIFOWNER', 'Delete Notes If Submitter')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,17, 0x20000, 'TS_USRTBLPRIV_DELNOTEIFAUTHOR', 'Delete Notes You Authored')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,18, 0x40000, 'TS_USRPRJPRIV_EDITATTACHANY', 'Edit Attachments On Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,19, 0x80000, 'TS_USRPRJPRIV_EDITATTACHIFOWNER', 'Edit Attachments If Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,20, 0x100000, 'TS_USRPRJPRIV_EDITATTACHIFSUBMITTER', 'Edit Attachments If Submitter')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,21, 0x200000, 'TS_USRPRJPRIV_EDITATTACHIFAUTHOR', 'Edit Attachments You Authored')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,22, 0x400000, 'TS_USRPRJPRIV_ADDATTACHIFCONTACT', 'Add Attachments To Item If Contact')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,23, 0x800000, 'TS_USRPRJPRIV_ADDNOTEIFCONTACT', 'Add Notes To Item If Contact')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,24, 0x1000000, 'TS_USRTBLPRIV_VIEWATTACHIFOWNER', 'View Attachments If Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,25, 0x2000000, 'TS_USRTBLPRIV_VIEWATTACHIFAUTHOR', 'View Attachments If Author')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,26, 0x4000000, 'TS_USRTBLPRIV_VIEWALLATTACHMENTS', 'View Attachments on Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,27, 0x8000000, 'TS_USRPRJPRIV_VIEWATTACHIFSUBMITTER', 'View Attachments If Submitter')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,28, 0x10000000, 'TS_USRPRJPRIV_UNKNOWN', 'Set Unrestricted Status Of Notes/Email')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 3,29, 0x20000000, 'TS_USRPRJPRIV_UNKNOWN', 'Set Unrestricted Status Of Attachments')


/* Mask 4 privileges */
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 4, 1, 0x1, 'TS_USRTBLPRIV_ADDATTACHANY',   'View User Fields On Submit')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 4, 2, 0x2, 'TS_USRTBLPRIV_VIEWADVANCEDONSUBMIT',   'View Advanced Fields On Submit')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 4, 3, 0x4, 'TS_USRTBLPRIV_VIEWMANAGERONSUBMIT',   'View Manager Fields On Submit')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 4, 4, 0x8, 'TS_USRTBLPRIV_VIEWSYSTEMONSUBMIT',   'View System Fields On Submit')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 4, 8, 0x100, 'TS_USRTBLPRIV_VIEWUSERONUPDATE',   'View User Fields On Update')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 4, 9, 0x200, 'TS_USRTBLPRIV_VIEWADVANCEDONUPDATE',   'View Advanced Fields On Update')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 4,10, 0x400, 'TS_USRTBLPRIV_VIEWMANAGERONUPDATE',   'View Manager Fields On Update')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 4,11, 0x800, 'TS_USRTBLPRIV_VIEWSYSTEMONUPDATE',   'View System Fields On Update')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERTBL', 4,12, 0x1000, 'TS_USRTBLPRIV_VIEWHIDDEN',   'View Hidden Fields in Detail Reports')

INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 4,9, 0x2000, 'TS_USRSYSPRIV_APIACCESS',   'Connect Using The API')

INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4, 0, 0x1, 'TS_USRPRJPRIV_VIEWUSERONSUBMIT', 'View User Fields On Submit')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4, 1, 0x2, 'TS_USRPRJPRIV_VIEWADVANCEDONSUBMIT', 'View Advanced Fields On Submit')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4, 2, 0x4, 'TS_USRPRJPRIV_VIEWMANAGERONSUBMIT', 'View Manager Fields On Submit')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4, 3, 0x8, 'TS_USRPRJPRIV_VIEWSYSTEMONSUBMIT', 'View System Fields On Submit')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4, 4, 0x10, 'TS_USRPRJPRIV_VIEWUSERONTRANSITION', 'View User Fields On Transition')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4, 5, 0x20, 'TS_USRPRJPRIV_VIEWADVANCEDONTRANSITIION', 'View Advanced Fields On Transition')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4, 6, 0x40, 'TS_USRPRJPRIV_VIEWMANAGERONTRANSITIION', 'View Manager Fields On Transition')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4, 7, 0x80, 'TS_USRPRJPRIV_VIEWSYSTEMONTRANSITIION', 'View System Fields On Transition')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4, 8, 0x100, 'TS_USRPRJPRIV_VIEWUSERONUPDATE', 'View User Fields On Update')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4, 9, 0x200, 'TS_USRPRJPRIV_VIEWADVANCEDONUPDATE', 'View Advanced Fields On Update')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,10, 0x400, 'TS_USRPRJPRIV_VIEWMANAGERONUPDATE', 'View Manager Fields On Update')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,11, 0x800, 'TS_USRPRJPRIV_VIEWSYSTEMONUPDATE', 'View System Fields On Update')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,12, 0x1000, 'TS_USRPRJPRIV_VIEWHIDDEN', 'View Hidden Fields In Detail Reports')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,14, 0x4000, 'TS_USRPRJPRIV_VIEWIFCONTACT', 'View Item If Contact')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,16, 0x10000, 'TS_USRPRJPRIV_VIEWIFCONTACTCOMPANY', 'View Item If Contact''s Company')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,17, 0x20000, 'TS_USRPRJPRIV_VIEWWORKFLOWS', 'View Workflow Graphically')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,18, 0x40000, 'TS_USRPRJPRIV_VIEWNOTEIFOWNER', 'View Notes If Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,19, 0x80000, 'TS_USRPRJPRIV_VIEWNOTEIFAUTHOR', 'View Notes You Authored')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,20, 0x100000, 'TS_USRPRJPRIV_VIEWNOTEIFSUBMITTER', 'View Notes If Submitter')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,21, 0x200000, 'TS_USRPRJPRIV_VIEWALLNOTES', 'View Notes On Any Item')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,22, 0x400000, 'TS_USRPRJPRIV_VIEWSUBTASKS', 'View Principals and Subtasks')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,23, 0x800000, 'TS_USRPRJPRIV_VIEWSTATECHANGE', 'View State Change History')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,24, 0x1000000, 'TS_USRPRJPRIV_VIEWCHANGEHISTORY', 'View Change History')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,25, 0x2000000, 'TS_USRPRJPRIV_LINKSUBTASKS', 'Link Subtasks')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,26, 0x4000000, 'TS_USRPRJPRIV_LINKPRINCIPAL', 'Link/Unlink Principal')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 4,27, 0x08000000, 'TS_PERMOBJECT_VERSIONCONTROLHISTORY', 'Manage Version Control History')

/* Mask 5 privileges */
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 5, 0, 0x1, 'TS_USRSYSPRIV_EDITYOURCONTACTINFO',   'Edit Your Contact Information')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 5,28, 0x10000000, 'TS_USRSYSPRIV_ASSIGNCONTACTLICENSE',   'Assign Contact External User Access')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 5,29, 0x20000000, 'TS_USRSYSPRIV_VIEWCONTACTIFYOU',   'View Your Contact Information')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERSYS', 5,30, 0x40000000, 'TS_USRSYSPRIV_VIEWPUBLICPROBLEMS',   'View Public Problems And Resolutions')

INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 5, 1, 0x2, 'TS_USRPRJPRIV_VIEWIFSECONDARYOWNER', 'View Item If Secondary Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 5, 2, 0x4, 'TS_USRPRJPRIV_UPDATEIFSECONDARYOWNER', 'Update Item If Secondary Owner')
INSERT INTO TT_PRIVILEGE_BITMAPS (PRIVILEGE_TYPE, BITMAP_ID, BIT_POSITION, BIT_VALUE, PRIVILEGE_ENUM, PRIVILEGE_NAME) 
     VALUES('USERPRJ', 5, 3, 0x8, 'TS_USRPRJPRIV_TRANSIFSECONDARYOWNER', 'Transition Item If Secondary Owner')

