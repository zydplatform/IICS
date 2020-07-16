<%-- 
    Document   : addserviceactivity
    Created on : May 15, 2018, 12:13:59 PM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<form class="form-horizontal">
    <div class="form-group row">
        <div class="col-md-8">
            <label class="control-label" for="ownername">Service Activity Name:</label>
            <input class="form-control" type="text" id="serviceactname" name="serviceactname" placeholder="Enter Service Activity Name">
        </div>
        <div class="col-md-4">
            <label class="control-label" for="ownername">Duration(minutes):</label>
            <input class="form-control " type="text" id="duration" name="duration" placeholder="Enter Duration">
        </div>
    </div>
    <div class="form-group row">
        <div class="col-md-12">
            <label class="control-label" for="description">About Service Activity:</label>
            <textarea class="form-control" rows="3" id="description" name="description" placeholder="Description"></textarea>
        </div>
    </div>
</form>