<%--
    Document   : printStockReport
    Created on : 19-Jul-2018, 11:25:44
    Author     : IICS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
            }
            th,td{
                padding: 3px;
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

            .text-size-13{
                font-size: 13px;
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
                        <h4>Daily Patient Register.</h4>
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
            <div class="heading row">Visit Summary</div><hr/>
            <table class="table-d">
                <tr>
                    <td class="center td-d color-success">
                        <strong>Total Visits</strong>
                    </td>
                    <td class="center td-d color-info">
                        <strong>New Visits</strong>
                    </td>
                    <td class="center td-d color-warning">
                        <strong>Revisits</strong>
                    </td>
                </tr>
                <tr>
                    <td class="center td-d color-success">
                        ${revisits + newvisits}
                    </td>
                    <td class="center td-d color-info">
                        ${newvisits}
                    </td>
                    <td class="center td-d color-warning">
                        ${revisits}
                    </td>
                </tr>
            </table>
        </div>
        <div class="row">
            <div class="heading row">Patients</div><hr/>
            <table class="table">
                <thead>
                    <tr>
                        <th class="h no-wrap text-size-13">No</th>
                        <th class="h no-wrap text-size-13">Names</th>
                        <!--<th class="h no-wrap text-size-13">Visit No.</th>-->
                        <th class="h no-wrap text-size-13">Gender</th>
                        <th class="h no-wrap text-size-13">Age</th>
                        <th class="h no-wrap text-size-13">Parish</th>
                        <th class="h no-wrap text-size-13">Village</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var = "s" value = "${1}"/>
                    <c:forEach items="${visits}" var="visit">
                        <c:if test="${s % 2 == 0}">
                            <tr style="background-color: #f2f2f2;">
                                <td class="d no-wrap text-size-13"><c:out value = "${s}"/></td>
                                <td class="d no-wrap text-size-13">${visit.names}</td>
                                <!--<td class="d no-wrap text-size-13">${visit.visitno}</td>-->
                                <td class="d no-wrap text-size-13">${visit.gender}</td>
                                <td class="d no-wrap text-size-13">${visit.age}</td>
                                <td class="d no-wrap text-size-13">${visit.parish}</td>
                                <td class="d no-wrap text-size-13">${visit.village}</td>
                            </tr>
                        </c:if>
                        <c:if test="${s % 2 != 0}">
                            <tr>
                                <td class="d no-wrap text-size-13"><c:out value = "${s}"/></td>
                                <td class="d no-wrap text-size-13">${visit.names}</td>
                                <!--<td class="d no-wrap text-size-13">${visit.visitno}</td>-->
                                <td class="d no-wrap text-size-13">${visit.gender}</td>
                                <td class="d no-wrap text-size-13">${visit.age}</td>
                                <td class="d no-wrap text-size-13">${visit.parish}</td>
                                <td class="d no-wrap text-size-13">${visit.village}</td>
                            </tr>
                        </c:if>
                        <c:set var = "s" value = "${s + 1}"/>
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