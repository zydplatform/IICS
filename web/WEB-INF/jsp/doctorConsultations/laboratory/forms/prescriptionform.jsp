<%-- 
    Document   : prescriptionform
    Created on : Oct 6, 2018, 9:22:31 PM
    Author     : HP
--%>
<%@include file="../../../include.jsp" %>
<form>
    <div class="form-group">
        <!--<label for="batch">Drug Name</label>-->
        <label for="batch">Medicine</label>
        <select class="form-control select-labdrugtoprescribe" id="doctorlabPrescribeDrug">
            <option id="DrugPrescriptionDefaults" value="select">.........select...........</option>
            <c:forEach items="${ItemsFound}" var="a">
                <option id="DruglabPres${a.itemid.replaceAll("[^a-zA-Z0-9]","")}" data-itemname="${a.fullname}" value="${a.itemid}">${a.fullname}</option>
            </c:forEach>
        </select>
    </div>
    <div class="form-group">
    <label for="expiry">Dose</label>
    <input type="text" class="form-control select-labdrugdosetoprescribe" placeholder="Enter Dose eg 1 g, 2 mg">
    <i id="status" class="fa" style="font-size: 1.15em;"></i>
</div>
    <div class="form-group">
        <label for="expiry">Dosage</label>
        <select class="form-control select-labdrugtoprescribedosage" id="labdrugtoprescribedosageid">
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
        <label for="quantity">Duration</label>
        <select class="form-control select-labdrugtoprescribedays">
            <option value="select">Select duration</option>
            <option id="druglabpresed1" data-days="One Day" value='1'>One Day</option>
            <option id="druglabpresed2" data-days="Two Days" value='2'>Two Days</option>
            <option id="druglabpresed3" data-days="Three Days" value='3'>Three Days</option>
            <option id="druglabpresed4" data-days="Four Days" value='4'>Four Days</option>
            <option id="druglabpresed5" data-days="Five Days" value='5'>Five Days</option>
            <option id="druglabpresed6" data-days="Six Days" value='6'>Six Days</option>
            <option id="druglabpresed7" data-days="1/52(One Week)" value='7'>1/52(One Week)</option>
            <option id="druglabpresed14" data-days="2/52(Two Weeks)" value='14'>2/52(Two Weeks)</option>
            <option id="druglabpresed21" data-days="3/52(Three Weeks)" value='21'>3/52(Three Weeks)</option>
            <option id="druglabpresed28" data-days="Four Weeks" value='28'>Four Weeks</option>
            <option id="druglabpresed30" data-days="1/12(One Month)" value='30'>1/12(One Month)</option>
        </select>
    </div>  
    <div class="form-group">
        <label for="batch">Special Instructions</label>
        <!--<textarea class="prescribeditemmoreinfo form-control" placeholder="Enter Comment" rows="2"></textarea>-->
        <select class="prescribeditemmoreinfo form-control" id="prescribeditemmoreinfo">
            <option value=""></option>
            <c:forEach items="${specialInstructions}" var="instruction">
                <option value="${instruction.specialinstruction}">${instruction.specialinstruction}</option>
            </c:forEach>
        </select>
    </div>
</form>
<script>
    $('.select-labdrugtoprescribe').select2();
    $('.select-labdrugtoprescribedosage').select2();
    $('.select-labdrugtoprescribedays').select2();
    $('input.select-drugdosetoprescribe').on('input', function(e){
        debugger
        isAlphaNumeric($(this));        
    });
    $('#prescribeditemmoreinfo').select2({
        tags: true,
        placeholder: "Enter Special Instructions",
        width: '100%'
    });
    $('input.select-labdrugdosetoprescribe').on('input', function(e){
        debugger
        isAlphaNumeric($(this));        
    });
</script>
