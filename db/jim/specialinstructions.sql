-- SEQUENCE: patient.specialinstructions_specialinstructionsid_seq

-- DROP SEQUENCE patient.specialinstructions_specialinstructionsid_seq;

CREATE SEQUENCE patient.specialinstructions_specialinstructionsid_seq;

ALTER SEQUENCE patient.specialinstructions_specialinstructionsid_seq
    OWNER TO postgres;

-- Table: patient.specialinstructions

-- DROP TABLE patient.specialinstructions;

CREATE TABLE patient.specialinstructions
(
    specialinstructionsid bigint NOT NULL DEFAULT nextval('patient.specialinstructions_specialinstructionsid_seq'::regclass),
    specialinstruction text COLLATE pg_catalog."default" NOT NULL,
    addedby bigint NOT NULL,
    dateadded date NOT NULL,
    CONSTRAINT specialinstructions_pkey1 PRIMARY KEY (specialinstructionsid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE patient.specialinstructions
    OWNER to postgres;
COMMENT ON TABLE patient.specialinstructions
    IS 'This table contains a list of special instructions used at issuing of prescriptions.';