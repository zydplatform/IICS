<%-- 
    Document   : prescription
    Created on : Oct 6, 2018, 8:44:44 PM
    Author     : HP
--%>
<style>
    .select2-container{
        z-index: 9999999 !important;
    }
    .focus {
        border-color:red !important;
    }
</style>
<%@include file="../../../include.jsp" %>
<fieldset>
    <div class="" id="labpatient_pastprescriptions">
        <div class="row">
            <div class="col-md-10"></div>
            <div class="col-md-2">
                <button type="button"   onclick="viewprevouslabpatientsprescriptions();" class="btn btn-primary btn-block pull-right">Previous Prescription(s) <span class="badge badge-info">${prevousPrescriptions}</span></button>
            </div>
        </div>
            <!---->
<!--        <legend>Add Drugs</legend>-->
        <legend>Add Medicine</legend>
        <div class="row">
            <div class="col-md-4">
                <div class="tile" id="searchTile">
                    <div class="tile-body">
                        <div id="PatientlabPrescriptions_form">
                            <%@include file="prescriptionform.jsp" %>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-md-12 right">
                                <button type="button" id="addinglabPrescriptionsbtns" class="btn btn-primary" onclick="addlabpatientPrescriptions();">
                                    Add Medicine
                                </button>
                            </div>
                        </div>  
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <!---->
                            <!--<h4 class="tile-title">Selected Drugs.</h4>-->
                            <h4 class="tile-title">Selected Medicine</h4>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <!---->
<!--                                        <th>Drug Name</th>-->
                                        <th>Medicine</th>
                                        <th>Dose</th>
                                        <th>Dosage</th>
                                        <th>Duration</th>
                                        <th>Comment</th>
                                        <th>Update</th>
                                    </tr>
                                </thead>
                                <tbody id="labprescriptionsenteredItemsBody">
                                    
                                </tbody>
                            </table>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-12 right" id="displaynonesendlabPrescriptionsbtn" style="display: none;">
                                    <hr style="border:1px dashed #dddddd;">
                                    <button type="button"  onclick="submitLabPatientprescriptions();" class="btn btn-primary">Send</button>
                                </div>
                            </div><br><br>
                            <div class="row">
                                <div class="col-md-12 right" id="displaynonesendlabPrescriptionsPrintbtn" style="display: none;">
                                    <button type="button" class="btn btn-secondary" id="sendlabPrescriptionsPrintbtn" onclick="printinglabPatientPrescription();">
                                        <i class="fa fa-print"></i>  Print
                                    </button>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="savedlabPatientPrescriptionsId" type="hidden">
</fieldset>
<script>
    var labpatientprescriptions = [];
    var labprescribedItems = new Set();
    function addlabpatientPrescriptions() {
        var itemid = $('#doctorlabPrescribeDrug').val();
        var dosage = $('.select-labdrugtoprescribedosage').val();
        var days = $('.select-labdrugtoprescribedays').val();
        var daysname = $('#druglabpresed' + days).data('days');
        var itemname = $('#DruglabPres' + itemid.replace(/[^0-9a-z]/gi, '')).data('itemname');
        var comment = $('.prescribeditemmoreinfo').val();
        var dose = $('.select-labdrugdosetoprescribe').val();
        //
        if(isAlphaNumeric($('.select-labdrugdosetoprescribe')) === false){
            return false;
        }
        //
        if (dosage === 'select') {
            document.getElementById('labdrugtoprescribedosageid').focus();
        } else 
        {
            $('.select-labdrugtoprescribedosage').removeClass('focus');
        }
//        if (days === 'select') {
//            $('.select-drugtoprescribedays').addClass('focus');
//        } else {
//            $('.select-drugtoprescribedays').removeClass('focus');
//        }
//        if (itemid === 'select') {
//            $('#doctorPrescribeDrug').addClass('focus');
//        } else {
//            $('#doctorPrescribeDrug').removeClass('focus');
//        }

        if (dosage !== 'select' && days !== 'select' && itemid !== 'select') {
//            labprescribedItems.add(parseInt(itemid));
            labprescribedItems.add(itemid);
            labpatientprescriptions.push({
                itemid: itemid,
                dosage: dosage,
                days: days,
                daysname: daysname,
                comment: comment,
                dose: dose
            });
            var commentings = '';
            if (comment === '') {
                commentings = '------------';
            } else {
                commentings = comment;
            }
            $('#labprescriptionsenteredItemsBody').append('<tr id="labprescribedPatientRow' + itemid.replace(/[^0-9a-z]/gi, '') + '"><td>' + itemname + '</td>' +
                    '<td>' + dose + '</td>' +
                    '<td>' + dosage + '</td>' +
                    '<td>' + daysname + '</td>' +
                    '<td>' + commentings + '</td>' +
                    '<td align="center"><span  title="Delete Of This Item." onclick="removeLabPatientPrescriptions(\'' + itemid.replace(/[^0-9a-z]/gi, '') + '\');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');

            if (labprescribedItems.size > 0) {
                document.getElementById('displaynonesendlabPrescriptionsbtn').style.display = 'block';
                document.getElementById('displaynonesendlabPrescriptionsPrintbtn').style.display = 'block';
            } else {
                document.getElementById('displaynonesendlabPrescriptionsbtn').style.display = 'none';
                document.getElementById('displaynonesendlabPrescriptionsPrintbtn').style.display = 'none';
            }
            ajaxSubmitDataNoLoader('doctorconsultation/labprescriptionform.htm', 'PatientlabPrescriptions_form', 'prescribedItems=' + JSON.stringify(Array.from(labprescribedItems)) + '&act=b&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    }
    function removeLabPatientPrescriptions(itemid) {
        for (i in labpatientprescriptions) {
//            if (parseInt(labpatientprescriptions[i].itemid) === parseInt(itemid)) {
            if (labpatientprescriptions[i].itemid.replace(/[^0-9a-z]/gi, '').toUpperCase() 
                    === itemid.replace(/[^0-9a-z]/gi, '').toUpperCase()) {
                labpatientprescriptions.splice(i, 1);
                labprescribedItems.delete(itemid);
                $('#labprescribedPatientRow' + itemid.replace(/[^0-9a-z]/gi, '')).remove();
                break;
            }
        }
        if (labprescribedItems.size < 1) {
            document.getElementById('displaynonesendlabPrescriptionsbtn').style.display = 'none';
            document.getElementById('displaynonesendlabPrescriptionsPrintbtn').style.display = 'none';
        }
        ajaxSubmitDataNoLoader('doctorconsultation/labprescriptionform.htm', 'PatientlabPrescriptions_form', 'prescribedItems=' + JSON.stringify(Array.from(labprescribedItems)) + '&act=b&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function submitLabPatientprescriptions() {
        var patientVisitsid = $('#facilityLabvisitPatientvisitid').val();
        $.ajax({
            type: 'GET',
            data: {},
            url: "doctorconsultation/getdispensingunits.htm",
            success: function (data) {
                $.confirm({
                    title: 'SELECT DISPENSING UNIT',
                    content: '' + data,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Submit',
                            btnClass: 'btn-purple',
                            action: function () {
                                var dispensingUnit = $('#facilitydispensingunitid').val();
                                var facilityUnitServiceId = $('#facilitydispensingunitid').children("option:selected").data('facility-unit-service-id');
                                if (dispensingUnit !== 'select') {
                                    $.ajax({
                                        type: 'POST',
                                        data: {dispensingUnitid: dispensingUnit, prescriptions: JSON.stringify(labpatientprescriptions), patientVisitsid: patientVisitsid, facilityunitserviceid: facilityUnitServiceId},
                                        url: "doctorconsultation/savepatientsprescriptions.htm",
                                        success: function (datas) {
                                            var results = JSON.parse(datas);
                                            document.getElementById('savedlabPatientPrescriptionsId').value = results[0].prescriptionid;
                                            document.getElementById('sendlabPrescriptionsPrintbtn').disabled = false;
                                            queuePatientToDispensingService2(patientVisitsid, results[0].facilityunitservicesid, results[0].staffid, results[0].facilityunitid);

                                            document.getElementById('addinglabPrescriptionsbtns').disabled = true;
                                            document.getElementById('displaynonesendlabPrescriptionsbtn').style.display = 'none';
                                        }
                                    });
                                }
                            }
                        },
                        close: function () {

                        }
                    }
                });
            }
        });
    }
    function queuePatientToDispensingService2(patientVisitationId, serviceid, queueStaffid, facilityunitid) {
//        var queueData = {
//            type: 'ADD',
//            visitid: parseInt(patientVisitationId),
//            serviceid: serviceid,
//            staffid: queueStaffid
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
            data: { visitid: parseInt(patientVisitationId), serviceid: serviceid, staffid: queueStaffid },
            success: function (result, textStatus, jqXHR) {                
                stompClient.send('/app/patientqueuesize/' + facilityunitid + facilityId + '/' + serviceid, {}, JSON.stringify({ unitserviceid: serviceid }));                
            },
            error: function (jqXHR, textStatus, errorThrown) {                                                        
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);

            }
        }); 
    }
    function printinglabPatientPrescription() {
        var patientVisitsid = $('#facilityLabvisitPatientvisitid').val();
        var patientid = $('#facilityLabvisitedPatientid').val();
        var prescriptionid = $('#savedlabPatientPrescriptionsId').val();
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Print Patient Prescriptions',
            content: '<div id="printlabpatientPrescriptionsBox" class="center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>',
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
                var printBox = this.$content.find('#printlabpatientPrescriptionsBox');
                $.ajax({
                    type: 'GET',
                    data: {patientVisitsid: patientVisitsid, patientid: patientid, prescriptionid: prescriptionid},
                    url: 'doctorconsultation/printPatientPrescription.htm',
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
    }
    function viewprevouslabpatientsprescriptions() {
        var patientVisitsid = $('#facilityLabvisitPatientvisitid').val();
        var patientid = $('#facilityLabvisitedPatientid').val();
        $.ajax({
            type: 'GET',
            data: {patientVisitsid: patientVisitsid, patientid: patientid},
            url: "doctorconsultation/viewprevouspatientsprescriptions.htm",
            success: function (data) {
                $.confirm({
                    title: 'PREVIOUS PRESCRIPTIONS',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '70%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        close: function () {

                        }
                    }
                });
            }
        });
    }
    function isAlphaNumeric(control){        
        var parent = control.parent();
        var value = control.val();
//        var pattern = /[0-9]+\s*[a-zA-Z]+$/gi;
//        var pattern = /[0-9]+\s*[a-zA-Z]+\s*[+\/a-zA-Z\s]*$/gi;
        var pattern = /[0-9]+\s*[a-zA-Z%]+\s*[+\/a-zA-Z\s%]*$/gi;
        var result = ((value.match(pattern)) ? true : false);
        if(result){
            var status = parent.find('#status');
            status.removeClass('fa-times-circle');
            status.addClass('fa-check-circle'); 
            status.css('color', '#00FF00');
            status.html('');
        }else {
            var status = parent.find('#status');
            status.removeClass('fa-check-circle');
            status.addClass('fa-times-circle');             
            status.css('color', '#FF0000');
            status.html(" Please enter a valid value eg 250 mg.");   
        }
        return result;
    }
</script>
