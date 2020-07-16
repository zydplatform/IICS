<%-- 
    Document   : labRequest
    Created on : Aug 19, 2018, 10:04:42 AM
    Author     : IICS
--%>
<style>
    .select2-container{
        z-index: 9999999 !important;
    }
</style>
<%@include file="../../include.jsp" %>
<input id="savedPatientLabTestsRequestsId" type="hidden">
<fieldset>
    <div  id="patient_labrequests">
        <div class="row">
            <div class="col-md-12">
                <button type="button"   onclick="viewpreviousPatientLabTest(${prevoiusvisitsCount});" class="btn btn-success pull-right"><div id="previouslabtestsicon" style="display: none;"><i class="fa fa-spinner fa-spin" ></i></div> Previous Lab Tests <span class="badge badge-info">${prevoiusvisitsCount}</span></button>     
            </div> 
        </div>
        <div id="sentPatientLabTestsDiv">
            <div class="row">
                <div class="col-md-6">
                    <div class="tile">
                        <div class="tile-body">
                            <div class="form-group row">
                                <label for="doctorlabtestsClassifications" class="col-sm-4 col-form-label">Select Specimen</label>
                                <div class="col-sm-8">
                                    <select class="form-control select-labtestsClassifications" id="doctorlabtestsClassifications" onchange="searchInputFields(this.value, this.id);">
                                        <c:forEach items="${labTestsClassificationsFound}" var="a">
                                            <option id="LabRqst${a.labtestclassificationid}" data-classificationname="${a.labtestclassificationname}" value="${a.labtestclassificationid}">${a.labtestclassificationname}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div id="getLabTestsDiv">

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="tile">
                        <h4 class="tile-title">Selected Tests.</h4>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Test Name</th>
                                    <th>Specimen</th>
                                    <th>Remove</th>
                                </tr>
                            </thead>
                            <tbody id="addedpatientLaboratoryTests">

                            </tbody>
                        </table>
                        <div id="sendPatientsLabTstReq" style="display: none;">
                            <hr style="border:1px dashed #dddddd;">
                            <div class="row">
                                <div class="col-md-12 right">
                                    <button type="button" class="btn btn-primary" onclick="sendPatientLabRequests();">
                                        Send Request.
                                    </button>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 
</fieldset>
<script>
    var facilityId = ${facilityid};
    var facilityunitid = ${facilityunitid};
    var selectect = $('#doctorlabtestsClassifications').val();
    var selectectname = $('#LabRqst' + selectect).data('classificationname');
    ajaxSubmitDataNoLoader('doctorconsultation/laboratoryhome.htm', 'getLabTestsDiv', 'labtestclassificationid=' + selectect + '&name=' + selectectname + '&tests=' + JSON.stringify(Array.from(patientLabTests)) + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    function searchInputFields(searchValue, id) {
        var selectectname2 = $('#LabRqst' + searchValue).data('classificationname');
        ajaxSubmitDataNoLoader('doctorconsultation/laboratoryhome.htm', 'getLabTestsDiv', 'labtestclassificationid=' + searchValue + '&tests=' + JSON.stringify(Array.from(patientLabTests)) + '&name=' + selectectname2 + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }

    function sendPatientLabRequests() {
        var patientVisitsid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();
        $.ajax({
            type: 'GET',
            data: {},
            url: "doctorconsultation/sendPatientLabRequests.htm",
            success: function (data) {
                $.confirm({
                    title: 'SELECT LABORATORY',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '30%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Queue Patient',
                            btnClass: 'btn-purple',
                            action: function () {
                                var labunit = $('#facilityLaboratoryunitid').val();
                                $.ajax({
                                    type: 'POST',
                                    data: {tests: JSON.stringify(Array.from(patientLabTests)), labunit: labunit, patientVisitsid: patientVisitsid},
                                    url: "doctorconsultation/savepatientlaboratorytestsandqueue.htm",
                                    success: function (response) {
                                        document.getElementById('pauseOrUnPauseApatientid').style.display='none';
                                        toggleCloseButton(patientVisitsid); //
                                        
                                        var results = JSON.parse(response);
                                        document.getElementById('savedPatientLabTestsRequestsId').value = results[0].laboratoryrequestid;

                                        ajaxSubmitDataNoLoader('doctorconsultation/sentlaboratorytests.htm', 'sentPatientLabTestsDiv', 'laboratoryrequestid=' + results[0].laboratoryrequestid + '&addedby=' + results[0].staffid + '&unit=' + results[0].laboratoryunit + '&requestnumber=' + results[0].requestnumber + '&maxR=100&sStr=', 'GET');
                                        queuePatientsToLaboratory(patientVisitsid, results[0].facilityunitservicesid, results[0].staffid);
                                    }
                                });
                            }
                        },
                        close: function () {

                        }
                    }
                });
            }
        });
    }
    function queuePatientsToLaboratory(patientVisitsid, facilityunitservicesid, staffid) {        
//        var queueData = {
//            type: 'ADD',
//            visitid: parseInt(patientVisitsid),
//            serviceid: facilityunitservicesid,
//            staffid: staffid
//        };
//        var host = location.host;
//        var url = 'ws://' + host + '/IICS/queuingServer';
//        var ws = new WebSocket(url);
//        ws.onopen = function (ev) {
//            ws.send(JSON.stringify(queueData));
//        };
//        ws.onmessage = function (ev) {
//            if (ev.data === 'ADDED') {
        //
//            }
//        };        
        $.ajax({
            type: 'GET',
            url: 'queuingSystem/pushPatient',
            data: { visitid: parseInt(patientVisitsid), serviceid: facilityunitservicesid, staffid: staffid },
            success: function (result, textStatus, jqXHR) {                
                stompClient.send('/app/patientqueuesize/' + facilityunitid + '/' + facilityId + '/' + facilityunitservicesid, {}, JSON.stringify({ unitserviceid: facilityunitservicesid }));
                fetchCount({ facilityunitid: facilityunitid, destination: 'consultation', unitserviceid: facilityunitservicesid, staffid: staffid, type: 'requests' }, '/app/patientlabs');
            },
            error: function (jqXHR, textStatus, errorThrown) {                                                        
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);

            }
        }); 
    }
    function viewpreviousPatientLabTest(prevoiusvisitsCount) {
        document.getElementById('previouslabtestsicon').style.display='block';
                
        var patientVisitsid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();
        if (prevoiusvisitsCount > 0) {
            $.ajax({
                type: 'GET',
                data: {patientVisitsid: patientVisitsid, patientid: patientid},
                url: "doctorconsultation/viewpreviousPatientLabTest.htm",
                success: function (data) {
                    document.getElementById('previouslabtestsicon').style.display='none';
                    $.confirm({
                        title: 'PREVIOUS LABORATORY TESTS',
                        content: '' + data,
                        type: 'purple',
                        boxWidth: '90%',
                        useBootstrap: false,
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'ok',
                                btnClass: 'btn-purple',
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
    }
</script>