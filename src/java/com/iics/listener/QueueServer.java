/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.listener;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 *
 * @author IICS
 */
public class QueueServer implements ServletContextListener {

    ServerSocket serversocket = null;
    Map<String, Object> unitServices = new HashMap<>();
    Map<String, Object> unitServicePoints = new HashMap<>();

    @Override
    public void contextInitialized(ServletContextEvent sce) {
//        new ConnectionListener().start();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
//        try {
//            System.out.println("Closing Queuing Server");
//            serversocket.close();
//            serversocket = null;
//            System.out.println("Queuing Server Closed");
//        } catch (IOException ex) {
//            System.out.println(ex + "--------------------");
//        }
    }

    class ConnectionListener extends Thread {

        @Override
        public void run() {
            try {
                System.out.println("Starting Queuing Server");
                serversocket = new ServerSocket(1280);
            } catch (IOException e) {
                try {
                    serversocket = new ServerSocket();
                    serversocket.bind(new InetSocketAddress("localhost", 1280));
                    System.out.println(e);
                } catch (IOException ex) {
                    System.out.println(ex);
                }
            }
            System.out.println("Queuing Server Started");
            while (true) {
                try {
                    Socket pipe = serversocket.accept();
                    BufferedReader in = new BufferedReader(new InputStreamReader(pipe.getInputStream()));

                    String input = in.readLine();
                    System.out.println(input);
                    PrintWriter out = new PrintWriter(pipe.getOutputStream(), true);
                    out.println(input);
//                    Map<String, Object> clientConnection = new ObjectMapper().readValue(input, Map.class);
//                    String type = (String) clientConnection.get("type");
//                    if (type.equalsIgnoreCase("ADD")) {
//                        new QueuePatient(clientConnection, pipe).start();
//                    } else if (type.equalsIgnoreCase("SERVICEPOINT")) {
//                        new ServicePoint(clientConnection, pipe).start();
//                    }
                } catch (IOException e) {
                    System.out.println(e);
                }
            }
        }
    }

    class QueuePatient extends Thread {

        int patientCount = 0;
        Socket clientSocket;
        Map<String, Object> visit;

        public QueuePatient(Map<String, Object> visit, Socket clientSocket) {
            this.visit = visit;
            this.clientSocket = clientSocket;
        }

        @Override
        public void run() {
            try {
                Map<String, Object> service = (Map<String, Object>) unitServices.get("service" + visit.get("serviceid").toString());
                if (service != null) {
                    List<Map> patients = (List<Map>) service.get("patients");
                    if (patients != null) {
                        Map<String, Object> newVisit = new HashMap<>();
                        newVisit.put("timein", new Date());
                        newVisit.put("type", visit.get("type"));
                        newVisit.put("visitid", visit.get("visitid"));
                        if ("NORMAL".equalsIgnoreCase(visit.get("type").toString())) {
                            patients.add(newVisit);
                        } else {
                            //Logic for emergency queues goes here.
                            patients.add(newVisit);
                        }
                    } else {
                        patients = new ArrayList<>();
                        Map<String, Object> newVisit = new HashMap<>();
                        newVisit.put("timein", new Date());
                        newVisit.put("type", visit.get("type"));
                        newVisit.put("visitid", visit.get("visitid"));

                        //Add new Visit to Queue.
                        patients.add(newVisit);
                    }
                    patientCount = patients.size();
                    service.put("patients", patients);
                } else {
                    service = new HashMap<>();
                    List<Map> patients = new ArrayList<>();
                    Map<String, Object> newVisit = new HashMap<>();
                    newVisit.put("timein", new Date());
                    newVisit.put("type", visit.get("type"));
                    newVisit.put("visitid", visit.get("visitid"));

                    //Add new Visit to Queue.
                    patients.add(newVisit);

                    service.put("patients", patients);
                }
                unitServices.put("service" + visit.get("serviceid").toString(), service);
                new PrintWriter(clientSocket.getOutputStream(), true).println(1);
                clientSocket.close();

                //Update all service points with new count.
                Map<String, Object> servicePoints = (Map<String, Object>) unitServicePoints.get("service" + visit.get("serviceid").toString());
                if (servicePoints != null) {
                    List<Map> serviceCentres = (List<Map>) servicePoints.get("centers");
                    for (Map center : serviceCentres) {
                        Socket centerSocket = (Socket) center.get("socket");
                        if (centerSocket.isConnected()) {
                            new PrintWriter(centerSocket.getOutputStream(), true).println(patientCount);
                            centerSocket.close();
                        }
                    }
                }
            } catch (IOException e) {
                System.out.println(e);
            }
        }
    }

    class ServicePoint extends Thread {

        int patientCount = 0;
        Map<String, Object> point;
        Socket servicePointSocket;

        public ServicePoint(Map<String, Object> point, Socket servicePointSocket) {
            this.point = point;
            this.servicePointSocket = servicePointSocket;
        }

        @Override
        public void run() {
            try {
                Map<String, Object> service = (Map<String, Object>) unitServicePoints.get("service" + point.get("serviceid").toString());
                if (service != null) {
                    List<Map> servicePoints = (List<Map>) service.get("centers");
                    if (servicePoints != null) {
                        boolean found = false;
                        for (int i = 0; i < servicePoints.size(); i++) {
                            Map newPoint = servicePoints.get(i);
                            if ((newPoint.get("staffid").toString()).equalsIgnoreCase(point.get("staffid").toString())) {
                                newPoint.put("timein", new Date());
                                newPoint.put("staffid", point.get("staffid"));
                                newPoint.put("room", point.get("room"));
                                //Close Previous connection.
                                ((Socket) newPoint.get("socket")).close();
                                newPoint.put("socket", servicePointSocket);
                                servicePoints.add(newPoint);
                                found = true;
                                break;
                            }
                        }
                        if (!found) {
                            Map<String, Object> newPoint = new HashMap<>();
                            newPoint.put("timein", new Date());
                            newPoint.put("staffid", point.get("staffid"));
                            newPoint.put("room", point.get("room"));
                            newPoint.put("socket", servicePointSocket);
                            servicePoints.add(newPoint);
                        }
                    } else {
                        servicePoints = new ArrayList<>();
                        Map<String, Object> newPoint = new HashMap<>();
                        newPoint.put("timein", new Date());
                        newPoint.put("staffid", point.get("staffid"));
                        newPoint.put("room", point.get("room"));
                        newPoint.put("socket", servicePointSocket);

                        //Add new service Point to List.
                        servicePoints.add(newPoint);
                    }
                    service.put("centers", servicePoints);
                } else {
                    service = new HashMap<>();
                    List<Map> servicePoints = new ArrayList<>();
                    Map<String, Object> newPoint = new HashMap<>();
                    newPoint.put("timein", new Date());
                    newPoint.put("staffid", point.get("staffid"));
                    newPoint.put("room", point.get("room"));
                    newPoint.put("socket", servicePointSocket);

                    //Add new service Point to List.
                    servicePoints.add(newPoint);

                    service.put("centers", servicePoints);
                }
                unitServices.put("service" + point.get("serviceid").toString(), service);

                //Update new center with current no of Patients.
                Map<String, Object> patientQueue = (Map<String, Object>) unitServices.get("service" + point.get("serviceid").toString());
                if (patientQueue != null) {
                    List<Map> patients = (List<Map>) service.get("patients");
                    if (patients != null) {
                        patientCount = patients.size();
                    }
                }
                if (servicePointSocket.isConnected()) {
                    new PrintWriter(servicePointSocket.getOutputStream(), true).println(patientCount);
                }
                servicePointSocket.close();
            } catch (IOException e) {
                System.out.println(e);
            }
        }
    }
}
