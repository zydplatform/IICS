-- Table: public.audittraillocation

-- DROP TABLE public.audittraillocation;

CREATE TABLE public.audittraillocation
(
    audit bigint NOT NULL,
    timein timestamp without time zone NOT NULL,
    changeby bigint NOT NULL,
    category character varying COLLATE pg_catalog."default" NOT NULL,
    activity character varying COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    prevregion character varying COLLATE pg_catalog."default",
    prevdistrict character varying COLLATE pg_catalog."default",
    prevcounty character varying COLLATE pg_catalog."default",
    prevsubcounty character varying COLLATE pg_catalog."default",
    prevparish character varying COLLATE pg_catalog."default",
    prevvillage character varying COLLATE pg_catalog."default",
    curlocationid integer,
    dbaction character varying COLLATE pg_catalog."default" NOT NULL,
    attrvalue character varying COLLATE pg_catalog."default" NOT NULL,
    curcounty character varying(255) COLLATE pg_catalog."default",
    curdistrict character varying(255) COLLATE pg_catalog."default",
    curparish character varying(255) COLLATE pg_catalog."default",
    curregion character varying(255) COLLATE pg_catalog."default",
    cursubcounty character varying(255) COLLATE pg_catalog."default",
    curvillage character varying(255) COLLATE pg_catalog."default",
    prevlocationid integer,
    transferactivity character varying(255) COLLATE pg_catalog."default",
    administered boolean NOT NULL DEFAULT false,
    refid bigint,
    reflevel integer DEFAULT 0,
    objectid bigint,
    CONSTRAINT "PK_RefLocationsAuditTrail" PRIMARY KEY (audit),
    CONSTRAINT "FK_ChangedBy_Person" FOREIGN KEY (changeby)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.audittraillocation
    OWNER to postgres;