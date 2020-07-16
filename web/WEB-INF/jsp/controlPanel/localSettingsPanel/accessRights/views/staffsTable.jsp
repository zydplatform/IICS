<%-- 
    Document   : staffsTable
    Created on : Jul 22, 2018, 9:33:27 AM
    Author     : Grace-K
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered" id="StaffAssignedAccessRightsGroups">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Staff Name</th>
                                    <th>Units</th>
                                    <th>Granted Access Rights</th>
                                    <th>Groups | Add</th>
                                </tr>
                            </thead>

                            <tbody >
                                <% int j = 1;%>
                                <% int i = 1;%>
                                <c:forEach items="${staffmemberslist}" var="a">
                                    <tr>
                                        <td><%=j++%></td>
                                        <td>${a.firstname} &nbsp;${a.othernames}&nbsp;${a.lastname}</td>
                                        <td align="center">
                                            <button type="button" class="btn btn-primary btn-sm" onclick="viewStaffUnits(${a.staffid});">
                                                <i class="fa fa-dedent">
                                                    <span class="badge badge-light">${a.staffunitscounts}</span>
                                                    Units(s)
                                                </i>
                                            </button>
                                        </td>
                                        <td align="center">
                                            <button type="button" class="btn btn-primary btn-sm" onclick="viewStaffGrantedRights('${a.staffgroups}',${a.staffid},${a.staffunitscount}, '${a.firstname}', '${a.lastname}');">
                                                <i class="fa fa-dedent"></i>
                                            </button>
                                        </td>
                                        <td align="center">
                                            <span  title="Groups Added To."  <c:if test="${a.staffunitscount<1}">class="badge badge-secondary icon-custom"</c:if>  <c:if test="${a.staffunitscount>0}">onclick="viewStaffGroups('${a.staffgroups}',${a.staffid},'${a.firstname}','${a.lastname}','${a.othernames}');" class="badge badge-success icon-custom"</c:if>>${a.staffunitscount}</span>
                                                |
                                            <span  title="Add To Group." onclick="addstaffmembertoGroups('${a.staffgroups}',${a.staffid});"  class="badge badge-danger icon-custom"><i class="fa fa-plus"></i></span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div>
<script>
    $('#StaffAssignedAccessRightsGroups').DataTable();
    function addstaffmembertoGroups(assignedgroups, staffid) {
        window.location = '#addnewstaffaccessgrouprightsgroupsdialog';
        initDialog('addnewgrpaccessgrouprightsdiv');
        ajaxSubmitDataNoLoader('localaccessrightsmanagement/useraccessrightsaddtomanagement.htm', 'addgrpaccessgrouprightsdiv', 'assignedgroups=' + assignedgroups + '&staffid=' + staffid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function viewStaffGroups(assignedgroups, staffid,firstname,lastname,othernames) {
        $.ajax({
            type: 'GET',
            data: {assignedgroup: assignedgroups, staffid: staffid},
            url: "localaccessrightsmanagement/viewassignedstaffgroups.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: '<a href="#!">'+firstname+' '+ lastname +' '+othernames+'</a>:'+' '+'Group(s) And Assigned Component(s)',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '70%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                            
                        }
                    }
                });
            }
        });

    }
    function viewStaffGrantedRights(assignedgroups, staffid, staffunitscount, firstname, lastname) {
        if (staffunitscount > 0) {
            $.ajax({
                type: 'GET',
                data: {assignedgroups: assignedgroups, staffid: staffid},
                url: "localaccessrightsmanagement/viewStaffGrantedRights.htm",
                success: function (data, textStatus, jqXHR) {
                    window.location = '#viewStaffGrantedRightsAccess';
                    document.getElementById('StaffGrantedRightsTitle').innerHTML = firstname + ' ' + lastname + ' ' + 'Granted Rights';
                    $('#viewStaffGrantedRightsAccessdiv').html(data);
                    initDialog('viewStaffGrantedRightsAccessclass');
                }
            });
        } else {
            $.confirm({
                title: 'Granted Rights!',
                icon: 'fa fa-warning',
                content: 'No Granted Rights !!',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    close: function () {

                    }
                }
            });
        }
    }
    function viewStaffUnits(staffid) {
        $.ajax({
            type: 'GET',
            data: {staffid:staffid},
            url: "localaccessrightsmanagement/viewstaffunits.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                title: 'Facility Units!',
                boxWidth:'60%',
                useBootstrap: false,
                content: ''+data,
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    close: function () {

                    }
                }
            });
            }
        });
    }
</script>