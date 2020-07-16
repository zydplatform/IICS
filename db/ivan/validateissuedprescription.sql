-- View: patient.issuedprescriptionitemsview

-- DROP VIEW patient.issuedprescriptionitemsview;

CREATE OR REPLACE VIEW patient.issuedprescriptionitemsview AS
 SELECT pv.patientvisitid,
    pv.patientid,
    pv.visitnumber,
    pv.facilityunitid AS visitedunit,
    p.prescriptionid,
    p.dateprescribed,
    p.referencenumber,
    pi.newprescriptionitemsid,
    pi.dosage,
    pi.dose,
    pi.days,
    pi.daysname,
    pi.itemname,
    pi.isissued,
    pi.ismodified,
    pis.issuedby,
    pis.dateissued,
    pis.itempackageid,
    d.quantitydispensed
   FROM patient.patientvisit pv
     JOIN patient.prescription p ON pv.patientvisitid = p.patientvisitid
     JOIN patient.newprescriptionitems pi ON p.prescriptionid = pi.prescriptionid
     JOIN store.prescriptionissue pis ON pi.newprescriptionitemsid = pis.newprescriptionitemsid
     JOIN store.dispenseditems d ON pis.prescriptionissueid = d.prescriptionissueid;

ALTER TABLE patient.issuedprescriptionitemsview
    OWNER TO postgres;

