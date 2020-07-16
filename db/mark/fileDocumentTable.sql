/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jun 5, 2018


drop TABLE patient.documenttable
 */
select* from patient.documenttable;
Drop TABLE patient.documenttable;
CREATE TABLE patient.documenttable(documentid bigint PRIMARY KEY , 
docname varchar(100) NOT NULL,description text,fileno varchar(100) NOT NULL,staffid bigint,datecreated TIMESTAMP);
CREATE SEQUENCE patient.documenttable_documentid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.documenttable ALTER COLUMN 
documentid SET DEFAULT
nextval('patient.documenttable_documentid_seq'::regclass);