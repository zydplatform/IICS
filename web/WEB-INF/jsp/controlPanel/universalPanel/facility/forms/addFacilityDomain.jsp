<%-- 
    Document   : addFacilityDomain
    Created on : Mar 23, 2018, 8:24:01 PM
    Author     : Grace-K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<form class="form-horizontal">
    <div class="form-group row">
        <label class="control-label col-md-4" for="domainname">Domain Name:</label>
        <div class="col-md-8">
            <input class="form-control col-md-8" type="text" id="domainname" name="domainname" placeholder="Owner Name">
        </div>
    </div>

    <div class="form-group row">
        <label class="control-label col-md-4" for="description2">About Domain:</label>
        <div class="col-md-8">
            <textarea class="form-control col-md-8" rows="2" id="description2" name="description2" placeholder="About Domain"></textarea>
        </div>
    </div>
</form>
