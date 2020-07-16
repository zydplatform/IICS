/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  user
 * Created: Jun 26, 2018
 */

select * from public.requisition;
CREATE TABLE contactdetails(
	contactdetailsid integer NOT NULL,
        contacttype character varying(255),
        contactvalue character varying(255),
        CONSTRAINT contactdetails_pkey PRIMARY KEY (contactdetailsid),
        personid bigint REFERENCES person(personid),
        CONSTRAINT contactvalues UNIQUE(contactvalue)
)

CREATE TABLE requisition(

requisitionid int PRIMARY KEY,
 status VARCHAR(255),
 recommender bigint REFERENCES person(personid),
 staffid bigint REFERENCES staff(staffid)
);

ALTER TABLE requisition add COLUMN datecreated date;
ALTER TABLE requisition ADD UNIQUE (staffid); 
ALTER TABLE requisition ADD links VARCHAR (255);
ALTER TABLE requisition ADD reasonfordenial VARCHAR (255);
ALTER TABLE requisition add COLUMN datedenied date;
ALTER TABLE requisition add COLUMN dateapproved date;
ALTER TABLE requisition ADD UNIQUE (links);
ALTER TABLE designation ADD facilityid int REFERENCES facility(facilityid);


CREATE TABLE requisition(requisitionid int PRIMARY KEY, status VARCHAR(255), recommender bigint REFERENCES person(personid), staffid bigint REFERENCES staff(staffid));
ALTER TABLE requisition add COLUMN datecreated date;
ALTER TABLE requisition ADD UNIQUE (staffid); 

CREATE TABLE questions(questionsid int PRIMARY KEY, question VARCHAR (255));

CREATE TABLE public.userquestions(
    userquestionsid integer NOT NULL PRIMARY KEY,
    systemuserid bigint REFERENCES public.systemuser (systemuserid),
    questionsid integer REFERENCES public.questions (questionsid),
    answer character varying(255),
    UNIQUE(systemuserid, questionsid)
);

CREATE OR REPLACE VIEW personview AS
SELECT pn.personid,
		pn.firstname,
		pn.lastname,
        pn.othernames,
        pn.facilityid,
        stf.staffid,
        stf.staffno,
        stf.designationid,
        sfu.facilityunitid,
        fu.facilityunitname,
        des.designationname,
        su.username,
        su.active
        
        
   FROM person pn
   	JOIN staff stf ON(pn.personid=stf.personid)
    JOIN store.stafffacilityunit sfu ON (stf.staffid=sfu.staffid)
    JOIN facilityunit fu ON (sfu.facilityunitid=fu.facilityunitid)
    JOIN designation des ON (stf.designationid=des.designationid)
    JOIN systemuser su ON (pn.personid=su.personid);
select * from personview;

CREATE OR REPLACE VIEW facilityunits AS
SELECT st.staffid,
sfu.facilityunitid,
sfu.active,
fu.facilityunitname
FROM staff st
JOIN controlpanel.stafffacilityunit sfu ON (st.staffid=sfu.staffid)
JOIN facilityunit fu ON (sfu.facilityunitid=fu.facilityunitid);

ALTER TABLE person ADD COLUMN registeredby Integer REFERENCES person(personid);
ALTER TABLE person ALTER COLUMN gender DROP not null;
ALTER TABLE person ALTER COLUMN dob DROP not null;
ALTER TABLE person ALTER COLUMN estimatedage DROP not null;
ALTER TABLE person ALTER COLUMN estimated DROP not null;
ALTER TABLE person DROP COLUMN registeredby;

CREATE OR REPLACE VIEW store.orderitemsview AS
SELECT fo.facilityorderid,
		fo.facilityorderno,
		fo.status,
        fo.ordertype,
        foi.pickedby,
        foi.itemid,
        foi.qtyordered,
        foi.qtyapproved
   FROM store.facilityorder fo 
   JOIN store.facilityorderitems foi ON(fo.facilityorderid=foi.facilityorderid)
   WHERE fo.status='SERVICED' AND fo.ordertype='INTERNAL';

ALTER TABLE store.facilityorderitems ADD COLUMN batchno VARCHAR(255);
ALTER TABLE systemuser DROP COLUMN secretquestion;
ALTER TABLE systemuser DROP COLUMN secretanswer;
ALTER TABLE deviceregistrationrequest ADD COLUMN mac_address VARCHAR(255);

ALTER TABLE accessdevice.computerloghistory DROP COLUMN gateway;
ALTER TABLE accessdevice.computerloghistory ADD COLUMN gateway VARCHAR(255);

ALTER TABLE accessdevice.deviceregistrationrequest DROP COLUMN facilityid ;
ALTER TABLE accessdevice.deviceregistrationrequest ADD COLUMN facilityid BIGINT;

ALTER TABLE accessdevice.deviceregistrationrequest DROP COLUMN devicemanufacturerid ;
ALTER TABLE accessdevice.deviceregistrationrequest ADD COLUMN devicemanufacturerid BIGINT;

CREATE OR REPLACE VIEW assetsmanager.facilitylocations AS
SELECT b.buildingid,
		b.buildingname,
		b.facilityid,
        fb.facilityblockid,
        fb.blockname,
        bf.blockfloorid,
        bf.floorname,
		br.blockroomid,
		br.roomname,
		br.status,
		furoom.facilityunitroomid,
		furoom.roomstatus,
		furoom.facilityunitid
   FROM assetsmanager.building b 
   JOIN assetsmanager.facilityblock fb ON(b.buildingid=fb.buildingid)
   JOIN assetsmanager.Blockfloor bf ON(bf.facilityblockid=fb.facilityblockid)
   JOIN assetsmanager.Blockroom br ON(br.blockfloorid=bf.blockfloorid)
   JOIN assetsmanager.Facilityunitroom furoom ON(furoom.blockroomid=br.blockroomid)
    WHERE furoom.roomstatus='UNASSIGNED';
   
      
ALTER TABLE patient.patientvisit ADD COLUMN visitnumber VARCHAR(255);

CREATE TABLE store.package
(
    packageid integer NOT NULL,
    packetno integer,
    eachpacket integer,
    status varchar(255),
    datecreated date,
    createdby bigint,
    stockid bigint,
    CONSTRAINT package_pkey PRIMARY KEY (packageid),
    CONSTRAINT package_stockid_fkey FOREIGN KEY (stockid)
        REFERENCES store.stock (stockid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

ALTER TABLE store.package ADD COLUMN packagedby Integer REFERENCES staff(staffid);
ALTER TABLE store.package ADD COLUMN datepackaged  date;

CREATE SEQUENCE store.package_packageid_seq
INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE store.package ALTER COLUMN packageid SET DEFAULT nextval('store.package_packageid_seq'::regclass);


ALTER TABLE store.package ADD COLUMN updatedby bigint;
ALTER TABLE store.package ADD COLUMN dateupdated DATE;

CREATE TABLE store.readypackets
(
    readypacketsid bigint NOT NULL,
    referencenumber varchar(255),
    status varchar(255),
    CONSTRAINT readypacketsid_pkey PRIMARY KEY (readypacketsid),
    packageid bigint REFERENCES store.package(packageid),
    stockid bigint REFERENCES store.stock(stockid),
    packagedby bigint REFERENCES public.staff(staffid),
    updatedby bigint REFERENCES public.staff(staffid),
    datepackaged DATE
   
)
ALTER TABLE store.readypackets ALTER COLUMN readypacketsid SET DEFAULT nextval('store.readypackets_readypacketsid_seq'::regclass);
CREATE SEQUENCE store.store.readypackets_readypacketsid_seq
INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER TABLE store.package ADD COLUMN totalqtypicked INTEGER;
ALTER TABLE store.readypackets ADD COLUMN batches VARCHAR (255);
ALTER TABLE store.readypackets ADD COLUMN dispensingstatus boolean default false;

ALTER TABLE store.package DROP COLUMN itemid;
ALTER TABLE store.package ADD COLUMN stockid bigint;
ALTER TABLE store.readypackets DROP COLUMN stockid;

ALTER TABLE store."package" ALTER COLUMN packageid SET DEFAULT nextval('store.packages_packagesid_seq'::regclass);

CREATE SEQUENCE contactdetails_contactdetailsid_seq
INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE "contactdetails" ALTER COLUMN contactdetailsid SET DEFAULT nextval('contactdetails_contactdetailsid_seq'::regclass);
ALTER TABLE patient.triage ADD wfazscore varchar(255);
ALTER TABLE patient.triage ADD hfazscore varchar(255);
ALTER TABLE patient.triage ADD wfhzscore varchar(255);
ALTER TABLE patient.triage ADD muac INTEGER;
ALTER TABLE patient.triage ADD bmi varchar(255);

CREATE TABLE patient.zscores
(
    zscoresid bigint NOT NULL,
    weightforage varchar(255),
    heightforage varchar(255),
    weightforheight varchar(255),
   	bmi varchar(255),
	triageid bigint,
CONSTRAINT zscores_pkey PRIMARY KEY (zscoresid)
)
CREATE SEQUENCE patient.zscores_zscoresid_seq
ALTER TABLE patient.zscores ALTER COLUMN zscoresid SET DEFAULT nextval('patient.zscores_zscoresid_seq'::regclass);

ALTER TABLE patient.triage DROP wfazscore;
ALTER TABLE patient.triage DROP hfazscore;
ALTER TABLE patient.triage DROP wfhzscore;

ALTER TABLE patient.triage DROP bmi;
