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
                    <td class="center" colspan="2">
                        <h3>Stock Taking Discrepancy Report for ${report.activityname}</h3>
                    </td>
                </tr>
                <tr>
                    <td class="left">
                        Start Date: ${report.start}
                    </td>
                    <td class="right">
                        End Date: ${report.end}
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td class="left">
                        Items Found: <strong>${report.itemCount}</strong>
                    </td>
                </tr>
            </table>
        </div>
        <div class="row">
            <% int m = 1;%>
            <c:forEach items="${report.reportItems}" var="item">
                <div class="pane" id="item${item.itemid}">
                    <div class="heading row" style="border-bottom: red;"><%=m++%>: ${item.itemname}</div><hr/>
                    <div class="itemBatches">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th class="h">#</th>
                                    <th class="h no-wrap">Batch</th>
                                    <th class="h no-wrap">Expiry Date</th>
                                    <th class="right h">Quantity Expected</th>
                                    <th class="right h">Quantity Counted</th>
                                    <th class="right h">Discrepancy</th>
                                    <th class="center h">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int s = 1;%>
                                <c:forEach items="${item.batches}" var="batch">
                                    <% if (s % 2 == 0) {%>
                                    <tr style="background-color: #f2f2f2;">
                                        <td class="d"><%=s++%></td>
                                        <td class="d">${batch.batch}</td>
                                        <td class="right d">${batch.expiry}</td>
                                        <td class="right d">${batch.expected}</td>
                                        <td class="right d">${batch.counted}</td>
                                        <td class="right d <c:if test='${(batch.counted - batch.expected) == 0}'>color-success</c:if><c:if test='${(batch.counted - batch.expected) < 0}'>color-warning</c:if><c:if test='${(batch.counted - batch.expected) > 0}'>color-info</c:if>">${batch.counted - batch.expected}</td>
                                        <td class="center d <c:if test='${batch.action == "A"}'>color-info</c:if><c:if test='${batch.action == "R"}'>color-warning</c:if><c:if test='${batch.action == "N"}'>color-danger</c:if>">${batch.action}</td>
                                    </tr>
                                    <%} else {%>
                                    <tr>
                                        <td class="d"><%=s++%></td>
                                        <td class="d">${batch.batch}</td>
                                        <td class="right d">${batch.expiry}</td>
                                        <td class="right d">${batch.expected}</td>
                                        <td class="right d">${batch.counted}</td>
                                        <td class="right d <c:if test='${(batch.counted - batch.expected) == 0}'>color-success</c:if><c:if test='${(batch.counted - batch.expected) < 0}'>color-warning</c:if><c:if test='${(batch.counted - batch.expected) > 0}'>color-info</c:if>">${batch.counted - batch.expected}</td>
                                        <td class="center d <c:if test='${batch.action == "A"}'>color-info</c:if><c:if test='${batch.action == "R"}'>color-warning</c:if><c:if test='${batch.action == "N"}'>color-danger</c:if>">${batch.action}</td>
                                    </tr>
                                    <%}%>
                                </c:forEach>
                                <tr>
                                    <td class="d" colspan="3">
                                        <strong>Totals</strong>
                                    </td>
                                    <td class="right d">
                                        <strong>${item.expected}</strong>
                                    </td>
                                    <td class="right d">
                                        <strong>${item.counted}</strong>
                                    </td>
                                    <td class="right d <c:if test='${(item.counted - item.expected) == 0}'>color-success</c:if><c:if test='${(item.counted - item.expected) < 0}'>color-warning</c:if><c:if test='${(item.counted - item.expected) > 0}'>color-info</c:if>">
                                        <strong>${item.counted - item.expected}</strong>
                                    </td>
                                    <td class="d"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="row">
            <div class="heading row">Definition of Symbols</div><hr/>
            <table class="table-d">
                <tr>
                    <td class="center td-d color-info">
                        <strong>A</strong>
                    </td>
                    <td class="center td-d color-warning">
                        <strong>R</strong>
                    </td>
                    <td class="center td-d color-danger">
                        <strong>N</strong>
                    </td>
                </tr>
                <tr>
                    <td class="center td-d color-info">
                        Positive discrepancy added to unit stock.
                    </td>
                    <td class="center td-d color-warning">
                        Negative discrepancy recorded.
                    </td>
                    <td class="center td-d color-danger">
                        No action taken.
                    </td>
                </tr>
            </table>
            <div class="heading row">Prepared By:</div><hr/>
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