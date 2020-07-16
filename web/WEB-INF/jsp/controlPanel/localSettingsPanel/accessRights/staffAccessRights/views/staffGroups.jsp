<%-- 
    Document   : staffGroups
    Created on : Jul 23, 2018, 9:25:25 AM
    Author     : Grace-K
--%>
<style>
    .select2-container{
        z-index: 999999999 !important;
    }
</style>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <div id="viewassignedstaffgroupDiv">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <table class="table table-hover table-bordered" id="StaffAssignedAccessssGroups">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Group Name</th>
                                        <th>Staff Assigned Component(s)</th>
                                        <th>Add More Component(S)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% int j = 1;%>
                                    <c:forEach items="${staffgroupslist}" var="a">
                                        <tr>
                                            <td><%=j++%></td>
                                            <td>${a.accessrightgroupname}</td>
                                            <td align="center">
                                                <c:forEach items="${a.getAssignedComponents}" var="b">
                                                    <a href="#!">|${b.componentname}|</a> <br>
                                                </c:forEach>
                                            </td>
                                            <td align="center">
                                                <button type="button" class="btn btn-primary btn-sm" onclick="addmoregroupcomponentstostaff(${a.accessrightsgroupid},${staffid}, '${assignedgroup}');">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div>
<script>
    $('#StaffAssignedAccessssGroups').DataTable();
    function addmoregroupcomponentstostaff(accessrightsgroupid, staffid, assignedgroup) {
        $.ajax({
            type: 'GET',
            data: {accessrightsgroupid: accessrightsgroupid, staffid: staffid},
            url: "localaccessrightsmanagement/addmoregroupcomponentstostaff.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'Add More Group Components For Staff!',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '80%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                            ajaxSubmitDataNoLoader('localaccessrightsmanagement/viewassignedstaffgroups.htm', 'viewassignedstaffgroupDiv', 'assignedgroup=' + assignedgroup + '&staffid=' + staffid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    }
                });
            }
        });
    }
</script>