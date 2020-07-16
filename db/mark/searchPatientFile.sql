/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: May 31, 2018
drop VIEW patient.searchpatientfile;
 */
select * from patient.searchpatientfile;

drop VIEW patient.searchpatientfile;
CREATE OR REPLACE VIEW patient.searchpatientfile AS
 SELECT per.personid,
    per.firstname,
    per.lastname,
    per.othernames,
    per.facilityid,
    f.patientid,
    f.fileid,
    f.fileno,
    f.staffid,
    f.status,
    f.datecreated
   FROM public.person per
   JOIN patient.patient pat ON per.personid = pat.personid
   JOIN  patient.patientfile f ON f.patientid = pat.patientid;
