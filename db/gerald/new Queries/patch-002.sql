/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jul 17, 2018
 */

CREATE TABLE controlpanel.facilityprivilege
(
    facilityprivilegeid bigint NOT NULL,
    facilityid integer,
    privilegeid bigint,
    isactive boolean,
    addedby bigint,
    dateadded date,
    lastupdated date,
    lastupdatedby bigint,
    CONSTRAINT facilityprivilege_pkey PRIMARY KEY (facilityprivilegeid)
);
ALTER TABLE controlpanel.facilityprivilege ADD CONSTRAINT fk_privilege FOREIGN KEY(privilegeid) REFERENCES controlpanel.privilege(privilegeid);
ALTER TABLE controlpanel.facilityprivilege ADD CONSTRAINT fk_facility FOREIGN KEY(facilityid) REFERENCES facility(facilityid);
ALTER TABLE controlpanel.accessrightgroupprivilege ADD COLUMN facilityprivilegeid BIGINT;
ALTER TABLE controlpanel.accessrightgroupprivilege ADD CONSTRAINT fk_facilityprivilege FOREIGN KEY(facilityprivilegeid) REFERENCES controlpanel.facilityprivilege(facilityprivilegeid);


CREATE SEQUENCE store.itemcategorisation_itemcategorisationid_seq
    INCREMENT 1
    START 223
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE store.itemcategorisation ALTER itemcategorisationid SET default nextval('store.itemcategorisation_itemcategorisationid_seq'::regclass);

CREATE SEQUENCE  controlpanel.facilityprivilege_facilityprivilegeid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER TABLE controlpanel.facilityprivilege ALTER facilityprivilegeid SET default nextval('controlpanel.facilityprivilege_facilityprivilegeid_seq'::regclass);

ALTER TABLE store.item ADD COLUMN issupplies BOOLEAN;
ALTER TABLE store.item ADD COLUMN specification VARCHAR;
ALTER TABLE store.itemclassification ADD COLUMN ismedicine BOOLEAN;































