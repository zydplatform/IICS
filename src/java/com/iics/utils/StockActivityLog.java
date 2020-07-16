/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.utils;

import com.iics.service.GenericClassService;
import com.iics.store.Stock;
import com.iics.store.Stocklog;
import java.math.BigInteger;
import java.util.Date;

/**
 *
 * @author IICS TECHS
 */
public class StockActivityLog extends Thread{
    Integer stockid;
    Integer staffid;
    String logtype;
    Integer quantity;
    String referencetype;
    BigInteger reference;
    String referencenumber;
    GenericClassService genericClassService;

    public StockActivityLog(GenericClassService genericClassService, Integer stockid, Integer staffid, String logtype, Integer quantity, String referencetype, BigInteger reference, String referencenumber) {
        this.stockid = stockid;
        this.staffid = staffid;
        this.logtype = logtype;
        this.quantity = quantity;
        this.referencetype = referencetype;
        this.reference = reference;
        this.referencenumber = referencenumber;
        this.genericClassService = genericClassService;
    }

    @Override
    public void run() {
        Stocklog log = new Stocklog();
        log.setStockid(new Stock(stockid.longValue()));
        log.setStaffid(BigInteger.valueOf(staffid.longValue()));
        log.setLogtype(logtype);
        log.setQuantity(quantity);
        log.setDatelogged(new Date());
        log.setReferencetype(referencetype);
        log.setReference(reference);
        log.setReferencenumber(referencenumber);
        genericClassService.saveOrUpdateRecordLoadObject(log);
    }
}
