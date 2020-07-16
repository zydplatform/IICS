<%-- 
    Document   : patientDiagnosis
    Created on : Oct 15, 2018, 3:08:36 PM
    Author     : HP
--%>
<style>
    .stepwizard-step p {
        margin-top: 10px;
    }
    .stepwizard-row {
        display: table-row;
    }
    .stepwizard {
        display: table;
        width: 100%;
        position: relative;
    }
    .stepwizard-step button[disabled] {
        opacity: 1 !important;
        filter: alpha(opacity=100) !important;
    }
    .stepwizard-row:before {
        top: 14px;
        bottom: 0;
        position: absolute;
        content: " ";
        width: 100%;
        height: 1px;
        background-color: #ccc;
        z-order: 0;
    }
    .stepwizard-step {
        display: table-cell;
        text-align: center;
        position: relative;
    }
    .btn-circle {
        width: 199px;
        height: 30px;
        text-align: center;
        padding: 6px 0;
        font-size: 12px;
        line-height: 1.428571429;
        border-radius: 15px;
    }
    .autocomplete-suggestions { border: 1px solid #999; width: 667px !important; background: #fff; cursor: default; overflow: auto; z-index: 99999999 !important; }
    .autocomplete-suggestion { padding: 10px 5px; width: 100% !important; font-size: 1.2em; white-space: nowrap; overflow: hidden; z-index: 99999999 !important;}
    .autocomplete-selected { background: #f0f0f0; }
    .autocomplete-suggestions strong { font-weight: normal; color: #3399ff; }

    .panel {
        border: 1px solid #ddd;
        background-color: #fcfcfc;
    }
    .panel .btn-group {
        margin: 15px 0 30px;
    }
    .panel .btn-group .btn {
        transition: background-color .3s ease;
    }

    ul li:hover{
        cursor: pointer;
        background-color: #eee;
    }

</style>
<div class="container"></div>,<div class="container">

    <div class="stepwizard col-md-offset-3">
        <div class="stepwizard-row setup-panel">
            <div class="stepwizard-step">
                <a href="#step-1" type="button" class="btn btn-primary btn-circle">Diagnosis</a>
            </div>
            <div class="stepwizard-step">
                <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled="disabled">Details</a>

            </div>
            <div class="stepwizard-step">
                <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled="disabled">Treatment</a>
            </div>
        </div>
    </div>

    <form role="form" action="" method="post">
        <div class="row setup-content" id="step-1" style="margin-top: 20px;">
            <fieldset style="width: 100%;"> 
                <div class="row">
                    <div class="col-md-7">
                        <div class="tile">
                            <div class="tile-body" style="min-height:375px;">
                                <div id="content">
                                    <h5>What is Patient's main symptom?</h5>

                                    <div id="searchfield">
                                        <form><input type="text" placeholder="Enter Main Symptoms" name="currency"  class="form-control biginput" oninput="setvalue(this.value);" id="autocomplete"></form>
                                    </div><br>
                                    <div id="outputbox">
                                        <p id="outputcontent" style="display: none;"></p>
                                    </div>
                                    <hr>
                                    <div class=""><h5>Your Choices</h5></div>
                                    <div id="addeddiseasesSymptoms">
                                        <%@include file="../views/backgroundImage.jsp" %>  
                                    </div>
                                </div>  
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div id="patientConditionsdiv">
                            <div class="tile">
                                <div class="tile-title"><h5>Possible Conditions</h5></div>
                                <hr>
                                <div class="tile-body" style="overflow-y: scroll; height:331px;"><br>
                                    <div id="patientCondsdiv2">

                                    </div>
                                </div>
                            </div>  
                        </div>
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="row setup-content" id="step-2" style="margin-top: 20px;">
            <div class="row" style="width: 100%;">
                <div class="col-md-6">
                    <div class="tile">
                        <div class="tile-body" style="min-height:375px;">
                            <fieldset style="">
                                <legend>Symptoms.</legend>
                                <div id="patientConditionsDiv"></div> 
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="tile">
                        <div class="tile-body" style="min-height:375px;">
                            <fieldset style=""></fieldset> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row setup-content" id="step-3">
            <fieldset style="width: 100%;">

            </fieldset>
        </div>
    </form>
</div>

<script>
    var checkedpatientconditions = new Set();
    var checkedpatientconditionList=[];
    
    $(document).ready(function () {
        var navListItems = $('div.setup-panel div a'),
                allWells = $('.setup-content'),
                allNextBtn = $('.nextBtn'),
                allPrevBtn = $('.prevBtn');

        allWells.hide();

        navListItems.click(function (e) {
            e.preventDefault();
            var $target = $($(this).attr('href')),
                    $item = $(this);

            if (!$item.hasClass('disabled')) {
                navListItems.removeClass('btn-primary').addClass('btn-default');
                $item.addClass('btn-primary');
                allWells.hide();
                $target.show();
                $target.find('input:eq(0)').focus();
            }
        });

        allPrevBtn.click(function () {
            var curStep = $(this).closest(".setup-content"),
                    curStepBtn = curStep.attr("id"),
                    prevStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().prev().children("a");

            prevStepWizard.removeAttr('disabled').trigger('click');
        });

        allNextBtn.click(function () {
            var curStep = $(this).closest(".setup-content"),
                    curStepBtn = curStep.attr("id"),
                    nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
                    curInputs = curStep.find("input[type='text'],input[type='url']"),
                    isValid = true;
            if (isValid)
                nextStepWizard.removeAttr('disabled').trigger('click');
        });

        $('div.setup-panel div a.btn-primary').trigger('click');

        var cursss = [];
        $.ajax({
            type: 'POST',
            data: {},
            url: "doctorconsultation/diseasessymptoms.htm",
            success: function (data) {
                var response = JSON.parse(data);
                for (index in response) {
                    var results = response[index];
                    cursss.push({
                        value: results["value"],
                        data: results["data"]
                    });
                }
            }
        });

        $('#autocomplete').autocomplete({
            lookup: cursss,
            onSelect: function (suggestion) {
                addSymptoms(suggestion.data, suggestion.value);
            }
        });
    });
    var diseasesadded = [];
    var diseases = new Set();
    var addedSymptoms = [];
    var symptoms = new Set();

    function addSymptoms(symptomid, symptom) {
        $.ajax({
            type: 'POST',
            data: {symptomid: symptomid},
            url: "doctorconsultation/symptomsdiseases.htm",
            success: function (data) {
                var response = JSON.parse(data);
                for (index in response) {
                    var results = response[index];
                    if (diseases.has(parseInt(results["diseaseid"]))) {

                        var item = findOneBydisease(diseasesadded, parseInt(results["diseaseid"]));
                        var currentval = item.count;
                        item.count = parseInt(currentval) + 1;

                    } else {
                        diseases.add(parseInt(results["diseaseid"]));
                        diseasesadded.push({
                            diseaseid: parseInt(results["diseaseid"]),
                            diseasename: results["diseasename"],
                            count: 1
                        });
                    }
                }
                if (!symptoms.has(parseInt(symptomid))) {
                    addedSymptoms.push({
                        symptomid: symptomid,
                        symptom: symptom
                    });
                    symptoms.add(parseInt(symptomid));
                    $.ajax({
                        type: 'GET',
                        data: {symptoms: JSON.stringify(addedSymptoms)},
                        url: "doctorconsultation/symptoms.htm",
                        success: function (data) {
                            $('#addeddiseasesSymptomsdiv').html(data);
                            $('.biginput').val(searchvalue);
                            $('.biginput').focus();

                            $.ajax({
                                type: 'GET',
                                data: {diseases: JSON.stringify(diseasesadded)},
                                url: "doctorconsultation/patientconditions.htm",
                                success: function (response) {
                                    $('#patientConditionsdiv').html(response);
                                }
                            });
                        }
                    });
                } else {
                    $('.biginput').val(searchvalue);
                    $('.biginput').focus();
                }
            }
        });

    }
    function findOneBydisease(diseasesadded, diseaseid) {
        return diseasesadded.filter(function (item) {
            return item.diseaseid === diseaseid;
        })[0];
    }
    var searchvalue = '';
    function setvalue(value) {
        searchvalue = value;
    }
    function deleteSymptom(symptomid) {
        for (i in addedSymptoms) {
            if (addedSymptoms[i].symptomid === symptomid) {
                addedSymptoms.splice(i, 1);
                symptoms.delete(parseInt(symptomid));
                if (symptoms.size < 1) {
                    ajaxSubmitDataNoLoader('doctorconsultation/loadbackgroundimages.htm', 'addeddiseasesSymptoms', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
                $.ajax({
                    type: 'GET',
                    data: {symptoms: JSON.stringify(addedSymptoms)},
                    url: "doctorconsultation/symptoms.htm",
                    success: function (data) {
                        $('#addeddiseasesSymptomsdiv').html(data);

                        $.ajax({
                            type: 'POST',
                            data: {symptomid: symptomid},
                            url: "doctorconsultation/symptomsdiseases.htm",
                            success: function (respose) {
                                var responses = JSON.parse(respose);
                                for (index in responses) {
                                    var results = responses[index];
                                    deletediseases(results["diseaseid"]);
                                }

                                $.ajax({
                                    type: 'GET',
                                    data: {diseases: JSON.stringify(diseasesadded)},
                                    url: "doctorconsultation/patientconditions.htm",
                                    success: function (response) {
                                        $('#patientConditionsdiv').html(response);
                                    }
                                });
                            }
                        });
                    }
                });
                break;
            }
        }
    }
    function deletediseases(diseaseid) {
        for (i in diseasesadded) {
            if (parseInt(diseasesadded[i].diseaseid) === parseInt(diseaseid)) {
                diseasesadded.splice(i, 1);
                diseases.delete(parseInt(diseaseid));
                break;
            }
        }
    }
    function setPatientConditionforconfirm() {
        var patientvisitid=$('#facilityvisitPatientvisitid').val();
        $.confirm({
            title: 'Patient Condition(s) Confirmation',
            content: 'Are You Sure You Want Set <font color="blue"><strong>' + checkedpatientconditions.size + ' Condition(s) </strong></font> For Confirmation?',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {conditions:JSON.stringify(checkedpatientconditionList),symptom:JSON.stringify(Array.from(symptoms)),patientvisitid:patientvisitid},
                            url: "doctorconsultation/patientconditionforconfirmation.htm",
                            success: function (data) {
                                
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
</script>
