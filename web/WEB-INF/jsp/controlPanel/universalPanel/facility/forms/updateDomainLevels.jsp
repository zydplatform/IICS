<%-- 
    Document   : updateFacilityDomain
    Created on : Mar 24, 2018, 8:31:59 AM
    Author     : Grace-K
--%>
<%@include file="../../../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form class="form-horizontal">
    <div class="form-group row">
        <label class="control-label col-md-4" for="updatelevelname">Level Name:</label>
        <div class="col-md-8">
            <input class="form-control col-md-8" type="text" id="updatelevelname" name="updatelevelname" placeholder="Level Name">
        </div>
    </div>
    
    <div class="form-group row">
        <label class="control-label col-md-4" for="shortname2">About Domain Level:</label>
        <div class="col-md-8">
            <textarea class="form-control col-md-8" rows="2" id="shortname2" name="shortname2" placeholder="Short Name"></textarea>
        </div>
    </div>

    <div class="form-group row">
        <label class="control-label col-md-4" for="updatedescription2">About Domain Level:</label>
        <div class="col-md-8">
            <textarea class="form-control col-md-8" rows="2" id="updatedescription2" name="updatedescription2" placeholder="Description"></textarea>
        </div>
    </div>
</form>
