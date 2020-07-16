/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  RESEARCH
 * Created: Jul 25, 2018
 */

CREATE TABLE assetsmanager.facilityunitroom(facilityunitroomid int PRIMARY KEY, facilityunitid bigint references public.facilityunit(facilityunitid), blockroomid int references assetsmanager.blockroom(blockroomid),dateadded date, dateupdated date, addedby bigint, updatedby bigint);
CREATE TABLE assetsmanager.facilityunitroomservice(facilityunitroomserviceid int PRIMARY KEY, facilityunitroomid int references assetsmanager.facilityunitroom(facilityunitroomid), facilityunitservice bigint references public.facilityunitservice(facilityunitserviceid), dateadded date, dateupdated date, addedby bigint, updatedby bigint);
ALTER TABLE assetsmanager.facilityunitroom add column roomstatus text;
CREATE SEQUENCE assetsmanager.facilityunitroom_facilityunitroomid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE assetsmanager.facilityunitroom ALTER COLUMN facilityunitroomid SET DEFAULT nextval('assetsmanager.facilityunitroom_facilityunitroomid_seq'::regclass);
CREATE SEQUENCE assetsmanager.facilityunitroomservice_facilityunitroomserviceid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE assetsmanager.facilityunitroomservice ALTER COLUMN facilityunitroomserviceid SET DEFAULT nextval('assetsmanager.facilityunitroomservice_facilityunitroomserviceid_seq'::regclass);