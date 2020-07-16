-- SEQUENCE: patient.triagevalidationskip_triagevalidationskipid_seq

-- DROP SEQUENCE patient.triagevalidationskip_triagevalidationskipid_seq;

CREATE SEQUENCE patient.triagevalidationskip_triagevalidationskipid_seq;

ALTER SEQUENCE patient.triagevalidationskip_triagevalidationskipid_seq
    OWNER TO postgres;

-- Table: patient.triagevalidationskip

-- DROP TABLE patient.triagevalidationskip;

CREATE TABLE patient.triagevalidationskip
(
    triagevalidationskipid bigint NOT NULL DEFAULT nextval('patient.triagevalidationskip_triagevalidationskipid_seq'::regclass),
    skippedfield character varying COLLATE pg_catalog."default" NOT NULL,
    reason text COLLATE pg_catalog."default" NOT NULL,
    patientvisitid bigint NOT NULL,
    addedby bigint NOT NULL,
    dateadded date NOT NULL,
    facilityunitid bigint NOT NULL,
    CONSTRAINT triagevalidationskip_pkey PRIMARY KEY (triagevalidationskipid),
    CONSTRAINT triagevalidationskip_addedby_fkey FOREIGN KEY (addedby)
        REFERENCES public.staff (staffid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT triagevalidationskip_facilityunitid_fkey FOREIGN KEY (facilityunitid)
        REFERENCES public.facilityunit (facilityunitid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT triagevalidationskip_patientvisitid_fkey FOREIGN KEY (patientvisitid)
        REFERENCES patient.patientvisit (patientvisitid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE patient.triagevalidationskip
    OWNER to postgres;
COMMENT ON TABLE patient.triagevalidationskip
    IS 'This table stores reasons for skipping validation for a visit at triage. i.e. validation on width, height, temperature etc.';