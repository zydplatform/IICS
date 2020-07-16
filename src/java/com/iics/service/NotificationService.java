/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service;

import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

/**
 *
 * @author IICS
 */
public interface NotificationService {
    public void doNotify(SseEmitter emitter , Object data, String eventName);
}
