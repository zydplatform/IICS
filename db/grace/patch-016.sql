/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  HP
 * Created: Oct 3, 2018
 */

ALTER TABLE patient.prescription ADD approvedby bigint REFERENCES staff(staffid);

ALTER TABLE patient.prescription ADD status varchar(255);

ALTER TABLE patient.prescription ADD dateapproved date;

ALTER TABLE patient.prescriptionitems ADD quantityapproved int;

ALTER TABLE patient.prescriptionitems ADD itempackageid bigint;

ALTER TABLE patient.prescriptionitems ADD isapproved Boolean;

CREATE TABLE store.prescriptionissue(
    prescriptionissueid bigint PRIMARY KEY,
    quantityissued int,
    notes VARCHAR(255),
    stockid bigint REFERENCES store.stock(stockid),
    issuedby bigint REFERENCES staff(staffid),
    prescriptionitemsid bigint REFERENCES patient.prescriptionitems(prescriptionitemsid),
    dateissued date);

/* -- */
CREATE SEQUENCE store.prescription_issue_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807;

ALTER TABLE store.prescriptionissue ALTER COLUMN prescriptionissueid SET DEFAULT nextval('store.prescription_issue_seq'::regclass);

DROP TABLE store.prescriptionissuance;

/* -- */
ALTER TABLE patient.prescriptionitems DROP itempackageid;

ALTER TABLE patient.prescriptionitems DROP quantityapproved;

ALTER TABLE store.prescriptionissue ADD quantityapproved int;

ALTER TABLE store.prescriptionissue ADD itempackageid bigint;