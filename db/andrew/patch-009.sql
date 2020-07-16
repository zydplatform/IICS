/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  user
 * Created: Jun 1, 2018
 */

ALTER TABLE store.storagetype ADD COLUMN IF NOT EXISTS addedby BIGINT REFERENCES public.person(personid);
ALTER TABLE store.storagetype ADD COLUMN IF NOT EXISTS dateadded DATE;