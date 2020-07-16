<%-- 
    Document   : schedulespane
    Created on : May 15, 2018, 11:27:16 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div>
    <div class="container-fluid">
        <div class="app-title" id="">
            <div class="col-md-5">
                <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
                <p>Together We Save Lives...!</p>
            </div>
            <div class="mmmains">
                <div class="wrapper">
                    <ul class="breadcrumbs">
                        <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Local Setting</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('localsettigs/manage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Manage</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('appointmentandSchedules/appointmentsPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Appointments Pane</a></li>                    
                        <li class="last active"><a href="#">Schedules</a></li>
                    </ul>
                </div>
            </div>
        </div>
            <main  class="col-md-12 col-sm-12">
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_ACTIVEAPPOINTMENTSCHEDULESTAB')"> 
                <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                <label class="tabLabels" for="tab1">Active Schedules</label>
                 </security:authorize>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PAUSEDAPPOINTMENTSCHEDULESTAB')"> 
               <input id="tab2" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab2">Paused Schedules</label>
                 </security:authorize>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_APPOINTMENTSCHEDULESHISTORYTAB')"> 
                <input id="tab3" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab3">Schedule History</label>
                </security:authorize>
                
                <section class="tabContent" id="content1">
                    <div>
                        <div class="col-md-12">
                            <div class="btn-group pull-right">
                                <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-plus-circle"></i>&nbsp;Create Schedule(s)
                                </button>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item btn btn-secondary" id="createschedulebtn">
                                        Single Scheduling
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item btn btn-secondary" id="createBatchschedulebtn">
                                        Batch Scheduling
                                    </a>
                                </div>
                            </div>
                        </div>                               
                    </div>
                    <div id="activeContentdisplay">
                        <%@include file="views/active/activeschedulesDisplay.jsp" %>
                    </div>
                </section>
                <section class="tabContent" id="content2">
                    <div id="pausedContentdisplay">
                        <p>Loading Content please wait.....................</p>
                    </div>
                </section>
                <section class="tabContent" id="content3">
                    <div id="expiredContentdisplay">
                        <p>Loading Content please wait.....................</p>
                    </div>
                </section>
            </main>      
            <!------SINGLE SCHEDULING SECTION----------->
            <div class="row">
                <div class="col-md-12">
                    <div id="createschedulesx" class="manageCellDialog">
                        <div>
                            <div id="head">
                                <a href="#close" title="Close" class="close2">X</a>
                                <h2 class="modalDialog-title">Create New Schedule</h2>
                                <hr>
                            </div>
                            <div class="row scrollbar" id="content">
                                <div class="col-md-12">                        
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="tile">
                                                <div class="tile-body">
                                                    <div id="self"> </div>
                                                    <div id="other" class="hidedisplaycontent">other</div>
                                                    <div id="services" class="hidedisplaycontent">services</div>
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
        <!------BATCH SCHEDULING SECTION----------->
        <div class="row">
            <div class="col-md-12">
                <div id="createbatchschedulesx" class="manageCellDialog">
                    <div>
                        <div id="head">
                            <a href="#close" title="Close" class="close2">X</a>
                            <h2 class="modalDialog-title">Create New Batch Schedule</h2>
                            <hr>
                        </div>
                        <div class="row scrollbar" id="content">
                            <div class="col-md-12">                        
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="tile">
                                            <div class="tile-body">
                                                <div id="vv">
                                                    <button class="btn btn-primary btn-sm" onclick="generateBatchSchedule()"><i class="fa fa-plus-circle"></i>&nbsp;Generate Schedule</button>
                                                    <div id="showresults">Under Implemetation</div>
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
</div>
<script>
    breadCrumb();
    $(document).ready(function () {
        $('#tab1').change(function () {
            ajaxSubmitData('appointmentandSchedules/activeuserschedules.htm', 'activeContentdisplay', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        });
        $('#tab2').change(function () {
            ajaxSubmitData('appointmentandSchedules/pauseduserschedules.htm', 'pausedContentdisplay', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        });
        $('#tab3').change(function () {
            ajaxSubmitData('appointmentandSchedules/expireduserschedules.htm', 'expiredContentdisplay', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        });
        $('#createschedulebtn').click(function () {
            $.confirm({
                title: 'Create Schedule',
                content: '',
                icon: 'fa fa-lg fa-list',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    self: {
                        text: 'Self',
                        btnClass: 'btn-success',
                        action: function () {
                            $('#services').hide();
                            $('#other').hide();
                            $('#self').show();
                            window.location = '#createschedulesx';
                            initDialog('manageCellDialog');
                            ajaxSubmitData('appointmentandSchedules/createstaffSchedule.htm', 'self', 'selectedid=1 &act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    },
                    other: {
                        text: 'For Other',
                        btnClass: 'btn-primary',
                        action: function () {
                            $('#self').hide();
                            $('#services').hide();
                            $('#other').show();
                            window.location = '#createschedulesx';
                            initDialog('manageCellDialog');
                            ajaxSubmitData('appointmentandSchedules/createstaffSchedule.htm', 'other', 'selectedid=2 &act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    },
                    service: {
                        text: 'Service',
                        btnClass: 'btn-secondary',
                        action: function () {
                            $('#self').hide();
                            $('#other').hide();
                            $('#services').show();
                            window.location = '#createschedulesx';
                            initDialog('manageCellDialog');
                            ajaxSubmitData('appointmentandSchedules/createstaffSchedule.htm', 'services', 'selectedid=3 &act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    },
                    close: function () {
                    }
                }
            });

        });
        $('#createBatchschedulebtn').click(function () {
            window.location = '#createbatchschedulesx';
            initDialog('manageCellDialog');
        });
    });
    function generateBatchSchedule() {
        $.ajax({
            type: 'POST',
            dataType: 'text',
            data: '',
            url: "appointmentandSchedules/createbatchSchedule.htm",
            success: function (data, textStatus, jqXHR) {
                // alert(data);
            }
        });
    }
</script>