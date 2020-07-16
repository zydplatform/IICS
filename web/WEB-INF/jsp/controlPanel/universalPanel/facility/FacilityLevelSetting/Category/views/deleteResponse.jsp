<%-- 
    Document   : deleteResponse
    Created on : Dec 6, 2017, 3:29:56 PM
    Author     : samuelwam
--%>

<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<div class="modal fade" id="panel-addOrg" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onClick="clearDiv('workPane'); ajaxSubmitData('orgLevelSetting.htm', 'workPane', 'act=b&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    &times;
                </button>
                <h4><i class="fa fa-cut"></i>Discard Facility Level Category </h4>
            </div>
            <div class="modal-body">
                <!-- start: DYNAMIC TABLE PANEL -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <i class="fa fa-external-link-square"></i>
                                
                                <div class="panel-tools">
                                    <a class="btn btn-xs btn-link panel-collapse collapses" href="#">
                                    </a>
                                    <a class="btn btn-xs btn-link panel-refresh" href="#">
                                        <i class="fa fa-refresh"></i>
                                    </a>
                                    <a class="btn btn-xs btn-link panel-expand" href="#">
                                        <i class="fa fa-resize-full"></i>
                                    </a>
                                    <a class="btn btn-xs btn-link panel-close" href="#">
                                        <i class="fa fa-times"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="panel-body">
                                <table class="table table-striped table-bordered table-hover table-full-width" id="delOrg_1">
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th class="hidden-xs">Category</th>
                                            <th>Attachments</th> 
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${model.customList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                            <c:choose>
                                                <c:when test="${status.count % 2 != 0}">
                                                    <tr>
                                                    </c:when>
                                                    <c:otherwise>
                                                    <tr bgcolor="white">
                                                    </c:otherwise>
                                                </c:choose>
                                                <td>${status.count}</td>
                                                <td align="center">${list.categoryname}</td>
                                                <td align="center">${list.description}</td>                                            
                                                <td align="center"><c:if test="${list.active==true}">Deleted</c:if><c:if test="${list.active==false}">Failed!</c:if></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- end: DYNAMIC TABLE PANEL -->
            <div class="modal-footer">

            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
</div>


<script type="text/javascript" src="static/mainpane/plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="static/mainpane/plugins/DataTables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="static/mainpane/plugins/DataTables/media/js/DT_bootstrap.js"></script>
<script src="static/mainpane/js/table-data.js"></script>
<script>
     $('#panel-addOrg').modal('show'); 
</script>