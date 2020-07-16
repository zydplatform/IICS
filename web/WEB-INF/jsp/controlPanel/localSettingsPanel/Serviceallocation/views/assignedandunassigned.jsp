<%-- 
    Document   : assignedandunassigned
    Created on : Jul 26, 2018, 8:57:15 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<div class="row" style="margin-top: 1em">
    <div class="col-md-4 col-sm-4">
        <form action="" class="formName" id="buildingdropdown" style="display: none">
            <div class="form-group">
                <select class="form-control buildings" id="building-select">
                    <c:forEach items="${buildings}" var="building">
                        <option value="${building.buildingid}">${building.buildingname}</option>
                    </c:forEach>
                </select>
            </div>
        </form>
    </div>
</div>
<div class="row">
    <div class="col-md-12" id="servicePaneContent">

    </div>
</div>
<script>
    $(document).ready(function () {
        ajaxSubmitData('serviceallocation/serviceslist.htm', 'servicePaneContent', '', 'GET');
    });
</script>
