/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  user
 * Created: Sep 24, 2018
 */

CREATE SEQUENCE store.storagetype_storagetype_seq;
ALTER TABLE store.storagetype ALTER COLUMN storagetype SET DEFAULT nextval('store.storagetype_storagetype_seq'::regclass)