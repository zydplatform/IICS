<%-- 
    Document   : modifyPrescriptionItem
    Created on : Apr 30, 2019, 11:03:02 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="../../include.jsp"%>

<div class="row" id="prescription-item-container">
    <div class="col-md-12">
        <div class="form-group-sm">
            <input type="hidden" name="_prescription-items-id" id="_prescription-items-id" value="${prescriptionitem.newprescriptionitemsid}"/>
            <label for="item-name" class="control-label">Item Name:</label>
            <select id="item-name" name="item-name" class="form-control">
                <c:forEach items="${items}" var="item">
                    <option value="${item.genericname}" <c:if test="${prescriptionitem.genericname == item.genericname}">selected="selected"</c:if>>${item.genericname}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group-sm">
            <label for="dosage" class="control-label">Dosage:</label>
            <select id="dosage" name="dosage" class="form-control">
                <option value="Daily(OD)" <c:if test="${fn:toLowerCase(prescriptionitem.dosage) == fn:toLowerCase('Daily(OD)')}">selected="selected"</c:if>>Daily(OD)</option>
                <option value="BID/b.i.d" <c:if test="${fn:toLowerCase(prescriptionitem.dosage) == fn:toLowerCase('BID/b.i.d')}">selected="selected"</c:if>>BID/b.i.d</option>
                <option value="TID/t.i.d" <c:if test="${fn:toLowerCase(prescriptionitem.dosage) == fn:toLowerCase('TID/t.i.d')}">selected="selected"</c:if>>TID/t.i.d</option>
                <option value="QID/q.i.d" <c:if test="${fn:toLowerCase(prescriptionitem.dosage) == fn:toLowerCase('QID/q.i.d')}">selected="selected"</c:if>>QID/q.i.d</option>
                <option value='QHS(Bed time)' <c:if test="${fn:toLowerCase(prescriptionitem.dosage) == fn:toLowerCase('QHS(Bed time)')}">selected="selected"</c:if>>QHS(Bed time)</option>
                <option value='Q4h(Every 4 hours)' <c:if test="${fn:toLowerCase(prescriptionitem.dosage) == fn:toLowerCase('Q4h(Every 4 hours)')}">selected="selected"</c:if>>Q4h(Every 4 hours)</option>
                <option value='Q4h-6h(4-6 hours)' <c:if test="${fn:toLowerCase(prescriptionitem.dosage) == fn:toLowerCase('Q4h-6h(4-6 hours)')}">selected="selected"</c:if>>Q4h-6h(4-6 hours)</option>
                <option value='QWK(Every Week)' <c:if test="${fn:toLowerCase(prescriptionitem.dosage) == fn:toLowerCase('QWK(Every Week)')}">selected="selected"</c:if>>QWK(Every Week)</option>
            </select>
        </div> 
        <div class="form-group-sm">
            <label for="dose" class="control-label">Active Dose: </label>
            <input type="text" id="dose" name="dose" class="form-control" value="${prescriptionitem.dose}" placeholder="Enter Dose eg 1g, 2mg" />
            <i id="status" class="fa" style="font-size: 1.15em;"></i>
        </div>
        <div class="form-group-sm">
            <label for="duration" class="control-label">Duration:</label>
            <div class="input-group" id="duration" name="duration">
                <input type="text" id="days" class="form-control selected-days" 
                       placeholder="" aria-label="Text input with segmented dropdown button" value="${prescriptionitem.days}" />
                <div class="input-group-append">
                    <button type="button" class="btn btn-outline-secondary" id="daysname">${prescriptionitem.daysname}</button>
                    <button type="button" class="btn btn-outline-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="sr-only">Select Days</span>
                    </button>
                    <div class="dropdown-menu">
                        <span class="dropdown-item icon-custom">Day(s)</span>
                        <span class="dropdown-item icon-custom">Week(s)</span>
                        <span class="dropdown-item icon-custom">Month(s)</span>
                    </div>
                </div>
            </div>  
        </div>
        <div class="form-group-sm">
            <label for="reason" class="control-label">Reason:</label>
            <textarea id="reason" class="form-control text-left" rows="2"><c:if test="${prescriptionitem.containsKey('reason') == true}">${prescriptionitem.reason}</c:if></textarea>
        </div>
    </div>
</div>

<script>
    $('#dose').on('input', function(e){
        isAlphaNumeric($(this));        
    });
    $('.dropdown-item.icon-custom').on('click', function(){
        var parent = $($(this).parentsUntil("div.input-group")[1]);
        var type = $(this);
        parent.find('#daysname').html(type.html());
//        parent.find('#defaultselectedtypeString').val(type.html());
    });
    function isAlphaNumeric(control){
        var parent = control.parent();
        var value = control.val();
        var pattern = /[0-9]+\s*[a-zA-Z]+\s*[+\/a-zA-Z\s]*$/gi;
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