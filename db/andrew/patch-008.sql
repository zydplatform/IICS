/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  user
 * Created: May 21, 2018
 */

CREATE SEQUENCE controlpanel.schedules_schedulesid_seq
    INCREMENT 1
    START 3206
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE controlpanel.schedules(
    schedulesid bigint PRIMARY KEY DEFAULT nextval('controlpanel.schedules_schedulesid_seq'::regclass),
    startdate varchar(30),
    enddate varchar(30),
    schedulestatus varchar(30),
    staffid bigint REFERENCES public.staff(staffid),
    serviceid bigint REFERENCES public.service(serviceid),
    dateadded date,    
    addedby bigint REFERENCES public.staff(staffid),
    dateupdated date,
    updatedby bigint REFERENCES public.staff(staffid)
);

CREATE SEQUENCE controlpanel.scheduleday_scheduledayid_seq
    INCREMENT 1
    START 3206
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
CREATE TABLE controlpanel.scheduleday(
    scheduledayid bigint PRIMARY KEY DEFAULT nextval('controlpanel.scheduleday_scheduledayid_seq'::regclass),
    weekday varchar(30),
    schedulesid  bigint REFERENCES controlpanel.schedules(schedulesid)
);

CREATE SEQUENCE controlpanel.scheduledaysession_scheduledaysessionid_seq
    INCREMENT 1
    START 3206
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    CREATE TABLE controlpanel.scheduledaysession(
    scheduledaysessionid bigint PRIMARY KEY DEFAULT nextval('controlpanel.scheduledaysession_scheduledaysessionid_seq'::regclass),
    starttime varchar(30),
    endtime varchar(30),
    scheduledayid  bigint REFERENCES controlpanel.scheduleday(scheduledayid)
);