<%-- 
    Document   : registerpost
    Created on : Jul 23, 2019, 1:55:32 PM
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
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                    <li class="last active"><a href="#">Set Staffing Levels</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="tile" id="facilityLevelTable">
 
</div>

 <script>
                
    $('.new_search').select2();
    $('.select2').css('width', '100%');
    $('#sampleTable').DataTable();

    $.ajax({
        type: 'GET',
        url: "postsandactivities/fetchfacilityLevelTable.htm",
        success: function (data) {
            $('#facilityLevelTable').html(data);
            
        }        
    });
    
                
 </script>