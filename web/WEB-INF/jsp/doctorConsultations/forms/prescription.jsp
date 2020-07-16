<%-- 
    Document   : prescription
    Created on : Aug 19, 2018, 10:17:42 AM
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
<%@include file="../../include.jsp" %>
<fieldset>
    <div class="row">
        <div class="col-md-12">
            <button type="button"   onclick="viewprevouspatientsprescriptions();" class="btn btn-success pull-right">Previous Prescription(s) <span class="badge badge-info">${prevousPrescriptions}</span></button>    
        </div>
    </div><br>
    <div class="" id="patient_pastprescriptions">
        <!--<legend>Add Drugs</legend>-->
        <legend>Add Medicine</legend>
        <div class="row">
            <div class="col-md-4">
                <div class="tile">
                    <div class="tile-body">
                        <div id="PatientPrescriptions_form">

                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-md-12 right">
                                <button type="button" id="addingPrescriptionsbtns" class="btn btn-primary" onclick="addpatientPrescriptions();">
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
                            <!--<h4 class="tile-title">Selected Drugs.</h4>-->
                            <h4 class="tile-title">Selected Medicine</h4>
                            <table class="table">
                                <thead>
                                    <tr>
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
                                <tbody id="inputprescriptionsenteredItemsBody">
                                </tbody>
                            </table>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-12 right" id="displaynonesendPrescriptionsbtn" style="display: none;">
                                    <hr style="border:1px dashed #dddddd;">
                                    <button type="button"  onclick="submitPatientprescriptions();" class="btn btn-primary">Send</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<div id="popup" style="display: none;">
    <%@include file="../views/alertprescription.jsp"%>
</div>
<script>
    var facilityId = ${facilityid};
    ajaxSubmitDataNoLoader('doctorconsultation/prescriptionform.htm', 'PatientPrescriptions_form', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    var patientprescriptions = [];
    var prescribedItems = new Set();
    function addpatientPrescriptions() {
        var itemid = $('#doctorPrescribeDrug').val();
        var dosage = $('.select-drugtoprescribedosage').val();
        var days = $('.select-drugtoprescribedays').val();
        var daysname = $('#defaultselectedtypeString').val();
//        var itemname = $('#DrugPres' + itemid).data('itemname');
        var itemname = $('#DrugPres' + itemid.replace(/[^0-9a-z]/gi, '')).data('itemname');
        var comment = $('.prescribedpatientitemmoreinfo').val();
        var dose = $('.select-drugdosetoprescribe').val();
        //
        if(isAlphaNumeric($('.select-drugdosetoprescribe')) === false){
            return false;
        }
        //
        if (dosage === 'select') {
            document.getElementById('drugtoprescribedosageid').focus();
        } else {
            $('.select-drugtoprescribedosage').removeClass('focus');
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

        if (dosage !== 'select' && days !== '' && itemid !== 'select') {
//            prescribedItems.add(parseInt(itemid));
            prescribedItems.add(itemid);
            patientprescriptions.push({
                itemid: itemname,
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

            $('#inputprescriptionsenteredItemsBody').append('<tr id="prescribedPatientRow' + itemid.replace(/[^0-9a-z]/gi, '') + '"><td>' + itemname + '</td>' +
                    '<td>' + doseadd + '</td>' +
                    '<td>' + dosage + '</td>' +
                    '<td>' + days + ' ' + daysname + '</td>' +
                    '<td>' + commentng + '</td>' +
                    '<td align="center"><span  title="Delete Of This Item." onclick="removePatientPrescriptions(\'' + itemid + '\');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');

            if (prescribedItems.size > 0) {
                document.getElementById('displaynonesendPrescriptionsbtn').style.display = 'block';
            } else {
                document.getElementById('displaynonesendPrescriptionsbtn').style.display = 'none';
            }
            ajaxSubmitDataNoLoader('doctorconsultation/prescriptionform.htm', 'PatientPrescriptions_form', 'prescribedItems=' + JSON.stringify(Array.from(prescribedItems)) + '&act=b&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    }

    function submitPatientprescriptions() {
        var patientVisitsid = $('#facilityvisitPatientvisitid').val();
         var patientid = $('#facilityvisitedPatientid').val();
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
                                        data: {dispensingUnitid: dispensingUnit, prescriptions: JSON.stringify(patientprescriptions), patientVisitsid: patientVisitsid, facilityunitserviceid: facilityUnitServiceId},
                                        url: "doctorconsultation/savepatientsprescriptions.htm",
                                        success: function (datas) {                                            
                                            document.getElementById('pauseOrUnPauseApatientid').style.display='none';
                                            var results = JSON.parse(datas);
                                            queuePatientToDispensingService(patientVisitsid, results[0].facilityunitservicesid, results[0].staffid, results[0].facilityunitid);

                                            document.getElementById('addingPrescriptionsbtns').disabled = true;
                                            document.getElementById('displaynonesendPrescriptionsbtn').style.display = 'none';

                                           ajaxSubmitData('doctorconsultation/prescriptionhome.htm', 'prescriptionsDiv', 'patientid='+patientid+'&i=0&patientvisitid='+patientVisitsid+'&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
    function removePatientPrescriptions(itemid) {
        for (i in patientprescriptions) {
//            if (parseInt(patientprescriptions[i].itemid) === parseInt(itemid)) {
            if (patientprescriptions[i].itemid.replace(/[^0-9a-z]/gi, '').toUpperCase() 
                    === itemid.replace(/[^0-9a-z]/gi, '').toUpperCase()) {
                patientprescriptions.splice(i, 1);
                prescribedItems.delete(itemid);
                $('#prescribedPatientRow' + itemid.replace(/[^0-9a-z]/gi, '')).remove();
                break;
            }
        }
        ajaxSubmitDataNoLoader('doctorconsultation/prescriptionform.htm', 'PatientPrescriptions_form', 'prescribedItems=' + JSON.stringify(Array.from(prescribedItems)) + '&act=b&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function viewprevouspatientsprescriptions() {
        var patientVisitsid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();
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
    function queuePatientToDispensingService(patientVisitationId, serviceid, queueStaffid, facilityunitid) {
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
                stompClient.send('/app/patientqueuesize/' + facilityunitid + '/' + facilityId + '/' + serviceid, {}, JSON.stringify({ unitserviceid: serviceid }));
            },
            error: function (jqXHR, textStatus, errorThrown) {                                                        
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);

            }
        }); 
    }
    //
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
                if(data.toString().toLowerCase() === 'noitem'){
                    result = false;
                }else if(data.daysLeft<3 && data.daysLeft >0){
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
                                $('#addingPrescriptionsbtns').prop('disabled', true);
                                result =true;
                            }
                        }
                    }
                    });
                }
                else {
                    $.confirm({
                         icon: '',
                    title: 'ITEM ALREADY PRESCRIBED',
                   content: $('#popup').html(),
                    type: 'red',
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