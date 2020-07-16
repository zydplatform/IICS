<%--
    Document   : RegisterUsertable
    Created on : Apr 14, 2018, 8:52:27 PM
    Author     : IICS PROJECT
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<fieldset style="">
    <div class="">
        <table class="table table-hover table-bordered col-md-12 " id="userstable">
            <thead>
                <tr>
                    <td>No</td>
                    <th class="center">Staff name</th>
                    <th class="center">Facility unit(s)</th>
                    <th class="center">Staff Post</th>
                    <th class="center">Staff E-mail</th>
                    <th class="center">Recommender</th>
                    <th class="center">Send Link</th>
                </tr>
            </thead>
            <tbody>
                <% int j = 1;%>
                <% int x = 1;%>
                <c:forEach items="${aplist}" var="c">
                <tr>
                    <td><%=x++%></td>
                    <td>${c.staffname1}&nbsp;${c.staffname2}&nbsp;${c.staffname3}</td>
                    <td class="center"><a href="#"><span class="badge badge-success" style="font-size:14px" onclick="viewUnits(${c.staffid})">${c.noOfUnits}</span></a></td>
                    <td>${c.designationname}</td>
                    <td>${c.contactvalue}</td>
                    <td>${c.firstname}&nbsp;${c.lastname}</td>
                    <td class="center">
                        <div class="row">
                            <div class="col-md-3">
                            </div>
                            <div class="col-md-6">
                                <c:if test="${not empty c.links}">
                                    <span class="badge badge-success" style="margin-left: -3em">E-mail link sent</span>
                                </c:if>
                                <c:if test="${empty c.links}">
                                    <button class="btn btn-primary" id="confir<%=j++%>" onclick="confirmrequest($(this).attr('data-id'), $(this).attr('data-id1'), $(this).attr('data-id2'), $(this).attr('data-id3'), $(this).attr('data-id4'), $(this).attr('data-id5'));" data-id="${c.contactvalue}" data-id1="${c.staffid}" data-id2="${c.personid}" data-id3="${c.requisitionid}" data-id4="${c.staffname1}" data-id5="${c.staffname2}" type="button" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Deny request"><i class="fa fa-mail-forward"></i></button>
                                </c:if>
                            </div>
                            <div class="col-md-3">
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</fieldset>
<div id="loadupdatedrates" style="display: none;">
    <img src="static/img2/loader.gif" alt="Loading"/><br/>
    sending link to Email...Please Wait...
</div>

<script>
    $('#userstable').DataTable();
    function confirmrequest(contactvalue, staffid, personid, requisitionid, staffname1, staffname2) {
        document.getElementById('loadupdatedrates').style.display = 'block';
        var pass = md5(staffname1);
        $.ajax({
            type: 'POST',
            data: {staffname1: staffname1, staffname2: staffname2, pass: pass, contactvalue: contactvalue, requisitionid: requisitionid, personid: personid},
            url: "savesystemuser.htm",
            success: function (data) {
                document.getElementById('loadupdatedrates').style.display = 'none';
                if (data === '') {
                    $.notify({
                        title: "Update Complete : ",
                        message: "A link has been sent to " + contactvalue,
                        icon: 'fa fa-check'
                    }, {
                        type: "info"
                    });
                     ajaxSubmitData('usermanagement/registeruser.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    ajaxSubmitData('retrievepersons.htm', 'people', '', 'GET');
                } else {
                    $.confirm({
                        title: 'ALERT!!',
                        type: 'purple',
                        content: data
                    });
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
