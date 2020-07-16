/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web.general;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.utils.IICS;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.websocket.EndpointConfig;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import org.directwebremoting.guice.ApplicationScoped;

/**
 *
 * @author IICS
 */
@ApplicationScoped
@ServerEndpoint("/queuingServer")
public class QueuingServer {

    private static Map<String, Object> unitServicePoints = new HashMap<>();

    @OnOpen
    public void open(Session session, EndpointConfig epCfg) throws IOException {
        List staffid = session.getRequestParameterMap().get("staffid");
        if (staffid != null) {
            //
            IICS.BASE_URL = (session.getRequestParameterMap().get("host") != null) ? "http://" + session.getRequestParameterMap().get("host").get(0).toString() + "/IICS/" : IICS.BASE_URL;
            //
            List serviceid = session.getRequestParameterMap().get("serviceid");
            List room = session.getRequestParameterMap().get("room");
            List label = session.getRequestParameterMap().get("label");

            Map<String, Object> unitService = (Map<String, Object>) unitServicePoints.get("service" + serviceid.get(0).toString());
            if (unitService != null) {
                List<Map> servicePoints = (List<Map>) unitService.get("centers");
                if (servicePoints != null) {
                    boolean found = false;
                    for (int i = 0; i < servicePoints.size(); i++) {
                        Map newPoint = servicePoints.get(i);
                        if ((newPoint.get("staffid").toString()).equalsIgnoreCase(staffid.get(0).toString())) {
                            servicePoints.get(i).put("timein", new Date());
                            servicePoints.get(i).put("staffid", staffid.get(0));
                            servicePoints.get(i).put("room", room.get(0));
                            servicePoints.get(i).put("label", label.get(0));
                            servicePoints.get(i).put("socket", session);
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        Map<String, Object> newPoint = new HashMap<>();
                        newPoint.put("timein", new Date());
                        newPoint.put("staffid", staffid.get(0));
                        newPoint.put("label", label.get(0));
                        newPoint.put("room", room.get(0));
                        newPoint.put("socket", session);
                        servicePoints.add(newPoint);
                    }
                } else {
                    servicePoints = new ArrayList<>();
                    Map<String, Object> newPoint = new HashMap<>();
                    newPoint.put("timein", new Date());
                    newPoint.put("staffid", staffid.get(0));
                    newPoint.put("label", label.get(0));
                    newPoint.put("room", room.get(0));
                    newPoint.put("socket", session);

                    //Add new service Point to List.
                    servicePoints.add(newPoint);
                }
                unitService.put("centers", servicePoints);
            } else {
                unitService = new HashMap<>();
                List<Map> servicePoints = new ArrayList<>();
                Map<String, Object> newPoint = new HashMap<>();
                newPoint.put("timein", new Date());
                newPoint.put("staffid", staffid.get(0));
                newPoint.put("label", label.get(0));
                newPoint.put("room", room.get(0));
                newPoint.put("socket", session);

                //Add new service Point to List.
                servicePoints.add(newPoint);
                unitService.put("centers", servicePoints);
            }
            unitServicePoints.put("service" + serviceid.get(0).toString(), unitService);
            //Echo current queue state.
            Map<String, Object> response = new HashMap<>();
            response.put("type", "update");
            response.put("size", getQueueSize(Integer.parseInt((String) serviceid.get(0))));
            String responseBody = new ObjectMapper().writeValueAsString(response);
            session.getBasicRemote().sendText(responseBody);

            //Assign next patient
            response = new HashMap<>();
            response.put("type", "next");
            response.put("visit", popPatient(Integer.parseInt((String) serviceid.get(0))));
            responseBody = new ObjectMapper().writeValueAsString(response);
            session.getBasicRemote().sendText(responseBody);
        }
    }

    @OnMessage
    public void onMessage(Session session, String message) {
        try {
            Map<String, Object> response = new HashMap<>();
            Map<String, Object> clientConnection = new ObjectMapper().readValue(message, Map.class);
            String type = (String) clientConnection.get("type");
            //
            IICS.BASE_URL = (clientConnection.get("host") != null) ? "http://" + clientConnection.get("host").toString() + "/IICS/" : IICS.BASE_URL;
            //
            if (type.equalsIgnoreCase("ADD")) {
                Integer serviceid = Integer.parseInt(clientConnection.get("serviceid").toString());
                //Add new patient to queue.
                String saved = pushPatient(clientConnection);
                if (saved.equalsIgnoreCase("true")) {
                    session.getBasicRemote().sendText("ADDED");

                    //Update current connected staff with patient count & next patient.
                    response.put("type", "update");
                    response.put("size", getQueueSize(serviceid));
                    String responseBody = new ObjectMapper().writeValueAsString(response);

                    Map<String, Object> next = new HashMap<>();
                    next.put("type", "next");
                    next.put("visit", popPatient(serviceid));
                    String nextPatient = new ObjectMapper().writeValueAsString(next);

                    Map<String, Object> unitService = (Map) unitServicePoints.get("service" + clientConnection.get("serviceid").toString());
                    if (unitService != null) {
                        List<Map> serviceCenters = (List<Map>) unitService.get("centers");
                        for (Map activeStaff : serviceCenters) {
                            Session s;
                            if ((s = (Session) activeStaff.get("socket")).isOpen()) {
                                s.getBasicRemote().sendText(responseBody);
                                s.getBasicRemote().sendText(nextPatient);
                            }
                        }
                    }
                } else {
                    session.getBasicRemote().sendText("FAILED");
                }
            } else if (type.equalsIgnoreCase("PICK")) {
                Integer serviceid = Integer.parseInt(clientConnection.get("serviceid").toString());
                //Update patient queue details.
                String updated = servicePoppedPatient(clientConnection);
                if (updated.equalsIgnoreCase("true")) {
                    //Get current queue size.
                    response.put("type", "update");
                    response.put("size", getQueueSize(serviceid));
                    String queueSize = new ObjectMapper().writeValueAsString(response);

                    //Get next patient in queue.
                    Map<String, Object> next = new HashMap<>();
                    next.put("type", "next");
                    next.put("visit", popPatient(serviceid));
                    String nextPatient = new ObjectMapper().writeValueAsString(next);

                    //Update current connected staff.
                    Map<String, Object> unitService = (Map) unitServicePoints.get("service" + clientConnection.get("serviceid").toString());
                    if (unitService != null) {
                        List<Map> serviceCenters = (List<Map>) unitService.get("centers");
                        for (Map activeStaff : serviceCenters) {
                            Session s;
                            if ((s = (Session) activeStaff.get("socket")).isOpen()) {
                                s.getBasicRemote().sendText(queueSize);
                                s.getBasicRemote().sendText(nextPatient);
                            }
                        }
                    }
                }
            } else if (type.equalsIgnoreCase("REVERT")) {
                Integer serviceid = Integer.parseInt(clientConnection.get("serviceid").toString());
                //Update patient queue details.
                String reverted = revertPoppedPatient(clientConnection);
                if (reverted.equalsIgnoreCase("true")) {
                    //Get current queue size.
                    response.put("type", "update");
                    response.put("size", getQueueSize(serviceid));
                    String queueSize = new ObjectMapper().writeValueAsString(response);

                    //Update current connected staff.
                    Map<String, Object> unitService = (Map) unitServicePoints.get("service" + clientConnection.get("serviceid").toString());
                    if (unitService != null) {
                        List<Map> serviceCenters = (List<Map>) unitService.get("centers");
                        for (Map activeStaff : serviceCenters) {
                            Session s;
                            if ((s = (Session) activeStaff.get("socket")).isOpen()) {
                                s.getBasicRemote().sendText(queueSize);
                            }
                        }
                    }
                }
            } else if (type.equalsIgnoreCase("RESET")) {
                Integer serviceid = Integer.parseInt(clientConnection.get("serviceid").toString());

                //Update current connected staff with patient count & next patient.
                Map<String, Object> next = new HashMap<>();
                next.put("type", "next");
                next.put("visit", popPatient(serviceid));
                String nextPatient = new ObjectMapper().writeValueAsString(next);

                Map<String, Object> unitService = (Map) unitServicePoints.get("service" + clientConnection.get("serviceid").toString());
                if (unitService != null) {
                    List<Map> serviceCenters = (List<Map>) unitService.get("centers");
                    for (Map activeStaff : serviceCenters) {
                        Session s;
                        if ((s = (Session) activeStaff.get("socket")).isOpen()) {
                            s.getBasicRemote().sendText(nextPatient);
                        }
                    }
                }
            }
        } catch (IOException e) {
            System.out.println(e);
        }
    }

    private String getQueueSize(Integer unitServiceid) {
        String queueSize;
        ObjectMapper mapper = new ObjectMapper();
        try {
            queueSize = mapper.readValue(new URL(IICS.BASE_URL + "queuingSystem/fetchQueueSize?unitserviceid=" + unitServiceid), String.class);
        } catch (IOException e) {
            queueSize = "0";
        }
        return queueSize;
    }

    private String popPatient(Integer unitServiceid) {
        String popped;
        ObjectMapper mapper = new ObjectMapper();
        try {
            popped = mapper.readValue(new URL(IICS.BASE_URL + "queuingSystem/popPatient?unitserviceid=" + unitServiceid), String.class);
        } catch (IOException e) {
            popped = "0";
        }
        return popped;
    }

    private String pushPatient(Map<String, Object> visit) {
        String response;
        ObjectMapper mapper = new ObjectMapper();
        try {
            String url = IICS.BASE_URL + "queuingSystem/pushPatient?visitid=" + visit.get("visitid") + "&serviceid=" + visit.get("serviceid") + "&staffid=" + visit.get("staffid");
            response = mapper.readValue(new URL(url), String.class);
        } catch (IOException e) {
            response = "error";
        }
        return response;
    }

    private String servicePoppedPatient(Map<String, Object> visit) {
        String response;
        ObjectMapper mapper = new ObjectMapper();
        try {
            String url = IICS.BASE_URL + "queuingSystem/servicePoppedPatient?visitid=" + visit.get("visitid") + "&serviceid=" + visit.get("serviceid") + "&staffid=" + visit.get("staffid");
            response = mapper.readValue(new URL(url), String.class);
        } catch (IOException e) {
            response = "error";
        }
        return response;
    }

    private String revertPoppedPatient(Map<String, Object> visit) {
        String response;
        ObjectMapper mapper = new ObjectMapper();
        try {
            String url = IICS.BASE_URL + "queuingSystem/revertPoppedPatient?visitid=" + visit.get("visitid") + "&serviceid=" + visit.get("serviceid");
            response = mapper.readValue(new URL(url), String.class);
        } catch (IOException e) {
            response = "error";
        }
        return response;
    }
}
