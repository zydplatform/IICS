/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: May 31, 2018
 */

select * from patient.patientfile;
CREATE TABLE patient.patientfile(
fileid bigint PRIMARY KEY ,fileno varchar(100)NOT NULL,pin varchar(100)NOT NULL,patientid bigint,
staffid varchar(100)NOT NULL,status varchar(100)NOT NULL,datecreated TIMESTAMP);
 CREATE SEQUENCE patient.patientfile_fileid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.patientfile ALTER COLUMN 
fileid SET DEFAULT
nextval('patient.patientfile_fileid_seq'::regclass);