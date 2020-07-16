/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: May 23, 2018
 */
CREATE OR REPLACE VIEW patient.viewlocation AS
 SELECT 
    loc.locationid,
    loc.fileno,
    us.zonelabel,
    us.zoneid,
    us.baylabel,
    us.zonebayid,
    us.bayrowid,
    us.rowlabel,
    us.bayrowcellid,
    us.celllabel,
    fu.facilityunitname
    FROM patient.filelocation loc
    JOIN store.unitstoragezones us ON loc.cellid = us.bayrowcellid
    JOIN facilityunit fu ON fu.facilityunitid = us.facilityunitid;
select * from  patient.viewlocation;
/* select * from  patient.viewlocation;*/
