/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  RESEARCH
 * Created: Jul 2, 2009
 */

ALTER TABLE public.queuetype ADD COLUMN queuestatus boolean;

/*NEW 16TH/JULY/2018*/

ALTER TABLE assetsmanager.building ADD PRIMARY KEY (buildingid);
ALTER TABLE assetsmanager.facilityblock ADD PRIMARY KEY (facilityblockid);
ALTER TABLE assetsmanager.assetclassification ADD PRIMARY KEY (assetclassificationid);
ALTER TABLE assetsmanager.assets ADD PRIMARY KEY (assetsid);
ALTER TABLE public.designationcategory ADD PRIMARY KEY (designationcategoryid);
ALTER TABLE public.designation ADD PRIMARY KEY (designationid);

CREATE SEQUENCE assetsmanager.building_buildingid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE assetsmanager.building ALTER COLUMN buildingid SET DEFAULT nextval('assetsmanager.building_buildingid_seq'::regclass);

CREATE SEQUENCE assetsmanager.facilityblock_facilityblockid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE assetsmanager.facilityblock ALTER COLUMN facilityblockid SET DEFAULT nextval('assetsmanager.facilityblock_facilityblockid_seq'::regclass);

CREATE SEQUENCE assetsmanager.blockfloor_blockfloorid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE assetsmanager.blockfloor ALTER COLUMN blockfloorid SET DEFAULT nextval('assetsmanager.blockfloor_blockfloorid_seq'::regclass);
CREATE SEQUENCE assetsmanager.blockroom_blockroomid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE assetsmanager.blockroom ALTER COLUMN blockroomid SET DEFAULT nextval('assetsmanager.blockroom_blockroomid_seq'::regclass);

DROP TABLE public.buildingroom;






CREATE TABLE public.unallocated(unallocatedid int PRIMARY KEY, previoustable text, rowid int references public.designation(designationid),dateadded date, addedby bigint);
ALTER TABLE public.designation DROP COLUMN transferstatus;
ALTER TABLE public.designation DROP COLUMN deletestatus; 
ALTER TABLE public.designation DROP COLUMN universaldeletestatus;  
ALTER TABLE public.designation DROP COLUMN universaltransferstatus; 
ALTER TABLE public.designation ADD COLUMN transferstatus varchar DEFAULT 'ALLOCATED'; 
ALTER TABLE public.designationcategory ADD COLUMN deletestatus varchar DEFAULT 'NOTDELETED'; 
ALTER TABLE public.designation ADD COLUMN universaltransferstatus varchar default 'ASSIGNED';
ALTER TABLE public.designationcategory ADD COLUMN universaldeletestatus varchar default 'NOTDELETED';
CREATE TABLE public.facilitydesignations(facilitydesignationsid int PRIMARY KEY, designationid int references public.designation(designationid), designationcategoryid int references public.designationcategory(designationcategoryid));
ALTER TABLE public.facilitydesignations ADD COLUMN facilityid int references public.facility(facilityid);
CREATE SEQUENCE public.facilitydesignations_facilitydesignationsid_seq
    INCREMENT 1
    START 2
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE public.facilitydesignations ALTER COLUMN facilitydesignationsid SET DEFAULT nextval('public.facilitydesignations_facilitydesignationsid_seq'::regclass);



CREATE OR REPLACE VIEW  public.facilitydesignationview AS SELECT dc.designationcategoryid,
	dc.categoryname,
    dc.universaldeletestatus,
	dc.deletestatus,
	dg.designationid,
	dg.designationname,
	dg.transferstatus,
	dg.universaltransferstatus,
	fg.facilitydesignationsid,
	fg.facilityid
   FROM public.designationcategory dc
     JOIN public.designation dg ON dc.designationcategoryid = dg.designationcategoryid
     JOIN public.facilitydesignations fg ON dg.designationid = fg.designationid;

ALTER TABLE public.facilitydesignations ADD COLUMN addedby bigint;
ALTER TABLE public.facilitydesignations ADD COLUMN dateadded date;