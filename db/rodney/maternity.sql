

CREATE SEQUENCE controlpanel.maternitysettings_maternitysettings_seq;

ALTER SEQUENCE controlpanel.maternitysettings_maternitysettings_seq
    OWNER TO postgres;



CREATE SEQUENCE patient.maternity_childno_seq;

ALTER SEQUENCE patient.maternity_childno_seq
    OWNER TO postgres;



CREATE SEQUENCE patient.maternity_ipdno_seq;

ALTER SEQUENCE patient.maternity_ipdno_seq
    OWNER TO postgres;

CREATE SEQUENCE patient.maternity_maternity_childinfoid;

ALTER SEQUENCE patient.maternity_maternity_childinfoid
    OWNER TO postgres;


CREATE SEQUENCE patient.maternity_maternity_seq;

ALTER SEQUENCE patient.maternity_maternity_seq
    OWNER TO postgres;


CREATE SEQUENCE patient.maternityadmission_maternityadmission_seq;

ALTER SEQUENCE patient.maternityadmission_maternityadmission_seq
    OWNER TO postgres;



CREATE SEQUENCE patient.maternitypatientpause_patientpauseid_seq;

ALTER SEQUENCE patient.maternitypatientpause_patientpauseid_seq
    OWNER TO postgres;

CREATE SEQUENCE patient.triagepausesequence;

ALTER SEQUENCE patient.triagepausesequence
    OWNER TO postgres;


CREATE SEQUENCE patient.patientfinaldiagnosis_diagnosisid_seq;

ALTER SEQUENCE patient.patientfinaldiagnosis_diagnosisid_seq
    OWNER TO postgres;


CREATE TABLE controlpanel.maternitysettings
(
    id bigint NOT NULL DEFAULT nextval('controlpanel.maternitysettings_maternitysettings_seq'::regclass),
    dropdowntitle character varying(256) COLLATE pg_catalog."default",
    dropdownoptions character varying(750) COLLATE pg_catalog."default",
    CONSTRAINT maternitysettings_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE controlpanel.maternitysettings
    OWNER to postgres;


CREATE TABLE patient.childno
(
    childnoid bigint NOT NULL DEFAULT nextval('patient.maternity_childno_seq'::regclass),
    facilityunitid bigint NOT NULL,
    currentvalue integer NOT NULL,
    dateadded date NOT NULL,
    CONSTRAINT childno_pkey PRIMARY KEY (childnoid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE patient.childno
    OWNER to postgres;


ALTER TABLE public.facilityservices
    ALTER COLUMN serviceid SET DEFAULT nextval('facilityservice_serviceid_seq'::regclass);

CREATE TABLE patient.ipdno
(
    ipdnoid bigint NOT NULL DEFAULT nextval('patient.maternity_ipdno_seq'::regclass),
    facilityunitid bigint NOT NULL,
    currentvalue integer NOT NULL,
    dateadded date NOT NULL,
    CONSTRAINT ipdno_pkey PRIMARY KEY (ipdnoid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE patient.ipdno
    OWNER to postgres;


CREATE TABLE patient.maternity
(
    maternityid bigint NOT NULL DEFAULT nextval('patient.maternity_maternity_seq'::regclass),
    admissiondate timestamp without time zone,
    ipdno character varying(255) COLLATE pg_catalog."default",
    patientvisitid bigint,
    patientid bigint,
    personisalive boolean,
    ancnoandref character varying COLLATE pg_catalog."default",
    finaldiagnosis character varying(255) COLLATE pg_catalog."default",
    whoclinicalstage character varying(255) COLLATE pg_catalog."default",
    modeofdelivery character varying(255) COLLATE pg_catalog."default",
    managementof3rdstagelabour character varying(255) COLLATE pg_catalog."default",
    othertreatmentgiven character varying(255) COLLATE pg_catalog."default",
    emtctcode character varying(255) COLLATE pg_catalog."default",
    arvstomothers character varying(255) COLLATE pg_catalog."default",
    vitasupplementation boolean,
    muaccolorcode character varying(20) COLLATE pg_catalog."default",
    muacmeasurement numeric(19,2),
    inrno character varying(255) COLLATE pg_catalog."default",
    familyplanningmethodgiven character varying(255) COLLATE pg_catalog."default",
    conditionofmotherondischarge character varying(255) COLLATE pg_catalog."default",
    conditionofbabyondischarge character varying(255) COLLATE pg_catalog."default",
    deliveredby character varying(255) COLLATE pg_catalog."default",
    nameofpersondischarging character varying(255) COLLATE pg_catalog."default",
    admissionid bigint NOT NULL,
    pncbabywithin6h date,
    pncmotherwithin6h date,
    numberofchildren bigint,
    CONSTRAINT maternity_pkey PRIMARY KEY (maternityid),
    CONSTRAINT fk_admissionid FOREIGN KEY (admissionid)
        REFERENCES patient.maternityadmission (admissionid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_patientvisit FOREIGN KEY (patientvisitid)
        REFERENCES patient.patientvisit (patientvisitid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE patient.maternity
    OWNER to postgres;



CREATE TABLE patient.maternityadmission
(
    admissionid bigint NOT NULL DEFAULT nextval('patient.maternityadmission_maternityadmission_seq'::regclass),
    ipdno character varying(255) COLLATE pg_catalog."default",
    patientvisitid bigint,
    datetimein timestamp without time zone,
    datetimeout timestamp without time zone,
    dischargedby character varying(255) COLLATE pg_catalog."default",
    addedby bigint,
    cancelled boolean,
    discharged boolean,
    admitted boolean,
    cancelreason character varying(255) COLLATE pg_catalog."default",
    unitserviceid numeric(19,2),
    CONSTRAINT maternityadmission_pkey PRIMARY KEY (admissionid),
    CONSTRAINT fk_addedby FOREIGN KEY (addedby)
        REFERENCES public.staff (staffid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_patientvisit FOREIGN KEY (patientvisitid)
        REFERENCES patient.patientvisit (patientvisitid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE patient.maternityadmission
    OWNER to postgres;


CREATE TABLE patient.maternitychildinfo
(
    childinfoid bigint NOT NULL DEFAULT nextval('patient.maternity_maternity_childinfoid'::regclass),
    childid character varying(255) COLLATE pg_catalog."default",
    patientidmother bigint,
    apgarscore integer,
    sex character varying(7) COLLATE pg_catalog."default",
    notbreathingatbirth character varying(255) COLLATE pg_catalog."default",
    skintoskincontact boolean,
    breastfedunder1hrs boolean,
    routinemedicationteo boolean,
    routinemedicationvitk boolean,
    routinemedicationchlorhexidine boolean,
    counselingatdischarge character varying(255) COLLATE pg_catalog."default",
    maternutrcouns character varying(255) COLLATE pg_catalog."default",
    iycf character varying(255) COLLATE pg_catalog."default",
    infantfeedingoption character varying(255) COLLATE pg_catalog."default",
    weightofbaby numeric(19,2),
    arvsgiventobaby character varying(255) COLLATE pg_catalog."default",
    bcgimmunisation "char",
    polioimmunisation "char",
    dateofdelivery date,
    timeofdelivery character varying(10) COLLATE pg_catalog."default",
    addedby bigint,
    edittedby bigint,
    status character varying(50) COLLATE pg_catalog."default",
    maternityid bigint,
    ipdno character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT childinfo_pkey PRIMARY KEY (childinfoid),
    CONSTRAINT fk_patientidmother FOREIGN KEY (patientidmother)
        REFERENCES patient.patient (patientid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE patient.maternitychildinfo
    OWNER to postgres;


CREATE TABLE patient.maternitypatientpause
(
    patientpauseid integer NOT NULL DEFAULT nextval('patient.maternitypatientpause_patientpauseid_seq'::regclass),
    addedby bigint,
    paused boolean,
    dateadded date,
    patientvisitid bigint,
    facilityunit bigint,
    CONSTRAINT maternitypatientpause_pkey PRIMARY KEY (patientpauseid),
    CONSTRAINT fk_addedby FOREIGN KEY (addedby)
        REFERENCES public.staff (staffid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE patient.maternitypatientpause
    OWNER to postgres;


ALTER TABLE patient.servicequeue
    ADD COLUMN moduleidentifier character varying(30) COLLATE pg_catalog."default" DEFAULT 'general'::character varying;


CREATE TABLE patient.triagepause
(
    triagepauseid integer NOT NULL DEFAULT nextval('patient.triagepausesequence'::regclass),
    addedby bigint,
    paused boolean,
    dateadded date,
    patientvisitid bigint,
    facilityunit bigint,
    CONSTRAINT triagepause_pkey PRIMARY KEY (triagepauseid),
    CONSTRAINT triagepause_addedby_fkey FOREIGN KEY (addedby)
        REFERENCES public.staff (staffid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE patient.triagepause
    OWNER to postgres;



CREATE TABLE patient.patientfinaldiagnosis
(
    finaldiagnosisid bigint NOT NULL DEFAULT nextval('patient.patientfinaldiagnosis_diagnosisid_seq'::regclass),
    diagnosis character varying(256) COLLATE pg_catalog."default",
    diagnosiscode character varying(256) COLLATE pg_catalog."default",
    patientvisitid bigint,
    dateadded date,
    facilityunitid bigint,
    addedby bigint,
    CONSTRAINT finaldiagnosisid_pkey PRIMARY KEY (finaldiagnosisid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE patient.patientfinaldiagnosis
    OWNER to postgres;




    
CREATE OR REPLACE VIEW patient.admittedpatientsview AS
 SELECT mat.maternityid,
    mat.admissionid,
    mat.ipdno,
    mat.admissiondate,
    mat.patientvisitid,
    pat.patientid,
    pn.firstname,
    pn.lastname,
    pn.dob
   FROM patient.maternity mat
     JOIN patient.maternityadmission ma ON mat.admissionid = ma.admissionid
     JOIN patient.patientvisit pv ON ma.patientvisitid = pv.patientvisitid
     JOIN patient.patient pat ON pv.patientid = pat.patientid
     JOIN person pn ON pat.personid = pn.personid
  WHERE ma.admitted = true;

ALTER TABLE patient.admittedpatientsview
    OWNER TO postgres;


CREATE OR REPLACE VIEW patient.dischargedmaternitypatientsview AS
 SELECT ma.admissionid,
    ma.ipdno,
    ma.datetimein,
    ma.patientvisitid,
    ma.datetimeout,
    ma.dischargedby,
    ma.cancelreason,
    ma.discharged,
    pat.patientid,
    pn.firstname,
    pn.lastname,
    pn.dob
   FROM patient.maternityadmission ma
     JOIN patient.patientvisit pv ON ma.patientvisitid = pv.patientvisitid
     JOIN patient.patient pat ON pv.patientid = pat.patientid
     JOIN person pn ON pat.personid = pn.personid
  WHERE ma.cancelled = false AND ma.discharged = true;

ALTER TABLE patient.dischargedmaternitypatientsview
    OWNER TO postgres;



CREATE OR REPLACE VIEW patient.dischargedpatientsview AS
 SELECT ma.admissionid,
    ma.ipdno,
    ma.datetimein,
    ma.patientvisitid,
    ma.datetimeout,
    ma.dischargedby,
    ma.cancelreason,
    ma.discharged,
    pat.patientid,
    pn.firstname,
    pn.lastname,
    pn.dob
   FROM patient.maternityadmission ma
     JOIN patient.patientvisit pv ON pv.patientvisitid = ma.patientvisitid
     JOIN patient.patient pat ON pat.patientid = pv.patientid
     JOIN person pn ON pn.personid = pat.personid
  WHERE ma.cancelled = true AND ma.discharged = true;

ALTER TABLE patient.dischargedpatientsview
    OWNER TO postgres;



CREATE OR REPLACE VIEW patient.maternityadmissionview AS
 SELECT ma.admissionid,
    ma.ipdno,
    ma.datetimein,
    ma.patientvisitid,
    pat.patientid,
    pn.firstname,
    pn.lastname,
    pn.dob
   FROM patient.maternityadmission ma
     JOIN patient.patientvisit pv ON ma.patientvisitid = pv.patientvisitid
     JOIN patient.patient pat ON pv.patientid = pat.patientid
     JOIN person pn ON pat.personid = pn.personid
  WHERE ma.cancelled = false AND ma.discharged = false AND ma.admitted = false;

ALTER TABLE patient.maternityadmissionview
    OWNER TO postgres;


CREATE OR REPLACE VIEW patient.maternitymothersview AS
 SELECT ma.maternityid,
    ma.admissionid,
    ma.ipdno,
    ma.patientid,
    ma.personisalive,
    ma.modeofdelivery,
    ma.inrno,
    ma.deliveredby,
    ma.numberofchildren,
    concat(per.firstname, ' ', per.lastname, ' ', per.othernames) AS fullname,
    per.spokenlanguage AS language,
    per.nationality,
    per.nin,
    l.villagename,
    l.parishname,
    cd.contacttype,
    cd.contactvalue
   FROM patient.maternity ma
     JOIN patient.patient pt ON ma.patientid = pt.patientid
     JOIN person per ON pt.personid = per.personid
     JOIN locations l ON per.currentaddress = l.villageid
     JOIN contactdetails cd ON per.personid = cd.personid;

ALTER TABLE patient.maternitymothersview
    OWNER TO postgres;


CREATE OR REPLACE VIEW patient.patientstartisticsview AS
 SELECT pa.patientid,
    pa.personid,
    pa.patientno,
    pa.datecreated,
    pa.facilityid AS registrationfacilityid,
    per.dob,
    per.gender,
    vis.patientvisitid,
    vis.addedby,
    vis.dateadded,
    vis.visitpriority,
    vis.visittype,
    vis.visitnumber,
    vis.facilityunitid,
    fu.facilityid,
    concat(per.firstname, ' ', per.lastname, ' ', per.othernames) AS fullname,
    date_part('DAY'::text, now() - per.dob::timestamp with time zone)::integer AS age,
    l.villagename,
    l.parishname,
    l.subcountyname,
    l.countyname,
    l.districtname
   FROM patient.patient pa
     JOIN person per ON pa.personid = per.personid
     JOIN patient.patientvisit vis ON vis.patientid = pa.patientid
     JOIN facilityunit fu ON vis.facilityunitid = fu.facilityunitid
     JOIN locations l ON per.currentaddress = l.villageid;

ALTER TABLE patient.patientstartisticsview
    OWNER TO postgres;
