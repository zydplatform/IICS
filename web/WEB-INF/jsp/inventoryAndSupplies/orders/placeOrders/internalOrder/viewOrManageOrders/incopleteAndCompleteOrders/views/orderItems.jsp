<%-- 
    Document   : orderItems
    Created on : May 23, 2018, 4:59:18 PM
    Author     : IICS
--%>
<%@include file="../../../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    .cl{color: #465cba;}
</style>
<div>
    <fieldset>
        <legend>An Internal Order</legend>
        <div class="container" id="firstdiv1">
            <div class="row">
                <table style="margin:  0px  10px  10px  80px;" width="90%" cellspacing="0px" cellpadding="10px" border="0" align="center">
                    <tbody><tr class="odd">
                            <td align="left"><span class="style101">Order Number:</span></td>
                            <td align="left"><b class="cl">${facilityorderno}</b></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Date Needed:</span></td>
                            <td align="left"><b class="cl">${dateneeded}</b></td>
                        </tr>
                        <tr class="even">
                            <td align="left"><span class="style101">Ref No.:</span></td>
                            <td align="left"><b class="cl"> 0540323</b></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Date Created:</span></td>
                            <td align="left"><b class="cl">${dateprepared}</b></td>
                        </tr>
                        <tr class="odd">
                            <td align="left"></td>
                            <td>
                                <b><span class="style101"></span></b>
                            </td>
                            <td align="left">&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Created By:</span></td>
                            <td align="left"><b class="cl">${personname}</b></td>
                        </tr>
                        <tr class="even">
                            <td align="left"><span class="style101">Order Origin:</span></td>
                            <td align="left"><b class="cl">${facilityunitname}</b></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Order stage:</span></td>
                            <td align="left"><b class="cl"><c:if test="${orderstage=='SUBMITTED'}">WAITING APPROVAL</c:if>
                                    <c:if test="${orderstage=='PAUSED'}">PAUSED</c:if>
                                    <c:if test="${orderstage=='RECEIVED'}"> SERVICED</c:if>
                                    </b></td>
                            </tr>
                            <tr class="odd">
                                <td align="left"><span class="style101">Order Destination:</span></td>
                                <td align="left"><b class="cl">${facilitysuppliername}</b></td>
                            <td align="left">&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Criteria:</span></td>
                            <td align="left">
                                <b class="cl" <c:if test="${criteria==true}">style="color: red;"</c:if>>
                                    <c:if test="${criteria==true}">Emergency Order</c:if>
                                    <c:if test="${criteria==false}">Normal Order</c:if>
                                    </b>
                                </td>
                            </tr>
                            <tr class="even">
                            </tr>
                        </tbody></table>

                </div>
                <div class="row">
                    <div class="col-md-4">

                    </div>
                    <div class="col-md-4">
                        <h5 style="color: #6e0610; display: none;" >Total Cost:<span class="badge badge-secondary"><strong>${totalcost}</strong></span></h5>
                </div>
                <div class="col-md-4">

                </div>
            </div>
        </div>
    </fieldset>
</div>
<br>
<fieldset>
    <table class="table table-hover table-bordered" id="facilitypausunitorderitemsstable">
        <thead>
            <tr>
                <th>No</th>
                <th>Item</th>
                <th>Quantity Ordered</th>
            </tr>
        </thead>
        <tbody>
            <% int j = 1;%>
            <c:forEach items="${itemsFound}" var="a">
                <tr>
                    <td><%=j++%></td>
                    <td>${a.genericname}</td>
                    <td>${a.qtyordered}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="form-group">
        <div class="row">
            <div class="col-md-6">
            </div>
            <div class="col-md-6">
                <hr style="border:1px dashed #dddddd;">
                <button type="button" onclick="clsepusmodaldialog();" class="btn btn-secondary btn-block">close</button>
            </div>   
        </div>
    </div> 
</fieldset> 
<script>
    $('#facilitypausunitorderitemsstable').DataTable();
    function clsepusmodaldialog() {
        window.location = '#close';
    }
</script>