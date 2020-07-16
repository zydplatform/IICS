/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  user
 * Created: Jun 29, 2018
 */

 ALTER TABLE store.bayrowcell ADD COLUMN celltranslimit BIGINT  DEFAULT 0;


 CREATE OR REPLACE VIEW store.unitstoragezones AS SELECT zn.zoneid,
    zn.zonelabel,
    znby.zonebayid,
    znby.baylabel,
    byrw.bayrowid,
    byrw.rowlabel,
    byrwcell.bayrowcellid,
    byrwcell.celllabel,   
    zn.facilityunitid,
    byrwcell.cellstate,
    byrwcell.storagetypeid,
    byrwcell.celltranslimit
   FROM store.zone zn
     JOIN store.zonebay znby ON zn.zoneid = znby.zoneid
     JOIN store.bayrow byrw ON znby.zonebayid = byrw.zonebayid
     JOIN store.bayrowcell byrwcell ON byrw.bayrowid = byrwcell.bayrowid;

   
