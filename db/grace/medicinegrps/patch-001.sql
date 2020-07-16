/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  HP
 * Created: Nov 16, 2018
 */

CREATE TABLE store.medicinegroup(
    medicinegroupid bigint PRIMARY KEY,
    groupname Varchar(255),
    description text,
    addedby bigint REFERENCES staff(staffid),
    lastupdatedby bigint REFERENCES staff(staffid),
    dateadded date,
    lastupdated date
);

CREATE SEQUENCE store.medicine_group_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807;

ALTER TABLE store.medicinegroup ALTER COLUMN medicinegroupid SET DEFAULT nextval('store.medicine_group_seq'::regclass);
