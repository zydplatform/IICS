<%-- 
    Document   : facilityunits
    Created on : Sep 24, 2018, 6:12:55 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<input type="hidden" value="${staffid}" id="staffid">
<select class="form-control" id="exampleSelect2">
    <c:forEach items="${staffunits}" var ="unit">
        <option id="units" value="${unit.facilityunitid}">${unit.facilityunitname}</option>
    </c:forEach>
</select>
<div class="col-md-12 right"><hr/>
    <button id="savenewunit" onclick="saveUnit()" class="btn btn-primary" type="button">Save</button>
</div>
<script>
    $('#demoselect').select2();
    function saveUnit() {
        document.getElementById("savenewunit").disabled = true;
        var staffid = $('#staffid').val();
        var facilityunitid = $('#exampleSelect2').val();
        $.ajax({
            type: 'GET',
            data: {staffid: staffid, facilityunitid: facilityunitid},
            url: "usermanagement/savenewunit.htm",
            success: function (respose) {
                ajaxSubmitData('usermanagement/userdetails', 'Userdetails', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                ajaxSubmitData('usermanagement/staffunits', 'staffunitsection', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

            }
        });
    }
</script>
