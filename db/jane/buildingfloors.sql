-- SEQUENCE: public.buildingfloors_floorid_seq

-- DROP SEQUENCE public.buildingfloors_floorid_seq;

CREATE SEQUENCE public.buildingfloors_floorid_seq;

ALTER SEQUENCE public.buildingfloors_floorid_seq
    OWNER TO postgres;


-- Table: public.buildingfloors

-- DROP TABLE public.buildingfloors;

CREATE TABLE public.buildingfloors
(
    floorid integer NOT NULL DEFAULT nextval('buildingfloors_floorid_seq'::regclass),
    floorname character varying(100) COLLATE pg_catalog."default" NOT NULL,
    buildingid integer NOT NULL,
    numberofrooms bigint NOT NULL,
    CONSTRAINT buildingfloors_pkey PRIMARY KEY (floorid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.buildingfloors
    OWNER to postgres;