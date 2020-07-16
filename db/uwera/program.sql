

CREATE TABLE antenatal.program
(
    programid bigint NOT NULL,
    programname character varying COLLATE pg_catalog."default",
    programkey character varying COLLATE pg_catalog."default",
    active boolean NOT NULL,
    CONSTRAINT programid PRIMARY KEY (programid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE antenatal.program
    OWNER to postgres;


CREATE TABLE antenatal.programservice
(
    programserviceid bigint NOT NULL,
    programid integer,
    serviceid bigint NOT NULL,
    CONSTRAINT "PK_ProgramServices" PRIMARY KEY (programserviceid),
    CONSTRAINT "FK_RefFacilityService" FOREIGN KEY (serviceid)
        REFERENCES public.facilityservices (serviceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_RefProgram" FOREIGN KEY (programid)
        REFERENCES antenatal.program (programid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE antenatal.programservice
    OWNER to postgres;


CREATE TABLE antenatal.patientprogram
(
    patientprogramid bigint NOT NULL,
    patientvisitid bigint,
    startdate date,
    dateclosed date,
    status character varying COLLATE pg_catalog."default",
    patientid integer,
    timein timestamp without time zone NOT NULL DEFAULT now(),
    timeout timestamp without time zone,
    programid bigint,
    CONSTRAINT patientprogramid PRIMARY KEY (patientprogramid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE antenatal.patientprogram
    OWNER to postgres;

-- Index: fki_patientid

-- DROP INDEX antenatal.fki_patientid;

CREATE INDEX fki_patientid
    ON antenatal.patientprogram USING btree
    (patientvisitid)
    TABLESPACE pg_default;