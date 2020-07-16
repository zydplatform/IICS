/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Mar 22, 2018
 */

CREATE SCHEMA store;

ALTER TABLE item SET SCHEMA store;

ALTER TABLE itemcategorisation DROP COLUMN itemcode;
ALTER TABLE itemcategorisation DROP COLUMN tradename;
ALTER TABLE itemcategorisation DROP COLUMN supplierprice;
ALTER TABLE itemcategorisation SET SCHEMA store;

ALTER TABLE itemcategory DROP COLUMN supplier;
ALTER TABLE itemcategory SET SCHEMA store;

ALTER TABLE itemclassification DROP COLUMN supplierid;
ALTER TABLE itemclassification DROP COLUMN suppliesitemconvention;
ALTER TABLE itemclassification SET SCHEMA store;

ALTER TABLE store.item ADD COLUMN isactive boolean DEFAULT true;
ALTER TABLE store.itemcategorisation ADD COLUMN isactive boolean DEFAULT true;
ALTER TABLE store.itemcategory ADD COLUMN isactive boolean DEFAULT true;
ALTER TABLE store.itemclassification ADD COLUMN isactive boolean DEFAULT true;

ALTER TABLE itemform SET SCHEMA store;
ALTER TABLE itemadministeringtype SET SCHEMA store;

CREATE OR REPLACE VIEW store.itemcategories AS SELECT i.itemid,
    i.itemcode,
    i.genericname,
    i.packsize,
    i.itemformid,
    i.itemadministeringtypeid,
    i.isactive,
    ic.itemcategoryid,
    c.categoryname,
    c.itemclassificationid,
    cl.classificationname,
    itf.formname,
    a.typename,
    concat(i.genericname,
        CASE
            WHEN i.specification IS NULL THEN concat(' ', i.itemstrength, ' ', i.itemform)
            WHEN i.specification IS NOT NULL THEN concat(' ', i.specification)
            ELSE NULL::text
        END
    ) AS fullname,
    i.itemstrength,
    i.itemform,
    i.issupplies,
    i.specification,
    cl.isdeleted AS classificationisdeleted,
    i.isdeleted AS itemisdeleted
    FROM store.item i
        JOIN store.itemcategorisation ic ON i.itemid = ic.itemid
        JOIN store.itemcategory c ON ic.itemcategoryid = c.itemcategoryid
        JOIN store.itemclassification cl ON c.itemclassificationid = cl.itemclassificationid
        JOIN store.itemform itf ON i.itemformid = itf.itemformid
        JOIN store.itemadministeringtype a ON i.itemadministeringtypeid = a.administeringtypeid;

CREATE SEQUENCE store.supplier_supplierid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE store.supplier(
    supplierid bigint PRIMARY KEY DEFAULT nextval('store.supplier_supplierid_seq'::regclass),
    suppliername text,
    suppliercode text,
    transactions text COLLATE pg_catalog."default",
    villageid integer REFERENCES public.village(villageid),
    physicaladdress text,
    postaladdress text,
    emailaddress text,
    officetel varchar(255),
    fax varchar(255),
    active boolean NOT NULL DEFAULT true
);

CREATE SEQUENCE store.suppliercontactperson_suppliercontactpersonid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE store.suppliercontactperson(
    suppliercontactpersonid bigint PRIMARY KEY DEFAULT nextval('store.suppliercontactperson_suppliercontactpersonid_seq'::regclass),
    personid bigint REFERENCES public.person(personid),
    supplierid bigint REFERENCES store.supplier(supplierid),
    personRole text,
    mobile varchar(255),
    emailaddress varchar(255),
    active boolean NOT NULL DEFAULT true
);

CREATE VIEW locations AS SELECT v.villageid,
    v.villagename,
    p.parishid,
    p.parishname,
    s.subcountyid,
    s.subcountyname,
    c.countyid,
    c.countyname,
    d.districtid,
    d.districtname,
    r.regionid,
    r.regionname
    FROM village v
        JOIN parish p ON v.parishid = p.parishid
        JOIN subcounty s ON p.subcountyid = s.subcountyid
        JOIN county c ON s.countyid = c.countyid
        JOIN district d ON c.districtid = d.districtid
        JOIN region r ON d.regionid = r.regionid;

ALTER TABLE store.supplier ADD COLUMN operations VARCHAR(255);

CREATE SEQUENCE store.supplieritem_supplieritemid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    
CREATE TABLE store.supplieritem(
    supplieritemid bigint PRIMARY KEY DEFAULT nextval('store.supplieritem_supplieritemid_seq'::regclass),
    supplierid bigint REFERENCES store.supplier(supplierid),
    itemid bigint references store.item(itemid),
    packsize int,
    itemcost float
);

CREATE OR REPLACE VIEW store.supplieritemcategories AS SELECT si.supplieritemid,
    si.supplierid,
    si.itemid,
    si.itemcode,
    ic.genericname,
    si.packsize,
    si.itemcost,
    ic.isactive,
    ic.itemcategoryid,
    ic.categoryname,
    ic.itemclassificationid,
    ic.classificationname,
    si.isrestricted,
    si.tradename,
    ic.fullname
   FROM store.supplieritem si
        JOIN store.itemcategories ic ON si.itemid = ic.itemid;

ALTER TABLE stock SET SCHEMA store;
ALTER TABLE store.stock DROP COLUMN issuedby;
ALTER TABLE store.stock DROP COLUMN requisitionno;
ALTER TABLE store.stock DROP COLUMN stockbalance;
ALTER TABLE store.stock DROP COLUMN emergencyorder;
ALTER TABLE store.stock DROP COLUMN originid;
ALTER TABLE store.stock DROP COLUMN destinationid;
ALTER TABLE store.stock DROP COLUMN orderingstock;
ALTER TABLE store.stock DROP COLUMN isshelved;
ALTER TABLE store.stock DROP COLUMN pickliststock;
ALTER TABLE store.stock DROP COLUMN bookedstock;
ALTER TABLE store.stock DROP COLUMN issuedstock;
ALTER TABLE store.stock DROP COLUMN pickedstock;
ALTER TABLE store.stock DROP COLUMN servicedstock;
ALTER TABLE store.stock DROP COLUMN recievingstore;
ALTER TABLE store.stock DROP COLUMN supplyingstore;

ALTER TABLE store.stock ADD COLUMN stocktaken boolean DEFAULT false;

CREATE SEQUENCE store.shelfstock_shelfstockd_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    
CREATE TABLE store.shelfstock(
    shelfstockid bigint PRIMARY KEY DEFAULT nextval('store.shelfstock_shelfstockd_seq'::regclass),
    stockid bigint REFERENCES store.stock(stockid),
    cellid integer REFERENCES store.bayrowcell(bayrowcellid),
    quantityshelved integer,
    isstocktaken boolean default false
);

ALTER TABLE store.stock ADD COLUMN facilityunitid bigint REFERENCES public.facilityunit(facilityunitid);
ALTER TABLE store.stock ADD COLUMN suppliertype varchar(255);
ALTER TABLE store.stock ADD COLUMN supplierid bigint;
ALTER TABLE store.stock ADD COLUMN issuedby bigint REFERENCES public.staff (staffid);
ALTER TABLE store.stock ADD COLUMN dateadded date DEFAULT now();

ALTER TABLE store.stock ALTER COLUMN quantityrecieved TYPE INT USING quantityrecieved::integer;
CREATE OR REPLACE VIEW store.facilityunitstock AS SELECT s.stockid,
    s.itemid,
    ic.genericname,
    ic.isactive,
    ic.itemcategoryid,
    ic.itemclassificationid,
    s.daterecieved,
    s.quantityrecieved,
    date_part('DAY'::text, s.expirydate::timestamp with time zone - now())::integer AS daystoexpire,
    s.batchnumber,
    s.facilityunitid,
    s.suppliertype,
    s.supplierid,
    s.issuedby,
    s.dateadded,
    s.shelvedstock,
    s.expirydate,
    ic.categoryname,
    ic.classificationname,
    s.stockissued,
    s.recievedby,
    ic.fullname
    FROM store.stock s
        JOIN store.itemcategories ic ON s.itemid = ic.itemid;

CREATE OR REPLACE FUNCTION store.countShelvedStock(stockid integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
	AS $BODY$
            DECLARE
            qty integer;
            BEGIN
                SELECT sum(quantityshelved) INTO qty FROM store.shelfstock where stockid=stockid;
   	RETURN pin;
    END;
$BODY$;

ALTER TABLE store.stock ADD COLUMN expires boolean default false;
ALTER TABLE store.stock DROP CONSTRAINT fk68af716232b8607;
ALTER TABLE store.stock DROP CONSTRAINT fk68af716eda962fa;
ALTER TABLE store.stock ADD COLUMN shelvedstock integer default 0;

ALTER TABLE store.shelfstock ADD COLUMN updatedby integer REFERENCES public.staff(staffid);
ALTER TABLE store.shelfstock ADD COLUMN dateupdated date DEFAULT now();

CREATE VIEW store.celltotal AS
    SELECT cellid, SUM(quantityshelved)
    FROM store.Shelfstock GROUP BY cellid;

CREATE VIEW store.cellitems AS SELECT us.zonelabel,
    us.zoneid,
    us.baylabel,
    us.zonebayid,
    us.bayrowid,
    us.rowlabel,
    us.bayrowcellid,
    us.celllabel,
    ss.shelfstockid,
    ss.quantityshelved,
    fs.stockid,
    fs.itemid,
    fs.genericname,
    fs.daystoexpire,
    fs.batchnumber,
    fs.expirydate,
    ss.facilityunitid,
    fs.categoryname,
    fs.classificationname,
    us.cellstate,
    fs.fullname
    FROM store.unitstoragezones us JOIN store.shelfstock ss ON(us.bayrowcellid=ss.cellid)
    JOIN store.facilityunitstock fs ON(ss.stockid=fs.stockid);

CREATE SEQUENCE store.unitcatalogueitem_unitcatalogueitemid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    
CREATE TABLE store.unitcatalogueitem(
    unitcatalogueitemid bigint primary key default nextval('store.unitcatalogueitem_unitcatalogueitemid_seq'::regclass),
    facilityunitid bigint REFERENCES public.facilityunit(facilityunitid),
    itemid bigint REFERENCES store.item(itemid),
    catitemstatus varchar(255),
    isactive boolean default false,
    dateadded date,
    dateupdated date,
    updatedby bigint REFERENCES public.staff(staffid)
);

CREATE VIEW store.unitcatalogue AS SELECT uc.unitcatalogueitemid,
    ic.itemid,
    ic.itemcode,
    ic.genericname,
    f.formname,
    ic.itemformid,
    ic.itemcategoryid,
    ic.categoryname,
    ic.itemclassificationid,
    ic.classificationname,
    uc.facilityunitid,
    uc.catitemstatus,
    uc.isactive,
    fu.facilityid,
    ic.fullname,
    ic.itemstrength,
    ic.itemform,
    ic.issupplies,
    ic.specification
    FROM store.itemcategories ic
        JOIN store.unitcatalogueitem uc ON ic.itemid = uc.itemid
        JOIN store.itemform f ON ic.itemformid = f.itemformid
        JOIN public.facilityunit fu ON(uc.facilityunitid = fu.facilityunitid)
            WHERE ic.isactive = true;

CREATE VIEW store.facilitycatalogueitem AS SELECT 
    facilityid, 
    itemid,
    formname
    FROM store.unitcatalogue 
        where catitemstatus='APPROVED' 
            group by facilityid,itemid,formname;

CREATE VIEW store.facilitycatalogue AS SELECT 
    fi.facilityid,
    fi.itemid,
    ic.genericname,
    ic.itemformid,
    ic.itemcategoryid,
    ic.categoryname,
    ic.itemclassificationid,
    ic.classificationname,
    fi.formname,
    ic.itemstrength,
    ic.itemform,
    ic.issupplies,
    ic.specification,
    ic.fullname
    FROM store.facilitycatalogueitem  fi
        JOIN store.itemcategories ic ON(fi.itemid = ic.itemid);

ALTER TABLE store.stock ADD COLUMN stockissued integer DEFAULT 0;

DROP VIEW store.facilitycatalogue;

DROP VIEW store.facilitycatalogueitem;

DROP VIEW store.unitcatalogue;

DROP TABLE store.unitcatalogueitem;

CREATE SEQUENCE store.stockactivity_stockactivityid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE SEQUENCE store.activitycell_activitycellid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE SEQUENCE store.activitycellitem_activitycellitemid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE store.stockactivity(
    stockactivityid BIGINT PRIMARY KEY DEFAULT nextval('store.stockactivity_stockactivityid_seq'::regclass),
    activityname VARCHAR(255),
    startdate date,
    enddate date,
    addedby BIGINT REFERENCES public.staff(staffid),
    dateadded date,
    dateupdated date,
    updatedby BIGINT REFERENCES public.staff(staffid),
    facilityunitid BIGINT REFERENCES public.facilityunit(facilityunitid)
);

CREATE TABLE store.activitycell(
    activitycellid BIGINT PRIMARY KEY DEFAULT nextval('store.activitycell_activitycellid_seq'::regclass),
    cellid integer REFERENCES store.bayrowcell(bayrowcellid),
    cellstaff BIGINT REFERENCES public.systemuser(systemuserid),
    activitystatus VARCHAR(255),
    addedby BIGINT REFERENCES public.staff(staffid),
    dateadded date,
    dateupdated date,
    updatedby BIGINT REFERENCES public.staff(staffid),
    stockactivityid BIGINT REFERENCES store.stockactivity(stockactivityid)
);
    
CREATE TABLE store.activitycellitem(
    activitycellitemid BIGINT PRIMARY KEY DEFAULT nextval('store.activitycellitem_activitycellitemid_seq'::regclass),
    activitycellid BIGINT REFERENCES store.activitycell(activitycellid),
    itemid BIGINT REFERENCES store.item(itemid),
    actualstock integer,
    countedstock integer
);

CREATE VIEW public.searchstaff AS SELECT s.staffid,
    s.personid,
    s.designationid,
    s.staffno,
    s.computerno,
    s.currentfacility,
    s.isexternal,
    p.firstname,
    p.othernames,
    p.lastname,
    p.dob,
    p.gender,
    d.designationname,
    LOWER(CONCAT(firstname,lastname,othernames)) as permutation1,
    LOWER(CONCAT(lastname,othernames,firstname)) as permutation2,
    LOWER(CONCAT(lastname,firstname)) as permutation3
    FROM public.staff s 
    JOIN public.person p ON s.personid = p.personid 
    JOIN public.designation d ON(d.designationid = s.designationid);


ALTER TABLE store.activitycell DROP CONSTRAINT activitycell_cellstaff_fkey;
ALTER TABLE store.activitycell ADD CONSTRAINT activitycell_cellstaff_fkey FOREIGN KEY (cellstaff) REFERENCES public.staff (staffid);

ALTER TABLE store.supplier ADD COLUMN tin varchar(255);
ALTER TABLE store.supplieritem ADD COLUMN itemcode text;
ALTER TABLE store.supplieritem ADD COLUMN isrestricted boolean DEFAULT false;
ALTER TABLE store.supplieritem ADD COLUMN tradename varchar(255);

DELETE FROM store.itemcategorisation WHERE itemcategoryid = 19
    OR (itemcategoryid >= 31 AND itemcategoryid <= 62)
    OR (itemcategoryid >= 177 AND itemcategoryid <= 181);
DELETE FROM store.itemcategory WHERE itemclassificationid != 3 
    AND itemclassificationid != 11 
    AND itemclassificationid != 12 
    AND itemclassificationid != 13;
DELETE FROM store.itemclassification WHERE itemclassificationid != 3 
    AND itemclassificationid != 11
    AND itemclassificationid != 12
    AND itemclassificationid != 13;

INSERT INTO store.supplieritem (itemid, packsize, itemcost, itemcode, isrestricted) 
	SELECT i.itemid, i.packsize, i.unitcost, i.itemcode, i.restricted FROM store.item i;
    
UPDATE store.supplieritem SET supplierid = 3210;

ALTER TABLE store.activitycellitem ADD COLUMN status varchar(255) DEFAULT 'counted';
ALTER TABLE store.activitycellitem ADD COLUMN batchnumber varchar(255);
ALTER TABLE store.activitycellitem ADD COLUMN expirydate date DEFAULT now();
ALTER TABLE store.activitycellitem DROP COLUMN actualstock;
ALTER TABLE store.activitycellitem ADD COLUMN dateadded TIMESTAMP DEFAULT now();
ALTER TABLE store.activitycell ADD COLUMN recount BOOLEAN DEFAULT false;

CREATE SEQUENCE store.recount_recountid_seq;
CREATE SEQUENCE store.recountitem_recountitemid_seq;
CREATE TABLE store.recount(recountid bigint PRIMARY KEY DEFAULT nextval('store.recount_recountid_seq'::regclass), itemid bigint REFERENCES store.item(itemid), activitycellid bigint REFERENCES store.activitycell(activitycellid), staff bigint REFERENCES public.staff(staffid), status varchar(255));
CREATE TABLE store.recountitem(recountitemid bigint PRIMARY KEY DEFAULT nextval('store.recountitem_recountitemid_seq'::regclass), recountid bigint REFERENCES store.recount(recountid), countedstock integer, status VARCHAR(255) DEFAULT 'PENDING', batchnumber VARCHAR(255), expirydate date DEFAULT now(), dateadded timestamp DEFAULT now());
ALTER TABLE store.recount ADD COLUMN issuedby bigint REFERENCES public.staff(staffid);
ALTER TABLE store.recount ADD COLUMN dateissued date default now();
ALTER TABLE store.activitycell ADD COLUMN closed boolean DEFAULT false;
ALTER TABLE store.activitycell ADD COLUMN closedby bigint REFERENCES staff(staffid);
ALTER TABLE store.recount ADD COLUMN dateupdated date DEFAULT now();
ALTER TABLE store.recount ADD COLUMN reviewed boolean DEFAULT false;
ALTER TABLE store.recount ADD COLUMN reviewedby bigint references public.staff(staffid);

CREATE OR REPLACE VIEW store.itemrecount AS SELECT r.recountid,
    r.itemid,
    r.staff,
    r.status,
    r.issuedby,
    r.dateissued,
    r.dateupdated,
    r.reviewed,
    r.reviewedby,
    ac.activitycellid,
    ac.cellid,
    ac.stockactivityid
    FROM store.recount r
        JOIN store.activitycell ac ON(r.activitycellid = ac.activitycellid);

CREATE SEQUENCE store.shelflog_shelflogid_seq;
CREATE TABLE store.shelflog(
    shelflogid bigint PRIMARY KEY DEFAULT nextval('store.shelflog_shelflogid_seq'::regclass),
    cellid bigint references store.bayrowcell(bayrowcellid),
    stockid bigint references store.stock(stockid),
    logtype varchar(255),
    quantity integer,
    staffid bigint references public.staff(staffid),
    datelogged timestamp default now()
);

CREATE OR REPLACE VIEW store.shelflogstock AS SELECT sf.shelflogid,
    sf.cellid,
    sf.stockid,
    sf.logtype,
    sf.quantity,
    sf.staffid,
    sf.datelogged,
    fus.itemid,
    fus.genericname,
    fus.batchnumber,
    fus.facilityunitid,
    fus.expirydate,
    fus.daystoexpire,
    fus.fullname
    FROM store.shelflog sf
    JOIN store.facilityunitstock fus ON(sf.stockid = fus.stockid);

CREATE OR REPLACE VIEW store.stockcount AS SELECT activitycellitemid,
    aci.itemid,
    aci.countedstock,
    aci.batchnumber,
    aci.dateadded,
    ac.stockactivityid,
    ic.genericname,
    aci.activitycellid,
    ac.cellstaff,
    ac.cellid,
    ic.fullname
    FROM store.activitycellitem aci
    JOIN store.activitycell ac ON(aci.activitycellid = ac.activitycellid)
    JOIN store.itemcategories ic ON(aci.itemid = ic.itemid);

CREATE SEQUENCE store.activityfollowup_activityfollowupid_seq;
CREATE TABLE store.activityfollowup(
    activityfollowupid bigint PRIMARY KEY default nextval('store.activityfollowup_activityfollowupid_seq'::regclass),
    itemid bigint REFERENCES store.item(itemid),
    stockactivityid bigint REFERENCES store.stockactivity(stockactivityid),
    batchno varchar(255),
    followupaction varchar(255),
    followupcomment text
);

UPDATE store.item set itemformid=19;
UPDATE store.item set itemadministeringtypeid=1;
ALTER TABLE store.item ALTER itemformid SET DEFAULT 19;
ALTER TABLE store.item ALTER itemadministeringtypeid SET DEFAULT 1;

ALTER TABLE public.contactdetails SET SCHEMA backup;
ALTER TABLE public.countrycurrency SET SCHEMA backup;
ALTER TABLE public.county SET SCHEMA backup;
ALTER TABLE public.ctrycurrency SET SCHEMA backup;
ALTER TABLE public.currencyrates SET SCHEMA backup;
ALTER TABLE public.designation SET SCHEMA backup;
ALTER TABLE public.designationcategory SET SCHEMA backup;
ALTER TABLE public.district SET SCHEMA backup;
ALTER TABLE public.entitydescription SET SCHEMA backup;
ALTER TABLE public.entityleveldescription SET SCHEMA backup;
ALTER TABLE public.facility SET SCHEMA backup;
ALTER TABLE public.facilityassignedpolicy SET SCHEMA backup;
ALTER TABLE public.facilitydomain SET SCHEMA backup;
ALTER TABLE public.facilitylevel SET SCHEMA backup;
ALTER TABLE public.facilityowner SET SCHEMA backup;
ALTER TABLE public.facilitypolicy SET SCHEMA backup;
ALTER TABLE public.facilitypolicyoptions SET SCHEMA backup;
ALTER TABLE public.facilitystructure SET SCHEMA backup;
ALTER TABLE public.facilityunit SET SCHEMA backup;
ALTER TABLE public.facilityunits SET SCHEMA backup;
ALTER TABLE public.location SET SCHEMA backup;
ALTER TABLE public.locations SET SCHEMA backup;
ALTER TABLE public.nextofkin SET SCHEMA backup;
ALTER TABLE public.parish SET SCHEMA backup;
ALTER TABLE public.person SET SCHEMA backup;
ALTER TABLE public.personview SET SCHEMA backup;
ALTER TABLE public.questions SET SCHEMA backup;
ALTER TABLE public.queuetype SET SCHEMA backup;
ALTER TABLE public.region SET SCHEMA backup;
ALTER TABLE public.requisition SET SCHEMA backup;
ALTER TABLE public.searchstaff SET SCHEMA backup;
ALTER TABLE public.staff SET SCHEMA backup;
ALTER TABLE public.subcounty SET SCHEMA backup;
ALTER TABLE public.systemrole SET SCHEMA backup;
ALTER TABLE public.systemrolefacility SET SCHEMA backup;
ALTER TABLE public.systemuser SET SCHEMA backup;
ALTER TABLE public.userquestions SET SCHEMA backup;
ALTER TABLE public.village SET SCHEMA backup;
ALTER TABLE public.worldcountries SET SCHEMA backup;
DO $$ DECLARE
    tabname RECORD;
BEGIN
    FOR tabname IN (SELECT tablename 
        FROM pg_tables 
            WHERE schemaname = 'public')
    LOOP
        EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(tabname.tablename) || ' CASCADE';
    END LOOP;
END $$;
ALTER TABLE backup.contactdetails SET SCHEMA public;
ALTER TABLE backup.countrycurrency SET SCHEMA public;
ALTER TABLE backup.county SET SCHEMA public;
ALTER TABLE backup.ctrycurrency SET SCHEMA public;
ALTER TABLE backup.currencyrates SET SCHEMA public;
ALTER TABLE backup.designation SET SCHEMA public;
ALTER TABLE backup.designationcategory SET SCHEMA public;
ALTER TABLE backup.district SET SCHEMA public;
ALTER TABLE backup.entitydescription SET SCHEMA public;
ALTER TABLE backup.entityleveldescription SET SCHEMA public;
ALTER TABLE backup.facility SET SCHEMA public;
ALTER TABLE backup.facilityassignedpolicy SET SCHEMA public;
ALTER TABLE backup.facilitydomain SET SCHEMA public;
ALTER TABLE backup.facilitylevel SET SCHEMA public;
ALTER TABLE backup.facilityowner SET SCHEMA public;
ALTER TABLE backup.facilitypolicy SET SCHEMA public;
ALTER TABLE backup.facilitypolicyoptions SET SCHEMA public;
ALTER TABLE backup.facilitystructure SET SCHEMA public;
ALTER TABLE backup.facilityunit SET SCHEMA public;
ALTER TABLE backup.facilityunits SET SCHEMA public;
ALTER TABLE backup.location SET SCHEMA public;
ALTER TABLE backup.locations SET SCHEMA public;
ALTER TABLE backup.nextofkin SET SCHEMA public;
ALTER TABLE backup.parish SET SCHEMA public;
ALTER TABLE backup.person SET SCHEMA public;
ALTER TABLE backup.personview SET SCHEMA public;
ALTER TABLE backup.questions SET SCHEMA public;
ALTER TABLE backup.queuetype SET SCHEMA public;
ALTER TABLE backup.region SET SCHEMA public;
ALTER TABLE backup.requisition SET SCHEMA public;
ALTER TABLE backup.searchstaff SET SCHEMA public;
ALTER TABLE backup.staff SET SCHEMA public;
ALTER TABLE backup.subcounty SET SCHEMA public;
ALTER TABLE backup.systemrole SET SCHEMA public;
ALTER TABLE backup.systemrolefacility SET SCHEMA public;
ALTER TABLE backup.systemuser SET SCHEMA public;
ALTER TABLE backup.userquestions SET SCHEMA public;
ALTER TABLE backup.village SET SCHEMA public;
ALTER TABLE backup.worldcountries SET SCHEMA public;

ALTER TABLE store.activityfollowup ADD COLUMN dateadded TIMESTAMP DEFAULT now();
ALTER TABLE store.activityfollowup ADD COLUMN addedby bigint REFERENCES public.staff(staffid);

CREATE VIEW searchfacility AS SELECT f.facilityid,
    f.facilityname,
    f.facilitycode,
    f.shortname,
    f.emailaddress,
    f.phonecontact,
    f.website,
    f.postaddress,
    f.phonecontact2,
    l.villagename,
    l.parishname,
    l.subcountyname,
    l.countyname,
    l.districtname,
    l.regionname,
    fl.shortname AS levelcode,
    fl.facilitylevelname
    FROM public.facility f 
    JOIN public.locations l ON(f.villageid=l.villageid)
    JOIN public.facilitylevel fl ON(f.facilitylevelid=fl.facilitylevelid);

CREATE SEQUENCE store.stocklog_stocklogid_seq;
CREATE TABLE store.stocklog(
    stockflogid bigint PRIMARY KEY DEFAULT nextval('store.stockflog_stockflogid_seq'::regclass),
    stockid bigint REFERENCES store.stock (stockid),
    logtype character varying(255),
    quantity integer,
    staffid bigint REFERENCES public.staff (staffid),
    datelogged timestamp without time zone DEFAULT now()
);

CREATE SEQUENCE patient.facilityvisitno_facilityvisitnoid_seq;
CREATE TABLE patient.facilityvisitno(
    facilityvisitnoid bigint PRIMARY KEY DEFAULT nextval('patient.facilityvisitno_facilityvisitnoid_seq'::regclass),
    facilityunitid bigint references public.facilityunit(facilityunitid),
    currentvalue integer default 1
);

CREATE OR REPLACE FUNCTION patient.nextvisitno(unitid integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    AS $BODY$
        declare
            visitno integer;
        BEGIN
            SELECT currentvalue into visitno FROM patient.facilityvisitno where facilityunitid=unitid;
            UPDATE patient.facilityvisitno set currentvalue=currentvalue + 1 where facilityunitid=unitid;
        RETURN visitno;
    END;
$BODY$;