/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service.filemanager;

import com.iics.web.filemanager.ManageDocument;
import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import uk.co.mmscomputing.device.scanner.Scanner;
import uk.co.mmscomputing.device.scanner.ScannerDevice;
import uk.co.mmscomputing.device.scanner.ScannerIOException;
import uk.co.mmscomputing.device.scanner.ScannerIOMetadata;
import uk.co.mmscomputing.device.scanner.ScannerListener;


/**
 *
 * @author IICS
 */

public class DocumentScannerService implements ScannerListener{
 Scanner scanner;
 String baseDir;
 int pageNumber;
 String link;
 String filePath="";
 boolean fileStaus=false;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
 public DocumentScannerService(Scanner scanner,String link,String baseDir){
     try {
       this.scanner=Scanner.getDevice();
       this.baseDir=baseDir;
       this.link=link;
     if(this.scanner!=null){
        this.scanner.addListener(DocumentScannerService.this);
        System.out.println("Twain Scanner not null");
      }
      this.scanner.acquire();
      } catch (ScannerIOException ex) {
        Logger.getLogger(ManageDocument.class.getName()).log(Level.SEVERE, null, ex);
     }
 }

    public boolean isFileStaus() {
        return fileStaus;
    }

    public void setFileStaus(boolean fileStaus) {
        this.fileStaus = fileStaus;
    }
public void update(ScannerIOMetadata.Type type, ScannerIOMetadata metadata) {
        if (type.equals(ScannerIOMetadata.ACQUIRED)) {
            BufferedImage image = metadata.getImage();
            System.out.println("Have an image now!");
            try {
                filePath=baseDir+link;
               if (!new File(baseDir).exists()) {
                    new File(baseDir).mkdir();
                }
                boolean data = ImageIO.write(image, "png", new File(baseDir+link));
               if (data) {
                //Save Page 
                System.out.println("Have an image now!");
               }
            } catch (Exception e) {
                e.printStackTrace();
                setFileStaus(false);
            }
        } else if (type.equals(ScannerIOMetadata.NEGOTIATE)) {
            ScannerDevice device = metadata.getDevice();
            try {
                device.setShowUserInterface(true);
                device.setShowProgressBar(true);
                device.setResolution(100);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (type.equals(ScannerIOMetadata.STATECHANGE)) {
            System.err.println(metadata.getStateStr());
            if (metadata.isFinished()) {
                System.out.println("page No"+pageNumber); 
                setFileStaus(true);
            }
        } else if (type.equals(ScannerIOMetadata.EXCEPTION)) {
            metadata.getException().printStackTrace();
        }
}
}