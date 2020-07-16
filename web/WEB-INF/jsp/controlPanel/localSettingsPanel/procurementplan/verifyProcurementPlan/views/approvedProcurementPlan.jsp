<%-- 
    Document   : approvedProcurementPlan
    Created on : Apr 16, 2018, 12:43:59 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<fieldset>
    <c:if test="${size > 0}">
        <legend>Approved Procurement Plan</legend>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered" id="approvedprocurementtable">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Procurement</th>
                                    <th>Items</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody id="">
                                <% int j = 1;%>
                                <% int i = 1;%>
                                <c:forEach items="${financialyritems}" var="a">
                                    <tr id="${a.financialyearid}">
                                        <td><%=j++%></td>
                                        <td>${a.procurementplan}</td>
                                        <td><a href="#" id="vitm<%=j++%>-${a.financialyearid}" onclick="viewfinancialprocurementitems(this.id);">${a.financialyritemsRowcount} Items</a></td>
                                        <td>Approved</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    <c:if test="${size < 1}">
        <legend>Approved Procurement Plan</legend>
        <p style="color: red;">No Approved Procurement Plan</p>
    </c:if>
</fieldset>
<div class="modal fade" id="viewprocurementplansitemsapproved" style="padding-right: 21% !important;"tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle"> Financial Year Items</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12">
                        </div>
                        <!-- panel preview -->
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <div id="itemstable2">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <legend>Getting Item Please Wait...................</legend>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tile-footer">
                                    <div class="row">
                                        <div class="col-md-8 col-md-offset-3">
                                            <button class="btn btn-primary" type="button" data-dismiss="modal"><i class="fa fa-fw fa-lg fa-check-circle"></i>Ok</button>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary" href="#" data-dismiss="modal" ><i class="fa fa-fw fa-lg fa-times-circle"></i>Close</a>
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
<script>
    function  viewfinancialprocurementitems(id) {
        var fields = id.split('-');
        var procurementid = fields[1];
        ajaxSubmitData('procurementplanmanagement/approvedfacilityprocurementplanitemsapproved.htm', 'itemstable2', 'procurementid='+ procurementid +'&ofst=1&maxR=100&sStr=', 'GET');
        $('#viewprocurementplansitemsapproved').modal('show');
    }
</script>        