/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service.impl;

import com.iics.service.NotificationService;
import java.io.IOException;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

/**
 *
 * @author IICS
 */
@EnableScheduling
@Service("notificationService")
public class NotificationServiceImpl implements NotificationService {

    @Override
    @Async
    public void doNotify(SseEmitter emitter , Object data, String eventName) {
        try {
            ((SseEmitter) emitter).send(SseEmitter.event().name(eventName).data(data));
            emitter.complete();
        } catch (IOException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }   
    }
    
}
