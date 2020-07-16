<%-- 
    Document   : itemEdit
    Created on : Jul 11, 2018, 4:25:22 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form id="entryUpdateCategoryformItem">
    <div class="form-group">
        <label class="control-label">Item Name</label>
        <input class="form-control" id="updateItemName"  value="${name}" type="text">
    </div>
    <div class="form-group">
        <label class="control-label">Dosage Form</label>
        <input class="form-control" id="updateItemForm" type="text" value="${dosageform}">
    </div>
    <div class="form-group">
        <label>Item Strength</label>
        <input type="text" value="${itemstrength}" id="updateItemstrength" class="form-control" required />
    </div>
    <div class="form-group">
        <label>Select Level here</label>
        <select class="form-control" required id="updateItemlevel">
            <option value="${facilitylevelid}">${levelofuse}</option>   
            <c:forEach items="${itemsFound}" var="c">
                <option id="UpdateOption${c.facilitylevelid}" data-name="${c.shortname}" value="${c.facilitylevelid}">${c.shortname}</option>   
            </c:forEach>
        </select>
    </div>
    <div class="form-group">
        <label>Select Class here</label>
        <select class="form-control" required id="updateItemClass">
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
                <input class="form-check-input" style="font-weight: normal !important;" <c:if test="${isspecial==true}">checked="true"</c:if> type="radio" name="updateInlineRadioSpecial" id="updateinlineRadioisspecial1" value="Yes">
                <label class="form-check-label">Yes</label>
            </div>

            <div class="form-check form-check-inline">
                <input class="form-check-input" <c:if test="${isspecial==false}">checked="true"</c:if> type="radio" name="updateInlineRadioSpecial" id="updateinlineRadioisspecial2" value="No">
                <label class="form-check-label">No</label>
            </div>
        </div>
    </div>       
</form>