DROP TABLE domaindesignationcategory;

DROP TABLE designationcategoryfacility;

DROP TABLE domainlevel;

ALTER TABLE facilitylevel ADD facilitydomain int REFERENCES facilitydomain(facilitydomainid);

ALTER TABLE designationcategory ADD addedby bigint REFERENCES staff(staffid);

ALTER TABLE designationcategory ADD lastupdatedby bigint REFERENCES staff(staffid);

ALTER TABLE designationcategory ADD dateadded date;

ALTER TABLE designationcategory ADD datelastupdated date;

ALTER TABLE designationcategory ADD facilityid int REFERENCES facility(facilityid);