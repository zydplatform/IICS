/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: May 8, 2018
 */
ALTER TABLE store.orderperiod ADD COLUMN setascurrent BOOLEAN;
ALTER TABLE store.orderperiod ADD COLUMN approved BOOLEAN;

-- second patch 0002
CREATE OR REPLACE VIEW store.facilityprocurementplanitems AS
SELECT ffy.facilityfinancialyearid,
	ffy.facilityid,
        orp.orderperiodid,
       SUM(fupp.averagemonthlyconsumption) AS averagemonthlyconsumption,
       SUM(fupp.averageannualcomsumption) AS averageannualcomsumption,
       SUM(fupp.averagequarterconsumption) AS averagequarterconsumption ,
       fupp.itemid
   FROM store.facilityfinancialyear ffy
    JOIN store.facilityunitfinancialyear fufy ON(ffy.facilityfinancialyearid=fufy.facilityfinancialyearid)
    JOIN store.orderperiod orp ON(orp.orderperiodid=fufy.orderperiodid)
    JOIN store.facilityunitprocurementplan fupp ON(fufy.facilityunitfinancialyearid=fupp.facilityunitfinancialyearid)
   WHERE fufy.proccessingstage='approved' AND ffy.isthecurrent=true AND fupp.approved=true AND orp.setascurrent=true
   GROUP BY ffy.facilityfinancialyearid,ffy.facilityid,fupp.itemid,orp.orderperiodid;


CREATE TABLE store.facilityprocurementplanitemupdates
(
    facilityprocurementplanitemupdatesid integer NOT NULL,
    itemid bigint,
    averagemonthlyconsumption double precision,
    averageannualconsumption double precision,
    averagequarterconsumption double precision,
    facilityfinancialyearid bigint,
    orderperiodid integer,
    addedby bigint,
    dateadded date,
    lastupdated date,
    lastupdatedby bigint,
    CONSTRAINT facilityprocurementplanitemupdates_pkey PRIMARY KEY (facilityprocurementplanitemupdatesid)
);
ALTER TABLE store.facilityprocurementplanitemupdates ADD CONSTRAINT fk_item FOREIGN KEY(itemid) REFERENCES store.item(itemid);
ALTER TABLE store.facilityprocurementplanitemupdates ADD CONSTRAINT fk_orderperiodid FOREIGN KEY(orderperiodid) REFERENCES store.orderperiod(orderperiodid);
ALTER TABLE store.facilityprocurementplanitemupdates ADD CONSTRAINT fk_facilityfinancialyear FOREIGN KEY(facilityfinancialyearid) REFERENCES store.facilityfinancialyear(facilityfinancialyearid);
ALTER TABLE store.facilityprocurementplanitemupdates ADD CONSTRAINT fk_lastupdatedby FOREIGN KEY(lastupdatedby) REFERENCES person(personid);
ALTER TABLE store.facilityprocurementplanitemupdates ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES person(personid);
CREATE SEQUENCE store.facilityprocurementplanitemupdates_facilityprocurementplanitemupdatesid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.facilityprocurementplanitemupdates ALTER COLUMN facilityprocurementplanitemupdatesid SET DEFAULT nextval('store.facilityprocurementplanitemupdates_facilityprocurementplanitemupdatesid_seq'::regclass);

CREATE TABLE store.facilityprocurementplan
(
    facilityprocurementplanid bigint NOT NULL,
    orderperiodid integer,
    itemid bigint,
    averagemonthconsumption double precision,
    averageannualconsumption double precision,
    averagequarterconsumption double precision,
    addedby bigint,
    dateadded date,
    CONSTRAINT facilityprocurementplan_pkey PRIMARY KEY (facilityprocurementplanid)
);
ALTER TABLE store.facilityprocurementplan ADD CONSTRAINT fk_itmeid FOREIGN KEY(itemid) REFERENCES store.item(itemid);
ALTER TABLE store.facilityprocurementplan ADD CONSTRAINT fk_orderperiodid FOREIGN KEY(orderperiodid) REFERENCES store.orderperiod(orderperiodid);
ALTER TABLE store.facilityprocurementplan ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES person(personid);
CREATE SEQUENCE store.facilityprocurementplan_facilityprocurementplanid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.facilityprocurementplan ALTER COLUMN facilityprocurementplanid SET DEFAULT nextval('store.facilityprocurementplan_facilityprocurementplanid_seq'::regclass);
ALTER TABLE store.orderperiod ADD COLUMN procured BOOLEAN;

ALTER TABLE store.orderperiod ADD COLUMN submitted BOOLEAN;
ALTER TABLE store.orderperiod ADD COLUMN submitcomment VARCHAR;
ALTER TABLE facilityunit ADD COLUMN ismainstore BOOLEAN;






