/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  user
 * Created: Jun 27, 2018
 */
CREATE OR REPLACE VIEW scheduleplan.batchstaffschedules AS SELECT srv.serviceid,
	srv.servicename,
	srv.facilityunitid,
    srvpln.servicedayplanid,
    srvpln.servicedayid,
    srvpln.desiredstaff,
    srvpln.starttime,
    srvpln.endtime,
    stfsrv.staffserviceid,
    stfsrv.staffid,
    stf.workinghours
   FROM scheduleplan.service srv
  	 JOIN scheduleplan.servicedayplan srvpln ON (srv.serviceid = srvpln.serviceid)
   	 JOIN scheduleplan.staffservice stfsrv ON (srvpln.serviceid = stfsrv.serviceid)
     JOIN public.staff stf ON (stfsrv.staffid = stf.staffid);
