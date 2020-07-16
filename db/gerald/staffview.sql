CREATE OR REPLACE VIEW controlpanel.staffprivilege AS
SELECT srpf.systemroleprivilagefacilityid,
		srpf.systemroleprivilegeid,
        srpf.systemrolefacilityid,
        srp.systemroleid,
        srp.privilegeid
   FROM controlpanel.systemroleprivilagefacility srpf
   JOIN controlpanel.systemroleprivilege srp ON(srpf.systemroleprivilegeid=srp.systemroleprivilegeid)
   JOIN systemrolefacility srf ON (srpf.systemrolefacilityid=srf.systemrolefacilityid)
   
   