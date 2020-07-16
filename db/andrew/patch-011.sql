/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  user
 * Created: Jun 26, 2018
 */

CREATE SCHEMA scheduleplan;
CREATE SEQUENCE scheduleplan.service_serviceid_seq
    INCREMENT 1
    START 3206
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
CREATE TABLE scheduleplan.service(
    serviceid bigint PRIMARY KEY DEFAULT nextval('scheduleplan.service_serviceid_seq'::regclass),
    serviceName varchar(255),
    facilityunitid bigint,
    dateadded date,    
    addedby bigint REFERENCES public.staff(staffid),
    dateupdated date,
    updatedby bigint REFERENCES public.staff(staffid),
     CONSTRAINT fk_facilityunit FOREIGN KEY (facilityunitid)
        REFERENCES public.facilityunit (facilityunitid)
);
CREATE SEQUENCE scheduleplan.servicedayplan_servicedayplanid_seq
    INCREMENT 1
    START 3206
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
CREATE TABLE scheduleplan.servicedayplan(
    servicedayplanid bigint PRIMARY KEY DEFAULT nextval('scheduleplan.servicedayplan_servicedayplanid_seq'::regclass),    
    serviceid bigint REFERENCES scheduleplan.service(serviceid),
    servicedayid int,
    desiredstaff int,
    startTime varchar(30),
    endTime varchar(30)
);
CREATE SEQUENCE scheduleplan.staffplan_staffplanid_seq
    INCREMENT 1
    START 3206
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
CREATE TABLE scheduleplan.staffplan(
    staffplanid bigint PRIMARY KEY DEFAULT nextval('scheduleplan.staffplan_staffplanid_seq'::regclass),    
    staffid bigint REFERENCES public.staff(staffid),
    staffplanweek int,
    staffplanyear varchar(30)
);

ALTER TABLE public.staff ADD COLUMN workinghours int DEFAULT 40;