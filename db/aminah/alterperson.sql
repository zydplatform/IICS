-- Column: public.person.title

-- ALTER TABLE public.person DROP COLUMN title;

ALTER TABLE public.person
    ADD COLUMN title character varying(255) COLLATE pg_catalog."default";
	
	

	
	
	