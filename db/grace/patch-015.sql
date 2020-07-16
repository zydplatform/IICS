/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  HP
 * Created: Sep 27, 2018
 */

ALTER TABLE store.facilityorder ADD taken BOOLEAN;

ALTER TABLE store.facilityorder ADD datetaken date;

ALTER TABLE store.orderissuance ADD unitquantityreceived int;