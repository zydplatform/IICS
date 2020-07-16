<%-- 
    Document   : facilityHome
    Created on : Jul 17, 2018, 5:51:34 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">
    <div class="col-md-12">
        <button onclick="addfacilityaccessRights();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Release Facility Rights</button>
    </div>
</div><br>
<div style="">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered" id="assignedfacilityaccessrights">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Facility Name</th>
                                    <th>Active Component(s)</th>
                                    <th>Recalled Component(s)</th>
                                </tr>
                            </thead>
                            <tbody >
                                <% int j = 1;%>
                                <% int p = 1;%>
                                <% int k = 1;%>
                                <c:forEach items="${facilityFound}" var="a">
                                    <tr>
                                        <td><%=j++%></td>
                                        <td>${a.facilityname}</td> 
                                        <td align="center">
                                            <button type="button" class="btn btn-primary btn-sm" onclick="viewReleaseFacilityComponent(${a.facilityid},'${a.facilityname}');">
                                                <i class="fa fa-dedent">
                                                    <span class="badge badge-light">${a.componentscount}</span>
                                                    Component(s)
                                                </i>
                                            </button>
                                        </td>
                                        <td align="center">
                                            <button type="button" class="btn btn-primary btn-sm" onclick="viewrecalledFacilityComponents(${a.facilityid});">
                                                <i class="fa fa-dedent">
                                                    <span class="badge badge-light" id="recalledFacilityComponentsnumbers${a.facilityid}">0</span>
                                                    Component(s) &nbsp; <i class="fa fa-spinner fa-spin" id="recalledFacilityComponentsIcons${a.facilityid}"></i>
                                                </i>
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
    </fieldset>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="releasefacilityaccessrighhts" class="supplierCatalogDialog releasefacilityaccessrighht">
            <div>
                <div id="head">
                    <a href="#close" title="Close" onclick="ajaxSubmitDataNoLoader('activitiesandaccessrights/assignedfacilityaccessrights.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"  class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleoralreadyheading">Release Facility Rights</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="releasefacilityaccessrighhtdiv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Getting Items Please Wait...........</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="viewreleasefacilityaccessrighhts" class="supplierCatalogDialog viewreleasefacilityaccessrighht">
            <div>
                <div id="head">
                    <a href="#close" title="Close" onclick="ajaxSubmitDataNoLoader('activitiesandaccessrights/assignedfacilityaccessrights.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleoralreadyFacilityssheading">Released Facility Rights</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="viewreleasefacilityaccessrighhtdiv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Getting Items Please Wait...........</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    $(document).ready(function () {
        var responses = JSON.parse('${systemfacilitypriv}');
        for (index in responses) {
            var reslt = responses[index];
            $.ajax({
                type: 'POST',
                data: {facilityid: reslt["facilityid"]},
                url: "activitiesandaccessrights/viewrecalledfacilityscomponents.htm",
                success: function (data, textStatus, jqXHR) {
                    var sub = JSON.parse(data);
                    for (k in sub) {
                        var subs = sub[k];
                        document.getElementById('recalledFacilityComponentsnumbers' + subs["facilityid"]).innerHTML = subs["facilityunassignprivcomp"];
                        document.getElementById('recalledFacilityComponentsIcons' + subs["facilityid"]).style.display = 'none';
                    }
                }
            });
        }
    });

    $('#assignedfacilityaccessrights').DataTable();
    function addfacilityaccessRights() {
        $.ajax({
            type: 'GET',
            url: "activitiesandaccessrights/unreleasefacility.htm",
            data: {data: 'rights'},
            success: function (data, textStatus, jqXHR) {
                window.location = '#releasefacilityaccessrighhts';
                $('#releasefacilityaccessrighhtdiv').html(data);
                initDialog('releasefacilityaccessrighht');
            }
        });
    }
    function viewReleaseFacilityComponent(facilityid,facilityname) {
        $.ajax({
            type: 'GET',
            data: {facilityid: facilityid},
            url: "activitiesandaccessrights/viewReleaseFacilityComponent.htm",
            success: function (data, textStatus, jqXHR) {
                window.location = '#viewreleasefacilityaccessrighhts';
                $('#viewreleasefacilityaccessrighhtdiv').html(data);
                document.getElementById('titleoralreadyFacilityssheading').innerHTML='<b>'+facilityname+' </b>:'+'Released & Un Released Rights.';
                initDialog('viewreleasefacilityaccessrighht');
            }
        });
    }
    function viewrecalledFacilityComponents(facilityid) {
        $.ajax({
            type: 'POST',
            data: {facilityid: facilityid},
            url: "activitiesandaccessrights/viewrecalledfacilityscomponents.htm",
            success: function (data, textStatus, jqXHR) {

            }
        });
    }
</script>