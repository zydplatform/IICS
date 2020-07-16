<%-- 
    Document   : donationPrintOut
    Created on : Oct 18, 2018, 9:52:14 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>

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

            .bold{
                font-weight: bold;
                color: black;
                text-decoration: underline;
            }

            .qty{
                font-weight: bold;
                color: #00e;
            }

            .c{
                text-align: left;
                padding-left: 280px;
            }
        </style>
    </head>

    <body>
        <div class="row"><br/>
            <div class="heading row">History For Ref No.: <span class="bold">${donorrefno}</span> On <span class="bold">${datereceived}</span> Received By <span class="bold">${receivedby}</span></div><hr/>
            <c:if test="${donortype == 'Organisation'}">
            <table>
                <thead>
                    <tr>
                        <th>Donor Details</th>
                        <th></th>
                        <th>Contact Details</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="left">Donor Name: <span class="qty">${donorname}</span></td>
                        <td class="left"></td>
                        <td class="left">Contact Person Name: <span class="qty">${personname}</span></td>
                    </tr>
                    <tr>
                        <td class="left">Donor Tel: <span class="qty">${telno}</span></td>
                        <td class="left"></td>
                        <td class="left">Primary Contact: <span class="qty">${primarycontact}</span></td>
                    </tr>
                    <tr>
                        <td class="left">Donor Email: <span class="qty">${emial}</span></td>
                        <td class="left"></td>
                        <td class="left">Secondary Contact: <span class="qty">${secondarycontact}</span></td>
                    </tr>
                    <tr>
                        <td class="left">Donor Type: <span class="qty">${donortype}</span></td>
                        <td class="left"></td>
                        <td class="left">Email: <span class="qty">${email}</span></td>
                    </tr>

                </tbody>
            </table> 
            </c:if>
            <c:if test="${donortype == 'Individual'}">
            <table>
                <thead>
                    <tr>
                        <th>Donor Details</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="left">Donor Name: <span class="qty">${donorname}</span></td>
                        <td class="left"></td>
                        <td class="left">Donor Tel: <span class="qty">${telno}</span></td>
                    </tr>
                    <tr>
                        <td class="left">Donor Email: <span class="qty">${emial}</span></td>
                        <td class="left"></td>
                        <td class="left">Donor Type: <span class="qty">${donortype}</span></td>
                    </tr>
                </tbody>
            </table> 
            </c:if>
                       
        </div>
        <c:if test="${medicalItemDonorHistoryList != null}">
            <div class="row">
                <div class="heading row">Medicines & Supplies</div><hr/>
                <table class="table">
                    <thead>
                        <tr>
                            <th class="h no-wrap text-size-13">No</th>
                            <th class="h no-wrap text-size-13">Item Name</th>
                            <th class="h no-wrap text-size-13">Batch No.</th>
                            <th class="h no-wrap text-size-13">Expiry Date</th>
                            <th class="h no-wrap text-size-13 right">Quantity Donated</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var = "s" value = "${1}"/>
                        <c:forEach items="${medicalItemDonorHistoryList}" var="d">
                            <c:if test="${s % 2 == 0}">
                                <tr style="background-color: #f2f2f2;">
                                    <td class="d no-wrap text-size-13"><c:out value = "${s}"/></td>
                                    <td class="d no-wrap text-size-13">${d.packagename}</td>
                                    <td class="d no-wrap text-size-13">${d.batchno}</td>
                                    <td class="d no-wrap text-size-13">${d.expirydate}</td>
                                    <td class="d no-wrap text-size-13 right">
                                        <span class="qty">${d.qtydonated}</span>
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${s % 2 != 0}">
                                <tr>
                                    <td class="d no-wrap text-size-13"><c:out value = "${s}"/></td>
                                    <td class="d no-wrap text-size-13">${d.packagename}</td>
                                    <td class="d no-wrap text-size-13">${d.batchno}</td>
                                    <td class="d no-wrap text-size-13">${d.expirydate}</td>
                                    <td class="d no-wrap text-size-13 right">
                                        <span class="qty">${d.qtydonated}</span>
                                    </td>
                                </tr>
                            </c:if>
                            <c:set var = "s" value = "${s + 1}"/>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        <c:if test="${otherItemDonorHistoryList != null}">
            <div class="row">
                <div class="heading row">Other Items</div><hr/>
                <table class="table">
                    <thead>
                        <tr>
                            <th class="h no-wrap text-size-13">No</th>
                            <th class="h no-wrap text-size-13">Item Name</th>
                            <th class="h no-wrap text-size-13">Item Specification</th>
                            <th class="h no-wrap text-size-13 right">Quantity Donated</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var = "w" value = "${1}"/>
                        <c:forEach items="${otherItemDonorHistoryList}" var="ot">
                            <c:if test="${w % 2 == 0}">
                                <tr style="background-color: #f2f2f2;">
                                    <td class="d no-wrap text-size-13"><c:out value = "${w}"/></td>
                                    <td class="d no-wrap text-size-13">${ot.assetsname}</td>
                                    <td class="d no-wrap text-size-13">${ot.itemspecification}</td>
                                    <td class="d no-wrap text-size-13 right">
                                        <span class="qty">${ot.assetqty}</span>
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${w % 2 != 0}">
                                <tr>
                                    <td class="d no-wrap text-size-13"><c:out value = "${w}"/></td>
                                    <td class="d no-wrap text-size-13">${ot.assetsname}</td>
                                    <td class="d no-wrap text-size-13">${ot.itemspecification}</td>
                                    <td class="d no-wrap text-size-13 right">
                                        <span class="qty">${ot.assetqty}</span>
                                    </td>
                                </tr>
                            </c:if>
                            <c:set var = "w" value = "${w + 1}"/>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
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
