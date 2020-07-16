<%-- 
    Document   : approvedrequests
    Created on : Aug 23, 2018, 6:43:26 PM
    Author     : user
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-3"></div>
    <div class="col-md-6">
        <h4><font color="blue">Approved Requests</font></h4>
    </div>
    <div class="col-md-3"></div>
</div>
<fieldset>
    <table class="table table-hover table-bordered" id="rtable" >
        <thead>
            <tr>
                <th>No</th>
                <th>Name</th>
                <th>Facility Unit(s)</th>
                <th>Designation</th>
                <th>Date Approved</th>
                <th>Approved by</th>
                <th>Activate|Deactivate</th>
            </tr>
        </thead>
        <% int c = 1;%>
        <tbody>
            <c:forEach items="${approvedreqs}" var="detailss">
                <tr>
                    <td><%=c++%></td>
                    <td>${detailss.firstname}&nbsp;${detailss.lastname}&nbsp;${detailss.othernames}</td>
                    <td class="center"><a href="#"><span class="badge badge-success" style="font-size:14px" onclick="viewUnits(${detailss.staffid})">${detailss.noOfUnits}</span></a></td>
                    <td>${detailss.designationname}</td> 
                    <td>${detailss.datecreated}</td> 
                    <td>${detailss.firstnamer}&nbsp;${detailss.lastnamer}&nbsp;${detailss.othernamesr}</td> 
                    <c:if test="${detailss.active  eq true}">
                        <td class="center">
                            <label class="switch">
                                <input type="checkbox"  class="deactivateuser" value="true" onclick="deactivateuser(${detailss.systemuserid}, $(this).val())" checked>
                                <span class="slider round"></span>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             round"></span>
                            </label>
                        </td>
                    </c:if>
                    <c:if test="${detailss.active  eq false}">
                        <td class="center">
                            <label class="switch">
                                <input type="checkbox"  class="activateuser" value="false" onclick="activateuser(${detailss.systemuserid}, $(this).val())">
                                <span class="slider round"></span>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             round"></span>
                            </label>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</fieldset>
<script>
    $('#rtable').DataTable();
    function viewmoredetails(staffid) {
        $.ajax({
            type: 'GET',
            data: {staffid: staffid},
            url: "staffinfo.htm",
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">Batch details for:' + '<font color="green">' + staffid + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '40%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true
                });
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
    function deactivateuser(systemuserid, value) {
        if (value === 'true') {
            $.confirm({
                title: 'Message!',
                content: 'You are about to Activate this User from using the system',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                cache: false,
                                dataType: 'text',
                                data: {systemuserid: systemuserid},
                                url: "usermanagement/deactivateuser.htm",
                                success: function (data) {
                                    ajaxSubmitData('viewapprovedreqs.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                            $('.deactivateuser').val("false");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('viewapprovedreqs.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                    }
                }
            });
        } else if (value === 'false') {
            $.confirm({
                title: 'Message!',
                content: 'Your are about to Activate this User from using the system.',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                cache: false,
                                dataType: 'text',
                                data: {systemuserid: systemuserid},
                                url: "usermanagement/activateuser.htm",
                                success: function (data) {
                                    ajaxSubmitData('viewapprovedreqs.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                            $('.deactivateuser').val("true");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('viewapprovedreqs.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                    }
                }
            });

        }
    }
    function activateuser(systemuserid, value) {
        if (value === 'false') {
            $.confirm({
                title: 'Message!',
                content: 'Your about to Activate this User from using the system',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                cache: false,
                                dataType: 'text',
                                data: {systemuserid: systemuserid},
                                url: "usermanagement/activateuser.htm",
                                success: function (data) {
                                    ajaxSubmitData('viewapprovedreqs.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                            $('.activateuser').val("true");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('viewapprovedreqs.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                    }
                }
            });
        } else if (value === 'true') {
            $.confirm({
                title: 'Message!',
                content: 'Your about to Activate this User from using the system',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                cache: false,
                                dataType: 'text',
                                data: {systemuserid: systemuserid},
                                url: "usermanagement/deactivateuser.htm",
                                success: function (data) {
                                    ajaxSubmitData('viewapprovedreqs.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                            $('.activateuser').val("false");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('viewapprovedreqs.htm', 'content', '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                    }
                }
            });
        }
    }
</script>
