
<%@include file="../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% int x = 0;%>
<div class="container-fluid" id="mmmainLocalSettingsConfigure">
    <div class="app-title">
        <div class="col-md-5">
            <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
            <p>Together We Save Lives...!</p>
        </div>
        <div>
            <div class="mmmains">
                <div class="wrapper">
                    <ul class="breadcrumbs">
                        <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Local Setting</a></li>
                        <li class="last active"><a href="#">Configure</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
  <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALDESIGNATIONSANDCATEGORY')">
  <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/PostsSysIcon2.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Designation Categories & Designations
                    </h4>
                </div>
            </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
   <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SYSUSERINTERNALUSERIDENTIFICATION')">
       <!--            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('localsettigs/registeruser.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img2/registerUser.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Register users
                    </h4>
                </div>
            </div>-->
             <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
<security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_FACILITYUNITSETUP')">   
    <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('facilityUnitSetUp.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img2/unityStructure.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Facility Unit Structure
                    </h4>
                </div>
            </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
</div>
  
</div>
<script>
    breadCrumb();
</script>
