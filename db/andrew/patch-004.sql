/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICSRemote
 * Created: Apr 17, 2018
 */

CREATE TABLE store.staffbayrowcell(
    staffbayrowcellid int PRIMARY KEY,
    bayrowcellid int REFERENCES store.bayrowcell(bayrowcellid),
    staffid bigint REFERENCES public.staff(staffid),
    staffactivity VARCHAR(255)
);
ALTER TABLE store.zone
  ADD COLUMN IF NOT EXISTS zoneState BOOLEAN NOT NULL DEFAULT true;