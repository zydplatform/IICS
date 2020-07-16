/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Apr 25, 2018
 */

ALTER TABLE facility ADD COLUMN villageid integer;

ALTER TABLE facility ADD COLUMN dateadded timestamp without time zone;

ALTER TABLE facility ADD COLUMN gpseasting character varying;



ALTER TABLE facility
  ADD CONSTRAINT fk_villageid FOREIGN KEY (villageid)
      REFERENCES village (villageid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
