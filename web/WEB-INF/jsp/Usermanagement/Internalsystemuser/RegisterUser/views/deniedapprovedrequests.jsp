<%-- 
    Document   : deniedapprovedrequests
    Created on : May 17, 2018, 4:27:12 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-4 col-sm-4">

    </div>
    <div class="col-md-7 col-sm-7 right">
        <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
            <div class="btn-group" role="group">
                <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-sliders" aria-hidden="true"></i>
                </button>
                <div class="dropdown-menu dropdown-menu-left">
                    <a class="dropdown-item" href="#!" id="load-approved-requests">Approved Requests</a><hr>
                    <a class="dropdown-item" href="#!" id="load-denied-requests">Denied Requests</a>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="content">

</div>
<script>
    $('#rtable').DataTable();
    ajaxSubmitData('viewapprovedreqs.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    $('#load-approved-requests').click(function () {
        ajaxSubmitData('viewapprovedreqs.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });

    $('#load-denied-requests').click(function () {
        
        ajaxSubmitData('viewdeniedrequests.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

    });
</script>