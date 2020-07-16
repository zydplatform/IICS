<%-- 
    Document   : procurementPlanItems
    Created on : Apr 12, 2018, 11:11:25 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <legend>Procurement Plan For Financial Year:&nbsp; ${procurementplanname}</legend>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <input value="${financialyearid}" type="hidden" id="procurementidappr">
                        <input id="procurementnamesent" value="${procurementplanname}" type="hidden">
                        <table class="table table-hover table-bordered" id="procurementtable2">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Generic Name</th>
                                    <th>Pack Size</th>
                                    <th>Monthly Need</th>
                                    <th>Annual Need</th>
                                    <th>Remove</th>
                                </tr>
                            </thead>
                            <tbody >
                                <% int j = 1;%>
                                <% int m = 1;%>
                                <% int a = 1;%>
                                <% int readd = 1;%>
                                <c:forEach items="${financialyritem}" var="a">
                                    <tr id="${a.itemid}">
                                        <td><%=j++%></td>
                                        <td>${a.genericname}</td>
                                        <td>${a.packsize}</td>
                                        <td id="monthz-<%=m++%>"onkeyup="updatemonthorannuallyneededvalues(this.id);" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;">${a.monthly}</td>
                                        <td id="annualz-<%=a++%>" onkeyup="updatemonthorannuallyneededvalues(this.id);" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;">${a.annual}</td>
                                        <c:if test="${a.approved==false}">
                                            <td align="">Removed &nbsp;|&nbsp;<a id="readd<%=readd++%>-${a.itemid}" href="#" onclick="readditem(this.id);"><i class="fa fa-fw fa-lg fa-plus"></i></a></td>
                                        </c:if>
                                        <c:if test="${a.approved==true}">
                                            <td align="center"><input value="${a.itemid}" type="checkbox" onchange="if (this.checked) {
                                                        addorremoveitem(this.value);
                                                    } else {
                                                        addorremoveitem(this.value);
                                                    }" checked="checked"></td>
                                            </c:if>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-4">
                                    <hr style="border:1px dashed #dddddd;">
                                    <button type="button"  onclick=""class="btn btn-primary btn-block">Save & Pause</button>
                                </div>   
                                <div class="col-sm-4">
                                    <hr style="border:1px dashed #dddddd;">
                                    <button type="button" onclick="saveandasapproved();" class="btn btn-primary btn-block">Save & Approve</button>
                                </div> 
                                <div class="col-sm-4">
                                    <hr style="border:1px dashed #dddddd;">
                                    <button type="button" onclick="resetdata();" class="btn btn-secondary btn-block">Reset</button>
                                </div> 
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </fieldset>
</div>