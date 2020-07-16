<%-- 
    Document   : levelsMenu
    Created on : Dec 4, 2017, 3:30:31 PM
    Author     : samuelwam
--%>

<%@include file="../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="col-sm-12">
    <div class="box box-color box-bordered">    
        <div class="box-title">
            <h3>
                <i class="fa fa-home"></i>
                Organisation Settings - Manage Domain Levels
            </h3>
        </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <!-- start: FORM VALIDATION 1 PANEL -->
                        <div class="panel panel-default">
                            <div class="panel-heading"></div>
                            <div class="panel-body" id="orgResponse-pane">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <img src="static/images/Menus/flevel1.jpg" width="100px" height="100px" class="circle-img" alt="Facility Level Category" 
                                                     onClick="clearDiv('workPane'); ajaxSubmitData('orgLevelSetting.htm', 'workPane', 'act=b&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                            </div>
                                        </div>
                                        <!--
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <img src="static/images/Menus/flevel2.jpg" width="100px" height="100px" class="circle-img" alt="Category Level">
                                            </div>
                                        </div>
                                        -->
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <img src="static/images/Menus/flevel3.jpg" width="100px" height="100px" class="circle-img" alt="Assign Level">
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
<div id="TempDialogDiv"></div>
<script type="text/javascript" src="static/mainpane/plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="static/mainpane/plugins/DataTables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="static/mainpane/plugins/DataTables/media/js/DT_bootstrap.js"></script>
<script src="static/mainpane/js/table-data.js"></script>
<script>
    jQuery(document).ready(function () {
        //Main.init();
        TableData.init();
    });
</script>

