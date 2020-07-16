/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jun 14, 2018
 */
ALTER TABLE services SET SCHEMA controlpanel;
ALTER TABLE autoactivityrunsetting SET SCHEMA controlpanel;
CREATE SEQUENCE controlpanel.autoactivityrunsetting_autoactivityrunsettingid_seq
    INCREMENT 1
    START 73346
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE controlpanel.autoactivityrunsetting ALTER COLUMN autoactivityrunsettingid SET DEFAULT nextval('controlpanel.autoactivityrunsetting_autoactivityrunsettingid_seq'::regclass);

CREATE SEQUENCE controlpanel.services_serviceid_seq
    INCREMENT 1
    START 54
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE controlpanel.services ALTER COLUMN serviceid SET DEFAULT nextval('controlpanel.services_serviceid_seq'::regclass);
ALTER TABLE controlpanel.autoactivityrunsetting ADD COLUMN addedby BIGINT;
ALTER TABLE controlpanel.autoactivityrunsetting ADD CONSTRAINT fk_person FOREIGN KEY (addedby) REFERENCES person(personid);
ALTER TABLE controlpanel.autoactivityrunsetting ADD COLUMN lastupdatedby BIGINT;
ALTER TABLE controlpanel.autoactivityrunsetting ADD CONSTRAINT fk_personupdate FOREIGN KEY (lastupdatedby) REFERENCES person(personid);
UPDATE controlpanel.autoactivityrunsetting
	SET  addedby=459;

truncate table controlpanel.autoactivityrunsetting cascade;
ALTER SEQUENCE controlpanel.services_serviceid_seq START WITH 1; 
ALTER SEQUENCE controlpanel.autoactivityrunsetting_autoactivityrunsettingid_seq START WITH 1; 






