/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: May 31, 2018
 */
CREATE OR REPLACE VIEW controlpanel.staffassignedrights AS
SELECT sfurp.stafffacilityunitaccessrightprivilegeid,
	   sfurp.active AS stafffacilityunitaccessrightprivstatus,
	   sfurp.stafffacilityunitid,
       argp.accessrightgroupprivilegeid,
       argp.active AS accessrightgroupprivilegestatus,
       argp.privilegeid,
       arg.designationcategoryid,
       arg.accessrightsgroupid,
       arg.active AS accessrightgroupstatus,
       dc.categoryname
   FROM controlpanel.stafffacilityunitaccessrightprivilege sfurp
   JOIN controlpanel.accessrightgroupprivilege argp ON (sfurp.accessrightgroupprivilegeid=argp.accessrightgroupprivilegeid)
   JOIN controlpanel.accessrightsgroup arg ON(arg.accessrightsgroupid=argp.accessrightsgroupid)
   JOIN public.designationcategory dc ON(arg.designationcategoryid=dc.designationcategoryid)
