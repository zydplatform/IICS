ALTER TABLE patient.maternitychildinfo
ADD COLUMN isregistered boolean;
ALTER TABLE patient.maternitychildinfo
 ADD COLUMN patientid bigint;

ALTER TABLE patient.maternitychildinfo
 ADD COLUMN birthnotificationgiven boolean;
ALTER TABLE patient.maternitychildinfo
 ADD COLUMN birthnotificationdate date;
