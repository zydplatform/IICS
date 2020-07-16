<%-- 
    Document   : registeredServices
    Created on : Jun 14, 2018, 3:59:51 PM
    Author     : IICS
--%>
<style>

    :not(td) {
        vertical-align:top;
    }
</style>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<table class="table table-hover table-bordered" id="tableregisteredServicesFound">
    <thead>
        <tr>
            <th>No</th>
            <th></th>
            <th>Status</th>
            <th>Service</th>
            <th>Schedule(24 Hr Clock)</th>
            <th>Previous Execution</th>
            <th>Details</th>
            <th>Edit | Delete</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <% int i = 1;%>
        <c:forEach items="${scheduledservices}" var="a">
            <tr style="height: 60px">
                <td><%=j++%></td>
                <td style="width: 200px; vertical-align:middle;">
                    <c:if test="${a.startondemand}">                                                    
                        <span class="alert alert-info">   
                            <input id="runmanualservicemannualid" <c:if test="${a.status==true && a.interrupted!=true}">disabled="disabled" checked=""</c:if> onclick="if ($(this).prop('checked')) {
                                        runmanualservicemannual(this.value, this.id);
                                    }" name="serviceid" value="${a.beanname}" type="checkbox"/> 
                            Manual&nbsp;&nbsp;&nbsp;&nbsp;
                        </span>
                    </c:if>
                    <c:if test="${a.startonstartup}">
                        <c:choose>
                            <c:when test="${a.interrupted ==true && a.status ==true}">
                                <span class="alert alert-info">
                                    <input id="runmanualserviceautoid" onclick="if ($(this).prop('checked')) {
                                                runmanualserviceauto(this.value, '${a.startingtimepattern}', this.id);
                                            }" name="serviceid" value="${a.beanname}" type="checkbox"/>
                                    Automatic
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="alert alert-info">
                                    <input id="runmanualserviceautoid" checked="checked" disabled="disabled" onclick="if ($(this).prop('checked')) {
                                                runmanualserviceauto(this.value, '${a.startingtimepattern}', this.id);
                                            }" name="serviceid" value="${a.beanname}" type="checkbox"/>
                                    Automatic
                                </span> 
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </td>
                <td align="center" style="vertical-align:middle;">
                    <c:if test="${a.status==null && a.interrupted!=true}">
                        <font color="red"><strong>PENDING</strong></font>
                    </c:if>
                    <c:if test="${a.status==false && a.interrupted !=true}">
                        <font color="blue"><strong>COMPLETED</strong></font>
                        <div id="fountainG_END">
                            <div id="fountainG_END_1" class="fountainG_END"></div>
                            <div id="fountainG_END_2" class="fountainG_END"></div>
                            <div id="fountainG_END_3" class="fountainG_END"></div>
                            <div id="fountainG_END_4" class="fountainG_END"></div>
                            <div id="fountainG_END_5" class="fountainG_END"></div>
                        </div>
                    </c:if>
                    <c:if test="${a.status==true && a.interrupted!=true}">
                        <font color="green"><strong>RUNNING</strong></font>
                        <div id="fountainG">
                            <div id="fountainG_1" class="fountainG"></div>
                            <div id="fountainG_2" class="fountainG"></div>
                            <div id="fountainG_3" class="fountainG"></div>
                            <div id="fountainG_4" class="fountainG"></div>
                            <div id="fountainG_5" class="fountainG"></div>
                        </div>
                    </c:if>
                    <c:if test="${a.interrupted ==true && a.status ==true}">
                        <font color="red"><strong>ABORTED</strong></font>
                        <div id="fountainG_END">
                            <div id="fountainG_END_1" class="fountainG_END"></div>
                            <div id="fountainG_END_2" class="fountainG_END"></div>
                            <div id="fountainG_END_3" class="fountainG_END"></div>
                            <div id="fountainG_END_4" class="fountainG_END"></div>
                            <div id="fountainG_END_5" class="fountainG_END"></div>
                        </div>
                    </c:if>    
                </td>
                <td>${a.servicename}</td>
                <td>${a.crondescription}</td>
                <td align="center" style="vertical-align:middle;">
                    <c:if test="${a.completed==null}">
                        <span class="alert alert-danger">NEVER</span>
                    </c:if>
                    <c:if test="${a.completed==false}">
                        <c:choose>
                            <c:when test="${a.completed==false && a.status==true && a.interrupted!=true}">
                                <span class="alert alert-success">SUCCESS</span>
                            </c:when>
                            <c:otherwise>
                                <span class="alert alert-danger">FAILED</span>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    <c:if test="${a.completed==true}">
                        <span class="alert alert-success">SUCCESS</span>
                    </c:if>
                </td>
                <td align="center" style="vertical-align: middle;">
                    <span title="Details Of This Service." class="badge badge-danger icon-custom" onclick="servicedetails('${a.servicename}', '${a.description}', '${a.crondescription}', '${a.lastruntime}', '${a.personname}');"><i class="fa fa-dedent"></i></span>
                </td>
                <td align="center" style="vertical-align: middle;">
                    <span title="Edit This Service." class="badge badge-secondary icon-custom" onclick="updateservicess(${a.serviceid}, '${a.servicename}',${a.startonstartup},${a.startondemand});"><i class="fa fa-edit"></i></span>
                    |
                    <span title="Dlete This Service." class="badge badge-danger icon-custom" onclick="deleteservices(${a.serviceid},${a.status},${a.interrupted}, '${a.beanname}');"><i class="fa fa-trash-o"></i></span>

                </td>
            </tr>

        </c:forEach>

    </tbody>
</table>
<script>
    $('#serviceMsg').fadeOut(4000);
    $('#tableregisteredServicesFound').DataTable();

    function runmanualserviceauto(beanname, startingtimepattern, id) {
        $.confirm({
            title: 'Re-Start This Service!',
            icon: 'fa fa-warning',
            content: 'Are You Sure You Want To Re-Start This Service !!',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {type: 'auto', beanname: beanname, startingtimepattern: startingtimepattern},
                            url: "schedulerservicesmanagement/runManualService.htm",
                            success: function (data, textStatus, jqXHR) {
                                $.confirm({
                                    title: 'Start This Service!',
                                    content: 'Service Re-Started Success Fully',
                                    type: 'orange',
                                    typeAnimated: true,
                                    buttons: {
                                        close: function () {

                                        }
                                    }
                                });
                            }
                        });
                    }
                },
                close: function () {
                    $('#' + id).prop('checked', false);
                }
            }
        });
    }
    function runmanualservicemannual(beanname, id) {
        $.confirm({
            title: 'Start This Service!',
            icon: 'fa fa-warning',
            content: 'Are You Sure You Want To Start This Service !!',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {type: 'mannual', beanname: beanname},
                            url: "schedulerservicesmanagement/runManualService.htm",
                            success: function (data, textStatus, jqXHR) {
                                $.confirm({
                                    title: 'Start This Service!',
                                    content: 'Service Started Success Fully',
                                    type: 'orange',
                                    typeAnimated: true,
                                    buttons: {
                                        close: function () {

                                        }
                                    }
                                });
                            }
                        });
                    }
                },
                close: function () {
                    $('#' + id).prop('checked', false);
                }
            }
        });
    }
    function deleteservices(serviceid, status, interrupted, beanname) {
        if (status === true && interrupted !== true) {
            $.confirm({
                title: 'Delete Service',
                icon: 'fa fa-warning',
                content: 'Can Not Delete Running Service',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    close: function () {
                        
                    }
                }
            });
        } else {
            $.confirm({
                title: 'Delete Service!',
                content: 'Are You Sure You Want To Delete This Service',
                type: 'red',
                icon: 'fa fa-warning',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes,Delete',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {serviceid: serviceid},
                                url: "schedulerservicesmanagement/deleteservice.htm",
                                success: function (data, textStatus, jqXHR) {
                                    ajaxSubmitData('schedulerservicesmanagement/scheduledgetupdatedservices.htm', 'getupdatedservices', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    },
                    close: function () {
                    }
                }
            });
        }
    }
    function servicedetails(servicename, description, crondescription, lastruntime, personname) {
        $.confirm({
            title: '<b>Service :</b>' + ' ' + servicename,
            content: '<div class="row"><div class="col-md-12"><div class="tile" id="getfinancialyeardatesdiv">\n\
                          <form ><div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">SERVICE DETAILS</span></div>\n\
                             <div class="form-group bs-component">\n\
                                <span class="control-label pat-form-heading patientConfirmFont" for=""><strong style="font-size: 14px; margin-left: 10px;">(1)&nbsp;Description:</strong></span>&nbsp;\n\
                                <span class="badge badge-patientinfo"><strong>' + description + '</strong></span>\n\
                              </div>\n\
                             <div class="form-group bs-component">\n\
                                <span class="control-label pat-form-heading patientConfirmFont" for=""><strong style="font-size: 14px; margin-left: 10px;">(2)&nbsp; Schedule:</strong></span>&nbsp;\n\
                                <span class="badge badge-patientinfo"><strong>' + crondescription + '</strong></span>\n\
                              </div>\n\
                           <div class="form-group bs-component">\n\
                                <span class="control-label pat-form-heading patientConfirmFont" for=""><strong style="font-size: 14px; margin-left: 10px;">(3)&nbsp; Last Execution:</strong></span>&nbsp;\n\
                                <span class="badge badge-patientinfo"><strong>' + lastruntime + '</strong></span>\n\
                              </div>\n\
                           <div class="form-group bs-component">\n\
                                <span class="control-label pat-form-heading patientConfirmFont" for=""><strong style="font-size: 14px; margin-left: 10px;">(4)&nbsp; Created By:</strong></span>&nbsp;\n\
                                <span class="badge badge-patientinfo"><strong>' + personname + '</strong></span>\n\
                              </div>\n\
                             <div class="tile-footer"></div>\n\
                            </form>\n\
                        </div></div></div>',
            type: 'red',
            boxWidth: '700px',
            useBootstrap: false,
            draggable: true,
            typeAnimated: true,
            buttons: {
                close: function () {
                }
            }
        });
    }
    function updateservicess(serviceid, servicename, startonstartup, startondemand) {
        window.location = '#updateservicedialog';
        ajaxSubmitData('schedulerservicesmanagement/updateservice.htm', 'updateservicediv', 'serviceid=' + serviceid + '&servicename=' + servicename + '&startonstartup=' + startonstartup + '&startondemand=' + startondemand + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
        initDialog('updateservicess');
    }
</script>