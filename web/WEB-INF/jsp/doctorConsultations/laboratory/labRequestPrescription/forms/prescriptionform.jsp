<%-- 
    Document   : prescriptionform
    Created on : Oct 26, 2018, 12:50:18 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<input type="hidden" value="Day(s)" id="LabPatientselectedtypeString">
<form>
    <div class="form-group">
        <!---->
<!--        <label for="batch">Drug Name</label>-->
        <label for="batch">Medicine</label>
        <select class="form-control select-labReqdrugtoprescribe" id="doctorlabReqPrescribeDrug">
            <option id="DrugPrescriptionDefaultLab" value="select">.........select...........</option>
            <c:forEach items="${ItemsFound}" var="a">
                <option id="DruglabReqPres${a.itemid.replaceAll("[^a-zA-Z0-9]","")}" data-itemname="${a.fullname}" value="${a.itemid}">${a.fullname}</option>
            </c:forEach>
        </select>
    </div>
    <div class="form-group">
        <label for="expiry">Dose</label>
        <input type="text" class="form-control select-labReqdrugdosetoprescribe" placeholder="Enter Dose eg 1 g, 2 mg">
        <i id="status" class="fa" style="font-size: 1.15em;"></i>
    </div>
    <div class="form-group">
        <label for="expiry">Dosage</label>
        <select class="form-control select-labReqdrugtoprescribedosage" id="labReqdrugtoprescribedosageid">
            <option value="select">Select dosage</option>
            <option value="Daily(OD)">Daily(OD)</option>
            <option value="BID/b.i.d">BID/b.i.d</option>
            <option value="TID/t.i.d">TID/t.i.d</option>
            <option value="QID/q.i.d">QID/q.i.d</option>
            <option value='QHS(Bed time)'>QHS(Bed time)</option>
            <option value='Q4h(Every 4 hours)'>Q4h(Every 4 hours)</option>
            <option value='Q4h-6h(4-6 hours)'>Q4h-6h(4-6 hours)</option>
            <option value='QWK(Every Week)'>QWK(Every Week)</option>
        </select>
    </div>
    <div class="form-group">
        <label for="expiry">Duration</label>
        <div class="input-group">
            <input type="text" class="form-control select-labPatientdrugtoprescribedays" placeholder="Enter Duration" aria-label="Text input with segmented dropdown button">
            <div class="input-group-append">
                <button type="button" class="btn btn-outline-secondary" id="labsettingtogglebtn">Day(s)</button>
                <button type="button" class="btn btn-outline-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="sr-only">Select Days</span>
                </button>
                <div class="dropdown-menu">
                    <span class="dropdown-item icon-custom" onclick="setselectedtype(1, 'Day(s)');">Day(s)</span>
                    <span class="dropdown-item icon-custom" onclick="setselectedtype(2, 'Week(S)');">Week(S)</span>
                    <span class="dropdown-item icon-custom" onclick="setselectedtype(3, 'Month(s)');">Month(s)</span>
                </div>
            </div>
        </div>   
    </div>
    <div class="form-group">
        <label for="batch">Special Instructions</label>
        <!--<textarea class="Labprescribeditemmoreinfo form-control" placeholder="Enter Comment" rows="2"></textarea>-->
        <select class="Labprescribeditemmoreinfo form-control" id="Labprescribeditemmoreinfo">
            <option value=""></option>
            <c:forEach items="${specialInstructions}" var="instruction">
                <option value="${instruction.specialinstruction}">${instruction.specialinstruction}</option>
            </c:forEach>
        </select>
    </div>
</form>
<script>
    $('.select-labReqdrugtoprescribe').select2();
    $('.select-labReqdrugtoprescribedosage').select2();
    
      $('.select2').css('width', '100%');
    function labsettingtogglebtn(value, type) {
        $('#settingtogglebtn').html(type);
        $('#LabPatientselectedtypeString').val(type);
    }
    $('#Labprescribeditemmoreinfo').select2({
        tags: true,
        placeholder: "Enter Special Instructions",
        width: '100%'
    });
    $('input.select-labReqdrugdosetoprescribe').on('input', function(e){        
        isAlphaNumeric($(this));        
    });
    //
    
    $('#doctorlabReqPrescribeDrug').change(function(){
        //
        
        var itemid = $('#doctorlabReqPrescribeDrug').val();
        var itemname = $('#DruglabReqPres' + itemid.replace(/[^0-9a-z]/gi, '')).data('itemname');
        var patientId = $('#facilitylabvisitedPatientid').val();
        if (checkItemAlreadyPrescribed(itemname, patientId) === true) {
            $('#addlabPrescriptionsbtn').prop('disabled', true);
        } else {
            $('#addlabPrescriptionsbtn').prop('disabled', false);
        }
        //
    });
</script>
