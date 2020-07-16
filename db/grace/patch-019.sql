/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  HP
 * Created: Oct 19, 2018
 */

CREATE TABLE store.suppliesorder(
    suppliesorderid bigint PRIMARY KEY,
    facilityunitid bigint REFERENCES staff(staffid),
    isemergency boolean,
    requestedby bigint REFERENCES staff(staffid),
    daterequested date,
    status VARCHAR(255),
    orderno VARCHAR(255),
    dateissued date,
    issuedby bigint REFERENCES staff(staffid),
    approvedby bigint REFERENCES staff(staffid),
    dateapproved date,
    issuedto bigint REFERENCES staff(staffid)
);


CREATE SEQUENCE store.supplies_order_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807;

ALTER TABLE store.suppliesorder ALTER COLUMN suppliesorderid SET DEFAULT nextval('store.supplies_order_seq'::regclass);



CREATE TABLE store.suppliesorderitems(
    suppliesorderitemsid bigint PRIMARY KEY,
    itemid bigint,
    qtyordered int,
    qtyreceived int,
    qtyapproved int,
    isapproved boolean,
    suppliesorderid bigint REFERENCES store.suppliesorder(suppliesorderid)
);

CREATE SEQUENCE store.supplies_order_items_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807;

ALTER TABLE store.suppliesorderitems ALTER COLUMN suppliesorderitemsid SET DEFAULT nextval('store.supplies_order_items_seq'::regclass);

CREATE TABLE store.suppliesissuance(
    suppliesissuanceid bigint PRIMARY KEY,
    stockid bigint REFERENCES store.stock (stockid),
    suppliesorderitemsid bigint REFERENCES store.suppliesorderitems (suppliesorderitemsid),
    qtyissued int
);

CREATE SEQUENCE store.supplies_issuance_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807;

ALTER TABLE store.suppliesissuance ALTER COLUMN suppliesissuanceid SET DEFAULT nextval('store.supplies_issuance_seq'::regclass);

-- ALTER TABLE store.suppliesorder DROP isapproved;
-- 
-- ALTER TABLE store.suppliesorder DROP isissued;

ALTER TABLE store.suppliesorderitems ADD isapproved Boolean;

ALTER TABLE store.suppliesorderitems ADD isissued Boolean;

ALTER TABLE store.suppliesorder ADD addedby  bigint REFERENCES staff(staffid);