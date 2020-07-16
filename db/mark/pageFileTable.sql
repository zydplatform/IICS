/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jun 20, 2018
 */

select * from  patient.filepage;

CREATE TABLE patient.filepage(pageid bigint PRIMARY KEY ,
 doctumentid bigint,link text,pagenumber varchar(100)NOT NULL
 );
CREATE SEQUENCE patient.filepage_pageid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.filepage ALTER COLUMN 
pageid SET DEFAULT
nextval('patient.filepage_pageid_seq'::regclass);