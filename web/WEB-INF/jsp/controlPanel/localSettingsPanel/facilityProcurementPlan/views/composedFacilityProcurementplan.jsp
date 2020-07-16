<%-- 
    Document   : composedFacilityProcurementplan
    Created on : May 9, 2018, 12:52:18 AM
    Author     : IICS
--%>
<style>
    #overlay {
        background: rgba(0,0,0,0.5);
        color: #FFFFFF;
        position: fixed;
        height: 100%;
        width: 100%;
        z-index: 5000;
        top: 0;
        left: 0;
        float: left;
        text-align: center;
        padding-top: 25%;
    }
</style>
</style>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <section id="team" class="pb-5">
                            <div class="container">
                                <c:if test="${facilityfinancialyear !=null}">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group row">
                                                <label class="control-label col-md-4">Procurement Plan For Financial Year:</label>
                                                <div class="col-md-6">
                                                    <h3><span class="badge badge-secondary"><strong><c:if test="${facilityfinancialyear !=null}">${facilityfinancialyear}</c:if><c:if test="${facilityfinancialyear==null}">No Active Financial Year</c:if></strong></span></h3>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>  
                                </c:if>

                                <div class="row">
                                    <c:if test="${procured==true}">
                                        <table class="table table-hover table-bordered" id="consolidatedFacilityprocurementplanItem">
                                            <thead>
                                                <tr>
                                                    <th>No</th>
                                                    <th>Procurement Plan</th>
                                                    <th>Items</th>
                                                    <th>Start Date</th>
                                                    <th>End Date</th>
                                                        <c:if test="${istopdownapproach==false}">
                                                        <th>Units</th>
                                                        </c:if>
                                                    <th>Total Cost</th>
                                                    <th>Approve Items</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% int j = 1;%>
                                                <tr>
                                                    <td><%=j++%></td>
                                                    <td>${orderperiodname}</td>
                                                    <td align="center">
                                                        <button type="button" class="btn btn-primary" onclick="viewconsolidateditems(${orderperiodid}, '${orderperiodtype}');">
                                                            <i class="fa fa-dedent">
                                                                <span class="badge badge-light">${facilityprocurementplansitemsRowcount}</span>
                                                                Item(s)
                                                            </i>
                                                        </button>
                                                    </td>
                                                    <td>${startdate}</td>
                                                    <td>${enddate}</td>
                                                    <c:if test="${istopdownapproach==false}">
                                                        <td align="center">
                                                            <button onclick="consolidatefacilityunitsprocurementplans(${orderperiodid}, '${orderperiodtype}',${facilityfinancialyearid});"  title="Consolidate The Procurement Plan." class="btn btn-primary btn-sm add-to-shelf">
                                                                <i class="fa fa-lg fa-save">&nbsp;Units</i>
                                                            </button> 
                                                        </td> 
                                                    </c:if>
                                                    <td>
                                                        ${totalcost}
                                                    </td>
                                                    <td align="center">
                                                        <button onclick="facilityprocurementplanitemsviewfuc(${facilityfinancialyearid}, '${orderperiodtype}',${orderperiodid}, '${orderperiodname}', '${facilityfinancialyear}',${facilityprocurementplansitemsRowcount},${istopdownapproach});"  title="Delete Item From Order" class="btn btn-primary btn-sm add-to-shelf">
                                                            <i class="fa fa-dedent"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </c:if>
                                    <div id="overlay" style="display: none;">
                                        <img src="static/img2/loader.gif" alt="Loading" /><br/>
                                        Submitting procurement Plan Items Please Wait...
                                    </div>
                                    <c:if test="${procured==false}">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <legend style="color: red;"> No  Procurement plan To Approve In The Financial Year</legend>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div>

<div class="row">
    <div class="col-md-12">
        <div id="facilityprocurementplanitemsview" class="supplierCatalogDialog facilityprocurementplanItemView">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="facilityprocurementplan_item">Procurement Plan Items</h2>
                    <hr>
                    <input id="procurementfinancialyearid" type="hidden">
                    <input id="procurementorderperiodtype" type="hidden">
                    <input id="procurementorderperiodtypeid" type="hidden">
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile" id="facilityprocuredprocuredprocurementplansitemsdiv">
                                    <p>Getting Items Please wait...................</p>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-3">
                                        </div>   
                                        <div class="col-sm-3">
                                            <hr style="border:1px dashed #dddddd;">
                                            <button type="button" onclick="savefacilityprocurementplanitemsupdates('submit');" class="btn btn-primary btn-block">Approved</button>
                                        </div> 
                                        <div class="col-sm-3">
                                            <hr style="border:1px dashed #dddddd;">
                                            <button type="button" onclick="refreshdial();" class="btn btn-secondary btn-block">Refresh</button>
                                        </div> 
                                        <div class="col-sm-3">
                                            <hr style="border:1px dashed #dddddd;">
                                            <button type="button" onclick="closedial();" class="btn btn-secondary btn-block">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="edit_procurementplan_items" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
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
                                                <div id="editItemzDiv">

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="approvedprocurementplan_items" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="title"> Approved Item(s)</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div id="approvedItemzDiv">
                                                    <div class="overlay">
                                                        <div class="m-loader mr-4">
                                                            <svg class="m-circular" viewBox="25 25 50 50">
                                                            <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                            </svg>
                                                        </div>
                                                        <h3 class="l-text">Getting Items Please Wait...........</h3>
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
                <div class="modal fade" id="facilityunititemvaluesview" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content" style="width: auto;">
                            <div class="modal-header">
                                <h5 class="modal-title" id="title">Facility Units</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div id="facilityunititemvaluesviewdiv">

                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12" align="right"  >
                                                <button class="btn btn-primary" type="submit" onclick="savefacilityunititemsmodification();">
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
        <div id="consolidateFacilityUnitsPlans" class="supplierCatalogDialog consolidateFacilityUnitsPlans">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleoralreadyheading">Units For Consolidated Procurement Plan</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="consolidateFacilityUnitsPlansDiv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Getting Units Please Wait...........</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="consolidatedItemsUnits" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="title">Unit's Procured Items</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12" id="consolidatedItemsUnitsDiv">
                                                <div class="overlay">
                                                    <div class="m-loader mr-4">
                                                        <svg class="m-circular" viewBox="25 25 50 50">
                                                        <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                        </svg>
                                                    </div>
                                                    <h3 class="l-text">Getting Unit's Items Please Wait...........</h3>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12" align="right">
                                                <a class="btn btn-secondary" href="#" data-dismiss="modal" ><i class="fa fa-fw fa-lg fa-times-circle"></i>Close</a>
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
<div class="modal fade" id="viewconsolidateditemsdialog" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="title">Items</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12" id="viewconsolidateditemsDiv">
                                <div class="overlay">
                                    <div class="m-loader mr-4">
                                        <svg class="m-circular" viewBox="25 25 50 50">
                                        <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                        </svg>
                                    </div>
                                    <h3 class="l-text">Getting Unit's Items Please Wait...........</h3>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" align="right">
                                <a class="btn btn-secondary" href="#" data-dismiss="modal" ><i class="fa fa-fw fa-lg fa-times-circle"></i>Close</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#consolidatedFacilityprocurementplanItem').DataTable();
    function facilityprocurementplanitemsviewfuc(facilityfinancialyearid, orderperiodtype, orderperiodid, orderperiodname, facilityfinancialyear, facilityprocurementplansitemsRowcount, istopdownapproach) {
        if (facilityprocurementplansitemsRowcount > 0) {
            document.getElementById('procurementfinancialyearid').value = facilityfinancialyearid;
            document.getElementById('procurementorderperiodtype').value = orderperiodtype;
            document.getElementById('procurementorderperiodtypeid').value = orderperiodid;

            document.getElementById('facilityprocurementplan_item').innerHTML = facilityfinancialyear + ' ' + orderperiodname + ' ' + 'Procurement Plan Items';
            ajaxSubmitData('facilityprocurementplanmanagement/facilityprocuredprocuredprocurementplansitemsview.htm', 'facilityprocuredprocuredprocurementplansitemsdiv', 'act=a&facilityfinancialyearid=' + facilityfinancialyearid + '&orderperiodtype=' + orderperiodtype + '&orderperiodid=' + orderperiodid + '&d=0&istopdownapproach=' + istopdownapproach + '&maxR=100&sStr=', 'GET');
            window.location = '#facilityprocurementplanitemsview';
            initDialog('facilityprocurementplanItemView');
        } else {
            $.confirm({
                title: 'Consolidate Procurement Plan!',
                content: 'First Select Units And Consolidate This Procurement Plan !!',
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
    function closedial() {
        window.location = '#close';
    }
    function refreshdial() {
        var facilityfinancialyearid = $('#procurementfinancialyearid').val();
        var orderperiodtype = $('#procurementorderperiodtype').val();
        var orderperiodid = $('#procurementorderperiodtypeid').val();
        ajaxSubmitData('facilityprocurementplanmanagement/facilityprocuredprocuredprocurementplansitemsview.htm', 'facilityprocuredprocuredprocurementplansitemsdiv', 'act=a&facilityfinancialyearid=' + facilityfinancialyearid + '&orderperiodtype=' + orderperiodtype + '&orderperiodid=' + orderperiodid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }

    function consolidatefacilityunitsprocurementplans(orderperiodid, orderperiodtype, facilityfinancialyearid) {
        window.location = '#consolidateFacilityUnitsPlans';
        ajaxSubmitData('facilityprocurementplanmanagement/consolidatefacilityunitsprocurementplans.htm', 'consolidateFacilityUnitsPlansDiv', 'act=a&facilityfinancialyearid=' + facilityfinancialyearid + '&orderperiodtype=' + orderperiodtype + '&orderperiodid=' + orderperiodid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
        initDialog('consolidateFacilityUnitsPlans');
    }
    function viewconsolidateditems(orderperiodid, orderperiodtype) {
        $('#viewconsolidateditemsdialog').modal('show');
        ajaxSubmitData('facilityprocurementplanmanagement/viewconsolidatedfacilityitems.htm', 'viewconsolidateditemsDiv', 'act=a&orderperiodtype=' + orderperiodtype + '&orderperiodid=' + orderperiodid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>