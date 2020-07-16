/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jun 20, 2018
 */

ALTER TABLE controlpanel.services ADD COLUMN terminationreason VARCHAR;
ALTER TABLE controlpanel.services DROP COLUMN changedby;
ALTER TABLE controlpanel.services ADD COLUMN changedby BIGINT;
ALTER TABLE controlpanel.services DROP COLUMN createdby;
ALTER TABLE controlpanel.services ADD COLUMN createdby BIGINT;
ALTER TABLE controlpanel.services ADD CONSTRAINT  fk_createdby FOREIGN KEY(createdby) REFERENCES person(personid);
ALTER TABLE controlpanel.services ADD CONSTRAINT  fk_changedby FOREIGN KEY(changedby) REFERENCES person(personid);