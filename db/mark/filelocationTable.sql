/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: May 23, 2018
 */
select * from patient.filelocation;
drop TABLE patient.filelocation;

CREATE TABLE patient.filelocation(
locationid bigint PRIMARY KEY ,fileno varchar(100)NOT NULL,zoneid bigint NOT NULL,
cellid bigint NOT NULL,datecreated TIMESTAMP);
 CREATE SEQUENCE patient.filelocation_locationid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.filelocation ALTER COLUMN 
locationid SET DEFAULT
nextval('patient.filelocation_locationid_seq'::regclass);