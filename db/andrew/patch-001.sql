/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICSRemote
 * Created: Mar 27, 2018
 */
CREATE TABLE store.storagemechanism
(
    storagemechanismid bigint NOT NULL,
    storagemechanismname character varying(30) COLLATE pg_catalog."default",
    CONSTRAINT storagemechanism_pkey PRIMARY KEY (storagemechanismid)
);
CREATE TABLE store.storagetype
(
    storagetype bigint NOT NULL,
    storagetypename character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT storagetype_pkey PRIMARY KEY (storagetype)
);
CREATE TABLE store.zone(zoneid int PRIMARY KEY, zonelabel VARCHAR(255), searchstate BOOLEAN,storagetypeid bigint REFERENCES store.storagetype(storagetype), facilityunitid bigint REFERENCES public.facilityunit(facilityunitid), lastupdated TIMESTAMP, lastupdatedby int REFERENCES public.systemuser(systemuserid),dateadded date, addedby int REFERENCES public.systemuser(systemuserid));
CREATE TABLE store.zonebay(zonebayid int PRIMARY KEY, baylabel VARCHAR(255), storagemechanismid int REFERENCES store.storagemechanism(storagemechanismid),zoneid int REFERENCES store.zone(zoneid),celltransactionlimit int);
CREATE TABLE store.bayrow(bayrowid int PRIMARY KEY, rowlabel VARCHAR(255),zonebayid int REFERENCES store.zonebay(zonebayid));
CREATE TABLE store.bayrowcell(bayrowcellid int PRIMARY KEY, celllabel VARCHAR(255),bayrowid int REFERENCES store.bayrow(bayrowid));