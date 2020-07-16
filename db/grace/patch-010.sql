/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS-GRACE
 * Created: Jul 18, 2018
 */

ALTER TABLE store.orderissuance DROP quantityissued;

ALTER TABLE store.orderissuance DROP dateissued;

ALTER TABLE store.orderissuance DROP issuedby;

ALTER TABLE store.orderissuance ADD quantitydelivered int;

ALTER TABLE store.facilityorderitems ADD deliveredby bigint REFERENCES staff(staffid);

ALTER TABLE store.facilityorderitems ADD deliveredto bigint REFERENCES staff(staffid);

ALTER TABLE store.facilityorderitems ADD isdelivered Boolean;

ALTER TABLE store.facilityorderitems ADD datedelivered date;
