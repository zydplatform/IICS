/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Grace-K
 * Created: Apr 6, 2018
 */
CREATE SCHEMA patient;

CREATE TABLE patient.facilityunitblock(facilityunitblockid int PRIMARY KEY, active boolean, facilityunitid bigint REFERENCES public.facilityunit(facilityunitid), minval int, maxval int, currentval int);


CREATE OR REPLACE FUNCTION patient.function_increment(i INT)
RETURNS integer AS $total$
DECLARE
	pin integer;
BEGIN
   SELECT currentval into pin FROM patient.facilityunitblock where facilityunitid = i;
   UPDATE patient.facilityunitblock set currentval = currentval + 1 where facilityunitid = i;
   RETURN pin;
END;
$total$ 
LANGUAGE plpgsql;

ALTER TABLE patient.patient ADD pin int;

ALTER TABLE patient.patient ALTER COLUMN patientid DROP DEFAULT;
