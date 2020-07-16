
CREATE OR REPLACE VIEW dashboard.timeontaskview AS
 SELECT servicequeue.servicedby,
    date(servicequeue.timein) AS date,
    min(servicequeue.timeout) AS starttime,
    max(servicequeue.timeout) AS endtime
   FROM patient.servicequeue
  WHERE servicequeue.serviced = true AND servicequeue.canceled = false AND servicequeue.canceled = false
  GROUP BY (date(servicequeue.timein)), servicequeue.servicedby
  ORDER BY servicequeue.servicedby, (min(servicequeue.timeout));

ALTER TABLE dashboard.timeontaskview
    OWNER TO postgres;

