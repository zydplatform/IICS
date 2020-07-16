<%-- 
    Document   : updateSupplier
    Created on : 01-Jun-2018, 08:09:53
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<div class="col-md-6">
    <div class="tile">
        <h4 class="tile-title">Basic Details</h4>
        <div class="tile-body">
            <form id="entryform1">
                <div class="form-group">
                    <label class="control-label">Supplier Names</label>
                    <input class="form-control" value="${supplier.name}" id="suppliernameUpdate" type="text" placeholder="Supplier Names">
                </div>
                <div class="form-group">
                    <label class="control-label">Company No.</label>
                    <input class="form-control" value="${supplier.code}" id="suppliercodeUpdate" type="text" placeholder="Registration / Company No.">
                </div>
                <div class="form-group">
                    <label class="control-label">TIN No.</label>
                    <input class="form-control" value="${supplier.tin}" id="tinnoUpdate" type="text" placeholder="TIN No.">
                </div>
                <div class="form-group">
                    <label class="control-label">Supplies</label>
                    <div class="form-check">
                        <label class="form-check-label">
                            <input class="form-check-input" type="checkbox" id="productsUpdate">Products
                        </label>
                    </div>
                    <div class="form-check">
                        <label class="form-check-label">
                            <input class="form-check-input" type="checkbox" id="servicesUpdate">Services
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label">Office Tel. No</label>
                    <input class="form-control" value="${supplier.tel}" id="telUpdate" oninput="validatePhone()" onfocus="addError('tel')" type="text" placeholder="Tel. No">
                </div>
                <div class="form-group">
                    <label class="control-label">Email Address</label>
                    <input class="form-control" value="${supplier.email}" id="emailUpdate" type="text" placeholder="Email Address">
                </div>
            </form>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="tile">
        <h4 class="tile-title">Address Information</h4>
        <form id="entryform2">
            <div class="form-group">
                <label class="control-label">Street</label>
                <input class="form-control" value="${supplier.str}" id="streetnameUpdate" type="text" placeholder="X Street">
            </div>
            <div class="form-group">
                <label class="control-label">Plot No./House</label>
                <input class="form-control" value="${supplier.plo}" id="plotUpdate" type="text" placeholder="Plot X">
            </div>
            <div class="form-group">
                <label class="control-label">Postal Address</label>
                <input class="form-control" value="${supplier.post}" id="postUpdate" type="text" placeholder="P.O Box xxx, Kampala">
            </div>
            <div class="form-group">
                <label class="control-label">Fax</label>
                <input class="form-control" value="${supplier.fax}" id="faxUpdate" type="text" placeholder="Fax">
            </div>
            <div class="form-group">
                <label class="control-label">District</label>
                <select class="form-control" id="districtUpdate">
                    <c:forEach items="${districts}" var="district">
                        <c:if test="${district.id == supplier.dis}">
                            <option value="${district.id}" selected="true">${district.name}</option>
                        </c:if>
                        <c:if test="${district.id != supplier.dis}">
                            <option value="${district.id}">${district.name}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label class="control-label">Village</label>
                <select class="form-control" id="villageUpdate">

                </select>
            </div>
        </form>
    </div>
</div>
<div class="col-md-12 right">
    <button class="btn btn-primary right" onclick="saveSupplierUpdate(${supplier.id})" type="button">
        <i class="fa fa-fw fa-lg fa-plus-circle"></i>
        Update Details
    </button>
</div>
<script>
    $(document).ready(function () {
        $('#districtUpdate').select2();
        $('#villageUpdate').select2();
        $('.select2').css('width', '100%');
        var opr = '${supplier.opr}';
        if (opr === 'Products And Services') {
            $('#productsUpdate').click();
            $('#servicesUpdate').click();
        } else if (opr === 'Products') {
            $('#productsUpdate').click();
        } else if (opr === 'Services') {
            $('#servicesUpdate').click();
        }
        $('#telUpdate').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });
        $('#faxUpdate').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });
        $('#villageUpdate').html('');
        var districtid = parseInt($('#districtUpdate').val());
        $.ajax({
            type: 'POST',
            url: 'locations/fetchDistrictVillages.htm',
            data: {districtid: districtid},
            success: function (data) {
                var res = JSON.parse(data);
                if (res !== '' && res.length > 0) {
                    for (i in res) {
                        if (res[i].id === ${supplier.vil}) {
                            $('#villageUpdate').append('<option value="' + res[i].id + '" selected="true">' + res[i].village + ' [' + res[i].subcounty + ']</option>').trigger('change');
                        } else {
                            $('#villageUpdate').append('<option value="' + res[i].id + '">' + res[i].village + ' [' + res[i].subcounty + ']</option>');
                        }
                    }
                }
            }
        });
        $('#districtUpdate').change(function () {
            $('#villageUpdate').html('');
            var districtid = parseInt($('#districtUpdate').val());
            $.ajax({
                type: 'POST',
                url: 'locations/fetchDistrictVillages.htm',
                data: {districtid: districtid},
                success: function (data) {
                    var res = JSON.parse(data);
                    if (res !== '' && res.length > 0) {
                        for (i in res) {
                            if (res[i].id === ${supplier.vil}) {
                                $('#villageUpdate').append('<option value="' + res[i].id + '" selected="true">' + res[i].village + ' [' + res[i].subcounty + ']</option>').trigger('change');
                            } else {
                                $('#villageUpdate').append('<option value="' + res[i].id + '">' + res[i].village + ' [' + res[i].subcounty + ']</option>');
                            }
                        }
                    }
                }
            });
        });
    });
</script>