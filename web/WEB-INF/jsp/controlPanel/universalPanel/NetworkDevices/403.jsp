<%-- 
    Document   : mainpane
    Created on : May 30, 2018, 8:05:32 AM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html lang="en">
    <head>
        <meta name="description" content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
<!--        <title>IICS</title>-->
        <title>IICS-HMIS</title>
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
        <!-- end: META -->
        <!-- start: MAIN CSS -->
        <link href="static/images/IICS.ico" rel="shortcut icon" type="image/x-icon"/>
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="static/res/css/main.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="static/res/css/styles.css">
        <link rel="stylesheet" type="text/css" href="static/frontend/css/legendlayout.css">
        <link rel="stylesheet" href="static/res/css/jquery.toast.css">
        <link rel="stylesheet" href="static/res/css/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" href="static/res/css/datepicker.css">
        <link rel="stylesheet" type="text/css" href="static/res/css/mdtimepicker.css"/>
        <!--COnfirm Dialog -->
        <link rel="stylesheet" href="static/res/css/jquery-confirm/3.3.0/jquery-confirm.min.css">

    </head>
    <body class="app sidebar-mini rtl" style="background-color:white">
        <!-- Navbar-->
        <header class="app-header" id="colors">
            <a class="app-header__logo" href="#"><c:if test="${not empty model.userFacObj}">${model.userFacObj.facilityname}></c:if>${model.facilityObj.facilityname}</a>
                <!-- Sidebar toggle button-->
                <a class="app-sidebar__toggle" id="toggleside" href="#" data-toggle="sidebar" data-tooltip="tooltip" data-placement="right" title="" data-original-title="Hide side menu" aria-label="Hide Sidebar" ></a>
                <!-- Navbar Right Menu-->
                <ul class="app-nav">
                    <li class="app-search">
                        <input class="app-search__input" type="search" placeholder="Search">
                        <button class="app-search__button">
                            <i class="fa fa-search"></i>
                        </button>
                    </li>

                    <li>
                        <a class="app-header__logo" href="#" style="text-decoration: none;font-size:16px">                                
                            &nbsp;&nbsp;<i class="fa fa-question"></i>
                            F1 for help</a>
                    </li>
                    <li class="dropdown"><a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Open Profile Menu"><i class="fa fa-user fa-lg"></i></a>
                        <ul class="dropdown-menu settings-menu dropdown-menu-right">
                            <li><a class="dropdown-item" href="<c:url value="j_spring_security_logout" />" ><i class="fa fa-arrow-right fa-lg"></i> &nbsp;Log Out</a></li>
                    </ul>
                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar" >
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/48.jpg" alt="User Image">
                <div>
                    <p class="app-sidebar__user-name">${model.personObj.firstname}&nbsp;${model.personObj.lastname} </p>
                    <p class="app-sidebar__user-designation">Software Developer</p>

                </div>
            </div>
            <ul class="app-menu">
                <li>
                    <a class="app-menu__item active" href="#">
                        <i class="app-menu__icon fa fa-home"></i>
                        <span class="app-menu__label">
                            DEVICE ACCESS CHECK 
                        </span>
                    </a>
                </li>
                <li>
                    <div class="col-md-12">
                        <div class="bs-component" style="margin-top: 5%;">
                            <div class="card"  style=" border-radius: 2px">
                                <div class="card-body" id="changeUnitSession">

                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>

        </aside>
        <main class="app-content" id="mmmain1">
            <div class="container" id="workPane">
                <h1>HTTP Status 403 - Access is denied</h1><br>
                <h3>
                    Your ${model.deviceType} Is Not Granted Access To The IICS System.
                    <br><br>

                    <div class="row">
                        <div class="col-md-12">
                            <!-- start: FORM VALIDATION 1 PANEL -->
                            <div class="panel panel-default">
                                <div class="panel-heading"></div>
                                <div class="panel-body" id="response-pane">
                                    <c:if test="${model.sentRequest==false}">
                                        <fieldset>
                                            <legend>Enter Device Details</legend>
                                            <form name="submitData" id="submitData" class="form-horizontal">
                                                <div class="row">
                                                    <div class="panel-body">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5 control-label" for="manufacturer">Your Device Manufacturer:<span class="symbol required"></label>
                                                            <div class="col-sm-5">
                                                                <select class="form-control" id="manufacturer" name="manufacturer">
                                                                    <option value="0">--Select Manufacturer--</option>
                                                                    <c:forEach items="${model.manuListArr}" var="m">
                                                                        <option value="${m[0]}">${m[1]}</option>
                                                                    </c:forEach>
                                                                </select>
                                                                <input type="hidden" id='logId' name='logId' value='${model.devObj.computerloghistory.computerloghistoryid}'/>
                                                            </div>
                                                            <label class="col-sm-5 control-label" for="condition">Your Device Condition:<span class="symbol required"></label>
                                                            <div class="col-sm-5">
                                                                <select class="form-control" id="cond" name="cond">
                                                                    <option value="0">--Select Condition--</option>
                                                                    <option value="Good Condition">Good Condition</option>
                                                                    <option value="Very Slow Response">Very Slow Response</option>
                                                                    <option value="Relatively Slow Response">Relatively Slow Response</option>
                                                                </select>
                                                            </div>

                                                            <label class="col-sm-5 control-label" for="note" >Operating System:</label>
                                                            <div class="col-sm-5">
                                                                <input type="hidden" name="osname" id="osname" class='form-control' readonly="readonly">
                                                                <input type="text" name="os" id="os" class='form-control' readonly="readonly">
                                                            </div>
                                                            <label class="col-sm-5 control-label" for="note" >Request Note:</label>
                                                            <div class="col-sm-5">
                                                                <textarea name="note" id="note" class='form-control'></textarea>
                                                            </div>
                                                            <label class="col-sm-5 control-label" for="serial" >${model.deviceType} Serial No.:</label>
                                                            <div class="col-sm-5">
                                                                <textarea name="serial" id="serial" class='form-control' <c:if test="${not empty model.serialObj}">readonly="readonly"</c:if>>${model.serialObj}</textarea>
                                                                </div>
                                                            </div>                                                
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <div class="form-actions" align="center">
                                                                <div align="left" style="alignment-adjust: central;">
                                                                    <div id="btnSaveHide">
                                                                        <input type="button" id="saveButton" name="button" class="btn btn-primary" <c:if test="${model.sentRequest==true}">disabled="disbaled"</c:if> value='SUBMIT DEVICE REGISTRATION REQUEST' onClick="
                                                                            var note = $('#note').val();
                                                                            var manU = $('#manufacturer').val();
                                                                            var cond = $('#cond').val();
                                                                                if (note === null || note === '' || manU === null || manU === '0' || cond === null || cond === '0' ) {
                                                                                    deviceCheckReg();
                                                                                    return false;
                                                                                }
                                                                                ajaxSubmitForm('requestDeviceReg.htm', 'workPane', 'submitData');"/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>


                                            </fieldset>
                                    </c:if>
                                    <c:if test="${model.sentRequest==true}">
                                        <div class="row">
                                            <span class="text5">Request Already Sent!</span>
                                            <br><br>
                                            Message : Please Contact Administrator For Help!!
                                        </div>
                                    </c:if>   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="AddNewRg" class="form-actions text5">
                    </div>
                </h3>                            
            </div>

            <div style="display: none">
                <div id='blackout0'> </div>
                <div class="PopupHide" id='divpopup0'>               
                    <div id='pop_content0'>
                        <div align="center">
                            <img src="static/images/ajax-loader.gif" alt="[close]" width="100px" height="100px"  onclick='popup(0, 0)'>
                            <br/>
                            <!--<span  id="loaderTxt" style="font-size: 20px; color: blue; alignment-adjust: left">Please Wait, Still Processing.......</span>-->
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <div>
            <%--<%@include file="lockScreen.jsp" %>--%>
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
        <!--Date Picker-->
        <script type="text/javascript" src="static/res/js/plugins/bootstrap-datepicker.min.js"></script>
        <!--Sweet-Alerts-->
        <script type="text/javascript" src="static/res/js/plugins/bootstrap-notify.min.js"></script>
        <script type="text/javascript" src="static/res/js/plugins/sweetalert.min.js"></script>

        <script src="static/res/js/jstorage.js"></script>
        <script src="static/res/js/sec/md5.min.js"></script>
        <script>
                                $('.bs-component [data-toggle="popover"]').popover();
                                $('.bs-component [data-toggle="tooltip"]').tooltip();
        </script>
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
    </body>
</html>
<script>
                                jQuery(document).ready(function () {
                                    var OSName = "Unknown OS";
                                    if (navigator.appVersion.indexOf("Win") != -1)
                                        OSName = "Windows";
                                    else if (navigator.appVersion.indexOf("Mac") != -1)
                                        OSName = "MacOS";
                                    else if (navigator.appVersion.indexOf("X11") != -1)
                                        OSName = "Linux";
                                    else if (navigator.appVersion.indexOf("Linux") != -1)
                                        OSName = "Linux";
                                    $("#os").val(OSName);
                                    $("#osname").val(OSName);
                                });
                                //showNotification('title', 'message', 'success', 'workpane');
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
                                                '<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
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

                                function deviceCheckReg() {
                                    $.confirm({
                                        title: 'Request Note Missing! Complete All Fields!',
                                        type: 'red',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'Yes',
                                                btnClass: 'btn-red',
                                                action: function () {
                                                }
                                            },
                                            NO: function () {

                                            }
                                        }
                                    });
                                }
</script>


