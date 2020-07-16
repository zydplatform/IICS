/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jun 27, 2018
 */
CREATE TABLE store.discrepancy
(
    discrepancyid bigint NOT NULL,
    discrepancytype character varying(200) COLLATE pg_catalog."default",
    stockid bigint,
    quantity integer,
    loggedby bigint,
    datelogged date,
    dateadded date,
    addedby bigint,
    CONSTRAINT discrepancy_pkey PRIMARY KEY (discrepancyid)
);
CREATE TABLE patient.patientvisit
(
    patientvisitid bigint NOT NULL,
    patientid bigint,
    addedby bigint,
    dateadded date,
    CONSTRAINT patientvisit_pkey PRIMARY KEY (patientvisitid)
);
CREATE TABLE patient.prescription
(
    prescriptionid bigint NOT NULL,
    patientvisitid bigint,
    itemid bigint,
    weight character varying(255) COLLATE pg_catalog."default",
    dosage character varying(200) COLLATE pg_catalog."default",
    dateprescribed date,
    duration integer,
    status character varying(200) COLLATE pg_catalog."default",
    CONSTRAINT prescription_pkey PRIMARY KEY (prescriptionid)
);
CREATE TABLE store.prescriptionissuance
(
    prescriptionissuanceid bigint NOT NULL,
    stockid bigint,
    quantityissued integer,
    prescriptionid bigint,
    dateissued date,
    issuedby bigint,
    CONSTRAINT prescriptionissuance_pkey PRIMARY KEY (prescriptionissuanceid)
);

CREATE TABLE store.orderissuance
(
    orderissuanceid bigint NOT NULL,
    stockid bigint,
    quantityissued integer,
    facilityorderitemsid bigint,
    issuedby bigint,
    dateissued date,
    CONSTRAINT orderissuance_pkey PRIMARY KEY (orderissuanceid)
);
ALTER TABLE store.discrepancy ADD CONSTRAINT fk_stockid FOREIGN KEY(stockid) REFERENCES store.stock (stockid);
ALTER TABLE store.discrepancy ADD CONSTRAINT fk_loggedby FOREIGN KEY(loggedby) REFERENCES person (personid);
ALTER TABLE store.discrepancy ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES person (personid);
ALTER TABLE patient.patientvisit ADD CONSTRAINT fk_patientid FOREIGN KEY(patientid) REFERENCES patient.patient (patientid);
ALTER TABLE patient.patientvisit ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES person (personid);
ALTER TABLE patient.prescription ADD CONSTRAINT fk_itemid FOREIGN KEY(itemid) REFERENCES store.item (itemid);
ALTER TABLE patient.prescription ADD CONSTRAINT fk_patientvisitid FOREIGN KEY(patientvisitid) REFERENCES patient.patientvisit (patientvisitid);
ALTER TABLE store.prescriptionissuance ADD CONSTRAINT fk_stockid FOREIGN KEY(stockid) REFERENCES store.stock (stockid);
ALTER TABLE store.prescriptionissuance ADD CONSTRAINT fk_issuedby FOREIGN KEY(issuedby) REFERENCES person (personid);
ALTER TABLE store.orderissuance ADD CONSTRAINT fk_stockid FOREIGN KEY(stockid) REFERENCES store.stock (stockid);
ALTER TABLE store.orderissuance ADD CONSTRAINT fk_facilityorderitemsid FOREIGN KEY(facilityorderitemsid) REFERENCES store.facilityorderitems (facilityorderitemsid);
ALTER TABLE store.orderissuance ADD CONSTRAINT fk_issuedby FOREIGN KEY(issuedby) REFERENCES person (personid);

CREATE SEQUENCE store.discrepancy_discrepancyid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE store.discrepancy ALTER COLUMN discrepancyid SET DEFAULT nextval('store.discrepancy_discrepancyid_seq'::regclass);
CREATE SEQUENCE patient.patientvisit_patientvisitid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.patientvisit ALTER COLUMN patientvisitid SET DEFAULT nextval('patient.patientvisit_patientvisitid_seq'::regclass);
CREATE SEQUENCE patient.prescription_prescriptionid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.prescription ALTER COLUMN prescriptionid SET DEFAULT nextval('patient.prescription_prescriptionid_seq'::regclass);
CREATE SEQUENCE store.prescriptionissuance_prescriptionissuanceid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE store.prescriptionissuance ALTER COLUMN prescriptionissuanceid SET DEFAULT nextval('store.prescriptionissuance_prescriptionissuanceid_seq'::regclass);
CREATE SEQUENCE store.orderissuance_orderissuanceid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE store.orderissuance ALTER COLUMN orderissuanceid SET DEFAULT nextval('store.orderissuance_orderissuanceid_seq'::regclass);






