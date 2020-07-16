/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jun 5, 2018
 */

select* from patient.viewfiledocument;
drop view patient.viewfiledocument;
CREATE OR REPLACE VIEW patient.viewfiledocument AS
 SELECT doc.documentid,
    doc.description,
    doc.datecreated,
    doc.fileno,
    doc.staffid,
    pn.firstname,
    pn.lastname
   FROM patient.documenttable doc
   JOIN staff stf ON stf.staffid =doc.staffid
   JOIN person pn ON pn.personid = stf.personid;
 
