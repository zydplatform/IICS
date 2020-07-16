/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Aug 1, 2018
 */

CREATE OR REPLACE VIEW store.procuringhistory AS
 SELECT ffy.facilityfinancialyearid,
    ffy.startyear,
    ffy.endyear,
    fufy.facilityunitid,
    fupp.itemid,
    fupp.averagemonthlyconsumption,
    fupp.averageannualcomsumption,
    ffy.financialyearstartdate,
    ffy.financialyearenddate,
    ordp.orderperiodid
   FROM store.facilityfinancialyear ffy
     JOIN store.facilityunitfinancialyear fufy ON ffy.facilityfinancialyearid = fufy.facilityfinancialyearid
     JOIN store.facilityunitprocurementplan fupp ON fufy.facilityunitfinancialyearid = fupp.facilityunitfinancialyearid
     JOIN store.orderperiod ordp ON ffy.facilityfinancialyearid = ordp.facilityfinancialyearid;

CREATE FUNCTION store.getprocurehistory1(endyear integer, unitid bigint, procureitemid bigint)
    RETURNS text
    LANGUAGE 'plpgsql'
	AS $BODY$
		declare
			previousyear integer = endyear - 1;
			procured integer = 0;
		BEGIN
   			SELECT averagemonthlyconsumption into procured FROM store.procuringhistory ph where ph.endyear=previousyear AND ph.facilityunitid=unitid AND ph.itemid=procureitemid;
   	RETURN procured;
END;
$BODY$;

CREATE OR REPLACE FUNCTION store.getprocurehistory2(
	endyear integer,
	unitid bigint,
	procureitemid bigint)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
		declare
			previousyear integer = endyear - 2;
			procured integer = 0;
		BEGIN
   			SELECT averagemonthlyconsumption into procured FROM store.procuringhistory ph where ph.endyear=previousyear AND ph.facilityunitid=unitid AND ph.itemid=procureitemid;
   	RETURN procured;
END;
$BODY$;

CREATE OR REPLACE FUNCTION store.getprocurehistory3(
	endyear integer,
	unitid bigint,
	procureitemid bigint)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
		declare
			previousyear integer = endyear - 3;
			procured integer = 0;
		BEGIN
   			SELECT averagemonthlyconsumption into procured FROM store.procuringhistory ph where ph.endyear=previousyear AND ph.facilityunitid=unitid AND ph.itemid=procureitemid;
   	RETURN procured;
END;
$BODY$;

CREATE FUNCTION store.getdatedconsumption1(startdate date, enddate date, unitid bigint, procureitemid bigint)
    RETURNS text
    LANGUAGE 'plpgsql'
	AS $BODY$
		declare
			issued integer;
			openingdate date = startdate - INTERVAL '12 MONTH';
			closingdate date = enddate - INTERVAL '12 MONTH';
		BEGIN
   			SELECT sum(quantityissued) into issued FROM store.orderissuance oi WHERE oi.dateissued>=openingdate AND oi.dateissued<=closingdate AND oi.destinationstore=unitid AND oi.itemid=procureitemid;
   	RETURN issued;
END;
$BODY$;

CREATE FUNCTION store.getdatedconsumption2(startdate date, enddate date, unitid bigint, procureitemid bigint)
    RETURNS text
    LANGUAGE 'plpgsql'
	AS $BODY$
		declare
			issued integer;
			openingdate date = startdate - INTERVAL '24 MONTH';
			closingdate date = enddate - INTERVAL '24 MONTH';
		BEGIN
   			SELECT sum(quantityissued) into issued FROM store.orderissuance oi WHERE oi.dateissued>=openingdate AND oi.dateissued<=closingdate AND oi.destinationstore=unitid AND oi.itemid=procureitemid;
   	RETURN issued;
END;
$BODY$;

CREATE FUNCTION store.getdatedconsumption3(startdate date, enddate date, unitid bigint, procureitemid bigint)
    RETURNS text
    LANGUAGE 'plpgsql'
	AS $BODY$
		declare
			issued integer;
			openingdate date = startdate - INTERVAL '36 MONTH';
			closingdate date = enddate - INTERVAL '36 MONTH';
		BEGIN
   			SELECT sum(quantityissued) into issued FROM store.orderissuance oi WHERE oi.dateissued>=openingdate AND oi.dateissued<=closingdate AND oi.destinationstore=unitid AND oi.itemid=procureitemid;
   	RETURN issued;
END;
$BODY$;

CREATE VIEW store.unitprocurementhistory AS SELECT facilityfinancialyearid,
	facilityunitid,
	itemid,
	averagemonthlyconsumption,
	averageannualcomsumption,
	store.getprocurehistory1(endyear, facilityunitid, itemid) AS history1,
	store.getprocurehistory2(endyear, facilityunitid, itemid) AS history2,
	store.getprocurehistory3(endyear, facilityunitid, itemid) AS history3,
	store.getdatedconsumption1(financialyearstartdate, financialyearenddate, facilityunitid, itemid) AS consumption1,
	store.getdatedconsumption2(financialyearstartdate, financialyearenddate, facilityunitid, itemid) AS consumption2,
	store.getdatedconsumption3(financialyearstartdate, financialyearenddate, facilityunitid, itemid) AS consumption3
	FROM store.procuringhistory;

CREATE VIEW store.orderconsumption AS SELECT oi.orderissuanceid,
	oi.quantityissued,
	oi.dateissued,
	foi.itemid,
	fo.destinationstore
	FROM store.orderissuance oi
	JOIN store.facilityorderitems foi ON(oi.facilityorderitemsid = foi.facilityorderitemsid)
	JOIN store.facilityorder fo ON(fo.facilityorderid = foi.facilityorderid);

DROP VIEW store.unitprocurementhistory;

CREATE VIEW store.unitprocurementhistory AS
SELECT facilityfinancialyearid,
	facilityunitid,
	itemid,
	orderperiodid,
	averagemonthlyconsumption,
	averageannualcomsumption,
	store.getprocurehistory1(endyear, facilityunitid, itemid) AS history1,
	store.getprocurehistory2(endyear, facilityunitid, itemid) AS history2,
	store.getprocurehistory3(endyear, facilityunitid, itemid) AS history3,
	store.getdatedconsumption1(financialyearstartdate, financialyearenddate, facilityunitid, itemid) AS consumption1,
	store.getdatedconsumption2(financialyearstartdate, financialyearenddate, facilityunitid, itemid) AS consumption2,
	store.getdatedconsumption3(financialyearstartdate, financialyearenddate, facilityunitid, itemid) AS consumption3
	FROM store.procuringhistory;