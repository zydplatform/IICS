<%-- 
    Document   : regionContent
    Created on : May 31, 2018, 4:55:54 PM
    Author     : Uwera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<div class="box-title" align="center">
    <h3>
        <i class="fa fa-home"></i>
        Manage Region
    </h3>
</div>
<fieldset style="min-height:100px;">
    <div id="response-pane"></div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                        <thead class="col-md-12">
                            <tr>
                                <th class="center">No</th>
                                <th>Region Name </th>
                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEREGIONS')or hasRole('PRIVILEGE_UPDATEREGIONS')"></security:authorize>
                                    <th class="center">Manage</th>
                                </tr>
                            </thead>
                            <tbody class="col-md-12" id="tableRegion">
                            <% int y = 1;%>
                            <% int j = 1;%>
                            <c:forEach items="${regionList}" var="region">
                                <tr id="${region.regionid}">
                                    <td class="center"><%=y++%></td>
                                    <td>${region.regionname}</td>
                                    <td class="center">
                                        <a href="#" title="Update Region" onclick="updateRegion(this.id);" id="up<%=j++%>"><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                        &nbsp;
                                        <%--<span  onclick="deleteRegion(${region.regionid}, '${region.regionname}');" id="up<%=j++%>"><i class="fa fa-fw fa-lg fa-book"></i></span>--%>
                                        
                                        
                                        <a href="#" title="Discard Region" onclick="var resp = confirm('Delete Region: ${region.regionname}!');
                                                if (resp === false) {
                                                    return false;
                                                }
                                                ajaxSubmitData('locations/deleteRegion.htm', 'response-pane', 'act=a&rID=${region.regionid}', 'GET');" id="up<%=j++%>"><i class="fa fa-fw fa-lg fa-times"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div id="addnew-pane"></div>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<script>
    $(document).ready(function () {
        $('#sampleTable').DataTable();
    });
    
    <%--
    function deleteRegion(regionid, regionname) {

        $.confirm({
            title: 'Delete/Discard ' + regionname,
            content: 'Are You Sure You Want To Delete' + ' ' + regionname,
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'YES',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'GET',
                            data: {regionid: regionid},
                            url: "locations/deleteRegion.htm', 'response-pane', 'act=a&rID=${region.regionid}', 'GET'",
                            success: function (data, textStatus, jqXHR) {
                                console.log("regionid:::::::::::::" + regionid);
                                if (data === 'success') {
                                    $.confirm({
                                        title: 'Deleted/Discarded ' + regionname + 'Successfully',
                                        type: 'orange',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                ajaxSubmitData('locations/deleteRegion.htm', 'response-pane', 'act=a&rID=${region.regionid}', 'GET');
                                            }
                                        }
                                    });
                                } else {
                                    $.alert({
                                        title: 'Alert!',
                                        content: 'Failed To Delete/Discard' + ' ' + regionname
                                    });
                                }
                            }
                        });
                    }
                },
                NO: function () {
                }
            }
        });
    }--%>
</script>



