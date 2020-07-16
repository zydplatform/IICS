<%-- 
    Document   : errorusercredentials
    Created on : Oct 25, 2018, 3:57:55 PM
    Author     : HP
--%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <link href="static/images/IICS.ico" rel="shortcut icon" type="image/x-icon"/>
</head>
<body onload="Loadpageadded();">   
    <%@include file="frontPage.jsp" %>    
</body>
<script>
    function Loadpageadded() {
         var jsoncount = ${count};
        //<span style="margin-left:5em; font-size:.6em;">Attemps:<b class="text-danger">' + parseInt(jsoncount) + '</b></span>
        $.confirm({
            title: 'Error!',
            content:'<strong class="text-danger">Your Account is in use somewhere else.\n</strong><br><br><strong class="text-success"></strong>',
            type: 'red',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'LogOut',
                    btnClass: 'btn-danger',
                    action: function () {
                        $('#myModalshowlogin').modal('show');
                    }
                },
                close: function () {
                }
            }
        });
    }
</script>



