<%-- 
    Document   : laboratoryPatientTests
    Created on : Sep 27, 2018, 4:01:16 PM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<input id="laboratoryrequest_formid" value="${laboratoryrequestid}" type="hidden">
<div class="row">
    <div class="col-md-4">
        <div class="form-group bs-component">
            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Request Number:</strong></span>&nbsp;
            <strong >
                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${laboratoryrequestnumber}</strong></span>
            </strong>
        </div> 
    </div>
    <div class="col-md-4">
        <div class="form-group bs-component">
            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Origin Unit:</strong></span>&nbsp;
            <strong >
                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${facilityunitname}</strong></span>
            </strong>
        </div>   
    </div>
    <div class="col-md-4">
        <div class="form-group bs-component">
            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Requested By:</strong></span>&nbsp;
            <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${staffdetails}</strong></span>
        </div>  
    </div>
</div>
<br>
<div class="row">
    <div class="col-md-5">
        <div id="laboratoryrequestedtestsdiv">
            <table class="table table-hover table-bordered">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Test Name</th>
                        <th>Update</th>
                    </tr>
                </thead>
                <tbody >

                </tbody>
            </table>
        </div>
    </div> 
    <input id="allowdtoPrintPatientLabTests" value="0" type="hidden">
    <div class="col-md-7">
        <table class="table table-hover table-bordered">
            <thead>
                <tr>
                    <th>Test Name</th>
                    <th>Results</th>
                    <th>Range</th>
                    <th>Update</th>
                </tr>
            </thead>
            <tbody id="enteredLabTestMethodsBodyResults">

            </tbody>
        </table>
        <div id="footerlabtestsbtns" style="display: none;">
            <div class="modal-footer">
                <button type="button" id="submittpatientlabtestbackbtn" class="btn btn-primary" onclick="submittpatientlabtestback(this.id);">Submit Results</button>
                <button type="button" class="btn btn-secondary btn-md" onclick="printsubmittpatientlabtestback();"><i class="fa fa-print"></i> Print</button>
            </div>   
        </div>
    </div>
</div>
<script>
    var patienttestresultList = [];
    var patienttestresults = new Set();

    var laboratoryrequest = $('#laboratoryrequest_formid').val();
    ajaxSubmitData('laboratory/laboratorypatientrequestedtests.htm', 'laboratoryrequestedtestsdiv', 'laboratoryrequest=' + laboratoryrequest + '&patienttestresults=' + JSON.stringify(Array.from(patienttestresults)) + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    function enterpatientlabtestresults(laboratoryrequesttestid, testname) {
        $.confirm({
            title: 'Patient Laboratory Test Results',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Laboratory Test</label>' +
                    '<input type="text" disabled="true" value="' + testname + '" class="name form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Laboratory Test Result</label>' +
                    '<input type="text"  class="laboratorytestresults form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Notes</label>' +
                    '<textarea class="form-control rounded-0" id="laboratorytestresultsdesc" rows="2"></textarea>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            closeIcon:true,
            buttons: {
                tryAgain: {
                    text: 'Save',
                    btnClass: 'btn-purple',
                    action: function () {
                        var result = this.$content.find('.laboratorytestresults').val();
                        var notes = this.$content.find('.laboratorytestresultsdesc').val();
                        if (!result) {
                            $.alert('provide a valid Test Result');
                            return false;
                        }
                        patienttestresultList.push({
                            testresult: result,
                            notes: notes,
                            laboratoryrequesttestid: laboratoryrequesttestid
                        });
                        patienttestresults.add(laboratoryrequesttestid);

                        $('#enteredLabTestMethodsBodyResults').append('<tr id="LabTestsBodyResults' + laboratoryrequesttestid + '"><td>' + testname + '</td>' +
                                '<td>' + result + '</td>' +
                                '<td></td>' +
                                '<td align="center"><span  title="Delete Of This Test Tesult." onclick="deleteLabTestResult(' + laboratoryrequesttestid + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');


                        var laboratoryrequest3 = $('#laboratoryrequest_formid').val();
                        ajaxSubmitData('laboratory/laboratorypatientrequestedtests.htm', 'laboratoryrequestedtestsdiv', 'laboratoryrequest=' + laboratoryrequest3 + '&patienttestresults=' + JSON.stringify(Array.from(patienttestresults)) + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                        if (patienttestresults.size > 0) {
                            document.getElementById('footerlabtestsbtns').style.display = 'block';
                        } else {
                            document.getElementById('footerlabtestsbtns').style.display = 'none';
                        }
                    }
                },
                close: function () {

                }
            }
        });


    }
    function deleteLabTestResult(laboratoryrequesttestid) {
        for (i in patienttestresultList) {
            if (parseInt(patienttestresultList[i].laboratoryrequesttestid) === parseInt(laboratoryrequesttestid)) {
                patienttestresultList.splice(i, 1);
                patienttestresults.delete(parseInt(laboratoryrequesttestid));
                $('#LabTestsBodyResults' + laboratoryrequesttestid).remove();
                var laboratoryrequest2 = $('#laboratoryrequest_formid').val();
                ajaxSubmitData('laboratory/laboratorypatientrequestedtests.htm', 'laboratoryrequestedtestsdiv', 'laboratoryrequest=' + laboratoryrequest2 + '&patienttestresults=' + JSON.stringify(Array.from(patienttestresults)) + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                break;
            }
        }
        if (patienttestresults.size > 0) {
            document.getElementById('footerlabtestsbtns').style.display = 'block';
        } else {
            document.getElementById('footerlabtestsbtns').style.display = 'none';
        }
    }
    function submittpatientlabtestback(id) {
        var laboratoryrequestid = $('#laboratoryrequest_formid').val();
        document.getElementById(id).disabled = true;
        $.ajax({
            type: 'POST',
            url: "laboratory/patientlaboratoryrequesttestsnumber.htm",
            data: {laboratoryrequestid: laboratoryrequestid},
            success: function (data, textStatus, jqXHR) {
                if (parseInt(data) === patienttestresults.size) {
                    $.confirm({
                        title: 'Patient Laboratory',
                        content: 'Are You Sure You Want To Submit Lab Tests Result?',
                        type: 'red',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Yes',
                                btnClass: 'btn-red',
                                action: function () {
                                    submitlabResults(laboratoryrequestid);
                                }
                            },
                            close: function () {
                                document.getElementById(id).disabled = false;
                            }
                        }
                    });
                } else {
                    if (patienttestresults.size < parseInt(data)) {
                        var testcount = parseInt(data) - patienttestresults.size;
                        $.confirm({
                            title: 'Patient Laboratory',
                            content: testcount + ' ' + 'Laboratory Test(s) Result Missing! Are You Sure You Want To Submit?',
                            type: 'red',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Yes',
                                    btnClass: 'btn-red',
                                    action: function () {
                                        submitlabResults(laboratoryrequestid);
                                    }
                                },
                                close: function () {
                                    document.getElementById(id).disabled = false;
                                }
                            }
                        });
                    }
                }
            }
        });
    }
    function printsubmittpatientlabtestback() {
        var patientidlab2 = $('#facilityvisitedPatientLabid').val();
        var patientvisitlabid2 = $('#facilityvisitPatientLabvisitid').val();
        var patientvisitall = $('#allowdtoPrintPatientLabTests').val();
        var laboratoryrequestid = $('#laboratoryrequest_formid').val();
        if (parseInt(patientvisitall) === 1) {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Print Patient Laboratory Tests Result',
                content: '<div id="printlabTestsBox" class="center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>',
                type: 'purple',
                typeAnimated: true,
                boxWidth: '70%',
                useBootstrap: false,
                buttons: {
                    close: {
                        text: 'Close',
                        action: function () {

                        }
                    }
                },
                onContentReady: function () {
                    var printBox = this.$content.find('#printlabTestsBox');
                    $.ajax({
                        type: 'GET',
                        data: {patientVisitsid: patientvisitlabid2, patientid: patientidlab2, laboratoryrequestid: laboratoryrequestid},
                        url: 'laboratory/printPatientLaboratoryTestResults.htm',
                        success: function (res) {
                            if (res !== '') {
                                var objbuilder = '';
                                objbuilder += ('<object width="100%" height="500px" data="data:application/pdf;base64,');
                                objbuilder += (res);
                                objbuilder += ('" type="application/pdf" class="internal">');
                                objbuilder += ('<embed src="data:application/pdf;base64,');
                                objbuilder += (res);
                                objbuilder += ('" type="application/pdf"/>');
                                objbuilder += ('</object>');
                                printBox.html(objbuilder);
                            } else {
                                printBox.html('<div class="bs-component">' +
                                        '<div class="alert alert-dismissible alert-warning">' +
                                        '<h4>Warning!</h4>' +
                                        '<p>Error generating PDF. Please <strong>Refresh</strong> & Try Again.</p></div></div>'
                                        );
                            }
                        }
                    });
                }
            });
        } else {
            $.confirm({
                title: 'Encountered an error',
                content: 'You Must First Sumbit Results Before Printing',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Ok',
                        btnClass: 'btn-red',
                        action: function () {

                        }
                    },
                    close: function () {
                    }
                }
            });
        }
    }
    function submitlabResults(laboratoryrequestid) {
        $.ajax({
            type: 'POST',
            data: {tests: JSON.stringify(patienttestresultList),laboratoryrequestid:laboratoryrequestid},
            url: "laboratory/submitlabResults.htm",
            success: function (data) {
                document.getElementById('allowdtoPrintPatientLabTests').value = 1;
                document.getElementById('submittpatientlabtestbackbtn').style.display = 'none';
                $.confirm({
                    title: 'Patient Laboratory Tests Result',
                    content: 'Results Submitted Successfully',
                    type: 'green',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Ok',
                            btnClass: 'btn-green',
                            action: function () {

                            }
                        },
                        close: function () {

                        }
                    }
                });
            }
        });
    }
</script>