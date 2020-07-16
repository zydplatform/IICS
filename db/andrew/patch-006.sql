
ALTER TABLE store.bayrowcell
  ADD COLUMN IF NOT EXISTS cellstate BOOLEAN NOT NULL DEFAULT false;
select *from  store.unitstoragezones;
DROP VIEW  store.unitstoragezones;
CREATE VIEW store.unitstoragezones AS
SELECT zn.zoneid,
	zn.zonelabel,
	znby.zonebayid,
    znby.baylabel,
    byrw.bayrowid,
    byrw.rowlabel,
    byrwcell.bayrowcellid,
    byrwcell.celllabel,
    zn.facilityunitid,
    byrwcell.cellstate
   FROM store.zone zn
   JOIN store.zonebay znby ON (zn.zoneid=znby.zoneid)
   JOIN store.bayrow byrw ON (znby.zonebayid=byrw.zonebayid)
   JOIN store.bayrowcell byrwcell ON (byrw.bayrowid=byrwcell.bayrowid);


