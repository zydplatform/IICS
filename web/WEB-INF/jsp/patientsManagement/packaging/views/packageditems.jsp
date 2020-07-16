<%-- 
    Document   : packageditems
    Created on : Aug 10, 2018, 10:33:53 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<!DOCTYPE html>
<fieldset>
    <table class="table table-hover table-bordered col-md-12 " id="packageditemstable" style="margin-top: 3em">
        <thead>
            <tr>
                <th>No</th>
                <th>Item Name</th>
                <th>Number of ready packets</th>
                <th>Packaged by</th>
                <th>Date Packaged</th>
            </tr>
        </thead>
        <tbody>
            <% int b = 1;%>
            <c:forEach items="${packageditems}" var="c">
                <c:if test="${c.numberOfCreatedpkts >0}">
                    <tr>
                        <td><%=b++%></td>
                        <td>${c.fullname}</td>
                        <td class="center"><a href="#"><span class="badge badge-info" style="font-size:15px" onclick="viewreadypackets(${c.packageid}, '${c.fullname}')">${c.numberOfCreatedpkts}</span></a></td>
                        <td>${c.firstname}&nbsp;${c.lastname}&nbsp;${c.othernames}</td>
                        <td>${c.datepackaged}</td>
                    </tr>
                </c:if>
                <c:if test="${c.numberOfCreatedpkts==0}">

                </c:if>
            </c:forEach>
        </tbody>
    </table>
</fieldset>
<script>
    $('#packageditemstable').DataTable();
    function viewreadypackets(packageid, fullname) {
        $.ajax({
            type: 'GET',
            data: {packageid: packageid},
            url: "packaging/viewreadypackets.htm",
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">Ready Packets for:' + '<font color="green">' + fullname + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '50%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true
                });
            }
        });
    }
</script>