ALTER TABLE queuetype ADD COLUMN description text;
CREATE TABLE countrycurrency(countrycurrencyid int PRIMARY KEY, countryname text, countryshortname text, currencyname text, currencyshortname text, currencysymbol text, dateadded date);
CREATE TABLE currencyrates (currencyratesid int PRIMARY KEY, countrycurrencyoneid int REFERENCES public.countrycurrency(countrycurrencyid), countrycurrencytwoid int REFERENCES public.countrycurrency(countrycurrencyid), buyone int, sellone int, buytwo int, selltwo int, dateadded date);


-- CREATE SEQUENCE public.designationcategory_designationcategoryid_seq
--     INCREMENT 1
--     START 109
--     MINVALUE 1
--     MAXVALUE 9223372036854775807
--     CACHE 1;
ALTER TABLE designationcategory ALTER COLUMN designationcategoryid SET DEFAULT nextval('public.designationcategory_designationcategoryid_seq'::regclass);
CREATE TABLE public.worldcountries(worldcountriesid int PRIMARY KEY, countryname text);
ALTER TABLE countrycurrency add column currencysymbol text;
ALTER TABLE countrycurrency add column worldcountriesid int references public.worldcountries(worldcountriesid);
ALTER TABLE designationcategory add column categorystatus boolean;
ALTER TABLE queuetype add column queuestatus boolean;
ALTER TABLE countrycurrency ADD column currencyrates double precision;
ALTER TABLE countrycurrency DROP column currencysymbol;

ALTER TABLE public.servicetype SET SCHEMA controlpanel;
CREATE TABLE controlpanel.facilityblock(facilityblockid int PRIMARY KEY, blockname text, blockdescription text, status boolean,facilityunitid int references facilityunit(facilityunitid));
CREATE TABLE controlpanel.blockroom(blockroomid int PRIMARY KEY, roomname text, description text, status boolean, roomstatus boolean,facilityblockid int references controlpanel.facilityblock(facilityblockid));
ALTER TABLE controlpanel.facilityblock DROP COLUMN facilityunitid;
ALTER TABLE controlpanel.facilityblock ADD COLUMN facilityid int references facility(facilityid);
CREATE SEQUENCE controlpanel.facilityblock_facilityblockid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE controlpanel.facilityblock ALTER COLUMN facilityblockid SET DEFAULT nextval('controlpanel.facilityblock_facilityblockid_seq'::regclass);
ALTER TABLE controlpanel.facilityblock ADD COLUMN roomsize int;

CREATE SEQUENCE controlpanel.blockroom_blockroomid_seq
    INCREMENT 1
    START 2
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE controlpanel.blockroom ALTER COLUMN blockroomid SET DEFAULT nextval('controlpanel.blockroom_blockroomid_seq'::regclass);

ALTER TABLE controlpanel.servicetype add column isactive boolean;
CREATE SEQUENCE controlpanel.servicetype_servicetypeid_seq
    INCREMENT 1
    START 26
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE controlpanel.servicetype ALTER COLUMN servicetypeid SET DEFAULT nextval('servicetype_servicetypeid_seq'::regclass);

CREATE TABLE controlpanel.building (buildingid int PRIMARY KEY, buildingname text, facilityid int references facility(facilityid), isactive boolean, dateadded DATE , addedby text, dateupdated DATE, updatedby text, blocksize int);

CREATE SEQUENCE controlpanel.building_buildingid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE controlpanel.building ALTER COLUMN buildingid SET DEFAULT nextval('controlpanel.building_buildingid_seq'::regclass);

ALTER TABLE controlpanel.building DROP COLUMN updatedby;
ALTER TABLE controlpanel.building DROP COLUMN addedby;
ALTER TABLE controlpanel.building ADD COLUMN updatedby bigint;
ALTER TABLE controlpanel.building ADD COLUMN addedby bigint;
ALTER TABLE controlpanel.building ADD COLUMN roomsize int;
ALTER TABLE controlpanel.building ADD COLUMN blocksize int;

ALTER TABLE controlpanel.facilityblock DROP COLUMN updateby;
ALTER TABLE controlpanel.facilityblock DROP COLUMN addedby;
ALTER TABLE controlpanel.facilityblock ADD COLUMN updatedby bigint;
ALTER TABLE controlpanel.facilityblock ADD COLUMN addedby bigint;

CREATE SEQUENCE controlpanel.buildingroom_buildingroomid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE controlpanel.buildingroom ALTER COLUMN buildingroomid SET DEFAULT nextval('controlpanel.buildingroom_buildingroomid_seq'::regclass);

ALTER TABLE controlpanel.blockroom DROP COLUMN updateby;
ALTER TABLE controlpanel.blockroom DROP COLUMN addedby;
ALTER TABLE controlpanel.blockroom ADD COLUMN updatedby bigint;
ALTER TABLE controlpanel.blockroom ADD COLUMN addedby bigint;

ALTER TABLE public.worldcountries add column countrycurrency text;
ALTER TABLE public.worldcountries add column currencyabbrv text;

DROP TABLE public.ctrycurrency CASCADE;
CREATE TABLE public.ctrycurrency(currencyid int PRIMARY KEY, country text, currencyname text, abbreviation text, currencyrate double precision, currencystatus boolean, addedby bigint , updatedby bigint, dateadded date, dateupdated date);

CREATE SEQUENCE public.ctrycurrency_currencyid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE public.ctrycurrency ALTER COLUMN currencyid SET DEFAULT nextval('public.ctrycurrency_currencyid_seq'::regclass);
ALTER TABLE controlpanel.facilityblock ADD COLUMN buildingid integer REFERENCES building(buildingid);
ALTER TABLE controlpanel.facilityblock ADD COLUMN dateadded date;
ALTER TABLE controlpanel.facilityblock ADD COLUMN dateupdated date;
ALTER TABLE controlpanel.facilityblock DROP CONSTRAINT facilityblock_buildingid_fkey;
ALTER TABLE controlpanel.facilityblock ADD CONSTRAINT facilityblock_buildingid_fkey FOREIGN KEY (buildingid) REFERENCES controlpanel.building (buildingid);

ALTER TABLE public.designation ADD COLUMN status boolean default true;
ALTER TABLE public.designation ADD COLUMN activity text;
ALTER TABLE public.designation ADD COLUMN parentid Integer;
ALTER TABLE public.designation ADD COLUMN global boolean default true;

ALTER TABLE public.designation ADD COLUMN transferstatus boolean default false;
ALTER TABLE public.designation ADD COLUMN updatedby bigint;
ALTER TABLE public.designation ADD COLUMN addedby bigint;
ALTER TABLE public.designation ADD COLUMN dateadded date;
ALTER TABLE public.designation ADD COLUMN dateupdated date;

CREATE TABLE public.transfereddesignations(transfereddesignationsid int PRIMARY KEY, transferreddesignationname text, transferreddesigCatname text, dateadded date, dateupdated date, addedby bigint, updatedby bigint);
ALTER TABLE public.transfereddesignations ADD COLUMN designationcategoryid int references public.designationcategory(designationcategoryid);

ALTER TABLE public.designation ADD COLUMN previousdesigcategory int;