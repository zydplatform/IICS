<%-- 
    Document   : frontPage
    Created on : Mar 22, 2018, 9:26:46 PM
    Author     : IICS PROJECT
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Pharmaceuticals</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Free HTML5 Website Template by freehtml5.co" />
        <meta name="keywords" content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
        <link href="https://fonts.googleapis.com/css?family=Oxygen:300,400" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="static/frontend/css/animate.css">
        <link href="static/images/IICS.ico" rel="shortcut icon" type="image/x-icon"/>
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="static/frontend/css/bootstrap.css">
        <link rel="stylesheet" href="static/frontend/css/flexslider.css">
        <link rel="stylesheet" href="static/frontend/css/style.css">
        <script src="static/js/modernizr-2.6.2.min.js"></script>
        <script src="static/js/wow.js"></script>

        <script>
            new WOW().init();
        </script>
        <style>
            /*            *custom font*/
            @import url(https://fonts.googleapis.com/css?family=Montserrat);

            basic reset
            * {margin: 0; padding: 0;}

            html {
                height: 100%;
                background: linear-gradient(rgba(196, 102, 0, 0.6), rgba(155, 89, 182, 0.6));
            }

            body {
                font-family: montserrat, arial, verdana;
            }
            form styles
            #msform {
                width: 400px;
                margin: 50px auto;
                text-align: center;
                position: relative;
            }
            #msform fieldset {
                background: white;
                border: 0 none;
                border-radius: 3px;
                box-shadow: 0 0 15px 1px rgba(0, 0, 0, 0.4);
                padding: 20px 30px;
                box-sizing: border-box;
                width: 80%;
                margin: 0 10%;
                position: relative;
            }
            Hide all except first fieldset
            #msform fieldset:not(:first-of-type) {
                display: none;
            }
            inputs
            #msform input, #msform textarea {
                padding: 15px;
                border: 1px solid #ccc;
                border-radius: 3px;
                margin-bottom: 10px;
                width: 100%;
                box-sizing: border-box;
                font-family: montserrat;
                color: #2C3E50;
                font-size: 13px;
            }
            buttons
            #msform .action-button {
                width: 100px;
                background: #6e27ae;
                font-weight: bold;
                color: white;
                border: 0 none;
                border-radius: 1px;
                cursor: pointer;
                padding: 10px 5px;
                margin: 10px 5px;
            }
            #msform .action-button:hover, #msform .action-button:focus {
                box-shadow: 0 0 0 2px white, 0 0 0 3px #27AE60;
            }
            headings
            .fs-title {
                font-size: 15px;
                text-transform: uppercase;
                color: #2C3E50;
                margin-bottom: 10px;
            }
            .fs-subtitle {
                font-weight: normal;
                font-size: 13px;
                color: #666;
                margin-bottom: 20px;
            }
            progressbar
            #progressbar {
                margin-bottom: 30px;
                overflow: hidden;
                counter-reset: step;
            }
            #progressbar li {
                list-style-type: none;
                color: white;
                text-transform: uppercase;
                font-size: 9px;
                width: 33.33%;
                float: left;
                position: relative;
            }
            #progressbar li:before {
                content: counter(step);
                counter-increment: step;
                width: 20px;
                line-height: 20px;
                display: block;
                font-size: 10px;
                color: #333;
                background: white;
                border-radius: 3px;
                margin: 0 auto 5px auto;
            }
            progressbar connectors
            #progressbar li:after {
                content: '';
                width: 100%;
                height: 2px;
                background: white;
                position: absolute;
                left: -50%;
                top: 9px;
            }
            #progressbar li:first-child:after {
                content: none; 
            }
            #progressbar li.active:before,  #progressbar li.active:after{
                background: #6e27ae;
                color: white;
            }
        </style>
    </head>
    <body>
        <div id="page">
            <nav class="fh5co-nav " role="navigation" style="border-bottom: solid; border-bottom-color: yellow; background-color: black;">
                <div class="container-wrap">
                    <div class="top-menu">
                        <div class="row" id="topmenu">
                            <div class="col-md-12 ">
                                <div class="col-md-5" id="IICS">
                                    <a href="#"><img src="static/images/RightHand.png" /></a>
                                </div>
                                <div class="col-md-2" id="fh5co-logo">
                                    <a href="#"><img src="static/images/COA.png" /></a>
                                </div>
                                <div class="col-md-5   text-right menu-1" id="IICS1">
                                    <div class="col-md-12">
                                        <a href="#"><img src="static/images/LeftHand.png" /></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </nav>
            <div class="container-wrap">
                <aside id="fh5co-hero" style="border-top: solid;border-top-color: red">
                    <div class="flexslider">
                        <input id="username" value="${firstname} &nbsp;${lastname}" style="display: none">
                        <input id="id" value="${id}" style="display: none">
                        <div role="content" class="ui-content ">
                            <div align="center" id="dwnld-content">
                                <h1>WELCOME TO IICS</h1>
                                <h3>Your System is not configured.</h3>
                                <h3>Please download the configuration files from the link below.</h3>
                                <div>
                                    <a href="downloads.htm" download>
                                        <input type="button" value="Download Settings here" data-inline="true">
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </aside>
            </div><!-- END container-wrap -->

        </div>
        <div class="row">
            <div class="col-md-12 text-center" id="foot">
                <p style="color: black">
                    <small class="block">&copy; <strong>IICS TECHNOLOGIES  <script type="text/javascript">
                        document.write(new Date().getFullYear());</script>.All rights reserved</strong></small>
                </p>
            </div>
        </div>
    </body>
</html>
