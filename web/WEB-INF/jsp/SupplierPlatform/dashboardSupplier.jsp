<%-- 
    Document   : dashboardSupplier
    Created on : Sep 3, 2018, 12:41:20 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<!DOCTYPE html>
<%@include file="../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html lang="en">
    <head>
        <meta name="description" content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
        <title>IICS</title>
        <meta charset="utf-8">
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <meta name="_csrf_parameter" content="${_csrf.parameterName}"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta content="" name="description" />
        <meta content="" name="author" />
        <meta name="viewport" content="width=devicewidth, minimal-ui">
        <!-- end: META -->
        <!-- start: MAIN CSS -->
        <link href="static/images/IICS.ico" rel="shortcut icon" type="image/x-icon"/>
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="static/res/css/main.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css" href="static/res/css/styles.css">
        <link rel="stylesheet" type="text/css" href="static/frontend/css/legendlayout.css">
        <link rel="stylesheet" href="static/res/css/jquery.toast.css">
        <link rel="stylesheet" href="static/res/css/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" href="static/res/css/datepicker.css">
        <link rel="stylesheet" type="text/css" href="static/res/css/mdtimepicker.css"/>
        <!--COnfirm Dialog -->
        <link rel="stylesheet" href="static/res/css/jquery-confirm/3.3.0/jquery-confirm.min.css">
        <link rel="stylesheet" href="static/res/css/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="static/resources/css/servicestatus.css">
    </head>
    <body class="app rtl pace-done" id="body" >
        <!-- Navbar-->
        <header class="app-header" id="colors">
            <a class="app-header__logo" href="#">
                ${model.supplierObj.suppliername}
                </a>
                <!-- Sidebar toggle button-->
                <a class="app-sidebar__toggle" id="toggleside" href="#" data-toggle="sidebar" data-tooltip="tooltip" data-placement="right" title="" data-original-title="Hide side menu" aria-label="Hide Sidebar"></a>
                <!-- Navbar Right Menu-->
                <ul class="app-nav">
                    <li>
                        <a class="app-header__logo" href="http://172.18.1.2:8085/UserGuide/" target="_blank" style="text-decoration: none;font-size:16px ">                                
                            &nbsp;&nbsp;<i class="fa fa-book"></i>
                            User Guide
                        </a>
                    </li>
                    <li class="dropdown"><a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Open Profile Menu"><i class="fa fa-user fa-lg"></i></a>
                        <ul class="dropdown-menu settings-menu dropdown-menu-right">
                            <li><a class="dropdown-item" href="#" id="accountsettings"><i class="fa fa-cog fa-lg" onclick="accountsettings()"></i>Account Settings</a></li>
                            <li><a class="dropdown-item" href="page-user.html"><i class="fa fa-user fa-lg"></i> Profile</a></li>
                            <li>
                                <form action="<c:url value="j_spring_security_logout" />" id="logout" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                </form>
                                <a class="dropdown-item" href="#" onClick="document.getElementById('logout').submit();"><i class="fa fa-sign-out fa-lg"></i> Logout</a>
                            </li>
                    </ul>
                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar" >
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar img-responsive" src="static/images/profile-picture-placeholder.jpg" style="height: 30%;width: 30%" alt="User Image">
                <div>
                    <p class="app-sidebar__user-name">${model.personObj.firstname}&nbsp;${model.personObj.lastname}&nbsp;${othername} </p>
                    <p class="app-sidebar__user-designation">${designationname}</p>
                </div>
            </div>
            <ul class="app-menu" align="center">
                <li>
                    <a class="app-menu__item active" href="#">
                        <i class="app-menu__icon fa fa-home"></i>
                        <span class="app-menu__label">
                            IICS-Supplier Platform
                        </span>
                    </a>
                </li>
                <li>
                    <div class="col-md-12">
                        <div class="bs-component" style="margin-top: 5%;">
                            <div class="card"  style=" border-radius: 2px">
                                <div class="card-body" id="changeUnitSession" style="background-color: #E2A9F3;">
                                    <c:if test="${not empty model.activeUnit}">
                                        <h6 class="card-title">Active Work Location</h6>
                                        <h5> <label style="color: #0B0B3B;">${model.activeUnit}</label></h5>
                                        <div style="float:right">Assigned Locations: <button href="#" id="unitSize"  style="background-color: purple; color: whitesmoke; padding: 5px;text-align: center; text-decoration: none; display: inline-block;  font-size: 12px; margin: 4px 2px; border-radius: 30%;">${model.unitSize}</button></div>
                                            <c:if test="${model.unitSize>1}">
                                            <select class="form-control" id="changeUnitSession" onChange="clearDiv('workpane'); ajaxSubmitData('changeUserLocation.htm', 'changeUnitSession', 'act=b&i=' + this.value + '&b=f&c=a&d=1', 'GET');">
                                                <option value="${model.activeUnitId}" selected="selected">${model.activeUnit}</option>
                                                <c:forEach items="${model.unitList}" var="unit">
                                                    <option value="${unit.facilityunitid}">${unit.facilityunitname}</option>
                                                </c:forEach>
                                            </select>
                                        </c:if>
                                    </c:if>
                                        <div style="float:right">
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN')">
                                                <c:if test="${sessionChanged == null}">
                                                    <button class="change-session" onclick="changeUserSession()">
                                                        Change Session
                                                    </button>
                                                </c:if>
                                                <c:if test="${sessionChanged == true}">
                                                    <button class="change-session" onclick="endUserSession('${model.facilityObj.facilityname}')">
                                                        End Session
                                                    </button>
                                                </c:if>
                                            </security:authorize>
                                        </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </aside>
        <main class="app-content">
            <div id="workpane">
                <div class="app-title">
                    <div class="col-md-5">
                        <h1>
                            <i class="fa fa-dashboard"></i>
                            Customer Order System
                        </h1>
                        <p>Together We Save Lives...!</p>
                    </div>
                    <div class="col-md-7">
                        <div class="mmmains">
                            <div class="wrapper" id="">
                                <ul class="breadcrumbs">
                                    <li class="last active"><a style="font-size: 18px !important" href="#" class="fa fa-home"></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <% int x = 0;%>
                <div class="row">
                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SUPPLIERCONTROLPANELMANAGEMENT')">   
                        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Supplier/Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                            <div class="icon-content">
                                <img src="static/img/SettingsSysIcon1.png" class="expando" border="1" width="90" height="70">
                            </div>
                            <div class="icon-content">
                                <h4>
                                    Control Panel
                                </h4>
                            </div>
                        </div>
                        <%x += 1;%>
                    </security:authorize>
                    <% if (x % 4 == 0) { %>
                </div>
                
                <div class="row"><%}%>
                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EXTERNALORDERMANAGEMENT')"> 
                        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Supplier/Store/orderManagement.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                            <div class="icon-content">
                                <img src="static/img/StoresSysIcon1.png" class="expando" border="1" width="90" height="70">
                            </div>
                            <div class="icon-content">
                                <h4>Order Processing</h4>
                            </div>
                        </div>
                        <%x += 1;%>
                    </security:authorize>
                    <% if (x % 4 == 0) { %>
                </div>
                <div class="row"><%}%>
                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SUPPLIERUSERMANAGEMENT')"> 
                        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Supplier/Usermanagement/internalAndexternal.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                            <div class="icon-content">
                                <img src="static/img/PpleSysIcon1.png" class="expando" border="1" width="90" height="70">
                            </div>
                            <div class="icon-content">
                                <h4>User management</h4>
                            </div>
                        </div>
                        <%x += 1;%>
                    </security:authorize>
                    <% if (x % 4 == 0) { %>
                </div>
                <div class="row"><%}%>
                    
                </div>
            </div>
        </div>
    </main>
    <div style="display: none;">
        <div id='blackout0'> </div>
        <div class="PopupHide" id='divpopup0'>               
            <div id='pop_content0'>
                <div align="center">
                    <img src="static/images/ajax-loader.gif" alt="[close]" width="100px" height="100px"  onclick='popup(0, 0)'>
                    <br/>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="deny" tabindex="" role="dialog" aria-labelledby="exampleModalLongTitle">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 100%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="title">Edit Credentials</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="oneU">
                        <form>
                            <div class="row" id="usenames">
                                <div class="col-md-4"></div>
                                <div class="col-md-3">
                                    <p>
                                        Username: 
                                    </p>
                                </div>
                                <div class="col-md-3">
                                    <a href="#" id="editusername" style="color: red">Edit</a>
                                </div>
                                <div class="col-md-2"></div>
                            </div>
                            <div class="row" id="passwords">
                                <div class="col-md-4"></div>
                                <div class="col-md-3">
                                    <p>
                                        Password: 
                                    </p>
                                </div>
                                <div class="col-md-3">
                                    <a href="#" id="editpassword" style="color: red">Edit</a>
                                </div>
                                <div class="col-md-2"></div>
                            </div>

                        </form>
                    </div>
                    <div id="twou" style="display: none">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Old Username</label>
                            <input class="form-control" id="ousername" type="text" aria-describedby="emailHelp" disabled="true">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">New user name</label>
                            <input class="form-control" id="nusername" type="text" aria-describedby="emailHelp" placeholder="Enter new username">
                        </div>
                        <div id="nameexists"></div>
                        <div class="row">
                            <div class="col-md-3"></div>
                            <div class="col-md-3">
                                <button class="btn btn-primary " id="previousu" style="margin-top: 4em"><i class="fa fa-arrow-left">
                                    </i>Previous
                                </button>
                            </div>
                            <div class="col-md-3">
                                <button class="btn btn-primary " id="saveusername" style="margin-top: 4em"><i class="fa fa-arrow-right">
                                    </i>submit
                                </button>
                            </div>
                            <div class="col-md-3"></div>
                        </div>
                    </div>
                    <div id="threeu" style="display: none">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Current password</label>
                            <input id="knownpass"  style="display: none">
                            <input class="form-control" id="currentpass" type="password" aria-describedby="emailHelp" placeholder="Enter current password" maxlength="10">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">New password</label>
                            <input class="form-control" id="newpass" type="password" aria-describedby="emailHelp" placeholder="Enter new password" maxlength="10">
                        </div>
                        <input id="systemuserid" value="${systemuserid}" style="display: none">
                        <div class="row">
                            <div class="col-md-3"></div>
                            <div class="col-md-3">
                                <button class="btn btn-primary " id="previousp" style="margin-top: 4em"><i class="fa fa-arrow-left">
                                    </i>Previous
                                </button>
                            </div>
                            <div class="col-md-3">
                                <button class="btn btn-primary " id="savepass" style="margin-top: 4em"><i class="fa fa-arrow-right">
                                    </i>submit
                                </button>
                            </div>
                            <div class="col-md-3"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 text-center" style="background-color: purple">
            <p style="color: white;height: 1em">
                <small class="block">&copy; <strong>IICS TECHNOLOGIES  <script type="text/javascript">
                    document.write(new Date().getFullYear());</script>.All rights reserved</strong></small>
            </p>
        </div>
    </div>
    <div class="modal fade" id="sessionTimeOut" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 100%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lg fa-fw fa-user"></i>Idle Session Alert! [Max Idle Session Time:8min]</h5>
                </div>
                <div class="modal-body">
                    <div class="row" id="btnsB4Restore">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="row">
                                    <div class="col-md-12">
                                        <form>
                                            <div class="form-group">
                                                <div class="row" id="sessionTimeOutMsg"></div>
                                            </div>
                                            <div class="form-group">
                                                <input type="hidden" id="idleScreenState" value="false"/>
                                                <input type="hidden" id="idleVal" value="1"/>
                                                <input type="hidden" id="idleScreenPopUp" value="false"/>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="tile-footer">
                                    <button class="btn btn-primary" id="restoreSession" type="button" onClick="hideDiv('btnsB4Restore'); showDiv('btnsAfterRestore');"><i class="fa fa-check-circle"></i>Restore Session</button>
                                    <button class="btn btn-secondary" id="logOutSession" type="button" onClick="document.getElementById('logout').submit();" data-dismiss="modal">Log Out</button>
                                    <button class="btn btn-primary" id="restoreSessionLogIn" type="button" disabled="disabled" onClick=""><i class="fa fa-check-circle"></i>Log In</button>     
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" id="btnsAfterRestore" style="display:none">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="row">
                                    <div class="form-group">
                                        <div id="sessTimeOutAlert"></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label" id="space2" >USER:</label>
                                        </div>
                                    </div>
                                    <div class="col-md-9" >
                                        ${model.personObj.firstname} &nbsp; ${model.personObj.lastname}
                                    </div>
                                </div>
                                <div class="row" id='restoreCredential'>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label" id="space2" >PASSWORD:</label>
                                        </div>
                                    </div>
                                    <div class="col-md-9" >
                                        <input class="form-control" autofocus id="oldusername" type="hidden" placeholder="username" value="${mode.username}">
                                        <input class="form-control" id='oldpasswrd' type="password" placeholder="Password" required size="15">
                                        <small style="display: none" class="form-text text-muted" id="errPassword"><strong><font color="red">Please Enter Password! </font></strong><i style="font-size: 15px; color: red" class="fa fa-hand-o-up"></i></small></small>
                                        <small style="display: none" class="form-text text-muted" id="errPassword2"><strong><font color="red">Invalid Password! Next Invalid Attempt Will Lead To Shut Down!</font></strong><i style="font-size: 15px; color: red" class="fa fa-hand-o-up"></i></small></small>
                                    </div>
                                </div>
                                <div class="tile-footer">
                                    <div id='btnCallTerminateSess'>
                                        <form name="form2" id="form2" method="post" action="j_spring_security_check" class='form-login'>
                                            <div>
                                                <input class="form-control" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <input class="form-control" name="j_username" id="username" type="hidden" value="">
                                                <input class="form-control" name="j_password" id='passwrd' type="hidden">
                                                <input class="form-control" id='restoreAttempts' type="hidden" value="0">
                                            </div>
                                            <div class="modal-footer">
                                                <div class="form-group btn-container">
                                                    <button class="btn btn-primary" id="restoreSession2" type="button" onClick=" 
                                                            if ($('#oldpasswrd').val() === '' || typeof $('#oldpasswrd').val() === 'undefined' || $('#oldpasswrd').val() === null) {
                                                                if ($('#oldpasswrd').val() === '' || typeof $('#oldpasswrd').val() === 'undefined' || $('#oldpasswrd').val() === null) {
                                                                    $('#oldpasswrd').css({'border': '2px solid #f50808c4'});
                                                                    $('#errPassword').show();
                                                                    return false;
                                                                }
                                                            } else {
                                                                $('#oldpasswrd').css({'border': '2px solid #ced4da'});
                                                                $('#errPassword').hide();
                                                                $('#errPassword2').hide();
                                                                var psd = md5($('#oldpasswrd').val());
                                                                $('#passwrd').val(psd);
                                                                $('#oldpasswrd').val('******');
                                                                //document.getElementById('oldpasswrd').type = 'text';
                                                                if(psd!=='${model.password}'){
                                                                    $('#errPassword').show();
                                                                    $('#errPassword2').hide();
                                                                    $('#oldpasswrd').val('');
                                                                    //Restore Attempts With Invalid Passwords!
                                                                    var attempts=(parseInt($('#restoreAttempts').val())+1);
                                                                    $('#restoreAttempts').val(attempts);
                                                                    if(attempts===2){
                                                                        $('#errPassword').hide();
                                                                        $('#errPassword2').show();
                                                                    }
                                                                    if(attempts>2){
                                                                        showDiv('btnCallEndSess');
                                                                        hideDiv('btnCallTerminateSess');
                                                                        //hideDiv('restoreCredential');
                                                                        $('#restoreCredential').html('<h2><span style=\'color:red; font-weight:strong\'>Access Denied!!</span></h2>');
                                                                    }
                                                                }else{
                                                                    $('#idleScreenState').val('false'); $('#idleScreenPopUp').val('false'); $('#sessionTimeOut').modal('hide'); $('#idleVal').val(1);
                                                                    $('#errPassword').hide();
                                                                    $('#errPassword2').hide();
                                                                    $('#restoreAttempts').val(0);
                                                                    ajaxSubmitData('logSessionTimeOut.htm', 'lockScreenResp', 'act=a&c=false', 'GET');
                                                                }
                                                            }"><i class="fa fa-check-circle"></i>Restore Session</button>     
                                                    <button class="btn btn-secondary" disabled="disabled" id="restoreSessionLogIn2" type="button" onClick=" 
                                                        if ($('#oldpasswrd').val() === '' || typeof $('#oldpasswrd').val() === 'undefined' || $('#oldpasswrd').val() === null) {
                                                                if ($('#oldpasswrd').val() === '' || typeof $('#oldpasswrd').val() === 'undefined' || $('#oldpasswrd').val() === null) {
                                                                    $('#oldpasswrd').css({'border': '2px solid #f50808c4'});
                                                                    $('#errPassword').show();
                                                                    return false;
                                                                }
                                                            } else {
                                                                $('#oldpasswrd').css({'border': '2px solid #ced4da'});
                                                                $('#errPassword').hide();
                                                                var uname = $('#oldusername').val();
                                                                var psd = $('#oldpasswrd').val();
                                                                $('#username').val(uname);
                                                                $('#passwrd').val(psd);

                                                                $('#oldpasswrd').val('******');
                                                                 //document.getElementById('oldpasswrd').type = 'text';

                                                                $('#form2 input[id=passwrd]').val(hex_md5($('#form2 input[id=passwrd]').val()));
                                                                $.post('j_spring_security_check', $('#form2').serialize(), function (data) {
                                                                    // will first fade out the loading animation
                                                                    jQuery('#status').fadeOut();
                                                                    // will fade out the whole DIV that covers the website.
                                                                    jQuery('#preloader').delay(0).fadeOut('#FastWheelSpeed');
                                                                    location.reload(true);
                                                                });
                                                            }"><i class="fa fa-sign-in fa-lg fa-fw"></i>Login
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="form-group btn-container" id='btnCallEndSess' style='display:none'>
                                        <button class="btn btn-secondary" id="logOutSession" type="button" onClick="document.getElementById('logout').submit();" data-dismiss="modal">Log Out</button>                 
                                    </div>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id='lockScreenResp'></div>
        </div>
    </div>                    
    <!-- Essential javascripts for application to work-->
    <script src="static/res/js/jquery-3.2.1.min.js"></script>
    <script src="static/res/js/popper.min.js"></script>
    <script src="static/res/js/bootstrap.min.js"></script>
    <script src="static/res/js/main.js"></script>
    <script src="static/res/js/scripts.js"></script>
    <script src="static/res/js/mdtimepicker.js"></script> 
    <!-- The javascript plugin to display page loading on top-->
    <script src="static/res/js/plugins/pace.min.js"></script>
    <!-- Page specific javascripts-->
    <script type="text/javascript" src="static/res/js/plugins/chart.js"></script>
    <script type="text/javascript" src="static/res/js/plugins/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="static/res/js/plugins/dataTables.bootstrap.min.js"></script>
    <!--Main Page CSS -->
    <script type="text/javascript" src="static/js/ajaxCalls.js"></script>
    <script type="text/javascript" src="static/js/general.js"></script>
    <script type="text/javascript" src="static/js/dhtmlwindow.js"></script>
    <script type="text/javascript" src="static/js/validationScripts.js"></script>
    <script type="text/javascript" src="static/js/expando.js"></script>
    <link rel="javascript" type="text/javascript" href="static/js/expando.js"/>
    <link rel="javascript" type="text/javascript"  href="static/js/explain.js">
    <script>zoomer();</script>
    <!--Date Picker-->
    <script type="text/javascript" src="static/res/js/plugins/bootstrap-datepicker.min.js"></script>
    <!--Sweet-Alerts-->
    <script type="text/javascript" src="static/res/js/plugins/bootstrap-notify.min.js"></script>
    <script type="text/javascript" src="static/res/js/plugins/sweetalert.min.js"></script>

    <script src="static/res/js/jstorage.js"></script>
    <script src="static/res/js/sec/md5.min.js"></script>
    <script type="text/javascript" src="static/res/js/jquery.toast.js"></script>
    <script type="text/javascript" src="static/res/js/app.js"></script>

    <script src="static/res/js/moment.min.js"></script>
    <script src="static/res/js/bootstrap-datetimepicker.min.js"></script>
    <script src="static/res/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="static/res/js/plugins/select2.min.js"></script>
    <script src="static/res/js/systemBreadcrump.js"></script>
    <!--Date Picker & Breaad Crumbs-->
    <script src="static/res/js/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
    <script src="static/res/js/plugins/select2.min.js"></script>
    <script type="text/javascript" src="static/res/js/jquery-input-mask-phone-number.js"></script>
    <script src="static/res/js/cron-generate/cronGen.js"></script>
</body>
</html>
<script>

                    if (${accessrightsnumber} === 0) {
                        $.confirm({
                            title: 'Alert',
                            content: 'No assigned access right(S),Please contact your system admin',
                            type: 'red',
                            typeAnimated: true,
                            buttons: {close: function () {
                                    window.location.href = "<c:url value="j_spring_security_logout" />";
                                }
                            }
                        });
                    }

                    function showNotification(title, message, type, div) {
                        $.notify({
                            // options
                            icon: 'fa fa-check',
                            title: title,
                            message: message,
                            target: '_blank'
                        }, {
                            // settings
                            element: '#' + div,
                            position: null,
                            type: type,
                            allow_dismiss: true,
                            showProgressbar: false,
                            placement: {
                                from: 'bottom',
                                align: 'center'
                            },
                            offset: 20,
                            spacing: 10,
                            z_index: 1031,
                            delay: 5000,
                            timer: 1000,
                            url_target: '_blank',
                            mouse_over: null,
                            animate: {
                                enter: 'animated fadeInDown',
                                exit: 'animated fadeOutUp'
                            },
                            icon_type: 'class',
                            template: '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert">' +
                                    '<button type="button" aria-hidden="true" class="close" data-notify="dismiss">?</button>' +
                                    '<span data-notify="icon"></span> ' +
                                    '<span data-notify="title">{1}</span> ' +
                                    '<span data-notify="message">{2}</span>' +
                                    '<div class="progress" data-notify="progressbar">' +
                                    '<div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>' +
                                    '</div>' +
                                    '<a href="{3}" target="{4}" data-notify="url"></a>' +
                                    '</div>'
                        });
                    }
                    window.close(function () {
                        window.location.href = "<c:url value="j_spring_security_logout" />";
                    });

</script> 
<script>
    $("#accountsettings").click(function () {
        $('#deny').modal('show');
    });
    $("#previous").click(function () {
        $('#testdata').html('');
        $('#answerqns').hide();
        $('#heading').hide();
        $('#qns').show();
        $('#current').show();
    });
    $("#editusername").click(function () {
        $('#oneU').hide();
        $('#twou').show();
    });

    $("#editpassword").click(function () {
        $('#oneU').hide();
        $('#threeu').show();
    });

    $("#previousu").click(function () {
        $('#twou').hide();
        $('#oneU').show();
    });
    $("#previousp").click(function () {
        $('#threeu').hide();
        $('#oneU').show();
    });
    $("#savepass").click(function () {
        var systemuserid = $('#systemuserid').val();
        var currentpass = $('#currentpass').val();
        var currenthass = md5(currentpass);
        var knownpass = $('#knownpass').val();
        var newpass = $('#newpass').val();
        var hash = md5(newpass);
        if (knownpass === hash) {
            $.alert("There are no changes made to your password,Please enter a different password and resubmit!!");
        } else {

        }
        if (newpass === '') {
            document.getElementById('newpass').style.borderColor = "red";
        } else {

        }
        if (currentpass === '') {
            document.getElementById('currentpass').style.borderColor = "red";
        } else {

        }
        if (currentpass !== '' && newpass !== '' && hash !== currenthass && currenthass === knownpass) {
            $.ajax({
                type: 'POST',
                data: {systemuserid: systemuserid, hash: hash},
                url: "editpassword.htm",
                success: function (data, textStatus, jqXHR) {
                    $.notify({
                        title: "Update Complete : ",
                        message: "Your password has been changed!!",
                        icon: 'fa fa-check'
                    }, {
                        type: "info"
                    });
                }
            });
            $('#threeu').hide();
            $('#oneU').show();
        } else {

        }
    });
    $("#saveusername").click(function () {
        var systemuserid = $('#systemuserid').val();
        var nusername = $('#nusername').val();
        if (nusername === '') {
            document.getElementById('nusername').style.borderColor = "red";
        } else {
            $.ajax({
                type: 'POST',
                data: {systemuserid: systemuserid, nusername: nusername},
                url: "editusername.htm",
                success: function (data, textStatus, jqXHR) {
                    $.notify({
                        title: "Update Complete : ",
                        message: "Your username has been changed!!",
                        icon: 'fa fa-check'
                    }, {
                        type: "info"
                    });
                }
            });
            $('#twou').hide();
            $('#oneU').show();
        }
    });
    $('#nusername').on('input', function () {
        document.getElementById('saveusername').disabled = true;
        document.getElementById('nusername').style.borderColor = "green";
        var inputname = $('#nusername').val();
        $.ajax({
            type: 'POST',
            data: {searchValue: inputname, type: 'username'},
            url: "searchusername.htm",
            success: function (data, textStatus, jqXHR) {
                if (data === 'notexisting') {
                    $('#nameexists').html('');
                    document.getElementById('saveusername').disabled = false;
                } else {
                    $('#nameexists').html('<small><span style="color:red;">' + inputname + ' Already Exists,try another user name</span></small>');
                }
            }
        });
    });
    $(document).ready(function () {
        <c:if test="${not empty model.lockScreenState}">
            if(${model.lockScreenState}===true){
                $('#restoreSession').prop('disabled', true);
                hideDiv('btnsB4Restore'); showDiv('btnsAfterRestore');
                $('#sessionTimeOut').modal('show');
                //$('#idleScreenState').val('true');
                //$('#idleScreenPopUp').val('true');

                showDiv('btnCallEndSess');
                hideDiv('btnCallTerminateSess');
                $('#restoreCredential').html('<h2><span style=\'color:red; font-weight:strong\'>Access Denied! Previous Action Was Not Completed!</span></h2>');
            }
            else{
                $('#restoreSession').prop('disabled', false);
                showDiv('btnsB4Restore'); hideDiv('btnsAfterRestore');
            }
        </c:if>
        var systemuserid = $('#systemuserid').val();
        $.ajax({
            type: 'POST',
            data: {systemuserid: systemuserid},
            url: "getusername.htm",
            success: function (data) {
                var response = JSON.parse(data);
                for (index in response) {
                    var result = response[index];
                    document.getElementById('ousername').value = result["username"];
                    document.getElementById('knownpass').value = result["password"];
                }
            }
        });
    });

    $('#newpass').on('input', function () {
        document.getElementById('newpass').style.borderColor = "green";
    });
    $('#currentpass').on('input', function () {
        document.getElementById('currentpass').style.borderColor = "green";
    });
    $(document).on('shown.bs.modal', function (e) {
        $('[autofocus]', e.target).focus();
    });

    function changeUserSession() {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Switch Active Location.',
            content: '<div id="searchDiv" class="center">' +
                    '<div id="search-form_3">' +
                    '<input id="facilitySearch" type="text" placeholder="Search Facility" class="search_3">' +
                    '</div></div>' +
                    '<div id="searchResults"></div>',
            type: 'purple',
            typeAnimated: true,
            boxWidth: '40%',
            useBootstrap: false,
            buttons: {
                close: {
                    text: 'Close',
                    action: function () {

                    }
                }
            },
            onContentReady: function () {
                var searchResults = this.$content.find('#searchResults');
                var facilitySearch = this.$content.find('#facilitySearch');
                facilitySearch.on('input', function () {
                    var searchValue = facilitySearch.val();
                    if ((searchValue.toString()).length > 0) {
                        $.ajax({
                            type: 'GET',
                            data: {searchvalue: searchValue},
                            url: 'switchLocations/searchFacility.htm',
                            success: function (res) {
                                searchResults.html(res);
                            }
                        });
                    } else {
                        searchResults.html('');
                    }
                });
            }
        });
    }

    function endUserSession(currentFacility) {
        $.confirm({
            title: '<h3 class="itemTitle">End Active Session.</h3>',
            content: '<h4 class="itemTitle">You will be logged out of ' + currentFacility + '.</h4>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'End Session',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            url: 'switchLocations/endUserSession.htm',
                            success: function (res) {
                                document.location.reload(true);
                            }
                        });
                    }
                },
                close: {
                    text: 'Cancel',
                    btnClass: 'btn-red',
                    action: function () {

                    }
                }
            }
        });
    }
    $(window).click(function (event) {
        var id = event.target.id;
        if (!(id === 'toggleside')) {
            $('#body').addClass('pace-done');
            $('#body').addClass('sidenav-toggled');
        }
    });
    function idleLogout() {
        var t;
        var expire=8;
        window.onload = resetTimer;
        window.onmousemove = resetTimer;
        window.onmousedown = resetTimer;  // catches touchscreen presses as well      
        window.ontouchstart = resetTimer; // catches touchscreen swipes as well 
        window.onclick = resetTimer;      // catches touchpad clicks as well
        window.onkeypress = resetTimer;   
        window.addEventListener('scroll', resetTimer, true); // improved; see comments

        function yourFunction() {
            // your function for too long inactivity goes here
            // e.g. window.location.href = 'logout.php';
            var checkState=$('#idleScreenState').val();
            var mins = parseInt($('#idleVal').val());
            if(checkState==='false'){
                $('#sessionTimeOut').modal('show');
                $("#sessionTimeOutMsg").html("System Detected That Your Current Page Has Been Idle For "+mins+" Minute"); 
                $("#sessTimeOutAlert").html("Idle Time: "+mins+" Minute");
                $('#idleScreenState').val('true');
                $('#idleScreenPopUp').val('true');
                ajaxSubmitData('logSessionTimeOut.htm', 'lockScreenResp', 'act=a&c=true', 'GET');
            }else{
                mins++;
                $('#idleVal').val(mins);
                $("#sessionTimeOutMsg").html("System Detected That Your Current Page Has Been Idle For "+mins+" Minutes");
                $("#sessTimeOutAlert").html("Idle Time: "+mins+" Minutes");
                //if(mins<expire){
                //    $("#sessionTimeOutMsg").html("System Detected That Your Current Page Has Been Idle For "+mins+" Minute");
                //}else{
                //    $("#sessionTimeOutMsg").html("System Detected That Your Current Page Has Been Idle For "+mins+" Minute. \n\
                //        <br> \n\
                //        <h1><span style='color:red; font-weight:strong'>Your Session Has Expired!!</span></h1>");
                //}
            }
        }

        function resetTimer() {
            clearTimeout(t);
            var mins = parseInt($('#idleVal').val());
            //t = setTimeout(yourFunction, 10000);  // time is in milliseconds
            t = setInterval(yourFunction, 60000 * 30); // 30 minute
            //console.log('Called Set Interval! Minutes:'+mins+" t:"+t);
            if(mins>=(parseInt(expire))){
                //window.location.reload();
                //console.log('Call Reload Page By Now'+mins+" t:"+t);
                $('#idleScreenState').val('false'); 
                $('#idleScreenPopUp').val('false'); 
                //$('#idleVal').val(1);
                $("#sessionTimeOutMsg").html("System Has Terminated Your Session After "+mins+" Mins . \n\
                                    <br> \n\
                                    <h1><span style='color:red; font-weight:strong'>Auto Log Out Will Follow In 2 Minutes Time!!</span></h1>");
                                    
                $('#restoreSession').prop('disabled', true);
                $('#logOutSession').prop('disabled', false);
                $('#restoreSessionLogIn').prop('disabled', true);
                $("#sessTimeOutAlert").html("<h2><span style='color:red; font-weight:strong'>Time Out! Your Session Has Expired!!</span></h2>");
                if(mins>(parseInt(expire)+2)){
                    document.getElementById('logout').submit();
                    window.location.reload();
                }
            }else{
                var idlePopUp=$('#idleScreenPopUp').val();
                if(idlePopUp==='false'){
                    $('#idleVal').val(1);
                }else{
                    if((mins+1)>=(parseInt(expire))){
                        $.ajax({
                            type: 'GET',
                            url: 'checkSessionState.htm',
                            data: {},
                            success: function (res) {
                                //alert('res:'+res);
                                if (res === 'Active') {
                                    //Session Still Active
                                    //console.log('User Session Still Active:'+mins+" t:"+t);
                                    $('#restoreSession').prop('disabled', false);
                                    $('#logOutSession').prop('disabled', false);
                                    $('#restoreSessionLogIn').prop('disabled', true);
                                }else{
                                    //Spring Session Expired
                                    console.log('User Session Expired!!!:'+mins+" t:"+t);
                                    $("#sessionTimeOutMsg").html("System Detected That You Have Been Idle For Too Long ("+mins+" Mins) . \n\
                                        <br> \n\
                                        <h1><span style='color:red; font-weight:strong'>Your Session Has Expired!!</span></h1>");
                                    // Deactivate ReStore Session Btn
                                    $('#restoreSession').prop('disabled', true);
                                    $('#logOutSession').prop('disabled', true);
                                    $('#restoreSessionLogIn').prop('disabled', false);
                                    $("#sessTimeOutAlert").html("<h2><span style='color:red; font-weight:strong'>Time Out! Your Session Has Expired!!</span></h2>");
                                }
                            }
                        });
                    }//---
                }
            }
        }
    }
    idleLogout();
</script>