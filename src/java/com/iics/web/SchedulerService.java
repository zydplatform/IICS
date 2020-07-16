/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.controlpanel.Autoactivityrunsetting;
import com.iics.controlpanel.Services;
import com.iics.service.GenericClassService;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ScheduledFuture;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Service;

/**
 *
 * @author IICS
 */
//@Service
public class SchedulerService {
    //@Scheduled(fixedDelay=5000)
    //@Scheduled(fixedRate=5000)

    @Autowired
    GenericClassService genericClassService;
    @Autowired
    private TaskScheduler taskScheduler;
    @Autowired
    private final ApplicationContext appContextx= new ClassPathXmlApplicationContext("classpath:**/spring-scheduler.xml");

    //@Scheduled(cron = "0 0/5 * 1/1 * ?")
    public void doSchedule() {
        try {
          System.out.println("Re-Start Stopped schedules");
        String[] params = {"today", "interrupted", "startonstartup", "status"};
        Object[] paramsValues = {new Date(), Boolean.FALSE, Boolean.TRUE, Boolean.TRUE};
        String[] fields = {"startingtimepattern", "serviceid", "autoactivityrunsetting"};
        List<Object[]> unrunservices = (List<Object[]>) genericClassService.fetchRecord(Services.class, fields, "WHERE nextruntime<:today AND interrupted=:interrupted AND startonstartup=:startonstartup AND status=:status", params, paramsValues);
        if (unrunservices != null) {
            for (Object[] unrunservice : unrunservices) {
                CronTrigger trigger = new CronTrigger((String)unrunservice[0]);
                String[] params1 = {"autoactivityrunsettingid"};
                Object[] paramsValues1 = {unrunservice[2]};
                String[] fields1 = {"beanname"};
                List<String> autoactivityrunsetting = (List<String>) genericClassService.fetchRecord(Autoactivityrunsetting.class, fields1, "WHERE autoactivityrunsettingid=:autoactivityrunsettingid", params1, paramsValues1);
                if (autoactivityrunsetting != null) {
                    ScheduledFuture scedulefuture2 = taskScheduler.schedule((Runnable) appContextx.getBean(autoactivityrunsetting.get(0)), trigger);
                }
            }

        }
        System.out.println("End Re-Start Stopped schedule");  
        } catch (Exception e) {
            System.out.println("com.iics.web.SchedulerService.doSchedule():"+e);
        }
        
    }
}
