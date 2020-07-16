<%-- 
    Document   : prescriptionPrintOut
    Created on : Apr 23, 2019, 10:52:27 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp"%>
<html>
    <head>
        <title>Print Prescription</title>
        <style>
            body {
                font-size: 100%; 
                font-weight: normal;
            }
            div.container {                
               min-width: 100%;
            }            
            table {
                border-collapse: collapse;
                width: 100%;
                border-top: 0px solid #000000;                     
            }
            th,td{
                padding: 4px;
                border: 0px solid #ffffff;                
                font-size: small;
                font-weight: normal;
            }
            .center{
                text-align: center;
            }
            .left{
                text-align: left;
            }
            .right{
                text-align: right;
            }

            .color-danger{
                color: #dc3545;
            }
            .clear-fix::after {
                content: '';
                clear: both;
                display: table;
            }
            .strike-out {
                text-decoration: line-through;
            }
        </style>
    </head>
    <body>
        <div class="row">
            <div class="col-md-12 text-center">
                <img src="static/images/COA.png" alt="Court Of Arms"/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 center" style="font-size: small; font-weight: normal;">
                MINISTRY OF HEALTH
            </div>
            <div class="col-md-12 center" style="font-size: small; font-weight: normal;">
                ${facility}
            </div>
            <div class="col-md-12 center" style="font-size: small; font-weight: normal;">
                ${facilityunit}
            </div>
        </div>  
        <div style="height: 12px;"></div>
        <table class="patient-details-table"  style = "padding-top: 1%;">
            <thead></thead>
            <tbody>
                <tr>
                    <td style="width: 4.5%;">Name:</td>
                    <td style="width: 30%;">${patientname}</td>
                    <td style="width: 11%;">Patient Number:</td>
                    <td style="width: 30%;">${patientno}</td>
                </tr>
            </tbody>
            <tfoot></tfoot>            
        </table>     
        <div style="height: 12px;"></div>
        <div>
            <table class="table" id="ready-to-issue-items-table">
                <thead>
                    <tr>
                        <th style="width: 5%;">No.</th>
                        <th style="width: 25%;">Item</th>
                        <th style="width: 18%;">Regimen</th>
                        <th style="width: 35%;">Special Instructions</th>
                        <th style="width: 7%; text-align: center;">Issued</th>
                        <th style="width: 10%; text-align: center;">Not Issued</th>
                    </tr>
                </thead>
                <tbody>
                    <% int x = 1;%>
                    <c:forEach items="${prescriptionitems}" var="item">
                        <tr <c:if test="${item.isavailable == Boolean.TRUE || item.isoutofstock == Boolean.FALSE}">class="strike-out"</c:if>>
                            <td><%=x++%></td>
                            <td>${item.medicine} ${item.dosage}</td>
                            <td>${item.frequency} For ${item.duration}</td>
                            <td>${item.specialinstructions}</td>
                            <td style="text-align: center;">${item.issued}</td>
                            <td style="text-align: center;">${item.notissued}</td>
                        </tr>                               
                    </c:forEach>                
                </tbody>
            </table>
        </div>
        <div style="height: 12px;"></div>
        <table>
            <thead></thead>
            <tbody>
                <tr>
                    <td style="width: 15px;">Prescribed By:</td>
                    <td>${prescriber}</td>
                </tr>
            </tbody>
            <tfoot></tfoot>            
        </table> 
        <div style="height: 10px;"></div>
        <table>
            <thead></thead>
            <tbody>
                <tr>
                    <td style="width: 2px;">Sign:</td>
                    <td>.......................................</td>
                </tr>
            </tbody>
            <tfoot></tfoot>            
        </table>  
        <div style="height: 10px;"></div>
        <table>
            <thead></thead>
            <tbody>
                <tr>
                    <td style="width: 15px;">E-Mail:</td>
                    <td>${email}</td>
                </tr>
                <tr>
                    <td style="width: 15px;">Phone Number:</td>
                    <td>${contactno}</td>
                </tr>
                <tr>
                    <td style="width: 15px;">Date:</td>
                    <td>
                        <jsp:useBean id="now" class="java.util.Date" />
                        <fmt:formatDate pattern="dd-MM-yyyy" value="${now}" var="currentDate" />
                        ${currentDate}
                    </td>
                </tr>
            </tbody>
            <tfoot></tfoot>            
        </table> 
    </body>
</html>