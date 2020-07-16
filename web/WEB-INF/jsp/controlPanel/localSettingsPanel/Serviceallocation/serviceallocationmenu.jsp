<%-- 
    Document   : serviceallocationmenu
    Created on : Jul 26, 2018, 8:23:33 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@include file="../../../include.jsp" %>
<html>
    <body>
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
                            <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                            <li><a href="#" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Local Settings</a></li>
                            <li class="last active"><a href="#">Service allocations</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="tile">
            <div class="row">
                <div class="col-md-12">
                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_REQUESTTOUSESYSTEM')">
                        <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                        <label class="tabLabels" for="tab1">Allocate services</label>
                    </security:authorize>
                </div>
                <div class="col-md-12">
                    <div class="col-md-12" id="servicesassignment">
                        <div>
                            <%@include file="views/assignedandunassigned.jsp" %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </body>

</html>


<script>
    breadCrumb();
    function printdiv(print)
    {

        var headstr = "<html><head><title></title></head><body>";
        var footstr = "</body>";
        var newstr = document.all.item(print).innerHTML;
        var oldstr = document.body.innerHTML;
        document.body.innerHTML = headstr + newstr + footstr;
        window.print();
        document.body.innerHTML = oldstr;
        return false;
    }
    function printserviceallocations() {
        window.location = '#printserviceallocations';
        initDialog('modalDialog assignCellStaffDialog');
    }
</script>
