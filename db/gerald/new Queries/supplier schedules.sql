/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  HP
 * Created: Oct 3, 2018
 */

CREATE TABLE controlpanel.facilityunitschedule
(
    facilityunitscheduleid bigint NOT NULL,
    facilityunitid bigint,
    scheduleid integer,
    CONSTRAINT facilityunitschedule_pkey PRIMARY KEY (facilityunitscheduleid)
);

CREATE SEQUENCE controlpanel.facilityunitschedule_facilityunitscheduleid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE controlpanel.facilityunitschedule ALTER COLUMN facilityunitscheduleid SET DEFAULT nextval('controlpanel.facilityunitschedule_facilityunitscheduleid_seq'::regclass);

ALTER TABLE controlpanel.facilityunitschedule ADD CONSTRAINT fk_facilityunit FOREIGN KEY(facilityunitid) REFERENCES facilityunit(facilityunitid);
ALTER TABLE controlpanel.facilityunitschedule ADD CONSTRAINT fk_schedule FOREIGN KEY(scheduleid) REFERENCES controlpanel.schedule(scheduleid);