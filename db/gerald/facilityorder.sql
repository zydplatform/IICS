/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: May 15, 2018
 */

CREATE TABLE store.facilityorder
(
    facilityorderid bigint NOT NULL,
    ordertype character(50) COLLATE pg_catalog."default",
    originstore bigint,
    destinationstore bigint,
    isemergency boolean,
    preparedby bigint,
    dateprepared date,
    datepicked date,
    status character varying(255) COLLATE pg_catalog."default",
    approved boolean,
    approvedby bigint,
    approvalcomment character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT facilityorder_pkey PRIMARY KEY (facilityorderid),
    CONSTRAINT fk_approvedby FOREIGN KEY (approvedby)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_destinationfacilityunit FOREIGN KEY (destinationstore)
        REFERENCES public.facilityunit (facilityunitid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_originstore FOREIGN KEY (originstore)
        REFERENCES public.facilityunit (facilityunitid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_preparedby FOREIGN KEY (preparedby)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

CREATE TABLE store.facilityorderitems
(
    facilityorderitemsid bigint NOT NULL,
    itemid bigint,
    qtyordered bigint,
    qtyreceived bigint,
    qtyapproved bigint,
    approvalcomment character varying(255) COLLATE pg_catalog."default",
    pickedby bigint,
    approved boolean,
    dateapproved date,
    approvedby bigint,
    ispicked boolean,
    serviced boolean,
    servicedby bigint,
    dateserviced date,
    servicedcomment character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT facilityorderitems_pkey PRIMARY KEY (facilityorderitemsid),
    CONSTRAINT fk_approvedby FOREIGN KEY (pickedby)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_itemid FOREIGN KEY (itemid)
        REFERENCES store.item (itemid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_pickedby FOREIGN KEY (pickedby)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_servicedby FOREIGN KEY (pickedby)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
CREATE SEQUENCE store.facilityorder_facilityorderid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.facilityorder ALTER COLUMN facilityorderid SET DEFAULT nextval('store.facilityorder_facilityorderid_seq'::regclass);

CREATE SEQUENCE store.facilityorderitems_facilityorderitemsid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.facilityorderitems ALTER COLUMN facilityorderitemsid SET DEFAULT nextval('store.facilityorderitems_facilityorderitemsid_seq'::regclass);
ALTER TABLE store.facilityorder ADD COLUMN facilityorderno VARCHAR;

ALTER TABLE store.orderperiod ADD COLUMN isactive BOOLEAN;

ALTER TABLE store.facilityorderitems ADD COLUMN facilityorderid BIGINT;
ALTER TABLE store.facilityorderitems ADD CONSTRAINT  FK_facilityorderid FOREIGN KEY(facilityorderid) REFERENCES store.facilityorder(facilityorderid);

ALTER TABLE store.facilityorder ADD COLUMN dateneeded date;

ALTER TABLE store.facilityorder DROP COLUMN ordertype;
ALTER TABLE store.facilityorder ADD COLUMN ordertype VARCHAR;

ALTER TABLE facilityunit ADD COLUMN ismainstore BOOLEAN;




-- last queries


ALTER TABLE store.facilityorder DROP COLUMN destinationstore;
ALTER TABLE store.facilityorder ADD COLUMN destinationstore BIGINT;