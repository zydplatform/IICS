-- SEQUENCE: public.person_language_id_seq

-- DROP SEQUENCE public.person_language_id_seq;

CREATE SEQUENCE public.person_language_id_seq;

ALTER SEQUENCE public.person_language_id_seq
    OWNER TO postgres;

-- Table: public.personlanguage

-- DROP TABLE public.personlanguage;

CREATE TABLE public.personlanguage
(
    personlanguageid integer NOT NULL DEFAULT nextval('person_language_id_seq'::regclass),
    personid bigint,
    languageid integer,
    CONSTRAINT personlanguage_pkey PRIMARY KEY (personlanguageid),
    CONSTRAINT personlanguage_languageid_fkey FOREIGN KEY (languageid)
        REFERENCES public.spokenlanguages (languageid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT personlanguage_personid_fkey FOREIGN KEY (personid)
        REFERENCES public.person (personid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.personlanguage
    OWNER to postgres;