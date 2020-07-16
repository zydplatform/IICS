/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Nov 1, 2018
 */

CREATE TABLE patient.patientpause
(
    patientpauseid integer NOT NULL,
    addedby bigint,
    paused boolean,
    dateadded date,
    patientvisitid bigint,
    CONSTRAINT patientpause_pkey PRIMARY KEY (patientpauseid)
);
CREATE SEQUENCE patient.patientpause_patientpauseid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.patientpause ALTER COLUMN patientpauseid SET DEFAULT nextval('patient.patientpause_patientpauseid_seq'::regclass);

ALTER TABLE patient.patientpause ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES staff(staffid);
ALTER TABLE patient.patientpause ADD COLUMN facilityunit BIGINT;

-- run this queries last
CREATE TABLE patient.patientdiagnosis
(
    patientdiagnosisid bigint NOT NULL,
    diseaseid bigint,
    patientvisitid bigint,
    isconfirmed boolean,
    dateadded date,
    addedby bigint,
    rank integer,
    lastupdated date,
    lastupdatedby bigint,
    CONSTRAINT patientdiagnosis_pkey PRIMARY KEY (patientdiagnosisid)
);

CREATE TABLE patient.visitsymptom
(
    visitsymptomid bigint NOT NULL,
    symptomid bigint,
    patientvisitid bigint,
    dateadded date,
    addedby bigint,
    CONSTRAINT visitsymptom_pkey PRIMARY KEY (visitsymptomid)
);

CREATE SEQUENCE patient.visitsymptom_visitsymptomid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.visitsymptom ALTER COLUMN visitsymptomid SET DEFAULT nextval('patient.visitsymptom_visitsymptomid_seq'::regclass);

CREATE SEQUENCE patient.patientdiagnosis_patientdiagnosisid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.patientdiagnosis ALTER COLUMN patientdiagnosisid SET DEFAULT nextval('patient.patientdiagnosis_patientdiagnosisid_seq'::regclass);

ALTER TABLE patient.patientdiagnosis ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES staff(staffid);
ALTER TABLE patient.patientdiagnosis ADD CONSTRAINT fk_lastupdatedby FOREIGN KEY(lastupdatedby) REFERENCES staff(staffid);
ALTER TABLE patient.visitsymptom ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES staff(staffid);
ALTER TABLE patient.visitsymptom ADD CONSTRAINT fk_symptomid FOREIGN KEY(symptomid) REFERENCES patient.symptom(symptomid);
ALTER TABLE patient.visitsymptom ADD CONSTRAINT fk_patientvisitid FOREIGN KEY(patientvisitid) REFERENCES patient.patientvisit(patientvisitid);
ALTER TABLE patient.patientdiagnosis ADD CONSTRAINT fk_patientvisitid FOREIGN KEY(patientvisitid) REFERENCES patient.patientvisit(patientvisitid);
ALTER TABLE patient.patientdiagnosis ADD CONSTRAINT fk_diseaseid FOREIGN KEY(diseaseid) REFERENCES patient.disease(diseaseid);

DROP TABLE patient.diseasecomplicationcomponent;
DROP TABLE patient.complicationcomponent;

ALTER TABLE patient.patientcomplaint ADD COLUMN facilityunitid BIGINT;
ALTER TABLE patient.patientcomplaint ADD CONSTRAINT fk_facilityunitid FOREIGN KEY(facilityunitid) REFERENCES facilityunit(facilityunitid);
ALTER TABLE patient.patientobservation ADD COLUMN facilityunitid BIGINT;
ALTER TABLE patient.patientobservation ADD CONSTRAINT fk_facilityunitid FOREIGN KEY(facilityunitid) REFERENCES facilityunit(facilityunitid);

ALTER TABLE patient.internalreferral ADD COLUMN unitserviceid BIGINT;
ALTER TABLE patient.internalreferral ADD CONSTRAINT fk_unitserviceid FOREIGN KEY(unitserviceid) REFERENCES facilityunitservice(facilityunitserviceid);
