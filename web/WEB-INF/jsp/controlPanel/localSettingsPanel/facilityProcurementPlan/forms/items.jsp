<%-- 
    Document   : items
    Created on : May 9, 2018, 5:00:04 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="row">

    <div class="col-md-6">
        <div class="form-group row">
            <label class="control-label col-md-4">Approved Items In Cart:</label>
            <div class="col-md-6">
                <button type="button" class="btn btn-primary" onclick="approvedprocurementplanitemsshow(${approvedItems},${orderperiodid}, '${orderperiodtype}',${facilityfinancialyearid},${istopdownapproach});">
                    <i class="fa fa-dedent">
                        <span class="badge badge-light">${approvedItems}</span>
                        Item(s)
                    </i>
                </button>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group row">
            <label class="control-label col-md-4">Un Approved Items Cost:</label>
            <div class="col-md-6">
                <button type="button" class="btn btn-primary">
                        <span class="badge badge-light">${totalcost}</span>
                    </i>
                </button>
            </div>
        </div>
    </div>

</div>
<br>
<table class="table table-hover table-bordered" id="tableFacilityprocplanItems">
    <thead>
        <tr>
            <th>No</th>
            <th>Generic Name</th>
                <c:if test="${istopdownapproach==false}">
                <th>Facility Units</th>
                </c:if>
            <th>Monthly Need</th>
            <th>${orderperiodtype} Need</th>
            <th>Total Cost</th>
            <th>Approved</th>
            <th> Update | Reject</th>
        </tr>
    </thead>
    <tbody id="tableFacilityprocplanupdates">
        <% int j = 1;%>
        <% int p = 1;%>
        <c:forEach items="${facilityprocplansitems}" var="a">
            <tr id="${a.itemid}">
                <td><%=j++%></td>
                <td>${a.genericname}</td>
                <c:if test="${istopdownapproach==false}">
                    <td align="center">
                        <button onclick="facilityunitscountview(${a.itemid},${orderperiodid},${facilityfinancialyearid}, '${orderperiodtype}', '${a.genericname}');"  title="View Facility Unit." class="btn btn-primary btn-sm add-to-shelf">
                            ${a.facilityunitscount} &nbsp;Unit(s)
                        </button>
                    </td>    
                </c:if>
                <td>${a.averagemonthlyconsumption}</td>
                <td><c:if test="${orderperiodtype=='Quarterly'}">${a.averagequarterconsumption}</c:if><c:if test="${orderperiodtype=='Monthly'}">${a.averageannualcomsumption} </c:if><c:if test="${orderperiodtype=='Annually'}">${a.averageannualcomsumption}</c:if></td>
                <td>${a.cost}</td>
                <td align="center">
                    <div class="toggle-flip">
                        <label>
                            <input value="${a.facilityprocurementplanid}" id="papps<%=p++%>" type="checkbox" onchange="if (this.checked) {
                                        approveFacilityConsolidatedProcurementPlan('approve', this.id, this.value,${orderperiodid},${facilityfinancialyearid}, '${orderperiodtype}',${istopdownapproach});
                                    } else {
                                        approveFacilityConsolidatedProcurementPlan('disapprove', this.id, this.value,${orderperiodid},${facilityfinancialyearid}, '${orderperiodtype}',${istopdownapproach});
                                    }"><span class="flip-indecator" style="height: 10px !important;width:  32px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                        </label>
                    </div>
                </td>
                <td align="center">
                    <button onclick="editprocurementItem(${a.itemid}, '${a.genericname}', '${orderperiodtype}',${orderperiodid},${facilityfinancialyearid},${a.averagemonthlyconsumption},${a.facilityprocurementplanid},${istopdownapproach});"  title="Edit Item On The Procurement Plan." style="width: 30px !important;" class="btn btn-primary btn-sm add-to-shelf">
                        <i class="fa fa-lg fa-edit"></i>
                    </button>
                    |
                    <button onclick="rejectprocurementplanitems(${orderperiodid},${facilityfinancialyearid},${a.facilityprocurementplanid},${istopdownapproach});" style="width: 30px !important;"  title="Reject Item from The Procurement Plan." class="btn btn-secondary btn-sm add-to-shelf">
                        <i class="fa fa-lg fa-remove"></i>
                    </button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    var approvedItemsCount = 0;
    $('#tableFacilityprocplanItems').DataTable();
    function facilityunitscountview(itemid, orderperiodid, facilityfinancialyearid, orderperiodtype, genericname) {
        ajaxSubmitData('facilityprocurementplanmanagement/facilityunitsitemvaluesview.htm', 'facilityunititemvaluesviewdiv', 'act=a&facilityfinancialyearid=' + facilityfinancialyearid + '&itemid=' + itemid + '&orderperiodid=' + orderperiodid + '&orderperiodtype=' + orderperiodtype + '&genericname=' + genericname + '&maxR=100&sStr=', 'GET');
        $('#facilityunititemvaluesview').modal('show');
    }
    function formatNumber(num) {
        return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
    }
    var updatedprocurementitems = new Set();

    function rejectprocurementplanitems(orderperiodid,facilityfinancialyearid,facilityprocurementplanid,istopdownapproach) {
        $.confirm({
            title: 'Reject Item!',
            icon: 'fa fa-warning',
            content: 'You Deleting This Item From This Procurement Plan',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $.confirm({
                            title: 'Reject Item Reason!',
                            content: '' +
                                    '<form action="" class="formName">' +
                                    '<div class="form-group">' +
                                    '<label>Enter Reason here</label>' +
                                    '<input type="text" placeholder="Your name" class="name form-control" required />' +
                                    '</div>' +
                                    '</form>',
                            buttons: {
                                formSubmit: {
                                    text: 'Submit',
                                    btnClass: 'btn-purple',
                                    action: function () {
                                        var reason = this.$content.find('.name').val();
                                        if (!reason) {
                                            $.alert('provide a valid Reason');
                                            return false;
                                        }
                                        
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
                },
                close: function () {
                }
            }
        });

    }
    function savefacilityprocurementplanitemsupdates(type) {
        var financialyearid = $('#procurementfinancialyearid').val();
        var orderperiodid = $('#procurementorderperiodtypeid').val();
        $.confirm({
            title: 'Approved Procurement Plan!',
            content: 'Are You Sure Your Done With Approving Procurement plan Items, You Will Not Be Able To Change It?',
            type: 'red',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {financialyearid: financialyearid, orderperiodid: orderperiodid},
                            url: "facilityprocurementplanmanagement/saveapprovedfacilityprocurementplan.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data !== 'noitems') {
                                    $.confirm({
                                        title: 'Approved Procurement Plan!',
                                        content: 'Procurement Plan Approved SuccessFully!!!',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                window.location = '#close';
                                                ajaxSubmitData('facilityprocurementplanmanagement/composedfacilityprocurementplan.htm', 'content3', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            }
                                        }
                                    });
                                } else if (data === 'noitems') {
                                    $.confirm({
                                        title: 'Approve Procurement Plan!',
                                        content: 'Procurement Plan Has No Approved Items!!!',
                                        type: 'red',
                                        icon: 'fa fa-warning',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                            }
                                        }
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
    function editprocurementItem(itemid, genericname, orderperiodtype, orderperiodid, facilityfinancialyearid, averagemonthlyconsumption, facilityprocurementplanid, istopdownapproach) {
        $('#edit_procurementplan_items').modal('show');
        ajaxSubmitData('facilityprocurementplanmanagement/edititemdetails.htm', 'editItemzDiv', 'act=a&istopdownapproach=' + istopdownapproach + '&facilityfinancialyearid=' + facilityfinancialyearid + '&itemid=' + itemid + '&orderperiodid=' + orderperiodid + '&orderperiodtype=' + orderperiodtype + '&genericname=' + genericname + '&averagemonthlyconsumption=' + averagemonthlyconsumption + '&facilityprocurementplanid=' + facilityprocurementplanid, 'GET');

    }
    function approveFacilityConsolidatedProcurementPlan(type, id, value, orderperiodid, facilityfinancialyearid, orderperiodtype, istopdownapproach) {
        if (type === 'approve') {
            $.ajax({
                type: 'POST',
                data: {facilityprocurementplanid: value, type: 'approve'},
                url: "facilityprocurementplanmanagement/approvefacilityconsolidatedprocurementplanitems.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'success') {
                        approvedItemsCount = approvedItemsCount + 1;
                        if (approvedItemsCount === 10) {
                            approvedItemsCount = 0;
                            ajaxSubmitData('facilityprocurementplanmanagement/facilityprocuredprocuredprocurementplansitemsview.htm', 'facilityprocuredprocuredprocurementplansitemsdiv', 'act=a&facilityfinancialyearid=' + facilityfinancialyearid + '&orderperiodtype=' + orderperiodtype + '&orderperiodid=' + orderperiodid + '&istopdownapproach=' + istopdownapproach + '&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    }
                }
            });
        } else {
            $.ajax({
                type: 'POST',
                data: {facilityprocurementplanid: value, type: 'disapprove'},
                url: "facilityprocurementplanmanagement/approvefacilityconsolidatedprocurementplanitems.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'success') {
                        approvedItemsCount = approvedItemsCount - 1;
                    }
                }
            });
        }
    }
    function approvedprocurementplanitemsshow(approvedItems, orderperiodid, orderperiodtype, facilityfinancialyearid, istopdownapproach) {
        if (approvedItems > 0) {
            $('#approvedprocurementplan_items').modal('show');
            ajaxSubmitData('facilityprocurementplanmanagement/approvedprocurementplanitems.htm', 'approvedItemzDiv', 'act=a&orderperiodtype=' + orderperiodtype + '&orderperiodid=' + orderperiodid + '&facilityfinancialyearid=' + facilityfinancialyearid + '&istopdownapproach=' + istopdownapproach + '&maxR=100&sStr=', 'GET');
        } else {
            $.confirm({
                title: 'Approved Items Cart!',
                content: 'No Approved Items In The Cart',
                type: 'red',
                icon: 'fa fa-warning',
                typeAnimated: true,
                buttons: {
                    close: function () {
                    }
                }
            });
        }

    }
</script>