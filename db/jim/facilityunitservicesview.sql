-- View: public.facilityunitservicesview

-- DROP VIEW public.facilityunitservicesview;

CREATE OR REPLACE VIEW public.facilityunitservicesview AS
 SELECT fs.serviceid,
    fs.servicename,
    fs.description,
    fs.active,
    fs.dateadded,
    fs.dateupdated,
    fs.updatedby,
    fs.servicekey,
    fs.released,
    fus.facilityunitserviceid,
    fus.facilityunitid,
    fus.addedby,
    fus.status,
    fu.facilityunitname,
    fu.facilityid
   FROM facilityservices fs
     JOIN facilityunitservice fus ON fs.serviceid = fus.serviceid
     JOIN facilityunit fu ON fu.facilityunitid = fus.facilityunitid;

ALTER TABLE public.facilityunitservicesview
    OWNER TO postgres;
