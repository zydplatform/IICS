<%-- 
    Document   : itemEdit
    Created on : Jul 19, 2018, 3:07:16 PM
    Author     : IICS
--%>

<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form id="entryUpdateCategoryformItem">
    <div class="form-group">
        <label class="control-label">Item Name</label>
        <input class="form-control" id="updateSuppliesItemName"  value="${name}" type="text">
    </div>
    <div class="form-group">
        <label>Specification</label>
        <input type="text" value="${specification}" id="updateSuppliesItemspecification" class="form-control" required />
    </div>
    <div class="form-group">
        <label>Select Level here</label>
        <select class="form-control" required id="updateSuppliesItemlevel">
            <option value="${facilitylevelid}">${levelofuse}</option>   
            <c:forEach items="${itemsFound}" var="c">
                <option id="UpdateSuppOption${c.facilitylevelid}" data-name="${c.shortname}" value="${c.facilitylevelid}">${c.shortname}</option>   
            </c:forEach>
        </select>
    </div>
    <div class="form-group">
        <label>Select Class here</label>
        <select class="form-control" required id="updateSuppliesItemClass">
            <option value="${itemusage}">${itemusage}</option>
            <option value="Vital">Vital(V)</option>
            <option value="Essential">Essential(E)</option>
            <option value="Necessary">Necessary(N)</option>
        </select>
    </div>  
    <div class="form-group row">
        <label class="control-label col-md-4">Is Special</label>
        <div class="col-md-8">
            <div class="form-check form-check-inline">
                <input class="form-check-input" style="font-weight: normal !important;" <c:if test="${isspecial==true}">checked="true"</c:if> type="radio" name="updateSuppliesInlineRadioSpecial" id="updatesuppinlineRadioisspecial1" value="true">
                <label class="form-check-label">Yes</label>
            </div>

            <div class="form-check form-check-inline">
                <input class="form-check-input" <c:if test="${isspecial==false}">checked="true"</c:if> type="radio" name="updateSuppliesInlineRadioSpecial" id="updatesuppinlineRadioisspecial2" value="false">
                <label class="form-check-label">No</label>
            </div>
        </div>
    </div>        
</form>