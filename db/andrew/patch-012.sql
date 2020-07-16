/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  user
 * Created: Jun 26, 2018
 */
CREATE TABLE scheduleplan.staffservice(
    staffserviceid bigint PRIMARY KEY,    
    staffid bigint,
    serviceid bigint
);
CREATE TABLE scheduleplan.staffplandetail(
    staffplandetailid bigint PRIMARY KEY,    
    staffplanid bigint,
    plandetailday int,
    planStarttime varchar(30),
    planEndtime varchar(30),
    staffserviceid bigint 
);
CREATE SEQUENCE scheduleplan.staffservice_staffserviceid_seq
    INCREMENT 1
    START 3206
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
  
ALTER TABLE scheduleplan.staffservice  ALTER COLUMN staffserviceid SET DEFAULT nextval('scheduleplan.staffservice_staffserviceid_seq'::regclass);


CREATE SEQUENCE scheduleplan.staffplandetail_staffplandetailid_seq
    INCREMENT 1
    START 3206
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;    
ALTER TABLE scheduleplan.staffplandetail  ALTER COLUMN staffplandetailid SET DEFAULT nextval('scheduleplan.staffplandetail_staffplandetailid_seq'::regclass);

ALTER TABLE scheduleplan.staffservice ADD CONSTRAINT fk_staffid FOREIGN KEY(staffid) REFERENCES staff(staffid);
ALTER TABLE scheduleplan.service ADD CONSTRAINT fk_serviceid FOREIGN KEY(serviceid) REFERENCES scheduleplan.service(serviceid);









