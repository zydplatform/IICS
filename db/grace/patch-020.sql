/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  HP
 * Created: Oct 22, 2018
 */

/* Update Dispensing  PLEASE FIRST TRUNCATE store.prescriptionissue*/
DROP VIEW patient.prescriptionissueview;

CREATE TABLE store.dispenseditems(
    dispenseditemsid bigint PRIMARY KEY,
    quantitydispensed int,
    stockid bigint REFERENCES store.stock(stockid),
    prescriptionissueid bigint REFERENCES store.prescriptionissue(prescriptionissueid)
);

CREATE SEQUENCE store.dispensed_items_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807;

ALTER TABLE store.dispenseditems ALTER COLUMN dispenseditemsid SET DEFAULT nextval('store.dispensed_items_seq'::regclass);

ALTER TABLE store.prescriptionissue DROP stockid;

ALTER TABLE store.prescriptionissue DROP quantityissued;

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
    di.stockid,
    di.quantitydispensed,
    iss.prescriptionissueid
    FROM patient.prescription pre
    JOIN patient.prescriptionitems pi ON pi.prescriptionid = pre.prescriptionid
    JOIN store.prescriptionissue iss ON iss.prescriptionitemsid = pi.prescriptionitemsid
    JOIN store.dispenseditems di ON di.prescriptionissueid = iss.prescriptionissueid;

/* STOCK OUT TABLES */
ALTER TABLE store.stocklog ADD referencetype VARCHAR(255);

ALTER TABLE store.stocklog ADD reference bigint;

ALTER TABLE store.stocklog ADD referencenumber VARCHAR(255);
      