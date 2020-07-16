/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICSRemote
 * Created: Apr 27, 2018
 */

ALTER TABLE store.staffbayrowcell  ADD COLUMN zoneid int REFERENCES store.zone(zoneid);
DROP VIEW  store.staffassignedcell;
CREATE VIEW store.staffassignedcell AS
SELECT stff.staffbayrowcellid,
       stff.zoneid,
       stff.staffid,
       brc.bayrowcellid,
       bry.bayrowid,
       znbry.zonebayid
   FROM store.staffbayrowcell stff
   JOIN store.bayrowcell brc ON (stff.bayrowcellid = brc.bayrowcellid)
   JOIN store.bayrow bry ON (brc.bayrowid = bry.bayrowid)
   JOIN store.zonebay znbry ON (bry.zonebayid = znbry.zonebayid);