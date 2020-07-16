<%-- 
    Document   : recyclerequest
    Created on : Jul 12, 2018, 5:52:14 PM
    Author     : user
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="tile" id="requestcontenets">
    <div class="tile-body">
        <fieldset style="margin-top: 3em">
            <div class="">
                <table class="table table-hover table-bordered" id="userstable">
                    <thead>
                        <tr>
                            <td>No</td>
                            <th>Name</th>
                            <th class="center">Reason for rejected request</th>
                            <th class="center">Repeat process.</th>
                        </tr>
                    </thead>
                    <% int b = 1;%>
                    <% int v = 1;%>
                    <tbody>
                        <c:forEach items="${requisitionList11}" var="details">
                            <tr>
                                <td><%=v++%></td>
                                <td class="center">${details.stafffirstname} &nbsp; ${details.stafflastname}</td>
                                <td class="center"><button class="btn btn-outline-info" type="button">${details.reasonfordenial}</button></td>
                                <td class="center">
                                    <c:if test="${details.reasonfordenial =='Temporary Employee'}">
                                        <span class="badge badge-warning" style="height: 2em;font-size: 1em">This request cannot be recycled</span><button class="btn btn-circle" href="#" style="background-color: red;color: white" onclick="removefromlist(${details.requisitionid})"><i class="fa fa-fw fa-lg fa-times"></i></button>
                                        </c:if>
                                        <c:if test="${details.reasonfordenial !='Temporary Employee'}">
                                        <button class="btn btn-circle" id="approve<%=b++%>" onclick="resendrequest(${details.requisitionid});" data-id4="approved" style="background-color: purple;color: white" ><i class="fa fa-recycle"></i></button>                                        
                                        </c:if>

                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </fieldset>
    </div>
</div>
<script>
    $('#userstable').DataTable();
    function resendrequest(requisitionid) {
        $.confirm({
            title: 'Alert!!',
            content: 'Do you wish to resubmit a request for this person?',
            type: 'green',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Try again',
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
    

    }
</script>
