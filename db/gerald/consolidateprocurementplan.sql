/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jun 6, 2018
 */

ALTER TABLE store.facilityunitfinancialyear ADD COLUMN consolidated BOOLEAN; 
ALTER TABLE store.facilityprocurementplan ADD COLUMN approved BOOLEAN;
ALTER TABLE store.facilityprocurementplan ADD COLUMN approvedby BIGINT;
ALTER TABLE store.facilityprocurementplan ADD COLUMN dateapproved date;
ALTER TABLE store.facilityprocurementplan ADD COLUMN approvalcomment VARCHAR;

DROP TABLE store.facilityprocurementplanitemupdates;
DROP VIEW store.facilityprocurementplanitems;

-- last queries on friday
ALTER TABLE store.facilityfinancialyear DROP COLUMN activationdate;
ALTER TABLE store.facilityfinancialyear ADD COLUMN financialyearstartdate date; 
ALTER TABLE store.facilityfinancialyear ADD COLUMN financialyearenddate date; 
ALTER TABLE store.facilityfinancialyear ADD COLUMN procuringopendate date; 
ALTER TABLE store.facilityfinancialyear ADD COLUMN procuringclosedate date; 
ALTER TABLE store.facilityfinancialyear ADD COLUMN approvalopendate date; 
ALTER TABLE store.facilityfinancialyear ADD COLUMN approvalclosedate date; 


-- LAST MONDAY QUERIES

ALTER TABLE store.facilityfinancialyear ADD COLUMN proccessstage VARCHAR;

