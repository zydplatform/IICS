<%-- 
    Document   : requisitionlisttable
    Created on : Apr 13, 2018, 12:37:07 AM
    Author     : IICS PROJECT
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:if test="${empty requisitionList}">
    <h2 class="center" style="border: 1px solid purple">No requests Available!</h2>
</c:if>
<c:if test="${ not empty requisitionList}">

    <table class="table table-hover table-bordered col-md-12 " id="request" style="margin-top: 3em">
        <thead>
            <tr>
                <th>No</th>
                <th>Staff name</th>
                <th>Facility Unit(s)</th>
                <th>Staff Post</th>
                <th>Staff E-mail</th>
                <th>Recommender</th>
                <th>Deny|Approve request</th>
            </tr>
        </thead>
        <tbody>
            <% int b = 1;%>
            <% int x = 1;%>
            <c:forEach items="${requisitionList}" var="a">
                <tr>
                    <td><%=x++%></td>
                    <td>${a.firstname}&nbsp;${a.lastname}&nbsp;${a.othernames}</td>
                    <td class="center"><a href="#"><span class="badge badge-success" style="font-size:14px" onclick="viewUnits(${a.staffid})">${a.noOfUnits}</span></a></td>
                    <td>${a.designationname}</td>
                    <td >${a.contactvalue}</td>
                    <td>${a.reqfirstname}&nbsp;${a.reqlastname}&nbsp;${a.reqothernames}</td>
                    <td class="center">
                        <c:if test="${empty a.status}">
                            <span title="Deny this request"  class="icon-custom" id="deny<%=b++%>" onclick="denyRequest($(this).attr('data-id3'), $(this).attr('data-id4'));" data-id="${a.contactvalue}" data-id1="${a.staffid}" data-id2="${a.recommender}" data-id3="${a.requisitionid}" data-id4="Denied"><i class="fa fa-fw fa-lg fa-remove"></i></span>
                            | 
                            <a href="#!" title="Approve this requests" id="approve<%=b++%>" onclick="sendrequest($(this).attr('data-id3'), $(this).attr('data-id4'));" data-id="${a.contactvalue}" data-id1="${a.staffid}" data-id2="${a.recommender}" data-id3="${a.requisitionid}" data-id4="approved"><i class="fa fa-fw fa-lg fa-check"></i></a>
                            </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>
<div class="modal fade" id="deny" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="title">Reason for denial</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="control-label" id="space2" style="margin-top: em">Select Reason: </label>
                                </div>
                            </div>
                            <div class="col-md-9" >
                                <div id="selectPosts">
                                    <select class="form-control new_search" id="reasons">
                                        <option>-----Enter Reason-----</option>
                                        <option value="Review applicants details and re-submit">Review applicants details and re-submit</option>
                                        <option value="Temporary Employee">Temporary Employee</option>
                                        <option value="Mail details are not right">Mail details are not right</option>
                                        <option value="Details are not consistent">Details are not consistent</option>
                                        <option value="Request is not necessary">Request is not necessary</option>
                                    </select>
                                </div>                        
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="form-group ">
                    <button class="btn btn-primary " id="savereason"><i class="fa fa-save">
                        </i>Save
                    </button>
                </div>
            </div>
        </div>
    </div></div>
<script>
    $('.new_search').select2();
    $('.select2').css('width', '100%');
    $('#request').DataTable();
    function sendrequest(requisitionid, status) {
        $.confirm({
            title: 'Alert!',
            content: 'Are u sure you want to approve this request?',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {status: status, requisitionid: requisitionid},
                            url: "acceptedrequest.htm",
                            success: function (data) {
                                ajaxSubmitData('usermanagement/registeruser.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                ajaxSubmitData('retrievesavedrequests.htm', 'requisitionlist', '', 'GET');
                            }
                        });
                    }
                },
                No: function () {
                }
            }
        });

    }
    function denyRequest(requisitionid, status) {
        $('#deny').modal('show');
        $('#savereason').click(function () {
            var reasonfordenial = $("#reasons").val();
            if (reasonfordenial === '-----Enter Designation Name-----') {
                $.alert("You can not submit this information due to missing reason.");
                return false;
            } else {
                $('#deny').modal('hide');
                $.ajax({
                    type: 'POST',
                    data: {reasonfordenial: reasonfordenial, requisitionid: requisitionid, status: status},
                    url: "deniedrequest.htm",
                    success: function (data) {
                        ajaxSubmitData('retrievesavedrequests.htm', 'requisitionlist', '', 'GET');
                        ajaxSubmitData('usermanagement/registeruser.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        $('body').removeClass('modal-open');
                        $('modal-backdrop').remove();
                    }
                });
            }
        });
    }
    function viewUnits(staffid) {
        $.ajax({
            type: 'GET',
            data: {staffid: staffid},
            url: "Viewunits.htm",
            success: function (respose) {
                $.confirm({
                    title: '<strong class="center"> Facility Units' + '<font color="green"></font>' + '</strong>',
                    content: '' + respose,
                    boxWidth: '40%',
                    height: '100%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    draggable: true
                });
            }
        });
    }
</script>       