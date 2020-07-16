/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Aug 6, 2018
 */

CREATE TABLE patient.laboratoryrequest
(
    laboratoryrequestid bigint NOT NULL,
    laboratoryrequestnumber character varying(255) COLLATE pg_catalog."default",
    patientvisitid bigint,
    originunit bigint,
    destinationunit bigint,
    dateadded date,
    addedby bigint,
    lastupdated date,
    lastupdatedby bigint,
    CONSTRAINT laboratoryrequest_pkey PRIMARY KEY (laboratoryrequestid)
);
CREATE TABLE patient.laboratoryrequesttest
(
    laboratoryrequesttestid bigint NOT NULL,
    laboratorytestid bigint,
    laboratoryrequestid bigint,
    laboratorytestresultid bigint,
    dateadded date,
    addedby bigint,
    lastupdated date,
    lastupdatedby bigint,
    comment character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT laboratoryrequesttest_pkey PRIMARY KEY (laboratoryrequesttestid)
);
CREATE TABLE patient.laboratorytest
(
    laboratorytestid bigint NOT NULL,
    testname character varying(255) COLLATE pg_catalog."default",
    addedby bigint,
    dateadded date,
    CONSTRAINT laboratorytest_pkey PRIMARY KEY (laboratorytestid)
);
CREATE TABLE patient.laboratorytestresult
(
    laboratorytestresultid bigint NOT NULL,
    testresultname character varying(255) COLLATE pg_catalog."default",
    laboratorytestid bigint,
    addedby bigint,
    dateadded date,
    lastupdated date,
    lastupdatedby bigint,
    CONSTRAINT testresult_pkey PRIMARY KEY (laboratorytestresultid)
);

CREATE SEQUENCE patient.laboratoryrequest_laboratoryrequestid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.laboratoryrequest ALTER COLUMN laboratoryrequestid SET DEFAULT nextval('patient.laboratoryrequest_laboratoryrequestid_seq'::regclass);

CREATE SEQUENCE patient.laboratorytest_laboratorytestid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.laboratorytest ALTER COLUMN laboratorytestid SET DEFAULT nextval('patient.laboratorytest_laboratorytestid_seq'::regclass);

CREATE SEQUENCE patient.laboratorytestresult_laboratorytestresultid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.laboratorytestresult ALTER COLUMN laboratorytestresultid SET DEFAULT nextval('patient.laboratorytestresult_laboratorytestresultid_seq'::regclass);


CREATE SEQUENCE patient.laboratoryrequesttest_laboratoryrequesttestid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.laboratoryrequesttest ALTER COLUMN laboratoryrequesttestid SET DEFAULT nextval('patient.laboratoryrequesttest_laboratoryrequesttestid_seq'::regclass);

ALTER TABLE patient.laboratoryrequest ADD CONSTRAINT fk_patientvisit FOREIGN KEY(patientvisitid) REFERENCES patient.patientvisit(patientvisitid);
ALTER TABLE patient.laboratoryrequest ADD CONSTRAINT fk_originunit FOREIGN KEY(originunit) REFERENCES facilityunit(facilityunitid);
ALTER TABLE patient.laboratoryrequest ADD CONSTRAINT fk_destinationunit FOREIGN KEY(destinationunit) REFERENCES facilityunit(facilityunitid);
ALTER TABLE patient.laboratoryrequest ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES staff(staffid);
ALTER TABLE patient.laboratoryrequest ADD CONSTRAINT fk_lastupdatedby FOREIGN KEY(lastupdatedby) REFERENCES staff(staffid);
ALTER TABLE patient.laboratoryrequesttest ADD CONSTRAINT fk_lastupdatedby FOREIGN KEY(lastupdatedby) REFERENCES staff(staffid);
ALTER TABLE patient.laboratoryrequesttest ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES staff(staffid);
ALTER TABLE patient.laboratoryrequesttest ADD CONSTRAINT fk_laboratorytestresultid FOREIGN KEY(laboratorytestresultid) REFERENCES patient.laboratorytestresult(laboratorytestresultid);
ALTER TABLE patient.laboratoryrequesttest ADD CONSTRAINT fk_laboratoryrequest FOREIGN KEY(laboratoryrequestid) REFERENCES patient.laboratoryrequest(laboratoryrequestid);
ALTER TABLE patient.laboratoryrequesttest ADD CONSTRAINT fk_laboratorytest FOREIGN KEY(laboratorytestid) REFERENCES patient.laboratorytest(laboratorytestid);
ALTER TABLE patient.laboratorytestresult ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES staff(staffid);
ALTER TABLE patient.laboratorytestresult ADD CONSTRAINT fk_lastupdatedby FOREIGN KEY(lastupdatedby) REFERENCES staff(staffid);
ALTER TABLE patient.laboratorytestresult ADD CONSTRAINT fk_laboratorytest FOREIGN KEY(laboratorytestid) REFERENCES patient.laboratorytest(laboratorytestid);
ALTER TABLE patient.laboratorytest ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES staff(staffid);


-- ALTER TABLE patient.triage ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES staff(staffid);
-- ALTER TABLE patient.triage ADD CONSTRAINT fk_patientvisit FOREIGN KEY(patientvisitid) REFERENCES patient.patientvisit(patientvisitid);

CREATE SEQUENCE patient.triage_triageid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE patient.triage
(
    triageid bigint NOT NULL DEFAULT nextval('patient.triage_triageid_seq'::regclass),
    weight double precision,
    temperature double precision,
    height double precision,
    pulse integer,
    bloodpressure character varying(255) COLLATE pg_catalog."default",
    headcircum double precision,
    bodysurfacearea double precision,
    respirationrate integer,
    notes character varying(255) COLLATE pg_catalog."default",
    patientvisitid bigint,
    addedby bigint,
    dateadded date,
    CONSTRAINT triage_pkey PRIMARY KEY (triageid),
    CONSTRAINT fk_addedby FOREIGN KEY (addedby)
        REFERENCES public.staff (staffid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_patientvisit FOREIGN KEY (patientvisitid)
        REFERENCES patient.patientvisit (patientvisitid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE patient.laboratorytest ADD COLUMN facilityid BIGINT;
ALTER TABLE patient.laboratorytest ADD CONSTRAINT fk_facility FOREIGN KEY(facilityid)  REFERENCES facility(facilityid);

