ALTER TABLE person ADD nin VARCHAR(255);

ALTER TABLE person ALTER COLUMN dob DROP NOT NULL;

ALTER TABLE nextofkin ALTER COLUMN phonecontact DROP NOT NULL;

DROP VIEW patient.searchpatient;

ALTER TABLE patient.patient DROP COLUMN pin;

CREATE OR REPLACE VIEW patient.searchpatient AS
 SELECT per.personid,
    per.firstname,
    per.lastname,
    per.othernames,
    per.facilityid,
    per.currentaddress,
    pat.patientno,
    pat.patientid
    LOWER(CONCAT(firstname,lastname,othernames)) as permutation1,
    LOWER(CONCAT(lastname,othernames,firstname)) as permutation2,
    LOWER(CONCAT(lastname,firstname)) as permutation3
    FROM public.person per
        JOIN patient.patient pat ON per.personid = pat.personid;