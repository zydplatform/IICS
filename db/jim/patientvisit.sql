BEGIN;

DROP VIEW dashboard.facilitypatients;

DROP VIEW patient.patientstartisticsview;

ALTER TABLE patient.patientvisit
    ALTER COLUMN patientid SET NOT NULL;

ALTER TABLE patient.patientvisit
    ALTER COLUMN dateadded TYPE timestamp without time zone ;

CREATE OR REPLACE VIEW patient.patientstartisticsview AS
 SELECT pa.patientid,
    pa.personid,
    pa.patientno,
    pa.datecreated,
    pa.facilityid AS registrationfacilityid,
    per.dob,
    per.gender,
    vis.patientvisitid,
    vis.addedby,
    vis.dateadded,
    vis.visitpriority,
    vis.visittype,
    vis.visitnumber,
    vis.facilityunitid,
    fu.facilityid,
    concat(per.firstname, ' ', per.lastname, ' ', per.othernames) AS fullname,
    date_part('DAY'::text, now() - per.dob::timestamp with time zone)::integer AS age,
    l.villagename,
    l.parishname
   FROM patient.patient pa
     JOIN person per ON pa.personid = per.personid
     JOIN patient.patientvisit vis ON vis.patientid = pa.patientid
     JOIN facilityunit fu ON vis.facilityunitid = fu.facilityunitid
     JOIN locations l ON per.currentaddress = l.villageid;

ALTER TABLE patient.patientstartisticsview
    OWNER TO postgres;

CREATE OR REPLACE VIEW dashboard.facilitypatients AS
 SELECT ps.facilityid,
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
    ps.villagename AS village,
    ps.parishname AS parish
   FROM searchfacility sf
     JOIN patient.patientstartisticsview ps ON sf.facilityid = ps.facilityid;

ALTER TABLE dashboard.facilitypatients
    OWNER TO postgres;

COMMIT;