<%-- 
    Document   : itemsFormEdit
    Created on : May 7, 2018, 2:01:49 AM
    Author     : IICS
--%>
<style>
    #overlayedt {
        background: rgba(0,0,0,0.5);
        color: #FFFFFF;
        position: fixed;
        height: 100%;
        width: 100%;
        z-index: 5000;
        top: 0;
        left: 0;
        float: left;
        text-align: center;
        padding-top: 25%;
    }
</style>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">
    <div class="col-md-4">

    </div>
    <div class="col-md-8">
        <div class="form-group row">
            <label class="control-label col-md-4">Approved Items In Cart:</label>
            <div class="col-md-6">
                <button type="button" class="btn btn-primary" onclick="approvedfacilityunitprocurementitem();">
                    <i class="fa fa-dedent">
                        <span class="badge badge-light">${approvecItemsCount}</span>
                        Item(s)
                    </i>
                </button>
            </div>
        </div>
    </div>
</div><br>
<table class="table table-hover table-bordered" id="searchtableapproveItemstable">
    <thead>
        <tr>
            <th>No</th>
            <th>Generic Name</th>
            <th>Monthly Need</th>
                <c:if test="${type =='Quarterly'}">
                <th>Quarterly Need</th>
                </c:if>
                <c:if test="${type =='Annually'}">
                <th>Annually Need</th>
                </c:if>
                <c:if test="${type =='Monthly'}">
                <th>Annually Need</th>
                </c:if>
            <th>Edit</th>
            <th>Approved</th>
        </tr>
    </thead>
    <tbody id="approveprocurementplantable">
        <% int j = 1;%>
        <% int m = 1;%>
        <% int a = 1;%>
        <% int readd = 1;%>
        <c:forEach items="${procurementPlansItemsFound}" var="a">
            <tr id="${a.itemid}">
                <td><%=j++%></td>
                <td>${a.genericname}</td>
                <td >${a.averagemonthlyconsumption}</td>
                <c:if test="${type =='Quarterly'}">
                    <td>${a.averagequarterconsumption}</td>
                </c:if>
                <c:if test="${type =='Monthly'}">
                    <td >${a.averageannualcomsumption}</td>
                </c:if>
                <c:if test="${type =='Annually'}">
                    <td >${a.averageannualcomsumption}</td>
                </c:if>
                <td align="center">
                    <c:if test="${type =='Annually'}">
                        <button onclick="edititemandapprove('Annually',${a.facilityunitprocurementplanid}, '${a.genericname}',${a.averageannualcomsumption},${a.averagemonthlyconsumption});"  title="Edit The Procurement Plan Item." class="btn btn-primary btn-sm add-to-shelf">
                            <i class="fa fa-edit"></i>
                        </button>
                    </c:if>
                    <c:if test="${type =='Quarterly'}">
                        <button onclick="edititemandapprove('Quarterly',${a.facilityunitprocurementplanid}, '${a.genericname}',${a.averagequarterconsumption},${a.averagemonthlyconsumption});"  title="Edit The Procurement Plan Item." class="btn btn-primary btn-sm add-to-shelf">
                            <i class="fa fa-edit"></i>
                        </button> 
                    </c:if>
                </td>
                <td align="">
                    <div class="toggle-flip">
                        <label>
                            <input title="Approve Item Into The Procurement Plan." value="${a.itemid}" id="pread<%=readd++%>" type="checkbox" onchange="if (this.checked) {
                                        readditem('activate', this.value, this.id);
                                    } else {
                                        readditem('diactivate', this.value, this.id);
                                    }"><span class="flip-indecator" style="height: 10px !important; margin-top: 0px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                        </label>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table><br>
<div id="overlayedt" style="display: none;">
    <img src="static/img2/loader.gif" alt="Loading" /><br/>
    Please Wait...
</div>
<div id="itemsrevoeddiv" style="display: none;" >
    <div class="row text-left">
        <div class="col-xs-12">
            <h4>Removed: <strong><span class="preview-total" id="itemsremovedcount"></span></strong>&nbsp;Items</h4>
        </div>
    </div>
</div>
<script>
    $('#searchtableapproveItemstable').DataTable();
</script>