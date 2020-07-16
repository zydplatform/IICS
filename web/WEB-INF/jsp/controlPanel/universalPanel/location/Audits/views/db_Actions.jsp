<%-- 
    Document   : db_Actions
    Created on : August 1, 2018, 10:05:07 AM
    Author     : Uwera
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset id="main" style="width:90%">
    <legend>Actions On Object: ${model.atActivity}</legend>
    <table class="table table-hover table-bordered" id="auditsTable">
        <thead>
            <tr>
                <th>No</th>
                <th>Data Action</th>
                <th>Records</th>
                <th>View Details</th>
            </tr>
        </thead>
        <tbody id="tableAudits">
            <c:forEach items="${model.audActivityList}"  var="list" varStatus="status" >
                <c:choose>
                    <c:when test="${status.count % 2 != 0}">
                        <tr id="${list.dbaction}">
                        </c:when>
                        <c:otherwise>
                        <tr id="${list.dbaction}" bgcolor="white">
                        </c:otherwise>
                    </c:choose>
                    <td>${status.count}</td>
                    <td>${list.dbaction}</td>
                    <td><a title="View Record" onClick="window.location = '#dialogViewDB-Actions'; initDialog('supplierCatalogDialog'); var category = $('#audCat').val(); $('diaglog1Title').html('Manage ${list.dbaction} On ' + category + ''); ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=d&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${list.dbaction}', 'GET');"><span style="color:white ; background-color: green" class="btn btn-xs btn-teal tooltips ">${list.audit}</span></a></td>
                    <td class="center">
                        <a title="Manage" onClick="window.location = '#dialogViewDB-Actions'; initDialog('supplierCatalogDialog'); var category = $('#audCat').val(); $('diaglog1Title').html('Manage ${list.dbaction} On ' + category + ''); ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=d&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${list.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-book"></i></a>
                        <!-- onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'activityPanel', 'act=d&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${list.dbaction}', 'GET');"-->
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</fieldset>
<div id="dialogViewDB-Actions" class="supplierCatalogDialog">
    <div>
        <div id="head" align="center">
            <a href="#close" title="Close" onClick="var cat = $('#audCat').val(); ajaxSubmitData('locations/locationsAuditor.htm', 'activityPanel', 'act=c&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=' + cat + '', 'GET');" class="close2">X</a>
            <h2 class="modalDialog-title" id="diaglog1Title">Manage Data Actions</h2>
            <hr>
        </div>
        <div class="row scrollbar" id="content" style="width:100%"></div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#auditsTable').DataTable();

        $('#viewDbAction').click(function () {
            $("diaglog1Title").append("Manage");
            window.location = '#dialogViewDB-Actions';
            initDialog('supplierCatalogDialog');
        });
    });
    function funcViewAuditLogs(dbaction) {
        var category = $('#audCat').val();
        $("diaglog1Title").append("Manage " + dbaction + " On " + category);
        ajaxSubmitData('locations/locationsAuditor.htm', 'activityPanel', 'act=d&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=' + dbaction + '', 'GET');
    }

</script>
