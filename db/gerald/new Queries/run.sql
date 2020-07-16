/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Aug 3, 2018
 */

ALTER TABLE controlpanel.stafffacilityunitaccessrightprivilege ADD COLUMN isrecalled BOOLEAN DEFAULT false;
ALTER TABLE controlpanel.accessrightgroupprivilege ADD COLUMN isrecalled BOOLEAN DEFAULT false;
ALTER TABLE store.itemclassification ADD COLUMN parentid BIGINT;
ALTER TABLE store.itemclassification ADD COLUMN hasparent BOOLEAN DEFAULT true;



--WEEKEND
CREATE TABLE patient.labtestclassification
(
    labtestclassificationid bigint NOT NULL,
    labtestclassificationname character varying(255) COLLATE pg_catalog."default",
    description character varying(255) COLLATE pg_catalog."default",
    dateadded date,
    addedby bigint,
    CONSTRAINT labtestclassification_pkey PRIMARY KEY (labtestclassificationid)
);

ALTER TABLE patient.laboratorytest ADD COLUMN labtestclassificationid BIGINT;
ALTER TABLE patient.laboratorytest ADD COLUMN parentid BIGINT;
ALTER TABLE patient.laboratorytest ADD COLUMN description VARCHAR;

CREATE SEQUENCE patient.labtestclassification_labtestclassificationid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.labtestclassification ALTER COLUMN labtestclassificationid SET DEFAULT nextval('patient.labtestclassification_labtestclassificationid_seq'::regclass);
ALTER TABLE patient.laboratorytest ADD CONSTRAINT fk_labtestclassificationid FOREIGN KEY(labtestclassificationid) REFERENCES patient.labtestclassification(labtestclassificationid);
ALTER TABLE patient.labtestclassification ADD CONSTRAINT fk_staffid FOREIGN KEY(addedby) REFERENCES staff(staffid);

ALTER TABLE patient.labtestclassification ADD COLUMN facilityid BIGINT;
ALTER TABLE patient.labtestclassification ADD COLUMN isactive BOOLEAN;
ALTER TABLE patient.laboratoryrequest ADD COLUMN status VARCHAR;
ALTER TABLE patient.laboratoryrequesttest ADD COLUMN iscompleted BOOLEAN;



---Holiday
ALTER TABLE patient.laboratorytest ADD COLUMN testrange VARCHAR;
ALTER TABLE patient.laboratorytest ADD COLUMN unitofmeasure VARCHAR;

ALTER TABLE  patient.labtestclassification DROP COLUMN facilityid;
ALTER TABLE  patient.laboratorytest DROP COLUMN facilityid;


---packages
CREATE TABLE store.packages
(
    packagesid bigint NOT NULL,
    packagename character varying COLLATE pg_catalog."default",
    addedby bigint,
    dateadded date,
    CONSTRAINT packages_pkey PRIMARY KEY (packagesid)
);
CREATE TABLE store.itempackages
(
    itempackagesid bigint NOT NULL,
    packagesid bigint,
    itemid bigint,
    qty integer,
    addedby bigint,
    dateadded date,
    lastupdate date,
    lastupdatedby bigint,
    CONSTRAINT itempackages_pkey PRIMARY KEY (itempackagesid)
);
CREATE SEQUENCE store.packages_packagesid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE store.packages ALTER COLUMN packagesid SET DEFAULT nextval('store.packages_packagesid_seq'::regclass);

CREATE SEQUENCE store.itempackages_itempackagesid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE store.itempackages ALTER COLUMN itempackagesid SET DEFAULT nextval('store.itempackages_itempackagesid_seq'::regclass);
ALTER TABLE store.itempackages ADD CONSTRAINT fk_packages FOREIGN KEY(packagesid) REFERENCES store.packages(packagesid);
ALTER TABLE store.itempackages ADD CONSTRAINT fk_item FOREIGN KEY(itemid) REFERENCES store.item(itemid);
ALTER TABLE store.itempackages ADD CONSTRAINT fk_staff FOREIGN KEY(addedby) REFERENCES staff(staffid);
ALTER TABLE store.itempackages ADD CONSTRAINT fk_staffup FOREIGN KEY(lastupdatedby) REFERENCES staff(staffid);
ALTER TABLE store.packages ADD CONSTRAINT fk_staff FOREIGN KEY(addedby) REFERENCES staff(staffid);
ALTER TABLE store.itempackages ADD COLUMN isactive BOOLEAN;

ALTER TABLE store.item ADD COLUMN isdeleted BOOLEAN DEFAULT FALSE;
ALTER TABLE store.itemclassification ADD COLUMN isdeleted BOOLEAN DEFAULT FALSE;


---last updated queries

ALTER TABLE patient.prescription ADD COLUMN addedby BIGINT;
ALTER TABLE patient.prescription ADD CONSTRAINT fk_staff FOREIGN KEY(addedby) REFERENCES staff(staffid);
ALTER TABLE patient.prescription ADD COLUMN lastupdatedby BIGINT;
ALTER TABLE patient.prescription ADD CONSTRAINT fk_staffup FOREIGN KEY(lastupdatedby) REFERENCES staff(staffid);
ALTER TABLE patient.prescription ADD COLUMN lastupdated date;