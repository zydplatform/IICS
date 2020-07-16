<%-- 
    Document   : modifiedServicedItems
    Created on : Jun 13, 2019, 8:37:19 AM
    Author     : IICS TECHS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-12">
        <c:if test="${prescriptionitems.size() > 0}">
            <div class="tile">
                <div class="tile-title">
                    <span class="span-size-15">Replacement Item: </span><span class="span-size-15 new-name" style="color: #0000ff;"></span>
                </div>
            <div class="tile-body">
                <table class="table table-bordered" id="prescription-items-table">
                    <thead>
                        <th style="width:4%;">No</th>
                        <th>Original Item Name</th>
                        <th style="width:6%;">Dosage</th>                       
                        <th style="width:12%;">Frequency</th>
                        <th>Duration</th>
                        <th>Special Instructions</th>
                        </thead>
                    <tbody>
                        <% int x = 1;%>                        
                            <tr>
                                <td><%=x++%></td>
                                <td>${prescriptionitem.itemname}</td>
                                <td>${prescriptionitem.dose}</td>
                                <td>${prescriptionitem.dosage}</td>
                                <td>${prescriptionitem.days} ${prescriptionitem.daysname}</td>
                                <td>${prescriptionitem.notes}</td>
                            </tr>
                    </tbody>
                    <tfoot></tfoot>
                </table>
            </div>
            <div class="tile-footer"></div>
        </div>
        </c:if>
        <hr />                      
    </div>
</div>