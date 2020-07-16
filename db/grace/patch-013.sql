/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS-GRACE
 * Created: Jul 30, 2018
 */

DROP VIEW patient.patientstartisticsview;
CREATE OR REPLACE VIEW patient.patientstartisticsview AS SELECT pa.patientid,
    pa.personid,
    pa.patientno,
    pa.datecreated,
    pa.facilityid AS registrationfacilityid,
    per.dob,
    per.gender,
    vis.patientvisitid,
    vis.dateadded,
    vis.visitpriority,
    vis.visittype,
    vis.visitnumber,
    vis.facilityunitid,
    fu.facilityid,
    CONCAT(firstname, ' ', lastname, ' ', othernames) as fullname,
    CAST(date_part('DAY', now() - per.dob) AS INTEGER) AS age,
    l.villagename,
    l.parishname
    FROM patient.patient pa
    JOIN person per ON pa.personid = per.personid
    JOIN patient.patientvisit vis ON vis.patientid = pa.patientid
    JOIN public.facilityunit fu ON vis.facilityunitid = fu.facilityunitid
    JOIN public.locations l on(per.currentaddress = l.villageid);
