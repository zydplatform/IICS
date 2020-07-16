<%@include file="../../../include.jsp"%>
<div class="col-md-12">
    <div class="tile">
        <div class="col-md-12" style="display: none" id="receiveRecallButton">
                <div class="pull-right" id="handOverItemsdiv">
                    <button class="btn btn-secondary" id="receiveitems"  onclick="handoverFiles2()"><i class="fa fa-check"></i>Return</button>
                </div>  
        </div><br><br>
        <div class="tile-body">
            <div class="row">
                <div class="col-md-12"> 
                    <table class="table table-hover" id="assignmentList">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>File No</th>
                                <th >Return Date</th>
                                <th >Status</th>
                                <th >Details</th>
                                <th >Return</th>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                            <% int h = 1;%>
                            <c:forEach items="${assignments}" var="assignment">
                                <c:if test="${assignment.status=='Out'}">
                                    <tr>
                                        <td><%=h++%></td>
                                        <td >
                                            <a id="loctionLink"  onclick="showAssignmentHistory(${assignment.fileid})" class=" col-md-3" style="color:#7d047d;" >${assignment.fileno}</a>
                                        </td>
                                        <td>${assignment.datereturned}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${assignment.daystate}">
                                                    <a id="loctionLink" class=" col-md-3" style="color:#7d047d;" href="#"> Overdue: ${assignment.days} days</a>

                                                </td></c:when>
                                            <c:otherwise>
                                        <a id="loctionLink" class=" col-md-3" style="color:blue;" href="#"> Remaining: ${assignment.days} days </a></c:otherwise>
                                </c:choose>
                                <td class="center">
                                    <a data-dateissued="${assignment.dateassigned}" data-newreturnedDate="" data-fileid="${assignment.fileid}"
                                       onclick="showFilesOutDetails($(this).attr('data-dateissued')
                                                       , $(this).attr('data-newreturnedDate'),
                                                       '${assignment.firstname} ${assignment.othernames} ${assignment.lastname}',
                                                                       '${assignment.staffDetails.firstname} ${assignment.staffDetails.othernames} ${assignment.staffDetails.lastname}',
                                                                                       '${assignment.staffDetails.facilityunitname}'
                                                                                       , '${assignment.assignmentid}', $(this).attr('data-fileid'), '${assignment.status}')" href="#">
                                        <button class="btn btn-sm btn-secondary">
                                            0</button></a>
                                </td><td class="center">
                                    <div class="row">
                                        <div class="col-md-4"></div>
                                        <div class="col-md-4">
                                            <div class="animated-checkbox">
                                                <label>
                                                    <input type="checkbox" name="handover" id="${assignment.assignmentid}" data-fileid="${assignment.fileid}"  onChange="if (this.checked) {
                                                                checkBorrowedFiles('checked', this.id, $(this).attr('data-fileid'), 'handover');
                                                            } else {
                                                                checkBorrowedFiles('unchecked', this.id, $(this).attr('data-fileid'), 'handover');
                                                            }"><span class="label-text" ></span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4"></div>
                                    </div>
                                </td>
                                </tr>
                            </c:if>
                            <c:if test="${assignment.status=='Requested'}">
                                <tr>
                                    <td><%=h++%></td>
                                    <td >
                                        <a id="loctionLink"  onclick="showAssignmentHistory(${assignment.fileid})" class=" col-md-3" style="color:#7d047d;" >${assignment.fileno}</a>
                                    </td>
                                    <td>${assignment.datereturned}</td>
                                    <td>
                                    <c:choose>
                                            <c:when test="${assignment.days>0}">
                                                <a id="loctionLink" class=" col-md-3" style="color:#7d047d;" href="#"> Requested: ${assignment.days} days ago.</a>
                                             </td></c:when>
                                        <c:otherwise>
                                        <a id="loctionLink" class=" col-md-3" style="color:#7d047d;"href="#"> Requested: Today </a></c:otherwise>
                                </c:choose>
                                <td class="center">
                                    <a data-dateissued="${assignment.dateassigned}"data-newreturnedDate="${assignment.requesteddate}"data-fileid="${assignment.fileid}"
                                       onclick="showFilesOutDetails($(this).attr('data-dateissued')
                                                       , $(this).attr('data-newreturnedDate'),
                                                       '${assignment.firstname} ${assignment.othernames} ${assignment.lastname}',
                                                                       '${assignment.staffDetails.firstname} ${assignment.staffDetails.othernames} ${assignment.staffDetails.lastname}',
                                                                                       '${assignment.staffDetails.facilityunitname}'
                                                                                       , '${assignment.assignmentid}', $(this).attr('data-fileid'),'${assignment.status}')" href="#">
                                        <button class="btn btn-sm btn-secondary">
                                            0</button></a>
                                </td><td class="center">
                                    <div class="row">
                                        <div class="col-md-4"></div>
                                        <div class="col-md-4">
                                            <div class="animated-checkbox">
                                                <label>
                                                    <input type="checkbox" name="handover" id="${assignment.assignmentid}" data-fileid="${assignment.fileid}"  onChange="if (this.checked) {
                                                                checkBorrowedFiles('checked', this.id, $(this).attr('data-fileid'), 'handover');
                                                            } else {
                                                                checkBorrowedFiles('unchecked', this.id, $(this).attr('data-fileid'), 'handover');
                                                            }"><span class="label-text" ></span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4"></div>
                                    </div>
                                </td>
                                </tr>
                            </c:if>
                            <c:if test="${assignment.status=='Denied'}">
                                           <tr>
                                        <td><%=h++%></td>
                                        <td >
                                            <a id="loctionLink"  onclick="showAssignmentHistory(${assignment.fileid})" class=" col-md-3" style="color:#7d047d;" >${assignment.fileno}</a>
                                        </td>
                                        <td>${assignment.datereturned}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${assignment.daystate}">
                                                    <a id="loctionLink" class=" col-md-3" style="color:#7d047d;" href="#"> Overdue: ${assignment.days} days</a>

                                                </td></c:when>
                                            <c:otherwise>
                                        <a id="loctionLink" class=" col-md-3" style="color:blue;" href="#"> Remaining: ${assignment.days} days </a></c:otherwise>
                                </c:choose>
                                <td class="center">
                                    <a data-dateissued="${assignment.dateassigned}" data-newreturnedDate="${assignment.requesteddate}"data-fileid="${assignment.fileid}"
                                       onclick="showFilesOutDetails($(this).attr('data-dateissued')
                                                       , $(this).attr('data-newreturnedDate'),
                                                       '${assignment.firstname} ${assignment.othernames} ${assignment.lastname}',
                                                                       '${assignment.staffDetails.firstname} ${assignment.staffDetails.othernames} ${assignment.staffDetails.lastname}',
                                                                                       '${assignment.staffDetails.facilityunitname}'
                                                                                       , '${assignment.assignmentid}', $(this).attr('data-fileid'),'${assignment.status}')" href="#">
                                        <button class="btn btn-sm btn-secondary">
                                            0</button></a>
                                </td><td class="center">
                                    <div class="row">
                                        <div class="col-md-4"></div>
                                        <div class="col-md-4">
                                            <div class="animated-checkbox">
                                                <label>
                                                    <input type="checkbox" name="handover" id="${assignment.assignmentid}" data-fileid="${assignment.fileid}"  onChange="if (this.checked) {
                                                                checkBorrowedFiles('checked', this.id, $(this).attr('data-fileid'), 'handover');
                                                            } else {
                                                                checkBorrowedFiles('unchecked', this.id, $(this).attr('data-fileid'), 'handover');
                                                            }"><span class="label-text" ></span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4"></div>
                                    </div>
                                </td>
                                </tr>
                            </c:if>
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
                                                        var addborrowitem = [];
                                                        var temp = [];
                                                        var checkStatus;
                                                        function checkBorrowedFiles(type, itemid, fielid, menu) {
                                                            checkStatus = menu;
                                                            if (type === 'checked') {
                                                                document.getElementById("receiveRecallButton").style.display = 'block';
                                                                addborrowitem.push({assignmentid: itemid, fielid: fielid});
                                                            } else {
                                                                for (index in addborrowitem) {
                                                                    var res = addborrowitem[index];
                                                                    if (itemid === res["assignmentid"]) {
                                                                        var removed = addborrowitem.splice(index, 1);
                                                                        if (addborrowitem.length === 0) {
                                                                            document.getElementById("receiveRecallButton").style.display = 'none';
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        $('#assignmentList').DataTable();
                                                        function showFilesOutDetails(IssueDate,newreturnedDate, issuedBy, currentUser, currentLocation, assignmentid, fileid,status) {
                                                               $.confirm({
                                                                title: 'Assignment Details',
                                                                content: '' +
                                                                        '<form action="" class="formName" id="formDetails"><hr/>'
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
                                                                        '<label class="col-md-6">Issued Date: </label>' +
                                                                        '<label class="col-md-6">' + IssueDate + '</label>' +
                                                                        '</div>' +
                                                                        '</form>',
                                                                buttons: {
                                                                    formSubmit: {
                                                                        text: 'Recall  File',
                                                                        btnClass: 'btn btn-primary',
                                                                        action: function () {
                                                                            $.confirm({
                                                                                title: 'Confirm',
                                                                                content: '' +
                                                                                        '<form action="" class="formName"><hr/>' +
                                                                                        '<label Style="color:red;">Are You Sure You Want To Re Call This File ? </label>' +
                                                                                        '</div>' +
                                                                                        '</form>',
                                                                                buttons: {
                                                                                    confirm: function () {
                                                                                        var addborrowitem = [];
                                                                                        var status = 'Recalled';
                                                                                        addborrowitem.push({assignmentid: assignmentid, fielid: fileid});
                                                                                        $.ajax({
                                                                                            type: 'POST',
                                                                                            data: {assignmentids: JSON.stringify(addborrowitem), assignmentStatus: status},
                                                                                            url: "fileassignment/recallassignment.htm",
                                                                                            success: function (data) {
                                                                                                if (data === 'success') {
                                                                                                    $.alert('Successfully Recalled the File');
                                                                                                    ajaxSubmitData('fileassignment/listassignments.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                                                                                                } else {
                                                                                                    $.alert('Failed to submit data!');
                                                                                                }
                                                                                            }
                                                                                        });
                                                                                    },
                                                                                    cancel: function () {
                                                                                        $.alert('Canceled!');
                                                                                    }
                                                                                }
                                                                            });
                                                                        }
                                                                    },
                                                                    Close: function () {
                                                                        //close
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

                                                        function handoverFiles2() {
                                                            var status = '';
                                                            var url = '';
                                                            if (checkStatus === 'handover') {
                                                                status = 'In';
                                                                url = 'fileassignment/handoverfiles.htm';
                                                            } else {
                                                                status = 'Recalled';
                                                                url = 'fileassignment/recallfiles.htm';

                                                            }
                                                            if (parseInt(addborrowitem.length) === 0 && status !== '') {
                                                                alert("Please select items");
                                                            } else {
                                                                $.ajax({
                                                                    type: 'POST',
                                                                    data: {assignmentids: JSON.stringify(addborrowitem), assignmentStatus: status},
                                                                    url: url,
                                                                    success: function (data) {
                                                                        if (data === 'success') {
                                                                            if (status === 'Recalled') {
                                                                                alert('successfully Recalled' + addborrowitem.length + ' files');
                                                                                ajaxSubmitData('fileassignment/listassignments.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                            } else {
                                                                                confirmFileHandOvers2();

                                                                            }
                                                                        } else {
                                                                            $.alert('Failed to submit data!');
                                                                        }
                                                                    }
                                                                });
                                                            }
                                                        }
                                                        function confirmFileHandOvers2() {
                                                            $.confirm({
                                                                title: 'Upadate File Assignment',
                                                                content: '' +
                                                                        '<form action="" class="formName">' +
                                                                        '<div class="form-group">' +
                                                                        '<label>USERNAME:</label>' +
                                                                        '<input class="form-control"  id="borrowerusername" type="text" placeholder="username" required style="margin-bottom: 2.5em" size="15">' +
                                                                        '</div>' +
                                                                        '<div class="form-group">' +
                                                                        '<label>PASSWORD:</label>' +
                                                                        '<input class="form-control" id="borrowerpassword" type="password" placeholder="Password" required size="15">' +
                                                                        '</div>' +
                                                                        '</form>',
                                                                buttons: {
                                                                    formSubmit: {
                                                                        text: 'Confirm',
                                                                        btnClass: 'btn btn-primary',
                                                                        action: function () {
                                                                            var password = this.$content.find('#borrowerpassword').val();
                                                                            var username = this.$content.find('#borrowerusername').val();
                                                                            if (username !== null || username !== '' || password !== null || password !== '') {
                                                                                authenticateUser2(password, username);
                                                                            } else {
                                                                                alert(" Fields can not be empty.");
                                                                            }
                                                                        }
                                                                    },
                                                                    cancel: function () {
                                                                        //close
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
                                                        function authenticateUser2(password, username) {
                                                            var pass;
                                                            if (username === '' && password === '') {
                                                                alert('Enter Your Credentials');
                                                            } else {
                                                                pass = md5(password);
                                                            }
                                                            $.ajax({
                                                                type: "GET",
                                                                cache: false,
                                                                url: "fileassignment/confirmfilehandover.htm",
                                                                data: {username: username, password: pass},
                                                                success: function (response) {
                                                                    var obj = JSON.parse(response);
                                                                    if (obj.status !== 'success') {
                                                                        ajaxSubmitData('fileassignment/listassignments.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    } else {
                                                                        alert('Successfully Returned' + addborrowitem.length + ' files');
                                                                        ajaxSubmitData('fileassignment/listassignments.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    }
                                                                }
                                                            });
                                                        }
</script>
