<%-- 
    Document   : itemPrescriptionView
    Created on : Sep 22, 2018, 5:26:26 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp" %>

<div class="row">
    <div class="col-sm-12 col-md-12">
        <table class="table table-hover table-bordered " id="">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Item Name</th>
                    <th class="right">UnShelved stock</th>
                    <th class="right">Shelved stock</th>
                    <th>Choose</th>
                </tr>
            </thead>
            <tbody id="">
                <% int x = 1;%>
                <c:forEach items="${prescriptionSpecificItemList}" var="des">
                    <tr>
                        <td><%=x++%></td>
                        <td>${des.fullname}</td>
                        <td class="right">
                            <c:if test="${des.unshelvedstock != null && des.unshelvedstock != '0'}">
                                <strong ><fmt:formatNumber type="number" maxFractionDigits="0" value="${des.unshelvedstock}"/></strong>
                            </c:if>
                            <c:if test="${des.unshelvedstock == null || des.unshelvedstock == '0'}">
                                <strong>
                                    <font color="red">0</font>
                                </strong>
                            </c:if>
                        </td>
                        <td class="right">
                            <input type="hidden" id="shelvedstockvalue${des.itemid}" value="${des.shelvedstock}"/>
                            <c:if test="${des.shelvedstock != null && des.shelvedstock != '0'}">
                                <strong id="shelvedstock${des.itemid}"><fmt:formatNumber type="number" maxFractionDigits="0" value="${des.shelvedstock}"/></strong>
                            </c:if>
                            <c:if test="${des.shelvedstock == null || des.shelvedstock == '0'}">
                                <strong>
                                    <font color="red">0</font>
                                </strong>
                            </c:if>
                        </td>
                        <td class="center">
                            <input class="form-check-input" onclick="functionApprovePrescriptions(${des.itemid}, ${medicalitemid})" id="optionsRadios${des.itemid}" type="radio" name="packageitemsoptions" value="${des.itemid}">
                            <span class="hidedisplaycontent hiddenPrescInputs" id="approvePrescription${des.itemid}">
                                <input id="approveInputfield${des.itemid}" class="form-control-sm" type="number" value="" oninput="functionvalidatedenteredqtys(${des.itemid}, ${medicalitemid})"/></br>
                                <small  class="form-text hidedisplaycontent" id="errorwronginput${des.itemid}"><font color='red'>Can't approve more than what is shelved.</font></small>
                                <small class="form-text hidedisplaycontent" id="erroremptyfield${des.itemid}">
                                    <font color="purple">
                                        <strong>
                                            Approve(Enter) QTY to issue
                                        </strong>
                                    </font>
                                </small>
                            </span>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
