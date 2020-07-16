/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  RESEARCH
 * Created: Apr 26, 2018
 */
DROP TABLE public.facprocplandraft_items;
DROP TABLE public.facprocplandraftitems;
DROP TABLE public.facprocplandraft;
DROP TABLE store.facilityprocurementplan;
DROP TABLE public.facilityprocurementplandraft_items;
DROP TABLE public.facilityprocurementplandraft;
DROP TABLE store.financialyear;

CREATE TABLE store.facilityfinancialyear
(
    facilityfinancialyearid bigint NOT NULL,
    status boolean,
    startyear integer NOT NULL,
    endyear integer NOT NULL,
    maximumorderpercentage double precision,
    minimumorderpercentage double precision,
    isthecurrent boolean DEFAULT false,
    actndate timestamp without time zone,
    processingstage character varying(40) COLLATE pg_catalog."default",
    approvalcomment character varying(255) COLLATE pg_catalog."default",
    dateadded date,
    lastupdated date,
    addedby bigint,
    lastupdatedby bigint,
    facilityid bigint,
    orderperiodname character varying COLLATE pg_catalog."default",
    CONSTRAINT financialyearid PRIMARY KEY (facilityfinancialyearid)
);
CREATE TABLE store.facilityunitfinancialyear
(
    facilityunitfinancialyearid integer NOT NULL,
    facilityfinancialyearid bigint,
    facilityunitid bigint,
    addedby bigint,
    proccessingstage character varying COLLATE pg_catalog."default",
    approvalcomment character varying COLLATE pg_catalog."default",
    dateadded date,
    lastupdated date,
    lastupdatedby bigint,
    orderperiodid integer,
    CONSTRAINT facilityunitfinancialyear_pkey PRIMARY KEY (facilityunitfinancialyearid),
    CONSTRAINT fk_facilityfinancialyear FOREIGN KEY (facilityfinancialyearid)
        REFERENCES store.facilityfinancialyear (facilityfinancialyearid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE store.facilityunitprocurementplan
(
    facilityunitprocurementplanid integer NOT NULL,
    addedby bigint,
    itemid bigint,
    facilityunitfinancialyearid integer,
    averageannualcomsumption double precision,
    averagemonthlyconsumption double precision,
    approved boolean,
    approvalcomment character varying COLLATE pg_catalog."default",
    status character varying COLLATE pg_catalog."default",
    dateadded date,
    lastupdated date,
    lastupdatedby bigint,
    CONSTRAINT facilityunitprocurementplan_pkey PRIMARY KEY (facilityunitprocurementplanid),
    CONSTRAINT fk_facilityunitfinancialyear FOREIGN KEY (facilityunitfinancialyearid)
        REFERENCES store.facilityunitfinancialyear (facilityunitfinancialyearid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_item FOREIGN KEY (itemid)
        REFERENCES store.item (itemid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
CREATE SEQUENCE store.facilityfinancialyear_facilityfinancialyearid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.facilityfinancialyear ALTER COLUMN facilityfinancialyearid SET DEFAULT nextval('store.facilityfinancialyear_facilityfinancialyearid_seq'::regclass);

CREATE SEQUENCE store.facilityunitfinancialyear_facilityunitfinancialyearid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.facilityunitfinancialyear ALTER COLUMN facilityunitfinancialyearid SET DEFAULT nextval('store.facilityunitfinancialyear_facilityunitfinancialyearid_seq'::regclass);

CREATE SEQUENCE store.facilityunitprocurementplan_facilityunitprocurementplanid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.facilityunitprocurementplan ALTER COLUMN facilityunitprocurementplanid SET DEFAULT nextval('store.facilityunitprocurementplan_facilityunitprocurementplanid_seq'::regclass);

ALTER TABLE store.facilityunitfinancialyear ADD COLUMN facilityunitlabel VARCHAR;
ALTER TABLE store.facilityfinancialyear 
DROP COLUMN processingstage;
ALTER TABLE store.facilityfinancialyear 
DROP COLUMN approvalcomment;

CREATE TABLE store.orderperiod
(
    orderperiodid integer NOT NULL DEFAULT nextval('store.orderperiod_orderperiodid_seq'::regclass),
    orderperiodname character varying(255) COLLATE pg_catalog."default",
    startdate date,
    enddate date,
    addedby bigint,
    dateadded date,
    CONSTRAINT orderperiod_pkey PRIMARY KEY (orderperiodid),
    CONSTRAINT fk_addedby FOREIGN KEY (addedby)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE store.facilityunitfinancialyear ADD CONSTRAINT fk_orderperiod FOREIGN KEY(orderperiodid) REFERENCES store.orderperiod(orderperiodid);
ALTER TABLE store.facilityunitfinancialyear ADD CONSTRAINT fk_lastupdatedby FOREIGN KEY(lastupdatedby) REFERENCES person(personid);
ALTER TABLE store.facilityunitfinancialyear ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES person(personid);
ALTER TABLE store.orderperiod ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES person(personid);
ALTER TABLE store.facilityunitprocurementplan ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES person(personid);
ALTER TABLE store.facilityunitprocurementplan ADD CONSTRAINT fk_lastupdatedby FOREIGN KEY(lastupdatedby) REFERENCES person(personid);
ALTER TABLE store.facilityfinancialyear ADD CONSTRAINT fk_lastupdatedby FOREIGN KEY(lastupdatedby) REFERENCES person(personid);
ALTER TABLE store.facilityfinancialyear ADD CONSTRAINT fk_addedby FOREIGN KEY(addedby) REFERENCES person(personid);


CREATE SEQUENCE store.orderperiod_orderperiodid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.orderperiod ALTER COLUMN orderperiodid SET DEFAULT nextval('store.orderperiod_orderperiodid_seq'::regclass);

ALTER TABLE store.orderperiod ADD COLUMN orderperiodtype VARCHAR;
ALTER TABLE store.facilityfinancialyear DROP COLUMN  orderperiod;
ALTER TABLE store.facilityfinancialyear DROP COLUMN  maximumorderpercentage;
ALTER TABLE store.facilityfinancialyear DROP COLUMN  minimumorderpercentage;
ALTER TABLE store.facilityfinancialyear DROP COLUMN  actndate;
ALTER TABLE store.facilityfinancialyear ADD COLUMN activationdate date;
ALTER TABLE store.orderperiod ADD COLUMN facilityfinancialyearid BIGINT;
ALTER TABLE store.orderperiod ADD CONSTRAINT  fk_facilityfinancialyearid FOREIGN KEY(facilityfinancialyearid) REFERENCES store.facilityfinancialyear(facilityfinancialyearid);
ALTER TABLE store.facilityunitprocurementplan ADD COLUMN averagequarterconsumption double precision;
ALTER TABLE store.facilityfinancialyear ADD COLUMN orderperiodtype VARCHAR;












