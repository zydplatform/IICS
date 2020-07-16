<%-- 
    Document   : unitsServices
    Created on : Sep 12, 2018, 5:49:31 PM
    Author     : HP
--%>
<%@include file="../../../include.jsp" %>
<input id="QueuingUnitServiceStaffid" type="hidden" value="${staffid}">
<div class="row">
    <div class="col-md-12">
        <fieldset style="min-height:100px;">
            <hr>
            <div class="row">
                <div class="col-md-4">
                    <strong>Select Unit</strong>
                </div>
                <div class="col-md-6">
                    <select class="form-control" id="queuingFacilityUnits">
                        <c:if test="${empty unitServicesFound}">
                            <option value="select">-----------Select------------</option>
                        </c:if>
                        <c:if test="${not empty unitServicesFound}">
                            <option value="${facilityunitid}">${facilityunitname}</option>
                        </c:if>
                        <c:forEach items="${unitsFound}" var="otherUnits">
                            <option  value="${otherUnits.id}">${otherUnits.name}</option>
                        </c:forEach>
                    </select>  
                </div>
                <div class="col-md-2">

                </div>
            </div><br>
            <div class="row">
                <div class="col-md-4">
                    <strong>Select Service</strong>
                </div>
                <div class="col-md-6">
                    <select class="form-control" id="queuingFacilityUnitServices">
                        <c:if test="${not empty unitServicesFound}">
                            <c:forEach items="${unitServicesFound}" var="funitservices">
                                <option value="${funitservices.facilityunitserviceid}">${funitservices.servicename}</option>
                            </c:forEach>
                        </c:if>

                    </select>  
                </div>
                <div class="col-md-2">

                </div>
            </div>
            <hr>
        </fieldset>  
    </div>
</div>
<script>
    $('#queuingFacilityUnits').change(function () {
        var facilityunitservices = $('#queuingFacilityUnits').val();
        if (facilityunitservices !== 'select') {
            $.ajax({
                type: 'POST',
                data: {facilityunit: facilityunitservices},
                url: "doctorconsultation/facilityUnitServices.htm",
                success: function (data, textStatus, jqXHR) {
                    var response = JSON.parse(data);
                    $('#queuingFacilityUnitServices').html('');
                    if (response.length > 0) {
                        for (index in response) {
                            var results=response[index];
                            $('#queuingFacilityUnitServices').append('<option value="'+results["facilityunitserviceid"]+'">'+results["servicename"]+'</option>');
                        }
                    }
                }
            });
        }
    });
</script>