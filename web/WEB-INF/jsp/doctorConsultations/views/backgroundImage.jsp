<%-- 
    Document   : backgroundImage
    Created on : Oct 24, 2018, 8:34:13 AM
    Author     : IICS
--%>

<div id="addeddiseasesSymptomsdiv" style="background-color: #eef4f7;">
    <img src="static/img2/nosymptoms.PNG" style="height: 269px !important; margin-left: 30%;">  
</div>
<script>
    function selectedPatientCondition(diseaseid) {
        var curStep = $('#step-1').closest(".setup-content"),
                curStepBtn = curStep.attr("id"),
                nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
                isValid = true;

        if (isValid) {
            nextStepWizard.removeAttr('disabled').trigger('click');
            ajaxSubmitDataNoLoader('doctorconsultation/patientconditiondetails.htm', 'patientConditionsDiv', 'diseaseid='+diseaseid+'&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    }
</script>