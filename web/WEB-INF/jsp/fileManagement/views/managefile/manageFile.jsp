<%-- 
    Document   : manageFile
    Created on : Jun 18, 2018, 12:14:02 PM
    Author     : IICS
--%>
<style>
    .filelocationdetailsbuttons{
        margin-right:5px;
        margin-bottom:10px;
    }
</style>
<!-- Issue file-->
<div class="row">
    <div class="col-md-12">
        <div id="searchStaffDialog" class="fileAssignmentDetails">
            <div class="scrollbar">
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title align-items-center"><font color="purple">Search Staff</font></h2>
                    <hr>
                </div>
                <div class=" col-md-12 tile-body">
                    <div  id="searchStaffDialogContent">
                    </div>
                </div>                      
            </div>

        </div>
    </div>
</div>
<!-- locate File-->
<div class="row">
    <c:choose>
        <c:when test="${status=='In'}">
            <div class="col-md-8">
                <div id="locationORassignment" class="fileStorageDetails">
                    <div class="scrollbar">
                        <div id="head">
                            <a href="#close" title="Close" class="close2">X</a>
                            <h2 class="modalDialog-title align-items-center"></h2>
                            <hr>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <div id="horizontalwithwords">
                                            <span class="pat-form-heading">Storage Details</span></div>
                                        <c:forEach items="${fu}" var="f">
                                            <div class="row">
                                                <div class="col-md-6 boldedlabels">
                                                    Facility Unit:
                                                </div>
                                                <div class="col-md-6 boldedlabels" id="facilityuinitid" >
                                                    ${f.facilityunitname}
                                                </div>
                                            </div>
                                            <br>
                                        </c:forEach>
                                        <c:forEach items="${locDetails}" var="locDetails">  
                                            <input type="hidden" value="${locDetails.zoneid}" id="zonelevellidvalue"/>
                                            <input type="hidden" value="${locDetails.locationid}" id="locationidvalue"/>
                                            <input type="hidden" value="${locDetails.zonebayid}" id="baylevelidvalue"/>
                                            <input type="hidden" value="${locDetails.bayrowid}" id="bayrowlevelidvalue"/>
                                            <input type="hidden" value="${locDetails.rowlabel}" id="bayrowlabelvalue"/>
                                            <input type="hidden" value="${locDetails.bayrowcellid}" id="celllevelidvalue"/>
                                            <input type="hidden" value="${locDetails.bayrowcellid}" id="celllevelidvalue"/>
                                            <div class="row">
                                                <div class="col-md-6 boldedlabels">
                                                    Zone Label:
                                                </div>
                                                <div class="col-md-6 boldedlabels" id="zonelevellid">
                                                    ${locDetails.zonelabel}
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-md-6 boldedlabels">
                                                    Bay Label:
                                                </div>
                                                <div class="col-md-6 boldedlabels" id="baylevelid">
                                                    ${locDetails.baylabel}
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-md-6 boldedlabels">
                                                    Bay Row Label:
                                                </div>
                                                <div class="col-md-6 boldedlabels"  id="bayrowlevelid" >
                                                    ${locDetails.rowlabel}
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-md-6 boldedlabels">
                                                    cell Label:
                                                </div>
                                                <div class="col-md-6 boldedlabels" id="celllevelid" >
                                                    ${locDetails.celllabel}
                                                </div>
                                            </div>
                                            <br>
                                        </c:forEach> 
                                        <div class="row">
                                            <div class="col-md-2"></div>
                                            <a class="col-md-3  btn btn-primary filelocationdetailsbuttons" style=" color:white;" id="viewPages"  title="View Electronic File Copy">
                                                <i class="fa fa-folder-open" aria-hidden="true"></i> Files
                                            </a>
                                            <a class=" col-md-3 btn btn-secondary filelocationdetailsbuttons" style=" color:white;"  id="updateFile" title="Update File Location">
                                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i> Update 
                                            </a>
                                            <a class="col-md-3 form-control-sm  btn btn-info filelocationdetailsbuttons" style=" color:white;"  id="isssueFile" title="Issue Out File">
                                                <i class="fa fa-check" aria-hidden="true"></i>Issue 
                                            </a>  
                                        </div>  
                                        <br>
                                    </div>

                                    <div class=" row form-group">
                                        <label class="control-label col-md-1"></label>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_ISSUEFILE')">
                                            <a class=" col-md-2 btn btn-success"style="margin-right:10px;color:white;"  id="isssueFile">
                                                Issue File
                                            </a>
                                        </security:authorize>

                                        <a class="col-md-4 btn btn-primary" style="margin-right:10px;color:white;" id="viewPages">
                                            View Electronic Files
                                        </a>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_UPDATEFILELOCATION')">
                                            <a class=" col-md-4 btn btn-secondary"style="margin-right:10px;color:white;" id="updateFile">
                                                Update File Location
                                            </a>
                                        </security:authorize>
                                    </div>
<<<<<<< HEAD
                                </div>
=======
 </div>
>>>>>>> 133f974c8047d071e6d36164d7c7e87e0c4edada
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="col-md-8">
                <div id="locationORassignment" class="fileAssignmentDetails">
                    <div class="scrollbar">
                        <div id="head">
                            <a href="#close" title="Close" class="close2">X</a>
                            <h2 class="modalDialog-title align-items-center"></h2>
                            <hr>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <div id="horizontalwithwords">
                                            <span class="pat-form-heading">Assignment Details</span></div>
                                        <input type="hidden" value="${assignmentDetails.assignmentid}" id="assignmentidvalue"/>
                                        <div class="row">
                                            <div class="col-md-6 boldedlabels">
                                                Current User:
                                            </div>
                                            <div class="col-md-6 boldedlabels" id="baylevelid" >
                                                ${assignmentDetails.staffDetails.firstname} ${as.staffDetails.othernames} ${as.staffDetails.lastname}
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-md-6 boldedlabels">
                                                Current Location:
                                            </div>
                                            <div class="col-md-6 boldedlabels" id="baylevelid" >
                                                ${assignmentDetails.staffDetails.facilityunitname}
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-md-6 boldedlabels">
                                                Issued By:
                                            </div>
                                            <div class="col-md-6 boldedlabels" id="issuedByNameValue">${assignmentDetails.firstname} ${assignmentDetails.othernames} ${assignmentDetails.lastname} 
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-md-6 boldedlabels">
                                                Issue Date:
                                            </div>
                                            <div class="col-md-6 boldedlabels"id="issuedateidvalue">${assignmentDetails.dateassigned}
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-md-6 boldedlabels">
                                                Return Date:
                                            </div>
                                            <div class="col-md-6 boldedlabels" id="returndateidvalue">${assignmentDetails.datereturned}
                                            </div>
                                        </div>
                                        <br>
                                        <c:if test="${assignmentDetails.assignstatus=='Out'}">
                                            <c:choose>

                                                <c:when test="${assignmentDetails.daystate}">

                                                    <div class="row">
                                                        <div class="col-md-6 boldedlabels">
                                                            Overdue(Days):
                                                        </div>
                                                        <div class="col-md-6 boldedlabels" id ="daysidValue" >${assignmentDetails.days}
                                                        </div>
                                                    </div>
                                                    <br>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="row">
                                                        <div class="col-md-6 boldedlabels">
                                                            Remaining(Days):
                                                        </div>
                                                        <div class="col-md-6 boldedlabels" id="daysidValue">${assignmentDetails.days}
                                                        </div>
                                                    </div>
                                                    <br>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="row">
                                                <div class="col-md-1 boldedlabels">

                                                </div>
                                                <a class="col-md-6 btn btn-primary filelocationdetailsbuttons" style=" color:white;" onclick="update()">
                                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>    Update Assignment
                                                </a>
                                                <a class=" col-md-4 btn btn-secondary filelocationdetailsbuttons" style=" color:white;" id="returnFile">
                                                    <i class="fa fa-reply" aria-hidden="true"></i>  Return File
                                                </a>
                                            </div>
                                            <br>
                                        </c:if>
                                        <c:if test="${assignmentDetails.status=='Requested'}">
                                            
                                                  <div class="row">
                                                        <div class="col-md-6 boldedlabels">
                                                            Status:
                                                        </div>
                                                        <div class="col-md-6 boldedlabels">${assignmentDetails.assignstatus}
                                                        </div>
                                                    </div>
                                                    <br>
                                            <div class="row">
                                                <div class="col-md-1 boldedlabels">

                                                </div>
                                                <a class=" col-md-4 btn btn-secondary filelocationdetailsbuttons" style=" color:white;" id="returnFile">
                                                    <i class="fa fa-reply" aria-hidden="true"></i>  Return File
                                                </a>
                                            </div>
                                            <br>


                                        </c:if>
                                        <c:if test="${assignmentDetails.status=='Recalled'}">
                                                     <div class="row">
                                                        <div class="col-md-6 boldedlabels">
                                                           Status:
                                                        </div>
                                                        <div class="col-md-6 boldedlabels">${assignmentDetails.assignstatus}
                                                        </div>
                                                    </div>
                                                    <br>
                                            <div class="row">
                                                <div class="col-md-1 boldedlabels">

                                                </div>
                                                <a class=" col-md-4 btn btn-secondary filelocationdetailsbuttons" style=" color:white;" id="returnFile">
                                                    <i class="fa fa-reply" aria-hidden="true"></i>  Return File
                                                </a>
                                            </div>
                                            <br>
                                             </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </c:otherwise>
    </c:choose>

</div>
<div class="row">
    <div class="col-md-12">
        <div id="usersx" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title"><font color="purple">View Assignments</font></h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">                        
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <div id="patientFileUsers"></div>
                                    </div>                                        
                                </div>                                                               
                            </div>                                
                        </div>
                    </div>                        
                </div>
            </div>

        </div>
    </div>
</div>

<div class="">
    <div id="updateLocationx" class="newPatientFileForm">
        <div class="scrollbar">
            <div id="head">
                <h3 class="modal-title" id="title"><font color="purple">Update File Location</font></h3>
                <a href="#close" title="Close" class="close2">X</a>
                <hr>
            </div>
            <div class="">
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div id="updatePatientFile"></div>
                            <div class="tile-footer row">
                                <div class="col-lg-2 offset-lg-10">
                                    <input type="button" value="Update" class="btn btn-primary  pull-right " onClick="ajaxSubmitUpdateLocation('filelocation/updatelocation.htm', 'POST');"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="returnFilex" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title"><font color="purple">Return File</font></h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">                        
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div id="returnPatientFile"></div>                                      
                                </div>                                                               
                            </div>                                
                        </div>
                    </div>                        
                </div>
            </div>

        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('[data-toggle="tooltip2"]').tooltip();
        $("#viewPages").tooltip();
        $("#updateFile").tooltip();
        $("#isssueFile").tooltip();
    });
    function update() {
        $.confirm({
            title: 'Upadate File Assignment',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Choose New Date</label>' +
                    '<input type="text" id="updateReturnDate" class=" form-control" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Update',
                    btnClass: 'btn btn-primary',
                    action: function () {

                        var updateReturnDate = this.$content.find('#updateReturnDate').val();
                        if (updateReturnDate !== null || updateReturnDate !== '') {
                            submitNewDate('fileassignment/updateassignment.htm', 'GET', updateReturnDate)
                        } else {
                            $.alert({
                                content: 'Date Field can not be empty!',
                            });
                        }
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
    function submitNewDate(Url, method, returnDateValue) {
        var assignmentidvalue = $('#assignmentidvalue').val();
        var data = {assignmentid: assignmentidvalue, returnDateValue: returnDateValue};
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            timeout: 98000,
            success: function (resp) {
                if (resp !== 'failed') {
                    var fileid = $('#fileIdvalue').val();
                    var fileno = $('#filenovalue').val();
                    var pname = $('#pnamelabel').val();
                    var datecreatedId = $('#datecreatedIdvalue').val();
                    var statusId = $('#statusIdvalue').val();
                    var staffid = $('#staffidvalue').val();
                    viewPatientFileDetails(fileid, fileno, pname, datecreatedId, statusId, staffid);

                } else {
                    $.alert({
                        content: 'Failed To Update File Assignment.Please Try Again.',
                    });

                }
            },
            error: function (jqXHR, error, errorThrown) {
                if (Url !== 'checkUserNotification.htm') {
                    if (jqXHR.status && jqXHR.status === 400) {
                        alert('Server returned an Error, contact admin');
                    } else if (error === "timeout") {
                        alert("Request timed out, contact admin");
                    } else {
                        //                    alert("Something went wrong, contact system admin");
                    }
                }
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
            url: "fileassignment/confirmfilereturn.htm",
            data: {username: username, password: pass},
            success: function (response) {

                if (response == 'success') {
                    var fileid = $('#fileIdvalue').val();
                    var fileno = $('#filenovalue').val();
                    var pname = $('#pnamelabel').val();
                    var datecreatedId = $('#datecreatedIdvalue').val();
                    var statusId = 'In';
                    var staffid = $('#staffidvalue').val();
                    viewPatientFileDetails(fileid, fileno, pname, datecreatedId, statusId, staffid);
                } else {
                    $.alert({
                        content: response,
                    });

                }
            }
        });
    }
    /*******************************************************/
    function ajaxSubmitReturnStaffDetails(Url, method) {
        var assignmentid = $('#assignmentidvalue').val();
        var fileno = $('#filenovalue').val();
        var fileid = $('#fileIdvalue').val();
        var data = {
            assignmentid: assignmentid, fileno: fileno, fileid: fileid};
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            timeout: 98000,
            success: function (resp) {
                if (resp !== 'success') {
                    $.alert({
                        content: 'Error Occurred. Please Try Again',
                    });

                } else {
                    confirmFileHandOvers();
                }
            },
            error: function (jqXHR, error, errorThrown) {
                if (Url !== 'checkUserNotification.htm') {
                    if (jqXHR.status && jqXHR.status === 400) {
                        alert('Server returned an Error, contact admin');
                    } else if (error === "timeout") {
                        alert("Request timed out, contact admin");
                    } else {
                        //                    alert("Something went wrong, contact system admin");
                    }
                }
            }
        });

    }</script>
