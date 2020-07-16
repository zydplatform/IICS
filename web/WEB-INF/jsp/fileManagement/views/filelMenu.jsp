
<% int f = 0;%>
<%@include file="../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<div id="mmmainfilemenu">
    <div class="app-title" id="">
        <div class="col-md-5">
            <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
            <p>Together We Save Lives...!</p>
        </div>

        <div>
            <div class="mmmains">
                <div class="wrapper">
                    <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                        <li class="last active"><a href="#">Patient Files</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEFILES')">
            <div class="col-sm-4 col-md-4 menu-icon" align="center" onclick="ajaxSubmitData('patients/list.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img  src="static/img/filemanage.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h2>
                        Manage Files
                    </h2>
                </div>
            </div> 
            <%f += 1;%>
        </security:authorize>
        <% if (f % 3 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_FILEASSIGNMENTS')">
            <div class="col-sm-4 col-md-4 menu-icon" align="center" onclick="ajaxSubmitData('fileassignment/listassignments.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img src="static/img/assignment.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h2>
                        Assignments
                    </h2>
                </div>
            </div>
            <%f += 1;%>
        </security:authorize>
        <% if (f % 3 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_FILEREQUESTS')">
            <div class="col-sm-4 col-md-4 menu-icon" align="center" onclick="ajaxSubmitData('filerequest/myfilelist.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img src="static/img/borrowedFile.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h2>
                    Files Borrowed 
                    </h2>
                </div>
            </div>
            <%f += 1;%>
        </security:authorize>
        <% if (f % 3 == 0) { %></div><div class="row"><%}%>
    </div>
</div>
<script>
    breadCrumb();
</script>
