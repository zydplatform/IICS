/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  user
 * Created: May 29, 2018
 */
-- Table: public.facilityowner

-- DROP TABLE public.facilityowner;

ALTER TABLE public.facilityowner ADD COLUMN active boolean;

ALTER TABLE public.facilityowner ADD COLUMN subunits integer;