/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS
 * Created: Apr 11, 2018
 */

ALTER TABLE store.stocklog ADD referencetype VARCHAR(255);

ALTER TABLE store.stocklog ADD reference bigint;