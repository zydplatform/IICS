<%-- 
    Document   : components
    Created on : Jul 18, 2018, 12:06:38 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<button onclick="addmorereleasedfacilitycomponents(${facilityid});" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>ADD Components</button><br><br>
<table class="table table-hover table-bordered" id="viewassignedfacilityaccessrights">
    <thead>
        <tr>
            <th>No</th>
            <th>Component Name</th>
            <th>Released | Un Released</th>
            <th>Recall Component</th>
        </tr>
    </thead>
    <tbody >
        <% int j = 1;%>
        <c:forEach items="${systemsFound}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.componentname}</td> 
                <td align="center">
                    <button type="button" class="btn btn-primary btn-sm" onclick="ViewcomponentsActivityReleased(${facilityid},${a.systemmoduleid}, 'assigned');">
                        <i class="fa fa-unlock">
                            <span class="badge badge-light"></span>
                        </i>
                    </button>
                    |
                    <button type="button" class="btn btn-primary btn-sm" onclick="ViewcomponentsActivityReleased(${facilityid},${a.systemmoduleid}, 'un');">
                        <i class="fa fa-lock">
                            <span class="badge badge-light"></span>
                        </i>
                    </button>
                </td>
                <td align="center">
                    <button type="button" title="Recall All Component from facility" class="btn btn-primary btn-sm" onclick="recallallfacilityreleasedcomponent();">
                        <i class="fa fa-download" >
                            <span class="badge badge-light"></span>
                        </i>
                    </button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#viewassignedfacilityaccessrights').DataTable();
    function ViewcomponentsActivityReleased(facilityid, systemmoduleid, type) {
        if (type === 'assigned') {
            ajaxSubmitDataNoLoader('activitiesandaccessrights/ViewcomponentsActivityReleasedfacility.htm', 'viewreleasefacilityaccessrighhtdiv', 'facilityid=' + facilityid + '&systemmoduleid=' + systemmoduleid + '&act=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        } else {
            ajaxSubmitDataNoLoader('activitiesandaccessrights/ViewcomponentsActivityReleasedfacility.htm', 'viewreleasefacilityaccessrighhtdiv', 'facilityid=' + facilityid + '&systemmoduleid=' + systemmoduleid + '&act=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    }
    function addmorereleasedfacilitycomponents(facilityid) {
        $.ajax({
            type: 'GET',
            data: {facilityid: facilityid},
            url: "activitiesandaccessrights/addmorereleasedfacilitycomponents.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'RELEASE MORE COMPONENTS FOR FACILITY!',
                    content: '' + data,
                    boxWidth: '70%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                            ajaxSubmitDataNoLoader('activitiesandaccessrights/viewReleaseFacilityComponent.htm', 'viewreleasefacilityaccessrighhtdiv', 'facilityid=' + facilityid + '&act=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    }
                });
            }
        });
    }
    function recallallfacilityreleasedcomponent() {
        $.confirm({
            title: 'Recall Component',
            content: 'Under Implementation',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Ok',
                    btnClass: 'btn-purple',
                    action: function () {
                    }
                },
                close: function () {
                }
            }
        });
    }
</script>