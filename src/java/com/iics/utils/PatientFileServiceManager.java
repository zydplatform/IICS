/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.utils;

/**
 *
 * @author IICS
 */
public class PatientFileServiceManager {
     //create an object of SingleObject
   private static PatientFileServiceManager instance = new PatientFileServiceManager();

   //make the constructor private so that this class cannot be
   //instantiated
   private PatientFileServiceManager(){
   
   }

   //Get the only object available
   public static PatientFileServiceManager getInstance(){
      return instance;
   }
}
