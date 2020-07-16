/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jul 12, 2018
 */
select* from patient.viewfilepage;
drop VIEW patient.viewfilepage;
 CREATE OR REPLACE VIEW patient.viewfilepage AS
 SELECT doc.documentid,
    doc.fileno,
    page.pageid
   FROM patient.documenttable doc
   JOIN patient.filepage page 
   ON page.doctumentid =doc.documentid;
