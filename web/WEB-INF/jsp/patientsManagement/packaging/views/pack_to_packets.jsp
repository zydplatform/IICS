<%-- 
    Document   : pack_to_packets
    Created on : Sep 13, 2018, 8:22:14 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<!DOCTYPE html>
<div class="col-md-12">
    <fieldset>
        <table class="table table-hover scol-md-12 table-bordered" id="packtopackets">
            <thead>
                <tr>
                    <td>No</td>
                    <th>Item Name</th>
                    <th class="center">Packet Size</th>
                    <th class="center">Number of Packets</th>
                    <th class="center">Quantity Picked</th>
                    <th class="center">Pack</th>
                </tr>
            </thead>
            <tbody>
                <% int j = 1;%>
                <c:forEach items="${packageditems}" var="c">
                    <c:if test="${c.numberOfCreatedpkts >0}">
                        <tr>
                            <td><%=j++%></td>
                            <td><span >${c.fullname}</span></td>
                            <td class="center"><span class="badge badge-info" style="font-size:15px">${c.packageno}</span></td>
                            <td class="center"><span class="badge badge-info" style="font-size:15px">${c.numberOfCreatedpkts}</span></td>
                            <td class="center"><span class="badge badge-info" style="font-size:15px">${c.totalqtypicked}</span></td>
                            <td align="center">
                                <button class="btn btn-primary" onclick="additemstopackets(${c.packageid}, '${c.fullname}',${c.packageno},${c.numberOfCreatedpkts},${c.stockid})"><i class="fa fa-dedent"></i></button>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${c.numberOfCreatedpkts ==0}">

                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </fieldset>
</div>
<script>
    $('#packtopackets').DataTable();
    function additemstopackets(packageid, fullname, packageno, numberOfCreatedpkts,stockid) {
        $.ajax({
            type: 'GET',
            data: {packageid: packageid, packageno: packageno, stockid: stockid},
            url: "packaging/additemstopackets.htm",
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">Add:' + '<font color="green">' + fullname + '</font>' + ' to ' + '<font color="red">' + numberOfCreatedpkts + '</font>' + " " + 'packet(s)</strong>',
                    content: '' + data,
                    boxWidth: '55%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true
                });
            }
        });
    }
</script>

