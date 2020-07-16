/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Aug 11, 2018
 */
ALTER TABLE patient.patientvisit ADD COLUMN visittype varchar(255);
CREATE SEQUENCE patient.medicalissue_medicalissueid_seq;
CREATE TABLE patient.medicalissue(
    medicalissueid bigint PRIMARY KEY DEFAULT nextval('patient.medicalissue_medicalissueid_seq'),
    medicalissuename varchar(255),
    issuedescription text,
    dateadded date default now(),
    addedby bigint references public.staff(staffid)
);
CREATE SEQUENCE patient.patientmedicalissue_patientmedicalissueid_seq;
CREATE TABLE patient.patientmedicalissue(
    patientmedicalissueid bigint PRIMARY KEY DEFAULT nextval('patient.patientmedicalissue_patientmedicalissueid_seq'),
    patientid bigint references patient.patient(patientid),
    medicalissue bigint references patient.medicalissue(medicalissueid),
    medicalissuestate varchar(255),
    dateadded date default now(),
    addedby bigint references public.staff(staffid)
);
ALTER TABLE patient.patientvisit ADD COLUMN facilityunitid bigint REFERENCES public.facilityunit(facilityunitid);

ALTER TABLE patient.patient ADD COLUMN telephone varchar(255);
ALTER TABLE patient.patient ADD COLUMN nextofkinname varchar(255);
ALTER TABLE patient.patient ADD COLUMN relationship varchar(255);
ALTER TABLE patient.patient ADD COLUMN nextofkincontact varchar(255);
DROP VIEW patient.searchpatient;
CREATE OR REPLACE VIEW patient.searchpatient AS SELECT pn.personid,
    pn.firstname,
    pn.lastname,
    pn.othernames,
    pn.facilityid,
    pn.currentaddress,
    pat.patientno,
    pat.patientid,
    pat.telephone,
    concat(pat.relationship, ': ', pat.nextofkinname) AS nextofkin,
    pat.nextofkincontact,
    lower(concat(pn.firstname, pn.lastname, pn.othernames)) AS permutation1,
    lower(concat(pn.lastname, pn.othernames, pn.firstname)) AS permutation2,
    lower(concat(pn.lastname, pn.firstname)) AS permutation3
    FROM person pn
        JOIN patient.patient pat ON pn.personid = pat.personid;

CREATE SEQUENCE patient.patient_patientid_seq;
ALTER TABLE patient.patient ALTER COLUMN patientid SET DEFAULT nextval('patient.patient_patientid_seq');

ALTER TABLE public.facilityunit ADD COLUMN administrative boolean default false;
CREATE SEQUENCE patient.servicequeue_servicequeueid_seq;
CREATE TABLE patient.servicequeue(
    servicequeueid bigint PRIMARY KEY DEFAULT nextval('patient.servicequeue_servicequeueid_seq'),
    unitserviceid bigint references public.facilityunitservice(facilityunitserviceid),
    patientvisitid bigint references patient.patientvisit(patientvisitid),
    timein timestamp DEFAULT now(),
    timeout timestamp,
    addedby bigint references public.staff(staffid),
    serviced boolean DEFAULT false,
    servicedby bigint references public.staff(staffid)
);

CREATE OR REPLACE VIEW patient.patientvisits AS SELECT pv.patientvisitid,
    pv.patientid,
    pv.visitnumber,
    pv.visittype,
    pv.facilityunitid,
    concat(sp.firstname, ' ', sp.lastname, ' ', sp.othernames) AS fullnames
    FROM patient.patientvisit pv JOIN patient.searchpatient sp ON(pv.patientid = sp.patientid);

ALTER TABLE patient.patientvisit ADD COLUMN visitpriority varchar(255);

--Change in stock management
CREATE SEQUENCE store.medicalitem_medicalitemid_seq;
CREATE TABLE store.medicalitem(
    medicalitemid bigint PRIMARY KEY DEFAULT nextval('store.medicalitem_medicalitemid_seq'),
    itemcode text,
    genericname text,
    packsize integer ,
    unitcost double precision,
    itemstrength text,
    itemformid integer,
    itemadministeringtypeid integer,
    itemordertype character varying(255),
    itemusage character varying(255),
    isspecial boolean DEFAULT false,
    restricted boolean NOT NULL DEFAULT false,
    isactive boolean DEFAULT true,
    levelofuse integer,
    itemform character varying(255),
    issupplies boolean,
    specification character varying(255),
    isdeleted boolean DEFAULT false,
    UNIQUE (itemcode),
    CONSTRAINT itemadministeringtypeid FOREIGN KEY (itemadministeringtypeid)
        REFERENCES store.itemadministeringtype (administeringtypeid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT itemformid FOREIGN KEY (itemformid)
        REFERENCES store.itemform (itemformid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
ALTER TABLE store.itemcategorisation drop CONSTRAINT categorisationitemid;
INSERT INTO store.medicalitem(
	medicalitemid,
	itemcode,
	genericname,
	packsize,
	unitcost,
	itemstrength,
	itemformid,
	itemadministeringtypeid,
	itemordertype,
	itemusage,
	isspecial,
	restricted,
	isactive,
	levelofuse,
	itemform,
	issupplies,
	specification,
	isdeleted
)SELECT itemid, itemcode, genericname, packsize, unitcost, itemstrength, itemformid, itemadministeringtypeid, itemordertype, itemusage, isspecial, restricted, isactive, levelofuse, itemform, issupplies, specification, isdeleted FROM store.item;
ALTER TABLE store.itemcategorisation add CONSTRAINT categorisationitemid FOREIGN KEY (itemid) REFERENCES store.medicalitem(medicalitemid);

ALTER TABLE store.medicalitem ALTER COLUMN itemform TYPE character varying;
ALTER TABLE store.medicalitem ALTER COLUMN specification TYPE character varying;
CREATE OR REPLACE VIEW store.itemcategories AS SELECT mi.medicalitemid as itemid,
    mi.itemcode,
    mi.genericname,
    mi.packsize,
    mi.itemformid,
    mi.itemadministeringtypeid,
    mi.isactive,
    ic.itemcategoryid,
    c.categoryname,
    c.itemclassificationid,
    cl.classificationname,
    itf.formname,
    a.typename,
    concat(mi.genericname,
        CASE
            WHEN mi.specification IS NULL THEN concat(' ', mi.itemstrength, ' ', mi.itemform)
            WHEN mi.specification IS NOT NULL THEN concat(' ', mi.specification)
            ELSE NULL
        END
    ) AS fullname,
    mi.itemstrength,
    mi.itemform,
    mi.issupplies,
    mi.specification,
    cl.isdeleted AS classificationisdeleted,
    mi.isdeleted AS itemisdeleted
    FROM store.medicalitem mi
        JOIN store.itemcategorisation ic ON mi.medicalitemid = ic.itemid
        JOIN store.itemcategory c ON ic.itemcategoryid = c.itemcategoryid
        JOIN store.itemclassification cl ON c.itemclassificationid = cl.itemclassificationid
        JOIN store.itemform itf ON mi.itemformid = itf.itemformid
        JOIN store.itemadministeringtype a ON mi.itemadministeringtypeid = a.administeringtypeid;

ALTER TABLE store.itemcategorisation DROP CONSTRAINT fkb2a27aa3eda962fa;
ALTER TABLE store.item DROP CONSTRAINT fk317b132a53b4c4;
ALTER TABLE store.item DROP CONSTRAINT fk317b135fcd5402;
ALTER TABLE store.item DROP CONSTRAINT itemadministeringtypeid;
ALTER TABLE store.item DROP CONSTRAINT itemformid;
ALTER TABLE store.item DROP COLUMN itemcode;
ALTER TABLE store.item DROP COLUMN genericname;
ALTER TABLE store.item DROP COLUMN packsize;
ALTER TABLE store.item DROP COLUMN unitcost;
ALTER TABLE store.item DROP COLUMN itemstrength;
ALTER TABLE store.item DROP COLUMN itemformid;
ALTER TABLE store.item DROP COLUMN itemadministeringtypeid;
ALTER TABLE store.item DROP COLUMN itemordertype;
ALTER TABLE store.item DROP COLUMN itemusage;
ALTER TABLE store.item DROP COLUMN isspecial;
ALTER TABLE store.item DROP COLUMN restricted;
ALTER TABLE store.item DROP COLUMN isactive;
ALTER TABLE store.item DROP COLUMN levelofuse;
ALTER TABLE store.item DROP COLUMN itemform;
ALTER TABLE store.item DROP COLUMN issupplies;
ALTER TABLE store.item DROP COLUMN specification;
ALTER TABLE store.item DROP COLUMN isdeleted;

ALTER TABLE store.item ADD COLUMN medicalitemid bigint REFERENCES store.medicalitem (medicalitemid);
ALTER TABLE store.item ADD COLUMN packagesid bigint REFERENCES store.packages (packagesid);
ALTER TABLE store.item ADD COLUMN qty integer;
ALTER TABLE store.item ADD COLUMN addedby bigint REFERENCES public.staff (staffid);
ALTER TABLE store.item ADD COLUMN dateadded date;
ALTER TABLE store.item ADD COLUMN lastupdate date;
ALTER TABLE store.item ADD COLUMN lastupdatedby bigint REFERENCES public.staff (staffid);
ALTER TABLE store.item ADD COLUMN isactive boolean;


--DROP VIEW store.itempackage;
DROP TABLE store.itempackages;
ALTER TABLE store.item ADD COLUMN measure varchar(255);
ALTER TABLE store.activitycell DROP COLUMN closed;
ALTER TABLE store.activitycell ADD COLUMN closed boolean default false;
ALTER TABLE store.activitycell DROP COLUMN recount;
ALTER TABLE store.activitycell ADD COLUMN recount boolean default false;

INSERT INTO store.item(medicalitemid) SELECT i.medicalitemid FROM store.medicalitem i;
UPDATE store.item SET qty=1;
UPDATE store.item SET packagesid=1;
UPDATE store.item SET dateadded=now();
UPDATE store.item SET addedby=1;
UPDATE store.item SET lastupdate=now();
UPDATE store.item SET lastupdatedby=1;
UPDATE store.item SET isactive=true;

CREATE OR REPLACE VIEW store.itempackage AS SELECT ip.itemid AS itempackageid,
    ic.itemid,
    ic.genericname,
    ic.itemcategoryid,
    ic.categoryname,
    ic.itemclassificationid,
    ic.classificationname,
    ic.fullname,
    ic.itemstrength,
    ic.itemform,
    ic.issupplies,
    ic.specification,
    concat(
        ic.fullname,
        CASE
            WHEN p.packagename='N/A'
            THEN ''
            WHEN p.packagename!='N/A'
            THEN concat(' (', p.packagename, ' of ', ip.qty, ' )')
        END
    ) AS packagename,
    ip.qty AS packagequantity,
    ip.isactive,
    ic.itemformid,
    ic.itemcode,
    p.packagesid,
    p.packagename AS package,
    ip.measure
    FROM store.itemcategories ic
    JOIN store.item ip ON ic.itemid = ip.medicalitemid
    JOIN store.packages p ON ip.packagesid = p.packagesid;

CREATE OR REPLACE VIEW store.facilityunitstock AS SELECT s.stockid,
    s.itemid,
    ip.genericname,
    ip.isactive,
    ip.itemcategoryid,
    ip.itemclassificationid,
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
    ip.categoryname,
    ip.classificationname,
    s.stockissued,
    s.recievedby,
    ip.fullname,
    ip.packagequantity AS packsize,
    ip.packagename
    FROM store.stock s
    JOIN store.itempackage ip ON s.itemid = ip.itempackageid;
--ALTER TABLE store.stock DROP COLUMN packsize;

CREATE OR REPLACE VIEW store.cellitems AS SELECT us.zonelabel,
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
    us.facilityunitid,
    fs.categoryname,
    fs.classificationname,
    us.cellstate,
    fs.fullname,
    fs.packagename
    FROM store.unitstoragezones us JOIN store.shelfstock ss ON(us.bayrowcellid=ss.cellid)
    JOIN store.facilityunitstock fs ON(ss.stockid=fs.stockid);

CREATE OR REPLACE VIEW store.stockcount AS SELECT aci.activitycellitemid,
    aci.itemid,
    aci.countedstock,
    aci.batchnumber,
    aci.dateadded,
    ac.stockactivityid,
    ip.genericname,
    aci.expirydate,
    aci.activitycellid,
    ac.cellstaff,
    ac.cellid,
    ip.fullname,
    ip.packagename,
    ip.packagequantity
    FROM store.activitycellitem aci
    JOIN store.activitycell ac ON aci.activitycellid = ac.activitycellid
    JOIN store.itempackage ip ON aci.itemid = ip.itempackageid;

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
    fus.fullname,
    fus.packagename
    FROM store.shelflog sf
    JOIN store.facilityunitstock fus ON(sf.stockid = fus.stockid);

CREATE OR REPLACE VIEW store.stockcount AS SELECT aci.activitycellitemid,
    aci.itemid,
    aci.countedstock,
    aci.batchnumber,
    aci.dateadded,
    ac.stockactivityid,
    ip.genericname,
    aci.expirydate,
    aci.activitycellid,
    ac.cellstaff,
    ac.cellid,
    ip.fullname,
    ip.packagename,
    ip.packagequantity
    FROM store.activitycellitem aci
        JOIN store.activitycell ac ON aci.activitycellid = ac.activitycellid
        JOIN store.itempackage ip ON aci.itemid = ip.itemid;

CREATE OR REPLACE VIEW store.supplieritemcategories AS SELECT si.supplieritemid,
    si.supplierid,
    si.itemid,
    si.itemcode,
    ip.genericname,
    si.packsize,
    si.itemcost,
    ip.isactive,
    ip.itemcategoryid,
    ip.categoryname,
    ip.itemclassificationid,
    ip.classificationname,
    si.isrestricted,
    si.tradename,
    ip.fullname,
    ip.packagename,
    ip.packagequantity
    FROM store.supplieritem si
        JOIN store.itempackage ip ON si.itemid = ip.itempackageid;

CREATE OR REPLACE VIEW store.unitcatalogue AS SELECT uc.unitcatalogueitemid,
    uc.itemid,
    ip.itemcode,
    ip.genericname,
    f.formname,
    ip.itemformid,
    ip.itemcategoryid,
    ip.categoryname,
    ip.itemclassificationid,
    ip.classificationname,
    uc.facilityunitid,
    uc.catitemstatus,
    uc.isactive,
    fu.facilityid,
    ip.fullname,
    ip.itemstrength,
    ip.itemform,
    ip.issupplies,
    ip.specification,
    ip.packagename,
    ip.packagequantity
    FROM store.itempackage ip
        JOIN store.unitcatalogueitem uc ON ip.itempackageid = uc.itemid
        JOIN store.itemform f ON ip.itemformid = f.itemformid
        JOIN facilityunit fu ON uc.facilityunitid = fu.facilityunitid
        WHERE ip.isactive = true;

CREATE OR REPLACE VIEW store.facilitycatalogue AS SELECT fi.facilityid,
    fi.itemid,
    ip.genericname,
    ip.itemformid,
    ip.itemcategoryid,
    ip.categoryname,
    ip.itemclassificationid,
    ip.classificationname,
    fi.formname,
    ip.itemstrength,
    ip.itemform,
    ip.issupplies,
    ip.specification,
    ip.fullname,
    ip.packagename,
    ip.packagequantity
    FROM store.facilitycatalogueitem fi
        JOIN store.itempackage ip ON fi.itemid = ip.itempackageid;

ALTER TABLE store.item ADD COLUMN measure varchar(255);
ALTER TABLE store.activitycell DROP COLUMN closed;
ALTER TABLE store.activitycell ADD COLUMN closed boolean default false;
ALTER TABLE store.activitycell DROP COLUMN recount;
ALTER TABLE store.activitycell ADD COLUMN recount boolean default false;

CREATE OR REPLACE VIEW store.supplieritemcategories AS SELECT si.supplieritemid,
    si.supplierid,
    si.itemid,
    si.itemcode,
    ip.genericname,
    si.packsize,
    si.itemcost,
    ip.isactive,
    ip.itemcategoryid,
    ip.categoryname,
    ip.itemclassificationid,
    ip.classificationname,
    si.isrestricted,
    si.tradename,
    ip.fullname,
    ip.packagename,
    ip.packagequantity
    FROM store.supplieritem si
        JOIN store.itempackage ip ON si.itemid = ip.itempackageid;

ALTER TABLE store.recount ALTER COLUMN reviewed SET default false;
UPDATE store.item SET measure='Tablet' WHERE packagesid=2;

ALTER TABLE store.bayrowcell ADD COLUMN isolated boolean DEFAULT false;
CREATE OR REPLACE VIEW store.unitstoragezones AS SELECT zn.zoneid,
    zn.zonelabel,
    znby.zonebayid,
    znby.baylabel,
    byrw.bayrowid,
    byrw.rowlabel,
    byrwcell.bayrowcellid,
    byrwcell.celllabel,
    zn.facilityunitid,
    byrwcell.cellstate,
    byrwcell.storagetypeid,
    byrwcell.celltranslimit,
	byrwcell.isolated
   	FROM store.zone zn
     	JOIN store.zonebay znby ON zn.zoneid = znby.zoneid
     	JOIN store.bayrow byrw ON znby.zonebayid = byrw.zonebayid
     	JOIN store.bayrowcell byrwcell ON byrw.bayrowid = byrwcell.bayrowid;

DROP VIEW store.celltotal;
DROP VIEW store.cellitems;
CREATE OR REPLACE VIEW store.cellitems AS SELECT us.zonelabel,
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
    us.facilityunitid,
    fs.categoryname,
    fs.classificationname,
    us.cellstate,
    fs.fullname,
    fs.packagename,
    us.isolated,
    fs.packsize,
    ss.cellid
    FROM store.unitstoragezones us
    JOIN store.shelfstock ss ON us.bayrowcellid = ss.cellid
    JOIN store.facilityunitstock fs ON ss.stockid = fs.stockid;

ALTER TABLE patient.servicequeue ADD COLUMN canceled boolean DEFAULT false;
ALTER TABLE patient.servicequeue ADD COLUMN canceledby bigint references public.staff(staffid);
ALTER TABLE patient.servicequeue ADD COLUMN timecanceled timestamp;

CREATE OR REPLACE VIEW patient.waitingtime AS SELECT unitserviceid,
    DATE(timein) as dateadded,
    SUM(
            CASE
        WHEN timeout IS NULL THEN DATE_PART('minute', now() - timein)
        ELSE DATE_PART('minute', timeout - timein)
    END
    )
    FROM patient.servicequeue GROUP BY unitserviceid,dateadded;

--Stock log view--
DROP VIEW store.facilitystocklog;
CREATE OR REPLACE VIEW store.facilitystocklog AS SELECT sl.stockflogid,
    fus.itemid,
    sl.stockid,
    sl.logtype,
    sl.quantity,
    sl.staffid,
    sl.datelogged,
    sl.referencetype,
    sl.reference,
    sl.referencenumber,
    fus.facilityunitid,
    fus.packsize,
    fus.dateadded,
    fus.daterecieved,
    fus.batchnumber,
    fus.expirydate,
    fus.daystoexpire
    FROM store.stocklog sl
    JOIN store.facilityunitstock fus ON(sl.stockid=fus.stockid);