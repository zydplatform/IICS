/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS-GRACE
 * Created: 28-Jul-2018
 */

CREATE OR REPLACE FUNCTION public.getpersonemail(syspersonid bigint)
    RETURNS text
    LANGUAGE 'plpgsql'
	AS $BODY$
		declare
			email TEXT = 'EMAIL';
			contact TEXT;
		BEGIN
   			SELECT contactvalue into contact FROM public.contactdetails cd where cd.personid=syspersonid AND cd.contacttype=email;
   	RETURN contact;
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.getpersontelephone(syspersonid bigint)
    RETURNS text
    LANGUAGE 'plpgsql'
	AS $BODY$
		declare
			pri TEXT = 'PRIMARYCONTACT';
			contact TEXT;
		BEGIN
   			SELECT contactvalue into contact FROM public.contactdetails cd where cd.personid=syspersonid AND cd.contacttype=pri;
   	RETURN contact;
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.getpersonnextofkin(syspersonid bigint)
    RETURNS text
    LANGUAGE 'plpgsql'
	AS $BODY$
		declare
			nextofkin TEXT;
		BEGIN
   			SELECT concat(n.relationship, ': ', n.fullname) into nextofkin FROM public.nextofkin n where n.personid=syspersonid;
   	RETURN nextofkin;
END;
$BODY$;

CREATE OR REPLACE VIEW patient.searchpatient AS SELECT pn.personid,
    pn.firstname,
    pn.lastname,
    pn.othernames,
    pn.facilityid,
    pn.currentaddress,
    pat.patientno,
    pat.patientid,
    getpersonemail(pn.personid) AS email,
    getpersontelephone(pn.personid) AS telephone,
    getpersonnextofkin(pn.personid) AS nextofkin,
    lower(concat(pn.firstname, pn.lastname, pn.othernames)) AS permutation1,
    lower(concat(pn.lastname, pn.othernames, pn.firstname)) AS permutation2,
    lower(concat(pn.lastname, pn.firstname)) AS permutation3
    FROM person pn
    JOIN patient.patient pat ON pn.personid = pat.personid;