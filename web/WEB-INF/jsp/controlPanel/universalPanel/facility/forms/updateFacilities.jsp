<%-- 
    Document   : updateFacilities
    Created on : Apr 3, 2018, 7:31:14 PM
    Author     : Grace-K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<form class="form-horizontal">
    <div class="form-group row">
        <label class="control-label col-md-4" for="updatedfacilityname">Facility Name:</label>
        <div class="col-md-8">
            <input class="form-control col-md-8" type="text" id="updatedfacilityname" name="updatedfacilityname" placeholder="Facility Name">
        </div>
    </div>

    <div class="form-group row">
        <label class="control-label col-md-4" for="updatedshortname">Facility Name:</label>
        <div class="col-md-8">
            <input class="form-control col-md-8" type="text" id="updatedshortname" name="updatedshortname" placeholder="Short Name">
        </div>
    </div>

    <div class="form-group row">
        <label class="control-label col-md-4" for="updatedfacilitystatus">Status:</label>
        <div class="col-md-8">
            <input class="form-control col-md-8" type="text" id="updatedfacilitystatus" name="updatedfacilitystatus" placeholder="Status">
        </div>
    </div>

</form>
