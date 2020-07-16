<%--
    Document   : printStockReport
    Created on : 19-Jul-2018, 11:25:44
    Author     : IICS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
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
        </style>
    </head>
    <body>
        <div class="row">
            <table>
                <tr>
                    <td class="center">
                        <h3>User Stock Count Sheet</h3>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td class="left">
                        Name: <strong>${report.staff}</strong><br/>
                        Position: <strong>${report.designation}</strong><br/>
                        Assigned Locations: <strong>${report.assigned}</strong><br/>
                        Submitted Locations: <strong>${report.submitted}</strong><br/>
                    </td>
                    <td class="right">
                        <strong>${report.activity}</strong><br/>
                        From: <strong>${report.start}</strong><br/>
                        To: <strong>${report.end}</strong>
                    </td>
                </tr>
            </table>
        </div>
        <div class="row">
            <% int k = 1;%>
            <c:forEach items="${report.reportItems}" var="item">
                <div class="pane" id="item${item.itemid}">
                    <div class="heading row" style="border-bottom: red;"><%=k++%>: ${item.itemname}</div><hr/>
                    <div class="itemBatches">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th class="h">#</th>
                                    <th class="h">Batch</th>
                                    <th class="right h">Expiry Date</th>
                                    <th class="right h">Quantity Counted</th>
                                    <th class="right h">Date Counted</th>
                                    <th class="right h">Cell</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int r = 1;%>
                                <c:forEach items="${item.batches}" var="batch">
                                    <% if (r % 2 == 0) {%>
                                    <tr style="background-color: #f2f2f2;">
                                        <td class="d"><%=r++%></td>
                                        <td class="d">${batch.batch}</td>
                                        <td class="right d">${batch.expiry}</td>
                                        <td class="right d">${batch.counted}</td>
                                        <td class="right d">${batch.dateadded}</td>
                                        <td class="right d">${batch.cell}</td>
                                    </tr>
                                    <%} else {%>
                                    <tr>
                                        <td class="d"><%=r++%></td>
                                        <td class="d">${batch.batch}</td>
                                        <td class="right d">${batch.expiry}</td>
                                        <td class="right d">${batch.counted}</td>
                                        <td class="right d">${batch.dateadded}</td>
                                        <td class="right d">${batch.cell}</td>
                                    </tr>
                                    <%}%>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <table>
                            <tr>
                                <td class="right">
                                    <p class="pagenavbox" id="pagenavigation">
                                        Total Counted:&nbsp;
                                        <a href="#tablesintables" class="pagenav">
                                            ${item.counted}
                                        </a>
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="row">
            <table>
                <tr>
                    <td class="right">Signature</td>
                </tr>
                <tr>
                    <td class="right">...........................</td>
                </tr>
            </table>
            <div class="heading row">Approved By:</div><hr/>
            <table>
                <tr>
                    <td class="left">Name</td>
                    <td class="center">Signature</td>
                    <td class="right">Date</td>
                </tr>
                <tr>
                    <td class="left">......................................................</td>
                    <td class="center">...........................</td>
                    <td class="right">...........................</td>
                </tr>
            </table>
        </div>
    </body>
</html>