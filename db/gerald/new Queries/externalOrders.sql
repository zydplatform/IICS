/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  HP
 * Created: Aug 27, 2018
 */

ALTER TABLE store.externalfacilityorders ADD COLUMN supplierid BIGINT;
ALTER TABLE store.externalfacilityorders ADD CONSTRAINT fk_supplierid FOREIGN KEY(supplierid) REFERENCES store.supplier(supplierid);