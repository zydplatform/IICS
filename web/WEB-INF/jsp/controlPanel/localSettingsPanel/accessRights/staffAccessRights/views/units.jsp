<%-- 
    Document   : units
    Created on : Jul 23, 2018, 3:08:30 PM
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
                    <div class="tile-body"><br><br>
                        <table class="table table-hover table-bordered" id="StaffBelongingUnits">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Unit Name</th>
                                </tr>
                            </thead>
                            <tbody >
                                <% int j = 1;%>
                                <% int i = 1;%>
                                <c:forEach items="${staffunitsList}" var="a">
                                    <tr>
                                        <td><%=j++%></td>
                                        <td>${a.facilityunitname}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div><br>
            </div>
        </div>
    </fieldset>
</div> 
<script type="text/javascript" src="static/res/js/plugins/select2.min.js"></script>
<script>
    $('#StaffBelongingUnits').DataTable();
  
</script>