/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  user
 * Created: Jun 6, 2018
 */
ALTER TABLE store.bayrowcell DROP COLUMN storagetypeid;
ALTER TABLE store.bayrowcell ADD COLUMN storagetypeid bigint DEFAULT 0;
