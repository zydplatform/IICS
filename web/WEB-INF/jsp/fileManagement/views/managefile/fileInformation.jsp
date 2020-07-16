<%-- 
    Document   : fileInformation
    Created on : Jun 1, 2018, 11:36:00 AM
    Author     : IICS
--%>

<%@include file="../../../include.jsp"%>
<style>
    .boldedlabels{
        font-weight: bold; 
    }
</style>
<div class="row tile justify-content-center align-items-center">  
    <div class=" col col-md-12 col-sm-12 ">
        <div class="tile">
            <div class="tile-body">
                <div class="col-md-12">
                    <div id="horizontalwithwords">
                        <span class="pat-form-heading">File Information</span></div>
                    <input type="hidden" col-md-3 value="${fileno}" id="filenovalue"/>
                    <input type="hidden" col-md-3 value="${fileid}" id="fileIdvalue"/>
                    <input type="hidden" col-md-3 value="${datecreatedId}" id="datecreatedIdvalue"/>
                    <input type="hidden" col-md-3 value="${status}" id="statusIdvalue"/>
                    <input type="hidden" col-md-3 value="${staffid}" id="staffidvalue"/>
                    <input id="pnamelabel" type="hidden" col-md-3 col-sm-6 value="${pname}"/>

                </div>
                <div class="row">

                    <div class="col-md-6 boldedlabels">
                        Patient Name:
                    </div>
                    <div class="col-md-6 boldedlabels">
                        ${pname}
                    </div>
                </div>
                <br>
                <div class="row">

                    <div class="col-md-6 boldedlabels">
                        File Number:
                    </div>
                    <div class="col-md-6 boldedlabels">
                        ${fileno}
                    </div>
                </div>
                <br>
                <div class="row">

                    <div class="col-md-6 boldedlabels">
                        Created By:
                    </div>
                    <div class="col-md-6 boldedlabels">
                        ${staffdetails.firstname} ${staffdetails.lastname} ${staffdetails.othernames}
                    </div>
                </div>
                <br>
                <div class="row">

                    <div class="col-md-6 boldedlabels">
                        Created On:
                    </div>
                    <div class="col-md-6 boldedlabels">
                        ${datecreatedId} </div>
                </div>
                <br>
                <c:choose>
                    <c:when test="${status=='In'}">
                        <div class="row">
                            <div class="col-md-6 boldedlabels">
                                File Status:
                            </div>
                            <div class="col-md-6 boldedlabels">
                                <a id="loctionLink" class=" col-md-3 col-sm-6" style="color:blue;" href="#"> ${status}</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <div class="col-md-6 boldedlabels">
                                File Status:
                            </div>
                            <div class="col-md-6 boldedlabels">
                                <a id="loctionLink" class=" col-md-3" style="color:#7d047d;" href="#"> ${status}</a>
                            </div>
                        </div><br>
                        <div class="row">
                            <div class="col-md-6 boldedlabels">
                                Return Date:
                            </div>
                            <div class="col-md-6">
                                ${assignmentDetails.datereturned}
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-6 boldedlabels">
                            </div>
                            <a class="col-md-2 btn btn-primary" style="margin-right:10px;color:white;" id="viewPages" data-toggle="tooltip1" title="View Electronic File Copy">
                                <i class="fa fa-folder-open" aria-hidden="true"></i> Files
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
                <br>
            </div>
        </div>
    </div>
</div>
<%@include file="manageFile.jsp"%>
<%@include file="manageFilePages.jsp"%>
<script>

    $(document).ready(function () {
        $('#storetype').DataTable();
        $('[data-toggle="tooltip1"]').tooltip();
        $("#updatezoneid").change(function () {
            var zoneid = $('#updatezoneid').val();
            var data = {zoneid: zoneid};
            fetchCells('filelocation/fetchcells.htm', 'updatecellid', data, 'GET');
        });
        $('#updateFile').click(function () {
            fetchPatientFilePagesOrIssueOrViewUsers('filelocation/updatelocation.htm', 'updatePatientFile', 'GET');
            window.location = '#updateLocationx';
            initDialog('supplierCatalogDialog');
        });
        $('#returnFile').click(function () {
            ajaxSubmitReturnStaffDetails('fileassignment/returnfile.htm', 'GET');
        });
        $('#viewPages').click(function () {
            fetchPatientFilePagesOrIssueOrViewUsers('files/pagelist.htm', 'patientFilePages', 'GET');
        });
        $('#isssueFile').click(function () {
            fetchPatientFilePagesOrIssueOrViewUsers('fileassignment/searchstaffreturnfile.htm', 'searchStaffDialogContent', 'GET');
            window.location = '#searchStaffDialog';
            initDialog('supplierCatalogDialog');

        });
        $('#loctionLink').click(function (evt) {
            evt.preventDefault();
            window.location = '#locationORassignment';
            initDialog('fileStorageDetails');
        });

        $('#viewFileBorrowers').click(function () {
            fetchPatientFilePagesOrIssueOrViewUsers('fileassignment/listassignments.htm', 'patientFileUsers', 'GET');
            window.location = '#usersx';
            initDialog('supplierCatalogDialog');
        });
        $('#viewPageDetailsButton').click(function () {
            window.location = '#viewPageDetails';
            initDialog('supplierCatalogDialog');
        });
    });
    function showLocORassignDetails() {

        window.location = '#locationORassignment';
        initDialog('supplierCatalogDialog');

    }
    function fetchPatientFilePagesOrIssueOrViewUsers(Url, responsDiv, method) {
        var fileno = $('#filenovalue').val();
        var fileid = $('#fileIdvalue').val();
        var pnamelabel = $('#pnamelabel').val();

        var data = {
            fileno: fileno, fileid: fileid, pname: pnamelabel};
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            timeout: 98000,
            success: function (resp) {
                if (responsDiv === 'patientFilePages') {
                    $.confirm({
                        title: '<h3><font color="purple">Patient File Pages</font></h3>',
                        content: '' +
                                '<div class="col-md-12">'+
                            '<div class="tile"><div class="tile-body">'+
                             '<div id="patientFilePages">'+resp+
                            '</div>'+
                            '</div></div>'+
                        '</div>',
                        columnClass: 'col-md-10 col-md-offset-1',
                        containerFluid: true, // this will add 'container-fluid' instead of 'container'
                       
                buttons: {
        Close: function () {
            //close
        },
    },
            });
                } else {
                    $('#' + responsDiv).html(resp);
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
    function ajaxSubmitUpdatedLocation(Url, method) {
        var zoneid = $('#updatezoneid').val();
        var cellid = $('#updatecellid').val();
        var fileno = $('#fileIdvalue').val();
        var locationid = $('#locationidvalue').val();
        alert('zone' + zoneid + 'cell' + cellid + 'file' + fileno + 'locationidvalue' + locationid);
        var data = {
            zoneid: zoneid,
            cellid: cellid,
            fileno: fileno,
            locationid: locationid};
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            timeout: 98000,
            success: function (resp) {
                var obj = JSON.parse(resp);
                var options = "";
                for (var k = 0; k < obj.length; k++) {
                    options += "<option value=" + obj[k].bayrowcellid + ">" + obj[k].celllabel + "</option>";
                    $('#zonelevellid').html(obj[k].zonelabel);
                    $('#zonelevellidvalue').val(obj[k].zoneid);
                    $('#locationidvalue').val(obj[k].locationid);
                    $('#zonebayid').html(obj[k].baylabel);
                    $('#baylevelidvalue').val(obj[k].zonebayid);
                    $('#celllevelid').html(obj[k].celllabel);
                    $('#celllevelidvalue').val(obj[k].bayrowcellid);
                }
                window.location = '#close';
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

    function doAjax() {
// Get form
        var form = $('#fileUploadForm')[0];
        var data = new FormData(form);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: 'files/multipleFileUpload',
            data: data,
            processData: false, //prevent jQuery from automatically transforming the data into a query string
            contentType: false,
            cache: false,
            success: function (data) {
                alert(data);
            },
            error: function (e) {
                alert(e.responseText);
            }
        });
    }
    function fetchCells(Url, respDiv, data, method) {
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            timeout: 98000,
            success: function (resp) {
                alert(resp);
                var obj = JSON.parse(resp);
                var options = "";
                for (var k = 0; k < obj.length; k++) {
                    options += "<option value=" + obj[k].bayrowcellid + ">" + obj[k].celllabel + "</option>";
                }
                $('#' + respDiv).html(options);
            },
            error: function (jqXHR, error, errorThrown) {
                if (Url !== 'checkUserNotification.htm') {
                    if (jqXHR.status && jqXHR.status === 400) {
                        alert('Server returned an Error, contact admin');
                    } else if (error === "timeout") {
                        alert("Request timed out, contact admin");
                    } else {
                        alert("Something went wrong, contact system admin");
                    }
                }
            }
        });
    }
    function viewPatientFileDetails(fileid, fileno, pname, datecreatedId, statusId, staffid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "patients/patientfiledetails.htm",
            data: {staffid: staffid, pname: pname, fileid: fileid, fileno: fileno, statusId: statusId, datecreatedId: datecreatedId},
            success: function (response) {
                $('#filedetailspane').html(response);
            }
        });
    }
</script> 