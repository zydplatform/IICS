/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**


 * Author:  IICS
 * Created: Jun 7, 2018
 */
select * from patient.userfileassignment;
drop TABLE patient.userfileassignment;

CREATE TABLE patient.userfileassignment(
assignmentid bigint PRIMARY KEY ,fileno varchar(100)NOT NULL,issuedbystaffid bigint,
recievedbystaffid bigint,currentlocation bigint, status varchar(100)NOT NULL,dateassigned TIMESTAMP,datereturned TIMESTAMP);
 CREATE SEQUENCE patient.userfileassignment_assignmentid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE patient.userfileassignment ALTER COLUMN 
assignmentid SET DEFAULT
nextval('patient.userfileassignment_assignmentid_seq'::regclass);
