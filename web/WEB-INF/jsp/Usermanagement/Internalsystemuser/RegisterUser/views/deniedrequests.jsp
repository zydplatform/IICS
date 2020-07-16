<%-- 
    Document   : deniedrequests
    Created on : Aug 23, 2018, 6:43:41 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-3"></div>
    <div class="col-md-6">
        <h4><font color="blue">Denied Requests</font></h4>
    </div>
    <div class="col-md-3"></div>
</div>
<fieldset>
    <table class="table table-hover table-bordered" id="denied-requests-table" >
        <thead>
            <tr>
                <th>No</th>
                <th>Name</th>
                <th>Facility Unit(s)</th>
                <th>Designation</th>
                <th>Date Denied</th>
                <td>Reason</td>
                <th>Denied by</th>
                <th>Re-cycle</th>
            </tr>
        </thead>
        <% int c = 1;%>
        <% int b = 1;%>
        <tbody>
            <c:forEach items="${deniedrequests}" var="detailss">
                <tr>
                    <td><%=c++%></td>
                    <td>${detailss.firstname}&nbsp;${detailss.lastname}&nbsp;${detailss.othernames}</td>
                    <td class="center"><a href="#"><span class="badge badge-success" style="font-size:14px" onclick="viewUnits(${detailss.staffid})">${detailss.noOfUnits}</span></a></td>
                    <td>${detailss.designationname}</td> 
                    <td>${detailss.datedenied}</td> 
                    <td>${detailss.reasonfordenial}</td>
                    <td>${detailss.firstnamer}&nbsp;${detailss.lastnamer}&nbsp;${detailss.othernamesr}</td>

                    <td class="center">
                        <c:if test="${detailss.reasonfordenial =='Temporary Employee'}">
                            <button class="btn btn-sm btn-danger" href="#" onclick="removefromlist(${details.requisitionid})"><i class="fa fa-fw fa-lg fa-times"></i></button>
                            </c:if>
                            <c:if test="${detailss.reasonfordenial !='Temporary Employee'}">
                            <button class="btn btn-sm btn-info" id="approve<%=b++%>" onclick="resendrequest(${detailss.requisitionid});" data-id4="approved"><i class="fa fa-recycle"></i></button>                                        
                            </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</fieldset>
<script>
    $('#denied-requests-table').DataTable();
    function removefromlist(requisitionid) {
        $.confirm({
            title: 'Alert!!',
            content: 'Do you wish to remove this row from the list?',
            type: 'green',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {requisitionid: requisitionid},
                            url: "removefromlist.htm",
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('viewdeniedrequests.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                ajaxSubmitData('requeststatus.htm', 'requestprocessing', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                        $.notify({
                            title: "Update Complete : ",
                            message: "You have successfully removed an item from the list",
                            icon: 'fa fa-check'
                        }, {
                            type: "info"
                        });
                    }
                },
                close: function () {
                }
            }
        }
        );
    }
    function resendrequest(requisitionid) {
        $.confirm({
            title: 'Alert!!',
            content: 'Do you wish to resubmit a request for this Staff member?',
            type: 'green',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {requisitionid: requisitionid},
                            url: "resendrequest.htm",
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('reloadrecycle.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                ajaxSubmitData('requeststatus.htm', 'requestprocessing', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                ajaxSubmitData('usermanagement/registeruser.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                        $.notify({
                            title: "Update Complete : ",
                            message: "You can now resend a request for this person.",
                            icon: 'fa fa-check'
                        }, {
                            type: "info"
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function viewUnits(staffid) {
        $.ajax({
            type: 'GET',
            data: {staffid: staffid},
            url: "Viewunitslist.htm",
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
