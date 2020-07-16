<%-- 
    Document   : addRecoveryCategory
    Created on : Aug 16, 2018, 3:47:12 PM
    Author     : user
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<form class="form-horizontal">
    <div class="form-group row">
        <label class="control-label col-md-4" for="trailcategoryname">Category Name:</label>
        <div class="col-md-8">
            <input class="form-control col-md-8" type="text" id="trailcategoryname" name="trailcategoryname" placeholder="category Name">
        </div>
    </div>
    <div class="form-group row">
        <label class="control-label col-md-4" for="description">Description:</label>
        <div class="col-md-8">
            <textarea class="form-control col-md-8"  rows="2" id="description" name="description" placeholder="description"></textarea>
        </div>
    </div>
</form>
