
<%@include file="../../../include.jsp"%>
<div id="mainxxx">
    <div class="app-title" id="">
        <div class="col-md-5">
            <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
            <p>Together We Save Lives...!</p>
        </div>
        <div>
            <div class="mmmains">
                <div class="wrapper">
                    <ul class="breadcrumbs">
                        <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                        <li><a href="#" onclick="ajaxSubmitData('patients/filemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Patient Files</a></li>
                        <li class="last active"><a href="#"> Files Borrowed </a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <main  class="col-md-12 col-sm-12"> 
        <div class="tile">
            <div class="tile-body">
                <div>
                    <%@include file="../../../include.jsp"%>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">

                                    <table class="table table-hover" id="assignmentList">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>File No</th>
                                                <th >Return Date</th>
                                                <th >Status</th>
                                                <th >Details</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tableBody">
                                            <% int h = 1;%>
                                            <c:forEach items="${assignments}" var="assignment">
                                                <tr>
                                                    <c:forEach items="${assignment.staffDetails}" var="ass">
                                                        <c:if test="${assignment.status=='Out'}">
                                                            <td><%=h++%></td>
                                                            <td>${assignment.fileno}</td>
                                                            <td>${assignment.datereturned}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${assignment.daystate}">
                                                                        <a id="loctionLink" class=" col-md-3" style="color:#7d047d;" href="#"> Overdue: ${assignment.days} days</a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a id="loctionLink" class=" col-md-3" style="color:blue;" href="#"> Remaining: ${assignment.days} days </a></c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="center">
                                                                <a data-dateissued="${assignment.dateassigned}" data-datereturned="${assignment.datereturned}"data-fileid="${assignment.fileid}"
                                                                   onclick="showOtherDetails($(this).attr('data-dateissued'), '${assignment.faciltyname}',
                                                                           '${assignment.firstname} ${assignment.othernames} ${assignment.lastname}',
                                                                                           '${assignment.assignmentid}', $(this).attr('data-fileid'))" href="#">
                                                                    <button class="btn btn-sm btn-secondary">
                                                                        0</button></a>
                                                            </td>
                                                        </c:if>

                                                        <c:if test="${assignment.status=='Requested'}">
                                                            <td><%=h++%></td>
                                                            <td> ${assignment.fileno} </td>
                                                            <td>${assignment.datereturned}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${assignment.days gt 0}">
                                                                        <a id="loctionLink" class=" col-md-3" style="color:#7d047d;" href="#">${assignment.status}:</a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a id="loctionLink" class=" col-md-3" style="color:#7d047d;" href="#">${assignment.status}: Today.</a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="center">
                                                                <a data-dateissued="${assignment.dateassigned}"
                                                                   data-datereturned="${assignment.datereturned}"
                                                                   data-dateexpected="${assignment.requesteddate}"
                                                                   data-daterequested="${assignment.requestdate}"
                                                                   data-fileid="${assignment.fileid}"
                                                                   onclick="showPendingRequestDetails(
                                                                           $(this).attr('data-dateissued'), $(this).attr('data-dateexpected'),
                                                                           '${assignment.firstname} ${assignment.othernames} ${assignment.lastname}',
                                                                                           '${assignment.faciltyname}', $(this).attr('data-daterequested'))" href="#">
                                                                    <button class="btn btn-sm btn-secondary">
                                                                        0</button>
                                                                </a>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${assignment.status=='Denied'}">
                                                            <td><%=h++%></td>
                                                            <td> ${assignment.fileno} </td>
                                                            <td>${assignment.datereturned}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${assignment.days gt 0}">
                                                                        <a id="loctionLink" class=" col-md-4" style="color:#7d047d;" href="#">${assignment.status}:${assignment.days} days ago.</a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a id="loctionLink" class=" col-md-4" style="color:#7d047d;" href="#">${assignment.status}: Today.</a>
                                                                    </c:otherwise>
                                                                </c:choose> </td>
                                                            <td class="center">
                                                                <a data-dateissued="${assignment.dateassigned}" data-datereturned="${assignment.datereturned}"data-fileid="${assignment.fileid}"
                                                                   onclick="showOtherDetails2($(this).attr('data-dateissued')
                                                                           , '${assignment.faciltyname}',
                                                                           '${assignment.firstname} ${assignment.othernames} ${assignment.lastname}',
                                                                                           '${assignment.assignmentid}', $(this).attr('data-fileid'))" href="#">
                                                                    <button class="btn btn-sm btn-secondary">
                                                                        0</button></a>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${assignment.status=='Recalled'}">
                                                            <td><%=h++%></td>
                                                            <td> ${assignment.fileno} </td>
                                                            <td>${assignment.datereturned}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${assignment.days gt 0}">
                                                                        <a id="loctionLink" class=" col-md-3" style="color:#7d047d;" href="#">${assignment.status}:${assignment.days} days ago.</a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a id="loctionLink" class=" col-md-3" style="color:#7d047d;" href="#">${assignment.status}: Today.</a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="center">
                                                                <a data-dateissued="${assignment.dateassigned}" data-datereturned="${assignment.datereturned}"data-fileid="${assignment.fileid}"
                                                                   onclick="showOtherDetails($(this).attr('data-dateissued')
                                                                           , '${assignment.faciltyname}',
                                                                           '${assignment.firstname} ${assignment.othernames} ${assignment.lastname}',
                                                                                           '${assignment.assignmentid}', $(this).attr('data-fileid'))" href="#">
                                                                    <button class="btn btn-sm btn-secondary">
                                                                        0</button></a>
                                                            </td>
                                                        </c:if>
                                                    </c:forEach>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <script src="static/res/js/sec/md5.min.js"></script>
                <script>

                                                                               $('#assignmentList').DataTable();
                                                                               function showOtherDetails(IssueDate, loc, issuedBy, assignmentid, fileid) {
                                                                                   $.confirm({
                                                                                       title: 'Assignment Details',
                                                                                       content: '' +
                                                                                               '<form action="" class="formName"><hr/>'
                                                                                               +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">Issued By: </label>' +
                                                                                               '<label class="col-md-6">' + issuedBy + '</label>' +
                                                                                               '</div>'
                                                                                               +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">Picked From: </label>' +
                                                                                               '<label class="col-md-6">' + loc + '</label>' +
                                                                                               '</div>' +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">Issued Date: </label>' +
                                                                                               '<label class="col-md-6">' + IssueDate + '</label>' +
                                                                                               '</div>' +
                                                                                               '</form>',
                                                                                       buttons: {
                                                                                           formSubmit: {
                                                                                               text: 'Send Request',
                                                                                               btnClass: 'btn btn-primary',
                                                                                               action: function () {
                                                                                                   handoverFiles(assignmentid, fileid);
                                                                                               }
                                                                                           },
                                                                                           Close: function () {
                                                                                           },
                                                                                       },
                                                                                       onContentReady: function () {
                                                                                           // bind to events
                                                                                           var jc = this;
                                                                                           this.$content.find('form').on('submit', function (e) {
                                                                                               // if the user submits the form by pressing enter in the field.
                                                                                               e.preventDefault();
                                                                                               jc.$$formSubmit.trigger('click'); // reference the button and click it
                                                                                           });
                                                                                       }
                                                                                   });
                                                                               }
                                                                               function showOtherDetails2(IssueDate, loc, issuedBy, overduedays) {
                                                                                   $.confirm({
                                                                                       title: 'Assignment Details',
                                                                                       content: '' +
                                                                                               '<form action="" class="formName"><hr/>'
                                                                                               +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">Issued By: </label>' +
                                                                                               '<label class="col-md-6">' + issuedBy + '</label>' +
                                                                                               '</div>'
                                                                                               +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">Picked From: </label>' +
                                                                                               '<label class="col-md-6">' + loc + '</label>' +
                                                                                               '</div>' +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">Issued Date: </label>' +
                                                                                               '<label class="col-md-6">' + IssueDate + '</label>' +
                                                                                               '</div>' +
                                                                                               '</form>',
                                                                                       buttons: {
                                                                                           Close: function () {
                                                                                           },
                                                                                       }
                                                                                   });
                                                                               }

                                                                               function handoverFiles(assignmentid, fileid) {
                                                                                   $.confirm({
                                                                                       title: 'Request For Assignment Extenstion',
                                                                                       content: '' +
                                                                                               '<form action="" class="formName"><hr/>'
                                                                                               +
                                                                                               '<div class="form-group">' +
                                                                                               '<label>New Return Date: </label>' +
                                                                                               '<input type="text" id="newreturnDateValue" class=" form-control" required />' +
                                                                                               '</div>' +
                                                                                               '</form>',
                                                                                       buttons: {
                                                                                           formSubmit: {
                                                                                               text: 'Submit',
                                                                                               btnClass: 'btn btn-primary',
                                                                                               action: function () {
                                                                                                   var additem = [];
                                                                                                   var status = 'Requested';
                                                                                                   var requestedDate = $('#newreturnDateValue').val();
                                                                                                   additem.push({assignmentid: assignmentid, fielid: fileid, requestedDate: requestedDate});
                                                                                                   $.ajax({
                                                                                                       type: 'POST',
                                                                                                       data: {assignmentids: JSON.stringify(additem), assignmentStatus: status},
                                                                                                       url: "filerequest/requestassignment.htm",
                                                                                                       success: function (data) {
                                                                                                           if (data === 'success') {
                                                                                                               $.alert('Successfully Requested the File');
                                                                                                               ajaxSubmitData('filerequest/myfilelist.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                                                           } else {
                                                                                                           }
                                                                                                       }
                                                                                                   });
                                                                                               }
                                                                                           },
                                                                                           cancel: function () {
                                                                                           }
                                                                                       },
                                                                                       onContentReady: function () {
                                                                                           $('#newreturnDateValue').datepicker({
                                                                                               format: "dd/mm/yyyy",
                                                                                               autoclose: true
                                                                                           });
// bind to events
                                                                                           var jc = this;
                                                                                           this.$content.find('form').on('submit', function (e) {
                                                                                               // if the user submits the form by pressing enter in the field.
                                                                                               e.preventDefault();
                                                                                               jc.$$formSubmit.trigger('click'); // reference the button and click it
                                                                                           });
                                                                                       }

                                                                                   });
                                                                               }
                                                                               function setNewReturnDate() {
                                                                                   $.confirm({
                                                                                       title: 'More Details',
                                                                                       content: '' +
                                                                                               '<form action="" class="formName"><hr/>' +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">Created On: </label>' +
                                                                                               '<label class="col-md-6">datecreated ' + +'</label>' + '</div>' +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">Created By: </label>' +
                                                                                               '<label class="col-md-6">staffdetails' + +'</label>' +
                                                                                               '</div>' +
                                                                                               '</form>',
                                                                                       buttons: {
                                                                                           formSubmit: {
                                                                                               text: 'View',
                                                                                               btnClass: 'btn-primary',
                                                                                               action: function () {
                                                                                               }
                                                                                           },
                                                                                           cancel: function () {
                                                                                               //close
                                                                                           },
                                                                                       },
                                                                                       onContentReady: function () {
                                                                                           $('#updateReturnDate').datepicker({
                                                                                               format: "dd/mm/yyyy",
                                                                                               autoclose: true
                                                                                           });
// bind to events
                                                                                           var jc = this;
                                                                                           this.$content.find('form').on('submit', function (e) {
                                                                                               // if the user submits the form by pressing enter in the field.
                                                                                               e.preventDefault();
                                                                                               jc.$$formSubmit.trigger('click'); // reference the button and click it
                                                                                           });
                                                                                       }
                                                                                   });
                                                                               }
                                                                               function showPendingRequestDetails(IssueDate, requesteddate, issuedBy, faciltyname, daterequested) {
                                                                                   $.alert({
                                                                                       title: 'Request Details',
                                                                                       content: '' +
                                                                                               '<form action="" class="formName"><hr/>'
                                                                                               +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">Issued By: </label>' +
                                                                                               '<label class="col-md-6">' + issuedBy + '</label>' +
                                                                                               '</div>' +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">Picked From: </label>' +
                                                                                               '<label class="col-md-6">' + faciltyname + '</label>' +
                                                                                               '</div>' +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">Issued Date: </label>' +
                                                                                               '<label class="col-md-6">' + IssueDate + '</label>' +
                                                                                               '</div>' +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">Requested On: </label>' +
                                                                                               '<label class="col-md-6">' + daterequested + '</label>' +
                                                                                               '</div>' +
                                                                                               '<div class="form-group row">' +
                                                                                               '<label class="col-md-6">New Return Date: </label>' +
                                                                                               '<label class="col-md-6">' + requesteddate + '</label>' +
                                                                                               '</div>' +
                                                                                               '</form>',
                                                                                       buttons: {
                                                                                           Close: function () {

                                                                                           }
                                                                                       }
                                                                                   });
                                                                               }
                </script>
            </div>
    </main>
</div>



