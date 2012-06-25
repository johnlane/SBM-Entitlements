# SBM Entitlements Report

This is a T-SQL table and views that can be added to the SBM database to allow entitlements data to be extracted for use in reports.

SBM = Serena Business Manager, formerly TeamTrack (http://www.serena.com). 

## Usage

This code provides TT entitlements reports. To use, install one table and 
two views:

	TT_PRIVILEGE_BITMAPS
	vw_TT_EntitlementsReport
	vw_TT_EntitlementsReportInherited

## License

See LICENSE file. MIT License

## Examples

    SELECT * FROM [TeamTrack_Db].[dbo].[vw_TT_EntitlementsReport]
    WHERE [USERNAME] = 'Joe Bloggs'
    ORDER BY USERNAME, ITEMNAME, PERMISSIONNAME, GROUPNAME, ROLENAME

    SELECT * FROM [TeamTrack_Db].[dbo].[vw_TT_EntitlementsReportInherited]
    WHERE [USERNAME] = 'Joe Bloggs'
    ORDER BY USERNAME, ITEMNAME, PERMISSIONNAME, GROUPNAME, ROLENAME

[Discuss](http://gsfn.us/t/2iqbz)
[Download](https://github.com/johnlane/SBM-Entitlements)
