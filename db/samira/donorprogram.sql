/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  RESEARCH
 * Created: Sep 4, 2018
 */
CREATE TABLE store.donorprogram(donorprogramid int PRIMARY KEY, donorname text, donationfunder text, donationtype text, startdate date, enddate date, telno varchar, emial text, fax text, addedby bigint, updatedby bigint, dateadded date, dateupdated date);
CREATE SEQUENCE store.donorprogram_donorprogramid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.donorprogram ALTER COLUMN donorprogramid SET DEFAULT nextval('store.donorprogram_donorprogramid_seq'::regclass);

CREATE TABLE store.facilitydonorstock(facilitydonorstockid int PRIMARY KEY, stockid bigint references store.stock(stockid), donorprogramid int references store.donorprogram(donorprogramid), addedby bigint, updatedby bigint, dateadded date, dateupdated date);
CREATE SEQUENCE store.facilitydonorstock_facilitydonorstockid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.facilitydonorstock ALTER COLUMN facilitydonorstockid SET DEFAULT nextval('store.facilitydonorstock_facilitydonorstockid_seq'::regclass);
ALTER TABLE store.donorprogram ADD COLUMN facilityid int references public.facility(facilityid)

ALTER TABLE store.donorprogram DROP COLUMN startdate;
ALTER TABLE store.donorprogram DROP COLUMN enddate;
ALTER TABLE store.donorprogram DROP COLUMN donationtype;
ALTER TABLE store.donorprogram DROP COLUMN donationfunder;

ALTER TABLE store.donorprogram ADD COLUMN origincountry text;
ALTER TABLE store.donorprogram ADD COLUMN donortype varchar;

-- facilitydonor
CREATE TABLE store.facilitydonor(facilitydonorid int PRIMARY KEY, donorprogramid int references store.donorprogram(donorprogramid), facilityid int references public.facility(facilityid), addedby bigint, updatedby bigint, dateadded date, dateupdated date);
CREATE SEQUENCE store.facilitydonor_facilitydonorid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.facilitydonor ALTER COLUMN facilitydonorid SET DEFAULT nextval('store.facilitydonor_facilitydonorid_seq'::regclass);

-- donations table
CREATE TABLE store.donations(donationsid int PRIMARY KEY, facilitydonorid int references store.facilitydonor(facilitydonorid), donorrefno varchar,receivedby bigint, updatedby bigint, datereceived date, dateupdated date);
CREATE SEQUENCE store.donations_donationsid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.donations ALTER COLUMN donationsid SET DEFAULT nextval('store.donations_donationsid_seq'::regclass);

-- donoritems
CREATE TABLE store.donoritems(donoritemsid int PRIMARY KEY, donoritemname varchar,addedby bigint, updatedby bigint, dateadded date, dateupdated date);
CREATE SEQUENCE store.donoritems_donoritemsid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.donoritems ALTER COLUMN donoritemsid SET DEFAULT nextval('store.donoritems_donoritemsid_seq'::regclass);

-- donationitems
CREATE TABLE store.donationsitems(donationsitemsid int PRIMARY KEY, donationsid int references store.donations(donationsid), medicalitemsid bigint references store.item(itemid), otheritemsid int references store.donoritems(donoritemsid), itemtype varchar, qtydonated int, expirydate date, batchno text, istransferrred boolean Default FALSE, addedby bigint, updatedby bigint, dateadded date, dateupdated date);
CREATE SEQUENCE store.donationsitems_donationsitemsid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.donationsitems ALTER COLUMN donationsitemsid SET DEFAULT nextval('store.donationsitems_donationsitemsid_seq'::regclass);

-- donation consumption
CREATE TABLE store.donationconsumption(donationconsumptionid int PRIMARY KEY, donationsitemsid int references store.donationsitems(donationsitemsid), facilityunitid bigint references public.facilityunit(facilityunitid), qtyissued int,receivedby bigint,issuedby bigint, bigintupdatedby bigint, dateissued date, dateupdated date);
CREATE SEQUENCE store.donationconsumption_donationconsumptionid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.donationconsumption ALTER COLUMN donationconsumptionid SET DEFAULT nextval('store.donationconsumption_donationconsumptionid_seq'::regclass);

DROP TABLE store.facilitydonorstock;
ALTER TABLE store.donorprogram DROP COLUMN facilityid;

ALTER TABLE store.donations DROP COLUMN donorprogramid;
ALTER TABLE store.donationsitems ADD COLUMN donationsid int references store.donations(donationsid)

ALTER TABLE store.donorprogram ADD COLUMN contactperson bigint references public.person (personid)

ALTER TABLE store.donorprogram DROP COLUMN contactperson;
ALTER TABLE store.facilitydonor ADD COLUMN contactperson bigint references public.person (personid);

ALTER TABLE store.facilitydonor ADD COLUMN primarycontact varchar;
ALTER TABLE store.facilitydonor ADD COLUMN secondarycontact varchar;
ALTER TABLE store.facilitydonor ADD COLUMN email text;

ALTER TABLE store.donationsitems ADD COLUMN itemspecification text;

ALTER TABLE store.donationsitems ADD COLUMN qtytransferred int

ALTER TABLE store.donationsitems DROP COLUMN qtytransferred

ALTER TABLE store.donationsitems ADD COLUMN intialdonatedqty int

ALTER TABLE store.donationsitems DROP COLUMN handedoverto

ALTER TABLE store.donationsitems ADD COLUMN handedoverto bigint references public.staff (staffid)

-- THIS IS ABOUT THE ASSETS TABLES 
ALTER TABLE store.donorprogram ADD COLUMN individualdonorid bigint references public.person (personid)

ALTER TABLE store.donorprogram DROP COLUMN individualdonorid;

ALTER TABLE store.donationconsumption DROP COLUMN facilityunitid;
ALTER TABLE store.donationconsumption DROP COLUMN qtyissued;
ALTER TABLE store.donationconsumption DROP COLUMN receivedby;
ALTER TABLE store.donationconsumption DROP COLUMN issuedby;
ALTER TABLE store.donationconsumption DROP COLUMN bigintupdatedby;
ALTER TABLE store.donationconsumption DROP COLUMN dateissued;
ALTER TABLE store.donationconsumption DROP COLUMN dateupdated;

ALTER TABLE store.donationconsumption ADD COLUMN handedoverto bigint references public.staff (staffid);
ALTER TABLE store.donationconsumption ADD COLUMN qtyhandedover Integer;
ALTER TABLE store.donationconsumption ADD COLUMN handoverdate date;
ALTER TABLE store.donationconsumption ADD COLUMN consumerunit bigint references public.facilityunit(facilityunitid);
ALTER TABLE store.donationconsumption ADD COLUMN qtydelivered Integer;
ALTER TABLE store.donationconsumption ADD COLUMN isdelivered boolean;
ALTER TABLE store.donationconsumption ADD COLUMN datedelivered date;
ALTER TABLE store.donationconsumption ADD COLUMN deliveredto bigint references public.staff (staffid);
ALTER TABLE store.donationconsumption ADD COLUMN deliveredfrom bigint references public.staff (staffid);

ALTER TABLE store.donationsitems DROP COLUMN handedoverto;
ALTER TABLE store.donationsitems DROP COLUMN istransferrred;
ALTER TABLE store.donationsitems DROP COLUMN intialdonatedqty;

ALTER TABLE store.donationconsumption ADD COLUMN handoverunit bigint references public.facilityunit(facilityunitid);
