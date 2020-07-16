<%-- 
    Document   : updateFacilityOwner
    Created on : Mar 22, 2018, 7:02:22 PM
    Author     : Grace-K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp"%>
<!DOCTYPE html>
<form class="form-horizontal">
    <div class="form-group row">
        <label class="control-label col-md-4" for="updateownername">Owner Name:</label>
        <div class="col-md-8">
            <input class="form-control col-md-8" type="text" id="updateownername" name="updateownername" placeholder="Owner Name">
        </div>
    </div>

    <div class="form-group row">
        <label class="control-label col-md-4" for="updatedescription">About Facility Owner:</label>
        <div class="col-md-8">
            <textarea class="form-control col-md-8" rows="2" id="updatedescription" name="updatedescription" placeholder="Description"></textarea>
        </div>
    </div>
</form>
