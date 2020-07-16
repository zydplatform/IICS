<%@include file="../../../include.jsp"%>
<div id="mainxxx">
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
                        <li><a href="#" onclick="ajaxSubmitData('patients/filemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Patient Files</a></li>
                        <li class="last active"><a href="#">Manage Assignments</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <main  class="col-md-12 col-sm-12"> 

        <div class="tile">
            <div class="tile-body">
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_VIEWFILESOUT')">
            <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab1">Files Out </label>
        </security:authorize>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_VIEWRECALLEDFILES')">
            <input id="tab2" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab2">Recalled Files  <label id="recalledFilesTab"></label></label>
            </security:authorize>
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_VIEWFILEREQUESTS')">
            <input id="tab3" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab3">File Requests  <label id="fileRequestTab"></label></label>
            </security:authorize>


        <section class="tabContent" id="content1">
            <div>
                <%@include file="viewUserAssignment.jsp" %>
            </div>
        </section>
        <section class="tabContent" id="content2">
            <div>
                <div>
                    <p>Loading Content.......................</p>
                </div>
            </div>
        </section>
        <section class="tabContent" id="content3">
            <div>
                <div>
                    <p>Loading Content.......................</p>
                </div>
            </div>
        </section>
    </main>
    <div class="row">
        <div class="col-md-12">
            <div id="ShowHistorylist" class="filePages">
                <div>
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title align-items-center">File Assignment History</h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="content">
                        <div class="col-md-12">                        
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile">
                                        <div class="tile-body">
                                            <div id="fileAssignmentHistory"></div>
                                        </div>                                        
                                    </div>                                                               
                                </div>                                
                            </div>
                        </div>                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        loadRemainingTabs('fileassignment/listrecalledassignments.htm', 'content2', 'GET');
    });
    breadCrumb();
    function loadRemainingTabs(url, respDiv, method) {
        $.ajax({
            type: method,
            url: url,
            success: function (data) {
                $('#' + respDiv).html(data);
                ajaxSubmitData('filerequest/listpendingfilerequest.htm', 'content3', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            }
        });
    }
    function loadItemSize(respDiv, listSize) {


        if(parseInt(listSize)>0){
              $('#' + respDiv).html('('+listSize+')');
        }else{
           $('#'+ respDiv).style.display = 'none';
        }
     }

    $('#tab2').change(function () {
        $('#recalledFilesTab').html("");
    });
    $('#tab3').change(function () {
        $('#fileRequestTab').html("");
    });

    function showAssignmentHistory(fileid) {
        url = "filerequest/listassigmenthistory.htm";
        $.ajax({
            type: 'GET',
            data: {fileid: fileid},
            url: url,
            success: function (data) {
                $("#fileAssignmentHistory").html(data);
            }
        });
        window.location = '#ShowHistorylist';
        initDialog('filePages');
    }
</script>
