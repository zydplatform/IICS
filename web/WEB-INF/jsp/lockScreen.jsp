<%-- 
    Document   : lockScreen
    Created on : May 2, 2018, 9:17:50 AM
    Author     : IICS PROJECT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="static/res/css/main.css">
        <!--        <link rel="stylesheet" href="static/frontend/css/style.css">-->
        <link href="static/images/IICS.ico" rel="shortcut icon" type="image/x-icon"/>
        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!--        <title>IICS</title>-->
        <title>IICS-HMIS</title>
    </head>
    <body>
        <div class="modal fade " id="jitp-warn-display" data-backdrop="static" data-keyboard="false" style="margin-top: 10em">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header"><h4 class="modal-title">Session Timeout <i class="fa fa-warning"></i></h4></div>
                    <!--                    <form name="form2" id="form2" method="post" action="j_spring_security_check" class='form-login'>-->
                    <fieldset>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-3" >
                                    <div class="form-group">
                                        <label class="control-label" id="space1" style="margin-top: 1em">USERNAME:</label>
                                        <label class="control-label" id="space2"  style="margin-top: 3em">PASSWORD:</label>
                                    </div>
                                </div>
                                <div class="col-md-9" style="margin-top: 1em">
                                    <input class="form-control" name="j_username" id="username" type="hidden" value="${model.username}" required>
                                    <input class="form-control" type="text" value="${model.username}" style="margin-bottom: 2.5em" disabled="true" required>
                                    <input class="form-control" name="j_password" id='passwrd' type="password" placeholder="Password" required size="15" autofocus="autofocus">
                                </div>

                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="form-group ">
                                <button class="btn btn-primary " onClick="unlock();"><i class="fa fa-sign-in fa-lg fa-fw"></i>Stay Connected
                                </button>
                                <button id="jitp-warn-logout" type="button" class="btn btn-default"><a id="jitp-warn-logout" href="<c:url value='j_spring_security_logout'/>">Log out</a></button>
                            </div>
                        </div>
                    </fieldset> 
                    <!--                    </form>-->
                </div>
            </div>
        </div>
   
    <script src="static/res/js/sec/md5.min.js"></script>
    <script>
                                    function unlock() {
                                        $.ajax({
                                            url: 'unlock.htm',
                                            type: 'POST',
                                            success: function (data) {
                                                var fields = data.split(',');
                                                var username1 = fields[0];
                                                var password1 = fields[1];
                                                $.jStorage.set("username", username1);
                                                $.jStorage.set("password", password1);
                                                $.jStorage.get("username");
                                                $.jStorage.get("password");
                                                var k = $.jStorage.get("password");

                                                var user = $('#passwrd').val();
                                                var pass = md5(user);
                                                if (pass === $.jStorage.get("password")) {
                                                    $('#jitp-warn-display').modal('hide');
                                                } else {
                                                    document.getElementById('passwrd').style.borderColor = "red";
                                                }
                                            },
                                            error: function (err) {
                                                alert(err);
                                            }
                                        });
                                    }
    </script>    
</body>
</html>
