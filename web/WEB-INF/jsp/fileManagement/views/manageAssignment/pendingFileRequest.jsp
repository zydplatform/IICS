<%@include file="../../../include.jsp"%>
<div class="col-md-12">
        <div class="tile">
            <div class="tile-body">
                <table class="table table-hover" id="pendingAssignmentList">
                    <thead>
                        <tr>
                            <th class="center">No</th>
                            <th class="center">File No</th>
                            <th class="center">Requested On</th>
                            <th class="center"> Return Date</th>
                            <th class="center">Requested Days Left</th>
                            <th class="center">Details</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <% int h = 1;%>
                        <c:forEach items="${assignments}" var="assignment">
                            <tr>
                                <td><%h++;%></td>
                                <c:forEach items="${assignment.staffDetails}" var="ass">
                                    <td >
                                        <a id="loctionLink"  onclick="showAssignmentHistory(${assignment.fileid})" class=" col-md-3" style="color:#7d047d;" >${assignment.fileno}</a>
                                    </td>
                                    <td class="center">${assignment.requestdate}</td>
                                    <td class="center">${assignment.datereturned}</td>
                                    <td class="center">${assignment.days}</td>
                                   <td class="center">
                                        <a data-dateissued="${assignment.dateassigned}"
                                           data-datereturned="${assignment.datereturned}"
                                           data-dateexpected="${assignment.requesteddate}"
                                           data-fileid="${assignment.fileid}"
                                           onclick="showOtherApprovedDetails(
                                                           $(this).attr('data-dateissued'),
                                                           '${assignment.firstname} ${assignment.othernames} ${assignment.lastname}',
                                                                           '${ass.firstname} ${ass.othernames} ${ass.lastname}',
                                                                                           '${ass.facilityunitname}', $(this).attr('data-fileid'), '${assignment.assignmentid}',
                                                                                           '${assignment.requestid}', $(this).attr('data-dateexpected'))" href="#">
                                            <button class="btn btn-sm btn-secondary">
                                                0</button></a>
                                    </td>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
</div>
<div class="row" style="display: none" id="receivebutton">
    <div class="col-md-9">
        <div class="col-md-3 pull-right" id="receiveitemsdiv">
            <button class="btn btn-secondary" id="receiveitems" onclick="receiveitems()"><i class="fa fa-check"></i>Receive</button>
        </div>        
    </div>
</div><script>
    $('#pendingAssignmentList').DataTable();
    $(document).ready(function () {
        loadItemSize("fileRequestTab", "<%=h - 1%>");
    });
    function showOtherApprovedDetails(IssueDate, issuedBy, currentUser, currentLocation, fileid, assignmentid, requestid, dateExpected) {
        $.alert({
            title: 'Asignment Details',
            content: '' +
                    '<form action="" class="formName"><hr/>'
                    +
                    '<div class="form-group row">' +
                    '<label class="col-md-6">Current User: </label>' +
                    '<label class="col-md-6">' + currentUser + '</label>' +
                    '</div>' +
                    '<div class="form-group row">' +
                    '<label class="col-md-6">Current Location: </label>' +
                    '<label class="col-md-6">' + currentLocation + '</label>' +
                    '</div>' +
                    '<div class="form-group row">' +
                    '<label class="col-md-6">Issued By: </label>' +
                    '<label class="col-md-6">' + issuedBy + '</label>' +
                    '</div>' +
                    '<div class="form-group row">' +
                    '<label class="col-md-6">Issue Date: </label>' +
                    '<label class="col-md-6">' + IssueDate + '</label>' +
                    '</div>' +
                    '<div class="form-group row">' +
                    '<label class="col-md-6">New Return Date: </label>' +
                    '<label class="col-md-6">' + dateExpected + '</label>' +
                    '</div>' +
                    '</form>',
            buttons: {
               Approve: {
                    text: 'Approve', // With spaces and symbols
                    btnClass:'btn btn-primary',
                      action: function () {
                        var additem = [];
                        additem.push({assignmentid: assignmentid, fielid: fileid, requestid: requestid});
                         var url = "filerequest/approveassignment.htm";
                        alert(additem);
                        $.ajax({
                            type: 'POST',
                            data: {assignmentids: JSON.stringify(additem)},
                            url: url,
                            success: function (data) {
                                if (data === 'success') {
                                $.alert('Successfully Approved the File');
                                ajaxSubmitData('fileassignment/listassignments.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            } else {
                                alert("Failed To Approve File Request");
                            }
                            }
                        });
                    }
                },
                Deny: {
                    text: 'Deny', // With spaces and symbols
                    btnClass: 'btn-red',
                    action: function () {
                        var additem = [];
                        additem.push({assignmentid: assignmentid, fielid: fileid, requestid: requestid});
                        var url = '';
                        url = "filerequest/denyassignment.htm";
                        $.ajax({
                            type: 'POST',
                            data: {assignmentids: JSON.stringify(additem)},
                            url: url,
                            success: function (data) {
                                if (data === 'success') {
                                    $.alert('Successfully Requested the File');
                                    ajaxSubmitData('filerequest/listpendingfilerequest.htm', 'content3', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                } else {
                                    alert("Failed To update File");
                                }
                            }
                        });
                    }
                },
                Close: function () {

                }
            }
        });
    }
  
</script>
