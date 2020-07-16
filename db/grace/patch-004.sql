/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Grace-K
 * Created: Apr 13, 2018
 */
DROP VIEW patient.searchpatient;

CREATE OR REPLACE VIEW patient.searchpatient AS
 SELECT per.personid,
    per.firstname,
    per.lastname,
    per.othernames,
    per.facilityid,
    per.currentaddress,
    pat.pin,
    pat.patientid
   FROM public.person per
    JOIN patient.patient pat ON per.personid = pat.personid;
