<%-- 
    Document   : stafflist
    Created on : Jul 13, 2018, 1:08:21 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="form-group col-md-3">
                <label for="">Select Unit</label>
                <select class="form-control" id="filtered_facility_unit_id">
                    <option value="allFacilityStaff">All</option>
                    <c:forEach items="${facilityunits}" var="unit">
                        <option value="${unit.facilityunitid}">${unit.facilityunitname}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3 col-sm-1" style="margin-left: 0%; margin-top: 28px;">
                <button class="btn btn-primary" onclick="fetchAllStaff()" type="button">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>

    <fieldset>
        <table class="table table-hover table-bordered col-md-12" id="stafftable">
            <thead>
                <tr>
                    <td>No.</td>
                    <td>Name</td>
                    <td>Staff Number</td>
                    <td>Designation.</td>
                    <td>Date Registered</td>
                    <td>Registered By</td>
                </tr>
            </thead>
            <tbody>
                <% int p = 1;%>
                <c:forEach items="${stafflists}" var="m">
                    <tr>
                        <td><%=p++%></td>
                        <td><a onclick="viewstaffdetails(${m.staffid},${m.personid})"><font color="blue">${m.firstname}&nbsp;${m.lastname}&nbsp;${m.othernames}</font></a></td>
                        <td>${m.staffno}</td>
                        <td>${m.designationname}</td>
                        <td>${m.datecreated}</td>
                        <td>${m.firstnamer}&nbsp;${m.lastnamer}&nbsp;${m.othernamesr}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </fieldset>

<script>
    $('#stafftable').DataTable();
    function fetchAllStaff() {
        $('#staffcontent').html('');
        selectedFacilityUnitid = $('#filtered_facility_unit_id').val();
        if (selectedFacilityUnitid === 'allFacilityStaff') {
            ajaxSubmitData('allStaff.htm', 'stafflists', '', 'GET');
        } else {
            ajaxSubmitData('unitstafflist.htm', 'stafflists', '&selectedFacilityUnitid=' + selectedFacilityUnitid +'', 'GET');
        }
    }
    function viewstaffdetails(staffid,personid) {
        $.ajax({
            type: 'GET',
            data: {staffid: staffid,personid: personid},
            url: "viewstaffdetails.htm",
            success: function (respose) {
                $.confirm({
                    title: '<strong class="center">More Info' + '<font color="green"></font>' + '</strong>',
                    content: '' + respose,
                    boxWidth: '30%',
                    height: '100%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    draggable: true
                });
            }
        });
    }

</script>