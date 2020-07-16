

ALTER TABLE facility ADD COLUMN catchmentarea character varying(20);

ALTER TABLE facility ADD COLUMN facilityfunder character varying(50);
ALTER TABLE facility ADD COLUMN facilitygender character varying(6);

ALTER TABLE facility ADD COLUMN facilitysupervisor character varying(50);

ALTER TABLE facility ADD COLUMN paymentmode character varying(50);
ALTER TABLE facility ADD COLUMN receiveadverts boolean;
ALTER TABLE facility ADD COLUMN singlefacilitytype character varying(6);
ALTER TABLE facility ADD COLUMN villageid integer;
ALTER TABLE facility ADD COLUMN gpseasting character varying(255);
ALTER TABLE facility ADD COLUMN gpsnorthing character varying(255);
ALTER TABLE facility ADD COLUMN dateadded timestamp without time zone;

ALTER TABLE facility ADD COLUMN description character varying(255);

ALTER TABLE facility ADD COLUMN shortname character varying(255);

ALTER TABLE facility ADD COLUMN location character varying(255);
ALTER TABLE facility ADD COLUMN facilitylogourl character varying(255);
ALTER TABLE facility ADD COLUMN emailaddress character varying(255);
ALTER TABLE facility ADD COLUMN phonecontact character varying(255);
ALTER TABLE facility ADD COLUMN website character varying(255);
ALTER TABLE facility ADD COLUMN updateby bigint;
ALTER TABLE facility ADD COLUMN approvedby bigint;
ALTER TABLE facility ADD COLUMN dateupdated timestamp without time zone;
ALTER TABLE facility ADD COLUMN ipnetwork character varying(25);
ALTER TABLE facility ADD COLUMN addedby bigint;
ALTER TABLE facility ADD COLUMN active boolean;
ALTER TABLE facility ADD COLUMN dateapproved timestamp without time zone;
ALTER TABLE facility ADD COLUMN postaddress character varying(255);



ALTER TABLE facility
  ADD CONSTRAINT "FK_AddedBy" FOREIGN KEY (addedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE facility
  ADD CONSTRAINT "FK_UpdatedBy" FOREIGN KEY (updateby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


ALTER TABLE facility
  ADD CONSTRAINT "FK_VillageLocation" FOREIGN KEY (villageid)
      REFERENCES village (villageid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


ALTER TABLE facility
  ADD CONSTRAINT "FK_ApprovedBy" FOREIGN KEY (approvedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

CREATE TABLE entitydescription
(
  descriptionid integer NOT NULL,
  active boolean NOT NULL,
  dateadded timestamp without time zone,
  dateupdated timestamp without time zone,
  description character varying(255),
  levels integer,
  facilitylevelid integer NOT NULL,
  addedby bigint NOT NULL,
  updatedby bigint,
  CONSTRAINT entitydescription_pkey PRIMARY KEY (descriptionid),
  CONSTRAINT fk_md1dlftrwnhrtdi6mvydknqml FOREIGN KEY (facilitylevelid)
      REFERENCES facilitylevel (facilitylevelid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_s04jdd3y6ih4pc030x4ewomjl FOREIGN KEY (addedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_sh7ynhpysrlbwj4wb1cf8qmuy FOREIGN KEY (updatedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE entityleveldescription
(
  entitylevelid bigint NOT NULL,
  dateadded timestamp without time zone,
  dateupdated timestamp without time zone,
  description character varying(255),
  status boolean,
  descriptionid integer NOT NULL,
  facilitylevelid integer NOT NULL,
  addedby bigint NOT NULL,
  updatedby bigint,
  CONSTRAINT entityleveldescription_pkey PRIMARY KEY (entitylevelid),
  CONSTRAINT fk_10894wfj8mwog384h56ey575v FOREIGN KEY (descriptionid)
      REFERENCES entitydescription (descriptionid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_a2exru8lyg5glph3cd1inahv3 FOREIGN KEY (facilitylevelid)
      REFERENCES facilitylevel (facilitylevelid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_fkv7t0p2feo2a3hoaxmdf2fyd FOREIGN KEY (updatedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_t557pnb3tvoytfe1p65qghye0 FOREIGN KEY (addedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE facility
(
  facilityid serial NOT NULL,
  facilityownerid integer,
  facilitylevelid integer NOT NULL,
  facilityname text NOT NULL,
  facilitycode text NOT NULL,
  status text NOT NULL DEFAULT 'PENDING'::text, -- this field indicates whether a facility has been approved to become an actual facility in the database
  file numeric(19,2),
  facilitydomainid integer,
  hasbranch boolean NOT NULL DEFAULT false,
  hasdepartments boolean NOT NULL DEFAULT false,
  parentbranchid bigint,
  catchmentarea character varying(20),
  facilityfunder character varying(50),
  facilitygender character varying(6),
  facilitysupervisor character varying(50),
  paymentmode character varying(50),
  receiveadverts boolean,
  singlefacilitytype character varying(6),
  villageid integer,
  gpseasting character varying(255),
  gpsnorthing character varying(255),
  active boolean,
  dateadded timestamp without time zone,
  description character varying(255),
  shortname character varying(255),
  locationid integer,
  location character varying(255),
  facilitylogourl character varying(255),
  emailaddress character varying(255),
  phonecontact character varying(255),
  postaddress character varying(255),
  website character varying(255),
  updateby bigint,
  approvedby bigint,
  dateapproved timestamp without time zone,
  dateupdated timestamp without time zone,
  ipnetwork character varying(25),
  addedby bigint,
  CONSTRAINT facilityid PRIMARY KEY (facilityid),
  CONSTRAINT "FK_AddedBy" FOREIGN KEY (addedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_RefParentSchoolBranch" FOREIGN KEY (parentbranchid)
      REFERENCES facility (facilityid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT facilitylevel FOREIGN KEY (facilitylevelid)
      REFERENCES facilitylevel (facilitylevelid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT facilityowner FOREIGN KEY (facilityownerid)
      REFERENCES facilityowner (facilityownerid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk1dde6ea36b0c54a2 FOREIGN KEY (facilityownerid)
      REFERENCES facilityowner (facilityownerid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk1dde6ea3ade0b604 FOREIGN KEY (facilitylevelid)
      REFERENCES facilitylevel (facilitylevelid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk1dde6ea3c377aee2 FOREIGN KEY (facilitydomainid)
      REFERENCES facilitydomain (facilitydomainid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_iiy3ousrkxckno6c6w04hsetm FOREIGN KEY (locationid)
      REFERENCES location (locationid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_ipj14y06kbvpdlsxgirvdrx1r FOREIGN KEY (updateby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_jcuyosxhjqks0796wg2rf1ybs FOREIGN KEY (villageid)
      REFERENCES village (villageid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_jtqehwf1h6jslavpbdyx5jx62 FOREIGN KEY (approvedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- Index: fki_facilitylevel

-- DROP INDEX fki_facilitylevel;

CREATE INDEX fki_facilitylevel
  ON facility
  USING btree
  (facilitylevelid);

-- Index: fki_facilityowner

-- DROP INDEX fki_facilityowner;

CREATE INDEX fki_facilityowner
  ON facility
  USING btree
  (facilityownerid);

alter table facility add CONSTRAINT fk_villageid FOREIGN KEY(villageid) REFERENCES
 public.village(villageid);