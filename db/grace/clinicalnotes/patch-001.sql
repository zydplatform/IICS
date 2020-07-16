/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS-GRACE
 * Created: Aug 6, 2018
 */

CREATE TABLE patient.diseaseclassification(
    diseaseclassificationid bigint PRIMARY KEY,
    classifficationname VARCHAR(255),
    facilityid bigint REFERENCES facility(facilityid),
    createdby bigint REFERENCES staff(staffid),
    updatedby bigint REFERENCES staff(staffid),
    datecreated date,
    lastupdate date,
    status Boolean);

CREATE SEQUENCE patient.diseaseclassification_classification_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807;

ALTER TABLE patient.diseaseclassification ALTER COLUMN diseaseclassificationid SET DEFAULT nextval('patient.diseaseclassification_classification_seq'::regclass);


CREATE TABLE patient.diseasecategory(
    diseasecategoryid bigint PRIMARY KEY,
    diseasecategoryname VARCHAR(255),
    diseaseclassificationid bigint REFERENCES patient.diseaseclassification(diseaseclassificationid),
    createdby bigint REFERENCES staff(staffid),
    updatedby bigint REFERENCES staff(staffid),
    datecreated date,
    lastupdate date,
    status Boolean);

CREATE SEQUENCE patient.disease_category_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807;

ALTER TABLE patient.diseasecategory ALTER COLUMN diseasecategoryid SET DEFAULT nextval('patient.disease_category_seq'::regclass);


CREATE TABLE patient.disease(
    diseaseid bigint PRIMARY KEY,
    diseasename VARCHAR(255),
    description text,
    diseasecategoryid bigint REFERENCES patient.diseasecategory(diseasecategoryid),
    createdby bigint REFERENCES staff(staffid),
    updatedby bigint REFERENCES staff(staffid),
    datecreated date,
    lastupdate date,
    status Boolean);

CREATE SEQUENCE patient.disease_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807;

ALTER TABLE patient.disease ALTER COLUMN diseaseid SET DEFAULT nextval('patient.disease_seq'::regclass);

/*Other Queries*/
ALTER TABLE patient.disease ADD parentid bigint;
ALTER TABLE patient.disease ADD hasparent BOOLEAN;

/*---*/
ALTER TABLE patient.diseaseclassification DROP facilityid;

ALTER TABLE patient.disease ADD diseasecode VARCHAR(255);
