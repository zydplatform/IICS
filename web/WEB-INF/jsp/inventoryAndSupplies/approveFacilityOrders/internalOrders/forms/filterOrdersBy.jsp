<%-- 
    Document   : filterOrdersBy
    Created on : Sep 1, 2018, 3:22:43 PM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<hr>
<div class="row">
    <div class="col-md-6 col-sm-6">
        <form>
            <div class="form-group">
                <label for="filtersDate">Start Date</label>
                <input class="filterstartDate form-control" type="text" placeholder="dd-mm-yyyy">
            </div>
        </form>
    </div>
    <div class="col-md-6 col-sm-6">
        <form>
            <div class="form-group">
                <label for="filtereDate">End Date</label>
                <input class="filterendDate form-control" type="text"  placeholder="dd-mm-yyyy">
            </div>
        </form>
    </div>
</div>
<hr>
<div class="row">
    
    <div class="col-md-6">
        <strong>Select Filter By Facility Unit:</strong>
    </div>
    <div class="col-md-6">
        <select class="filterordersby form-control">
            <option value="">-----------Select------------</option>
            <c:forEach items="${facilityunitsList}" var="a">
                <option value="${a.facilityunitid}">${a.facilityunitname}</option>
            </c:forEach>
        </select>  
    </div>
</div><br>
<hr>
<script>
    var serverDate = '${serverdate}';
    $('.filterstartDate').datetimepicker({
        pickTime: false,
        format: "DD/MM/YYYY",
        maxDate: new Date(serverDate)
    });
    
    $('.filterendDate').datetimepicker({
        pickTime: false,
        format: "DD/MM/YYYY",
        maxDate: new Date(serverDate)
                // defaultDate: new Date()
    });
</script>