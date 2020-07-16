<%-- 
    Document   : mainpane
    Created on : Nov 23, 2017, 3:45:28 PM
    Author     : samuelwam
--%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<!-- Template Name: Clip-One - Responsive Admin Template build with Twitter Bootstrap 3.x Version: 1.3 Author: ClipTheme -->
<!--[if IE 8]><html class="ie8 no-js" lang="en"><![endif]-->
<!--[if IE 9]><html class="ie9 no-js" lang="en"><![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
    <!--<![endif]-->
    <!-- start: HEAD -->
    <head>
        <title>SMS-MAIN</title>
        <!-- start: META -->
        <meta charset="utf-8" />
        <!--[if IE]><meta http-equiv='X-UA-Compatible' content="IE=edge,IE=9,IE=8,chrome=1" /><![endif]-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta content="" name="description" />
        <meta content="" name="author" />
        <meta name="_csrf" content="${_csrf.token}"/>
        <!-- default header name is X-CSRF-TOKEN -->
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <meta name="_csrf_parameter" content="${_csrf.parameterName}"/>
        <!-- end: META -->
        <!-- start: MAIN CSS -->
        <link href="static/images/IICS.ico" rel="shortcut icon" type="image/x-icon"/>
        <link rel="stylesheet" href="static/mainpane/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="static/mainpane/plugins/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="static/mainpane/fonts/style.css">
        <link rel="stylesheet" href="static/mainpane/css/main.css">
        <link rel="stylesheet" href="static/mainpane/css/main-responsive.css">
        <link rel="stylesheet" href="static/mainpane/plugins/iCheck/skins/all.css">
        <link rel="stylesheet" href="static/mainpane/plugins/bootstrap-colorpalette/css/bootstrap-colorpalette.css">
        <link rel="stylesheet" href="static/mainpane/plugins/perfect-scrollbar/src/perfect-scrollbar.css">
        <link rel="stylesheet" href="static/mainpane/css/theme_black_and_white.css" type="text/css" id="skin_color">
        <link rel="stylesheet" href="static/mainpane/css/print.css" type="text/css" media="print"/>
        <!--[if IE 7]>
        <link rel="stylesheet" href="static/mainpane/plugins/font-awesome/css/font-awesome-ie7.min.css">
        <![endif]-->
        <!-- end: MAIN CSS -->
        <!-- start: CSS REQUIRED FOR THIS PAGE ONLY -->
        <link rel="stylesheet" href="static/mainpane/plugins/fullcalendar/fullcalendar/fullcalendar.css">
        <!-- end: CSS REQUIRED FOR THIS PAGE ONLY -->
        <link rel="stylesheet" type="text/css" href="static/mainpane/plugins/select2/select2.css" />
        <link rel="stylesheet" href="static/mainpane/plugins/DataTables/media/css/DT_bootstrap.css" />
        <!--<link rel="shortcut icon" href="favicon.ico" />-->
        <link rel="stylesheet" href="static/mainpane/css/chat.css" type="text/css" media="print"/>
        <link rel="stylesheet" href="static/mainpane/css/ajaxLoader.css" type="text/css"/>
        <style type="text/css">

        </style>

    </head>
    <!-- end: HEAD -->
    <!-- start: BODY -->
    <body>
        <!-- start: HEADER -->
        <div class="navbar navbar-inverse navbar-fixed-top">
            <!-- start: TOP NAVIGATION CONTAINER -->
            <div class="container">
                <div class="navbar-header">
                    <!-- start: RESPONSIVE MENU TOGGLER -->
                    <button data-target=".navbar-collapse" data-toggle="collapse" class="navbar-toggle" type="button">
                        <span class="clip-list-2"></span>
                    </button>
                    <!-- end: RESPONSIVE MENU TOGGLER -->
                    <!-- start: LOGO -->
                    <a class="navbar-brand" href="mainPage.htm">
                        SchoolMate
                    </a>
                    <!-- end: LOGO -->
                </div>
                <div class="navbar-tools">
                    <!-- start: TOP NAVIGATION MENU -->
                    <ul class="nav navbar-right">
                        <!-- start: TO-DO DROPDOWN -->
                        <li class="dropdown">
                            <a data-toggle="dropdown" data-hover="dropdown" class="dropdown-toggle" data-close-others="true" href="#">
                                <i class="clip-list-5"></i>
                                <span class="badge"> 12</span>
                            </a>
                            <ul class="dropdown-menu todo">
                                <li>
                                    <span class="dropdown-menu-title"> You have 12 pending tasks</span>
                                </li>
                                <li>
                                    <div class="drop-down-wrapper">
                                        <ul>
                                            <li>
                                                <a class="todo-actions" href="javascript:void(0)">
                                                    <i class="fa fa-square-o"></i>
                                                    <span class="desc" style="opacity: 1; text-decoration: none;">Staff Meeting</span>
                                                    <span class="label label-danger" style="opacity: 1;"> today</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="todo-actions" href="javascript:void(0)">
                                                    <i class="fa fa-square-o"></i>
                                                    <span class="desc" style="opacity: 1; text-decoration: none;"> Create Doc Control Procedure</span>
                                                    <span class="label label-danger" style="opacity: 1;"> today</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="todo-actions" href="javascript:void(0)">
                                                    <i class="fa fa-square-o"></i>
                                                    <span class="desc">Distribute Letters</span>
                                                    <span class="label label-warning"> tommorow</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="todo-actions" href="javascript:void(0)">
                                                    <i class="fa fa-square-o"></i>
                                                    <span class="desc">Staff Meeting</span>
                                                    <span class="label label-warning"> tommorow</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="todo-actions" href="javascript:void(0)">
                                                    <i class="fa fa-square-o"></i>
                                                    <span class="desc">File Contracts</span>
                                                    <span class="label label-success"> this week</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="todo-actions" href="javascript:void(0)">
                                                    <i class="fa fa-square-o"></i>
                                                    <span class="desc">Compliance Checks</span>
                                                    <span class="label label-success"> this week</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="todo-actions" href="javascript:void(0)">
                                                    <i class="fa fa-square-o"></i>
                                                    <span class="desc">Report Progress</span>
                                                    <span class="label label-info"> this month</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="todo-actions" href="javascript:void(0)">
                                                    <i class="fa fa-square-o"></i>
                                                    <span class="desc">Train on Doc Rules</span>
                                                    <span class="label label-info"> this month</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="todo-actions" href="javascript:void(0)">
                                                    <i class="fa fa-square-o"></i>
                                                    <span class="desc" style="opacity: 1; text-decoration: none;">Staff Meeting</span>
                                                    <span class="label label-danger" style="opacity: 1;"> today</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="todo-actions" href="javascript:void(0)">
                                                    <i class="fa fa-square-o"></i>
                                                    <span class="desc" style="opacity: 1; text-decoration: none;">Supervise Sensitive Letters</span>
                                                    <span class="label label-danger" style="opacity: 1;"> today</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="todo-actions" href="javascript:void(0)">
                                                    <i class="fa fa-square-o"></i>
                                                    <span class="desc">Report Control Issues</span>
                                                    <span class="label label-warning"> tommorow</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li class="view-all">
                                    <a href="javascript:void(0)">
                                        See all tasks <i class="fa fa-arrow-circle-o-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- end: TO-DO DROPDOWN-->
                        <!-- start: NOTIFICATION DROPDOWN -->
                        <li class="dropdown">
                            <a data-toggle="dropdown" data-hover="dropdown" class="dropdown-toggle" data-close-others="true" href="#">
                                <i class="clip-notification-2"></i>
                                <span class="badge"> 11</span>
                            </a>
                            <ul class="dropdown-menu notifications">
                                <li>
                                    <span class="dropdown-menu-title"> You have 11 notifications</span>
                                </li>
                                <li>
                                    <div class="drop-down-wrapper">
                                        <ul>
                                            <li>
                                                <a href="javascript:void(0)">
                                                    <span class="label label-primary"><i class="fa fa-user"></i></span>
                                                    <span class="message"> New user registration</span>
                                                    <span class="time"> 1 min</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0)">
                                                    <span class="label label-success"><i class="fa fa-comment"></i></span>
                                                    <span class="message"> New comment</span>
                                                    <span class="time"> 7 min</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0)">
                                                    <span class="label label-success"><i class="fa fa-comment"></i></span>
                                                    <span class="message"> New comment</span>
                                                    <span class="time"> 8 min</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0)">
                                                    <span class="label label-success"><i class="fa fa-comment"></i></span>
                                                    <span class="message"> New comment</span>
                                                    <span class="time"> 16 min</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0)">
                                                    <span class="label label-primary"><i class="fa fa-user"></i></span>
                                                    <span class="message"> New user registration</span>
                                                    <span class="time"> 36 min</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0)">
                                                    <span class="label label-warning"><i class="fa fa-shopping-cart"></i></span>
                                                    <span class="message"> 2 items sold</span>
                                                    <span class="time"> 1 hour</span>
                                                </a>
                                            </li>
                                            <li class="warning">
                                                <a href="javascript:void(0)">
                                                    <span class="label label-danger"><i class="fa fa-user"></i></span>
                                                    <span class="message"> User deleted account</span>
                                                    <span class="time"> 2 hour</span>
                                                </a>
                                            </li>
                                            <li class="warning">
                                                <a href="javascript:void(0)">
                                                    <span class="label label-danger"><i class="fa fa-shopping-cart"></i></span>
                                                    <span class="message"> Transaction was canceled</span>
                                                    <span class="time"> 6 hour</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0)">
                                                    <span class="label label-success"><i class="fa fa-comment"></i></span>
                                                    <span class="message"> New comment</span>
                                                    <span class="time"> yesterday</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0)">
                                                    <span class="label label-primary"><i class="fa fa-user"></i></span>
                                                    <span class="message"> New user registration</span>
                                                    <span class="time"> yesterday</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0)">
                                                    <span class="label label-primary"><i class="fa fa-user"></i></span>
                                                    <span class="message"> New user registration</span>
                                                    <span class="time"> yesterday</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0)">
                                                    <span class="label label-success"><i class="fa fa-comment"></i></span>
                                                    <span class="message"> New comment</span>
                                                    <span class="time"> yesterday</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0)">
                                                    <span class="label label-success"><i class="fa fa-comment"></i></span>
                                                    <span class="message"> New comment</span>
                                                    <span class="time"> yesterday</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li class="view-all">
                                    <a href="javascript:void(0)">
                                        See all notifications <i class="fa fa-arrow-circle-o-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- end: NOTIFICATION DROPDOWN -->
                        <!-- start: MESSAGE DROPDOWN -->
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-close-others="true" data-hover="dropdown" data-toggle="dropdown" href="#">
                                <i class="clip-bubble-3"></i>
                                <span class="badge"> 9</span>
                            </a>
                            <ul class="dropdown-menu posts">
                                <li>
                                    <span class="dropdown-menu-title"> You have 9 messages</span>
                                </li>
                                <li>
                                    <div class="drop-down-wrapper">
                                        <ul>
                                            <li>
                                                <a href="javascript:;">
                                                    <div class="clearfix">
                                                        <div class="thread-image">
                                                            <img alt="" src="static/mainpane/images/staff_icon.png" width="40px" height="40px">
                                                        </div>
                                                        <div class="thread-content">
                                                            <span class="author">Nicole Bell</span>
                                                            <span class="preview">Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.</span>
                                                            <span class="time"> Just Now</span>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:;">
                                                    <div class="clearfix">
                                                        <div class="thread-image">
                                                            <img alt="" src="static/mainpane/images/staff_icon.png" width="40px" height="40px">
                                                        </div>
                                                        <div class="thread-content">
                                                            <span class="author">Peter Clark</span>
                                                            <span class="preview">Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.</span>
                                                            <span class="time">2 mins</span>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:;">
                                                    <div class="clearfix">
                                                        <div class="thread-image">
                                                            <img alt="" src="static/mainpane/images/staff_icon.png" width="40px" height="40px"">
                                                        </div>
                                                        <div class="thread-content">
                                                            <span class="author">Steven Thompson</span>
                                                            <span class="preview">Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.</span>
                                                            <span class="time">8 hrs</span>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:;">
                                                    <div class="clearfix">
                                                        <div class="thread-image">
                                                            <img alt="" src="static/mainpane/images/staff_icon.png" width="40px" height="40px">
                                                        </div>
                                                        <div class="thread-content">
                                                            <span class="author">${model.personObj.firstname}</span>
                                                            <span class="preview">Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.</span>
                                                            <span class="time">9 hrs</span>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:;">
                                                    <div class="clearfix">
                                                        <div class="thread-image">
                                                            <img alt="" src="static/mainpane/images/staff_icon.png" width="40px" height="40px"">
                                                        </div>
                                                        <div class="thread-content">
                                                            <span class="author">Kenneth Ross</span>
                                                            <span class="preview">Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.</span>
                                                            <span class="time">14 hrs</span>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li class="view-all">
                                    <a href="pages_messages.html">
                                        See all messages <i class="fa fa-arrow-circle-o-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- end: MESSAGE DROPDOWN -->
                        <!-- start: USER DROPDOWN -->
                        <li class="dropdown current-user">
                            <a data-toggle="dropdown" data-hover="dropdown" class="dropdown-toggle" data-close-others="true" href="#">
                                <img src="static/mainpane/images/staff_icon.png" width="35px" height="35px" class="circle-img" alt="">
                                <span class="username">${model.personObj.personname}</span>
                                <i class="clip-chevron-down"></i>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('systemUserSetting.htm', 'workPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        &nbsp;My Profile
                                    </a>
                                </li>
                                <li>
                                    <a href="pages_calendar.html">
                                        <i class="clip-calendar"></i>
                                        &nbsp;My Calendar
                                    </a>
                                <li>
                                    <a href="pages_messages.html">
                                        <i class="clip-bubble-4"></i>
                                        &nbsp;My Messages (3)
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="utility_lock_screen.html"><i class="clip-locked"></i>
                                        &nbsp;Lock Screen </a>
                                </li>
                                <security:authorize access="hasAnyRole('ROLE_USER')"> 
                                    <li>


                                        <a href="#" onClick="logoutfn();location.reload(true);window.name = 0;">
                                            <i class="clip-exit"></i>
                                            &nbsp;Log Out
                                        </a>

                                    </li>
                                </security:authorize>
                            </ul>
                        </li>
                        <!-- end: USER DROPDOWN -->
                    </ul>
                    <!-- end: TOP NAVIGATION MENU -->
                </div>
            </div>
            <!-- end: TOP NAVIGATION CONTAINER -->
        </div>

        <!-- end: HEADER -->
        <!-- start: MAIN CONTAINER -->
        <div class="main-container">
            <div class="navbar-content">
                <!-- start: SIDEBAR -->
                <div class="main-navigation navbar-collapse collapse">
                    <!-- start: MAIN MENU TOGGLER BUTTON -->
                    <div class="navigation-toggler">
                        <i class="clip-chevron-left"></i>
                        <i class="clip-chevron-right"></i>
                    </div>
                    <!-- end: MAIN MENU TOGGLER BUTTON -->
                    <!-- start: MAIN NAVIGATION MENU -->
                    <ul class="main-navigation-menu">
                        <!--<li class="active open">
                            <a href="index.html"><i class="clip-home-3"></i>
                                <span class="title"> Dashboard </span><span class="selected"></span>
                            </a>
                        </li>-->
                        <li>
                            <a href="#"><i class="clip-home-3"></i>
                                <span class="title"> Dashboard </span><span class="selected"></span>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:void(0)"><i class="clip-user-2"></i>
                                <span class="title">User Manager</span><i class="icon-arrow"></i>
                                <span class="selected"></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('registerNewUser.htm', 'workPane', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <!--<a href="#" onClick="ajaxSubmitData('xxx.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">-->
                                        <i class="clip-user-2"></i>
                                        <span class="title">Register New User</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('listAllRegisteredUsersForManagement.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <!--<a href="#" onClick="ajaxSubmitData('xxx.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">-->
                                        <i class="clip-pencil"></i>
                                        <span class="title">Manage Existing User</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:void(0)"><i class="clip-banknote"></i>
                                <span class="title">Fees Management</span><i class="icon-arrow"></i>
                                <span class="selected"></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('finances/feesstructure.htm', 'workPane', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-stack"></i>
                                        <span class="title">Fees Structure</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('finances/sponsors.htm', 'workPane', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-stack"></i>
                                        <span class="title">Sponsors</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('finances/collection.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-stack-empty"></i>
                                        <span class="title">Fees Collection</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:void(0)"><i class="clip-balance"></i>
                                <span class="title">Accounts</span><i class="icon-arrow"></i>
                                <span class="selected"></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('accounts/managerequistion.htm', 'workPane', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-stack"></i>
                                        <span class="title">Requisitions</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:void(0)"><i class="clip-cog-2"></i>
                                <span class="title">Curriculum</span><i class="icon-arrow"></i>
                                <span class="selected"></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('curriculum/academicYears.htm', 'workPane', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Academic Years</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('curriculum/manageclasses.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-pencil"></i>
                                        <span class="title">Classes</span>
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript:void(0)"><i class="clip-users-2"></i>
                                <span class="title">Human Resource</span><i class="icon-arrow"></i>
                                <span class="selected"></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('workschedule.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Work Schedule</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('humanresource.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Add Staff</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('staffAllowances.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');"> <i class="clip-user-2"></i>
                                        <span class="title">Allowances</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('deductions.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');"> <i class="clip-user-2"></i>
                                        <span class="title">Deductions</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('schoolDepartments.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');"> <i class="clip-users-2"></i>
                                        <span class="title">Staff Members</span>
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript:void(0)"><i class="clip-cog-2"></i>
                                <span class="title">Examinations</span><i class="icon-arrow"></i>
                                <span class="selected"></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('gradeRules.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">

                                        <i class="clip-book"></i>
                                        <span class="title">Grade Rules</span>
                                    </a>
                                </li>
                                <li>

                                    <a href="#" onClick="ajaxSubmitData('classAssessment.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-book"></i>
                                        <span class="title">Assessments</span>
                                    </a>
                                </li>
                                <li>

                                    <a href="#" onClick="ajaxSubmitData('teacherclasses.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Marks Entry</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('requestedamendmentslist.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Marks Amendments</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('examinations/marksheets.htm', 'workPane', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Mark-Sheets</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('examinations/reportcomments.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-pencil"></i>
                                        <span class="title">Report Cards</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('examinations/performancesheets.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-pencil"></i>
                                        <span class="title">Class Performance</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:void(0)"><i class="clip-user-2"></i>
                                <span class="title">Student</span><i class="icon-arrow"></i>
                                <span class="selected"></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('registration/students.htm', 'workPane', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Check-In</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('admitstudent.htm', 'workPane', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Register Student</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('scanstudentdocuments.htm', 'workPane', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Scan Student Documents</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('studentsearch.htm', 'workPane', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Student Details</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('students.htm', 'workPane', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Medical Form</span>
                                    </a>
                                </li>
                                <li> 
                                    <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('record_book.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=a&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-book"></i>
                                        Record Book
                                    </a>
                                </li>
                                <li>
                                    <a href="#" >
                                        <i class="clip-pencil"></i><span>Other Records</span><i class="icon-arrow"></i></a><span class="selected"></span>
                                    <ul class="sub-menu">
                                        <li>
                                            <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('otherrecords.htm', 'workPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                                <i class=""></i>
                                                <span class="title">Discipline</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('extraactivities.htm', 'workPane', 'page=selectacademicyear&act=sports&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                                <i class=""></i>
                                                <span class="title">Sports</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('leadership.htm', 'workPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                                <i class=""></i>
                                                <span class="title">Leadership</span>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" >
                                <i class="clip-stumbleupon"></i><span>Parents and Families</span><i class="icon-arrow"></i></a><span class="selected"></span>
                            <ul class="sub-menu">
                                <li>
                                    <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('parentguardian.htm', 'workPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Manage parent</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:void(0)"><i class="clip-book"></i>
                                <span class="title">Inventory</span><i class="icon-arrow"></i>
                                <span class="selected"></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('registersupplier.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Suppliers</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('addtostock.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-user-2"></i>
                                        <span class="title">Manage Inventory</span>
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li>
                            <a href="#" >
                                <i class="clip-home"></i><span>Student Residences</span></a><span class="selected"></span>
                            <ul class="sub-menu">
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('dormitory/detaillist.htm', 'workPane', 'act=dormitory&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                        <i class="clip-home-2"></i>
                                        <span class="title">Residences</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('dormitory/detaillist.htm', 'workPane', 'act=assignstudent&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                        <i class="glyphicon glyphicon-user"></i>
                                        <span class="title">Resident<>Student</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('dormitory/detaillist.htm', 'workPane', 'act=assignstaff&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                        <i class="glyphicon glyphicon-user"></i>
                                        <span class="title">Resident<>Staff</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('dormitory/detaillist.htm', 'workPane', 'act=dormitorystudentListReport&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                        <i class="clip-book"></i>
                                        <span class="title">Resident Reports</span>
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li>
                            <a href="javascript:void(0)"><i class="clip-book"></i>
                                <span class="title">Academics</span><i class="icon-arrow"></i>
                                <span class="selected"></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="javascript:void(0)"><i class="clip-use"></i>
                                        <span class="title">Students Attendance</span><i class="icon-arrow"></i>
                                        <span class="selected"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li>
                                            <a href="#" onClick="ajaxSubmitData('classAcademicAtttendences.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                                <i class="clip-checkbox"></i>
                                                <span class="title">Class Attendance</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" onClick="ajaxSubmitData('academicSubjectAtttendences.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                                <i class="clip-checkbox"></i>
                                                <span class="title">Subject Attendance</span>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('teacherPanel.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-clock"></i>
                                        <span class="title">Time Table</span>
                                    </a>
                                </li>

                            </ul>


                        </li>

                        <li>
                            <a href="javascript:void(0)"><i class="clip-cog-2"></i>
                                <span class="title"> Control Panel </span><i class="icon-arrow"></i>
                                <span class="selected"></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="#">
                                        <span class="title">Department Setting</span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li>
                                            <a href="#" onClick="ajaxSubmitData('departmentlist.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');"><i class="fa fa-home"></i>Departments</a>
                                        </li>
                                    </ul>
                                    <ul class="sub-menu">
                                        <li>
                                            <a href="#" onClick="ajaxSubmitData('registernewdepartments.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');"><i class="fa fa-home"></i>Add Departments</a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="title">Subjects Setting</span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li>
                                            <a href="#" onClick="ajaxSubmitData('registernewsubjects.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');"><i class="fa fa-home"></i>Register Subjects</a>
                                        </li>
                                    </ul>
                                    <ul class="sub-menu">
                                        <li>
                                            <a href="#" onClick="ajaxSubmitData('subjectslist.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');"><i class="fa fa-home"></i>Subjects</a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('examinations/customreportcards.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                        <i class="clip-pencil"></i>
                                        <span class="title">Generate Reports</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="title">Organization Setting</span>
                                    </a>
                                    <ul class="sub-menu">
                                        <!--<li>
                                            <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('orgHierarchySetting.htm', 'workPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"><i class="fa fa-home"></i>Hierarchy</a>
                                        </li>-->
                                        <li>
                                            <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('organisationSetting.htm', 'workPane', 'act=g&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"><i class="fa fa-home"></i>Organisation</a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="title">Dev Templates</span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li>
                                            <a href="#"><i class="fa fa-wrench"></i>Tables</a>
                                            <ul class="sub-menu">
                                                <li>
                                                    <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('devTemplates.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=a&offset=1&maxResults=100&vsearch=', 'GET');"><i class="fa fa-copy"></i>
                                                        Static</a>
                                                </li>
                                                <li>
                                                    <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('devTemplates.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=b&offset=1&maxResults=100&vsearch=', 'GET');"><i class="fa fa-copy"></i>
                                                        Responsive</a>
                                                </li>
                                                <li>
                                                    <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('devTemplates.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=c&offset=1&maxResults=100&vsearch=', 'GET');"><i class="fa fa-copy"></i>
                                                        Data</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a href="#" id="formTemp"><i class="fa fa-wrench"></i>Forms</a>
                                            <ul class="sub-menu">
                                                <li>
                                                    <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('devTemplates.htm', 'workPane', 'act=b&sn=&i=0&c=0&st=&d=a&offset=1&maxResults=100&vsearch=', 'GET');"><i class="fa fa-pencil-square"></i>
                                                        Form Lay Out</a>
                                                </li>
                                                <li>
                                                    <a href="#" onClick="clearDiv('workPane'); ajaxSubmitData('devTemplates.htm', 'workPane', 'act=b&sn=&i=0&c=0&st=&d=b&offset=1&maxResults=100&vsearch=', 'GET');"><i class="fa fa-pencil-square"></i>
                                                        Form Elements</a>
                                                </li>
                                                <li>
                                                    <a href="#"><i class="fa fa-pencil-square"></i>Special Styles</a>

                                                </li>
                                            </ul>
                                        </li>

                                    </ul>
                                </li>

                            </ul>
                        </li>

                        <li>
                            <a href="#" onClick="ajaxSubmitData('xxx.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');"><i class="clip-bars"></i>
                                <span class="title">Reports</span>
                                <span class="selected"></span>
                            </a>
                        </li>
                        <!---Documents start-->

                        <li>
                            <a href="javascript:void(0)"><i class="clip-folder"></i>
                                <span class="title">Documents</span><i class="icon-arrow"></i>
                                <span class="selected"></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('xxx.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">  
                                        <i class="clip-file-pdf"></i>
                                        <span class="title">Admission Letters</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onClick="ajaxSubmitData('xxx.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');" >
                                        <i class="clip-file-pdf"></i>
                                        <span class="title">Referral Letters</span>
                                    </a>
                                </li>

                                <li>
                                    <a href="javascript:void(0)"><i class="clip-file-check"></i>
                                        <span class="title">School IDs</span><i class="icon-arrow"></i>
                                        <span class="selected"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li>
                                            <a href="#" onClick="ajaxSubmitData('documents/studentIdsMgt.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                                <i class="clip-file-2"></i>
                                                <span class="title">Student IDs</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" onClick="ajaxSubmitData('xxx.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                                <i class="clip-file-2"></i>
                                                <span class="title">Staff IDs</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" onClick="ajaxSubmitData('xxx.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                                <i class="clip-file-2"></i>
                                                <span class="title">IDs Replacements</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" onClick="ajaxSubmitData('meals/mealCardsMgt.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                                <i class="clip-file-2"></i>
                                                <span class="title">Meal Cards</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" onClick="ajaxSubmitData('xxx.htm', 'workPane', 'act=a&sn=&i=0&c=0&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');">
                                                <i class="clip-file-2"></i>
                                                <span class="title">Visitation IDs</span>
                                            </a>
                                        </li>
                                    </ul>
                                </li>

                            </ul>
                        </li>

                        <!--Documents Ends-->
                    </ul>
                    <!-- end: MAIN NAVIGATION MENU -->
                </div>
                <!-- end: SIDEBAR -->
            </div>
            <!-- start: PAGE -->
            <div class="main-content">
                <!-- start: PANEL CONFIGURATION MODAL FORM -->
                <div class="modal fade" id="panel-config" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                    &times;
                                </button>
                                <h4 class="modal-title">Panel Configuration</h4>
                            </div>
                            <div class="modal-body">
                                Here will be a configuration form
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">
                                    Close
                                </button>
                                <button type="button" class="btn btn-primary">
                                    Save changes
                                </button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
                <!-- end: SPANEL CONFIGURATION MODAL FORM -->
                <div class="container" id="workPane">
                    <!-- start: PAGE HEADER -->
                    <div class="row">
                        <div class="col-sm-12">
                            <!-- start: PAGE TITLE & BREADCRUMB -->
                            <ol class="breadcrumb">
                                <li>
                                    <i class="clip-home-3"></i>
                                    <a href="#">
                                        Home
                                    </a>
                                </li>
                                <li class="active">
                                    Dashboard
                                </li>
                                <li class="search-box">
                                    <form class="sidebar-search">
                                        <div class="form-group">
                                            <input type="text" placeholder="Start Searching...">
                                            <button class="submit">
                                                <i class="clip-search-3"></i>
                                            </button>
                                        </div>
                                    </form>
                                </li>
                            </ol>
                            <div class="page-header">
                                <h1>Dashboard <small>overview &amp; stats </small></h1>
                            </div>
                            <!-- end: PAGE TITLE & BREADCRUMB -->
                        </div>
                    </div>
                    <!-- end: PAGE HEADER -->
                    <!-- start: PAGE CONTENT -->

                    <div class="row">
                        <div class="col-sm-7">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <i class="clip-stats"></i>
                                    XXXXXXXX
                                    <div class="panel-tools">
                                        <a class="btn btn-xs btn-link panel-collapse collapses" href="#">
                                        </a>
                                        <a class="btn btn-xs btn-link panel-config" href="#panel-config" data-toggle="modal">
                                            <i class="fa fa-wrench"></i>
                                        </a>
                                        <a class="btn btn-xs btn-link panel-refresh" href="#">
                                            <i class="fa fa-refresh"></i>
                                        </a>
                                        <a class="btn btn-xs btn-link panel-close" href="#">
                                            <i class="fa fa-times"></i>
                                        </a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="flot-medium-container">
                                        <div id="placeholder-h1" class="flot-placeholder"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <i class="clip-checkbox"></i>
                                    Assigned To Do List
                                    <div class="panel-tools">
                                        <a class="btn btn-xs btn-link panel-collapse collapses" href="#">
                                        </a>
                                        <a class="btn btn-xs btn-link panel-config" href="#panel-config" data-toggle="modal">
                                            <i class="fa fa-wrench"></i>
                                        </a>
                                        <a class="btn btn-xs btn-link panel-refresh" href="#">
                                            <i class="fa fa-refresh"></i>
                                        </a>
                                        <a class="btn btn-xs btn-link panel-close" href="#">
                                            <i class="fa fa-times"></i>
                                        </a>
                                    </div>
                                </div>
                                <div class="panel-body panel-scroll" style="height:300px">
                                    <ul class="todo">
                                        <li>
                                            <a class="todo-actions" href="javascript:void(0)">
                                                <i class="fa fa-square-o"></i>
                                                <span class="desc" style="opacity: 1; text-decoration: none;">Review Meeting</span>
                                                <span class="label label-danger" style="opacity: 1;"> today</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="todo-actions" href="javascript:void(0)">
                                                <i class="fa fa-square-o"></i>
                                                <span class="desc" style="opacity: 1; text-decoration: none;">Add New Template</span>
                                                <span class="label label-danger" style="opacity: 1;"> today</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="todo-actions" href="javascript:void(0)">
                                                <i class="fa fa-square-o"></i>
                                                <span class="desc"> Approve Updated Documents</span>
                                                <span class="label label-warning"> tommorow</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="todo-actions" href="javascript:void(0)">
                                                <i class="fa fa-square-o"></i>
                                                <span class="desc">Reply Senders</span>
                                                <span class="label label-warning"> tommorow</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="todo-actions" href="javascript:void(0)">
                                                <i class="fa fa-square-o"></i>
                                                <span class="desc"> Contact Media Team</span>
                                                <span class="label label-success"> this week</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="todo-actions" href="javascript:void(0)">
                                                <i class="fa fa-square-o"></i>
                                                <span class="desc"> Hire Courier</span>
                                                <span class="label label-success"> this week</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="todo-actions" href="javascript:void(0)">
                                                <i class="fa fa-square-o"></i>
                                                <span class="desc">Shelve Received Hard Copies</span>
                                                <span class="label label-info"> this month</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="todo-actions" href="javascript:void(0)">
                                                <i class="fa fa-square-o"></i>
                                                <span class="desc">Update Monthly Log</span>
                                                <span class="label label-info"> this month</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="todo-actions" href="javascript:void(0)">
                                                <i class="fa fa-square-o"></i>
                                                <span class="desc" style="opacity: 1; text-decoration: none;">Staff Meeting</span>
                                                <span class="label label-danger" style="opacity: 1;"> today</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="todo-actions" href="javascript:void(0)">
                                                <i class="fa fa-square-o"></i>
                                                <span class="desc" style="opacity: 1; text-decoration: none;"> New frontend layout</span>
                                                <span class="label label-danger" style="opacity: 1;"> today</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="todo-actions" href="javascript:void(0)">
                                                <i class="fa fa-square-o"></i>
                                                <span class="desc"> Hire developers</span>
                                                <span class="label label-warning"> tommorow</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>	

                    </div>

                    <div class="row">
                        <div class="col-sm-7">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <i class="clip-users-2"></i>
                                    Active Users
                                    <div class="panel-tools">
                                        <a class="btn btn-xs btn-link panel-collapse collapses" href="#">
                                        </a>
                                        <a class="btn btn-xs btn-link panel-config" href="#panel-config" data-toggle="modal">
                                            <i class="fa fa-wrench"></i>
                                        </a>
                                        <a class="btn btn-xs btn-link panel-refresh" href="#">
                                            <i class="fa fa-refresh"></i>
                                        </a>
                                        <a class="btn btn-xs btn-link panel-close" href="#">
                                            <i class="fa fa-times"></i>
                                        </a>
                                    </div>
                                </div>
                                <div class="panel-body panel-scroll" style="height:300px">
                                    <table class="table table-striped table-hover" id="sample-table-1">
                                        <thead>
                                            <tr>
                                                <th class="center">Photo</th>
                                                <th>Full Name</th>
                                                <th class="hidden-xs">Email</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="center"><img src="static/mainpane/images/staff_icon.png" width="40px" height="40px" alt="image"/></td>
                                                <td>Julius Ssekajja</td>
                                                <td class="hidden-xs">
                                                    <a href="#" rel="nofollow" target="_blank">
                                                        juliussekajja@gmail.com
                                                    </a></td>
                                                <td class="center">
                                                    <div>
                                                        <div class="btn-group">
                                                            <a class="btn btn-primary dropdown-toggle btn-sm" data-toggle="dropdown" href="#">
                                                                <i class="fa fa-cog"></i> <span class="caret"></span>
                                                            </a>
                                                            <ul role="menu" class="dropdown-menu pull-right">
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-edit"></i> Edit
                                                                    </a>
                                                                </li>
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-share"></i> Share
                                                                    </a>
                                                                </li>
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-times"></i> Remove
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div></td>
                                            </tr>
                                            <tr>
                                                <td class="center"><img src="static/mainpane/images/person_icon.png" width="40px" height="40px" alt="image"/></td>
                                                <td>Isaac Makubuya</td>
                                                <td class="hidden-xs">
                                                    <a href="#" rel="nofollow" target="_blank">
                                                        isaacMkby@gmail.com
                                                    </a></td>
                                                <td class="center">
                                                    <div>
                                                        <div class="btn-group">
                                                            <a class="btn btn-primary dropdown-toggle btn-sm" data-toggle="dropdown" href="#">
                                                                <i class="fa fa-cog"></i> <span class="caret"></span>
                                                            </a>
                                                            <ul role="menu" class="dropdown-menu pull-right">
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-edit"></i> Edit
                                                                    </a>
                                                                </li>
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-share"></i> Share
                                                                    </a>
                                                                </li>
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-times"></i> Remove
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div></td>
                                            </tr>
                                            <tr>
                                                <td class="center"><img src="static/mainpane/images/staff_icon.png" width="40px" height="40px" alt="image"/></td>
                                                <td>Annick Uwera Daaki</td>
                                                <td class="hidden-xs">
                                                    <a href="#" rel="nofollow" target="_blank">
                                                        uwera093@gmail.com
                                                    </a></td>
                                                <td class="center">
                                                    <div>
                                                        <div class="btn-group">
                                                            <a class="btn btn-primary dropdown-toggle btn-sm" data-toggle="dropdown" href="#">
                                                                <i class="fa fa-cog"></i> <span class="caret"></span>
                                                            </a>
                                                            <ul role="menu" class="dropdown-menu pull-right">
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-edit"></i> Edit
                                                                    </a>
                                                                </li>
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-share"></i> Share
                                                                    </a>
                                                                </li>
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-times"></i> Remove
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div></td>
                                            </tr>
                                            <tr>
                                                <td class="center"><img src="static/mainpane/images/staff_icon.png" width="40px" height="40px" alt="image"/></td>
                                                <td>Diana Byarugaba Mbabazi</td>
                                                <td class="hidden-xs">
                                                    <a href="#" rel="nofollow" target="_blank">
                                                        dianambabazi@gmail.com
                                                    </a></td>
                                                <td class="center">
                                                    <div>
                                                        <div class="btn-group">
                                                            <a class="btn btn-primary dropdown-toggle btn-sm" data-toggle="dropdown" href="#">
                                                                <i class="fa fa-cog"></i> <span class="caret"></span>
                                                            </a>
                                                            <ul role="menu" class="dropdown-menu pull-right">
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-edit"></i> Edit
                                                                    </a>
                                                                </li>
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-share"></i> Share
                                                                    </a>
                                                                </li>
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-times"></i> Remove
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div></td>
                                            </tr>
                                            <tr>
                                                <td class="center"><img src="static/mainpane/images/person_icon.png" width="40px" height="40px" alt="image"/></td>
                                                <td>Andrew B T</td>
                                                <td class="hidden-xs">
                                                    <a href="#" rel="nofollow" target="_blank">
                                                        andrewbibangamba@gmail.com
                                                    </a></td>
                                                <td class="center">
                                                    <div>
                                                        <div class="btn-group">
                                                            <a class="btn btn-primary dropdown-toggle btn-sm" data-toggle="dropdown" href="#">
                                                                <i class="fa fa-cog"></i> <span class="caret"></span>
                                                            </a>
                                                            <ul role="menu" class="dropdown-menu pull-right">
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-edit"></i> Edit
                                                                    </a>
                                                                </li>
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-share"></i> Share
                                                                    </a>
                                                                </li>
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="#">
                                                                        <i class="fa fa-times"></i> Remove
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <i class="clip-bubble-4"></i>
                                            Chats
                                            <div class="panel-tools">
                                                <a id="chat-active" class="btn btn-xs btn-link"  href="#">
                                                    <i class="fa fa-comments fa-2x chat-active-status"></i>
                                                    <label class="chat-active-status"> Offline</label>
                                                </a>

                                                <a class="btn btn-xs btn-link panel-collapse collapses" href="#">
                                                </a>
                                                <a class="btn btn-xs btn-link panel-config" href="#panel-config" data-toggle="modal">
                                                    <i class="fa fa-wrench"></i>
                                                </a>
                                                <a class="btn btn-xs btn-link panel-refresh" href="#">
                                                    <i class="fa fa-refresh"></i>
                                                </a>
                                                <a class="btn btn-xs btn-link panel-expand" href="#">
                                                    <i class="fa fa-resize-full"></i>
                                                </a>

                                                <a class="btn btn-xs btn-link panel-close" href="#">
                                                    <i class="fa fa-times"></i>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="panel-body panel-scroll" style="height:420px;overflow:scroll;">
                                            <div id="chat-active-window" style="">
                                                <div id="chat-active-head">
                                                    <table class="table">
                                                        <tr class="success"> 
                                                            <td width="10%">
                                                                <img alt="" src="static/mainpane/images/staff_icon.png"  width="30px" height="30px">
                                                            </td>                                       					
                                                            <td align="left" width="20%">
                                                                <span id="chat-active-current-user" class="label label-default">User</span>
                                                            </td>
                                                            <td align="right">
                                                                <button id="close-chat" class="btn btn-xs btn-default">Close</button>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="discussion">                                         			                                               	
                                                </div>
                                            </div>
                                            <div id="chat-onlineUsers-window">
                                                <div class="alert alert-default">
                                                    <span id="no-online-users" class="label label-default">:(  There are no users available online</span>
                                                    <table class="table table-striped">
                                                        <tbody class="onliners">
                                                        </tbody>
                                                    </table>

                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="chat-form">
                                        <div class="input-group">
                                            <input id="chat-message" type="text" class="form-control input-mask-date" placeholder="Type a message here...">
                                            <span class="input-group-btn">
                                                <button id="chat-send" class="btn btn-teal" type="button">
                                                    <i class="fa fa-check"></i>
                                                </button> </span>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- end: PAGE CONTENT-->


                </div>
                <div class="row">


                </div>
            </div>
            <!-- end: PAGE -->
        </div>
        <!-- end: MAIN CONTAINER -->
        <!-- start: FOOTER -->
        <div class="footer clearfix">
            <div class="footer-inner">
                2017 &copy; IICS-SchoolMate School Management System.
            </div>
            <div class="footer-items">
                <span class="go-top"><i class="clip-chevron-up"></i></span>
            </div>
        </div>
        <!-- end: FOOTER -->

        <div>                              
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
        <!-- start: MAIN JAVASCRIPTS -->
        <!--[if lt IE 9]>
        <script src="static/mainpane/plugins/respond.min.js"></script>
        <script src="static/mainpane/plugins/excanvas.min.js"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <![endif]-->
        <!--[if gte IE 9]><!-->
        <script type="text/javascript" src="static/graph/googleapi.js"></script>
        <script type="text/javascript" src="static/mainpane/js/jquery/jquery-3.1.0.min.js"></script>
        <!--<![endif]-->
        <script src="static/mainpane/plugins/jquery-ui/jquery-ui-1.10.2.custom.min.js"></script>
        <script src="static/mainpane/plugins/bootstrap/js/bootstrap.min.js"></script>
        <script src="static/mainpane/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"></script>
        <script src="static/mainpane/plugins/blockUI/jquery.blockUI.js"></script>
        <script src="static/mainpane/plugins/iCheck/jquery.icheck.min.js"></script>
        <script src="static/mainpane/plugins/perfect-scrollbar/src/jquery.mousewheel.js"></script>
        <script src="static/mainpane/plugins/perfect-scrollbar/src/perfect-scrollbar.js"></script>
        <script src="static/mainpane/plugins/less/less-1.5.0.min.js"></script>
        <script src="static/mainpane/plugins/jquery-cookie/jquery.cookie.js"></script>
        <script src="static/mainpane/plugins/bootstrap-colorpalette/js/bootstrap-colorpalette.js"></script>
        <script src="static/mainpane/js/main.js"></script>
        <!-- end: MAIN JAVASCRIPTS -->
        <!-- start: JAVASCRIPTS REQUIRED FOR THIS PAGE ONLY -->
        <script src="static/mainpane/plugins/flot/jquery.flot.js"></script>
        <script src="static/mainpane/plugins/flot/jquery.flot.pie.js"></script>
        <script src="static/mainpane/plugins/flot/jquery.flot.resize.min.js"></script>
        <script src="static/mainpane/plugins/jquery.sparkline/jquery.sparkline.js"></script>
        <script src="static/mainpane/plugins/jquery-easy-pie-chart/jquery.easy-pie-chart.js"></script>
        <script src="static/mainpane/plugins/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js"></script>
        <script src="static/mainpane/plugins/fullcalendar/fullcalendar/fullcalendar.js"></script>
        <script src="static/mainpane/js/index.js"></script>
        <script type="text/javascript" src="static/js/ajaxCalls.js"></script>
        <script type="text/javascript" src="static/js/general.js"></script>
        <script type="text/javascript" src="static/js/dhtmlwindow.js"></script>
        <script type="text/javascript" src="static/js/validationScripts.js"></script>

        <script src="static/mainpane/js/sockjs-0.3.4.js"></script>
        <script src="static/mainpane/js/stomp.js"></script>
        <script src="static/mainpane/js/websocketConn.js"></script>
        <!-- end: JAVASCRIPTS REQUIRED FOR THIS PAGE ONLY -->

        <script>
                            jQuery(document).ready(function () {
                                chat_init();
                                Main.init();
                                Index.init();
                            });

                            function logoutfn() {
                                var token = $("meta[name='_csrf']").attr("content");
                                var header = $("meta[name='_csrf_header']").attr("content");
                                var parameter = $("meta[name='_csrf_parameter']").attr("content");

                                var data = {};
                                var headers = {};

                                data[parameter] = token;
                                headers[header] = token;

                                $.ajax({
                                    cache: false,
                                    async: false,
                                    dataType: 'json',
                                    type: 'POST',
                                    headers: headers,
                                    data: data,
                                    contentType: 'application/json; charset=utf-8',
                                    url: '/IICS/j_spring_security_logout',
                                }).done(function () {
                                    location.reload(true);
                                    window.name = 0;
                                });

                            }
        </script>
    </body>
    <!-- end: BODY -->
</html>
