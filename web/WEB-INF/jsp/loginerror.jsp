<%-- 
    Document   : loginerror
    Created on : Jul 10, 2019, 9:08:01 AM
    Author     : IICS TECHS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="static/images/IICS.ico" rel="shortcut icon" type="image/x-icon"/>
        <title>IICS-HMIS</title>
    </head>
    <body>
        <%@include file="frontPage.jsp"%>
        <script>
            $(function(){
                $.confirm({
                    title: '',
                    content: '<h4>Invalid credentials. Please try again.</h4>',
                    boxWidth: '25%',
                    useBootstrap: false,
                    type: 'red',
                    typeAnimated: true,
                    closeIcon: true,
                    theme: 'modern',
                    buttons:{
                        TRYAGAIN:{
                            text: 'Try Again',
                            btnClass: 'btn-green',
                            action: function(){
                                $('#modal1').modal();
                            }
                        },
                        CANCEL:{
                            text: 'Cancel',
                            btnClass: 'btn-purple',
                            action: function(){
                                
                            }
                        }
                    }
                });
            });
        </script>
    </body>
</html>
