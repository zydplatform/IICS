/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  HP
 * Created: Aug 31, 2018
 */

ALTER TABLE patient.labtestclassification ADD COLUMN parentid BIGINT;
ALTER TABLE store.facilityorder ADD COLUMN dateapproved date;


CREATE TABLE patient.testmethod
(
    testmethodid bigint NOT NULL,
    testmethodname character varying(255) COLLATE pg_catalog."default",
    isactive boolean,
    CONSTRAINT testmethod_pkey PRIMARY KEY (testmethodid)
);

ALTER TABLE patient.laboratorytest ADD COLUMN testmethodid BIGINT;
ALTER TABLE patient.laboratorytest ADD CONSTRAINT fk_testmethodid FOREIGN KEY(testmethodid) REFERENCES patient.testmethod(testmethodid);



DROP VIEW controlpanel.staffassignedrights;

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
    sffu.active AS stafffacilityunitstatus,
    priv.privilegekey,
    priv.active AS isactive
   FROM controlpanel.stafffacilityunitaccessrightprivilege sfurp
     JOIN controlpanel.accessrightgroupprivilege argp ON sfurp.accessrightgroupprivilegeid = argp.accessrightgroupprivilegeid
     JOIN controlpanel.accessrightsgroup arg ON arg.accessrightsgroupid = argp.accessrightsgroupid
     JOIN controlpanel.stafffacilityunit sffu ON sfurp.stafffacilityunitid = sffu.stafffacilityunitid
     JOIN controlpanel.privilege priv ON argp.privilegeid=priv.privilegeid;


-- ruuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu

ALTER TABLE patient.prescription ADD COLUMN dispensingunit BIGINT;
ALTER TABLE patient.prescription ADD CONSTRAINT fk_dispensingunit FOREIGN KEY(dispensingunit) REFERENCES facilityunit(facilityunitid);

ALTER TABLE patient.prescription DROP CONSTRAINT fk_itemid;
ALTER TABLE patient.prescription ADD CONSTRAINT fk_itemid FOREIGN KEY(itemid) REFERENCES store.medicalitem(medicalitemid);

ALTER TABLE patient.prescription DROP COLUMN itemid;
ALTER TABLE patient.prescription DROP COLUMN weight;
ALTER TABLE patient.prescription DROP COLUMN dosage;
ALTER TABLE patient.prescription DROP COLUMN status;
ALTER TABLE patient.prescription DROP COLUMN duration;
ALTER TABLE patient.prescription DROP COLUMN dispensingunit;

ALTER TABLE patient.prescription ADD COLUMN originunitid BIGINT;
ALTER TABLE patient.prescription ADD COLUMN destinationunitid BIGINT;

ALTER TABLE patient.prescription ADD CONSTRAINT fk_originunitid FOREIGN KEY(originunitid) REFERENCES facilityunit(facilityunitid);
ALTER TABLE patient.prescription ADD CONSTRAINT fk_destinationunitid FOREIGN KEY(destinationunitid) REFERENCES facilityunit(facilityunitid);

CREATE TABLE patient.prescriptionitems
(
    prescriptionitemsid bigint NOT NULL,
    prescriptionid bigint,
    itemid bigint,
    dosage character varying(255) COLLATE pg_catalog."default",
    days integer,
    dosagestatus character varying(255) COLLATE pg_catalog."default",
    dateadded date,
    CONSTRAINT prescriptionitems_pkey PRIMARY KEY (prescriptionitemsid)
);

CREATE SEQUENCE patient.prescriptionitems_prescriptionitemsid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.prescriptionitems ALTER COLUMN prescriptionitemsid SET DEFAULT nextval('patient.prescriptionitems_prescriptionitemsid_seq'::regclass);
ALTER TABLE patient.prescriptionitems ADD CONSTRAINT fk_itemid FOREIGN KEY(itemid) REFERENCES store.medicalitem(medicalitemid);
ALTER TABLE patient.prescriptionitems ADD CONSTRAINT fk_prescriptionid FOREIGN KEY(prescriptionid) REFERENCES patient.prescription(prescriptionid);

ALTER TABLE store.medicalitem ADD COLUMN itemsource VARCHAR DEFAULT 'ems';
ALTER  TABLE store.facilityorderitems ALTER COLUMN approved SET DEFAULT false;

CREATE SEQUENCE patient.testmethod_testmethodid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.testmethod ALTER COLUMN testmethodid SET DEFAULT nextval('patient.testmethod_testmethodid_seq'::regclass);


ALTER TABLE store.facilityfinancialyear ALTER COLUMN istopdownapproach SET DEFAULT true;
ALTER TABLE store.facilityfinancialyear ALTER COLUMN isthecurrent SET DEFAULT false;
ALTER TABLE store.facilityfinancialyear ALTER COLUMN proccessstage SET DEFAULT 'CREATED';
ALTER TABLE store.facilityfinancialyear ALTER COLUMN orderperiodtype SET DEFAULT 'Annually';
ALTER TABLE store.facilityfinancialyear ALTER COLUMN status SET DEFAULT false;


ALTER TABLE store.facilityprocurementplan ADD COLUMN pack Integer default 1;
ALTER TABLE store.facilityprocurementplan ADD COLUMN unitcost DOUBLE PRECISION default 0;
ALTER TABLE store.facilityprocurementplan ADD COLUMN itemcode text;
ALTER TABLE patient.prescriptionitems ADD COLUMN daysname VARCHAR;
ALTER TABLE patient.laboratoryrequesttest ADD COLUMN testresult VARCHAR;
ALTER TABLE  patient.prescriptionitems ADD COLUMN notes VARCHAR;

CREATE TABLE patient.patientcomplaint
(
    patientcomplaintid bigint NOT NULL,
    patientcomplaint character varying(255) COLLATE pg_catalog."default",
    description character varying(255) COLLATE pg_catalog."default",
    patientvisitid bigint,
    addedby bigint,
    dateadded date,
    CONSTRAINT patientcomplaint_pkey PRIMARY KEY (patientcomplaintid)
);
CREATE SEQUENCE patient.patientcomplaint_patientcomplaintid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.patientcomplaint ALTER COLUMN patientcomplaintid SET DEFAULT nextval('patient.patientcomplaint_patientcomplaintid_seq'::regclass);

CREATE TABLE patient.patientobservation
(
    patientobservationid bigint NOT NULL,
    observation character varying(255) COLLATE pg_catalog."default",
    addedby bigint,
    dateadded date,
    patientvisitid bigint,
    CONSTRAINT patientobservation_pkey PRIMARY KEY (patientobservationid)
);

CREATE SEQUENCE patient.patientobservation_patientobservationid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.patientobservation ALTER COLUMN patientobservationid SET DEFAULT nextval('patient.patientobservation_patientobservationid_seq'::regclass);

ALTER TABLE patient.patientcomplaint ADD COLUMN patientvisitid BIGINT;

CREATE TABLE patient.internalreferral
(
    internalreferralid bigint NOT NULL,
    referralunitid bigint,
    patientvisitid bigint,
    referringunitid bigint,
    addedby bigint,
    dateadded date,
    iscomplete boolean,
    referralnotes character varying(255) COLLATE pg_catalog."default",
    referredto bigint,
    specialty character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT internalreferral_pkey PRIMARY KEY (internalreferralid)
);

CREATE SEQUENCE patient.internalreferral_internalreferralid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.internalreferral ALTER COLUMN internalreferralid SET DEFAULT nextval('patient.internalreferral_internalreferralid_seq'::regclass);

ALTER TABLE patient.internalreferral ADD CONSTRAINT fk_patientvisitid FOREIGN KEY(patientvisitid) REFERENCES patient.patientvisit(patientvisitid);
ALTER TABLE patient.internalreferral ADD CONSTRAINT fk_referralunitid FOREIGN KEY(referralunitid) REFERENCES facilityunit(facilityunitid);
ALTER TABLE patient.internalreferral ADD CONSTRAINT fk_referringunitid FOREIGN KEY(referringunitid) REFERENCES facilityunit(facilityunitid);
ALTER TABLE patient.internalreferral ADD CONSTRAINT fk_referredto FOREIGN KEY(referredto) REFERENCES staff(staffid);
ALTER TABLE patient.internalreferral ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES staff(staffid);
ALTER TABLE patient.patientcomplaint ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES staff(staffid);
ALTER TABLE patient.patientcomplaint ADD CONSTRAINT fk_patientvisitid FOREIGN KEY(patientvisitid) REFERENCES patient.patientvisit(patientvisitid);
ALTER TABLE patient.patientobservation ADD CONSTRAINT fk_patientvisitid FOREIGN KEY(patientvisitid) REFERENCES patient.patientvisit(patientvisitid);
ALTER TABLE patient.patientobservation ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES staff(staffid);

ALTER TABLE patient.prescriptionitems ADD COLUMN dose VARCHAR;














