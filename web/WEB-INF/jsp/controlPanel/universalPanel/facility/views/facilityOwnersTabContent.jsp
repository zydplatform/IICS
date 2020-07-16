<%-- 
    Document   : facilityOwnersTabContent
    Created on : Mar 24, 2018, 10:26:47 AM
    Author     : Grace-K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>

<div class="row">
    <div class="col-md-12">
        <fieldset style="min-height:100px;">
            <div class="tile">
                <div class="tile-body">
                    <table class="table table-hover table-bordered" id="facilityownwertable">
                        <thead>
                            <tr>
                                <th class="center">No</th>
                                <th>Facility Owner Name</th>
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EDITORDELETEFACILITYOWNERNAME')">
                                <th class="center">Manage</th>
                                </security:authorize>
                            </tr>
                        </thead>
                        <tbody class="col-md-12" id="tableFacilityOwner">
                            <% int y = 1;%>
                            <% int j = 1;%>
                            <c:forEach items="${faclilityOwnerList}" var="a">
                                <tr id="${a.facilityownerid}">
                                    <td class="center"><%=y++%></td>
                                    <td>${a.ownername}</td>
                                    <td class="hide">${a.description}</td>
<!--                                    <td class="center"><a id="" data-container="body" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="${a.description}" data-original-title="${a.ownername}" href="#"> <i class="fa fa-fw fa-lg fa-dedent"></i></a></td>-->
                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EDITORDELETEFACILITYOWNERNAME')">
                                    <td class="center">
                                        <a href="#" title="Update Facility Owner" onclick="updateFacilityOwner(this.id);" id="up<%=j++%>"><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                        &nbsp;
                                        <a href="#" title="Discard Facility Owner" onclick="var resp = confirm('Discard ${a.ownername}!');
                                           if (resp === false) {
                                                 return false;
                                           }
                                           ajaxSubmitData('facility/discardFacilitywOners.htm', 'facliltyOwnerContent', 'act=a&sn=&i=${a.facilityownerid}&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');" id="up<%=j++%>"><i class="fa fa-fw fa-lg fa-times"></i></a>
                                                                           
                                    </td>
                                    </security:authorize>     
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div id="addnew-pane"></div>
                </div>
            </div>
        </fieldset>
    </div>
</div>
                            
                            <script>
    $(document).ready(function () {
        $('#sampleTable').DataTable();
    });
</script>
<script>
    $(document).ready(function () {
        $('#facilityownwertable').DataTable();
    });
</script>