BEGIN;

	DROP VIEW patient.prescriptionitemsview;

	DROP VIEW patient.servicedprescriptionstats;
	
	DROP VIEW store.bookedprescriptionitemsview;
	
	DROP VIEW patient.unservicedprescriptionsview;


	ALTER TABLE patient.prescription
		ALTER COLUMN dateprescribed TYPE timestamp without time zone;

	ALTER TABLE patient.servicedprescriptions
		ALTER COLUMN dateadded TYPE timestamp without time zone;	

	CREATE OR REPLACE VIEW patient.prescriptionitemsview AS
	 SELECT p.prescriptionid,
		p.patientvisitid,
		p.dateprescribed,
		p.status,
		p.addedby,
		p.lastupdated,
		p.lastupdatedby,
		p.dispensingunit,
		p.destinationunitid,
		p.originunitid,
		p.approvedby,
		p.dateapproved,
		p.dateissued,
		npi.newprescriptionitemsid,
		npi.dosage,
		npi.dose,
		npi.notes,
		npi.days,
		npi.daysname,
		npi.isapproved,
		npi.isissued,
		npi.itemname,
		npi.approvable
	   FROM patient.prescription p
		 JOIN patient.newprescriptionitems npi ON p.prescriptionid = npi.prescriptionid;

	ALTER TABLE patient.prescriptionitemsview
		OWNER TO postgres;

	CREATE OR REPLACE VIEW patient.servicedprescriptionstats AS
	 SELECT p.prescriptionid,
		p.patientvisitid,
		p.dateprescribed,
		p.destinationunitid,
		sp.servicedprescriptionid,
		sp.issueditems,
		sp.notissueditems,
		sp.addedby,
		sp.dateadded
	   FROM patient.prescription p
		 JOIN patient.servicedprescriptions sp ON p.prescriptionid = sp.prescriptionid;

	ALTER TABLE patient.servicedprescriptionstats
		OWNER TO postgres;
		
	CREATE OR REPLACE VIEW store.bookedprescriptionitemsview AS
	 SELECT pres.prescriptionid,
		pres.destinationunitid,
		p.newprescriptionitemsid,
		pi.itempackageid AS itemid,
		p.days,
		p.isapproved,
		COALESCE(pi.quantityapproved, 0) AS quantityapproved,
		COALESCE(ip.itemstrength, ''::text) AS itemstrength
	   FROM patient.prescription pres
		 JOIN patient.newprescriptionitems p ON pres.prescriptionid = p.prescriptionid
		 JOIN store.prescriptionissue pi ON p.newprescriptionitemsid = pi.newprescriptionitemsid
		 JOIN store.itempackage ip ON pi.itempackageid = ip.itempackageid
	  WHERE p.isapproved = true AND (p.isissued IS NULL OR p.isissued = false) AND pi.dateissued IS NULL AND pi.issuedby IS NULL AND pres.dateprescribed = now()::date AND p.isserviced = false;

	ALTER TABLE store.bookedprescriptionitemsview
		OWNER TO postgres;
		
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
     JOIN patient.unservicedprescriptionitemsreasons upir ON p.prescriptionid = upir.prescriptionid
     JOIN patient.servicequeue s ON p.patientvisitid = s.patientvisitid AND fus.facilityunitserviceid::numeric = s.unitserviceid
  WHERE s.canceled = false AND s.serviced = false
  ORDER BY p.prescriptionid DESC;

ALTER TABLE patient.unservicedprescriptionsview
    OWNER TO postgres;



COMMIT;