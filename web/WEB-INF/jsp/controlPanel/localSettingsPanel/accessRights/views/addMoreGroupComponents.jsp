<%-- 
    Document   : addMoreComponents
    Created on : Aug 2, 2018, 11:01:37 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<button onclick="addreleasedfacilitygroupcomponents(${accessrightsgroupid});" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>ADD Components</button><br><br>
<table class="table table-hover table-bordered" id="viewassignedfacilityaccessrightsComp">
    <thead>
        <tr>
            <th>No</th>
            <th>Component Name</th>
            <th>Granted | Un Granted</th>
        </tr>
    </thead>
    <tbody >
        <% int j = 1;%>
        <c:forEach items="${groupcomponentsList}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.componentname}</td> 
                <td align="center">
                    <button type="button" class="btn btn-primary btn-sm" onclick="">
                        <i class="fa fa-unlock">
                            <span class="badge badge-light"></span>
                        </i>
                    </button>
                    |
                    <button type="button" class="btn btn-primary btn-sm" onclick="">
                        <i class="fa fa-lock">
                            <span class="badge badge-light"></span>
                        </i>
                    </button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#viewassignedfacilityaccessrightsComp').DataTable();
    function addreleasedfacilitygroupcomponents(accessrightsgroupid) {
        $.ajax({
            type: 'GET',
            data: {accessrightsgroupid:accessrightsgroupid},
            url: "localaccessrightsmanagement/addreleasedfacilitygroupcomponents.htm",
            success: function (data, textStatus, jqXHR) {
              $.confirm({
                    title: 'ASSIGN MORE COMPONENTS FOR GROUP!',
                    content: '' + data,
                    boxWidth: '70%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                             ajaxSubmitDataNoLoader('localaccessrightsmanagement/viewgroupassignedComponentsandadd.htm', 'viewGroupGrantedRightsAccessCompdiv', 'accessrightsgroupid=' + accessrightsgroupid + '&act=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    }
                });  
            }
        });
    }
</script>