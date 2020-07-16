/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jun 29, 2018
 */

select * from patient.fileassignmentactivity;

CREATE TABLE patient.fileassignmentactivity(
activityid bigint PRIMARY KEY,
assignmentid bigint,
staffid bigint,
assignmentaction text,
actionDate TIMESTAMP);
 CREATE SEQUENCE patient.fileassignmentactivity_activityid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.fileassignmentactivity ALTER COLUMN 
activityid SET DEFAULT
nextval('patient.fileassignmentactivity_activityid_seq'::regclass);
