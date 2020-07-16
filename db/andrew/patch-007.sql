/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: 18-May-2018
 */
CREATE SEQUENCE store.zone_zoneid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    
ALTER TABLE store.zone ALTER COLUMN zoneid SET DEFAULT nextval('store.zone_zoneid_seq'::regclass);

CREATE SEQUENCE store.zone_zonebayid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    
ALTER TABLE store.zonebay ALTER COLUMN zonebayid SET DEFAULT nextval('store.zone_zonebayid_seq'::regclass);

CREATE SEQUENCE store.zone_bayrowid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    
ALTER TABLE store.bayrow ALTER COLUMN bayrowid SET DEFAULT nextval('store.zone_bayrowid_seq'::regclass);

CREATE SEQUENCE store.zone_bayrowcellid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    
ALTER TABLE store.bayrowcell ALTER COLUMN bayrowcellid SET DEFAULT nextval('store.zone_bayrowcellid_seq'::regclass);

