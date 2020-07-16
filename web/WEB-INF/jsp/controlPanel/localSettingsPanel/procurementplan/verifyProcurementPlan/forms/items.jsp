<%-- 
    Document   : items
    Created on : Jun 7, 2018, 5:00:56 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table class="table table-hover table-bordered" id="tableapprovedItemstable">
    <thead>
        <tr>
            <th>No</th>
            <th>Generic Name</th>
            <th style="display: none;">Pack Size</th>
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
            <th>Approved</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <% int m = 1;%>
        <% int a = 1;%>
        <% int readd = 1;%>
        <c:forEach items="${procurementPlansItemsFound}" var="a">
            <tr id="${a.itemid}">
                <td><%=j++%></td>
                <td>${a.genericname}</td>
                <td style="display: none;">${a.packsize}</td>
                <td >${a.averagemonthlyconsumption}</td>
                <c:if test="${type =='Quarterly'}">
                    <td >${a.averagequarterconsumption}</td>
                </c:if>
                <c:if test="${type =='Monthly'}">
                    <td >${a.averageannualcomsumption}</td>
                </c:if>
                <c:if test="${type =='Annually'}">
                    <td >${a.averageannualcomsumption}</td>
                </c:if>
                <td align="">
                    <div class="toggle-flip">
                        <label>
                            <input title="Un Approve Item From The Procurement Plan." checked="checked" value="${a.facilityunitprocurementplanid}" id="apppread<%=readd++%>" type="checkbox" onchange="if (this.checked) {
                                        unreadditem('activate', this.value, '${type}',${facilityunitfinancialyearid});
                                    } else {
                                        unreadditem('diactivate', this.value, '${type}',${facilityunitfinancialyearid});
                                    }"><span class="flip-indecator" style="height: 10px !important; margin-top: 0px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                        </label>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#tableapprovedItemstable').DataTable();
    function unreadditem(type2, facilityunitprocurementplanid, type,facilityunitfinancialyearid) {
        if (type2 === 'diactivate') {
            $.confirm({
                title: 'Remove Item!',
                content: 'Are You Sure You Want To Remove This Item From Approved List?',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        icon: 'fa fa-warning',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {facilityunitprocurementplanid:facilityunitprocurementplanid,type:'deactivate'},
                                url: "procurementplanmanagement/rejectormodifiedfacilityunitprocurementplanitem.htm",
                                success: function (data, textStatus, jqXHR) {
                                   ajaxSubmitData('procurementplanmanagement/verifyfacilityunitprocurementplanitemsview.htm', 'procured_itemsfinancialyrtable', 'act=a&facilityunitfinancialyearid=' + facilityunitfinancialyearid + '&type=' + type + '&ofst=1&maxR=100&sStr=', 'GET');
                                    ajaxSubmitData('procurementplanmanagement/approvedfacilityunitprocurementitems.htm', 'approvedfacilityunitprocurementitemDiv', 'act=a&facilityunitfinancialyearid=' + facilityunitfinancialyearid + '&type='+type+'&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    },
                    close: function () {
                    }
                }
            });
        }
    }
</script>