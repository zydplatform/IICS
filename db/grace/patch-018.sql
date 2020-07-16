
CREATE OR REPLACE VIEW patient.prescriptionissueview AS SELECT 
    pre.prescriptionid,
    pre.patientvisitid,
    pre.originunitid,
    pre.destinationunitid,
    pre.status,
    pi.prescriptionitemsid,
    pi.itemid,
    pi.isissued,
    iss.itempackageid,
    iss.dateissued,
    iss.stockid,
    iss.quantityissued,
    iss.prescriptionissueid
    FROM patient.prescription pre
    JOIN patient.prescriptionitems pi ON pi.prescriptionid = pre.prescriptionid
    JOIN store.prescriptionissue iss ON iss.prescriptionitemsid = pi.prescriptionitemsid;
