/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICSRemote
 * Created: Apr 10, 2018
 */
Select * from store.unitstoragezones;
CREATE OR REPLACE VIEW store.unitstoragezones AS
SELECT zn.zoneid,
	zn.zonelabel,
	znby.zonebayid,
    znby.baylabel,
    byrw.bayrowid,
    byrw.rowlabel,
    byrwcell.bayrowcellid,
    byrwcell.celllabel,
    zn.facilityunitid
   FROM store.zone zn
   JOIN store.zonebay znby ON (zn.zoneid=znby.zoneid)
   JOIN store.bayrow byrw ON (znby.zonebayid=byrw.zonebayid)
   JOIN store.bayrowcell byrwcell ON (byrw.bayrowid=byrwcell.bayrowid)
