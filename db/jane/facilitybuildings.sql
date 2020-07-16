-- SEQUENCE: public.facilitybuildings_seq

-- DROP SEQUENCE public.facilitybuildings_seq;

CREATE SEQUENCE public.facilitybuildings_seq;

ALTER SEQUENCE public.facilitybuildings_seq
    OWNER TO postgres;


-- Table: public.facilitybuildings

-- DROP TABLE public.facilitybuildings;

CREATE TABLE public.facilitybuildings
(
    buildingid integer NOT NULL DEFAULT nextval('building_buildingid_seq'::regclass),
    buildingname character varying(50) COLLATE pg_catalog."default" NOT NULL,
    facilityid integer NOT NULL,
    numberoffloors bigint NOT NULL,
    dateadded date NOT NULL,
    isactive boolean NOT NULL,
    addedby integer NOT NULL,
    CONSTRAINT facilitybuildings_pkey PRIMARY KEY (buildingid),
    CONSTRAINT addedby FOREIGN KEY (addedby)
        REFERENCES public.staff (staffid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT facilityid FOREIGN KEY (facilityid)
        REFERENCES public.facility (facilityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.facilitybuildings
    OWNER to postgres;