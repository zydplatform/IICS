-- View: dashboard.itemstatistics

-- DROP VIEW dashboard.itemstatistics;

CREATE OR REPLACE VIEW dashboard.itemstatistics AS
 SELECT fsl.itemid,
    fsl.logtype,
    sum(fsl.quantity)::integer AS quantity,
    fsl.facilityunitid,
    date_part('MONTH'::text, fsl.dateadded)::integer AS statmonth,
    date_part('YEAR'::text, fsl.dateadded) AS statyear,
    btrim(ip.packagename) AS packagename
   FROM store.facilitystocklog fsl
     JOIN store.itempackage ip ON fsl.itemid = ip.itempackageid
	 WHERE (fsl.logtype::text = ANY (ARRAY['IN'::character varying::text, 'DISP'::character varying::text])) AND 
(referencetype IS NULL OR TRIM(UPPER(referencetype)) = 'RX')
  GROUP BY fsl.facilityunitid, (date_part('MONTH'::text, fsl.dateadded)), (date_part('YEAR'::text, fsl.dateadded)), fsl.itemid, fsl.logtype, (btrim(ip.packagename))
  ORDER BY (date_part('MONTH'::text, fsl.dateadded)), (date_part('YEAR'::text, fsl.dateadded));

ALTER TABLE dashboard.itemstatistics
    OWNER TO postgres;