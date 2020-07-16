/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Jul 3, 2018
 */

ALTER TABLE store.itemcategory ADD COLUMN parentid BIGINT;
ALTER TABLE store.item ADD COLUMN levelofuse Integer;
UPDATE store.item
	SET   levelofuse=7;

ALTER TABLE store.item ADD COLUMN itemform VARCHAR;
-- run
ALTER TABLE facilitylevel add column count integer;

