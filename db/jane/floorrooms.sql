-- SEQUENCE: public.floorrooms_roomid_seq

-- DROP SEQUENCE public.floorrooms_roomid_seq;

CREATE SEQUENCE public.floorrooms_roomid_seq;

ALTER SEQUENCE public.floorrooms_roomid_seq
    OWNER TO postgres;
	
	-- Table: public.floorrooms

-- DROP TABLE public.floorrooms;

CREATE TABLE public.floorrooms
(
    roomid integer NOT NULL DEFAULT nextval('floorrooms_roomid_seq'::regclass),
    roomname character varying COLLATE pg_catalog."default",
    floorid integer,
    archived boolean,
    ismerged boolean,
    ispartitioned boolean,
    CONSTRAINT floorrooms_pkey PRIMARY KEY (roomid),
    CONSTRAINT floorid FOREIGN KEY (floorid)
        REFERENCES public.buildingfloors (floorid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.floorrooms
    OWNER to postgres;