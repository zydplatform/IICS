<%-- 
    Document   : composeProcurementplan
    Created on : Jun 25, 2018, 9:41:30 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered" id="Facilityfinancialprocuremnt">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Procurement Plan</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Period</th>
                                    <th>Item(s)</th>
                                    <th>Update | Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int j = 1;%>
                                <% int i = 1;%>
                                <c:forEach items="${procurementplansFound}" var="a">
                                    <tr>
                                        <td><%=j++%></td>
                                        <td>${a.procurementplan}</td>
                                        <td>${a.startdate}</td>
                                        <td>${a.enddate}</td>
                                        <td>${a.orderperiodname}</td>
                                        <td align="center">
                                            <button <c:if test="${a.financialyprocurementplansItemsRowcount >0}"> onclick="financialyprocurementplanIemssview('${a.orderperiodtype}',${a.orderperiodid});" </c:if>  title=" The Procurement Plans Items" class="btn btn-secondary btn-sm add-to-shelf">
                                                ${a.financialyprocurementplansItemsRowcount}&nbsp;Item(s)
                                            </button>
                                        </td>
                                        <td align="center">
                                            <button   onclick="addprocurementitems(${a.orderperiodid});" title="Add Items Procurement plan for financial year. ${a.startyear}-${a.endyear}" class="btn btn-primary btn-sm add-to-shelf subscribe">
                                                <i class="fa fa-fw fa-lg fa-plus"></i>
                                            </button>
                                            |
                                            <button onclick="deletetheprocurementplnItm(${a.orderperiodid});" title="Delete Procurement plan for financial year. ${a.startyear}-${a.endyear}" class="btn btn-primary btn-sm add-to-shelf subscribe">
                                                <i class="fa fa-fw fa-lg fa-remove"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div> 
<div class="row">
    <div class="col-md-12">
        <div id="additemsTOprocurementpln" class="supplierCatalogDialog additemsTOprocurementplns">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleoralreadyheading">Add Items To Procurement Plan</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="additemstoprocplnsdiv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Getting Please Wait...........</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="viewTheProcurementPlnItems" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content" style="width: 100%;">
                            <div class="modal-header">
                                <h5 class="modal-title" id="title"> Items</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div id="TopDownItemsViewDiv">
                                                    <p>Getting Items Please Wait................</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12" align="right"  >
                                                <button class="btn btn-primary" data-dismiss="modal">
                                                    <i class="fa fa-check-circle"></i>
                                                    close
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="viewedTheProcurementPlnItems" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="title"> Items</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div id="TopDownItemsViewedDiv">
                                    <p>Getting Items Please Wait................</p>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" align="right"  >
                                <button class="btn btn-primary" data-dismiss="modal">
                                    <i class="fa fa-check-circle"></i>
                                    close
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#Facilityfinancialprocuremnt').DataTable();
    function addprocurementitems(orderperiodid) {
        window.location = '#additemsTOprocurementpln';
        ajaxSubmitData('facilityprocurementplanmanagement/additemsprocurementform.htm', 'additemstoprocplnsdiv', 'act=a&orderperiodid=' + orderperiodid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        initDialog('additemsTOprocurementplns');
    }

    function financialyprocurementplanIemssview(orderperiodtype, orderperiodid) {
        $('#viewedTheProcurementPlnItems').modal('show');
        ajaxSubmitData('facilityprocurementplanmanagement/topdowncomposedprocurementplanitem.htm', 'TopDownItemsViewedDiv', 'act=b&orderperiodtype=' + orderperiodtype + '&orderperiodid=' + orderperiodid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

    }
    function deletetheprocurementplnItm(orderperiodid) {
        $.confirm({
            title: 'Delete Procurement Plan!',
            content: 'Are You Sure You Want To Delete This Procurement Plan??',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes, Delete',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            url: "facilityprocurementplanmanagement/removeallprocurementaddeditems.htm",
                            data: {orderperiodid: orderperiodid},
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('facilityprocurementplanmanagement/topdowncomposeprocurementplan.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
</script>