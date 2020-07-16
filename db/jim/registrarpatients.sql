-- View: patient.registrarpatients

-- DROP VIEW patient.registrarpatients;

CREATE OR REPLACE VIEW patient.registrarpatients AS
 SELECT pv.patientvisitid,
    pv.patientid,
    pv.addedby,
    pv.dateadded,
    pv.visitnumber,
    pv.visittype,
    pv.visitpriority,
    fu.facilityunitid,
    fu.facilityid
   FROM patient.patientvisit pv
     JOIN facilityunit fu ON pv.facilityunitid = fu.facilityunitid;

ALTER TABLE patient.registrarpatients
    OWNER TO postgres;
