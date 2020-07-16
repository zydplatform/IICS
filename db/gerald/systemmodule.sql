/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  RESEARCH
 * Created: Apr 24, 2018
 */

CREATE SEQUENCE controlpanel.systemmodule_systemmoduleid_seq
    INCREMENT 1
    START 336
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE controlpanel.systemmodule ALTER COLUMN systemmoduleid SET DEFAULT nextval('controlpanel.systemmodule_systemmoduleid_seq'::regclass);
ALTER TABLE  controlpanel.systemmodule DROP CONSTRAINT "FK_ModuleUpdatedBy_Staff_Ref_Staff";
ALTER TABLE  controlpanel.systemmodule DROP CONSTRAINT "FK_ModuleAddedBy_Staff_Ref_Staff";
ALTER TABLE controlpanel.systemmodule ADD CONSTRAINT fk_addedby_person FOREIGN KEY(addedby) REFERENCES person(personid); 
ALTER TABLE controlpanel.systemmodule ADD CONSTRAINT fk_updatedby_person FOREIGN KEY(updatedby) REFERENCES person(personid); 