<%-- 
    Document   : addFacilityOwner
    Created on : Mar 22, 2018, 4:20:18 PM
    Author     : Grace-K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp"%>
<!DOCTYPE html>
<form class="form-horizontal">
    <div class="form-group row">
        <label class="control-label col-md-4" for="ownername">Owner Name:</label>
        <div class="col-md-8">
            <input class="form-control col-md-8" type="text" id="ownername" name="ownername" placeholder="Owner Name">
        </div>
    </div>

    <div class="form-group row">
        <label class="control-label col-md-4" for="description">About Facility Owner:</label>
        <div class="col-md-8">
            <textarea class="form-control col-md-8" rows="2" id="facilityOwner_description" name="description" placeholder="Description"></textarea>
        </div>
    </div>
</form>
