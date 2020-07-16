/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web.general;

import com.iics.domain.Facilityservices;
import com.iics.domain.Facilityunitservice;
import com.iics.patient.Waitingtime;
import com.iics.service.GenericClassService;
import com.iics.service.NotificationService;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

/**
 *
 * @author IICS TECHS
 */
@Controller
@RequestMapping("/notifications")
public class NotificationContoller {
    @Autowired
    NotificationService notificationService;
    
    @Autowired
    GenericClassService genericClassService;
    
    @RequestMapping(value = "/averagewaitingtime", method = RequestMethod.GET)
    public @ResponseBody ResponseEntity<SseEmitter> averageWaitingTime(HttpServletRequest request) {    
        final SseEmitter emitter = new SseEmitter();
        HttpHeaders responseHeaders = new HttpHeaders();
//        Map<String, Object> data = new HashMap<>();
        try {
            responseHeaders.add("Content-Type", "text/event-stream");
            responseHeaders.add("Cache-Control", "no-cache");
            responseHeaders.add("Connection", "keep-alive");
            responseHeaders.add("Expires", "-1");
            BigInteger unitServiceId = BigInteger.valueOf(0);
            Integer facilityunitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            
            String[] params = {"servicekey"};
            Object[] paramsValues = {"key_triage"};
            String[] fields = {"serviceid"};
            List<Integer> triage = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fields, "WHERE servicekey=:servicekey", params, paramsValues);
            if (triage != null) {
                params = new String[] {"serviceid", "facilityunit"};
                paramsValues = new Object[] {triage, facilityunitId};
                fields = new String[] {"facilityunitserviceid"};
                String where = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                List<Long> serviceid = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
                if (serviceid != null) {
                    unitServiceId = BigInteger.valueOf(serviceid.get(0));
                }
            }
            Double waitingTimeTriage = fetchAverageWaitingTime(unitServiceId);
            
            params = new String[] {"servicekey"};
            paramsValues = new Object[] {"key_htdm"};
            fields = new String[] {"serviceid"};
            List<Integer> htdmService = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fields, "WHERE servicekey=:servicekey", params, paramsValues);
            if (htdmService != null) {
                params = new String[] {"serviceid", "facilityunit"};
                paramsValues = new Object[] {htdmService.get(0), facilityunitId};
                fields = new String[] {"facilityunitserviceid"};
                String where = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                List<Long> serviceid = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
                if (serviceid != null) {
                    unitServiceId = BigInteger.valueOf(serviceid.get(0));
                }
            }            
            waitingTimeTriage += fetchAverageWaitingTime(unitServiceId);  
            
            params = new String[] {"servicekey"};
            paramsValues = new Object[] {"key_consultation"};
            fields = new String[] {"serviceid"};
            List<Integer> consultation = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fields, "WHERE servicekey=:servicekey", params, paramsValues);
            if (consultation != null) {
                params = new String[] {"serviceid", "facilityunit"};
                paramsValues = new Object[] {consultation, facilityunitId};
                fields = new String[] {"facilityunitserviceid"};
                String where = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                List<Long> serviceidconsultation = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
                if (serviceidconsultation != null) {
                    unitServiceId = BigInteger.valueOf(serviceidconsultation.get(0));
                }
            }
            Double waitingTimeConsultation = fetchAverageWaitingTime(unitServiceId);
            
            params = new String[] {"servicekey"};
            paramsValues = new Object[] {"key_dispensing"};
            fields = new String[] {"serviceid"};
            List<Integer> dispensing = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fields, "WHERE servicekey=:servicekey", params, paramsValues);
            if (dispensing != null) {
                params = new String[] {"serviceid", "facilityunit"};
                paramsValues = new Object[] {dispensing, facilityunitId};
                fields = new String[] {"facilityunitserviceid"};
                String where = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                List<Long> serviceid = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
                if (serviceid != null) {
                    unitServiceId = BigInteger.valueOf(serviceid.get(0));
                }
            }            
            Double waitingTimeDispensing = fetchAverageWaitingTime(unitServiceId);
            //
            Map<String, Object> data = new HashMap<>();
            data.put("triage", Math.round(waitingTimeTriage));
            data.put("consultation", Math.round(waitingTimeConsultation));
            data.put("dispensing", Math.round(waitingTimeDispensing));            
            notificationService.doNotify(emitter, data, "averageWaitingTime");
        } catch(NumberFormatException e){
            System.out.println(e);
        }catch(Exception e){
            System.out.println(e);
        }
        return new ResponseEntity<>(emitter, responseHeaders, HttpStatus.OK);
    }
    private Double fetchAverageWaitingTime(final BigInteger unitServiceId){
        double waitingTime = 0;
        String[] params = { "unitserviceid" };
        Object[] paramsValues = { unitServiceId };
        String[] fields = {"sum"};
        String where = "WHERE unitserviceid=:unitserviceid AND DATE(dateadded)=DATE 'now'";
        List<Object> time = (List<Object>) genericClassService.fetchRecord(Waitingtime.class, fields, where, params, paramsValues);
        if (time != null) {
            waitingTime = (double)time.get(0);
        }
        return waitingTime;
    }
}
