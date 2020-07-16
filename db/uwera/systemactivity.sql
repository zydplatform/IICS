CREATE TABLE systemactivity
(
  activityid integer NOT NULL,
  active boolean NOT NULL,
  activitykey character varying(25),
  activityname character varying(255),
  dateadded timestamp without time zone,
  dateupdated timestamp without time zone,
  description character varying(255),
  released boolean NOT NULL,
  units integer,
  addedby bigint NOT NULL,
  updatedby bigint,
  CONSTRAINT systemactivity_pkey PRIMARY KEY (activityid),
  CONSTRAINT fk_g8oyx1gpmutk1c1v7fgi64o3h FOREIGN KEY (updatedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_ky9r1il8w0iyjtjfto1shfumw FOREIGN KEY (addedby)
      REFERENCES person (personid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE systemactivity
  OWNER TO postgres;