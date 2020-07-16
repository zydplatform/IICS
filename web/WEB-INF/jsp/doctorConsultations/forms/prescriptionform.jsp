<%-- 
    Document   : prescriptionform
    Created on : Sep 17, 2018, 11:51:32 AM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<input type="hidden" value="Day(s)" id="defaultselectedtypeString">
<div class="form-group">
<!--    <label for="batch">Drug Name</label>-->
    <label for="batch">Medicine</label>
    <select class="form-control select-drugtoprescribe" id="doctorPrescribeDrug">
        <option id="DrugPrescriptionDefaults" value="select">.........select...........</option>
        <c:forEach items="${ItemsFound}" var="a">
            <option id="DrugPres${a.itemid.replaceAll("[^a-zA-Z0-9]","")}" data-itemname="${a.fullname}" value="${a.itemid}">${a.fullname}</option>
        </c:forEach>
    </select>
</div>
<div class="form-group">
    <label for="expiry">Active Dose</label>
    <input type="text" class="form-control select-drugdosetoprescribe" placeholder="Enter Dose eg 1 g, 2 mg">
    <i id="status" class="fa" style="font-size: 1.15em;"></i>
</div>
<div class="form-group">
    <label for="expiry">Dosage</label>
    <select class="form-control select-drugtoprescribedosage" id="drugtoprescribedosageid">
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
        <input type="text" class="form-control select-drugtoprescribedays" placeholder="Enter Days" aria-label="Text input with segmented dropdown button">
        <div class="input-group-append">
            <button type="button" class="btn btn-outline-secondary" id="settingtogglebtn">Day(s)</button>
            <button type="button" class="btn btn-outline-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="sr-only">Select Days</span>
            </button>
            <div class="dropdown-menu">
                <span class="dropdown-item icon-custom" onclick="settselectedtype(1, 'Day(s)');">Day(s)</span>
                <span class="dropdown-item icon-custom" onclick="settselectedtype(2, 'Week(S)');">Week(S)</span>
                <span class="dropdown-item icon-custom" onclick="settselectedtype(3, 'Month(s)');">Month(s)</span>
            </div>
        </div>
    </div>   
</div>

<div class="form-group">
<!--    <label for="batch">Comment</label>-->
    <label for="batch">Special Instructions</label>
<!--    <textarea class="prescribedpatientitemmoreinfo form-control" placeholder="Enter Comment" rows="2"></textarea>-->
<select class="prescribedpatientitemmoreinfo form-control" id="prescribedpatientitemmoreinfo">
    <option value=""></option>
    <c:forEach items="${specialInstructions}" var="instruction">
        <option value="${instruction.specialinstruction}">${instruction.specialinstruction}</option>
    </c:forEach>
</select>
</div>
<script>
    $('.select-drugtoprescribe').select2();
    $('.select-drugtoprescribedosage').select2();
    
    $('.select2').css('width', '100%');
    function settselectedtype(value, type) {
        $('#settingtogglebtn').html(type);
        $('#defaultselectedtypeString').val(type);
    }
    $('#prescribedpatientitemmoreinfo').select2({
        tags: true,
        placeholder: "Enter Special Instructions",
        width: '100%'
    });
    $('input.select-drugdosetoprescribe').on('input', function(e){        
        isAlphaNumeric($(this));        
    });
     //
    $('#doctorPrescribeDrug').change(function(){
        //
        var itemid = $('#doctorPrescribeDrug').val();
        var itemname = $('#DrugPres' + itemid.replace(/[^0-9a-z]/gi, '')).data('itemname');
        var patientId = $('#facilityvisitedPatientid').val();
        if (checkItemAlreadyPrescribed(itemname, patientId) === true) {
            $('#addingPrescriptionsbtns').prop('disabled', true);
        } else {
            $('#addingPrescriptionsbtns').prop('disabled', false);
        }
        //
    });
    //
    function capitalize(str,force){
        str=force ? str.toLowerCase() : str;  
        return str.replace(/(\b)([a-zA-Z])/g,
                 function(firstLetter){
                    return   firstLetter.toUpperCase();
                 });
    }  
</script>