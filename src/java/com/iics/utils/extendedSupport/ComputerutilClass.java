/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.utils.extendedSupport;

import com.iics.utils.OsCheck;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.HashSet;
import java.util.Set;
import java.util.Collections;
import java.util.Enumeration;
import java.util.Arrays;
import java.util.List;
import java.net.InterfaceAddress;

/**
 *
 * @author samuelwam
 */
public class ComputerutilClass {

    static final Logger logger = Logger.getLogger(ComputerutilClass.class.getName());
    static InetAddress ip;
    private static Set<String> IP0MAC1 = new HashSet<String>();

    public static String[] getMacAddressWithIPByNetworkInterface() {
        String[] IP0MAC1_local = new String[3];
        try {
            ip = InetAddress.getLocalHost();
            System.out.println("Current IP address : " + ip.getHostName());
            IP0MAC1_local[0] = ip.getHostAddress();

            NetworkInterface network = NetworkInterface.getByInetAddress(ip);
            System.out.print("xxxxxxxxxxxxxxxxxxxx : " + network);
            byte[] mac = network.getHardwareAddress();

            System.out.print("Current MAC address : ");

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < mac.length; i++) {
                if (network.isVirtual()) {
                    continue;
                }
                sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));
            }
            System.out.println(sb.toString());
            IP0MAC1_local[1] = sb.toString();
            IP0MAC1_local[2] = ip.getHostName();
            System.out.print("Current Host : " + ip.getHostName());
        } catch (UnknownHostException e) {
            IP0MAC1_local[0] = "ERROR";
            IP0MAC1_local[1] = "ERROR";
            IP0MAC1_local[2] = "ERROR";
            e.printStackTrace();
        } catch (SocketException e) {
            IP0MAC1_local[0] = "ERROR";
            IP0MAC1_local[1] = "ERROR";
            IP0MAC1_local[2] = "ERROR";
            e.printStackTrace();
        }
        return IP0MAC1_local;
    }

    public static String[] getMacAddressWithGatewayByCommand() {
        String[] IP0MAC1_local = new String[5];
        try {

            System.out.println("Os type::" + OsCheck.getOperatingSystemType());
            String command = "netstat -rn";//"ipconfig /all";
            String command2 = "ifconfig -a";
            String patternString2 = ".*Link encap:Ethernet  HWaddr.*";
            String ipStartString2 = ".*inet addr:.*";
            //creating image temporary storage directory on windows machine
            if (OsCheck.getOperatingSystemType().toString().equals("Windows")) {
                command2 = "ipconfig /all";
                patternString2 = ".*Physical Addres.*: (.*)";
                ipStartString2 = ".*IPv4 Address.*: (.*)";
                logger.info("Detected that your Server is: Windows");

            } else if (OsCheck.getOperatingSystemType().toString().equals("Linux")) {
                command2 = "ifconfig -a";
                patternString2 = ".*Link encap:Ethernet  HWaddr.*";
                ipStartString2 = ".*inet addr:.*";
                logger.info("Detected that your Server is: Linux/Unix");

            } else if (OsCheck.getOperatingSystemType().toString().equals("MacOS")) {

                logger.info("Detected that your Server is: MacOS");
            }

            String _255 = "(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)";
            String exIP = "(?:" + _255 + "\\.){3}" + _255;

            Process p = Runtime.getRuntime().exec(command);
            BufferedReader inn = new BufferedReader(new InputStreamReader(p.getInputStream()));
            java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("^\\s*(?:0\\.0\\.0\\.0\\s*){1,2}(" + exIP + ").*");//(".*Physical Addres.*: (.*)");

            Process p2 = Runtime.getRuntime().exec(command2);
            BufferedReader inn2 = new BufferedReader(new InputStreamReader(p2.getInputStream()));
            java.util.regex.Pattern pattern2 = java.util.regex.Pattern.compile(patternString2);
            java.util.regex.Pattern patternIP = java.util.regex.Pattern.compile(ipStartString2);
            int i = 0;
            while (true) {
                String line = inn2.readLine();
                System.out.println("Line["+i+"]: "+line);

                i++;
                if (line == null) {
                    break;
                }

                Matcher mmIP = patternIP.matcher(line.trim());
                if (mmIP.matches()) {
                    System.out.println("Line====" + line + "=====Pattern==" + ipStartString2);
                    java.util.regex.Pattern defGate = java.util.regex.Pattern.compile(".*Default Gateway.*");
                    if (!defGate.matcher(line).matches()) {
                        //continue;
                    }

//                    String ipx = mmIP.group(0).substring(mmIP.group(0).lastIndexOf("addr:")+5).trim();
//                    java.util.regex.Pattern patternIP2 = java.util.regex.Pattern.compile(".*Bcast:.*");
                    if (OsCheck.getOperatingSystemType().toString().equals("Windows")) {
                        System.out.println(line + " IP~~~~~~~" + line.substring(line.indexOf(":")).trim() + "~~~~~~~~~~~~~~~");
                        String ipadd = line.substring(line.indexOf(":")).trim();
                        IP0MAC1_local[0] = ipadd;
                        break;
                    } else if (OsCheck.getOperatingSystemType().toString().equals("Linux")) {
                        System.out.println(line.trim() + " IP~~~~~~~" + line.trim().substring(line.trim().indexOf(ipStartString2) + 10, line.trim().indexOf("Bcast:")).trim() + "~~~~~~~~~~~~~~~");
                        String ipadd = line.substring(line.trim().indexOf(ipStartString2) + 10, line.trim().indexOf("Bcast:")).trim();
                        IP0MAC1_local[0] = ipadd;//mmIP.group(0);
                        break;
                    } else if (OsCheck.getOperatingSystemType().toString().equals("MacOS")) {

                    }

                }

                Matcher mm = pattern2.matcher(line.trim());

                if (mm.matches()) {
                    if (OsCheck.getOperatingSystemType().toString().equals("Windows")) {
                        System.out.println(" MAC~~~~~~~" + mm.group(0).trim() + "~~~~~~~~~~~~~~~");
                        IP0MAC1_local[1] = mm.group(0);
                        break;

                    } else if (OsCheck.getOperatingSystemType().toString().equals("Linux")) {
                        System.out.println(" MAC~~~~~~~" + mm.group(0).substring(mm.group(0).lastIndexOf("HWaddr") + 6).trim() + "~~~~~~~~~~~~~~~");
                        IP0MAC1_local[1] = mm.group(0);
                        break;

                    } else if (OsCheck.getOperatingSystemType().toString().equals("MacOS")) {

                    }

                }
            }

            while (true) {
                String line = inn.readLine();

                if (line == null) {
                    break;
                }

                Matcher mm = pattern.matcher(line.trim());
                if (mm.matches()) {
                    System.out.println("========" + mm.group(1).substring(mm.group(1).indexOf(":") + 1) + "=========");
                    System.out.println(": Gateway~~~~~~~" + mm.group(1));
                    IP0MAC1_local[2] = mm.group(1);
                    break;
//                    System.out.println(mm.group(2));
                }
            }
            IP0MAC1_local[3] = InetAddress.getLocalHost().getHostName();
            IP0MAC1_local[4] = InetAddress.getLocalHost().getHostAddress();

        } catch (IOException ex) {
            Logger.getLogger(ComputerutilClass.class.getName()).log(Level.SEVERE, null, ex);
            IP0MAC1_local[0] = "ERROR";
            IP0MAC1_local[1] = "ERROR";
            IP0MAC1_local[2] = "ERROR";
        }
        return IP0MAC1_local;
    }

    private static void displayInterfaceInformation(NetworkInterface netint) throws SocketException {
        System.out.printf("Display name: %s%n", netint.getDisplayName());
        System.out.printf("Name: %s%n", netint.getName());
        Enumeration<InetAddress> inetAddresses = netint.getInetAddresses();
        for (InetAddress inetAddress : Collections.list(inetAddresses)) {
            System.out.printf("InetAddress: %s%n", inetAddress);
        }

        System.out.printf("Parent: %s%n", netint.getParent());
        System.out.printf("Up? %s%n", netint.isUp());
        System.out.printf("Loopback? %s%n", netint.isLoopback());
        System.out.printf("PointToPoint? %s%n", netint.isPointToPoint());
        System.out.printf("Supports multicast? %s%n", netint.isVirtual());
        System.out.printf("Virtual? %s%n", netint.isVirtual());
        System.out.printf("Hardware address: %s%n", Arrays.toString(netint.getHardwareAddress()));
        System.out.printf("MTU: %s%n", netint.getMTU());

        List<InterfaceAddress> interfaceAddresses = netint.getInterfaceAddresses();
        for (InterfaceAddress addr : interfaceAddresses) {
            System.out.printf("InterfaceAddress: %s%n", addr.getAddress());
        }
        System.out.printf("%n");
        Enumeration<NetworkInterface> subInterfaces = netint.getSubInterfaces();
        for (NetworkInterface networkInterface : Collections.list(subInterfaces)) {
            if (networkInterface.isUp()) {
                System.out.printf("%nSubInterface%n");
                displayInterfaceInformation(networkInterface);
            }
        }
        System.out.printf("%n");
    }

    public static void main(String[] args) throws UnknownHostException, SocketException {
        getMacAddressWithGatewayByCommand();
//        getMacAddressWithIPByNetworkInterface();

        Enumeration<NetworkInterface> nets = NetworkInterface.getNetworkInterfaces();
        for (NetworkInterface netint : Collections.list(nets)) {
            displayInterfaceInformation(netint);
        }
    }

}
