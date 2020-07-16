<%-- 
    Document   : AddMoreStaffComponents
    Created on : Aug 28, 2018, 5:17:33 PM
    Author     : HP
--%>

<%@include file="../../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <fieldset style="min-height:100px;">
            <hr>
            <div class="row">
                <div class="col-md-4">
                    <strong>Select Component:</strong>
                </div>
                <div class="col-md-6">
                    <select class="form-control" id="addMoreStaffComponentsSelect">
                        <option value="select" id="defaultAddMoreStaffComponentsselectid">-----------Select------------</option>
                        <c:forEach items="${componentsList}" var="systemcomponent">
                            <option id="SelectAddMoreOption${systemcomponent.systemmoduleid}" value="${systemcomponent.systemmoduleid}">${systemcomponent.componentname}</option>
                        </c:forEach>
                    </select>  
                </div>
                <div class="col-md-2">

                </div>
            </div><br>
            <hr>
            <hr>
            <div class="row">
                <div class="col-md-4">
                    <strong>Select Units:</strong>
                </div>
                <div class="col-md-6">
                    <select class="form-control" id="addMoreStaffFcalityUnitsSelect" multiple="">
                        <c:forEach items="${staffUnitsList}" var="funits">
                            <option id="SelectAddMoreFcOption${funits.stafffacilityunitid}" value="${funits.stafffacilityunitid}">${funits.facilityunitname}</option>
                        </c:forEach>
                    </select>  
                </div>
                <div class="col-md-2">

                </div>
            </div><br>
            <hr>
            <div class="row">
                <div class="col-md-2">
                    <div class="overlay" id="gettingAddMorecomponentstructurediv" style="display: none;">
                        <div class="m-loader mr-4">
                            <svg class="m-circular" viewBox="25 25 50 50">
                            <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                            </svg>
                        </div>
                        <h5 class="l-text">Please Wait...........</h5>
                    </div>
                </div>
                <input id="releaseMoreStaffcomponentsgroupId" value="${accessrightsgroupid}" type="hidden">
                <div class="col-md-10">
                    <div id="releaseMorecomponentsforStafftree">

                    </div>
                </div>
            </div>
            <hr>
        </fieldset>  
    </div>
</div>

<script>
    $('#addMoreStaffFcalityUnitsSelect').select2();
    $('#addMoreStaffComponentsSelect').change(function () {
        var componentid = $('#addMoreStaffComponentsSelect').val();
        if (componentid !== 'select') {
            var accessrightsgroupid = $('#releaseMoreStaffcomponentsgroupId').val();
            document.getElementById('releaseMorecomponentsforStafftree').innerHTML = '';
            ajaxSubmitDataNoLoader('localaccessrightsmanagement/addmorestaffgroupcomponents.htm', 'releaseMorecomponentsforStafftree', 'systemmoduleid=' + componentid + '&accessrightsgroupid=' + accessrightsgroupid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    });
</script>