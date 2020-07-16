/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: 23-May-2018
 */

CREATE TABLE facilitystructure
(
  structureid bigint NOT NULL,
  hierachylabel character varying NOT NULL DEFAULT 25,
  description text,
  active boolean NOT NULL DEFAULT true,
  facilityid integer NOT NULL,
  parentid bigint,
  addedby bigint NOT NULL,
  dateadded timestamp without time zone NOT NULL,
  updatedby bigint,
  dateupdated timestamp without time zone,
  "position" integer NOT NULL,
  isparent boolean,
  units integer,
  items integer,
  CONSTRAINT "PK_FacilityStructureId" PRIMARY KEY (structureid),
  CONSTRAINT "FK_RefAddedByPerson" FOREIGN KEY (addedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_Ref_Facility" FOREIGN KEY (facilityid)
      REFERENCES facility (facilityid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_Ref_ParentLayer" FOREIGN KEY (parentid)
      REFERENCES facilitystructure (structureid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_Ref_UpdatedByPerson" FOREIGN KEY (updatedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE facilitystructure
  OWNER TO postgres;


-- Facility Unit Table Update

ALTER TABLE facilityunit ADD COLUMN structureid bigint;
ALTER TABLE facilityunit ADD COLUMN parentid bigint;

ALTER TABLE facilityunit ADD COLUMN dateupdated timestamp without time zone;

ALTER TABLE facilityunit ADD COLUMN updatedby bigint;

ALTER TABLE facilityunit ADD COLUMN addedby bigint;

ALTER TABLE facilityunit ADD COLUMN dateadded timestamp without time zone;
ALTER TABLE facilityunit
  ADD CONSTRAINT "FK_RefAddedByPerson" FOREIGN KEY (addedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE facilityunit
  ADD CONSTRAINT "FK_RefUpdatedByPerson" FOREIGN KEY (updatedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE facilityunit
  ADD CONSTRAINT "FK_RefStructure" FOREIGN KEY (structureid)
      REFERENCES facilitystructure (structureid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

--New--
alter TABLE public.computerloghistory ADD COLUMN useragent text;