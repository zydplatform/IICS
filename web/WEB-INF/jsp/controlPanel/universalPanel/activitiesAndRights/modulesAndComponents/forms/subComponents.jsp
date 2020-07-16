<%-- 
    Document   : subComponents
    Created on : Jun 4, 2018, 12:24:16 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${act=='b'}">
    <button onclick="systemmodulesubcompbackbutton(${systemmoduleid});" class="btn btn-secondary pull-left" type="button"><i class="fa fa-fw fa-lg fa-backward"></i>Back</button>
</c:if>
<br><br>
<table class="table table-hover table-bordered" id="system_sub_comp">
    <thead>
        <tr>
            <th>No</th>
            <th>Component Name</th>
            <th>Sub Component(s)</th>
            <th>Has Privilege</th>
            <th>Delete</th>
        </tr>
    </thead>
    <tbody id="tableFacilityOwner">
        <% int j = 1;%>
        <% int k = 1;%>
        <c:forEach items="${systemmodulesList}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.systemmodulename}</td>
                <td>${a.subcomponentcount}</td>
                <td align="center"><c:if test="${a.hasprivilege==true}">Yes</c:if><c:if test="${a.hasprivilege==false}">No</c:if></td>
                    <td align="center">
                            <span class="badge badge-danger icon-custom" title="Delete Component" onclick="deletesystemmodulesubcomponent(${a.systemmoduleid},${systemmoduleid},${a.subcomponentcount}, '${a.systemmodulename}');">
                        <i class="fa fa-fw fa-lg fa-remove"></i></span>
            </tr>
        </c:forEach>
    </tbody>
</table>
<div class="form-group">
    <div class="row">
        <div class="col-md-4">
        </div>
        <div class="col-md-4">
        </div>
        <div class="col-md-4">
            <hr style="border:1px dashed #dddddd;">
            <button type="button" onclick="cancelsystemmod();" class="btn btn-secondary btn-block">Close</button>
        </div>   
    </div>
</div>
<script>
    if ('${act}' === 'a') {
        document.getElementById('innitialsystemmoduleclickedfirst').value = '${systemmoduleid}';
    }
    if ('${act}' === 'a' && '${systemmodulesListSize}' === 0) {
        window.location = '#close';
        var sel = $('#systemmoduleclicked').val();
        if (sel === 'a') {
            ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        } else {
            ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=b&i=' + sel + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    } else if ('${act}' === 'b' && '${systemmodulesListSize}' === 0) {
        var initialsystemmoduleid2 = $('#innitialsystemmoduleclickedfirst').val();
        ajaxSubmitData('activitiesandaccessrights/getcascadingsystemmodulesubcomponents.htm', 'systemmoduleattachmentsdiv', 'act=c&systemmoduleid=' + '${systemmoduleid}' + '&initialsystemmoduleid=' + initialsystemmoduleid2 + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    $('#system_sub_comp').DataTable();
    function deletesystemmodulesubcomponent(systemmoduleid, systemmoduleidclicked, subcomponentcount, systemmodulename) {
        if (subcomponentcount === 0) {
            $.ajax({
                type: 'POST',
                data: {systemmoduleid: systemmoduleid},
                url: "activitiesandaccessrights/deletesystemmodule.htm",
                success: function (data, textStatus, jqXHR) {
                    var initialsystemmoduleid = $('#innitialsystemmoduleclickedfirst').val();
                    ajaxSubmitData('activitiesandaccessrights/getcascadingsystemmodulesubcomponents.htm', 'systemmoduleattachmentsdiv', 'act=b&systemmoduleid=' + systemmoduleidclicked + '&initialsystemmoduleid=' + initialsystemmoduleid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        } else {
            $.confirm({
                title: 'Delete Failed!',
                content: systemmodulename + ' ' + 'Was Not Deleted Because Of Attachment',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Ok',
                        btnClass: 'btn-red',
                        action: function () {
                            ajaxSubmitData('activitiesandaccessrights/getcascadingsystemmodulesubcomponents.htm', 'systemmoduleattachmentsdiv', 'act=b&systemmoduleid=' + systemmoduleid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    },
                    close: function () {
                        window.location = '#close';
                    }
                }
            });
        }
    }
    function systemmodulesubcompbackbutton(systemmoduleidclicked) {
        var initialsystemmoduleid = $('#innitialsystemmoduleclickedfirst').val();
        ajaxSubmitData('activitiesandaccessrights/getcascadingsystemmodulesubcomponents.htm', 'systemmoduleattachmentsdiv', 'act=c&systemmoduleid=' + systemmoduleidclicked + '&initialsystemmoduleid=' + initialsystemmoduleid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function cancelsystemmod() {
        window.location = '#close';
        var sel3 = $('#systemmoduleclicked').val();
        if (sel3 === 'a') {
            ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        } else {
            ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=b&i=' + sel3 + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    }
</script>
