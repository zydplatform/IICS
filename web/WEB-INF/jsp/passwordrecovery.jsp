<%-- 
    Document   : passwordrecovery
    Created on : Sep 20, 2018, 5:21:43 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    @import "bourbon";

    body {
/*        background: #eee !important;	*/
/*        background-image: url("../../static/frontend/images/govt.jpg") !important;
        background-repeat: no-repeat !important;*/
    }

    .wrapper {	
        margin-top: 80px;
        margin-bottom: 80px;
    }

    .form-signin {
        max-width: 420px;
        padding: 15px 35px 45px;
        margin: 0 auto;
        background-color: #fff;
        border: 1px solid rgba(0,0,0,0.1);  

        .form-signin-heading,
        .checkbox {
            margin-bottom: 30px;
        }

        .checkbox {
            font-weight: normal;
        }

        .form-control {
            position: relative;
            font-size: 16px;
            height: auto;
            padding: 10px;
            &:focus {
                z-index: 2;
            }
        }

        input[type="text"] {
            margin-bottom: -1px;
            border-bottom-left-radius: 0;
            border-bottom-right-radius: 0;
        }

        input[type="password"] {
            margin-bottom: 20px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }
    }
    .btninput{
        margin-top: 1em;  
    }
    .algerian {
        text-shadow: 1px 1px 0 #FFFFFF, 2px 2px 0 #000000;
    }
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
        font-weight: 400;
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
        left: 60%;
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
    .wrapper img {
        vertical-align: middle;
    }

</style>
<div class="wrapper">
    <div class="form-signin">  
        <input type="hidden" value="${systemuserid}" id="systemuserid">
        <h3 class="algerian"><i class="fa fa-lg fa-fw fa-user"></i>Reset Account Credentials.</h3>
        <hr/>
        <input type="text" class="form-control btninput" id="newusername" name="username" placeholder="Enter new Username" required="" autofocus="" />
        <input type="password" class="form-control btninput" id="newpassword" name="password" placeholder="Enter new Password" required=""/>  
        <input type="password" class="form-control btninput" id="comfirmpassword" name="password" placeholder="confirm new password" required="" oninput="confirmPassword()"/>  
        <hr/>
        <button class="btn btn-primary btn-block btninput" id="submitrecoverycredentials" type="submit" onclick="submitnewcredentials()"><i class="fa fa-save"></i>Save</button>   
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

</div>
<script>
    function submitnewcredentials() {
        var newusername = $('#newusername').val();
        var newpassword = $('#newpassword').val();
        var systemuserid = $('#systemuserid').val();
        $.confirm({
            title: 'Congratulations!',
            content: 'Your New Username is: ' + '<font color="blue" style="font-size:24px;">' + newusername + '</font>' + '<br>' + 'Your new Password is:' + '<font color="blue" style="font-size:24px;">' + newpassword + '</font>',
            type: 'green',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Submit',
                    btnClass: 'btn-green',
                    action: function () {
                        $('#credentialsdiv').hide();
                        $('#securityqns').show();
                        $.ajax({
                            type: 'POST',
                            data: {systemuserid: systemuserid, newusername: newusername, newpassword: newpassword},
                            url: "usermanagement/save_recovered_credentials.htm",
                            success: function (data) {
                                 location.reload();
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
    function confirmPassword() {
        var newpassword = $('#newpassword').val();
        var comfirmpassword = $('#comfirmpassword').val();
        if (newpassword === comfirmpassword) {
            $('#comfirmpassword').removeClass('error-field');
            document.getElementById('comfirmpassword').style.borderColor = "purple";
            $("#submitrecoverycredentials").prop('disabled', false);
        } else {
            $('#comfirmpassword').addClass('error-field');
            $("#submitrecoverycredentials").prop('disabled', true);
        }
    }
    $(document).ready(function () {
        document.getElementById('submitrecoverycredentials').disabled = true;
        $('#newpassword').keyup(function () {
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
                document.getElementById('submitrecoverycredentials').disabled = false;
            } else {
                document.getElementById('newpassword').style.borderColor = 'red';
                document.getElementById('submitrecoverycredentials').disabled = true;
            }
        }).focus(function () {
            $('#pswd_info').show();
        }).blur(function () {
            $('#pswd_info').hide();
        });
    });

</script>