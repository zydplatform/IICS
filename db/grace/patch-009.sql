/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS-GRACE
 * Created: Jun 29, 2018
 */

ALTER TABLE store.facilityorderitems ADD FOREIGN KEY (servicedby) REFERENCES staff(staffid);

ALTER TABLE store.orderissuance ADD qtypicked int;

ALTER TABLE store.facilityorderitems ADD datepicked date;

ALTER TABLE store.facilityorderitems DROP batchno;
