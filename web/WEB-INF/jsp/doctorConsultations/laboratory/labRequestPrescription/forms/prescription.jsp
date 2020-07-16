<%-- 
    Document   : prescription
    Created on : Oct 26, 2018, 12:48:49 PM
    Author     : IICS
--%>

<style>
    .select2-container{
        z-index: 9999999 !important;
    }
    .focus {
        border-color:red !important;
    }
</style>
<%@include file="../../../../include.jsp" %>
<fieldset>
    <div class="" id="labReqpatientprescription">
        <!---->
        <!--        <legend>Add Drugs</legend>-->
        <legend>Add Medicine</legend>
        <div class="row">
            <div class="col-md-4">
                <div class="tile" id="searchTile">
                    <div class="tile-body">
                        <div id="labPatlabPrescriptions_form">
                            <%--<%@include file="prescriptionform.jsp" %>--%>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-md-12 right">
                                <button type="button" id="addlabPrescriptionsbtn" class="btn btn-primary" onclick="addlabRequestpatientPrescriptions();">
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
                            <!--                            <h4 class="tile-title">Selected Drugs.</h4>-->
                            <h4 class="tile-title">Selected Medicine.</h4>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <!---->
                                        <!--<th>Drug Name</th>-->
                                        <th>Medicine</th>
                                        <th>Dose</th>
                                        <th>Dosage</th>
                                        <th>Duration</th>
                                        <!--<th>Comment</th>-->
                                        <th>Special Instructions</th>
                                        <th>Update</th>
                                    </tr>
                                </thead>
                                <tbody id="labPatientPrescriptionEnteredItemBody">

                                </tbody>
                            </table>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-12 right" id="displaysendlabPrescriptionsbtnn" style="display: none;">
                                    <hr style="border:1px dashed #dddddd;">
                                    <button type="button"  onclick="submitLabRequestPatientprescription();" class="btn btn-primary">Send</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<div id="notify" style="display: none">
    <%@include file="../../../views/alertprescription.jsp" %>
</div>
<script>
    var facilityId = ${facilityid};
    ajaxSubmitDataNoLoader('doctorconsultation/laboratoryprescriptionform.htm', 'labPatlabPrescriptions_form', 'act=a&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    var labprescribedItems = [];
    var labprescribedItemset = new Set();

    function addlabRequestpatientPrescriptions() {
        var itemid = $('#doctorlabReqPrescribeDrug').val();
        var dosage = $('.select-labReqdrugtoprescribedosage').val();
        var days = $('.select-labPatientdrugtoprescribedays').val();
        var daysname = $('#LabPatientselectedtypeString').val();
//        var itemname = $('#DruglabReqPres' + itemid).data('itemname');
        var itemname = $('#DruglabReqPres' + itemid.replace(/[^0-9a-z]/gi, '')).data('itemname');
        var comment = $('.Labprescribeditemmoreinfo').val();
        var dose = $('.select-labReqdrugdosetoprescribe').val();
        //
        if (isAlphaNumeric($('.select-labReqdrugdosetoprescribe')) === false) {
            return false;
        }
        //
        if (itemid !== 'select' && dosage !== 'select' && days !== '') {
//            labprescribedItemset.add(parseInt(itemid));
            labprescribedItemset.add(itemid);
            labprescribedItems.push({
                itemid: itemid,
                dosage: dosage,
                days: days,
                daysname: daysname,
                comment: comment,
                dose: dose
            });

            var commentng = '';
            if (comment === '') {
                commentng = '-------------';
            } else {
                commentng = comment;
            }

            var doseadd = '';
            if (dose === '') {
                doseadd = '--------';
            } else {
                doseadd = dose;
            }
            $('#labPatientPrescriptionEnteredItemBody').append('<tr id="labprescribedPatientRow' + itemid.replace(/[^0-9a-z]/gi, '') + '"><td>' + itemname + '</td>' +
                    '<td>' + doseadd + '</td>' +
                    '<td>' + dosage + '</td>' +
                    '<td>' + days + ' ' + daysname + '</td>' +
                    '<td>' + commentng + '</td>' +
                    '<td align="center"><span  title="Delete Of This Item." onclick="remPatientPrescriptions(\'' + itemid.replace(/[^0-9a-z]/gi, '') + '\');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');

            if (labprescribedItemset.size > 0) {
                document.getElementById('displaysendlabPrescriptionsbtnn').style.display = 'block';
            } else {
                document.getElementById('displaysendlabPrescriptionsbtnn').style.display = 'none';
            }
            ajaxSubmitDataNoLoader('doctorconsultation/laboratoryprescriptionform.htm', 'labPatlabPrescriptions_form', 'act=b&prescribedItems=' + JSON.stringify(Array.from(labprescribedItemset)) + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

        }

    }
    function remPatientPrescriptions(itemid) {
        for (i in labprescribedItems) {
//            if (parseInt(labprescribedItems[i].itemid) === parseInt(itemid)) {
            if (labprescribedItems[i].itemid.replace(/[^0-9a-z]/gi, '').toUpperCase() === itemid.replace(/[^0-9a-z]/gi, '').toUpperCase()) {
                labprescribedItems.splice(i, 1);
                labprescribedItemset.delete(itemid);
                $('#labprescribedPatientRow' + itemid.replace(/[^0-9a-z]/gi, '')).remove();
                break;
            }
        }
        ajaxSubmitDataNoLoader('doctorconsultation/laboratoryprescriptionform.htm', 'labPatlabPrescriptions_form', 'act=b&prescribedItems=' + JSON.stringify(Array.from(labprescribedItemset)) + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function submitLabRequestPatientprescription() {
        var patientVisitsid = $('#facilitylabvisitPatientvisitid').val();
        var patientid = $('#facilitylabvisitedPatientid').val();
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
                                        data: {dispensingUnitid: dispensingUnit, prescriptions: JSON.stringify(labprescribedItems), patientVisitsid: patientVisitsid, facilityunitserviceid: facilityUnitServiceId},
                                        url: "doctorconsultation/savepatientsprescriptions.htm",
                                        success: function (datas) {

                                            var results = JSON.parse(datas);
                                            queueLabPatientToDispensingService(patientVisitsid, results[0].facilityunitservicesid, results[0].staffid, results[0].facilityunitid);

                                            document.getElementById('addlabPrescriptionsbtn').disabled = true;
                                            document.getElementById('displaysendlabPrescriptionsbtnn').style.display = 'none';

                                            ajaxSubmitData('doctorconsultation/labpatientprescriptionhome.htm', 'labReqpatientprescription', 'patientid=' + patientid + '&i=0&patientvisitid=' + patientVisitsid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

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
    function queueLabPatientToDispensingService(patientVisitationId, serviceid, queueStaffid, facilityunitid) {
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
            data: {visitid: parseInt(patientVisitationId), serviceid: serviceid, staffid: queueStaffid},
            success: function (result, textStatus, jqXHR) {
                stompClient.send('/app/patientqueuesize/' + facilityunitid + '/' + facilityId + '/' + serviceid, {}, JSON.stringify({unitserviceid: serviceid}));                
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);

            }
        });
    }
    function isAlphaNumeric(control) {
        var parent = control.parent();
        var value = control.val();
//        var pattern = /[0-9]+\s*[a-zA-Z]+$/gi;
//        var pattern = /[0-9]+\s*[a-zA-Z]+\s*[+\/a-zA-Z\s]*$/gi;
        var pattern = /[0-9]+\s*[a-zA-Z%]+\s*[+\/a-zA-Z\s%]*$/gi;
        var result = ((value.match(pattern)) ? true : false);
        if (result) {
            var status = parent.find('#status');
            status.removeClass('fa-times-circle');
            status.addClass('fa-check-circle');
            status.css('color', '#00FF00');
            status.html('');
        } else {
            var status = parent.find('#status');
            status.removeClass('fa-check-circle');
            status.addClass('fa-times-circle');
            status.css('color', '#FF0000');
            status.html(" Please enter a valid value eg 250 mg.");
        }
        return result;
    }
    //

    function checkItemAlreadyPrescribed(itemName, patientId) {
       
        var result = false;
        $.ajax({
            type: 'GET',
            url: 'doctorconsultation/checkitemalreadyprescribed.htm',
            data: {itemname: itemName, patientid: patientId},
            async: false,
            success: function (response, textStatus, jqXHR) {

                var data = JSON.parse(response);
                if (data.toString().toLowerCase() === 'noitem') {
                    result = false;
                } else if (data.daysLeft < 3 && data.daysLeft > 0) {
                    $.confirm({
                        icon: '',
                        title: 'ITEM ALREADY PRESCRIBED',
                        content: data.message,
                        type: 'red',
                        typeAnimated: true,
                        boxWidth: '30%',
                        useBootstrap: false,
                        buttons: {
                            continue: {
                                text: 'Continue',
                                btnClass: 'btn-primary',
                                action: function () {
                                    result = false;
                                }
                            },
                            cancel: {
                                text: 'Cancel',
                                btnClass: 'btn-danger',
                                action: function () {
                                    $('#addlabPrescriptionsbtn').prop('disabled', true);
                                    result = true;
                                }
                            }
                        }
                    });
                } else {
                    $.confirm({
                        icon: '',
                        title: 'ITEM ALREADY PRESCRIBED',
                        content: $('#notify').html(),
                        type: 'blue',
                        typeAnimated: true,
                        boxWidth: '30%',
                        useBootstrap: false,
                        onContentReady: function () {
                            this.$content.find('#visit-number').val(data.visitnumber);
                            this.$content.find('#reference-number').val(data.referencenumber);
                            this.$content.find('#item-name').val(data.itemname);
                            this.$content.find('#dosage').val(data.dosage);
                            this.$content.find('#dose').val(data.dose);
                            this.$content.find('#duration').val(data.days);
                            this.$content.find('#days-name').val(data.daysname);
                            this.$content.find('#quantity-dispensed').val(data.quantitydispensed);
                            this.$content.find('#date-issued').val(data.dateissued);
                        },
                        buttons: {
                            cancel: {
                                text: 'Okay',
                                btnClass: 'btn-danger',
                                action: function () {
                                }
                            }
                        }
                    });
                    result = true;
                }
            }
        });
        return result;
    }
</script>
