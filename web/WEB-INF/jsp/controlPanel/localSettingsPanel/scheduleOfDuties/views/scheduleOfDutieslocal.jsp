<%-- 
    Document   : scheduleOfDuties
    Created on : Jul 25, 2019, 2:23:14 PM
    Author     : USER 1
--%>
<%@include file="../../../../include.jsp"%>

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
                    <li><a href="#" onclick="ajaxSubmitData('dashboard/loadDashboardMenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Dashboard & Reports</a></li>
                    <li class="last active"><a href="#">Schedule Of Duties</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="tile" id="facilityDesignationtable">
 
</div>
<script>
        $('#sampleTable').DataTable();
        $.ajax({
        type: 'GET',
        url: "postsandactivities/fetchfacilityDesignationtable.htm",
        success: function (data) {
            $('#facilityDesignationtable').html(data);
            
        }        
    });
</script>