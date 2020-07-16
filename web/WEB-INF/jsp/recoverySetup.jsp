<%-- 
    Document   : recoverySetup
    Created on : May 28, 2018, 12:56:34 PM
    Author     : user
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <style>
       .alignleft {
            float: left;
            margin-right: 15px;
        }
        .alignright {
            float: right;
            margin-left: 15px;
        }
        .aligncenter {
            display: block;
            margin: 0 auto 15px;
        }
        a:focus { outline: 0 solid }
        img {
            max-width: 100%;
            height: auto;
        }
        .fix { overflow: hidden }
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            margin: 0 0 15px;
            font-weight: 700;
        }
        html,
        body { height: 100% }

        a {
            -moz-transition: 0.3s;
            -o-transition: 0.3s;
            -webkit-transition: 0.3s;
            transition: 0.3s;
            color: #333;
        }
        a:hover { text-decoration: none }



        .search-box{margin:80px auto;position:absolute;}
        .caption{margin-bottom:50px;}
        .loginForm input[type=text], .loginForm input[type=password]{
            margin-bottom:10px;
        }
        .loginForm input[type=submit]{
            background:#fb044a;
            color:#fff;
            font-weight:700;

        }


        #pswd_info {
            background: #dfdfdf none repeat scroll 0 0;
            color: white;
            left: 50%;
            position: absolute;
            top: 115px;
        }
        #pswd_info h4{
            background: purple none repeat scroll 0 0;
            display: block;
            font-size: 14px;
            letter-spacing: 0;
            padding: 17px 0;
            text-align: center;
            text-transform: uppercase;
        }
        #pswd_info ul {
            list-style: outside none none;
        }
        #pswd_info ul li {
            padding: 10px 45px;
        }



        .valid {

            color: green;
            line-height: 21px;
            padding-left: 22px;
        }

        .invalid {

            color: red;
            line-height: 21px;
            padding-left: 22px;
        }


        #pswd_info::before {
            background: #dfdfdf none repeat scroll 0 0;
            content: "";
            height: 25px;
            left: -13px;
            margin-top: -12.5px;
            position: absolute;
            top: 50%;
            transform: rotate(45deg);
            width: 25px;
        }
        #pswd_info {
            display:none;
        }
    </style>
    <body class="app sidebar-mini rtl" style="background-color:plum">
        <!-- Navbar-->
        <header class="app-header" id="colors">
            <a class="app-header__logo" href="#">${model.facilityObj.facilityname}</a>
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
                <li >
                    <a class="app-header__logo" href="http://172.18.1.2:8085/UserGuide/" target="_blank" style="text-decoration: none;font-size:16px ">                                
                        &nbsp;&nbsp;<i class="fa fa-book"></i>
                        User Guide</a>
                </li>


                <li class="dropdown"><a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Open Profile Menu"><i class="fa fa-user fa-lg"></i></a>
                    <ul class="dropdown-menu settings-menu dropdown-menu-right">
                        <li><a class="dropdown-item" href="#"><i class="fa fa-cog fa-lg"></i>Account Settings</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fa fa-user fa-lg"></i> Profile</a></li>
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
                    <p class="app-sidebar__user-designation">${designationame}</p>

                </div>
            </div>
            <ul class="app-menu">
                <li>
                    <a class="app-menu__item active" href="#">
                        <i class="app-menu__icon fa fa-home"></i>
                        <span class="app-menu__label">
                            Dashboard 
                        </span>
                    </a>
                </li>
                <li>
                    <input id="systemuserid" value="${systemuserid}" style="display: none">
                    <div class="col-md-12">
                        <div class="bs-component" style="margin-top: 5%;">
                            <div class="card"  style=" border-radius: 2px">
                                <div class="card-body">
                                    <c:if test="${not empty model.activeUnit}">
                                        <h6 class="card-title">Active Work Location</h6>
                                        <h5 class="card-subtitle text-muted">${model.activeUnit}</h5>
                                        <div style="float:right">Assigned Locations: <button href="#" id="unitSize"  style="background-color: purple; color: whitesmoke; padding: 5px;text-align: center; text-decoration: none; display: inline-block;  font-size: 12px; margin: 4px 2px; border-radius: 30%;">${model.unitSize}</button></div>
                                        </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </aside>
        <main class="app-content" id="mmmain1">
            <div id="workpane">
                <div class="app-title">
                    <div class="col-md-5">
                        <h1>
                            <i class="fa fa-dashboard"></i>
                            Dashboard
                        </h1>
                        <p>Together We Save Lives...!</p>
                    </div>
                </div>
                <div class="row" style="margin-top: 2em" id="credentialsdiv">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <div class="tile" >
                            <div class="tile-body" >
                                <div id="horizontalwithwords"><span class="pat-form-heading">Edit Your Credentials here!</span></div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Old Username</label>
                                    <input class="form-control" id="ousername" type="text" aria-describedby="emailHelp" disabled="true">
                                </div>
                                <form id="credentialsform">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">New user name</label>
                                        <input class="form-control" id="nusername" type="text" aria-describedby="emailHelp" placeholder="Enter new username">
                                    </div>
                                    <div id="nameexists"></div>
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Current password</label>
                                        <input id="knownpass"  style="display: none">
                                        <input class="form-control" id="currentpass" type="password" aria-describedby="emailHelp" placeholder="Enter current password">
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">New Password</label>
                                        <input class="form-control" id="newpass" type="password" aria-describedby="emailHelp" placeholder="Enter new password">
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Confirm Password</label>
                                        <input class="form-control" id="confirmpass" type="password" oninput="confirmPassword()" aria-describedby="emailHelp" placeholder="Confirm Password">
                                    </div>

                                </form>
                                <div class="row">
                                    <div class="col-md-8"></div>
                                    <div class="col-md-2">
                                        <button class="btn btn-secondary" id="clearcredentialsform"><i class="fa fa-remove"></i>clear</button>
                                    </div>
                                    <div class="col-md-2">
                                        <button class="btn btn-primary" id="proceedtoqns"><i class="fa fa-arrow-right"></i>Next</button>
                                    </div>
                                </div>
                            </div>
                        </div> 
                    </div>
                    <div class="col-md-3"></div>
                </div> 
                <div class="row hidedisplaycontent" id="securityqns">
                    <div class="tile">
                        <div class="tile-body">
                            <div id="horizontalwithwords"><span class="pat-form-heading">Select security questions to answer!</span></div>
                            <div class="isa_warning">
                                <i class="fa fa-warning"></i>
                                <font size="4em"><strong><font color="red">Note:</font></strong>Please Select a minimum of three questions and a maximum of five questions.</font>   <span><font color="green"><strong>Total:</strong></font></span>
                                <button class="btn btn-outline-info" type="button" id="checkedsize"></button>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <c:forEach items="${questionslist}" var="details" begin="0" end="12">
                                        <div class="form-check" style="margin-bottom: 1em">
                                            <label class="form-check-label">
                                                <input class="form-check-input" data-id="${details.Questionsid}" type="checkbox" name="type" value="${details.Questionsid}" onChange="if (this.checked) {
                                                            checkeditem('checked', $(this).attr('data-id'));
                                                        } else {
                                                            checkeditem('unchecked', $(this).attr('data-id'));
                                                        }"><span id="idx${details.Questionsid}">${details.question}</span>
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="col-md-6">
                                    <c:forEach items="${questionslist}" var="details" begin="13" end="26">
                                        <div class="form-check" style="margin-bottom: 1em">
                                            <label class="form-check-label">
                                                <input class="form-check-input" data-id="${details.Questionsid}" type="checkbox" name="type" value="${details.Questionsid}" onChange="if (this.checked) {
                                                            checkeditem('checked', $(this).attr('data-id'));
                                                        } else {
                                                            checkeditem('unchecked', $(this).attr('data-id'));
                                                        }"><span id="idx${details.Questionsid}">${details.question}</span>
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-md-6"></div>
                                <div class="hidedisplaycontent" id="firstnext">
                                    <div class="col-md-2">
                                        <div class="form-group ">
                                            <button class="btn btn-primary " id="submitqns" style="margin-top: 4em"><i class="fa fa-arrow-right">
                                                </i>next
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row hidedisplaycontent" id="answerquestions">
                    <div class="tile">
                        <div class="tile-body">
                            <div id="horizontalwithwords"><span class="pat-form-heading">Please answer the selected question(s) below!</span></div>
                            <div class="row">
                                <div class="col-md-2"></div>
                                <div class="col-md-8">
                                    <span id="testdata"></span>
                                </div>
                                <div class="col-md-2"></div>
                            </div>
                            <div class="row">
                                <div class="col-md-4"></div>
                                <div class="col-md-2">
                                    <button class="btn btn-primary " id="previous" style="margin-top: 4em"><i class="fa fa-arrow-left">
                                        </i>Previous
                                    </button>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group ">
                                        <button class="btn btn-primary " id="savedatacontent" style="margin-top: 4em"><i class="fa fa-arrow-right">
                                            </i>submit
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="display: none">
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
            </div>
        </main>
        <div class="">
            <div id="deniedrequests" class="shelveItemDialog" >
                <div>
                    <div id="head" >
                        <a href="#close" title="Close" class="close2">X</a>
                        <div id="heading" style="display: none">
                            <h4 class="modalDialog-title" style="margin-left: 17em">Please answer the selected Questions!</h4>
                        </div>
                        <div id="current">
                            <h4 class="modalDialog-title" style="margin-left: 17em">Select security Questions to answer</h4>
                        </div>
                        <hr>
                    </div>
                    <div class="scrollbar" id="content">
                        <div id="qns">
                            <div class="row">
                                <div class="col-md-4"></div>
                                <div class="col-md-6">
                                    <span style="color: red;font-size: 1.2em">
                                        Note:Please select a maximum of five questions or less.
                                    </span>
                                </div>
                                <div class="col-md-2"></div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <c:forEach items="${questionslist}" var="details" begin="0" end="12">
                                        <div class="form-check" style="margin-bottom: 1em">
                                            <label class="form-check-label">
                                                <input class="form-check-input" data-id="${details.Questionsid}" type="checkbox" name="type" value="${details.Questionsid}" onChange="if (this.checked) {
                                                            checkeditem('checked', $(this).attr('data-id'));
                                                        } else {
                                                            checkeditem('unchecked', $(this).attr('data-id'));
                                                        }"><span id="idx${details.Questionsid}">${details.question}</span>
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="col-md-6">
                                    <c:forEach items="${questionslist}" var="details" begin="13" end="26">
                                        <div class="form-check" style="margin-bottom: 1em">
                                            <label class="form-check-label">
                                                <input class="form-check-input" data-id="${details.Questionsid}" type="checkbox" name="type" value="${details.Questionsid}" onChange="if (this.checked) {
                                                            checkeditem('checked', $(this).attr('data-id'));
                                                        } else {
                                                            checkeditem('unchecked', $(this).attr('data-id'));
                                                        }"><span id="idx${details.Questionsid}">${details.question}</span>
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6"></div>
                                <div class="hidedisplaycontent" id="firstnext">
                                    <div class="col-md-2">
                                        <div class="form-group ">
                                            <button class="btn btn-primary " id="submitqns" style="margin-top: 4em"><i class="fa fa-arrow-right">
                                                </i>next
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4"></div>
                            </div>
                        </div>
                        <div class="row" id="answerqns" style="display: none">
                            <div class="col-md-2"></div>
                            <div class="col-md-8">
                                <span id="testdata"></span>

                                <div class="row">
                                    <div class="col-md-4"></div>
                                    <div class="col-md-2">
                                        <button class="btn btn-primary " id="previous" style="margin-top: 4em"><i class="fa fa-arrow-left">
                                            </i>Previous
                                        </button>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group ">
                                            <button class="btn btn-primary " id="savedatacontent" style="margin-top: 4em"><i class="fa fa-arrow-right">
                                                </i>submit
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-md-4"></div>
                                </div>
                            </div>
                            <div class="col-md-2"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="aro-pswd_info">
            <div id="pswd_info">
                <h4>Password requirements</h4>
                <ul>
                    <li id="letter" class="invalid">At least <strong>one letter</strong></li>
                    <li id="capital" class="invalid">At least <strong>one capital letter</strong></li>
                    <li id="number" class="invalid">At least <strong>one number</strong></li>
                    <li id="length" class="invalid">Be at least <strong>5 characters</strong></li>
                    <li id="space" class="invalid">be<strong> use [~,!,@,#,$,%,^,&,*,-,=,.,;,']</strong></li>
                </ul>
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
        <script src="static/res/js/sec/md5.min.js"></script>
    </body>
</html>
<script>
                                                    $(document).ready(function () {
                                                        $("#proceedtoqns").prop('disabled', true);
                                                    });

                                                    function confirmPassword() {
                                                        var newPass = $('#newpass').val();
                                                        var confirmed = $('#confirmpass').val();
                                                        if (newPass === confirmed) {
                                                            $('#confirmpass').removeClass('error-field');
                                                            document.getElementById('confirmpass').style.borderColor = "green";
                                                            $("#proceedtoqns").prop('disabled', false);
                                                        } else {
                                                            $('#confirmpass').addClass('error-field');
                                                            $("#proceedtoqns").prop('disabled', true);
                                                        }
                                                    }
                                                    $("#clearcredentialsform").click(function () {
                                                        document.getElementById('credentialsform').reset();
                                                    });
                                                    $("#proceedtoqns").click(function () {
                                                        var nusername = $('#nusername').val();
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
                                                        //if (currentpass !== '' && newpass !== '' && hash !== currenthass && currenthass === knownpass) {
                                                        $.confirm({
                                                            title: 'Congratulations!',
                                                            content: 'Your New Username is: ' + '<font color="blue" style="font-size:24px;">' + nusername + '</font>' + '<br>' + 'Your new Password is:' + '<font color="blue" style="font-size:24px;">' + newpass + '</font>',
                                                            type: 'green',
                                                            typeAnimated: true,
                                                            buttons: {
                                                                tryAgain: {
                                                                    text: 'Continue',
                                                                    btnClass: 'btn-green',
                                                                    action: function () {
                                                                        $('#credentialsdiv').hide();
                                                                        $('#securityqns').show();
                                                                        $.ajax({
                                                                            type: 'POST',
                                                                            data: {systemuserid: systemuserid, hash: hash},
                                                                            url: "editpassword.htm",
                                                                            success: function (data) {
                                                                                $.notify({
                                                                                    title: "Update Complete : ",
                                                                                    message: "Your password has been changed!!",
                                                                                    icon: 'fa fa-check'
                                                                                }, {
                                                                                    type: "info"
                                                                                });
                                                                            }
                                                                        });
                                                                        if (nusername !== '') {
                                                                            $.ajax({
                                                                                type: 'POST',
                                                                                data: {systemuserid: systemuserid, nusername: nusername},
                                                                                url: "updateusername.htm",
                                                                                success: function (data) {
                                                                                    $.notify({
                                                                                        title: "Update Complete : ",
                                                                                        message: "Your username has been changed",
                                                                                        icon: 'fa fa-check'
                                                                                    }, {
                                                                                        type: "info"
                                                                                    });

                                                                                }
                                                                            });
                                                                        }
                                                                    }
                                                                },
                                                                close: function () {
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

                                                    var QuestionsAnswers = [];
                                                    function captureqns(id, qnid) {
//                                                        var regex = /[^A-Z0-9]/ig;
                                                        var answerq = document.getElementById(id).value;
//                                                        var result = answerq.replace(regex, '');
//                                                        var lowercase =result.toLowerCase();
                                                        var answer = md5(answerq);
                                                        QuestionsAnswers.push({
                                                            qnid, answer
                                                        });
                                                    }
                                                    $("#submitqns").click(function () {
                                                        $('#firstnext').hide();
                                                        $('#securityqns').hide();
                                                        $('#answerquestions').show();
                                                        var array = [];
                                                        var checkboxes = document.querySelectorAll('input[type=checkbox]:checked');
                                                        for (var i = 0; i < checkboxes.length; i++) {
                                                            var selectedqns = $('#idx' + checkboxes[i].value).html();
                                                            array.push({
                                                                num: checkboxes[i].value,
                                                                questions: selectedqns
                                                            });
                                                        }
                                                        for (var k in  array) {
                                                            var datax = array[k];
                                                            $('#testdata').append(datax.questions + '<br>' + '<input class="form-control" id="qnsAnswer' + datax.num + '" onchange="captureqns(this.id,' + datax.num + ')" type="text" placeholder="Please fill in your answer here....">' + '<br>');
                                                        }
                                                    });
                                                    $('#savedatacontent').click(function () {
                                                        var systemuserid = $('#systemuserid').val();
                                                        $.ajax({
                                                            type: 'POST',
                                                            data: {systemuserid: systemuserid, QuestionsAnswers: JSON.stringify(QuestionsAnswers)},
                                                            url: "savequestions.htm",
                                                            success: function (data) {
                                                                window.location.href = "<c:url value="j_spring_security_logout" />"
                                                                $.notify({
                                                                    title: "Update Complete : ",
                                                                    message: "Questions have been submitted",
                                                                    icon: 'fa fa-check'
                                                                }, {
                                                                    type: "info"
                                                                });
                                                            }
                                                        });
                                                    });
                                                    $("#previous").click(function () {
                                                        $('#testdata').html('');
                                                        $('#answerquestions').hide();
                                                        $('#securityqns').show();
                                                        $('#firstnext').show();
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
                                                    $("#saveusername").click(function () {
                                                        var systemuserid = $('#systemuserid').val();
                                                        var nusername = $('#nusername').val();
                                                        $.ajax({
                                                            type: 'POST',
                                                            data: {systemuserid: systemuserid, nusername: nusername},
                                                            url: "updateusername.htm",
                                                            success: function (data, textStatus, jqXHR) {
                                                                clearSearchResult();
                                                            }
                                                        });
                                                        $('#twou').hide();
                                                        $('#oneU').show();
                                                        $('#usenames').hide();
                                                    });
                                                    var systemuserid = $('#systemuserid').val();
                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {systemuserid: systemuserid},
                                                        url: "getusername.htm",
                                                        success: function (data, textStatus, jqXHR) {
                                                            var response = JSON.parse(data);
                                                            for (index in response) {
                                                                var result = response[index];
                                                                document.getElementById('ousername').value = result["username"];
                                                                document.getElementById('knownpass').value = result["password"];
                                                            }
                                                        }
                                                    });
                                                    $('#nusername').on('input', function () {

                                                        var inputname = $('#nusername').val();
                                                        $.ajax({
                                                            type: 'POST',
                                                            data: {searchValue: inputname, type: 'username'},
                                                            url: "searchusername.htm",
                                                            success: function (data, textStatus, jqXHR) {
                                                                if (data === 'notexisting') {
                                                                    $('#nameexists').html('');

                                                                } else {
                                                                    $('#nameexists').html('<small><span style="color:red;">' + inputname + ' Already Exists,try another user name</span></small>');
                                                                    document.getElementById('proceedtoqns').disabled = true;
                                                                }
                                                            }
                                                        });

                                                    });
                                                    var addcheckedQns = new Set();
                                                    function checkeditem(type, id) {
                                                        if (type === 'checked') {
                                                            addcheckedQns.add(id);
                                                        } else if (type === 'unchecked') {
                                                            addcheckedQns.delete(id);
                                                        }

                                                        if (addcheckedQns.size === 0) {
                                                            document.getElementById("firstnext").style.display = 'none';
                                                        } else if (addcheckedQns.size < 3) {
                                                            document.getElementById("firstnext").style.display = 'none';
                                                            document.getElementById('checkedsize').innerHTML = addcheckedQns.size;
                                                        } else {
                                                            document.getElementById("firstnext").style.display = 'block';
                                                            document.getElementById('checkedsize').innerHTML = addcheckedQns.size;
                                                        }
                                                    }
                                                    $(document).ready(function () {
                                                        $('#newpass').keyup(function () {
                                                            var pswd = $(this).val();

                                                            //validate the length
                                                            if (pswd.length < 5) {
                                                                $('#length').removeClass('valid').addClass('invalid');
                                                            } else {
                                                                $('#length').removeClass('invalid').addClass('valid');
                                                            }

                                                            //validate letter
                                                            if (pswd.match(/[A-z]/)) {
                                                                $('#letter').removeClass('invalid').addClass('valid');
                                                            } else {
                                                                $('#letter').removeClass('valid').addClass('invalid');
                                                            }

                                                            //validate capital letter
                                                            if (pswd.match(/[A-Z]/)) {
                                                                $('#capital').removeClass('invalid').addClass('valid');
                                                            } else {
                                                                $('#capital').removeClass('valid').addClass('invalid');
                                                            }

                                                            //validate number
                                                            if (pswd.match(/\d/)) {
                                                                $('#number').removeClass('invalid').addClass('valid');
                                                            } else {
                                                                $('#number').removeClass('valid').addClass('invalid');
                                                            }

                                                            //validate space
                                                            if (pswd.match(/[^a-zA-Z0-9\-\/]/)) {
                                                                $('#space').removeClass('invalid').addClass('valid');
                                                            } else {
                                                                $('#space').removeClass('valid').addClass('invalid');
                                                            }
                                                            if (pswd.length >= 5 && pswd.match(/[A-z]/) && pswd.match(/\d/) && pswd.match(/[^a-zA-Z0-9\-\/]/) && pswd.match(/[A-Z]/)) {
                                                                document.getElementById('proceedtoqns').disabled = false;
                                                            } else {
                                                                document.getElementById('newpass').style.borderColor = 'red';
                                                                document.getElementById('proceedtoqns').disabled = true;
                                                            }
                                                        }).focus(function () {
                                                            $('#pswd_info').show();
                                                        }).blur(function () {
                                                            $('#pswd_info').hide();
                                                        });
                                                    });
</script>

