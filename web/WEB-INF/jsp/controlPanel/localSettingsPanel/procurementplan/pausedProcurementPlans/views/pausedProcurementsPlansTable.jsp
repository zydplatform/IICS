<%-- 
    Document   : pausedProcurementsPlansTable
    Created on : May 3, 2018, 9:14:59 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<input id="facilityfinancialyrsel" value="${pausedprocurementfacilityyr}" type="hidden">
<!DOCTYPE html>
<table class="table table-hover table-bordered" id="pausedprcmentplans">
    <thead>
        <tr>
            <th>No</th>
            <th>Procurement Plan</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Items | Add Items</th>
            <th>Submit | Delete All Items</th>
        </tr>
    </thead>
    <tbody id="finanacialsitems">
        <% int j = 1;%>
        <% int i = 1;%>
        <% int p = 1;%>
        <% int k = 1;%>
        <c:forEach items="${facilityunitprocurementplans}" var="a">
            <tr id="up<%=i++%>-${a.facilityunitfinancialyearid}">
                <td><%=j++%></td>
                <td>${a.facilityunitlabel}</td>
                <td>${a.startdate}</td>
                <td>${a.enddate}</td>
                <td align="center">
                    <button onclick="pausedfacilityunitprocurementplanitems(${a.facilityunitfinancialyearid}, '${a.facilityunitlabel}', '${a.orderperiodtype}');"  title="Items In The Procurement Plan." class="btn btn-secondary btn-sm add-to-shelf">
                        ${a.financialyritemsRowcount} Items
                    </button> 
                    | 
                    <button onclick="pausedfacilityunitprocurementadditems(${a.facilityunitfinancialyearid}, '${a.facilityunitlabel}', '${a.orderperiodtype}');"  title="Add Items The Procurement Plan." class="btn btn-primary btn-sm add-to-shelf">
                        <i class="fa fa-plus"></i>
                    </button>
                </td>
                <td align="center">
                    <button onclick="submitfacilityunitprocurementplan(${a.facilityunitfinancialyearid}, 'submit');"  title="Submit The Procurement Plan." class="btn btn-primary btn-sm add-to-shelf">
                        <i class="fa fa-send"></i>
                    </button> 
                    | 
                    <button onclick="submitfacilityunitprocurementplan(${a.facilityunitfinancialyearid}, 'delete');"  title=" Delete The Procurement Plan." class="btn btn-secondary btn-sm add-to-shelf">
                        <i class="fa fa-remove"></i>
                    </button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table><br>
<c:if test="${size==0}">
    <p style="color: red;">No Paused Or Partially Done Procurement Plan !!</p>  
</c:if>
<div class="row">
    <div class="col-md-12">
        <div id="pausedadditemsintoprocurementplan" class="supplierCatalogDialog addPausedItems">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="add_items_pausedprocurement">Add Items</h2>
                    <hr>
                    <div class="row scrollbar" id="contents">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <div class="tile-body">
                                <div id="search-form_3">
                                    <input id="pauseditemsSearch" type="text" oninput="pausedsearchItems()" placeholder="Search Item" onfocus="pausedsearchItems()" class="search_3 dropbtn"/>
                                </div>
                                <div id="myDropdowns2" class="search-content">

                                </div><br>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <input id="pausedunitfinancialprocurementorderperiodtype" type="hidden">
                            <input id="pausedfacilityunitfinancialprocurementid" type="hidden">
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
                                                <th id="ordprdtyp2">Quarter Need</th>
                                                <th>Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody id="entereditemsTableBody2">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <hr style="border:1px dashed #dddddd;">
                                            <button type="button"  onclick="pausedfacilityuntaddtopause();"class="btn btn-primary btn-block">Add & Pause</button>
                                        </div>   
                                        <div class="col-sm-4">
                                            <hr style="border:1px dashed #dddddd;">
                                            <button type="button" onclick="pausedfacilityuntaddandsubmitprocurementplan();" class="btn btn-primary btn-block">Add & Submit</button>
                                        </div> 
                                        <div class="col-sm-4">
                                            <hr style="border:1px dashed #dddddd;">
                                            <button type="button" onclick="cancelpausedadditemstoProc();" class="btn btn-secondary btn-block">Cancel</button>
                                        </div> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="pausedadd_search_items" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
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
                                                <div id="pausedreturninputfieldsdiv">

                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12" align="right"  >
                                                <button class="btn btn-primary" type="submit" onclick="pausedadditemsprocurem();" id="additemprocurem">
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
<div class="row">
    <div class="col-md-12">
        <input id="removeorupdatefacilityunitprocurementitemsid" type="hidden">
        <div id="facilityunitprocurementplanitemsview" class="supplierCatalogDialog procurementplanPausedItems">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: none;">X</a>
                    <h2 class="modalDialog-title" id="pausedtitle">Procurement Plan Items</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div id="pausedfnyItemsViewDiv">
                                        <p>Getting Items Please Wait................</p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">

                                        <div class="col-sm-4">
                                            <div id="okbtn">
                                                <hr style="border:1px dashed #dddddd;">
                                                <button type="button"  onclick="saveupdatepausedprocurementplan('ok');"class="btn btn-primary btn-block">Ok</button>
                                            </div>
                                        </div>   
                                        <div class="col-sm-4">
                                            <div id="savechangesdiv" style="display: none;">
                                                <hr style="border:1px dashed #dddddd;">
                                                <button type="button" onclick="saveupdatepausedprocurementplan('save');" class="btn btn-primary btn-block">Save Updates</button>
                                            </div>
                                        </div> 
                                        <div class="col-sm-4">
                                            <hr style="border:1px dashed #dddddd;">
                                            <button type="button" onclick="cancelpausedadditemstoProc();" class="btn btn-secondary btn-block">Cancel</button>
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
    $('#pausedprcmentplans').DataTable();
    function submitfacilityunitprocurementplan(facilityunitfinancialyearid, type) {
        var facilityfinancialyrsel = $('#facilityfinancialyrsel').val();
        if (type === 'submit') {
            $.confirm({
                title: 'Submit Procurement Plan!',
                content: 'You Wont Be Able To Update Or Add Items After Submission !!',
                type: 'orange',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes, Submit',
                        btnClass: 'btn-orange',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {type: 'submit', facilityunitfinancialyearid: facilityunitfinancialyearid},
                                url: "procurementplanmanagement/submitordeletefacilityunitprocurementplan.htm",
                                success: function (data, textStatus, jqXHR) {
                                    ajaxSubmitData('procurementplanmanagement/pausedfinancialyearperiodstable.htm', 'pausedfinancialyearperiodstable', 'act=a&pausedprocurementfacilityyr=' + facilityfinancialyrsel + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    },
                    close: function () {
                    }
                }
            });

        } else {
            $.confirm({
                title: 'Delete Procurement Plan Items!',
                content: 'All Items In This Procurement Plan Will Be Deleted !!',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes, Delete',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {type: 'deleteitems', facilityunitfinancialyearid: facilityunitfinancialyearid},
                                url: "procurementplanmanagement/submitordeletefacilityunitprocurementplan.htm",
                                success: function (data, textStatus, jqXHR) {
                                    ajaxSubmitData('procurementplanmanagement/pausedfinancialyearperiodstable.htm', 'pausedfinancialyearperiodstable', 'act=a&pausedprocurementfacilityyr=' + facilityfinancialyrsel + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    },
                    close: function () {
                    }
                }
            });
        }
    }
    var pauseditemsaddedtoprocurement = new Set();
    function pausedfacilityunitprocurementplanitems(facilityunitfinancialyearid, name, orderperiodtype) {
        $('#pausedtitle').html(name + ' ' + 'Procurement Plan Items');
        document.getElementById('removeorupdatefacilityunitprocurementitemsid').value = facilityunitfinancialyearid;
        ajaxSubmitData('procurementplanmanagement/pausedfacilityunitprocurementplanitems.htm', 'pausedfnyItemsViewDiv', 'act=a&facilityunitfinancialyearid=' + facilityunitfinancialyearid + '&orderperiodtype=' + orderperiodtype + '&ofst=1&maxR=100&sStr=', 'GET');
        window.location = '#facilityunitprocurementplanitemsview';
        initDialog('procurementplanPausedItems');

    }
    function pausedfacilityunitprocurementadditems(facilityunitfinancialyearid, label, orderperiodtype) {
        document.getElementById('pausedfacilityunitfinancialprocurementid').value = facilityunitfinancialyearid;

        document.getElementById('pausedunitfinancialprocurementorderperiodtype').value = orderperiodtype;
        document.getElementById('add_items_pausedprocurement').innerHTML = label + ' ' + 'Add Items';
        document.getElementById('ordprdtyp2').innerHTML = orderperiodtype;
        $.ajax({
            type: 'POST',
            data: {type: 'getaddeditems', facilityunitfinancialyearid: facilityunitfinancialyearid},
            url: "procurementplanmanagement/getfacilityunitaddedprocurementplanitems.htm",
            success: function (data, textStatus, jqXHR) {
                var response = JSON.parse(data);
                for (index in response) {
                    pauseditemsaddedtoprocurement.add(response[index]);
                }
            }
        });
        window.location = '#pausedadditemsintoprocurementplan';
        initDialog('addPausedItems');

    }
    function cancelpausedadditemstoProc() {
        var facilityfinancialyrsel = $('#facilityfinancialyrsel').val();
        window.location = '#close';
        ajaxSubmitData('procurementplanmanagement/pausedfinancialyearperiodstable.htm', 'pausedfinancialyearperiodstable', 'act=a&pausedprocurementfacilityyr=' + facilityfinancialyrsel + '&d=0&ofst=1&maxR=100&sStr=', 'GET');

    }
    function pauseddisplaysSearchResults() {
        document.getElementById("myDropdowns2").classList.add("showSearch");
    }
    function pausedsearchItems() {
        pauseddisplaysSearchResults();
        var name = $('#pauseditemsSearch').val();
        if (name.length >= 3) {
            ajaxSubmitDataNoLoader('procurementplanmanagement/pausedsearchItems.htm', 'myDropdowns2', '&itemsonprocurement=' + JSON.stringify(Array.from(pauseditemsaddedtoprocurement)) + '&name=' + name, 'GET');
        } else {
            $('#myDropdowns2').html('');
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
    var count2 = 0;
    function pausedadditemsprocurem() {
        count2++;
        var itemsQty = $('#itemsQty').val();
        var quarterQty = $('#quarterQty').val();
        var itemsid = $('#itemsid').val();
        var itemsname = $('#itemsname').val();
        if (parseInt(itemsQty) !== 0 && parseInt(quarterQty) !== 0) {
            $('#entereditemsTableBody2').append('<tr id="itms-' + itemsid + '"><td>' + count2 + '</td>' +
                    '<td>' + itemsname + '</td>' +
                    '<td class="eitted" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;-moz-border-radius: ;" id="monthps-' + count2 + '" onkeyup="updatemonthorquarter2(this.id);">' + itemsQty + '</td>' +
                    '<td class="eitted" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;-moz-border-radius: ;" id="annualps-' + count2 + '" onkeyup="updatemonthorquarter2(this.id);">' + quarterQty + '</td>' +
                    '<td align="center"><button onclick="removefacilityunititem2(this.id);" id="ups2' + count2 + '" title="Remove Item From Items To List." class="btn btn-primary btn-sm"><i class="fa fa-remove"></i> </button></td></tr>');
            document.getElementById('enteritemdetailsform').reset();
            document.getElementById('itemsSearch').focus();
            $('#pausedadd_search_items').modal('hide');
            pauseditemsaddedtoprocurement.add(parseInt(itemsid));
        }
    }
    function removefacilityunititem2(id) {
        var tablerowid = $('#' + id).closest('tr').attr('id');
        var fields = tablerowid.split('-');
        var itemid = fields[1];
        pauseditemsaddedtoprocurement.delete(parseInt(itemid));
        $('#' + tablerowid).remove();
    }
    function updatemonthorquarter2(id) {
        var orderperiodtype = $('#pausedunitfinancialprocurementorderperiodtype').val();
        
        var fields = id.split('-');
        var type = fields[0];
        var posid = fields[1];
        var value = $('#' + id).text();
        if (value !== '' || value.length !== 0) {
            if (type === 'monthps') {
                if (orderperiodtype === 'Quarterly') {
                    document.getElementById('annualps-' + posid).innerHTML = parseInt(value) * 3;
                } else {
                    document.getElementById('annualps-' + posid).innerHTML = parseInt(value) * 12;
                }
            } else {
                if (orderperiodtype === 'Quarterly') {
                    document.getElementById('monthps-' + posid).innerHTML = Math.round(parseInt(value) / 3);
                } else {
                    document.getElementById('monthps-' + posid).innerHTML = Math.round(parseInt(value) / 12);
                }

            }
        }

    }
    function pausedfacilityuntaddtopause() {
        var orderperiodtype = $('#pausedunitfinancialprocurementorderperiodtype').val();
        var procurementitms = [];
        var table = document.getElementById("entereditemsTableBody2");
        var x = document.getElementById("entereditemsTableBody2").rows.length;
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
        var procurementid = $('#pausedfacilityunitfinancialprocurementid').val();
        var facilityfinancialyearid = $('#facilityfinancialyrsel').val();
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
                        ajaxSubmitData('procurementplanmanagement/pausedfinancialyearperiodstable.htm', 'pausedfinancialyearperiodstable', 'act=a&pausedprocurementfacilityyr=' + facilityfinancialyearid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');

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
    function pausedfacilityuntaddandsubmitprocurementplan() {
        var orderperiodtype = $('#pausedunitfinancialprocurementorderperiodtype').val();
        var procurementitms = [];
        var table = document.getElementById("entereditemsTableBody2");
        var x = document.getElementById("entereditemsTableBody2").rows.length;
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
        var procurementid = $('#pausedfacilityunitfinancialprocurementid').val();
        var facilityfinancialyearid = $('#facilityfinancialyrsel').val();
        console.log(facilityfinancialyearid);
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
                        ajaxSubmitData('procurementplanmanagement/pausedfinancialyearperiodstable.htm', 'pausedfinancialyearperiodstable', 'act=a&pausedprocurementfacilityyr=' + facilityfinancialyearid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');

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
                hideAfter: 3000,
                position: 'bottom-center'
            });
        }
    }
</script>