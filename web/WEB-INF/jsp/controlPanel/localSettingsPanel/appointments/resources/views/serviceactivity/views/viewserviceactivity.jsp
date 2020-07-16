<%-- 
    Document   : viewserviceactivity
    Created on : May 15, 2018, 12:14:53 PM
    Author     : RESEARCH
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row" id="">
    <div class="col-md-12" id="contentminex">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6" id="enterFac">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Current Facility:</label>
                        <b>${model.FacilityListZ.facilityname}</b>
                        <input class="form-control" id="facilityid" type="hidden" value="${model.FacilityListZ.facilityid}">
                        <input class="form-control" id="facilityname" type="hidden" value="${model.FacilityListZ.facilityname}">
                    </div>
                </div>
                <div class="col-md-6">
                    <button class="btn btn-primary pull-right" type="button"  id="addserviceact"  href="#" style="float: right"><i class="fa fa-plus fa-fw fa-lg fa-check-circle"></i>Add Service Activity</button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered" id="serviceactivitytable">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Service Activity Name</th>
                                    <th>Service Activity Duration(In Minutes)</th>
                                    <th>About Service Activity</th>
                                    <th>Service Type Status</th>
                                    <th>Manage Service Type</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int p = 1;%>
                                <% int vc = 1;%>
                                <% int t = 1;%>
                                <c:forEach items="${model.serviceactivityListView}" var="ac">
                                    <tr id="${ac.servicetypeid}">
                                        <td><%=p++%></td>
                                        <td>${ac.name}</td>
                                        <td>${ac.duration}</td>
                                        <td>${ac.description}</td>
                                        <c:if test="${ac.isactive == true}">
                                            <td align="center">
                                                <label class="switch">
                                                    <input type="checkbox"  class="sliderxz" data-servicetypeid="${ac.servicetypeid}" data-name="${ac.name}" value="true" onclick="sliderTB($(this).attr('data-servicetypeid'), $(this).attr('data-name'), $(this).val())" checked>
                                                    <span class="slider round"></span>
                                                </label>
                                            </td>
                                        </c:if>
                                        <c:if test="${ac.isactive == false}">
                                            <td align="center">
                                                <label class="switch">
                                                    <input type="checkbox"  class="sliderxz2" data-servicetypeid="${ac.servicetypeid}" data-name="${ac.name}" id="ad<%=vc++%>" value="false" onclick="sliderFB($(this).attr('data-servicetypeid'), $(this).attr('data-name'), $(this).val());" >
                                                    <span class="slider round"></span>
                                                </label>
                                            </td>
                                        </c:if>
                                        <td align="center">
                                            <div style="float:center">
                                                <button href="#" class="btn btn-xs btn-teal tooltips editDomainLevels" onclick="editservicetype(this.id);" id="utext<%=t++%>" style="background-color: white; color: purple " data-placement="top" data-original-title="Edit/Update"><i class="fa fa-lg fa-edit">Edit</i></button>
                                            </div>
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

    <!-- ADD NEW SERVICE ACTIVITY -->
    <div class="modal fade col-md-12" id="addServiceActivity" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 153%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Add New Service Activity</h5>
                    <span aria-hidden="true" data-dismiss="modal" aria-label="Close" class="close">&times;</span>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <%@include file="../forms/addserviceactivity.jsp" %>
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <button id="saveServiceActivity" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save Service Activity</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseFacilityOwner" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
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

    <!-- UPDATE SERVICE ACTIVITY -->
    <div class="modal fade col-md-12" id="updateServiceActivity" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 153%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Update Service Activity</h5>
                    <span aria-hidden="true" data-dismiss="modal" aria-label="Close" class="close">&times;</span>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <%@include file="../forms/updateservicetype.jsp" %>
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <button id="editserviceactivity" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save Service Activity</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseFacilityOwner" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
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
</div>
<script>
    $('#serviceactivitytable').DataTable();

    $('#addserviceact').click(function () {
        $('#addServiceActivity').modal('show');
    });

    //UPDATE SERVICE ACTIVITY
    function editservicetype(value) {
        var tableData = $('#' + value).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + value).closest('tr').attr('id');

        $('#editactid').val(tablerowid);
        $('#editactname').val(tableData[1]);
        $('#editactduration').val(tableData[2]);
        $('#editactdescription').val(tableData[3]);

        $('#updateServiceActivity').modal('show');
    }

    //SAVING SERVICE TYPE
    $('#saveServiceActivity').click(function () {
        $.confirm({
            title: 'Message!',
            content: 'Save A Service Type?',
            type: 'green',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        var facilityid = $('#facilityid').val();
                        var serviceactname = $('#serviceactname').val();
                        var duration = $('#duration').val();
                        var description = $('#description').val();

                        console.log("==========serviceactname" + serviceactname);
                        console.log("==========duration" + duration);
                        console.log("==========description" + description);
                        console.log("==========facilityid" + facilityid);

                        $.ajax({
                            type: "POST",
                            data: {serviceactname: serviceactname, duration: duration, description: description, facilityid: facilityid},
                            dataType: 'text',
                            url: "Appointmentresources/saveserviceactivity.htm",
                            success: function (response) {

                                document.getElementById('serviceactname').value = "";
                                document.getElementById('duration').value = "";
                                document.getElementById('description').value = "";

                                ajaxSubmitData('Appointmentresources/serviceActivities.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                cancel: function () {
                    document.getElementById('serviceactname').value = "";
                    document.getElementById('duration').value = "";
                    document.getElementById('description').value = "";

                    ajaxSubmitData('Appointmentresources/serviceActivities.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            }
        });
    });

    function sliderTB(typeid, name, valuex) {
        var namez = name.bold();
        if (valuex === 'true') {
            var stypestatus = 'false';//manageshelvingtab
            $.confirm({
                title: 'Message!',
                content: 'Your about to Deactivate' + ' ' + namez,
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {status: stypestatus, servicetypeid: typeid},
                                url: "Appointmentresources/activateDeactivateservicetype.htm",
                                success: function (data) {}
                            });
                            $('.sliderxz').val("false");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('Appointmentresources/serviceActivities.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        } else if (valuex === 'false') {
            var stypestatus = 'true';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Activate' + ' ' + namez,
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {status: stypestatus, servicetypeid: typeid},
                                url: "Appointmentresources/activateDeactivateservicetype.htm",
                                success: function (data) {}
                            });
                            $('.sliderzx').val("true");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('Appointmentresources/serviceActivities.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });

        }
    }
    function sliderFB(typeid, name, valuex) {
        var namez = name.bold();
        if (valuex === 'false') {
            var stypestatus = (valuex === 'false');
            $.confirm({
                title: 'Message!',
                content: 'Your about to Activate' + ' ' + namez,
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {status: stypestatus, servicetypeid: parseInt(typeid)},
                                url: "Appointmentresources/activateDeactivateservicetype.htm",
                                success: function (data) {}
                            });
                            $('.sliderxz2').val("true");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('Appointmentresources/serviceActivities.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        } else if (valuex === 'true') {
            var stypestatus = (valuex === 'true');
            $.confirm({
                title: 'Message!',
                content: 'Your about to Deactivate' + ' ' + namez,
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {status: stypestatus, servicetypeid: parseInt(typeid)},
                                url: "Appointmentresources/activateDeactivateservicetype.htm",
                                success: function (data) {}
                            });
                            $('.sliderxz2').val("false");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('Appointmentresources/serviceActivities.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        }
    }
</script>