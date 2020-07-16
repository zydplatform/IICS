/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.utils;

import com.iics.service.GenericClassService;
import com.iics.store.Bayrowcell;
import com.iics.store.Shelflog;
import com.iics.store.Stock;
import java.math.BigInteger;
import java.util.Date;

/**
 *
 * @author IICS
 */
public class ShelfActivityLog extends Thread {

    Integer cellid;
    Integer stockid;
    Integer staffid;
    String logtype;
    Integer quantity;
    GenericClassService genericClassService;

    public ShelfActivityLog(GenericClassService genericClassService, Integer cellid, Integer stockid, Integer staffid, String logtype, Integer quantity) {
        this.cellid = cellid;
        this.stockid = stockid;
        this.staffid = staffid;
        this.logtype = logtype;
        this.quantity = quantity;
        this.genericClassService = genericClassService;
    }

    @Override
    public void run() {
        Shelflog log = new Shelflog();
        log.setCellid(new Bayrowcell(cellid));
        log.setStockid(new Stock(stockid.longValue()));
        log.setStaffid(BigInteger.valueOf(staffid.longValue()));
        log.setLogtype(logtype);
        log.setQuantity(quantity);
        log.setDatelogged(new Date());
        genericClassService.saveOrUpdateRecordLoadObject(log);
    }
}
