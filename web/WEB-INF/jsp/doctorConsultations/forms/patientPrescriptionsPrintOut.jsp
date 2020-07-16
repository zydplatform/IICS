<%-- 
    Document   : patientPrescriptionsPrintOut
    Created on : Sep 19, 2018, 9:24:39 AM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
            }
            th,td{
                padding: 8px;
            }
            .h, .d {
                border-bottom: 1px solid #AAAAAA;
            }

            .h {
                background-color: #7d047d;
                color: white;
            }

            .table-d, .th-d, .td-d {
                border: 1px solid black;
            }

            .heading{
                padding: 5px 0 3px;
                font: 1.1em "Lucida Grande", Helvetica, "Arial Unicode MS", "Arial Unicode", Arial, sans-serif;
                color: #00e;
                border-bottom: 1px solid #00e;
                letter-spacing: 1px;
            }

            .byline {
                margin-top: -6px;
                text-align: right;
                padding-right: 80px;
                font-size: 20px;
            }

            .byline a.more:link, .byline a.more:visited {
                color: #f40;
                font-weight: bold;
            }

            .pagenavbox {
                margin-top: 25px;
                padding: 5px;
                background-color: #efefff;
                border: 1px solid #fff;
                font-weight: bold;
                line-height: 1.4em;
                border-radius: 2px;
                -webkit-border-radius: 2px;
                -moz-border-radius: 2px;
            }

            a.pagenav:link, .pagenav:visited {
                color: #547;
                text-decoration: none;
                letter-spacing: -1px;
            }

            .itemBatches{
                padding-left: 2%;
                padding-right: 2%;
                margin-bottom: -25px;
            }

            .span-size-15{
                font-size: 15px;
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

            .color-success{
                color: #28a745;
            }

            .color-info{
                color: #17a2b8;
            }

            .color-warning{
                color: #ffc107;
            }

            .color-danger{
                color: #dc3545;
            }

            .no-wrap{
                white-space: nowrap;
            }
        </style>
    </head>
    <body>
        <div class="row">
            <table>
                <tr>
                    <td colspan="2">
                        <!---->
                        <!--<h4>Patient Drugs Prescription.</h4>-->
                        <h4>Patient Medicine Prescription.</h4>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h3>${facility}</h3>
                    </td>
                </tr>
                <tr>
                    <td class="left">
                        <h3>${unit}</h3>
                    </td>
                    <td class="right">
                        Date: ${date}
                    </td>
                </tr>
            </table>
        </div>
          <div class="row">
            <table>
                <tr>
                    <td class="left"><b>Patient Name</b>:&nbsp; ${name}</td>
                </tr>
                <tr>
                    <td class="left"><b>Address</b>:&nbsp; ${villagename} &nbsp;${subcountyname} &nbsp; ${districtname}</td>
                </tr>
                <tr>
                    <td class="left"><b>Age</b>:&nbsp; ${estimatedage}</td>
                    <td class="center"><b>Sex</b>:&nbsp; ${gender}</td>
                </tr>
            </table>
        </div>
        <div class="row">
            <!---->
            <!--<div class="heading row">Drugs</div><hr/>-->
            <div class="heading row">Medicines</div><hr/>
            <table class="table">
                <thead>
                    <tr>
                        <th class="h" style="width: 8%;">No</th>
                        <!--<th class="h">Drug</th>-->
                        <th class="h">Medicine</th>
                        <th class="h" style="width: 8%;">Active Dose</th>
                        <th class="no-wrap">Dosage</th>
                        <th class="no-wrap" style="width: 10%;">Duration</th>
                        <!---->
                        <!--<th class="no-wrap">Comment</th>-->
                        <th class="no-wrap">Special Instructions</th>
                    </tr>
                </thead>
                <tbody>
                    <% int j = 1;%>
                    <c:forEach items="${prescriptionsFound}" var="a">
                        <tr>
                            <td><%=j++%></td>
                            <td>${a.fullname}</td>
                            <td>${a.activedose}</td>
                            <td class="no-wrap">${a.dosage}</td>
                            <td class="no-wrap">${a.days}</td>
                            <td class="no-wrap">${a.comment}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="row"><br/>
            <div class="heading row">Approved By:</div><hr/>
            <table>
                <tr>
                    <td class="left">Name</td>
                    <td class="center">Signature</td>
                    <td class="right">Date</td>
                </tr>
                <tr>
                    <td class="left">..........................................................</td>
                    <td class="center">...........................</td>
                    <td class="right">......./......./..........</td>
                </tr>
                <tr>
                    <td class="left">Position:.............................................</td>
                </tr>
            </table>
        </div>
    </body>
</html>
