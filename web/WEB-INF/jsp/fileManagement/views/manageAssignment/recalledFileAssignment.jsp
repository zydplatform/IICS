<%@include file="../../../include.jsp"%>
<div class="col-md-12">
        <div class="tile">
             <div class="col-md-12" id="handoverrecalleditems" style="display:none">
                    <div class="pull-right" id="receiveitemsdiv">
                        <button class="btn btn-secondary" id="receiveitems" onclick="handoverFiles()"><i class="fa fa-check"></i>Return</button>
                    </div>   
                </div>
            <br><br>
            <div class="tile-body">
            <table class="table table-hover" id="recalledAssignmentList">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>File No</th>
                                    <th >Over Due Days</th>
                                    <th>Recalled On</th>
                                    <th >Details</th>
                                    <th >Return</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody">
                            <div class="row scrollbar" id="content">
                                <% int h = 1;%>
                                <c:forEach items="${assignments}" var="assignment">
                                    <tr>
                                        <td><%=h++%></td>
                                       <td >
                                        <a id="loctionLink"  onclick="showAssignmentHistory(${assignment.fileid})" class=" col-md-3" style="color:#7d047d;" >${assignment.fileno}</a>
                                    </td>
                                         <td>${assignment.days}</td>
                                          <td>${assignment.activityDate}</td>
                                            <td class="center">
                                                <a data-dateissued="${assignment.dateassigned}" data-datereturned="${assignment.datereturned}"
                                                   onclick="showOtherDetails($(this).attr('data-dateissued')
                                                                   , $(this).attr('data-datereturned'),
                                                                   '${assignment.firstname} ${assignment.othernames} ${assignment.lastname}',
                                                                                   '${assignment.staffDetails.firstname} ${assignment.staffDetails.othernames} ${assignment.staffDetails.lastname}',
                                                                                                   '${assignment.staffDetails.facilityunitname}'
                                                                                                   , '${assignment.assignmentid}')" href="#">
                                                    <button class="btn btn-sm btn-secondary">
                                                        0</button></a>
                                            </td>
                                            <td class="center">
                                                <div class="row">
                                                    <div class="col-md-4"></div>
                                                    <div class="col-md-4">
                                                        <div class="animated-checkbox">
                                                            <label>
                                                                <input type="checkbox" name="handover" id="${assignment.assignmentid}" data-fileid="${assignment.fileid}"  onChange="if (this.checked) {
                                                                            checkeditem1('checked', this.id, $(this).attr('data-fileid'), 'handover');
                                                                        } else {
                                                                            checkeditem1('unchecked', this.id, $(this).attr('data-fileid'), 'handover');
                                                                        }"><span class="label-text" ></span>
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4"></div>
                                                </div>
                                            </td></c:forEach>
                                        </tr>
                                </tbody>
                            </div> </table> 
           </div>
        </div>
</div>

    <script src="static/res/js/sec/md5.min.js"></script>
    <script>
   $(document).ready(function () {
         loadItemSize("recalledFilesTab","<%=h-1%>");
     });
   $('#recalledAssignmentList').DataTable();
                              var additem = [];
                            var temp = [];
                            var checkStatus;
                            function checkeditem1(type, itemid, fielid, menu) {
                                checkStatus = menu;
                        if (type === 'checked') {
                                    document.getElementById("handoverrecalleditems").style.display = 'block';
                                    additem.push({assignmentid: itemid, fielid: fielid});
                                } else {
                                    for (index in additem) {
                                        var res = additem[index];
                                        if (itemid === res["assignmentid"]) {
                                            var removed = additem.splice(index, 1);
                                            if (additem.length === 0) {
                                                document.getElementById("handoverrecalleditems").style.display = 'none';
                                            }
                                        }
                                    }
                                }
                            }
                            function handoverFiles() {
                                var status = '';
                                var url = '';
                                status = 'Returned';
                                url = 'fileassignment/handoverfiles.htm';
                                if (parseInt(additem.length) === 0 && status !== '') {
                                    alert("Please select items");
                                } else {
                                    $.ajax({
                                        type: 'POST',
                                        data: {assignmentids: JSON.stringify(additem), assignmentStatus: status},
                                        url: url,
                                        success: function (data) {
                                            if (data === 'success') {
                                                if (status === 'Recalled') {
                                                    alert("successfully Recalled Files");
                                                } else {
                                                    confirmFileHandOvers();
                                                }
                                            } else {
                                                $.alert('Failed to submit data!');
                                            }
                                        }
                                    });
                                }
                            }
                            function showOtherDetails(IssueDate, returnedDate, issuedBy, currentUser, currentLocation, assignmentid, fileid) {
                                $.confirm({
                                    title: 'Assignment Details',
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
                                            '<label class="col-md-6">Issued Date: </label>' +
                                            '<label class="col-md-6">' + IssueDate + '</label>' +
                                            '</div>' +
                                            '<div class="form-group row">' +
                                            '<label class="col-md-6">Return Date: </label>' +
                                            '<label class="col-md-6">' + returnedDate + '</label>' +
                                            '</div>' +
                                            '</form>',
                                    buttons: {
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
                            function confirmFileHandOvers() {
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
                                                    authenticateUser(password, username);
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
                            function authenticateUser(password, username) {
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
                                            alert(obj.status);
                                        } else {
                                            alert('Successfully Returned' + additem.length + ' files');
                                            ajaxSubmitData('fileassignment/listassignments.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                        }
                                    }
                                });
                            }
    </script>