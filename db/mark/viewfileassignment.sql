/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jun 8, 2018
 */
drop VIEW patient.viewfilefileassignment;

CREATE OR REPLACE VIEW patient.viewfilefileassignment AS
 SELECT
    ass.assignmentid,
    ass.fileno,
    f.fileid,
    ass.dateassigned,
    ass.datereturned,
    ass.status,
    ass.issuedbystaffid,
    ass.recievedbystaffid,
    ass.currentlocation,
    pn.firstname,
    pn.lastname,
    pn.othernames
   FROM patient.userfileassignment ass
   JOIN staff stf  ON stf.staffid =ass.issuedbystaffid
   JOIN person pn ON pn.personid=stf.personid
   JOIN patient.patientfile f ON f.fileno=ass.fileno;
   select* from patient.viewfilefileassignment;