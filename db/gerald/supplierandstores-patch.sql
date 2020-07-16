/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  RESEARCH
 * Created: Apr 17, 2018
 */
ALTER TABLE public.facilityschedule
    SET SCHEMA controlpanel;
CREATE SEQUENCE controlpanel.facilityschedule_facilityscheduleid_seq
    INCREMENT 1
    START 19
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE controlpanel.facilityschedule ALTER COLUMN facilityscheduleid SET DEFAULT nextval('controlpanel.facilityschedule_facilityscheduleid_seq'::regclass);
CREATE TABLE controlpanel.facilityunitsupplier
(
    facilityunitsupplierid integer NOT NULL,
    facilityunitid bigint,
    supplierid bigint,
    suppliertype character varying(100) COLLATE pg_catalog."default",
    status character varying(50) COLLATE pg_catalog."default",
    active boolean,
    addedby bigint,
    dateadded date,
    lastupdated date,
    lastupdatedby bigint,
    CONSTRAINT facilityunitsupplier_pkey PRIMARY KEY (facilityunitsupplierid),
    CONSTRAINT fk_facilityunit FOREIGN KEY (facilityunitid)
        REFERENCES public.facilityunit (facilityunitid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_lastupdatedby FOREIGN KEY (lastupdatedby)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_psersonid FOREIGN KEY (addedby)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
CREATE TABLE controlpanel.schedule
(
    scheduleid integer NOT NULL,
    schedulename character varying(100) COLLATE pg_catalog."default",
    abbreviation character varying(20) COLLATE pg_catalog."default",
    dateadded date,
    addedby bigint,
    CONSTRAINT schedule_pkey PRIMARY KEY (scheduleid),
    CONSTRAINT fk_psersonid FOREIGN KEY (addedby)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
CREATE TABLE controlpanel.facilityunitsupplierschedule
(
    facilityunitsupplierscheduleid integer NOT NULL,
    facilityunitsupplierid integer,
    scheduleid integer,
    active boolean,
    addedby bigint,
    dateadded date,
    lastupdated date,
    lastupdatedby bigint,
    CONSTRAINT facilityunitsupplierschedule_pkey PRIMARY KEY (facilityunitsupplierscheduleid),
    CONSTRAINT fk_facilityunitsupplier FOREIGN KEY (facilityunitsupplierid)
        REFERENCES controlpanel.facilityunitsupplier (facilityunitsupplierid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_lastupdatedby FOREIGN KEY (lastupdatedby)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_personid FOREIGN KEY (addedby)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_scheduleid FOREIGN KEY (scheduleid)
        REFERENCES controlpanel.schedule (scheduleid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE SEQUENCE controlpanel.facilityunitsupplier_facilityunitsupplierid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE controlpanel.facilityunitsupplier ALTER COLUMN facilityunitsupplierid SET DEFAULT nextval('controlpanel.facilityunitsupplier_facilityunitsupplierid_seq'::regclass);

CREATE SEQUENCE controlpanel.schedule_scheduleid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE controlpanel.schedule ALTER COLUMN scheduleid SET DEFAULT nextval('controlpanel.schedule_scheduleid_seq'::regclass);

CREATE SEQUENCE controlpanel.facilityunitsupplierschedule_facilityunitsupplierscheduleid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE controlpanel.facilityunitsupplierschedule ALTER COLUMN facilityunitsupplierscheduleid SET DEFAULT nextval('controlpanel.facilityunitsupplierschedule_facilityunitsupplierscheduleid_seq'::regclass);
ALTER TABLE controlpanel.facilityunitsupplierschedule ADD COLUMN facilityscheduleid BIGINT;
ALTER TABLE controlpanel.facilityunitsupplierschedule ADD CONSTRAINT FK_facilityscheduleid FOREIGN KEY(facilityscheduleid) REFERENCES controlpanel.facilityschedule(facilityscheduleid);



CREATE OR REPLACE VIEW controlpanel.facilityunitstoreschedule AS
SELECT fus.facilityunitsupplierid,
	fus.facilityunitid,
        fus.status,
        fus.isactive,
        fu.facilityunitname,
        fus.supplierid,
        fus.suppliertype,
	fuss.facilityunitsupplierscheduleid,
        fuss.scheduleid,
        fuss.facilityscheduleid,
        fuss.active,
        s.scheduledayname,
        s.abbreviation,
        fs.schedulename
   FROM controlpanel.facilityunitsupplier fus
   JOIN public.facilityunit fu ON(fus.facilityunitid=FU.facilityunitid)
   JOIN controlpanel.facilityunitsupplierschedule fuss ON(fus.facilityunitsupplierid=fuss.facilityunitsupplierid)
   JOIN controlpanel.schedule s ON(fuss.scheduleid=s.scheduleid)
   JOIN controlpanel.facilityschedule fs ON(fuss.facilityscheduleid=fs.facilityscheduleid);
  ALTER TABLE controlpanel.facilityunitsupplier ADD COLUMN approvalcomment VARCHAR;