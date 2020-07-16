<%-- 
    Document   : ReleaseFacilityrights
    Created on : Jul 17, 2018, 7:37:56 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<form id="releaseingfacilityComponents_form">
  <div class="row">
    <div class="col-md-4">
        <strong>Select Facility:</strong>
    </div>
    <div class="col-md-6">
        <select class="form-control" id="selected_facilityid">
            <option value="select">-----------Select------------</option>
            <c:forEach items="${facilitysFound}" var="facility">
                <option id="selectedfacilityid${facility.facilityid}" value="${facility.facilityid}">${facility.facilityname}</option>
            </c:forEach>
        </select>  
    </div>
    <div class="col-md-2"></div>
</div><br>
<div class="row">
    <div class="col-md-4">
        <strong>Select Component:</strong>
    </div>
    <div class="col-md-6">
        <select class="form-control" id="releasefacilitycomponentid">
            <option value="select" id="defaltselectedrelasefacilitycomponentsid">-----------Select------------</option>
        </select>  
    </div>
    <div class="col-md-2"></div>
</div>  
</form>
<div class="" id="releasecomponentsforfacilitytree">

</div>
<script>
    $('#selected_facilityid').change(function () {
        var facilityid = $('#selected_facilityid').val();
        if (facilityid !== 'select') {
            $.ajax({
                type: 'POST',
                data: {facilityid:facilityid},
                url: "activitiesandaccessrights/facilityunreleasedcomponents.htm",
                success: function (data, textStatus, jqXHR) {
                    var response=JSON.parse(data);
                    $('#releasefacilitycomponentid').html('');
                    $('#releasefacilitycomponentid').append('<option value="select" id="defaltselectedrelasefacilitycomponentsid">-----------Select------------</option>');
                    for(index in response){
                       var results=response[index];
                       $('#releasefacilitycomponentid').append('<option value="'+results["systemmoduleid"]+'" id="defaltCompntselected'+results["systemmoduleid"]+'">'+results["componentname"]+'</option>');
                    }
                }
            });
        } else {
            document.getElementById('releasecomponentsforfacilitytree').innerHTML = '';
        }
    });
    $('#releasefacilitycomponentid').change(function () {
        var systemmoduleid = $('#releasefacilitycomponentid').val();
        var facilityid = $('#selected_facilityid').val();
        if (systemmoduleid !== 'select' && facilityid !== 'select') {
            ajaxSubmitDataNoLoader('activitiesandaccessrights/releasecomponents.htm', 'releasecomponentsforfacilitytree', 'act=a&facilityid=' + facilityid + '&systemmoduleid=' + systemmoduleid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        } else {
            document.getElementById('releasecomponentsforfacilitytree').innerHTML = '';
        }
    });
</script>