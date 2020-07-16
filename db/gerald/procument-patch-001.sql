ALTER TABLE public.financialyear
    SET SCHEMA store;
ALTER TABLE public.facilityprocurementplan
    SET SCHEMA store;

CREATE SEQUENCE store.facilityprocurementplan_facilityprocurementplanid_seq
    INCREMENT 1
    START 2523
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    
ALTER TABLE store.facilityprocurementplan ALTER COLUMN facilityprocurementplanid SET DEFAULT nextval('store.facilityprocurementplan_facilityprocurementplanid_seq'::regclass);
ALTER TABLE store.financialyear ADD COLUMN approvalcomment VARCHAR;
ALTER TABLE store.financialyear ADD COLUMN dateadded date;
ALTER TABLE store.financialyear ADD COLUMN lastupdated date;
ALTER TABLE store.financialyear ADD COLUMN addedby bigint;
ALTER TABLE store.financialyear ADD COLUMN lastupdatedby bigint;
ALTER TABLE store.financialyear ADD COLUMN processingstage VARCHAR;
ALTER TABLE store.facilityprocurementplan ADD COLUMN approved Boolean;
ALTER TABLE store.facilityprocurementplan ADD COLUMN approvalcomment VARCHAR;
ALTER TABLE store.facilityprocurementplan ADD COLUMN status VARCHAR;


