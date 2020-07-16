/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  RESEARCH
 * Created: Aug 13, 2018
 */

CREATE TABLE store.externalfacilityorders(externalfacilityordersid int PRIMARY KEY, neworderno varchar, approvalstartdate date, approvalenddate date, orderingstart date, orderingenddate date, approvedby bigint, orderstatus varchar default 'NOT APPROVED', dateapproved date);
CREATE SEQUENCE store.externalfacilityorders_externalfacilityordersid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    ALTER TABLE store.externalfacilityorders ALTER COLUMN externalfacilityordersid SET DEFAULT nextval('store.externalfacilityorders_externalfacilityordersid_seq'::regclass);
ALTER TABLE store.facilityorder ADD COLUMN externalfacilityordersid int references store.externalfacilityorders(externalfacilityordersid);
ALTER TABLE store.facilityorderitems ADD COLUMN isconsolidated Boolean DEFAULT FALSE;
ALTER TABLE store.externalfacilityorders ADD COLUMN  facilityid int references facility(facilityid);
ALTER TABLE store.externalfacilityorders ADD COLUMN isactive Boolean DEFAULT TRUE;
