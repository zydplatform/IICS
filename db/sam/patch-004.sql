/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  samuelwam <samuelwam@gmail.com>
 * Created: Jul 20, 2018
 */

CREATE TABLE facilityservices
(
  serviceid integer NOT NULL,
  active boolean NOT NULL,
  dateadded timestamp without time zone,
  dateupdated timestamp without time zone,
  servicename character varying(255),
  description character varying(255),
  servicekey character varying(25),
  addedby bigint NOT NULL,
  updatedby bigint,
  released boolean NOT NULL,
  units integer,
  CONSTRAINT facilityservices_pkey PRIMARY KEY (serviceid),
  CONSTRAINT fk_addedbyperson FOREIGN KEY (addedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_updatedbyperson FOREIGN KEY (updatedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE TABLE facilityunitservice
(
  facilityunitserviceid bigint NOT NULL,
  description character varying(255),
  servicename character varying(255),
  status boolean NOT NULL,
  dateadded timestamp without time zone NOT NULL DEFAULT now(),
  dateupdated timestamp without time zone,
  updatedby bigint,
  serviceid bigint,
  addedby bigint,
  facilityunitid bigint,
  CONSTRAINT facilityunitservice_pkey PRIMARY KEY (facilityunitserviceid),
  CONSTRAINT "FK_AddedBy" FOREIGN KEY (addedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_FacilityunitRef" FOREIGN KEY (facilityunitid)
      REFERENCES facilityunit (facilityunitid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_ServiceRef" FOREIGN KEY (serviceid)
      REFERENCES facilityservices (serviceid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_UpdatedBy" FOREIGN KEY (updatedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);