<%-- 
    Document   : deleteResponse
    Created on : Jun 4, 2018, 2:52:10 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="titleAct" value="DELETE SUCCESS"></c:set>    
<c:if test="${model.resp==false}"><c:set var="titleAct" value="DELETE FAILED, ERROR!"></c:set></c:if>

        <div class="modal fade col-md-12" id="panel-delete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width: 153%;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">${titleAct}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=${model.act}&i=0&b=${model.b}&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');  clearDiv('addnew-pane');">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <h3>${model.respMessage}</h3>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#panel-delete').modal('show');
</script>



