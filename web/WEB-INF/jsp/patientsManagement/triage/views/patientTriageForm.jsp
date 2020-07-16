<%-- 
    Document   : patientTriageForm
    Created on : Aug 30, 2018, 9:17:31 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../include.jsp" %>

<style>
    .skip-validation {
        font-size: 1.15em;
    }
    .skip-error {
        color: #ff0000;
    }
</style>  

<div id="patientBasicInfoTriage">
    
</div>
<div class="row">
    <div class="col-md-6 row">
        <div class="tile col-md-12">
            <div class="tile-body ">

                <div class="form-group row pull-right">
                    <button id="btnPreviousVitals" class="btn btn-primary btn-sm" type="button">Previous Vitals</button>
                </div>

                <div class="col-md-12 row" style="margin-top: -1%">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label" for="patientWeight" required>Weight(kg):
                                <a href="#" class="skip-validation text-info" data-field="weight" title="Click here to skip validation."
                                   data-toggle="modal" data-target="#skip-validation-modal"><i class="fa fa-info-circle"></i></a>
                            </label>
                            <input class="form-control" id="patientWeight" type="number" name="" min="0">
                            <span id="weight-skip-reason" class="skip-error"></span>
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="patientHeight">Height Length(cm):
                                <a href="#" class="skip-validation text-info" data-field="height" title="Click here to skip validation."
                                   data-toggle="modal" data-target="#skip-validation-modal"><i class="fa fa-info-circle"></i></a>
                            </label>
                            <input class="form-control" id="patientHeight" oninput="functioncheckpatientHeight()" type="number" name="patientHeight" min="20" max="300">
                            <medium class="form-text text-muted hidedisplaycontent" id="patientpatientHeighterrormsg"><font color="red">Height must be between 20 and 300.</font></medium>
                            <span id="heigth-skip-reason" class="skip-error"></span>
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="patientTemperature">Temperature(Celc):
                                <a href="#" class="skip-validation text-info" data-field="temperature" title="Click here to skip validation."
                                   data-toggle="modal" data-target="#skip-validation-modal"><i class="fa fa-info-circle"></i></a>
                            </label>
                            <input class="form-control" id="patientTemperature" oninput="functioncheckPatientTemperature()" type="number" name="patientTemperature" min="30" max="45">
                            <medium class="form-text text-muted hidedisplaycontent" id="patientTemperatureerrormsg"><font color="red">Temperature must be between 30 and 45.</font></medium>
                            <span id="temp-skip-reason" class="skip-error"></span>
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="patientBMI">BMI <strong>(kg/m<sup>2</sup>):</strong></label>
                            <input class="form-control" id="patientBMIReport" type="number" name="patientBMI" disabled="">
                            <medium class="form-text text-muted hidedisplaycontent" id="patientBMInoHeighteerrormsg"><font color="red">Enter Height to view BMI.</font></medium>
                            <medium class="form-text text-muted hidedisplaycontent" id="patientBMInoWeighteerrormsg"><font color="red">Enter Weight to view BMI.</font></medium>
                        </div>

                        <table>
                            <tbody>
                                <tr><label class="control-label" for="patientPressureSystolic">Blood Pressure(mmHg):
                                    <a href="#" class="skip-validation text-info" data-field="pressure" title="Click here to skip validation."
                                   data-toggle="modal" data-target="#skip-validation-modal"><i class="fa fa-info-circle"></i></a>
                                </label></tr>
                            <tr>
                                <td>
                                    <div class="form-group">
                                        <label class="col-form-label col-form-label-sm" for="patientPressureSystolic">Systolic:</label>
                                        <input class="form-control" id="patientPressureSystolic" min="0" type="number" name="patientPressureSystolic">
                                    </div>
                                </td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td>
                                    <div class="form-group">
                                        <label class="col-form-label col-form-label-sm" for="patientPressureDiastolic">Diastolic:</label>
                                        <input class="form-control" id="patientPressureDiastolic" min="0" type="number" name="patientPressureDiastolic">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <span id="pressure-skip-reason" class="skip-error"></span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <br />
                        <button class="btn btn-primary icon-btn pull-left" id="savePatientTriage" data-caller="">
                            <i class="fa fa-save"></i>Save
                        </button>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="form-group">
                                <label class="control-label" for="patientPulse">Pulse(B/min):</label>
                                <input class="form-control" id="patientPulse" oninput="functioncheckpatientPulse()" type="number" name="patientPulse" min="20" max="250">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientPulseerrormsg"><font color="red">Pulse must be between 20 and 250.</font></medium>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="patientHeadCircum">Head Circum(cm):</label>
                            <input class="form-control" id="patientHeadCircum" oninput="functioncheckpatientHeadCircum()" type="number" name="patientHeadCurcum" min="30" max="100">
                            <medium class="form-text text-muted hidedisplaycontent" id="patientHeadCircumerrormsg"><font color="red">Head Circum must be between 30 and 100.</font></medium>
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="patientBodySurfaceArea">Body Surface Area(cm):</label>
                            <input class="form-control" id="patientBodySurfaceArea" type="number" name="patientBodySurfaceArea" min="0">
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="patientRespirationRate">Respiration Rate(B/min):
                                <a href="#" class="skip-validation text-info" data-field="respirationRate" 
                                   title="Click here to skip validation." data-toggle="modal" data-target="#skip-validation-modal"><i class="fa fa-info-circle"></i></a>
                            </label>
                            <input class="form-control" id="patientRespirationRate" oninput="functioncheckpatientRespirationRate()" type="number" name="patientRespirationRate" min="10">
                            <span id="respiration-skip-reason" class="skip-error"></span>
                        </div>

                        <div class="form-group">
                            <label for="patientTriageNotes">Notes:</label>
                            <textarea class="form-control" id="patientTriageNotes" rows="4"></textarea>
                        </div>
                    </div>
                </div>
                <br />
            </div>
        </div>
    </div>
    <div class="col-md-6 ">
        <div class="tile">
            <div class="tile-body" id="issuesAndAllergies">
                
            </div>
        </div>
    </div>
</div>
<!--  -->
<div id="skip-validation-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">          
        <h3 class="modal-title">Skip Validation</h3>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <p>To skip field validation, please provide a reason.</p>
        <br />
        <label for="modal-field-placeholder" class="control-label">Field:</label>
        <br />
        <span class="form-control" id="modal-field-placeholder"></span>
        <br />
        <label for="modal-skip-validation-reason" class="control-label">Reason:</label>
        <select id="modal-skip-validation-reason" class="form-control" style="width: 100%;">
            <option>No Equipment.</option>
            <option>Equipment Not Functioning.</option>
        </select>
      </div>
      <div class="modal-footer">
            <button type="button" class="btn btn-default btn-primary" id="save-skip-validation">Save</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

<script>
    var patientweight= $('#patientWeight').val();
    $(function(){
        $('#modal-skip-validation-reason').select2({
             dropdownParent: $('#skip-validation-modal')
        });
    });
    $('#patientWeight').input(function(){
        if(patientweight>200){
            $.confirm({
                title: 'Valid Weight required',
                content:'Maximum Weight is 200(kgs) \n Minimum weight is 3(kgs) ',
                boxWidth:'35%',
                useBootstrap:false,
                type:'purple',
                typeAnimated:true,
                closeIcon:true,
                theme:'modern',
                buttons: {
                    OK: {
                        text: 'Ok',
                        btnClass: 'btn-purple',
                        keys: ['enter', 'shift'],
                        action: function () {

                        }
                    }
                }
            });
            
        }
    });
    $('#patientPressureSystolic').on('change', function(e){
        var estimatedAge = document.getElementById('estimated-age'); 
        if((!isNaN(estimatedAge.value.replace(/\D/g, ""))) && Number(estimatedAge.value.replace(/\D/g, '')) >= 16){
            if(e.target.value.toString().length > 0 && e.target.value.toString() !== ''){
                e.target.style.borderColor = "#C0C0C0";
            } else {
                e.target.style.borderColor = "#ff0000";
            }
        }
    });
    $('#patientPressureDiastolic').on('change', function(e){
        var estimatedAge = document.getElementById('estimated-age'); 
        if((!isNaN(estimatedAge.value.replace(/\D/g, ""))) && Number(estimatedAge.value.replace(/\D/g, '')) >= 16){
            if(e.target.value.toString().length > 0 && e.target.value.toString() !== ""){
                e.target.style.borderColor = "#C0C0C0";
            }else{
                e.target.style.borderColor = "#ff0000";
            }
        }
    });
    $('#patientRespirationRate').on('change', function(e){
        if(e.target.value.toString().length > 0 && e.target.value.toString() !== ""){
            e.target.style.borderColor = "#C0C0C0";
        }else{
            e.target.style.borderColor = "#ff0000";
        }
    });
    $('a.skip-validation').on('click', function(e){
        var field = $(this).data('field').toString().toUpperCase();
        switch(field){
            case 'weight'.toUpperCase():
                $('#modal-field-placeholder').html('Weight');
                break;
            case 'height'.toUpperCase():
                $('#modal-field-placeholder').html('Height');
                break;
            case 'temperature'.toUpperCase():
                $('#modal-field-placeholder').html('Temperature');
                break;
            case 'respirationRate'.toUpperCase():
                $('#modal-field-placeholder').html('Respiration Rate');
                break;
            case 'pressure'.toUpperCase():
                $('#modal-field-placeholder').html('Blood Pressure');
                break;
            default:
                break;
        }
    });
    $('#save-skip-validation').on('click', function(e){
        var data = {
            field: $('#modal-field-placeholder').html(),
            reason: $('#modal-skip-validation-reason').val(),
            patientvisitid: patientVisitationId
        };
        console.log(data);
        $.ajax({
            type: 'POST',
            data: data,
            url: 'triage/savetriagevalidationskip.htm',
            success: function (result, textStatus, jqXHR) {
                console.log(result);
                if(result.toString().toUpperCase() === 'success'.toUpperCase()){
                    switch(data.field.toString().toUpperCase()){
                        case 'weight'.toUpperCase():
                            skipWeight = true;
                            $('span#weight-skip-reason').html(data.reason);
                            $('#patientWeight').attr('readonly', true);
                            break;
                        case 'height'.toUpperCase():                            
                            skipHeight = true;
                            $('#heigth-skip-reason').html(data.reason);
                            $('#patientHeight').attr('readonly', true);
                            break;
                        case 'temperature'.toUpperCase():
                            skipTemp = true;
                            $('#temp-skip-reason').html(data.reason);
                            $('#patientTemperature').attr('readonly', true);
                            break;
                        case 'Respiration Rate'.toUpperCase():
                            skipRespirationRate = true;
                            $('#respiration-skip-reason').html(data.reason);
                            $('#patientRespirationRate').attr('readonly', true);
                            break;
                        case 'Blood Pressure'.toUpperCase():
                            skipPressure = true;
                            $('#pressure-skip-reason').html(data.reason);
                            $('#patientPressureDiastolic').attr('readonly', true);
                            $('#patientPressureSystolic').attr('readonly', true);
                            break;
                        default:
                            break;
                    }
                    $('#skip-validation-modal').modal('hide');
                    $.toast({
                        heading: 'Success',
                        text: "Operation Successful.",
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'mid-center'
                    });   
                }else {
                   $.toast({
                        heading: 'Error',
                        text: "Operation Unsuccessful, please try again.",
                        icon: 'error',
                        hideAfter: 2000,
                        position: 'mid-center'
                    });    
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    });
</script>