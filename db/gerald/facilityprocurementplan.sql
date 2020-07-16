/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  RESEARCH
 * Created: Apr 26, 2018
 */

-- Table: store.facilityprocurementplan

-- DROP TABLE store.facilityprocurementplan;

CREATE TABLE store.facilityprocurementplan
(
    facilityprocurementplanid bigint NOT NULL DEFAULT nextval('store.facilityprocurementplan_facilityprocurementplanid_seq'::regclass),
    itemid bigint,
    facilityid bigint,
    amc double precision,
    aac double precision,
    financialyearid bigint,
    amcbalance double precision,
    itemstatus boolean DEFAULT true,
    special boolean,
    draftstate character varying(255) COLLATE pg_catalog."default",
    prev_aac double precision,
    prev_amc double precision,
    previous_balance_accountedfor double precision,
    previous_balance_unaccountedfor double precision,
    previous_consumed_units double precision,
    previous_delivered_units double precision,
    previous_expired_units double precision,
    previous_stockout_units double precision,
    approved boolean,
    approvalcomment character varying(255) COLLATE pg_catalog."default",
    status character varying(30) COLLATE pg_catalog."default",
    CONSTRAINT facilityprocurementplanid PRIMARY KEY (facilityprocurementplanid),
    CONSTRAINT facilityid FOREIGN KEY (facilityid)
        REFERENCES public.facility (facilityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk7118c0d67f9da3ce FOREIGN KEY (financialyearid)
        REFERENCES store.financialyear (financialyearid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk7118c0d6c011c19a FOREIGN KEY (facilityid)
        REFERENCES public.facility (facilityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk7118c0d6eda962fa FOREIGN KEY (itemid)
        REFERENCES store.item (itemid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT itemid FOREIGN KEY (itemid)
        REFERENCES store.item (itemid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE store.facilityprocurementplan
    OWNER to postgres;