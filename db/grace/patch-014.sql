/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  HP
 * Created: Sep 11, 2018
 */

CREATE OR REPLACE VIEW patient.patientfacilityregister AS SELECT pa.patientid,
    pa.personid,
    pa.patientno,
    pa.datecreated,
    pa.facilityid,
    per.dob,
    per.gender,
    CONCAT(firstname, ' ', lastname, ' ', othernames) as fullname,
    CAST(date_part('DAY', now() - per.dob) AS INTEGER) AS age,
    l.villagename,
    l.parishname
    FROM patient.patient pa
    JOIN person per ON pa.personid = per.personid
    JOIN public.locations l on(per.currentaddress = l.villageid);