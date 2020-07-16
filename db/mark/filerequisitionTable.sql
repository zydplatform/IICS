/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jun 29, 2018
 */

select * from patient.filerequisition;
DROP TABLE patient.filerequisition;
CREATE TABLE patient.filerequisition(
requestid bigint PRIMARY KEY ,assignmentid bigint,requestedby bigint,
approvedby bigint,status varchar(100)NOT NULL,
requestdate TIMESTAMP,requesteddate TIMESTAMP,approveddate TIMESTAMP null);
CREATE SEQUENCE patient.filerequisition_requestid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.filerequisition ALTER COLUMN 
requestid SET DEFAULT
nextval('patient.filerequisition_requestid_seq'::regclass);