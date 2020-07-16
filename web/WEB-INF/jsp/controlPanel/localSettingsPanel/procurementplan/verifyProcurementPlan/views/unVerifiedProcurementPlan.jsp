<%-- 
    Document   : unVerifiedProcurementPlan
    Created on : Apr 30, 2018, 6:05:19 PM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../../include.jsp" %>
<c:if test="${size <1}">
    <div class="row">
        <div class="col-md-12">
            <legend style="color: red;"> No  Un Verified Procurement plan In This Financial Year</legend>
        </div>
    </div>
</c:if>
<c:if test="${size >0}">
    <table class="table table-hover table-bordered" id="unverifiedprocuredfinancialyrs">
        <thead>
            <tr>
                <th>No</th>
                <th>Procurement Plan</th>
                <th>Item(s)</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Approve | Reject</th>
            </tr>
        </thead>
        <tbody>
        <input id="facilityfinancialyrid_approv" value="${facilityfinancialyearid}" type="hidden">
        <% int j = 1;%>
        <c:forEach items="${unprocuredfinancialyrs}" var="b">
            <tr>
                <td><%=j++%></td>
                <td>${b.facilityunitlabel}</td>
                <td align="center">
                    <button   title="Manage The Procurement Plan Items." class="btn btn-secondary btn-sm add-to-shelf">
                        ${b.financialyritemsRowcount} &nbsp; Item(s)
                    </button>
                </td>
                <td>${b.startdate}</td>
                <td>${b.enddate}</td>
                <td align="center">
                    <button onclick="getprocurementplanitems(${b.facilityunitfinancialyearid}, '${b.facilityunitlabel}', '${b.orderperiodtype}');"  title="Approve The Procurement Plan Items." class="btn btn-secondary btn-sm add-to-shelf">
                        <i class="fa fa-save"></i>
                    </button> | <button onclick="rejectfacilityunitprocurementolan(${b.facilityunitfinancialyearid});"  title="Reject The Procurement Plan." class="btn btn-secondary btn-sm add-to-shelf">
                        <i class="fa fa-ban"></i>
                    </button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<div class="row">
    <div class="col-md-12">
        <div id="procuredfacilityunitprocurementitems" class="supplierCatalogDialog procuredFacilityUnitProcurementItem">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="title6heading2"> Procurement Items</h2>
                    <hr>
                    <input id="selected_facility_unit_proc" type="hidden"> 
                    <input id="selected_facility_unit_proc_type" type="hidden">
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div id="">
                                    <div class="tile" id="procured_itemsfinancialyrtable">

                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <hr style="border:1px dashed #dddddd;">
                                                <button type="button"  onclick="saveandpauseprocurementplan();"class="btn btn-primary btn-block">Pause</button>
                                            </div>
                                            <div class="col-md-4">
                                                <hr style="border:1px dashed #dddddd;">
                                                <button type="button" onclick="saveandasapproved();"class="btn btn-primary btn-block">Approved</button>
                                            </div>
                                            <div class="col-md-4">
                                                <hr style="border:1px dashed #dddddd;">
                                                <button type="button" onclick="resetdata();" class="btn btn-secondary btn-block">Refresh</button>
                                            </div>   
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="approvedfacilityunitprocurementitems" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content" style="width: 100%;">
                            <div class="modal-header">
                                <h5 class="modal-title" id="title"> Approved Items</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div id="approvedfacilityunitprocurementitemDiv">
                                                    <p>Getting Items Please Wait................</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12" align="right"  >
                                                <button class="btn btn-primary" data-dismiss="modal">
                                                    <i class="fa fa-check-circle"></i>
                                                    Ok
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="Editfacilityunitprocurementitems" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content" style="width: 100%;">
                            <div class="modal-header">
                                <h5 class="modal-title" id="title"> Edit Item</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div id="EditfacilityunitprocurementitemDiv">
                                                    <p>Getting Items Please Wait................</p>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</c:if>

<script>
    function approveunapprovedfacilityunitprocurementplan(id) {
        var facilityunitfinancialyrid = $('#facilityunitfinancialyrid').val();
        $.confirm({
            title: 'Are You Sure?!',
            content: 'You Want To Approve This Plan',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityunitfinancialyearid: id, type: 'approve'},
                            url: "procurementplanmanagement/approveunapprovedfacilityunitprocurementplan.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    $.toast({
                                        heading: 'Success',
                                        text: 'Successfully Approved !!!!',
                                        icon: 'success',
                                        hideAfter: 3000,
                                        position: 'bottom-center'
                                    });
                                    ajaxSubmitData('procurementplanmanagement/unapprovedfacilityunitprocurementplans.htm', 'unapprovedfacilityunitprocurementplansdiv', 'act=a&selectprocurementfacilityyr=' + facilityunitfinancialyrid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                } else {
                                    $.toast({
                                        heading: 'Error',
                                        text: 'An Un Expected Error Occurred Try Again !!!!',
                                        icon: 'error',
                                        hideAfter: 3000,
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
    function rejectfacilityunitprocurementolan(id) {
        var facilityunitfinancialyrid = $('#facilityunitfinancialyrid').val();
        $.confirm({
            title: 'Reason!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Your Reason here</label>' +
                    '<input type="text" placeholder="Enter Reason" class="name form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var reason = this.$content.find('.name').val();
                        if (!reason) {
                            $.alert('provide a valid reason');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {facilityunitfinancialyearid: id, type: 'reject', reason: reason},
                            url: "procurementplanmanagement/approveunapprovedfacilityunitprocurementplan.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    $.toast({
                                        heading: 'Success',
                                        text: 'Successfully Approved !!!!',
                                        icon: 'success',
                                        hideAfter: 3000,
                                        position: 'bottom-center'
                                    });
                                    ajaxSubmitData('procurementplanmanagement/unapprovedfacilityunitprocurementplans.htm', 'unapprovedfacilityunitprocurementplansdiv', 'act=a&selectprocurementfacilityyr=' + facilityunitfinancialyrid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                } else {
                                    $.toast({
                                        heading: 'Error',
                                        text: 'An Un Expected Error Occurred Try Again !!!!',
                                        icon: 'error',
                                        hideAfter: 3000,
                                        position: 'bottom-center'
                                    });
                                }
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                },
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    function getprocurementplanitems(facilityunitfinancialyearid, label, type) {
        document.getElementById('selected_facility_unit_proc_type').value = type;
        document.getElementById('selected_facility_unit_proc').value = facilityunitfinancialyearid;
        document.getElementById('title6heading2').innerHTML = label + ' ' + 'procured Items';
        ajaxSubmitData('procurementplanmanagement/verifyfacilityunitprocurementplanitemsview.htm', 'procured_itemsfinancialyrtable', 'act=a&facilityunitfinancialyearid=' + facilityunitfinancialyearid + '&type=' + type + '&ofst=1&maxR=100&sStr=', 'GET');
        window.location = '#procuredfacilityunitprocurementitems';
        initDialog('procuredFacilityUnitProcurementItem');

    }
    function resetdata() {
        itemscheck.clear();
        var type = $('#selected_facility_unit_proc_type').val();
        var facilityunitprocurementid = $('#selected_facility_unit_proc').val();
        ajaxSubmitData('procurementplanmanagement/verifyfacilityunitprocurementplanitemsview.htm', 'procured_itemsfinancialyrtable', 'act=a&facilityunitfinancialyearid=' + facilityunitprocurementid + '&type=' + type + '&ofst=1&maxR=100&sStr=', 'GET');
    }
    var itemscheck = new Set();
    function addorremoveitem(value) {

        if (!itemscheck.has(value)) {
            itemscheck.add(value);
        } else {
            itemscheck.delete(value);
        }
        $('#itemsremovedcount').html(itemscheck.size);
        if (itemscheck.size === 0) {
            document.getElementById('itemsrevoeddiv').style.display = 'none';
        } else {
            document.getElementById('itemsrevoeddiv').style.display = 'block';
        }

    }

    function approvefacilityunitprocurementplanremoveitem(itemid) {
        var procurementidappr = $('#selected_facility_unit_proc').val();
        var type = $('#selected_facility_unit_proc_type').val();
        $.confirm({
            title: 'Reason!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Your Reason here</label>' +
                    '<input type="text" placeholder="Enter Reason" class="name form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var reason = this.$content.find('.name').val();
                        if (!reason) {
                            $.alert('provide a valid reason');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {facilityunitfinancialyearid: procurementidappr, reason: reason, type: 'reject', itemid: itemid},
                            url: "procurementplanmanagement/rejectormodifiedfacilityunitprocurementplanitem.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    ajaxSubmitData('procurementplanmanagement/verifyfacilityunitprocurementplanitemsview.htm', 'procured_itemsfinancialyrtable', 'act=a&facilityunitfinancialyearid=' + procurementidappr + '&type=' + type + '&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                },
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    var itemstosaveandpause = [];
    var itemsmodified = [];
    var modifiedvalues = new Set();
    function saveandpauseprocurementplan() {
        var typeproc = $('#selected_facility_unit_proc_type').val();
        var procurementidappr = $('#selected_facility_unit_proc').val();
        var facilityfinancialyearid = $('#facilityfinancialyrid_approv').val();

        if (modifiedvalues.size !== 0) {
            var tablebody = document.getElementById("approveprocurementplantable");
            var x = document.getElementById("approveprocurementplantable").rows.length;
            for (var i = 0; i < x; i++) {
                var row = tablebody.rows[i];
                var ids = row.id;
                var tableData = $('#' + ids).closest('tr')
                        .find('td')
                        .map(function () {
                            return $(this).text();
                        }).get();
                if (typeproc === 'Quarterly') {
                    itemstosaveandpause.push({
                        itemid: ids,
                        monthly: tableData[3],
                        quarter: tableData[4]
                    });
                } else {
                    itemstosaveandpause.push({
                        itemid: ids,
                        monthly: tableData[3],
                        annual: tableData[4]
                    });
                }

            }
            for (index in itemstosaveandpause) {
                var items = itemstosaveandpause[index];
                if (modifiedvalues.has(items["itemid"]) && !itemscheck.has(items["itemid"])) {
                    if (typeproc === 'Quarterly') {
                        itemsmodified.push({
                            itemid: items["itemid"],
                            monthly: items["monthly"],
                            quarter: items["quarter"]
                        });
                    } else {
                        itemsmodified.push({
                            itemid: items["itemid"],
                            monthly: items["monthly"],
                            annual: items["annual"]
                        });
                    }

                }
            }
            $.ajax({
                type: 'POST',
                data: {values: JSON.stringify(itemsmodified), procurementid: procurementidappr, type: 'partial', typeperiod: typeproc},
                url: "procurementplanmanagement/saveorupdateorrejectandorpausefacilityunitprocurementplan.htm",
                success: function (data, textStatus, jqXHR) {
                    $.toast({
                        heading: 'Success',
                        text: 'Successfully Saved !!!',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    window.location = '#close';
                    ajaxSubmitData('procurementplanmanagement/unapprovedfacilityunitprocurementplans.htm', 'unapprovedfacilityunitprocurementplansdiv', 'act=a&selectprocurementfacilityyr=' + facilityfinancialyearid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });

        } else {
            $.ajax({
                type: 'POST',
                data: {facilityunitfinancialyearid: procurementidappr, type: 'partial'},
                url: "procurementplanmanagement/approveunapprovedfacilityunitprocurementplan.htm",
                success: function (data, textStatus, jqXHR) {
                    $.toast({
                        heading: 'Success',
                        text: 'Successfully Saved !!!',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    window.location = '#close';
                    ajaxSubmitData('procurementplanmanagement/unapprovedfacilityunitprocurementplans.htm', 'unapprovedfacilityunitprocurementplansdiv', 'act=a&selectprocurementfacilityyr=' + facilityfinancialyearid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        }
    }

    var approveCounting = 0;
    function readditem(type2, itemid, id) {
        document.getElementById('overlayedt').style.display='block';
        var procurementidappr = $('#selected_facility_unit_proc').val();
        var type = $('#selected_facility_unit_proc_type').val();
        if (type2 === 'activate') {
            $.ajax({
                type: 'POST',
                data: {facilityunitfinancialyearid: procurementidappr, type: 'readd', itemid: itemid},
                url: "procurementplanmanagement/rejectormodifiedfacilityunitprocurementplanitem.htm",
                success: function (data, textStatus, jqXHR) {
                    document.getElementById('overlayedt').style.display='none';
                    approveCounting = approveCounting + 1;
                    if (approveCounting === 10) {
                        ajaxSubmitData('procurementplanmanagement/verifyfacilityunitprocurementplanitemsview.htm', 'procured_itemsfinancialyrtable', 'act=a&facilityunitfinancialyearid=' + procurementidappr + '&type=' + type + '&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
                
            });
        } else {
            $.ajax({
                type: 'POST',
                data: {facilityunitfinancialyearid: procurementidappr, type: 'reject', itemid: itemid},
                url: "procurementplanmanagement/rejectormodifiedfacilityunitprocurementplanitem.htm",
                success: function (data, textStatus, jqXHR) {
                  document.getElementById('overlayedt').style.display='none';  
                }
            });
        }

    }
    function saveandasapproved() {
        var typeproc = $('#selected_facility_unit_proc_type').val();
        var procurementidappr = $('#selected_facility_unit_proc').val();
        var facilityfinancialyearid = $('#facilityfinancialyrid_approv').val();
        $.confirm({
            title: 'Approved Procurement Plan!',
            content: 'Are You Sure You Have Approved This Procurement Plan Items?',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityunitfinancialyearid: procurementidappr, type: 'approve'},
                            url: "procurementplanmanagement/approveunapprovedfacilityunitprocurementplan.htm",
                            success: function (data, textStatus, jqXHR) {
                                $.toast({
                                    heading: 'Success',
                                    text: 'Successfully Saved !!!',
                                    icon: 'success',
                                    hideAfter: 2000,
                                    position: 'bottom-center'
                                });
                                window.location = '#close';
                                ajaxSubmitData('procurementplanmanagement/unapprovedfacilityunitprocurementplans.htm', 'unapprovedfacilityunitprocurementplansdiv', 'act=a&selectprocurementfacilityyr=' + facilityfinancialyearid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });

    }
    function approvedfacilityunitprocurementitem() {
        $('#approvedfacilityunitprocurementitems').modal('show');
        var procurementidappr = $('#selected_facility_unit_proc').val();
        var type = $('#selected_facility_unit_proc_type').val();
        ajaxSubmitData('procurementplanmanagement/approvedfacilityunitprocurementitems.htm', 'approvedfacilityunitprocurementitemDiv', 'act=a&facilityunitfinancialyearid=' + procurementidappr + '&type=' + type + '&ofst=1&maxR=100&sStr=', 'GET');
    }
    function edititemandapprove(type, facilityunitprocurementplanid, genericname, quarterormonth, averagemonthlyconsumption) {
        $('#Editfacilityunitprocurementitems').modal('show');
        ajaxSubmitData('procurementplanmanagement/editfacilityunitprocurementitems.htm', 'EditfacilityunitprocurementitemDiv', 'act=a&facilityunitprocurementplanid=' + facilityunitprocurementplanid + '&type=' + type + '&genericname=' + genericname + '&quarterormonth=' + quarterormonth + '&averagemonthlyconsumption=' + averagemonthlyconsumption, 'GET');
    }
    function savebtnedittedonapprovedproc(facilityunitprocurementplanid) {
        var type = $('#selected_facility_unit_proc_type').val();
        var procurementidappr = $('#selected_facility_unit_proc').val();
        var monthly = $('#EdtapprditemsQty').val();
        var othervalues = 0;
        if (type === 'Quarterly') {
            othervalues = $('#EdtapprdquarterQty').val();
        } else {
            othervalues = $('#EdtapprvdAnnuallyQty').val();
        }
        $.ajax({
            type: 'POST',
            data: {monthly: monthly, type: type, othervalues: othervalues, facilityunitprocurementplanid: facilityunitprocurementplanid},
            url: "procurementplanmanagement/editprocurementunitplan.htm",
            success: function (data, textStatus, jqXHR) {
                ajaxSubmitData('procurementplanmanagement/verifyfacilityunitprocurementplanitemsview.htm', 'procured_itemsfinancialyrtable', 'act=a&facilityunitfinancialyearid=' + procurementidappr + '&type=' + type + '&ofst=1&maxR=100&sStr=', 'GET');

            }
        });
    }
</script>