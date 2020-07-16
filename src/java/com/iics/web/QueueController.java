/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.patient.Laboratoryrequest;
import com.iics.patient.Patientstartisticsview;
import com.iics.patient.Prescriptionqueue;
import com.iics.patient.Servicedprescriptionstats;
import com.iics.patient.Servicequeue;
import com.iics.service.GenericClassService;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.MessagingException;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

/**
 *
 * @author IICS TECHS
 */
@Controller
public class QueueController {

    @Autowired
    private SimpMessagingTemplate template;

    @Autowired
    GenericClassService genericClassService;
    
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    
    @MessageMapping("/patientcount/{facilityId}")
    public void patientCount(Map<String, Object> data,             
            @DestinationVariable String facilityId){
        try {
            int totalPatientVisits = 0;
            final int facility = Integer.parseInt(data.get("facilityid").toString());
            String [] params = new String[] { "facilityid" };
            Object [] paramsValues = new Object[]  { facility }; 
            String where = "WHERE facilityid=:facilityid AND DATE(dateadded)=DATE 'now'";      
            List<Object[]> totalpatientvisitList = (List<Object[]>) genericClassService.fetchRecordFunction(Patientstartisticsview.class, new String [] { "COUNT(DISTINCT r.patientid)" }, where, params, paramsValues, 0, 0);
            if(totalpatientvisitList != null){
                totalPatientVisits = Integer.parseInt(String.valueOf(totalpatientvisitList.get(0)));
            }
            template.convertAndSend(String.format("/topic/facilitypatientcount/%s", facilityId), totalPatientVisits);
        } catch(NumberFormatException | MessagingException e){
            System.out.println(e);
        }
    }    
    @MessageMapping("/patientqueuesize/{facilityunitid}/{facilityId}/{service}")
    public void patientQueueSize(Map<String, Object> data, @DestinationVariable String facilityunitid,
            @DestinationVariable String facilityId, 
            @DestinationVariable String service){
        try {
            Integer queueSize;
            final Integer unitServiceId = Integer.parseInt(data.get("unitserviceid").toString());
            String[] params = {"unitserviceid", "serviced", "ispopped", "canceled"};
            Object[] paramsValues = { unitServiceId, Boolean.FALSE, Boolean.FALSE, Boolean.FALSE };
            String where = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND DATE(timein)=DATE 'now' AND ispopped=:ispopped AND canceled=:canceled";
            queueSize = genericClassService.fetchRecordCount(Servicequeue.class, where, params, paramsValues);
            template.convertAndSend(String.format("/topic/patientqueuesize/%s/%s/%s", facilityunitid, facilityId, service), queueSize);
        } catch(NumberFormatException | MessagingException e) {
            System.out.println(e);
        }
    }
    @MessageMapping("/prescriptioncount/{facilityunitid}/{facilityId}")
    public void prescriptionCount(Map<String, Object> data, @DestinationVariable String facilityunitid,
            @DestinationVariable String facilityId) {
        try {
            String topic = ""; 
            final long facilityUnitId = Long.parseLong(data.get("facilityunitid").toString());
            final String queueStage = data.get("queuestage").toString();
            long queueSize = 0;
            switch (queueStage) {
                case "approval":
                    queueSize = fetchPrescriptionQueueSize(facilityUnitId, queueStage);
                    topic = String.format("/topic/approvalprescriptioncount/%s/%s", facilityunitid, facilityId);
                    break;
                case "picking":
                    queueSize = fetchPrescriptionQueueSize(facilityUnitId, queueStage);
                    topic = String.format("/topic/pickingprescriptioncount/%s/%s", facilityunitid, facilityId);
                    break;
                case "dispensing":
                    queueSize = fetchPrescriptionQueueSize(facilityUnitId, queueStage);
                    topic = String.format("/topic/dispensingprescriptioncount/%s/%s", facilityunitid, facilityId);
                    break;
                case "serviced":
                    queueSize = fetchServicePrescriptionCount(facilityUnitId);
                    topic = String.format("/topic/servicedprescriptioncount/%s/%s", facilityunitid, facilityId);
                    break;
            }
            template.convertAndSend(topic, queueSize);
        } catch (NumberFormatException | MessagingException ex) {
            System.out.println(ex);
        }
    }
    @MessageMapping("/servicedpatientscount/{facilityunitid}/{facilityId}")
    public void servicedPatientsCount(Map<String, Object> data, @DestinationVariable String facilityunitid,
            @DestinationVariable String facilityId){
        try {
            String topic = "";
            final BigInteger unitServiceId = (data.containsKey("unitserviceid")) ? BigInteger.valueOf(Long.parseLong(data.get("unitserviceid").toString())) : BigInteger.valueOf(0);  
            final String destination = data.get("destination").toString();
            int serviced = fetchServicedPatientsCount(unitServiceId);
            switch(destination){
                case "pharmacy":
                    long count = fetchServicePrescriptionCount(Long.parseLong(facilityunitid));
                    serviced = Integer.parseInt(String.valueOf(count));
                    topic = String.format("/topic/servicedpatientscountdispensing/%s/%s", facilityunitid, facilityId);
                    break;
                case "consultation":
                    topic = String.format("/topic/servicedpatientscountconsultation/%s/%s", facilityunitid, facilityId);
                    break;
                case "triage":                    
                    topic = String.format("/topic/servicedpatientscounttriage/%s/%s", facilityunitid, facilityId);
                    final BigInteger keyId = (data.containsKey("keyid")) ? BigInteger.valueOf(Long.parseLong(data.get("keyid").toString())) : BigInteger.valueOf(0);
                    serviced += fetchServicedPatientsCount(keyId);
                    break;
                case "paedconsultation":
                    topic = String.format("/topic/servicedpatientscountpaedconsultation/%s/%s", facilityunitid, facilityId);
                    break;
                case "paedtriage":
                    topic = String.format("/topic/servicedpatientscountpaedtriage/%s/%s", facilityunitid, facilityId);
                    break;
            }
            template.convertAndSend(topic, serviced);
        } catch(NumberFormatException | MessagingException ex){
            System.out.println(ex);
        }
    }
//    @MessageMapping("/averagewaitingtime")
//    public void averageWaitingTime(Map<String, Object> data){
//        try {
//            String topic = "";
//            final BigInteger unitServiceId = BigInteger.valueOf(Long.parseLong(data.get("unitserviceid").toString()));  
//            final String destination = data.get("destination").toString();
//            double waitingTime = fetchAverageWaitingTime(unitServiceId);       
//            switch(destination){
//                case "pharmacy":
//                    topic = "/topic/averagewaitingtimedispensing";
//                    break;
//                case "consultation":
//                    topic = "/topic/averagewaitingtimeconsultation";
//                    break;
//                case "triage":
//                    topic = "/topic/averagewaitingtimetriage";
//                    final BigInteger keyId = BigInteger.valueOf(Long.parseLong(data.get("keyid").toString()));
//                    waitingTime += fetchAverageWaitingTime(keyId);
//                    break;
//            }
//            template.convertAndSend(topic, waitingTime);
//        } catch(NumberFormatException | MessagingException e) {
//            System.out.println(e);
//        }
//    }        
    @MessageMapping("/canceledpatients/{facilityunitid}/{facilityId}")
    public void caneledPatients(Map<String, Object> data, @DestinationVariable String facilityunitid,
            @DestinationVariable String facilityId){
        try {
            String topic = "";
            final BigInteger unitServiceId = BigInteger.valueOf(Long.parseLong(data.get("unitserviceid").toString()));  
            final String destination = data.get("destination").toString();
            String[] params = {"unitserviceid", "canceled"};
            Object[] paramsValues = { unitServiceId, Boolean.TRUE};
            String where = "WHERE unitserviceid=:unitserviceid AND canceled=:canceled AND DATE(timein)=DATE 'now'";
            int canceled = genericClassService.fetchRecordCount(Servicequeue.class, where, params, paramsValues);
            switch(destination){
                case "pharmacy":
                    topic = String.format("/topic/canceledpatientsdispensing/%s/%s", facilityunitid, facilityId);
                    break;
                case "consultation":
                    topic = String.format("/topic/canceledpatientsconsultation/%s/%s", facilityunitid, facilityId);
                    break;
                case "triage":
                    topic = String.format("/topic/canceledpatientstriage/%s/%s", facilityunitid, facilityId);
                    break;
                case "triageHTDM":
                    topic = String.format("/topic/canceledpatientstriageHTDM/%s/%s", facilityunitid, facilityId);
                    break;
                case "paedconsultation":
                    topic = String.format("/topic/canceledpatientspaedconsultation/%s/%s", facilityunitid, facilityId);
                    break;
            }
            template.convertAndSend(topic, canceled);
        } catch(NumberFormatException | MessagingException ex){
            System.out.println(ex);
        }
    }
//    @MessageMapping("/pausedprescriptions/{facilityunitid}/{facilityId}")
//    public void pausedPrescriptions(Map<String, Object> data, @DestinationVariable String facilityunitid, 
//            @DestinationVariable String facilityId){        
//        try {
//            String topic = "";
//            final Long facilityUnitId = Long.parseLong(data.get("facilityunitid").toString());
//            final String destination = data.get("destination").toString();
//            String[] params = new String[]{"paused", "facilityunitid"};
//            Object[] paramsValues = new Object[]{Boolean.TRUE, facilityUnitId};
//            String where = "WHERE paused=:paused AND DATE(datepaused)=DATE 'now' AND facilityunitid=:facilityunitid AND LOWER(pausetype) <> 'automatic'";
//            int pausedPrescriptionsCount = genericClassService.fetchRecordCount(Pausedprescriptions.class, where, params, paramsValues);
//            
//            switch(destination){
//                case "pharmacy":
//                    topic = String.format("/topic/pausedprescriptionsdispensing/%s/%s", facilityunitid, facilityId);
//                    break;
//            }
//            template.convertAndSend(topic, pausedPrescriptionsCount);
//        } catch(NumberFormatException | MessagingException ex) {
//            System.out.println(ex);
//        }
//    }
    @MessageMapping("/patientlabs/{facilityunitid}/{facilityId}")
    public void patientLabs(Map<String, Object> data, @DestinationVariable String facilityunitid,
            @DestinationVariable String facilityId){
        try {
            Integer serviced;
            String topic = "";
            final String type = data.get("type").toString();
            final long facilityUnitId = Long.parseLong(data.get("facilityunitid").toString());
            final long staffId = Long.parseLong(data.get("staffid").toString());
            final String destination = data.get("destination").toString();
            if ("requests".equalsIgnoreCase(type)) {
                String[] params = {"originunit", "status", "addedby", "dateadded"};
                Object[] paramsValues = { facilityUnitId, "SENT", staffId, new Date()};
                String where = "WHERE originunit=:originunit AND status=:status AND addedby=:addedby AND dateadded=:dateadded";
                serviced = genericClassService.fetchRecordCount(Laboratoryrequest.class, where, params, paramsValues);
                switch(destination){
                    case "consultation":
                        topic = String.format("/topic/labrequestsconsultation/%s/%s", facilityunitid, facilityId);
                        break;
                }
            } else {
                String[] params = {"originunit", "status", "dateadded"};
                Object[] paramsValues = { facilityUnitId, "SERVICED", new Date()};
                String where = "WHERE originunit=:originunit AND status=:status AND dateadded=:dateadded";
                serviced = genericClassService.fetchRecordCount(Laboratoryrequest.class, where, params, paramsValues);
                switch(destination){
                    case "consultation":
                        topic = String.format("/topic/labresultsconsultation/%s/%s", facilityunitid, facilityId);
                        break;
                    }
            }
            template.convertAndSend(topic, serviced);
        } catch(NumberFormatException | MessagingException e){
            System.out.println(e);
        }
    }
    @MessageMapping("/updatetakenprescriptionslist/{facilityunitid}/{facilityId}/{service}")
    public void updateTakenPrescriptionsList(Map<String, Object> data,
            @DestinationVariable String facilityId, @DestinationVariable("facilityunitid") String facilityunitid,
            @DestinationVariable String service){
        String topic = String.format("/topic/takenprescriptionslist/%s/%s/%s", facilityId, facilityunitid, service);
        template.convertAndSend(topic, data);
    }
    private long fetchPrescriptionQueueSize(Long facilityunitid, String queueStage) {
        long queueSize = 0;
        try {
            String[] params = {"facilityunitid", "queuestage"};
            Object[] paramsValues = {facilityunitid, queueStage};
//            String where = "WHERE facilityunitid=:facilityunitid AND LOWER(queuestage)=:queuestage AND timeout IS NULL AND DATE(timein)=DATE 'now'";
            String where = "WHERE facilityunitid=:facilityunitid AND LOWER(queuestage)=:queuestage AND ispopped=false AND DATE(timein)=DATE 'now'";
            queueSize = genericClassService.fetchRecordCount(Prescriptionqueue.class, where, params, paramsValues);
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return queueSize;
    }
    private long fetchServicePrescriptionCount(long facilityUnitId) {
        long count = 0L;
        try { 
            String [] fields = { "prescriptionid", "patientvisitid" };
            String [] params = { "dateadded", "destinationunitid"  };
            Object [] paramsValues = { new Date(), BigInteger.valueOf(facilityUnitId) };
            String where = "WHERE DATE(dateadded)=:dateadded AND destinationunitid=:destinationunitid";
            List<Object[]> servicedPrescriptions = (List<Object[]>) genericClassService.fetchRecord(Servicedprescriptionstats.class, fields, where, params, paramsValues);
            if(servicedPrescriptions != null){
                count = servicedPrescriptions.size();
            }
//            String [] fields = { "prescriptionid", "patientvisitid" };
//            String [] params = { "timein", "facilityunitid", "isserviced", "isunresolved" };
//            Object [] paramsValues = { new Date(), BigInteger.valueOf(facilityUnitId), Boolean.TRUE, Boolean.FALSE };
//            String where = "WHERE DATE(timein)=:timein  AND facilityunitid=:facilityunitid AND isserviced=:isserviced AND  isunresolved=:isunresolved";
//            List<Object[]> servicedPrescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescriptionqueue.class, fields, where, params, paramsValues);
//            if(servicedPrescriptions != null){
//                count = servicedPrescriptions.size();
//            }
//            String[] params = new String[]{"dateissued", "isissued", "destinationunitid"};
//            Object[] paramsValues = new Object[]{new Date(), Boolean.TRUE, BigInteger.valueOf(facilityUnitId)};
//            String where = "WHERE dateissued=:dateissued AND isissued=:isissued AND destinationunitid=:destinationunitid GROUP BY prescriptionid";
//            List<Object> servicedPrescriptionCount = (List<Object>) genericClassService.fetchRecord(Newprescriptionissueview.class, new String[]{"prescriptionid"}, where, params, paramsValues);
//            if (servicedPrescriptionCount != null) {
//                count = servicedPrescriptionCount.size();
//            }
            //
//            params = new String[]{"dateprescribed", "destinationunitid"};
//            paramsValues = new Object[]{new Date(), BigInteger.valueOf(facilityUnitId)};
//            where = "WHERE dateprescribed=:dateprescribed AND destinationunitid=:destinationunitid GROUP BY prescriptionid";
//            List<Object> count2 = (List<Object>) genericClassService.fetchRecord(Unservicedprescriptionsview.class, new String[]{"prescriptionid"}, where, params, paramsValues);            
            //           
//            if(count2 != null){
//                count += count2.size();
//            }
            //
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
    private int fetchServicedPatientsCount(final BigInteger unitServiceId){
        String[] params = {"unitserviceid", "serviced", "canceled"};
        Object[] paramsValues = { unitServiceId, Boolean.TRUE, Boolean.FALSE };
        String where = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND DATE(timein)=DATE 'now'";
        int serviced = genericClassService.fetchRecordCount(Servicequeue.class, where, params, paramsValues);
        return serviced;
    }        
}
