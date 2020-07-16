/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  HP
 * Created: Sep 28, 2018
 */

ALTER TABLE public.facility ADD COLUMN faciltytype varchar(255) DEFAULT 'HU';
UPDATE  public.facility SET faciltytype = 'TU' WHERE facilityid = 1;

DROP VIEW searchfacility;

CREATE VIEW searchfacility AS SELECT f.facilityid,
    f.facilityname,
    f.facilitycode,
    f.shortname,
    f.emailaddress,
    f.phonecontact,
    f.website,
    f.postaddress,
    f.phonecontact2,
    l.villagename,
    l.parishname,
    l.subcountyname,
    l.countyname,
    l.districtname,
    l.regionname,
    fl.shortname AS levelcode,
    fl.facilitylevelname,
    l.villageid,
    l.parishid,
    l.subcountyid,
    l.countyid,
    l.districtid,
    l.regionid,
    f.faciltytype
    FROM public.facility f 
    JOIN public.locations l ON(f.villageid=l.villageid)
    JOIN public.facilitylevel fl ON(f.facilitylevelid=fl.facilitylevelid);

CREATE SEQUENCE store.financialyear_financialyearid_seq;
CREATE TABLE store.financialyear(
    financialyearid bigint PRIMARY KEY DEFAULT nextval('store.financialyear_financialyearid_seq'),
    financialyearname varchar(255),
    startdate date,
    enddate date,
    dateadded date,
    addedby BIGINT REFERENCES public.staff(staffid)
);
ALTER TABLE store.facilityfinancialyear add column financialyearid bigint references store.financialyear(financialyearid);
ALTER TABLE store.facilityfinancialyear add column procuringstatus varchar(255);
ALTER TABLE store.facilityfinancialyear add column datesubmitted date;


CREATE SCHEMA dashboard;
CREATE OR REPLACE VIEW dashboard.facilitypatients AS SELECT ps.facilityid,
    sf.facilityname,
    sf.facilitycode,
    sf.shortname,
    sf.emailaddress,
    sf.phonecontact,
    sf.villageid,
    sf.villagename,
    sf.parishid,
    sf.parishname,
    sf.subcountyid,
    sf.subcountyname,
    sf.countyid,
    sf.countyname,
    sf.districtid,
    sf.districtname,
    sf.regionid,
    sf.regionname,
    sf.levelcode,
    sf.facilitylevelname,
    sf.faciltytype,
    ps.patientid,
    ps.personid,
    ps.patientno,
    ps.datecreated,
    ps.dob,
    ps.gender,
    ps.patientvisitid,
    ps.dateadded,
    ps.visitpriority,
    ps.visittype,
    ps.visitnumber,
    ps.facilityunitid,
    ps.fullname,
    ps.age,
    ps.villagename as village,
    ps.parishname as parish
    FROM public.searchfacility sf
    JOIN patient.patientstartisticsview ps ON(sf.facilityid = ps.facilityid);