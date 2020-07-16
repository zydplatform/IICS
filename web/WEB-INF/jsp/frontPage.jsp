<%-- 
    Document   : frontPage
    Created on : Mar 22, 2018, 9:26:46 PM
    Author     : IICS PROJECT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--        <title>Pharmaceuticals</title>-->
        <title>IICS-HMIS</title>
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
        <link rel="stylesheet" href="static/res/css/jquery-confirm/3.3.0/jquery-confirm.min.css">
        <link rel="stylesheet" href="static/res/css/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="static/resources/css/servicestatus.css">

        <script>
            new WOW().init();
        </script>
    </head>
    <body id="mainpage">
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
                                        <ul>
                                            <!--<li class="active"><a href="#">Home</a></li>-->
                                            <li><a href="#" data-toggle="modal" data-target="#modal1"><i class="fa fa-user"></i> Login</a></li>
                                            <li><a href="#">About</a></li>
                                        </ul>
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
                        <ul class="slides">
                            <li id="imgx">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-6 slider-text col-sm-6">
                                            <div class="slider-text-inner">
                                                <h1>A PLACE WHERE WE HOPE TO CURE.</h1>
                                            </div>
                                        </div>
                                        <ul>
                                            <li id="imgx1" class="wow slideInLeft " data-wow-duration="5s"></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li id="imgx">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-6 col-md-offset-3 col-md-push-3 slider-text col-sm-6">
                                            <div class="slider-text-inner">
                                                <h1>WHERE MEDICATION IS READILY AVAILABLE.</h1>
                                            </div>
                                        </div>
                                        <ul class="wow slideInRight" data-wow-duration="10s">
                                            <li id="imgx2"></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li id="imgx">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-6 col-md-offset-3 slider-text">
                                            <div class="slider-text-inner text-center">
                                                <h1>WHERE PATIENTS HOPE TO HEAL.</h1>
                                            </div>
                                        </div>
                                        <ul class="wow slideInLeft" data-wow-duration="15s">
                                            <li id="imgx3"></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li id="imgx4">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-6 col-md-offset-3 col-md-push-3 slider-text">
                                            <div class="slider-text-inner">
                                                <h1 style="margin-top: -2em"> TOGETHER WE SAVE LIVES!</h1>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </aside>
            </div><!-- END container-wrap -->
            <div class="modal" id="modal1" role="dialog">
                <div class="modal-dialog" style="max-width: 500px!important">
                    <div class="modal-content"  id="login-form">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h3 class="login-head"><i class="fa fa-lg fa-fw fa-user"></i>Registered members login</h3>
                        </div>
                        <fieldset>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label" id="space1">USERNAME:</label>
                                            <label class="control-label" id="space2" >PASSWORD:</label>
                                        </div>
                                    </div>
                                    <div class="col-md-9" >
                                        <input class="form-control"  autofocus id="oldusername" type="text" placeholder="username" required size="15">
                                        <small style="display: none" class="form-text text-muted" id="errUsername"><strong><font color="red">Please Enter User Name! </font></strong><i style="font-size: 15px; color: red" class="fa fa-hand-o-up"></i></small><br><br>

                                        <input class="form-control"  id='oldpasswrd' type="password" placeholder="Password" required size="15">
                                        <small style="display: none" class="form-text text-muted" id="errPassword"><strong><font color="red">Please Enter Password! </font></strong><i style="font-size: 15px; color: red" class="fa fa-hand-o-up"></i></small></small>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-7"></div>
                                        <div class="col-md-4">
                                            <a href="#"><span onclick="forgotpassword()"><font color="purple">Forgot Password?</font></span></a> 
                                        </div>
                                        <div class="col-md-1"></div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>

                        <form name="form2" id="form2" method="post" action="j_spring_security_check" class='form-login'>
                            <%--<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>--%>
                            <fieldset>
                                <div>
                                    <input class="form-control" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input class="form-control" name="j_username" id="username" type="hidden">
                                    <input class="form-control" name="j_password" id='passwrd' type="hidden" >

                                </div>
                                <div class="modal-footer">
                                    <div class="form-group btn-container">
                                        <button id="btnSubmitLogin" class="btn btn-primary btn-block" onClick="
                                                if ($('#oldusername').val() === '' || $('#oldpasswrd').val() === '' || typeof $('#oldusername').val() === 'undefined' || $('#oldusername').val() === null || typeof $('#oldpasswrd').val() === 'undefined' || $('#oldpasswrd').val() === null) {
                                                    if ($('#oldusername').val() === '' || typeof $('#oldusername').val() === 'undefined' || $('#oldusername').val() === null) {
                                                        $('#oldusername').css({'border': '2px solid #f50808c4'});
                                                        $('#errUsername').show();
                                                        $('#errPassword').hide();
                                                        $('#oldpasswrd').css({'border': '2px solid #ced4da'});
                                                        return false;
                                                    }
                                                    if ($('#oldpasswrd').val() === '' || typeof $('#oldpasswrd').val() === 'undefined' || $('#oldpasswrd').val() === null) {
                                                        $('#oldpasswrd').css({'border': '2px solid #f50808c4'});
                                                        $('#errPassword').show();
                                                        $('#errUsername').hide();
                                                        $('#oldusername').css({'border': '2px solid #ced4da'});
                                                        return false;
                                                    }
                                                } else {
                                                    $('#oldusername').css({'border': '2px solid #ced4da'});
                                                    $('#oldpasswrd').css({'border': '2px solid #ced4da'});
                                                    $('#errUsername').hide();
                                                    $('#errPassword').hide();
                                                    var uname = $('#oldusername').val();
                                                    var psd = $('#oldpasswrd').val();
                                                    $('#username').val(uname);
                                                    $('#passwrd').val(psd);

                                                    $('#oldpasswrd').val('.......').style.fontSize = 'xx-large';
                                                    $('#oldpasswrd').attr('type', 'text');

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
                            </fieldset>
                        </form>
                    </div>
                    <div class="modal-content" style="display: none" id="passwordrecoveryform">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h3 class="login-head"><i class="fa fa-lg fa-fw fa-user"></i>Password Recovery Form</h3>
                        </div>
                        <fieldset>
                            <div class="modal-body">
                                <a href="#" id="#loginbackbutton" onclick="backone()"><i class="fa fa-long-arrow-left"></i></a>
                                <div class="row" id="passwordrecoveryform">
                                    <div class="col-md-1">

                                    </div>
                                    <div class="col-md-10">
                                        <div id="mailfeedback" style="display: none">
                                            <div class="alert alert-info">
                                                <strong>Note:</strong>Please provide a valid Email Address. 
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputEmail1">Email address</label>
                                            <input class="form-control" id="inputemail" type="email" aria-describedby="emailHelp" placeholder="Enter email">
                                        </div>
                                    </div>
                                    <div class="col-md-1"></div>

                                </div>
                            </div>

                        </fieldset>
                        <div class="modal-footer">
                            <div class="form-group btn-container">
                                <button id="continuefrominputmail" class="btn btn-primary btn-block" onclick="fetchsavedqns()"><i class="fa fa-sign-in fa-lg fa-fw"></i>Continue</button>
                            </div>
                        </div>
                    </div>
                    <div class="modal-content" style="display: none" id="answerfirstqn">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h3 class="login-head"><i class="fa fa-lg fa-fw fa-user"></i>Please answer the Question Below.</h3><br>
                            <div class="alert alert-danger">
                                <strong>Note:</strong>Please provide the exact answer that you provided to the question below while you were registering.
                            </div>
                        </div>
                        <fieldset>
                            <div class="modal-body">
                                <div class="row" id="">
                                    <div class="col-md-1">

                                    </div>
                                    <div class="col-md-10">
                                        <div class="form-group">
                                            <label for="exampleInputEmail1" id="qncontent"></label>
                                            <input type="hidden" id="hiddenqn">
                                            <input type="hidden" id="systemuserid">
                                            <input class="form-control" id="inputanswer" type="text" aria-describedby="emailHelp" placeholder="Enter answer.">
                                        </div>
                                        <div id="mailfeedback"></div>
                                    </div>
                                    <div class="col-md-1">

                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <div class="modal-footer">
                            <div class="form-group btn-container">
                                <button id="submitanswer" class="btn btn-primary btn-block" onclick="submitanswer()"><i class="fa fa-sign-in fa-lg fa-fw"></i>Submit</button>
                            </div>
                        </div>
                    </div>
                    <div class="modal-content" style="display: none" id="answersecondqn">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h3 class="login-head"><i class="fa fa-lg fa-fw fa-user"></i>Please  answer your second question..</h3><br>
                            <div class="alert alert-danger">
                                <strong>Note:</strong>Please provide the exact answer that you provided to the question below while you were registering.
                            </div>
                        </div>
                        <fieldset>
                            <div class="modal-body">
                                <div class="row" id="">
                                    <div class="col-md-1">

                                    </div>
                                    <div class="col-md-10">
                                        <div class="form-group">
                                            <label for="exampleInputEmail1" id="qn2content"></label>
                                            <input type="hidden" id="hiddenqn2">
                                            <input type="hidden" id="systemuserid2">
                                            <input class="form-control" id="inputsecondanswer" type="text" aria-describedby="emailHelp" placeholder="Enter answer.">
                                        </div>
                                        <div id="mailfeedback"></div>
                                    </div>
                                    <div class="col-md-1">

                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <div class="modal-footer">
                            <div class="form-group btn-container">
                                <button id="submitsecondanswer" class="btn btn-primary btn-block" onclick="submitsecondanswer()"><i class="fa fa-sign-in fa-lg fa-fw"></i>Submit</button>
                            </div>
                        </div>
                    </div>
                    <div class="modal-content" style="display: none" id="answerthirdqn">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h3 class="login-head"><i class="fa fa-lg fa-fw fa-user"></i>Please  answer your last question..</h3><br>
                            <div class="alert alert-danger" style="background-color: red">
                                <strong style="color: white">Note:</strong><span style="color: white">This is your last chance to provide a correct answer to your question.</span>
                            </div>
                        </div>
                        <fieldset>
                            <div class="modal-body">
                                <div class="row" id="">
                                    <div class="col-md-1">

                                    </div>
                                    <div class="col-md-10">
                                        <div class="form-group">
                                            <label for="exampleInputEmail1" id="qn3content"></label>
                                            <input type="hidden" id="hiddenqn3">
                                            <input type="hidden" id="systemuserid3">
                                            <input class="form-control" id="inputthirdanswer" type="text" aria-describedby="emailHelp" placeholder="Enter answer.">
                                        </div>
                                        <div id="mailfeedback"></div>
                                    </div>
                                    <div class="col-md-1">

                                    </div>
                                    <input type="hidden" id="clicks">
                                </div>
                            </div>
                        </fieldset>
                        <div class="modal-footer">
                            <div class="form-group btn-container">
                                <button id="submitthirdanswer" class="btn btn-primary btn-block" onclick="submitthirddanswer()"><i class="fa fa-sign-in fa-lg fa-fw"></i>Submit</button>
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 text-center" id="foot">
                <p style="color: white">
                    <small class="block">&copy; <strong>IICS TECHNOLOGIES&nbsp;
                            <script type="text/javascript">
                                document.write(new Date().getFullYear());
                            </script>. All rights reserved.
                        </strong>
                    </small>
                </p>
            </div>
        </div>
        <!-- jQuery -->
        <script src="static/js/jquery.min.js"></script>
        <!-- jQuery Easing -->
        <script src="static/js/jquery.easing.1.3.js"></script>
        <!-- Bootstrap -->
        <script src="static/js/bootstrap.min.js"></script>
        <!-- Waypoints -->
        <script src="static/js/jquery.waypoints.min.js"></script>
        <!-- Flexslider -->
        <script src="static/js/jquery.flexslider-min.js"></script>
        <!-- Magnific Popup -->
        <script src="static/js/jquery.magnific-popup.min.js"></script>
        <script src="static/js/magnific-popup-options.js"></script>
        <!-- Counters -->
        <script src="static/js/jquery.countTo.js"></script>
        <script type="text/javascript" src="static/js/ajaxCalls.js"></script>
        <!-- Main -->
        <script src="static/js/main.js"></script>
        <script src="static/res/js/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
        <script src="static/res/js/sec/md5.min.js"></script>
    </body>
</html>
<script>
                                function backone() {
                                    $('#passwordrecoveryform').hide();
                                    $('#login-form').show();

                                }

                                function forgotpassword() {
                                    $('#login-form').hide();
                                    $('#passwordrecoveryform').show();

                                }
                                $('#inputemail').on('input', function () {
                                    document.getElementById('inputemail').style.borderColor = "purple";
                                    var inputemail = $('#inputemail').val();
                                    $.ajax({
                                        type: 'POST',
                                        data: {searchValue: inputemail, type: 'email'},
                                        url: "usermanagement/searchemail.htm",
                                        success: function (data) {
                                            if (data === 'existing') {
                                                $('#mailfeedback').hide();
                                                document.getElementById('continuefrominputmail').disabled = false;

                                            } else {
                                                $('#mailfeedback').show();
                                                document.getElementById('continuefrominputmail').disabled = true;
                                            }
                                        }
                                    });

                                });

                                function fetchsavedqns() {
                                    var inputmail = $('#inputemail').val();
                                    if (inputmail === '') {
                                        document.getElementById('inputemail').style.borderColor = "red";
                                    } else {
                                        $.ajax({
                                            type: 'POST',
                                            data: {inputmail: inputmail},
                                            url: "usermanagement/retrievequestions.htm",
                                            success: function (data) {
                                                $('#passwordrecoveryform').hide();
                                                $('#answerfirstqn').show();
                                                var response = JSON.parse(data);
                                                for (index in response) {
                                                    var result = response[index];
                                                    document.getElementById('qncontent').innerHTML = result["question"];
                                                    document.getElementById('hiddenqn').value = result["questionsid"];
                                                    document.getElementById('systemuserid').value = result["systemuserid"];
                                                }
                                            }
                                        });
                                    }

                                }
                                function submitanswer() {
//                                    var regex = /[^A-Z0-9]/ig;
                                    var qnid = $('#hiddenqn').val();
                                    var answer = $('#inputanswer').val();
//                                    var resultanswer = answer.replace(regex, '');
//                                    var lowercaseanswer = resultanswer.toLowerCase();
                                    var userid = $('#systemuserid').val();
                                    if (answer === '') {
                                        document.getElementById('inputanswer').style.borderColor = "red";
                                    } else {
                                        $.ajax({
                                            type: 'POST',
                                            data: {qnid: qnid, answer: answer, userid: userid},
                                            url: "usermanagement/submitanswer.htm",
                                            success: function (data) {
                                                if (data === 'EQUAL') {
                                                    $.confirm({
                                                        title: 'Success!',
                                                        content: 'The answer provided is correct.Please proceed to the next step.',
                                                        type: 'purple',
                                                        typeAnimated: true,
                                                        buttons: {
                                                            tryAgain: {
                                                                text: 'Ok',
                                                                btnClass: 'btn-purple',
                                                                action: function () {
                                                                    $.ajax({
                                                                        dataType: 'text',
                                                                        data: {userid: userid},
                                                                        type: 'GET',
                                                                        url: "usermanagement/passwordrecoveryform.htm",
                                                                        success: function (data) {
                                                                            $('#mainpage').html(data);
                                                                        }
                                                                    });
                                                                }
                                                            },
                                                            close: function () {
                                                                location.reload();
                                                            }
                                                        }
                                                    });
                                                } else {
                                                    $.confirm({
                                                        title: 'Encountered an error!',
                                                        content: 'The answer you have provided is not the same as the one you submitted before.',
                                                        type: 'red',
                                                        typeAnimated: true,
                                                        boxWidth: '100%',
                                                        buttons: {
                                                            tryAgain: {
                                                                text: 'Try Again.',
                                                                btnClass: 'btn-red',
                                                                action: function () {
                                                                }
                                                            },
                                                            tryAgain2: {
                                                                text: 'Load second Question.',
                                                                btnClass: 'btn-blue',
                                                                action: function () {
                                                                    $.ajax({
                                                                        type: 'POST',
                                                                        data: {qnid1: qnid, userid: userid},
                                                                        url: "usermanagement/load_second_question.htm",
                                                                        success: function (data) {
                                                                            $('#answerfirstqn').hide();
                                                                            $('#answersecondqn').show();
                                                                            var response = JSON.parse(data);
                                                                            for (index in response) {
                                                                                var result = response[index];
                                                                                document.getElementById('qn2content').innerHTML = result["question"];
                                                                                document.getElementById('hiddenqn2').value = result["questionsid"];
                                                                                document.getElementById('systemuserid2').value = result["systemuserid"];
                                                                            }
                                                                        }
                                                                    });

                                                                }
                                                            },
                                                            close: function () {
                                                                location.reload();
                                                            }
                                                        }
                                                    });

                                                }

                                            }
                                        });
                                    }
                                }
                                function submitsecondanswer() {
//                                    var regex = /[^A-Z0-9]/ig;
                                    var qnid = $('#hiddenqn2').val();
                                    var qnid1 = $('#hiddenqn').val();
                                    var answer = $('#inputsecondanswer').val();
//                                    var resultanswer = answer.replace(regex, '');
//                                    var lowercaseanswer = resultanswer.toLowerCase();
                                    var userid = $('#systemuserid2').val();
                                    if (answer === '') {
                                        document.getElementById('inputsecondanswer').style.borderColor = "red";
                                    } else {
                                        $.ajax({
                                            type: 'POST',
                                            data: {qnid: qnid, answer: answer, userid: userid},
                                            url: "usermanagement/submitanswer.htm",
                                            success: function (data) {
                                                if (data === 'EQUAL') {
                                                    $.confirm({
                                                        title: 'Success!',
                                                        content: 'The answer provided is correct.Please proceed to the next step.',
                                                        type: 'purple',
                                                        typeAnimated: true,
                                                        buttons: {
                                                            tryAgain: {
                                                                text: 'Ok',
                                                                btnClass: 'btn-purple',
                                                                action: function () {
                                                                    $.ajax({
                                                                        dataType: 'text',
                                                                        data: {userid: userid},
                                                                        type: 'GET',
                                                                        url: "usermanagement/passwordrecoveryform.htm",
                                                                        success: function (data) {
                                                                            $('#mainpage').html(data);
                                                                        }
                                                                    });
                                                                }
                                                            },
                                                            close: function () {
                                                                location.reload();
                                                            }
                                                        }
                                                    });
                                                } else {
                                                    $.confirm({
                                                        title: 'Encountered an error!',
                                                        content: 'The answer you have provided is not the same as the one you submitted before.',
                                                        type: 'red',
                                                        typeAnimated: true,
                                                        boxWidth: '100%',
                                                        buttons: {
                                                            tryAgain: {
                                                                text: 'Try Again.',
                                                                btnClass: 'btn-red',
                                                                action: function () {
                                                                }
                                                            },
                                                            tryAgain2: {
                                                                text: 'Load third Question.',
                                                                btnClass: 'btn-blue',
                                                                action: function () {
                                                                    $.ajax({
                                                                        type: 'POST',
                                                                        data: {qnid1: qnid, userid: userid, qnid2: qnid1},
                                                                        url: "usermanagement/load_third_question.htm",
                                                                        success: function (data) {
                                                                            $('#answersecondqn').hide();
                                                                            $('#answerthirdqn').show();
                                                                            var response = JSON.parse(data);
                                                                            for (index in response) {
                                                                                var result = response[index];
                                                                                document.getElementById('qn3content').innerHTML = result["question"];
                                                                                document.getElementById('hiddenqn3').value = result["questionsid"];
                                                                                document.getElementById('systemuserid3').value = result["systemuserid"];
                                                                            }
                                                                        }
                                                                    });

                                                                }
                                                            },
                                                            close: function () {
                                                                location.reload();
                                                            }
                                                        }
                                                    });
                                                }
                                            }
                                        });
                                    }
                                }
                                var addOnClickCounts = (function () {
                                    var counter = 0;
                                    return function () {
                                        return counter += 1;
                                    }
                                })();
                                function submitthirddanswer() {
                                    document.getElementById("clicks").value = addOnClickCounts();
                                    var clicks = $('#clicks').val();
//                                    var regex = /[^A-Z0-9]/ig;
                                    var answer = $('#inputthirdanswer').val();
//                                    var resultanswer = answer.replace(regex, '');
//                                    var lowercaseanswer = resultanswer.toLowerCase();
                                    var userid = $('#systemuserid3').val();
                                    var qnid = $('#hiddenqn3').val();
                                    if (answer === '') {
                                        document.getElementById('inputthirdanswer').style.borderColor = "red";
                                    } else {
                                        if (clicks <= 3) {
                                            $.ajax({
                                                type: 'POST',
                                                data: {qnid: qnid, answer: answer, userid: userid},
                                                url: "usermanagement/submitanswer.htm",
                                                success: function (data) {
                                                    if (data === 'EQUAL') {
                                                        $.confirm({
                                                            title: 'Success!',
                                                            content: 'The answer provided is correct.Please proceed to the next step.',
                                                            type: 'purple',
                                                            typeAnimated: true,
                                                            buttons: {
                                                                tryAgain: {
                                                                    text: 'Ok',
                                                                    btnClass: 'btn-purple',
                                                                    action: function () {
                                                                        $.ajax({
                                                                            dataType: 'text',
                                                                            data: {userid: userid},
                                                                            type: 'GET',
                                                                            url: "usermanagement/passwordrecoveryform.htm",
                                                                            success: function (data) {
                                                                                $('#mainpage').html(data);
                                                                            }
                                                                        });
                                                                    }
                                                                },
                                                                close: function () {
                                                                    location.reload();
                                                                }
                                                            }
                                                        });
                                                    } else {
                                                        $.confirm({
                                                            title: 'Encountered an error!',
                                                            content: 'The answer you have provided is not the same as the one you submitted before.',
                                                            type: 'red',
                                                            typeAnimated: true,
                                                            boxWidth: '100%',
                                                            buttons: {
                                                                tryAgain: {
                                                                    text: 'Try Again.',
                                                                    btnClass: 'btn-red',
                                                                    action: function () {
                                                                    }
                                                                },
                                                                close: function () {
                                                                    location.reload();
                                                                }
                                                            }
                                                        });
                                                    }
                                                }
                                            });
                                        }
                                        //TEST IF THE NUMBER OF CLICKS IS MORE THAN 3-------Please make sure you dont forget to deactivate user
                                        else {
                                            $.confirm({
                                                title: 'Oops!!'+'<hr>',
                                                content: 'Your account has been deactivated,Contact your Supervisor for help.',
                                                type: 'red',
                                                typeAnimated: true,
                                                buttons: {
                                                    tryAgain: {
                                                        text: 'OK',
                                                        btnClass: 'btn-red',
                                                        action: function () {
                                                        }
                                                    },
                                                    close: function () {
                                                    }
                                                }
                                            });
                                        }
                                    }
                                }

                                $('#inputanswer').on('input', function () {
                                    document.getElementById('inputanswer').style.borderColor = "purple";
                                });
                                $(document).on('shown.bs.modal', function (e) {
                                    $('[autofocus]', e.target).focus();

                                });

                                var oldusername = document.getElementById("oldusername");
                                var oldpasswrd = document.getElementById("oldpasswrd");

                                oldusername.addEventListener("keyup", function (event) {
                                    event.preventDefault();
                                    if (event.keyCode === 13) {
                                        var name = ($("#oldusername").val()).toString();
                                        if (name.length > 0)
                                            $('#oldpasswrd').focus();
                                        document.getElementById("btnSubmitLogin").click();
                                    }
                                });

                                oldpasswrd.addEventListener("keyup", function (event) {
                                    event.preventDefault();
                                    if (event.keyCode === 13) {
                                        document.getElementById("btnSubmitLogin").click();
                                    }
                                });
</script>
