<%-- 
    Document   : facilityProcurementPlans
    Created on : May 8, 2018, 2:06:50 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table class="table table-hover table-bordered" id="facilityprocurementsplanstable">
    <thead>
        <tr>
            <th>No</th>
            <th>Procurement Plan</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Set As Current</th>
            <th>Remove</th>
        </tr>
    </thead>
    <tbody >
        <% int j = 1;%>
        <% int i = 1;%>
        <c:forEach items="${facilityprocplans}" var="a">
            <tr <c:if test="${a.setascurrent==true}">style="color: red;"</c:if>>
                <td><%=j++%></td>
                <td>${a.orderperiodname}</td>
                <td>${a.startdate}</td>
                <td>${a.enddate}</td>
                <td align="center"><c:if test="${a.setascurrent==true}">Yes</c:if><c:if test="${a.setascurrent==false}">No</c:if></td>
                
                        <td align="center"><input id="remproc<%=i++%>" <c:if test="${a.setascurrent==true}">disabled="true"</c:if> onchange="if (this.checked) {
                            } else {
                                removefacilityprocurementplan(this.value, this.id);
                            }" value="${a.orderperiodid}" type="checkbox" checked="checked"></td>   
                    
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#facilityprocurementsplanstable').DataTable();
    function removefacilityprocurementplan(value, id) {
        $.confirm({
            title: 'Remove Procurement Plan!',
            content: ' Facility Units Wont Be Able To Add Items After Submission !!',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes, Remove',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {orderperiodid: value},
                            url: "facilityprocurementplanmanagement/removefacilityprocurementplan.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    var facilityfinancialyearid = $('#facilityfinancialyearidplansview').val();
                                    ajaxSubmitData('facilityprocurementplanmanagement/facilityprocuredorunprocuredprocurementplans.htm', 'financialyprocurementplansviewdiv', 'act=a&facilityfinancialyearid=' + facilityfinancialyearid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                                }
                            }
                        });
                    }
                },
                close: function () {
                    console.log('un checked');
                    $('#' + id).prop('checked', true);
                }
            }
        });
    }
</script>
