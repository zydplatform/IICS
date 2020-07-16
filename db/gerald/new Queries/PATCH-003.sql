/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jul 20, 2018
 */

ALTER TABLE controlpanel.accessrightsgroup ADD COLUMN accessrightgroupname VARCHAR;
ALTER TABLE controlpanel.accessrightsgroup ADD COLUMN facilityid integer;
DROP view controlpanel.staffassignedrights;

CREATE OR REPLACE VIEW controlpanel.staffassignedrights AS
SELECT sfurp.stafffacilityunitaccessrightprivilegeid,
    sfurp.active AS stafffacilityunitaccessrightprivstatus,
    sfurp.stafffacilityunitid,
    argp.accessrightgroupprivilegeid,
    argp.active AS accessrightgroupprivilegestatus,
    argp.privilegeid,
    arg.accessrightsgroupid,
    arg.accessrightgroupname,
    arg.facilityid,
    arg.active AS accessrightgroupstatus,
	sffu.staffid,
	sffu.facilityunitid,
	sffu.active AS stafffacilityunitstatus
   FROM controlpanel.stafffacilityunitaccessrightprivilege sfurp
     JOIN controlpanel.accessrightgroupprivilege argp ON sfurp.accessrightgroupprivilegeid = argp.accessrightgroupprivilegeid
     JOIN controlpanel.accessrightsgroup arg ON arg.accessrightsgroupid = argp.accessrightsgroupid
     JOIN controlpanel.stafffacilityunit sffu ON sfurp.stafffacilityunitid=sffu.stafffacilityunitid;
     
     
ALTER TABLE controlpanel.accessrightsgroup DROP COLUMN designationcategoryid;

DROP VIEW public.searchstaff;
CREATE OR REPLACE VIEW public.searchstaff AS
 SELECT s.staffid,
    s.personid,
    s.designationid,
    s.staffno,
    s.computerno,
    s.currentfacility,
    s.isexternal,
    p.firstname,
    p.othernames,
    p.lastname,
    p.dob,
    p.gender,
    p.facilityid,
    d.designationname,
    lower(concat(p.firstname, p.lastname, p.othernames)) AS permutation1,
    lower(concat(p.lastname, p.othernames, p.firstname)) AS permutation2,
    lower(concat(p.lastname, p.firstname)) AS permutation3
   FROM staff s
    JOIN person p ON s.personid = p.personid
    JOIN designation d ON d.designationid = s.designationid;

CREATE OR REPLACE VIEW controlpanel.staffunits AS
SELECT ssv.staffid,
		sfu.stafffacilityunitid,
		sfu.active,
		sfu.facilityunitid,
		fu.facilityunitname
	FROM public.searchstaff ssv
	JOIN controlpanel.stafffacilityunit sfu ON ssv.staffid=sfu.staffid
	JOIN public.facilityunit fu ON sfu.facilityunitid=fu.facilityunitid;

