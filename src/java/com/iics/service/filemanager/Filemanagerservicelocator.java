/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service.filemanager;

/**
 *
 * @author IICS
 */
public class Filemanagerservicelocator {
    private ManageFileService manageFileService;
    private ManageLocationService manageLocationService;
    private UserFileAssignmentService userFileAssignmentService;
    private static Filemanagerservicelocator instance;
    private ManageFileRequestService manageFileRequestService;
    private  ManageDocumentService manageDocumentService;
    private Filemanagerservicelocator() {
    }

    public static Filemanagerservicelocator getInstance() {
        if (instance == null) {
            instance = new Filemanagerservicelocator();
        }
        return instance;
    }

    public ManageFileService getManageFileService() {
        if (manageFileService != null) {
            return manageFileService;
        } else {
            manageFileService = new ManageFileService();
            return manageFileService;
        }
    }

    public ManageLocationService getManageLocationService() {

        if (manageLocationService != null) {
            return manageLocationService;
        } else {
            manageLocationService = new ManageLocationService();
            return manageLocationService;
        }
    }

    public UserFileAssignmentService getUserFileAssignmentService() {
           if (userFileAssignmentService!= null) {
             return userFileAssignmentService;
        } else {
            userFileAssignmentService = new UserFileAssignmentService();
            return userFileAssignmentService;
        }
       
    }

    public ManageFileRequestService getManageFileRequestService() {
       
           if (userFileAssignmentService!= null) {
             return manageFileRequestService;
        } else {
            manageFileRequestService = new ManageFileRequestService();
             return manageFileRequestService;
        }
    }

    public ManageDocumentService getManageDocumentService() {
         if (userFileAssignmentService!= null) {
             return manageDocumentService;
        } else {
            manageDocumentService = new ManageDocumentService();
             return manageDocumentService;
        }
    }
    
}
