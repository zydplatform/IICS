/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Facilityservices;
import com.iics.domain.Facilityunitservice;
import com.iics.domain.Searchstaff;
import com.iics.patient.Patientstartisticsview;
import com.iics.patient.Patientvisit;
import com.iics.patient.Servicequeue;
import com.iics.patient.Waitingtime;
import com.iics.service.GenericClassService;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/queuingSystem")
public class QueuingSystem {

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/fetchStaffDetails", method = RequestMethod.GET)
    public @ResponseBody
    String fetchStaffDetails(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Map<String, Object> staff = new HashMap<>();
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

            int facilityunitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

            String[] paramsconsultationid = {"servicekey"};
            Object[] paramsValuesconsultationid = {"key_consultation"};
            String[] fieldsconsultationid = {"serviceid"};
            List<Integer> patientsvisitsconsultationid = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fieldsconsultationid, "WHERE servicekey=:servicekey", paramsconsultationid, paramsValuesconsultationid);
            if (patientsvisitsconsultationid != null) {
                String[] paramsconsultation = {"serviceid", "facilityunit"};
                Object[] paramValuesconsultation = {patientsvisitsconsultationid, facilityunitId};
                String[] fieldsconsultation = {"facilityunitserviceid"};
                String whereconsultation = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                List<Long> serviceidconsultation = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fieldsconsultation, whereconsultation, paramsconsultation, paramValuesconsultation);
                if (serviceidconsultation != null) {
                    staff.put("serviceid", serviceidconsultation.get(0));
                }
            }

            staff.put("room", "Room 23");
            staff.put("label", "Desk 10");
            staff.put("staffid", staffid);
            staff.put("type", "SERVICEPOINT");
            //
            staff.put("facilityunitid", facilityunitId);
            //
            String staffDetails = "";
            try {
                staffDetails = new ObjectMapper().writeValueAsString(staff);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return staffDetails;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchTriageStaffDetails", method = RequestMethod.GET)
    public @ResponseBody
    String fetchTriageStaffDetails(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Map<String, Object> staff = new HashMap<>();
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            int facilityunitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

            String[] paramstriageid = {"servicekey"};
            Object[] paramsValuestriageid = {"key_triage"};
            String[] fieldstriageid = {"serviceid"};
            List<Integer> patientsvisitstriageid = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fieldstriageid, "WHERE servicekey=:servicekey", paramstriageid, paramsValuestriageid);
            if (patientsvisitstriageid != null) {
                String[] params = {"serviceid", "facilityunit"};
                Object[] paramValues = {patientsvisitstriageid, facilityunitId};
                String[] fields = {"facilityunitserviceid"};
                String where = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                List<Long> serviceid = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramValues);
                if (serviceid != null) {
                    staff.put("serviceid", serviceid.get(0));
                }
            }

            staff.put("room", "Room 23");
            staff.put("label", "Desk 10");
            staff.put("staffid", staffid);
            staff.put("type", "SERVICEPOINT");
            //
            staff.put("facilityunitid", facilityunitId);
            //
            String staffDetails = "";
            try {
                staffDetails = new ObjectMapper().writeValueAsString(staff);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return staffDetails;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchQueueSize", method = RequestMethod.GET)
    public @ResponseBody
    String getQueueSize(@ModelAttribute("unitserviceid") Integer unitServiceid) {
        Integer queueSize;
        String[] params = {"unitserviceid", "serviced"};
        Object[] paramsValues = {unitServiceid, false};
        String where = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND DATE(timein)=DATE 'now'";
        queueSize = genericClassService.fetchRecordCount(Servicequeue.class, where, params, paramsValues);

        return queueSize.toString();
    }

//    @RequestMapping(value = "/popPatient", method = RequestMethod.GET)
//    public @ResponseBody
//    String popPatient(@ModelAttribute("unitserviceid") Integer unitServiceid) {
//        Long popped = 0L;
//        String[] params = {"unitserviceid", "serviced"};
//        Object[] paramsValues = {unitServiceid, false};
//        String[] fields = {"patientvisitid.patientvisitid", "timein"};
//        String where = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND DATE(timein)=DATE 'now' ORDER BY timein LIMIT 1";
//        List<Object[]> queue = (List<Object[]>) genericClassService.fetchRecord(Servicequeue.class, fields, where, params, paramsValues);
//        if (queue != null) {
//            popped = (Long) queue.get(0)[0];
//        }
//        return popped.toString();
//    }
    @RequestMapping(value = "/popPatient", method = RequestMethod.GET)
    public @ResponseBody
    String popPatient(@ModelAttribute("unitserviceid") Integer unitServiceid) {
        Long popped = 0L;
        synchronized (popped) {
            String[] params = {"unitserviceid", "serviced", "ispopped", "canceled"};
            Object[] paramsValues = {unitServiceid, Boolean.FALSE, Boolean.FALSE, Boolean.FALSE};
            String[] fields = {"patientvisitid.patientvisitid", "timein"};
            String where = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND DATE(timein)=DATE 'now' AND ispopped=:ispopped AND canceled=:canceled ORDER BY timein LIMIT 1";
            List<Object[]> queue = (List<Object[]>) genericClassService.fetchRecord(Servicequeue.class, fields, where, params, paramsValues);
            if (queue != null) {
                String[] columns = {"ispopped"};
                Object[] columnValues = {Boolean.TRUE};
                String pk = "patientvisitid";
                Object pkValue = queue.get(0)[0];
                int update = genericClassService.updateRecordSQLSchemaStyle(Servicequeue.class, columns, columnValues, pk, pkValue, "patient");
                popped = (Long) queue.get(0)[0];
            }
        }
        return popped.toString();
    }

    @RequestMapping(value = "/unpoppatient", method = RequestMethod.POST)
    public @ResponseBody
    String unPopPatient(@ModelAttribute("patientvisitid") Integer patientVisitId) {
        String[] columns = {"ispopped"};
        Object[] columnValues = {Boolean.FALSE};
        String pk = "patientvisitid";
        Object pkValue = patientVisitId;
        int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Servicequeue.class, columns, columnValues, pk, pkValue, "patient");
        return (rowsAffected > 0) ? "success" : "failure";
    }

//    @RequestMapping(value = "/pushPatient", method = RequestMethod.GET)
//    public @ResponseBody
//    String pushPatient(@ModelAttribute("visitid") String visitid, @ModelAttribute("serviceid") String serviceid, @ModelAttribute("staffid") String staffid) {
//        String saved = "false";
//        try {
//            Servicequeue queue = new Servicequeue();
//            queue.setServiced(false);
//            queue.setCanceled(false);
//            queue.setTimein(new Date());
//            queue.setAddedby(BigInteger.valueOf(Long.parseLong(staffid)));
//            queue.setPatientvisitid(new Patientvisit(Long.parseLong(visitid)));
//            queue.setUnitserviceid(BigInteger.valueOf(Long.parseLong(serviceid)));
//            genericClassService.saveOrUpdateRecordLoadObject(queue);
//            saved = "true";
//        } catch (NumberFormatException ex) {
//            System.out.println(ex);
//        }
//        return saved;
//    }
    @RequestMapping(value = "/pushPatient", method = RequestMethod.GET)
    public @ResponseBody
    String pushPatient(@ModelAttribute("visitid") String visitid, @ModelAttribute("serviceid") String serviceid, @ModelAttribute("staffid") String staffid) {
        String saved = "false";
        try {
            Servicequeue queue = new Servicequeue();
            queue.setServiced(false);
            queue.setCanceled(false);
            queue.setIspopped(Boolean.FALSE);
            queue.setTimein(new Date());
            queue.setAddedby(BigInteger.valueOf(Long.parseLong(staffid)));
            queue.setPatientvisitid(new Patientvisit(Long.parseLong(visitid)));
            queue.setUnitserviceid(BigInteger.valueOf(Long.parseLong(serviceid)));
            Object save = genericClassService.saveOrUpdateRecordLoadObject(queue);
            saved = "true";
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        }
        return saved;
    }

    @RequestMapping(value = "/servicePoppedPatient", method = RequestMethod.GET)
    public @ResponseBody
    String servicePoppedPatient(@ModelAttribute("visitid") String visitid, @ModelAttribute("serviceid") String serviceid, @ModelAttribute("staffid") String staffid) {
        String updated = "false";
        try {
            BigInteger staff = BigInteger.valueOf(Long.parseLong(staffid));
            Long visit = Long.parseLong(visitid);
            Long service = Long.parseLong(serviceid);
            String[] params = {"patientvisitid", "unitserviceid", "serviced"};
            Object[] paramsValues = {visit, service, false};
            String[] fields = {"servicequeueid"};
            String where = "WHERE patientvisitid=:patientvisitid AND unitserviceid=:unitserviceid AND serviced=:serviced AND DATE(timein)=DATE 'now'";
            List<Object> queue = (List<Object>) genericClassService.fetchRecord(Servicequeue.class, fields, where, params, paramsValues);
            if (queue != null) {
                String[] columns = {"serviced", "timeout", "servicedby", "canceled"};
                Object[] columnValues = {true, new Date(), staff, false};
                String pk = "servicequeueid";
                Object pkValue = queue.get(0);
                int update = genericClassService.updateRecordSQLSchemaStyle(Servicequeue.class, columns, columnValues, pk, pkValue, "patient");
                if (update != 0) {
                    updated = "true";
                }
            }
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        }
        return updated;
    }

    @RequestMapping(value = "/revertPoppedPatient", method = RequestMethod.GET)
    public @ResponseBody
    String revertPoppedPatient(@ModelAttribute("visitid") String visitid, @ModelAttribute("serviceid") String serviceid) {
        String reverted = "false";
        try {
            Long visit = Long.parseLong(visitid);
            Long service = Long.parseLong(serviceid);
            String[] params = {"patientvisitid", "unitserviceid", "canceled"};
            Object[] paramsValues = {visit, service, true};
            String[] fields = {"servicequeueid"};
            String where = "WHERE patientvisitid=:patientvisitid AND unitserviceid=:unitserviceid AND canceled=:canceled AND DATE(timein)=DATE 'now'";
            List<Object> queue = (List<Object>) genericClassService.fetchRecord(Servicequeue.class, fields, where, params, paramsValues);
            if (queue != null) {
                String[] columns = {"serviced", "canceled"};
                Object[] columnValues = {false, false};
                String pk = "servicequeueid";
                Object pkValue = queue.get(0);
                int update = genericClassService.updateRecordSQLSchemaStyle(Servicequeue.class, columns, columnValues, pk, pkValue, "patient");
                if (update != 0) {
                    reverted = "true";
                }
            }
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        }
        return reverted;
    }

//    @RequestMapping(value = "/revertPoppedPatient", method = RequestMethod.GET)
//    public @ResponseBody
//    String revertPoppedPatient(@ModelAttribute("visitid") String visitid, @ModelAttribute("serviceid") String serviceid) {
//        String reverted = "false";
//        try {
//            Long visit = Long.parseLong(visitid);
//            Long service = Long.parseLong(serviceid);
//            String[] params = {"patientvisitid", "unitserviceid", "serviced", "canceled"};
//            Object[] paramsValues = {visit, service, true, true};
//            String[] fields = {"servicequeueid"};
//            String where = "WHERE patientvisitid=:patientvisitid AND unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND DATE(timein)=DATE 'now'";
//            List<Object> queue = (List<Object>) genericClassService.fetchRecord(Servicequeue.class, fields, where, params, paramsValues);
//            if (queue != null) {
//                String[] columns = {"serviced", "canceled"};
//                Object[] columnValues = {false, false};
//                String pk = "servicequeueid";
//                Object pkValue = queue.get(0);
//                int update = genericClassService.updateRecordSQLSchemaStyle(Servicequeue.class, columns, columnValues, pk, pkValue, "patient");
//                if (update != 0) {
//                    reverted = "true";
//                }
//            }
//        } catch (NumberFormatException ex) {
//            System.out.println(ex);
//        }
//        return reverted;
//    }
    @RequestMapping(value = "/fetchLaboratoryStaffDetails", method = RequestMethod.GET)
    public @ResponseBody
    String fetchLaboratoryStaffDetails(HttpServletRequest request, Model model) {

        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Map<String, Object> staff = new HashMap<>();
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            int facilityunitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

            String[] paramstriageid = {"servicekey"};
            Object[] paramsValuestriageid = {"key_laboratory"};
            String[] fieldstriageid = {"serviceid"};
            List<Integer> patientsvisitstriageid = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fieldstriageid, "WHERE servicekey=:servicekey", paramstriageid, paramsValuestriageid);
            if (patientsvisitstriageid != null) {
                String[] params = {"serviceid", "facilityunit"};
                Object[] paramValues = {patientsvisitstriageid, facilityunitId};
                String[] fields = {"facilityunitserviceid"};
                String where = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                List<Long> serviceid = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramValues);
                if (serviceid != null) {
                    staff.put("serviceid", serviceid.get(0));
                }
            }

            staff.put("room", "Room 23");
            staff.put("label", "Desk 10");
            staff.put("staffid", staffid);
            staff.put("type", "SERVICEPOINT");
            String staffDetails = "";
            try {
                staffDetails = new ObjectMapper().writeValueAsString(staff);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return staffDetails;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchDispensingStaffDetails", method = RequestMethod.GET)
    public @ResponseBody
    String fetchDispensingStaffDetails(HttpServletRequest request, Model model) {

        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Map<String, Object> staff = new HashMap<>();
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            int facilityunitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

            String[] paramstriageid = {"servicekey"};
            Object[] paramsValuestriageid = {"key_dispensing"};
            String[] fieldstriageid = {"serviceid"};
            List<Integer> patientsvisitstriageid = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fieldstriageid, "WHERE servicekey=:servicekey", paramstriageid, paramsValuestriageid);
            if (patientsvisitstriageid != null) {
                String[] params = {"serviceid", "facilityunit"};
                Object[] paramValues = {patientsvisitstriageid, facilityunitId};
                String[] fields = {"facilityunitserviceid"};
                String where = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                List<Long> serviceid = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramValues);
                if (serviceid != null) {
                    staff.put("serviceid", serviceid.get(0));
                }
            }

            staff.put("room", "Room 23");
            staff.put("label", "Desk 10");
            staff.put("staffid", staffid);
            staff.put("type", "SERVICEPOINT");
            //
            staff.put("facilityunitid", facilityunitId);
            //
            String staffDetails = "";
            try {
                staffDetails = new ObjectMapper().writeValueAsString(staff);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return staffDetails;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/countCanceledPatients", method = RequestMethod.GET)
    public @ResponseBody
    String countCanceledPatients(@ModelAttribute("unitserviceid") Integer unitServiceid) {
        Integer queueSize;
        String[] params = {"unitserviceid", "serviced", "canceled"};
        Object[] paramsValues = {unitServiceid, true, true};
        String where = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND DATE(timein)=DATE 'now'";
        queueSize = genericClassService.fetchRecordCount(Servicequeue.class, where, params, paramsValues);

        return queueSize.toString();
    }

    @RequestMapping(value = "/countServicedPatients", method = RequestMethod.GET)
    public @ResponseBody
    String countServicedPatients(@ModelAttribute("unitserviceid") Integer unitServiceid) {
        Integer serviced;
        String[] params = {"unitserviceid", "serviced", "canceled"};
        Object[] paramsValues = {unitServiceid, true, false};
        String where = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND DATE(timein)=DATE 'now'";
        serviced = genericClassService.fetchRecordCount(Servicequeue.class, where, params, paramsValues);

        return serviced.toString();
    }

    @RequestMapping(value = "/getWaitingTime", method = RequestMethod.GET)
    public @ResponseBody
    String getWaitingTime(@ModelAttribute("unitserviceid") Integer unitServiceid) {
        double waitingTime = 0;
        String[] params = {"unitserviceid"};
        Object[] paramsValues = {unitServiceid};
        String[] fields = {"sum"};
        String where = "WHERE unitserviceid=:unitserviceid AND DATE(dateadded)=DATE 'now'";
        List<Object> time = (List<Object>) genericClassService.fetchRecord(Waitingtime.class, fields, where, params, paramsValues);
        if (time != null) {
            waitingTime = (double) time.get(0);
        }
        return String.valueOf(waitingTime);
    }

    @RequestMapping(value = "/cancelPoppedPatient", method = RequestMethod.POST)
    public @ResponseBody
    String cancelPoppedPatient(HttpServletRequest request, @ModelAttribute("visitid") String visitid, @ModelAttribute("serviceid") String serviceid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            String reverted = "false";
            try {
                Long visit = Long.parseLong(visitid);
                Long unitServiceid = Long.parseLong(serviceid);
//                String[] params = {"patientvisitid", "unitserviceid", "serviced"};
//                Object[] paramsValues = {visit, unitServiceid, true};
                String[] params = {"patientvisitid", "unitserviceid"};
                Object[] paramsValues = {visit, unitServiceid};
                String[] fields = {"servicequeueid"};
//                String where = "WHERE patientvisitid=:patientvisitid AND unitserviceid=:unitserviceid AND serviced=:serviced AND DATE(timein)=DATE 'now'";
                String where = "WHERE patientvisitid=:patientvisitid AND unitserviceid=:unitserviceid AND DATE(timein)=DATE 'now'";
                List<Object> queue = (List<Object>) genericClassService.fetchRecord(Servicequeue.class, fields, where, params, paramsValues);
                if (queue != null) {
//                    String[] columns = {"canceled", "canceledby", "timecanceled"};
//                    Object[] columnValues = {true, staffid, new Date()};
                    String[] columns = {"canceled", "canceledby", "timecanceled", "ispopped", "serviced", "servicedby"};
                    Object[] columnValues = {true, staffid, new Date(), Boolean.FALSE, Boolean.TRUE, staffid};
                    String pk = "servicequeueid";
                    Object pkValue = queue.get(0);
                    int update = genericClassService.updateRecordSQLSchemaStyle(Servicequeue.class, columns, columnValues, pk, pkValue, "patient");
                    if (update != 0) {
                        Integer queueSize;
                        String[] params2 = {"unitserviceid", "serviced", "canceled"};
                        Object[] paramsValues2 = {unitServiceid, true, true};
                        String where2 = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND DATE(timein)=DATE 'now'";
                        queueSize = genericClassService.fetchRecordCount(Servicequeue.class, where2, params2, paramsValues2);

                        return queueSize.toString();
                    }
                }
            } catch (NumberFormatException ex) {
                System.out.println(ex);
            }
            return reverted;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchCanceledPatients", method = RequestMethod.POST)
    public String fetchCanceledPatients(HttpServletRequest request, Model model, @ModelAttribute("serviceid") String serviceid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            List<Map> canceledPatients = new ArrayList<>();
            try {
                Long unitServiceid = Long.parseLong(serviceid);
//                String[] params = {"unitserviceid", "serviced", "canceled"};
//                Object[] paramsValues = {unitServiceid, true, true};
                String[] params = {"unitserviceid", "canceled"};
                Object[] paramsValues = {unitServiceid, Boolean.TRUE};
                String[] fields = {"patientvisitid.patientvisitid", "timecanceled", "servicedby"};
//                String where = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND DATE(timein)=DATE 'now'";
                String where = "WHERE unitserviceid=:unitserviceid AND canceled=:canceled AND DATE(timein)=DATE 'now'";
                List<Object[]> canceled = (List<Object[]>) genericClassService.fetchRecord(Servicequeue.class, fields, where, params, paramsValues);
                if (canceled != null) {
                    Map<String, Object> patient;
                    for (Object[] cl : canceled) {
                        patient = new HashMap<>();
                        patient.put("visitid", cl[0].toString());
                        patient.put("serviceid", serviceid);
                        patient.put("time", (new Date().getTime() - ((Date) cl[1]).getTime()) / (1000 * 60));

                        params = new String[]{"staffid"};
                        paramsValues = new Object[]{cl[2]};
                        fields = new String[]{"firstname", "othernames", "lastname"};
                        where = "WHERE staffid=:staffid";
                        List<Object[]> servicedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, where, params, paramsValues);
                        if (servicedby != null) {
                            patient.put("servicedby", servicedby.get(0)[0] + " " + servicedby.get(0)[1] + " " + servicedby.get(0)[2]);
                        }
                        //

                        String[] params2 = {"patientvisitid"};
                        Object[] paramsValues2 = {cl[0]};
                        String[] fields2 = {"fullname", "visitnumber", "gender", "age"};
                        String where2 = "WHERE patientvisitid=:patientvisitid";
                        List<Object[]> patientDetails = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields2, where2, params2, paramsValues2);
                        if (patientDetails != null) {
                            patient.put("names", patientDetails.get(0)[0]);
                            patient.put("visitno", patientDetails.get(0)[1]);
                            patient.put("gender", patientDetails.get(0)[2]);
                            patient.put("age", patientDetails.get(0)[3]);
                            canceledPatients.add(patient);
                        }
                    }
                }
            } catch (NumberFormatException ex) {
                System.out.println(ex);
            }
            model.addAttribute("patients", canceledPatients);
            return "patientsManagement/queues/canceled";
        } else {
            return "refresh";
        }
    }
}
