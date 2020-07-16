/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  RESEARCH
 * Created: Jun 8, 2018
 */

CREATE SCHEMA assetsmanager;
ALTER TABLE controlpanel.building SET SCHEMA assetsmanager;
ALTER TABLE controlpanel.facilityblock SET SCHEMA assetsmanager;
ALTER TABLE controlpanel.blockroom SET SCHEMA assetsmanager;
CREATE TABLE assetsmanager.assetclassification(assetclassificationid int PRIMARY KEY, classificationname text, allocationtype text, dateadded date, dateupdated date, addedby bigint, updatedby bigint);
CREATE TABLE assetsmanager.assets(assetsid int PRIMARY KEY,assetsname text,assetclassificationid int references assetsmanager.assetclassification(assetclassificationid),isactive boolean, dateadded date, dateupdated date, addedby bigint, updatedby bigint);
CREATE TABLE assetsmanager.assetallocation(assetallocationid int PRIMARY KEY,isallocated boolean,assetcurrentlocation text, assetoldlocation text, assetsid int references assetsmanager.assets(assetsid), blockroomid int references assetsmanager.blockroom(blockroomid),isactive boolean, dateadded date, dateupdated date, addedby bigint, updatedby bigint);
ALTER TABLE assetsmanager.assetclassification ADD COLUMN facilityid int references public.facility(facilityid);
CREATE SEQUENCE assetsmanager.assetclassification_assetclassificationid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE assetsmanager.assetclassification ALTER COLUMN assetclassificationid SET DEFAULT nextval('assetsmanager.assetclassification_assetclassificationid_seq'::regclass);
CREATE SEQUENCE assetsmanager.assets_assetsid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE assetsmanager.assets ALTER COLUMN assetsid SET DEFAULT nextval('assetsmanager.assets_assetsid_seq'::regclass);
CREATE SEQUENCE assetsmanager.assetallocation_assetallocationid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE assetsmanager.assetallocation ALTER COLUMN assetallocationid SET DEFAULT nextval('assetsmanager.assetallocation_assetallocationid_seq'::regclass);
ALTER TABLE assetsmanager.assetclassification ADD COLUMN assetsnumber int;
ALTER TABLE assetsmanager.assets ADD COLUMN assetidentifier text;

ALTER TABLE assetsmanager.assetallocation DROP COLUMN assetcurrentlocation;
ALTER TABLE assetsmanager.assetallocation DROP COLUMN assetoldlocation;
ALTER TABLE assetsmanager.assetallocation ADD COLUMN assetcurrentlocation int;
ALTER TABLE assetsmanager.assetallocation ADD COLUMN assetoldlocation int;

CREATE TABLE assetsmanager.blockfloor(blockfloorid int PRIMARY KEY, floorname text, numberofrooms int, facilityblockid int references assetsmanager.facilityblock(facilityblockid), isactive boolean,dateadded date, dateupdated date, addedby bigint, updatedby bigint);
ALTER TABLE assetsmanager.facilityblock ADD COLUMN floorsize int;
ALTER TABLE assetsmanager.blockroom DROP COLUMN facilityblockid;
ALTER TABLE assetsmanager.blockroom ADD COLUMN blockfloorid int references assetsmanager.blockfloor(blockfloorid);
CREATE SEQUENCE assetsmanager.blockfloor_blockfloorid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE assetsmanager.blockfloor ALTER COLUMN blockfloorid SET DEFAULT nextval('assetsmanager.blockfloor_blockfloorid_seq'::regclass);
ALTER TABLE assetsmanager.facilityblock DROP COLUMN roomsize;
ALTER TABLE assetsmanager.blockfloor ADD COLUMN roomsize int;
CREATE TABLE assetsmanager.assetstorage(assetstorageid int PRIMARY KEY, assetsid int references assetsmanager.assets(assetsid), blockroomid int references assetsmanager.blockroom(blockroomid), instorage boolean,dateadded date, dateupdated date, addedby bigint, updatedby bigint);

ALTER TABLE assetsmanager.blockroom ADD COLUMN dateadded date; 
ALTER TABLE assetsmanager.blockroom ADD COLUMN dateupdated date;

-- 29TH AUGUST 2018 NEW ASSET TABLES/CHANGES
ALTER TABLE assetsmanager.assetclassification DROP COLUMN facilityid
ALTER TABLE assetsmanager.assets DROP COLUMN isactive
ALTER TABLE assetsmanager.assets DROP COLUMN assetidentifier
ALTER TABLE assetsmanager.assetallocation DROP COLUMN assetsid

CREATE TABLE assetsmanager.facilityassets(facilityassetsid bigint PRIMARY KEY, assetsid int references assetsmanager.assets(assetsid), facilityid int references public.facility(facilityid), donationsid int references store.donations(donationsid), isdonated boolean, itemspecification text, serialno text, dateadded date, dateupdated date, addedby bigint, updatedby bigint)
CREATE SEQUENCE assetsmanager.facilityassets_facilityassetsid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE assetsmanager.facilityassets ALTER COLUMN facilityassetsid SET DEFAULT nextval('assetsmanager.facilityassets_facilityassetsid_seq'::regclass);

ALTER TABLE assetsmanager.assetallocation ADD COLUMN facilityassetsid bigint references assetsmanager.facilityassets(facilityassetsid)

ALTER TABLE  assetsmanager.assetclassification ADD COLUMN moreinfo text
ALTER TABLE  assetsmanager.assetclassification DROP COLUMN assetsnumber
ALTER TABLE assetsmanager.assets ADD COLUMN moreinfo text
ALTER TABLE assetsmanager.assets ADD COLUMN assettype text
ALTER TABLE assetsmanager.assets ADD COLUMN isservicable boolean 
ALTER TABLE assetsmanager.facilityassets ADD COLUMN assetqty int

ALTER TABLE assetsmanager.facilityassets ADD COLUMN allocated text
ALTER TABLE assetsmanager.facilityassets ADD COLUMN newqty int

ALTER TABLE assetsmanager.assetallocation ADD COLUMN allocatedby bigint
ALTER TABLE assetsmanager.assetallocation ADD COLUMN dateallocated date
ALTER TABLE assetsmanager.assetallocation DROP COLUMN dateadded
ALTER TABLE assetsmanager.assetallocation DROP COLUMN addedby
ALTER TABLE assetsmanager.assetallocation DROP COLUMN isallocated
ALTER TABLE assetsmanager.assetallocation ADD COLUMN isserviced BOOLEAN
ALTER TABLE assetsmanager.assetallocation ADD COLUMN isdisposed BOOLEAN
ALTER TABLE assetsmanager.facilityassets ADD COLUMN olddonatedqty int

ALTER TABLE assetsmanager.assetallocation ADD COLUMN qtyallocated int 
ALTER TABLE assetsmanager.assetallocation ADD COLUMN facilityunitid bigint references facilityunit(facilityunitid);