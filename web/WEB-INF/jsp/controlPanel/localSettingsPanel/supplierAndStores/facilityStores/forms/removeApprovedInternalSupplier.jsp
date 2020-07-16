<%-- 
    Document   : removeApprovedInternalSupplier
    Created on : Apr 23, 2018, 5:49:48 PM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../../include.jsp" %>
<!DOCTYPE html>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <legend></legend>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <div class="form-group row">
                            <label class="control-label col-md-3">Select:</label>
                            <div class="col-md-8">
                                <select class="form-control col-md-8" id="approvedorunapproved"> 
                                    <option value="approved">Approved Nominated Internal Suppliers</option> 
                                    <option value="unapproved">Un Approved Nominated Internal Suppliers</option> 
                                </select>
                            </div>
                        </div><br>
                        <table class="table table-hover table-bordered" id="approveinternalsupplierstable">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Client Unit Name</th>
                                    <th>Client Short Name</th>
                                    <th>Supplier Unit Name</th>
                                    <th>Supplier Short Name</th>
                                    <th>Remove</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int j = 1;%>
                                <c:forEach items="${unapprovedinternalsupplier}" var="a">
                                    <tr id="">
                                        <td><%=j++%></td>
                                        <td>${a.facilityunitname_client}</td>
                                        <td>${a.shortname_client}</td>
                                        <td>${a.facilityunitname_supplier}</td>
                                        <td>${a.shortname_supplier}</td>
                                        <td align="center">
                                            <input id="" type="checkbox">
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table><br>

                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div>
