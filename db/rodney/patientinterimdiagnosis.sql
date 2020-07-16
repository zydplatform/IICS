CREATE SEQUENCE patient.patient_patientinterimdiagnosis_seq;

ALTER SEQUENCE patient.patient_patientinterimdiagnosis_seq
    OWNER TO postgres;

CREATE TABLE patient.patientinterimdiagnosis
(
    diagnosisid bigint NOT NULL DEFAULT nextval('patient.patient_patientinterimdiagnosis_seq'::regclass),
    interimdiagnosis character varying(256) COLLATE pg_catalog."default",
    patientvisitid bigint,
    dateadded date,
    facilityunitid bigint,
    addedby bigint,
    CONSTRAINT diagnosisid_pkey PRIMARY KEY (diagnosisid),
    CONSTRAINT fk_addedby FOREIGN KEY (addedby)
        REFERENCES public.staff (staffid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_facilityunitid FOREIGN KEY (facilityunitid)
        REFERENCES public.facilityunit (facilityunitid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_patientvisitid FOREIGN KEY (patientvisitid)
        REFERENCES patient.patientvisit (patientvisitid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE patient.patientinterimdiagnosis
    OWNER to postgres;