-- Column: public.person.spokenlanguageid

-- ALTER TABLE public.person DROP COLUMN spokenlanguageid;

ALTER TABLE public.person
    ADD COLUMN spokenlanguageid integer;



-- SEQUENCE: public.spokenlanguage_languageid_seq

-- DROP SEQUENCE public.spokenlanguage_languageid_seq;

CREATE SEQUENCE public.spokenlanguage_languageid_seq;

ALTER SEQUENCE public.spokenlanguage_languageid_seq
    OWNER TO postgres;
	
-- Table: public.spokenlanguages

-- DROP TABLE public.spokenlanguages;

CREATE TABLE public.spokenlanguages
(
    languageid integer NOT NULL DEFAULT nextval('spokenlanguage_languageid_seq'::regclass),
    languagename character varying COLLATE pg_catalog."default",
    addedby integer,
    dateadded date,
    archived boolean,
    CONSTRAINT spokenlanguages_pkey PRIMARY KEY (languageid),
    CONSTRAINT addedby FOREIGN KEY (addedby)
        REFERENCES public.staff (staffid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.spokenlanguages
    OWNER to postgres;	