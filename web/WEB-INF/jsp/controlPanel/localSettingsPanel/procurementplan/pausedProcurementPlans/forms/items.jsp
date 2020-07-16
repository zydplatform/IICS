<%-- 
    Document   : items
    Created on : Apr 12, 2018, 3:49:26 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">
    <div class="col-md-6">
        <input id="pausedordertype" value="${orderperiodtype}" type="hidden">
    </div>
    <div class="col-md-6">
        <input type="text" id="searchtablepaused" class="form-control" onkeyup="searchtablepaused()" placeholder="Search for items..">
    </div>
</div><br>
<table class="table table-hover table-bordered" id="pauesdfacilityunitprocurementtb">

    <thead>
        <tr>
            <th>No</th>
            <th>Generic Name</th>
            <th>Monthly Needed</th>
                <c:if test="${orderperiodtype=='Quarterly'}">
                <th>Quarterly Needed</th>
                </c:if>
                <c:if test="${orderperiodtype !='Quarterly'}">
                <th>Annually Needed</th>
                </c:if>
            <th>Remove</th>
        </tr>
    </thead>
    <tbody id="pausedfacilityunitfinanacialsitems">
        <% int j = 1;%>
        <% int i = 1;%>
        <% int m = 1;%>
        <% int a = 1;%>
        <c:forEach items="${itemsFound}" var="a">
            <tr id="upe<%=i++%>-${a.itemid}">
                <td><%=j++%></td>
                <td>${a.genericname}</td>
                <td id="monthp-<%=m++%>" onkeyup="updatepausedprocurementitemsvalues(this.id);" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;">${a.monthqty}</td>
                <c:if test="${orderperiodtype=='Quarterly'}">
                    <td id="annualp-<%=a++%>" onkeyup="updatepausedprocurementitemsvalues(this.id);" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;">${a.quarterlyqty}</td>
                </c:if>
                <c:if test="${orderperiodtype !='Quarterly'}">
                    <td id="annualp-<%=a++%>" onkeyup="updatepausedprocurementitemsvalues(this.id);" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;">${a.annualqty}</td>
                </c:if>

                <td align="center">
                    <button onclick="removepausedprocurementitems(this.id);" id="${a.itemid}"  title="Remove Items From The Procurement Plan." class="btn btn-primary btn-sm add-to-shelf">
                        <i class="fa fa-remove"></i>
                    </button> 
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    function searchtablepaused() {
        var input, value;
        input = document.getElementById("searchtablepaused");
        value = input.value.toLowerCase().trim();
        $("#pauesdfacilityunitprocurementtb tr").each(function (index) {
            if (!index)
                return;
            $(this).find("td").each(function () {
                var id = $(this).text().toLowerCase().trim();
                var not_found = (id.indexOf(value) === -1);
                $(this).closest('tr').toggle(!not_found);
                return not_found;
            });
        });
    }
</script>