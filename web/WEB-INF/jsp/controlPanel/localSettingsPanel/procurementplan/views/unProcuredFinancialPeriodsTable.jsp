<%-- 
    Document   : unProcuredFinancialPeriodsTable
    Created on : Apr 30, 2018, 11:26:02 AM
    Author     : RESEARCH
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<c:if test="${size <1}">
    <div class="row">
        <div class="col-md-12">
            <legend style="color: red;"> No Procurement plan In This Financial Year</legend><br>
            <button id="generatefacilityunitprocurementbtn" onclick="generatefacilityunitprocurementplan(this.id);" class="btn btn-primary" type="button" ><i class="fa fa-fw fa-lg fa-check-circle"></i>Compose</button>
        </div>
    </div>
</c:if>
<input id="facilityfinancialyearidselct" value="${facilityfinancialyearid}" type="hidden">
<c:if test="${size >0}">
    <table class="table table-hover table-bordered" id="unprocuredfinancialyrs">
        <thead>
            <tr>
                <th>No</th>
                <th>Procurement Plan</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th align="center">Add Items | Import</th>
            </tr>
        </thead>
        <tbody>
            <% int j = 1;%>
            <c:forEach items="${unprocuredfinancialyrs}" var="b">
                <tr>
                    <td><%=j++%></td>
                    <td>${b.facilityunitlabel}</td>
                    <td>${b.startdate}</td>
                    <td>${b.enddate}</td>
                    <td align="center">
                        <button onclick="additemsintoprocurementplan(${b.facilityunitfinancialyearid}, '${b.orderperiodtype}');"  title="Add Items Into The Procurement Plan." class="btn btn-primary btn-sm add-to-shelf">
                            <i class="fa fa-plus"></i>
                        </button> | <button onclick="importitemfromfinancialyrs(${b.facilityunitfinancialyearid});"  title="Import From Previous Financial Years." class="btn btn-secondary btn-sm add-to-shelf">
                            <i class="fa fa-share"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>

<div class="row">
    <div class="col-md-12">
        <div id="importfromprocuredfinancialyears" class="modalDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: none;">X</a>
                    <h2 class="modalDialog-title" id="titleorheading">Import From Procured Financial Year</h2>
                    <hr>
                    <div id="selectfacilityfinancialyrsid">
                        <div class="form-group row">
                            <label class="control-label col-md-4">Procurement Plan For Financial Year:</label>
                            <div class="col-md-6">
                                <select class="form-control" id="selectfinancialyrtoimportfrmid">
                                </select>    
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <input id="importintofinancialyearid" type="hidden">
                                <div id="editfacilityunitprocurementitems">
                                    <div class="tile" id="noprocuredfinancialyrid" style="display: none;">
                                        <p style="color: red;" >No Procured Financial Year </p>
                                    </div>
                                    <div class="tile" id="lastprocuredfinancialyrs">
                                        <table class="table table-hover table-bordered" id="impfnys">
                                            <thead>
                                                <tr>
                                                    <th>No</th>
                                                    <th>Financial Year</th>
                                                    <th>View Items</th>
                                                    <th>Select</th>
                                                </tr>
                                            </thead>
                                            <tbody id="importfinancialyrtable">
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-4"></div>
                                            <div class="col-md-4">
                                                <hr style="border:1px dashed #dddddd;">
                                                <button type="button" id="importfnyrbtn"  onclick="importfacilityunitfinancialyearsitems();"class="btn btn-primary btn-block">Import</button>
                                            </div>
                                            <div class="col-md-4">
                                                <hr style="border:1px dashed #dddddd;">
                                                <button type="button" onclick="canceladdingitemstoProc();" class="btn btn-secondary btn-block">Cancel</button>
                                            </div>   
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="financialyearsitemsview" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content" style="width: 100%;">
                            <div class="modal-header">
                                <h5 class="modal-title" id="title"> Financial Year Items</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div id="fnyItemsViewDiv">
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
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="additemsintoprocurementplan" class="modalDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Add Items</h2>
                    <hr>
                    <div class="row">
                        <div class="col-md-2">
                        </div>
                        <div class="col-md-8">
                            <div class="tile-body">
                                <div id="search-form_3">
                                    <input id="itemsSearch" type="text" oninput="searchItems()" placeholder="Search Item" onfocus="searchItems()" class="search_3 dropbtn"/>
                                </div>
                                <div id="myDropdowns" class="search-content">

                                </div><br>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <input id="facilityunitfinancialprocurementorderperiodtype" type="hidden">
                            <input id="facilityunitfinancialprocurementid" type="hidden">
                        </div>
                    </div>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <h4 class="tile-title">Entered Items.</h4>
                                    <table class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>Item Name</th>
                                                <th>Monthly Need</th>
                                                <th id="ordprdtyp">Quarter Need</th>
                                                <th>Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody id="entereditemsTableBody">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <hr style="border:1px dashed #dddddd;">
                                            <button type="button"  onclick="addtopause();"class="btn btn-primary btn-block">Add & Pause</button>
                                        </div>   
                                        <div class="col-sm-4">
                                            <hr style="border:1px dashed #dddddd;">
                                            <button type="button" onclick="addandsubmitprocurementplan();" class="btn btn-primary btn-block">Add & Submit</button>
                                        </div> 
                                        <div class="col-sm-4">
                                            <hr style="border:1px dashed #dddddd;">
                                            <button type="button" onclick="canceladdingitemstoProc();" class="btn btn-secondary btn-block">Cancel</button>
                                        </div> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="add_search_items" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content" style="width: 100%;">
                            <div class="modal-header">
                                <h5 class="modal-title" id="title">Enter item Details</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div id="returninputfieldsdiv">

                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12" align="right"  >
                                                <button class="btn btn-primary" type="submit" onclick="additemsprocurem();" id="additemprocurem">
                                                    <i class="fa fa-check-circle"></i>
                                                    Add Item
                                                </button>
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
<script>
    $('#unprocuredfinancialyrs').DataTable();
    $('#impfnys').DataTable();
    function generatefacilityunitprocurementplan(id) {
        var financialyear = $('#facilityfinancialyearidselct').val();
        $.ajax({
            type: 'POST',
            data: {financialyear: financialyear},
            url: "procurementplanmanagement/generatefacilityunitprocurementplan.htm",
            success: function (data, textStatus, jqXHR) {
                if (data === 'created') {
                    document.getElementById(id).disabled=true;  
                    $.confirm({
                        title: 'Compose Procurement Plan!',
                        content: 'Procurement Plan For This Financial Year Already Composed !!!',
                        type: 'red',
                        icon: 'fa fa-warning',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Close',
                                btnClass: 'btn-red',
                                action: function () {
                                  
                                }
                            }
                        }
                    });
                } else {
                    ajaxSubmitData('procurementplanmanagement/unprocuredfinancialyearperiodstable.htm', 'unprocuredfinancialyearperiodstable', 'act=a&selectprocurementfacilityyr=' + financialyear + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            }
        });
    }
    var itemsaddedtoprocurement = new Set();
    function additemsintoprocurementplan(id, orderperiodtype) {
        document.getElementById('facilityunitfinancialprocurementid').value = id;
        document.getElementById('facilityunitfinancialprocurementorderperiodtype').value = orderperiodtype;
        document.getElementById('ordprdtyp').innerHTML = orderperiodtype + ' ' + 'Needed';
        window.location = '#additemsintoprocurementplan';
        initDialog('modalDialog');
    }
    function displaysSearchResults() {
        document.getElementById("myDropdowns").classList.add("showSearch");
    }
    function searchItems() {
        displaysSearchResults();
        var name = $('#itemsSearch').val();
        if (name.length >= 3) {
            if (itemsaddedtoprocurement.size > 0) {
                ajaxSubmitDataNoLoader('procurementplanmanagement/searchItems.htm', 'myDropdowns', 'type=withid&itemsonprocurement=' + JSON.stringify(Array.from(itemsaddedtoprocurement)) + '&name=' + name, 'GET');
            } else {
                ajaxSubmitDataNoLoader('procurementplanmanagement/searchItems.htm', 'myDropdowns', 'type=withoutid&name=' + name, 'GET');
            }
        } else {
            $('#myDropdowns').html('');
        }
    }
    window.onclick = function (event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("search-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('showSearch')) {
                    openDropdown.classList.remove('showSearch');
                }
            }
        }
    };
    var count = 0;
    function additemsprocurem() {
        count++;
        var itemsQty = $('#itemsQty').val();
        var quarterQty = $('#quarterQty').val();
        var itemsid = $('#itemsid').val();
        var itemsname = $('#itemsname').val();
        if (parseInt(itemsQty) !== 0 && parseInt(quarterQty) !== 0) {
            $('#entereditemsTableBody').append('<tr id="itms-' + itemsid + '"><td>' + count + '</td>' +
                    '<td>' + itemsname + '</td>' +
                    '<td class="eitted" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;-moz-border-radius: ;" id="month-' + count + '" onkeyup="updatemonthorquarter(this.id);">' + itemsQty + '</td>' +
                    '<td class="eitted" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;-moz-border-radius: ;" id="annual-' + count + '" onkeyup="updatemonthorquarter(this.id);">' + quarterQty + '</td>' +
                    '<td align="center"><button onclick="removefacilityunititem(this.id);" id="ups' + count + '" title="Remove Item From Items To List." class="btn btn-primary btn-sm"><i class="fa fa-remove"></i> </button></td></tr>');
            document.getElementById('enteritemdetailsform').reset();
            document.getElementById('itemsSearch').focus();
            $('#add_search_items').modal('hide');
            itemsaddedtoprocurement.add(itemsid);
        }
    }

    function updatemonthorquarter(id) {
        var fields = id.split('-');
        var type = fields[0];
        var posid = fields[1];
        var value = $('#' + id).text();
        if (value !== '' || value.length !== 0) {
            if (type === 'month') {
                document.getElementById('annual-' + posid).innerHTML = parseInt(value) * 3;
            } else {
                document.getElementById('month-' + posid).innerHTML = Math.round(parseInt(value) / 3);
            }
        }

    }
    function removefacilityunititem(id) {
        var tablerowid = $('#' + id).closest('tr').attr('id');
        var fields = tablerowid.split('-');
        var itemid = fields[1];
        itemsaddedtoprocurement.delete(itemid);
        $('#' + tablerowid).remove();
    }
    function addtopause() {
        var orderperiodtype = $('#facilityunitfinancialprocurementorderperiodtype').val();
        var procurementitms = [];
        var table = document.getElementById("entereditemsTableBody");
        var x = document.getElementById("entereditemsTableBody").rows.length;
        for (var i = 0; i < x; i++) {
            var row = table.rows[i];
            var ids = row.id;
            var tableData = $('#' + ids).closest('tr')
                    .find('td')
                    .map(function () {
                        return $(this).text();
                    }).get();
            var fields = ids.split('-');
            var iditem = fields[1];
            if (orderperiodtype === 'Quarterly') {
                procurementitms.push({
                    itemid: iditem,
                    monthly: tableData[2],
                    quarter: tableData[3]
                });
            } else {
                procurementitms.push({
                    itemid: iditem,
                    monthly: tableData[2],
                    annual: tableData[3]
                });
            }

        }
        var procurementid = $('#facilityunitfinancialprocurementid').val();
        var facilityfinancialyearid = $('#facilityfinancialyearidselct').val();
        if (procurementitms.length !== 0) {
            $.ajax({
                type: 'POST',
                data: {values: JSON.stringify(procurementitms), procurementid: procurementid, type: 'paused', orderperiodtype: orderperiodtype},
                url: "procurementplanmanagement/saveandorsubmitprocurementplan.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'success') {
                        window.location = '#close';
                        procurementitms = [];
                        $.toast({
                            heading: 'Success',
                            text: 'Successfully Saved !!!!!',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        ajaxSubmitData('procurementplanmanagement/unprocuredfinancialyearperiodstable.htm', 'unprocuredfinancialyearperiodstable', 'act=a&selectprocurementfacilityyr=' + facilityfinancialyearid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'An Unexpected Error Occurred Try Again !!!!!',
                            icon: 'error',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                    }
                }
            });
        } else {
            $.toast({
                heading: 'Error',
                text: 'First Add Items Before Saving !!!!',
                icon: 'error',
                hideAfter: 2000,
                position: 'bottom-center'
            });
        }
    }
    function addandsubmitprocurementplan() {
        var orderperiodtype = $('#facilityunitfinancialprocurementorderperiodtype').val();
        var procurementitms = [];
        var table = document.getElementById("entereditemsTableBody");
        var x = document.getElementById("entereditemsTableBody").rows.length;
        for (var i = 0; i < x; i++) {
            var row = table.rows[i];
            var ids = row.id;
            var tableData = $('#' + ids).closest('tr')
                    .find('td')
                    .map(function () {
                        return $(this).text();
                    }).get();
            var fields = ids.split('-');
            var iditem = fields[1];
            if (orderperiodtype === 'Quarterly') {
                procurementitms.push({
                    itemid: iditem,
                    monthly: tableData[2],
                    quarter: tableData[3]
                });
            } else {
                procurementitms.push({
                    itemid: iditem,
                    monthly: tableData[2],
                    annual: tableData[3]
                });
            }

        }
        var procurementid = $('#facilityunitfinancialprocurementid').val();
        var facilityfinancialyearid = $('#facilityfinancialyearidselct').val();
        if (procurementitms.length !== 0) {
            $.ajax({
                type: 'POST',
                data: {values: JSON.stringify(procurementitms), procurementid: procurementid, type: 'submit', orderperiodtype: orderperiodtype},
                url: "procurementplanmanagement/saveandorsubmitprocurementplan.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'success') {
                        procurementitms = [];
                        window.location = '#close';
                        $.toast({
                            heading: 'Success',
                            text: 'Successfully Saved !!!!!',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        ajaxSubmitData('procurementplanmanagement/unprocuredfinancialyearperiodstable.htm', 'unprocuredfinancialyearperiodstable', 'act=a&selectprocurementfacilityyr=' + facilityfinancialyearid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'An Unexpected Error Occurred Try Again !!!!!',
                            icon: 'error',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                    }
                }
            });
        } else {
            $.toast({
                heading: 'Error',
                text: 'First Add Items Before Saving !!!!',
                icon: 'error',
                hideAfter: 5000,
                position: 'bottom-center'
            });
        }
    }
    $('#selectfinancialyrtoimportfrmid').change(function () {
        var facilityfinancialyearid = $('#selectfinancialyrtoimportfrmid').val();
        $.ajax({
            type: 'POST',
            data: {type: 'facilityunitprocurementplan', facilityfinancialyearid: facilityfinancialyearid},
            url: "procurementplanmanagement/getpastfinancialyearstoimportfrom.htm",
            success: function (data, textStatus, jqXHR) {
                $('#importfinancialyrtable').html('');
                var response = JSON.parse(data);
                if (response.length !== 0) {
                    var number = 0;
                    for (index in response) {
                        number++;
                        var resp = response[index];
                        $('#importfinancialyrtable').append('<tr id="row' + resp["facilityunitfinancialyearid"] + '"><td>' + number + '</td>' +
                                '<td>' + resp["facilityunitlabel"] + '</td>' +
                                '<td align="center"><button onclick="viewfacilityunitprocurementitems(' + resp["facilityunitfinancialyearid"] + ',' + '\'' + resp["orderperiodtype"] + '\');"  title="View  The Procurement Plan Items." class="btn btn-secondary btn-sm add-to-shelf">' + resp["financialyunitritemsRowcount"] + ' Items </button></td>' +
                                '<td align="center"><input value="' + resp["facilityunitfinancialyearid"] + '" type="checkbox" onChange="if(this.checked){addingtofacilityunitimportslist(1,this.value,this.id,\'' + resp["orderperiodtype"] + '\');}else{addingtofacilityunitimportslist(0,this.value,this.id,\'' + resp["orderperiodtype"] + '\');}" id="num' + number + '"></td></tr>');
                    }
                }
            }
        });
    });
    function importitemfromfinancialyrs(id) {
        document.getElementById('importintofinancialyearid').value = id;
        $.ajax({
            type: 'POST',
            data: {type: 'getfinancialyrs'},
            url: "procurementplanmanagement/getpastfinancialyearstoimportfrom.htm",
            success: function (data, textStatus, jqXHR) {
                $('#selectfinancialyrtoimportfrmid').html('');
                var response = JSON.parse(data);
                if (response.length !== 0) {
                    document.getElementById('noprocuredfinancialyrid').style.display = 'none';
                    document.getElementById('lastprocuredfinancialyrs').style.display = 'block';
                    document.getElementById('importfnyrbtn').disabled = false;
                    for (index in response) {
                        var results = response[index];
                        $('#selectfinancialyrtoimportfrmid').append('<option value="' + results["facilityfinancialyearid"] + '">' + results["financialyear"] + '</option>');
                    }
                    var facilityfinancialyearid = $('#selectfinancialyrtoimportfrmid').val();
                    $.ajax({
                        type: 'POST',
                        data: {type: 'facilityunitprocurementplan', facilityfinancialyearid: facilityfinancialyearid},
                        url: "procurementplanmanagement/getpastfinancialyearstoimportfrom.htm",
                        success: function (data, textStatus, jqXHR) {
                            $('#importfinancialyrtable').html('');
                            var response = JSON.parse(data);
                            if (response.length !== 0) {
                                var number = 0;
                                for (index in response) {
                                    number++;
                                    var resp = response[index];
                                    $('#importfinancialyrtable').append('<tr id="row' + resp["facilityunitfinancialyearid"] + '"><td>' + number + '</td>' +
                                            '<td>' + resp["facilityunitlabel"] + '</td>' +
                                            '<td align="center"><button onclick="viewfacilityunitprocurementitems(' + resp["facilityunitfinancialyearid"] + ',' + '\'' + resp["orderperiodtype"] + '\');"  title="View  The Procurement Plan Items." class="btn btn-secondary btn-sm add-to-shelf">' + resp["financialyunitritemsRowcount"] + ' Items </button></td>' +
                                            '<td align="center"><input value="' + resp["facilityunitfinancialyearid"] + '" type="checkbox" onChange="if(this.checked){addingtofacilityunitimportslist(1,this.value,this.id,\'' + resp["orderperiodtype"] + '\');}else{addingtofacilityunitimportslist(0,this.value,this.id,\'' + resp["orderperiodtype"] + '\');}" id="num' + number + '"></td></tr>');
                                }
                            }
                        }
                    });
                } else {
                    document.getElementById('noprocuredfinancialyrid').style.display = 'block';
                    document.getElementById('lastprocuredfinancialyrs').style.display = 'none';
                    document.getElementById('importfnyrbtn').disabled = true;
                }
            }
        });
        window.location = '#importfromprocuredfinancialyears';
        initDialog('modalDialog');
    }
    function canceladdingitemstoProc() {
        $('#entereditemsTableBody').html('');
        $('#importfinancialyrtable').html('');
        var facilityfinancialyearidselct = $('#facilityfinancialyearidselct').val();
        window.location = '#close';
        ajaxSubmitData('procurementplanmanagement/unprocuredfinancialyearperiodstable.htm', 'unprocuredfinancialyearperiodstable', 'act=a&selectprocurementfacilityyr=' + facilityfinancialyearidselct + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function viewfacilityunitprocurementitems(facilityunitfinancialyearid, type) {
        $('#fnyItemsViewDiv').html(' <p>Getting Items Please Wait................</p>');
        $('#financialyearsitemsview').modal('show');
        ajaxSubmitData('procurementplanmanagement/viewfacilityunitprocurementitemstable.htm', 'fnyItemsViewDiv', 'type=' + type + '&facilityunitfinancialyearid=' + facilityunitfinancialyearid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    var orderperiodtype = '';
    var importprocurementplan = new Set();
    function addingtofacilityunitimportslist(type, value, id, orderperiod) {
        if (type === 1) {
            if (importprocurementplan.size === 0) {
                orderperiodtype = orderperiod;
                importprocurementplan.add(value);
            } else {
                $('#' + id).prop('checked', false);
                $.confirm({
                    title: 'Import!',
                    icon: 'fa fa-warning',
                    content: 'You Can Only Import From One Procurement Plan !!',
                    type: 'orange',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Ok',
                            btnClass: 'btn-orange',
                            action: function () {
                            }
                        },
                        close: function () {
                        }
                    }
                });
            }
        } else {
            if (importprocurementplan.has(value)) {
                orderperiodtype = '';
                importprocurementplan.delete(value);
            }
        }
    }
    function importfacilityunitfinancialyearsitems() {
        if (importprocurementplan.size !== 0 && orderperiodtype !== '') {
            document.getElementById('titleorheading').innerHTML = 'Edit Or Import Items From Selected Procurement Plan';
            document.getElementById('selectfacilityfinancialyrsid').style.display = 'none';
            document.getElementById('editfacilityunitprocurementitems').innerHTML = 'Getting Items Please Wait .........'
            var importintofacilityunitfinancialyearid = $('#importintofinancialyearid').val();
            ajaxSubmitData('procurementplanmanagement/editandimportfacilityunitprocurementplanitems.htm', 'editfacilityunitprocurementitems', 'importtofacilityunitfinancialyearid=' + importintofacilityunitfinancialyearid + '&values=' + JSON.stringify(Array.from(importprocurementplan)) + '&orderperiodtype=' + orderperiodtype + '&maxR=100&sStr=', 'GET');
        } else {
            $.confirm({
                title: 'Import!',
                icon: 'fa fa-warning',
                content: 'Select Procurement Plan To Import Items From!!',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Ok',
                        btnClass: 'btn-red',
                        action: function () {
                        }
                    },
                    close: function () {
                    }
                }
            });
        }
    }
</script>