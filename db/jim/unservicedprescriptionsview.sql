-- View: patient.unservicedprescriptionsview

-- DROP VIEW patient.unservicedprescriptionsview;

CREATE OR REPLACE VIEW patient.unservicedprescriptionsview AS
 SELECT p.prescriptionid,
    p.patientvisitid,
    p.dateprescribed,
    p.status,
    p.addedby,
    p.destinationunitid,
    p.originunitid,
    p.referencenumber,
    s.servicequeueid,
    s.serviced,
    s.servicedby,
    s.timein,
    s.timeout,
    s.unitserviceid,
    s.canceled,
    s.canceledby,
    s.timecanceled,
    s.ispopped
   FROM patient.prescription p
     JOIN facilityunitservice fus ON p.originunitid = fus.facilityunitid
     JOIN patient.servicequeue s ON p.patientvisitid = s.patientvisitid AND fus.facilityunitserviceid::numeric = s.unitserviceid
  WHERE s.canceled = false AND s.serviced = false AND s.ispopped = false
  ORDER BY p.prescriptionid DESC;

ALTER TABLE patient.unservicedprescriptionsview
    OWNER TO postgres;

