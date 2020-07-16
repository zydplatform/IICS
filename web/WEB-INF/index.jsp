<%-- 
    Document   : frontIndex
    Created on : Nov 23, 2017, 3:44:51 PM
    Author     : samuelwam
--%>
<%@include file="jsp/include.jsp" %>
<!DOCTYPE html>
<%@page session="true"%>
<html lang="en">
    <!--<![endif]-->
    <!-- start: HEAD -->
    <head>
        <title>IICS-SMS</title>
        <!-- start: META -->
        <!--[if IE]><meta http-equiv='X-UA-Compatible' content="IE=edge,IE=9,IE=8,chrome=1" /><![endif]-->
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta content="" name="description" />
        <meta content="" name="author" />
        <!-- end: META -->
        <!-- start: MAIN CSS -->
        <link href="static/images/IICS.ico" rel="shortcut icon" type="image/x-icon"/>
        <link href="static/frontend/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link rel="stylesheet" href="static/frontend/plugins/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="static/frontend/fonts/style.css">
        <link rel="stylesheet" href="static/frontend/plugins/animate.css/animate.min.css">
        <link rel="stylesheet" href="static/frontend/css/main.css">
        <link rel="stylesheet" href="static/frontend/css/main-responsive.css">
        <link rel="stylesheet" href="static/frontend/css/theme_black.css" type="text/css" id="skin_color">
        <!-- end: MAIN CSS -->
        <!-- start: CSS REQUIRED FOR THIS PAGE ONLY -->
        <link rel="stylesheet" href="static/frontend/plugins/revolution_slider/rs-plugin/css/settings.css">
        <link rel="stylesheet" href="static/frontend/plugins/flex-slider/flexslider.css">
        <link rel="stylesheet" href="static/frontend/plugins/colorbox/example2/colorbox.css">
        <!-- end: CSS REQUIRED FOR THIS PAGE ONLY -->
        <!-- start: HTML5SHIV FOR IE8 -->
        <!--[if lt IE 9]>
        <script src="assets/plugins/html5shiv.js"></script>
        <![endif]-->
        <!-- end: HTML5SHIV FOR IE8 -->
    </head>
    <!-- end: HEAD -->
    <body>
        <!-- start: HEADER -->
        <header>
            <!-- start: SLIDING BAR (SB) -->
            <div id="slidingbar-area">
                <div id="slidingbar">
                    <!-- start: SLIDING BAR FIRST COLUMN -->
                    <div class="col-md-4 col-sm-4">
                        <h2>About DMS</h2>
                        <p>
                            About SchoolMate School Management System
                            <security:authorize access="isAuthenticated()" ifAnyGranted="ROLE_ANONYMOUS">
                                ROLE_ANONYMOUS
                            </security:authorize>
                            <security:authorize access="isAuthenticated()" ifAnyGranted="ROLE_USER">
                                ROLE_USER
                            </security:authorize>
                        </p>
                    </div>

                    <!-- end: SLIDING BAR THIRD COLUMN -->
                </div>
                <!-- start: SLIDING BAR TOGGLE BUTTON -->
                <a href="#" class="sb_toggle">
                </a>
                <!-- end: SLIDING BAR TOGGLE BUTTON -->
            </div>
            <!-- end: SLIDING BAR -->
            <!-- start: TOP BAR -->
            <!-- end: TOP BAR -->
            <div role="navigation" class="navbar navbar-default navbar-fixed-top space-top">
                <!-- start: TOP NAVIGATION CONTAINER -->
                <div class="container">
                    <div class="navbar-header">
                        <!-- start: LOGO -->
                        <a class="navbar-brand" href="newIndex.htm">
                            <img src="static/frontend/images/schoolMate.png" width="80px" height="80px"/>
                        </a>
                        <!-- end: LOGO -->
                    </div>
                    <div style="float:right">
                        <img src="static/frontend/images/govt.jpg" width="80px" height="80px"/>
                    </div>

                </div>

                <!-- end: TOP NAVIGATION CONTAINER -->
            </div>
            <img src="static/frontend/images/byrUg.png" width="100%" />
        </header>
        <!-- end: HEADER -->

        <!-- start: MAIN CONTAINER -->
        <div class="main-container">

            <!-- start: REVOLUTION SLIDERS -->
            <section class="fullwidthbanner-container">
                <div class="fullwidthabnner">
                    <ul>
                        <!-- start: FIRST SLIDE -->
                        <li data-transition="fade" data-slotamount="7" data-masterspeed="1500" >
                            <img src="static/frontend/images/sliders/loginInSlide1.png"  style="background-color:rgb(246, 246, 246)" alt="slidebg1"  data-bgfit="cover" data-bgposition="left bottom" data-bgrepeat="no-repeat">
                            <div class="caption lft slide_title slide_item_left"
                                 data-x="0"
                                 data-y="105"
                                 data-speed="400"
                                 data-start="1500"
                                 data-easing="easeOutExpo">
                                Connect And Swipe                                </div>
                            <div class="caption lft slide_subtitle slide_item_left"
                                 data-x="0"
                                 data-y="180"
                                 data-speed="400"
                                 data-start="2000"
                                 data-easing="easeOutExpo">
                                Biometric Login							</div>
                            <div class="caption lft slide_desc slide_item_left"
                                 data-x="0"
                                 data-y="220"
                                 data-speed="400"
                                 data-start="2500"
                                 data-easing="easeOutExpo">
                                For your biometric login to the application,
                                <br>
                                ensure biometric authenticator is connected and ready.							</div>
                            <a class="caption lft btn btn-bricky slide_btn slide_item_left" href="#" onClick="window.open('mainPage.htm');"
                               data-x="0"
                               data-y="320"
                               data-speed="400"
                               data-start="3000"
                               data-easing="easeOutExpo">
                                Login?							</a>
                            <div class="caption sfr"
                                 data-x="720"
                                 data-y="55"
                                 data-speed="700"
                                 data-start="1000"
                                 data-easing="easeOutExpo"  >
                                <img src="static/frontend/images/fingerPrintIndex2.png" width="350px" height="350px" alt="Finger Print">							</div>
                        </li>
                        <!-- end: FIRST SLIDE -->
                        <!-- start: SECOND SLIDE -->
                        <li data-transition="fade" data-slotamount="7" data-masterspeed="1500" >
                            <img src="static/frontend/images/sliders/loginInSlide2.png"  style="background-color:rgb(246, 246, 246)" alt="slidebg1"  data-bgfit="cover" data-bgposition="left bottom" data-bgrepeat="no-repeat">
                            <div class="caption lft slide_title slide_item_left"
                                 data-x="0"
                                 data-y="105"
                                 data-speed="400"
                                 data-start="1500"
                                 data-easing="easeOutExpo">
                                Security Question							</div>
                            <div class="caption lfl slide_subtitle slide_item_left"
                                 data-x="0"
                                 data-y="180"
                                 data-speed="400"
                                 data-start="2000"
                                 data-easing="easeOutExpo">
                                Answer Question							</div>
                            <div class="caption lfr slide_desc slide_item_left"
                                 data-x="0"
                                 data-y="220"
                                 data-speed="400"
                                 data-start="2500"
                                 data-easing="easeOutExpo">
                                Protecting you from identity theft and fraud.
                                <br>
                                Authenticator will require you to answer some questions.							</div>
                            <a class="caption lfb btn btn-bricky slide_btn slide_item_left" href="#" onClick="window.open('mainPage.htm');"
                               data-x="0"
                               data-y="320"
                               data-speed="400"
                               data-start="3000"
                               data-easing="easeOutExpo">
                                Login!							</a>
                            <div class="caption sfr"
                                 data-x="700"
                                 data-y="55"
                                 data-speed="700"
                                 data-start="1000"
                                 data-easing="easeOutExpo"  >
                                <img src="static/frontend/images/sQnIndex2.png" width="350px" height="350px" alt="Security Qns">							</div>
                        </li>
                        <!-- end: SECOND SLIDE -->
                    </ul>
                </div>
            </section>			
        </div>

        <footer id="footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-7">
                        <p>
                            &copy; Copyright 2017 by IICS-SchoolMate School Management System. All Rights Reserved.
                        </p>
                    </div>

                </div>
            </div>
        </footer>
        <a id="scroll-top" href="#"><i class="fa fa-angle-up"></i></a>
        <!-- end: FOOTER -->
        <!-- start: MAIN JAVASCRIPTS -->
        <!--[if lt IE 9]>
        <script src="assets/plugins/respond.min.js"></script>
        <script src="assets/plugins/excanvas.min.js"></script>
        <script src="assets/plugins/html5shiv.js"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <![endif]-->
        <!--[if gte IE 9]><!-->
        <script type="text/javascript" src="static/frontend/js/jquery/jquery-3.1.0.min.js"></script>

        <!--<![endif]-->
        <script src="static/frontend/plugins/bootstrap/js/bootstrap.min.js"></script>
        <script src="static/frontend/plugins/jquery.transit/jquery.transit.js"></script>
        <script src="static/frontend/plugins/hover-dropdown/twitter-bootstrap-hover-dropdown.min.js"></script>
        <script src="static/frontend/plugins/jquery.appear/jquery.appear.js"></script>
        <script src="static/frontend/plugins/blockUI/jquery.blockUI.js"></script>
        <script src="static/frontend/plugins/jquery-cookie/jquery.cookie.js"></script>
        <script src="static/frontend/js/main.js"></script>
        <!-- end: MAIN JAVASCRIPTS -->
        <!-- start: JAVASCRIPTS REQUIRED FOR THIS PAGE ONLY -->
        <script src="static/frontend/plugins/revolution_slider/rs-plugin/js/jquery.themepunch.plugins.min.js"></script>
        <script src="static/frontend/plugins/revolution_slider/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
        <script src="static/frontend/plugins/flex-slider/jquery.flexslider.js"></script>
        <script src="static/frontend/plugins/stellar.js/jquery.stellar.min.js"></script>
        <script src="static/frontend/plugins/colorbox/jquery.colorbox-min.js"></script>
        <script src="static/frontend/js/index.js"></script>
        <!-- end: JAVASCRIPTS REQUIRED FOR THIS PAGE ONLY -->
        <script>
            jQuery(document).ready(function() {
                Main.init();
                Index.init();
                $.stellar();
            });
        </script>
    </body>
</html>
