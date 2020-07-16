<%-- 
    Document   : pausedProcurementPlan
    Created on : Apr 12, 2018, 1:31:28 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <legend>Paused Procurement Plan(s)</legend>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <div class="form-group row">
                            <label class="control-label col-md-4">Procurement Plan For Financial Year:</label>
                            <div class="col-md-6">
                                <c:if test="${not empty financialyr}">
                                    <c:forEach items="${financialyr}" var="fyr">
                                        <h3><span class="badge badge-secondary"><strong>${fyr.procurementplan}</strong></span></h3>
                                                </c:forEach>  
                                            </c:if>
                                            <c:if test="${empty financialyr}">
                                    <h3><span class="badge badge-secondary"><strong>NO Financial Year</strong></span></h3>
                                </c:if>
                            </div>
                        </div>
                        <div class="form-group row" style="display: none;">
                            <label class="control-label col-md-4">Procurement Plan For Financial Year:</label>
                            <div class="col-md-6">
                                <select class="form-control" id="pausedselectprocurementfacilityyr" disabled="true">
                                    <c:forEach items="${financialyr}" var="fyr">
                                        <option  value="${fyr.facilityfinancialyearid}">${fyr.financialyear}</option>
                                    </c:forEach>
                                </select>    
                            </div>
                        </div>
                        <c:if test="${size==0}">
                            <p style="color: red;">No Paused /Partially Done Procurement Plan !!!</p>
                        </c:if>
                        <div id="pausedfinancialyearperiodstable"></div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div> 

<script>

    var pausedprocurementfacilityyr = $('#pausedselectprocurementfacilityyr').val();
    if (pausedprocurementfacilityyr !== null) {
        ajaxSubmitData('procurementplanmanagement/pausedfinancialyearperiodstable.htm', 'pausedfinancialyearperiodstable', 'act=a&pausedprocurementfacilityyr=' + pausedprocurementfacilityyr + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
    } else {
        $('#pausedselectprocurementfacilityyr').append('<option>No Finacial Year With Paused Procurement plans</option>');
    }
    $('#pausedselectprocurementfacilityyr').change(function () {
        var financialyearid = $('#pausedselectprocurementfacilityyr').val();
        ajaxSubmitData('procurementplanmanagement/pausedfinancialyearperiodstable.htm', 'pausedfinancialyearperiodstable', 'act=a&pausedprocurementfacilityyr=' + financialyearid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
</script>
<script>
    function sentprocurementplans() {
        ajaxSubmitData('procurementplanmanagement/sentorrejectedorapprovedprocurementplan.htm', 'user-settings1', 'act=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function submitprocurementplan(id) {
        var fields = id.split('-');
        var fanancialyearid = fields[1];
        swal({
            title: "Are you sure?",
            text: "You will Not be able to add More Items Or Edit!",
            type: "warning",
            showCancelButton: true,
            confirmButtonText: "Yes, Activate!",
            cancelButtonText: "No, cancel!",
            closeOnConfirm: false,
            closeOnCancel: false
        }, function (isConfirm) {
            if (isConfirm) {
                $.ajax({
                    type: 'POST',
                    data: {fanancialyearid: fanancialyearid},
                    url: "procurementplanmanagement/submittheprocurementplanwithoutedits.htm",
                    success: function (data, textStatus, jqXHR) {
                        if (data === 'success') {
                            swal("Procurement Plan!", "Success Fully Submitted !!!", "success");
                            ajaxSubmitData('procurementplanmanagement/pausedprocurementplans.htm', 'content3', 'act=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        } else {
                            $.toast({
                                heading: 'Error',
                                text: 'An unexpected error occured while trying to Submit The Procurement Try Again Or Contact Admin',
                                icon: 'error',
                                hideAfter: 2000,
                                position: 'bottom-center'
                            });
                        }

                    }
                });

            } else {
                swal("Cancelled", "Submission Cancelled:)", "error");

            }
        });
    }
    function addmoreitemstoprocurement(id) {
        var fields = id.split('-');
        var fanancialyearid = fields[1];
        var tableData = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        ajaxSubmitData('procurementplanmanagement/addmoreitemstoapausedprocurementplan.htm', 'content3', 'fanancialyearid=' + fanancialyearid + '&procurementname=' + tableData[1] + '&totalitemsincart=' + tableData[2] + '&ofst=1&maxR=100&sStr=', 'GET');
    }
    var updatedvalues = new Set();
    function updatepausedprocurementitemsvalues(id) {
        var ordtyp = $('#pausedordertype').val();
        document.getElementById('savechangesdiv').style.display = 'block';
        document.getElementById('okbtn').style.display = 'none';

        var tablerowid = $('#' + id).closest('tr').attr('id');
        var fields1 = tablerowid.split('-');
        var item1 = fields1[1];
        updatedvalues.add(item1);

        var fields = id.split('-');
        var type = fields[0];
        var posid = fields[1];
        var value = $('#' + id).text();
        if (value !== '' || value.length !== 0) {
            if (type === 'monthp' && ordtyp === 'Quarterly') {
                document.getElementById('annualp-' + posid).innerHTML = parseInt(value) * 3;
            } else if (type === 'monthp' && ordtyp === 'Annually') {
                document.getElementById('annualp-' + posid).innerHTML = parseInt(value) * 12;
            } else if (type === 'monthp' && ordtyp === 'Monthly') {
                document.getElementById('annualp-' + posid).innerHTML = parseInt(value) * 12;
            } else if (type === 'annualp' && ordtyp === 'Quarterly') {
                document.getElementById('monthp-' + posid).innerHTML = Math.round(parseInt(value) / 3);
            } else if (type === 'annualp' && ordtyp === 'Annually') {
                document.getElementById('monthp-' + posid).innerHTML = Math.round(parseInt(value) / 12);
            } else if (type === 'annualp' && ordtyp === 'Monthly') {
                document.getElementById('monthp-' + posid).innerHTML = Math.round(parseInt(value) / 12);
            } else {
            }
        }

    }
    var deleteitems = new Set();
    function removepausedprocurementitems(id) {
        $.confirm({
            title: 'Remove Item From Procurement Plan!',
            content: 'It Will Be Removed From The Procurement Plan List !!',
            icon: 'fa fa-warning',
            type: 'orange',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes, Remove',
                    btnClass: 'btn-orange',
                    action: function () {

                        var financialyrid = $('#removeorupdatefacilityunitprocurementitemsid').val();
                        $.ajax({
                            type: 'POST',
                            data: {itemid: id, facilityunitfinancialyearid: financialyrid},
                            url: "procurementplanmanagement/deleteprocurementitems.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {

                                    deleteitems.add(id);
                                    var tablerowid1 = $('#' + id).closest('tr').attr('id');
                                    $('#' + tablerowid1).remove();
                                } else {
                                    $.toast({
                                        heading: 'Error',
                                        text: 'An unexpected error occured while trying to Remove Item !!!!',
                                        icon: 'error',
                                        hideAfter: 2000,
                                        position: 'bottom-center'
                                    });
                                }

                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }

    function searchvaluestable() {
        var input, value;
        input = document.getElementById("searchvalue");
        value = input.value.toLowerCase().trim();
        $("#itemstosearchtbls tr").each(function (index) {
            if (!index)
                return;
            $(this).find("td").each(function () {
                var id = $(this).text().toLowerCase().trim();
                var not_found = (id.indexOf(value) === -1);
                $(this).closest('tr').toggle(!not_found);
                return not_found;
            });
        });
    }

    function saveupdatepausedprocurementplan(type) {
        var pausedordertype = $('#pausedordertype').val();
        var allitemsset = [];
        var tablebody = document.getElementById("pausedfacilityunitfinanacialsitems");
        var x = document.getElementById("pausedfacilityunitfinanacialsitems").rows.length;
        for (var i = 0; i < x; i++) {
            var row = tablebody.rows[i];
            var ids = row.id;
            var tableData = $('#' + ids).closest('tr')
                    .find('td')
                    .map(function () {
                        return $(this).text();
                    }).get();

            var fields = ids.split('-');
            var iditem = fields[1];
            if (pausedordertype === 'Quarterly') {
                allitemsset.push({
                    itemid: iditem,
                    monthly: tableData[2],
                    quarter: tableData[3]
                });
            } else {
                allitemsset.push({
                    itemid: iditem,
                    monthly: tableData[2],
                    annual: tableData[3]
                });
            }

        }
        var saveitemsupdates = [];
        if (type === 'ok') {
            var facilityfinancialyrsel = $('#facilityfinancialyrsel').val();
            window.location = '#close';
            ajaxSubmitData('procurementplanmanagement/pausedfinancialyearperiodstable.htm', 'pausedfinancialyearperiodstable', 'act=a&pausedprocurementfacilityyr=' + facilityfinancialyrsel + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
        } else if (type === 'save') {
            if (updatedvalues.size !== 0) {
                for (index in allitemsset) {
                    var response = allitemsset[index];

                    if (updatedvalues.has(response["itemid"])) {
                        if (pausedordertype === 'Quarterly') {
                            saveitemsupdates.push({
                                itemid: response["itemid"],
                                monthly: response["monthly"],
                                quarter: response["quarter"]
                            });
                        } else {
                            saveitemsupdates.push({
                                itemid: response["itemid"],
                                monthly: response["monthly"],
                                annual: response["annual"]
                            });
                        }


                    }
                }
                if (saveitemsupdates.length !== 0) {
                    var financialyrid = $('#removeorupdatefacilityunitprocurementitemsid').val();
                    $.ajax({
                        type: 'POST',
                        data: {values: JSON.stringify(saveitemsupdates), facilityunitfinancialyearid: financialyrid, pausedordertype: pausedordertype},
                        url: "procurementplanmanagement/saveprocurementplanupdates.htm",
                        success: function (data, textStatus, jqXHR) {
                            updatedvalues = [];
                            saveitemsupdates = [];
                            $.toast({
                                heading: 'Success',
                                text: 'Saved Successfully !!!',
                                icon: 'success',
                                hideAfter: 2000,
                                position: 'bottom-center'
                            });
                            document.getElementById('savechangesdiv').style.display = 'none';
                            document.getElementById('okbtn').style.display = 'block';
                            window.location = '#close';
                        }
                    });
                } else {

                }
            } else {
                document.getElementById('savechangesdiv').style.display = 'none';
                document.getElementById('okbtn').style.display = 'block';
                window.location = '#close';
            }
        } else {
        }

    }
</script>