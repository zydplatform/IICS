<%-- 
    Document   : suppliers
    Created on : Mar 27, 2018, 12:51:47 PM
    Author     : IICS
--%>
<style>
    .select2-container{
        z-index: 9999999 !important;
    }
</style>
<%@include file="../../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <p class="pull-right">
            <button class="btn btn-primary icon-btn" onclick="openDialog()">
                <i class="fa fa-plus"></i>
                Register Supplier
            </button>
        </p>
    </div>
</div>
<fieldset>
    <table class="table table-hover table-bordered" id="supplierTable">
        <thead>
            <tr>
                <th>No</th>
                <th>Supplier</th>
                <th class="center">Address</th>
                <th class="center">Activation</th>
                <th class="center">Manage Details</th>
            </tr>
        </thead>
        <tbody id="bodySuppliers">
            <% int n = 1;%>
            <c:forEach items="${suppliers}" var="supplier">
                <tr>
                    <td><%=n++%></td>
                    <td>
                        ${supplier.name}
                        <br>
                        ${supplier.code}
                    </td>
                    <td>
                        ${supplier.phy}
                    </td>
                    <td class="center" id="switch${supplier.id}">
                        <label class="switch">
                            <input type="checkbox" id="supplier${supplier.id}" ${supplier.status}>
                            <span class="slider round" onclick="supplierStatus(${supplier.id}, '${supplier.name}', '${supplier.status}')"></span>
                        </label>
                    </td>  
                    <td class="center">
                        <a href="#!" data-trigger="focus" data-toggle="popover" data-id="${supplier.id}" data-container="body" data-placement="right" data-html="true" data-original-title="${supplier.name}">
                            <i class="fa fa-fw fa-lg fa-dedent"></i>
                        </a>
                        &nbsp;|&nbsp;
                        <a href="#updateSupplier" onclick="updateSupplier(${supplier.id})">
                            <i class="fa fa-fw fa-lg fa-edit"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</fieldset>
<div class="row">
    <div class="col-md-12">
        <div id="registerSupplier" class="registerSupplier newSupplier">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Register New Supplier</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-6">
                        <div class="tile">
                            <h4 class="tile-title">Basic Details</h4>
                            <div class="tile-body">
                                <form id="entryform1">
                                    <div class="form-group">
                                        <label class="control-label">Supplier Names</label>
                                        <input class="form-control" id="suppliername" type="text" placeholder="Supplier Names">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Company No.</label>
                                        <input class="form-control" id="suppliercode" type="text" placeholder="Registration / Company No.">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">TIN No.</label>
                                        <input class="form-control" id="tinno" type="text" placeholder="TIN No.">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Supplies</label>
                                        <div class="form-check">
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="checkbox" id="products">Products
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="checkbox" id="services">Services
                                            </label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Office Tel. No</label>
                                        <input class="form-control" id="tel" type="text" placeholder="Tel. No">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Email Address</label>
                                        <input class="form-control" id="email" type="text" placeholder="Email Address">
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
                                    <input class="form-control" id="streetname" type="text" placeholder="X Street">
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Plot No./House</label>
                                    <input class="form-control" id="plot" type="text" placeholder="Plot X">
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Postal Address</label>
                                    <input class="form-control" id="post" type="text" placeholder="P.O Box xxx, Kampala">
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Fax</label>
                                    <input class="form-control" id="fax" type="text" placeholder="Fax">
                                </div>
                                <div class="form-group">
                                    <label class="control-label">District</label>
                                    <select class="form-control" id="district">

                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Village</label>
                                    <select class="form-control" id="village">

                                    </select>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-12 right">
                        <button class="btn btn-primary right" id="saveSupplier" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Save Supplier
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="updateSupplier" class="registerSupplier updateSupplier">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Update Supplier Details</h2>
                    <hr>
                </div>
                <div class="row scrollbar updateSupplierContent" id="content">

                </div>
            </div>
        </div>
    </div>
</div>
<c:forEach items="${suppliers}" var="supplier">
    <div id="supplierDetails${supplier.id}" class="hide">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <form id="entryform">
                            <div id="horizontalwithwords">
                                <span class="pat-form-heading"><strong>Supplier Reg No.</strong></span>
                            </div>
                            <div class="form-group bs-component center">
                                <span class="control-label pat-form-heading patientConfirmFont reg${supplier.id}">${supplier.code}</span>
                            </div>
                            <div id="horizontalwithwords">
                                <span class="pat-form-heading"><strong>TIN No.</strong></span>
                            </div>
                            <div class="form-group bs-component center">
                                <span class="control-label pat-form-heading patientConfirmFont tin${supplier.id}">${supplier.tin}</span>
                            </div>
                            <div id="horizontalwithwords">
                                <span class="pat-form-heading"><strong>Contacts</strong></span>
                            </div>
                            <div class="form-group bs-component center">
                                <span class="control-label pat-form-heading patientConfirmFont tel${supplier.id}">${supplier.tel}</span>
                            </div>
                            <div class="form-group bs-component center">
                                <span class="control-label pat-form-heading patientConfirmFont email${supplier.id}">${supplier.email}</span>
                            </div>
                            <div class="form-group bs-component center">
                                <span class="control-label pat-form-heading patientConfirmFont post${supplier.id}">${supplier.post}</span>
                            </div>
                            <div id="horizontalwithwords">
                                <span class="pat-form-heading"><strong>Location</strong></span>
                            </div>
                            <div class="form-group bs-component center">
                                <span class="control-label pat-form-heading patientConfirmFont vil${supplier.id}">${supplier.vil}</span>
                            </div>
                            <div class="form-group bs-component center">
                                <span class="control-label pat-form-heading patientConfirmFont sub${supplier.id}">${supplier.sub}</span>
                            </div>
                            <div class="form-group bs-component center">
                                <span class="control-label pat-form-heading patientConfirmFont dis${supplier.id}">${supplier.dis}</span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
<script>
    var oldTel = '';
    $(document).ready(function () {
        var villageList = [];
        $('#supplierTable').DataTable();
        $('#district').select2();
        $('#village').select2();
        $('.select2').css('width', '100%');
        $('#tel').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });
        $('#fax').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });
        $.ajax({
            type: 'POST',
            url: 'locations/fetchDistricts.htm',
            success: function (data) {
                var res = JSON.parse(data);
                if (res !== '' && res.length > 0) {
                    for (i in res) {
                        $('#district').append('<option id="dis' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                    }
                    var districtid = parseInt($('#district').val());
                    $.ajax({
                        type: 'POST',
                        url: 'locations/fetchDistrictVillages.htm',
                        data: {districtid: districtid},
                        success: function (data) {
                            var res = JSON.parse(data);
                            if (res !== '' && res.length > 0) {
                                villageList = res;
                                for (i in res) {
                                    $('#villageList').append('<option value="' + res[i].village + '">' + res[i].subcounty + '</option>');
                                }
                            }
                        }
                    });
                }
            }
        });
        $('#village').html('');
        var districtid = parseInt($('#district').val());
        $.ajax({
            type: 'POST',
            url: 'locations/fetchDistrictVillages.htm',
            data: {districtid: districtid},
            success: function (data) {
                var res = JSON.parse(data);
                if (res !== '' && res.length > 0) {
                    for (i in res) {
                        $('#village').append('<option value="' + res[i].id + '">' + res[i].village + ' [' + res[i].subcounty + ']</option>');
                    }
                }
            }
        });
        $('#district').change(function () {
            $('#village').html('');
            districtid = parseInt($('#district').val());
            $.ajax({
                type: 'POST',
                url: 'locations/fetchDistrictVillages.htm',
                data: {districtid: districtid},
                success: function (data) {
                    var res = JSON.parse(data);
                    if (res !== '' && res.length > 0) {
                        for (i in res) {
                            $('#village').append('<option value="' + res[i].id + '">' + res[i].village + ' [' + res[i].subcounty + ']</option>');
                        }
                    }
                }
            });
        });
        $('#saveSupplier').click(function () {
            var product = document.getElementById("products");
            var services = document.getElementById("services");
            var name = $('#suppliername').val();
            var code = $('#suppliercode').val();
            var operations = product.checked && services.checked ? 'Products And Services' : product.checked ? 'Products' : services.checked ? 'Services' : '';
            var tel = $('#tel').val();
            var email = $('#email').val();
            var tin = $('#tinno').val();

            var plot = $('#plot').val();
            var street = $('#streetname').val();
            var phy = plot + '<br>' + street;
            var post = $('#post').val();
            var fax = $('#fax').val();
            var village = parseInt($('#village').val());
            if (name !== '' && code !== '' && tel !== '' && validateEmail(email) && village !== '' && tin !== '') {
                oldTel = '';
                $('#village').removeClass('error-field');
                $('#email').removeClass('error-field');
                $('#tel').removeClass('error-field');
                $('#tinno').removeClass('error-field');
                $('#suppliercode').removeClass('error-field');
                $('#suppliername').removeClass('error-field');
                var data = {
                    name: name,
                    code: code,
                    operations: operations,
                    tel: tel,
                    email: email,
                    phy: phy,
                    post: post,
                    fax: fax,
                    villageid: village,
                    tin: tin
                };
                $.ajax({
                    type: 'POST',
                    data: {data: JSON.stringify(data)},
                    url: 'externalsuppliers/saveSupplier.htm',
                    success: function (response) {
                        if (response !== '') {
                            showNotification('Success', ': Supplier Saved.', 'success', 'registerSupplier > div');
                            document.getElementById("entryform1").reset();
                            document.getElementById("entryform2").reset();
                            $('.pagination li:nth-last-child(2)').click();
                            $('#bodySuppliers').append(
                                    '<tr><td><%=n++%></td><td>' + name + '<br>' + code + '</td>' +
                                    '<td>' + phy + '</td>' +
                                    '<td class="center" id="switch' + response + '"><label class="switch">' +
                                    '<input type="checkbox" id="supplier' + response + '" checked>' +
                                    '<span class="slider round" onclick="supplierStatus(' + response + ', \'' + name + '\', \'checked\')"></span></label></td>' +
                                    '<td class="center">' +
                                    '<a href="#"><i class="fa fa-fw fa-lg fa-dedent"></i></a>' +
                                    '</td></tr>'
                                    );
                        }
                    }
                });
            } else {
                if (village === '') {
                    $('#village').focus();
                    $('#village').addClass('error-field');
                } else {
                    $('#village').removeClass('error-field');
                }
                if (!validateEmail(email)) {
                    $('#email').focus();
                    $('#email').addClass('error-field');
                } else {
                    $('#email').removeClass('error-field');
                }
                if (tel === '') {
                    $('#tel').focus();
                    $('#tel').addClass('error-field');
                } else {
                    $('#tel').removeClass('error-field');
                }
                if (tin === '') {
                    $('#tinno').focus();
                    $('#tinno').addClass('error-field');
                } else {
                    $('#tinno').removeClass('error-field');
                }
                if (code === '') {
                    $('#suppliercode').focus();
                    $('#suppliercode').addClass('error-field');
                } else {
                    $('#suppliercode').removeClass('error-field');
                }
                if (name === '') {
                    $('#suppliername').focus();
                    $('#suppliername').addClass('error-field');
                } else {
                    $('#suppliername').removeClass('error-field');
                }
            }
        });
        $('[data-toggle=popover]').each(function (i, obj) {
            $(this).popover({
                html: true,
                content: function () {
                    var id = $(this).attr('data-id');
                    var popup = $('#supplierDetails' + id).html();
                    return popup;
                }
            });
        });
    });

    function openDialog() {
        window.location = '#registerSupplier';
        initDialog('newSupplier');
    }

    function updateSupplier(supplierid) {
        window.location = '#updateSupplier';
        initDialog('updateSupplier');
        $.ajax({
            type: 'POST',
            data: {supplierid: supplierid},
            url: 'externalsuppliers/fetchUpdateForm.htm',
            success: function (res) {
                $('.updateSupplierContent').html(res);
            }
        });
    }

    function findVillageId(villageList, village) {
        var villageid = 0;
        for (i in villageList) {
            if ((villageList[i].village).replace(' ', '') === village.replace(' ', '')) {
                villageid = villageList[i].id;
                break;
            }
        }
        return villageid;
    }

    function validateEmail(email) {
        var atpos = email.indexOf("@");
        var dotpos = email.lastIndexOf(".");
        if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
            return false;
        }
        return true;
    }

    function addError(id) {
        $('#' + id).addClass('error-field');
    }

    function removeError(id) {
        $('#' + id).removeClass('error-field');
    }

    function validatePhone() {
        var newTel = ($('#tel').val()).toString();
        var telLength = newTel.length;
        if (telLength > 0 && telLength < 14) {
            var newKey = parseInt(newTel[telLength - 1]);
            if (newKey > 0 || newKey === 0 || newTel[telLength - 1] === ' ' || newTel[telLength - 1] === ')' || newTel[telLength - 1] === '(') {
                oldTel = oldTel + newKey.toString();
                if (oldTel.length === 3) {
                    oldTel = '(' + oldTel + ') ';
                    $('#tel').val(oldTel);
                }
            } else {
                $('#tel').val(oldTel);
            }
        } else {
            if (telLength < 0 || telLength === 0) {
                oldTel = '';
                $('#tel').val('');
                addError('tel');
            } else {
                $('#tel').val(oldTel);
                removeError('tel');
            }
        }
    }

    function supplierStatus(id, supplierName, status) {
        if (status.length < 1) {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Activate Supplier',
                content: '<strong>' + supplierName + '</strong>',
                type: 'blue',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Activate',
                        btnClass: 'btn-blue',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {id: id, value: true},
                                url: 'externalsuppliers/activateSupplier.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#switch' + id).html('<label class="switch"><input id="supplier' + id + '" type="checkbox" checked><span onclick="supplierStatus(' + id + ', \'' + supplierName + '\', \'checked\')" class="slider round"></span></label>');
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Supplier Activated',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Activate Supplier',
                                            icon: 'warning',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    }
                                }
                            });
                        }
                    },
                    close: {
                        text: 'Cancel',
                        action: function () {
                            $('#supplier' + id).click();
                        }
                    }
                }
            });
        } else {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Deactivate Supplier',
                content: '<strong>' + supplierName + '</strong>',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Deactivate',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {id: id, value: false},
                                url: 'externalsuppliers/activateSupplier.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#switch' + id).html('<label class="switch"><input id="supplier' + id + '" type="checkbox"><span onclick="supplierStatus(' + id + ', \'' + supplierName + '\', \'\')" class="slider round"></span></label>');
                                        $.toast({
                                            heading: 'Info',
                                            text: 'Supplier Dectivated',
                                            icon: 'info',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Deactivate Supplier',
                                            icon: 'warning',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    }
                                }
                            });
                        }
                    },
                    close: {
                        text: 'Cancel',
                        action: function () {
                            $('#supplier' + id).click();
                        }
                    }
                }
            });
        }
    }

    function saveSupplierUpdate(supplierid) {
        var product = document.getElementById("productsUpdate");
        var services = document.getElementById("servicesUpdate");
        var name = $('#suppliernameUpdate').val();
        var code = $('#suppliercodeUpdate').val();
        var operations = product.checked && services.checked ? 'Products And Services' : product.checked ? 'Products' : services.checked ? 'Services' : '';
        var tel = $('#telUpdate').val();
        var email = $('#emailUpdate').val();
        var tin = $('#tinnoUpdate').val();

        var plot = $('#plotUpdate').val();
        var street = $('#streetnameUpdate').val();
        var phy = plot + '<br>' + street;
        var post = $('#postUpdate').val();
        var fax = $('#faxUpdate').val();
        var village = parseInt($('#villageUpdate').val());
        if (name !== '' && code !== '' && tel !== '' && validateEmail(email) && village !== '' && tin !== '') {
            $('#villageUpdate').removeClass('error-field');
            $('#emailUpdate').removeClass('error-field');
            $('#telUpdate').removeClass('error-field');
            $('#tinnoUpdate').removeClass('error-field');
            $('#suppliercodeUpdate').removeClass('error-field');
            $('#suppliernameUpdate').removeClass('error-field');
            var data = {
                id: supplierid,
                name: name,
                code: code,
                operations: operations,
                tel: tel,
                email: email,
                phy: phy,
                post: post,
                fax: fax,
                villageid: village,
                tin: tin
            };
            $.ajax({
                type: 'POST',
                data: {data: JSON.stringify(data)},
                url: 'externalsuppliers/updateSupplier.htm',
                success: function (response) {
                    if (response !== '') {
                        showNotification('Success', ': Details Updated.', 'success', 'updateSupplier > div');
                        ajaxSubmitData('externalsuppliers/initSupplierPane.htm', 'externalSupplierContent', 'tab=tab1', 'GET');
                    }
                }
            });
        } else {
            if (village === '') {
                $('#villageUpdate').focus();
                $('#villageUpdate').addClass('error-field');
            } else {
                $('#villageUpdate').removeClass('error-field');
            }
            if (!validateEmail(email)) {
                $('#emailUpdate').focus();
                $('#emailUpdate').addClass('error-field');
            } else {
                $('#emailUpdate').removeClass('error-field');
            }
            if (tel === '') {
                $('#telUpdate').focus();
                $('#telUpdate').addClass('error-field');
            } else {
                $('#telUpdate').removeClass('error-field');
            }
            if (tin === '') {
                $('#tinnoUpdate').focus();
                $('#tinnoUpdate').addClass('error-field');
            } else {
                $('#tinnoUpdate').removeClass('error-field');
            }
            if (code === '') {
                $('#suppliercodeUpdate').focus();
                $('#suppliercodeUpdate').addClass('error-field');
            } else {
                $('#suppliercodeUpdate').removeClass('error-field');
            }
            if (name === '') {
                $('#suppliernameUpdate').focus();
                $('#suppliernameUpdate').addClass('error-field');
            } else {
                $('#suppliernameUpdate').removeClass('error-field');
            }
        }
    }
</script>
