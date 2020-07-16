ALTER TABLE facilitylevel DROP facilitydomain;

ALTER TABLE public.patient
    SET SCHEMA patient;

ALTER TABLE facilitylevel ADD facilitydomain int REFERENCES facilitydomain(facilitydomainid);