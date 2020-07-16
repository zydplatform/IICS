/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.utils.general;

import java.security.SecureRandom;
import java.util.Random;

/**
 *
 * @author bibangamba
 */
public class OTPGenerator {

    public static String generatePassword() {
        String chars = "abcdefghijklmnopqrstuvwxyz"
                + "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                + "0123456789@#$&";
//        String chars = "abcdefghijklmnopqrstuvwxyz"
//                + "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
//                + "0123456789!@%$%&^?|~'\"#+="
//                + "\\*/.,:;[]()-_<>";

        final int PW_LENGTH = 8;
//        final int PW_LENGTH = 20;
        Random rnd = new SecureRandom();
        StringBuilder pass = new StringBuilder();
        for (int i = 0; i < PW_LENGTH; i++) {
            pass.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return pass.toString();
    }

    public static String generateHOTPAPassword() {

        String pass = "12345678901234567890";
        String result = "";
        byte[] code = pass.getBytes();
        for (int i = 0; i < 10; i++) {
            try {
                result = HOTPAlgorithm.generateOTP(code, i, 6, false, i);
            } catch (Exception e) {
                System.out.println("Exception = " + e);
            }
        }
        return result;//if result.equal("null"), terminate and show error
    }
}
