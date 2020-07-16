/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  IICS-GRACE
 * Created: Jun 4, 2018
 */
ALTER TABLE person ADD registrationpoint bigint REFERENCES facilityunit(facilityunitid);