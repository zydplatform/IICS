<%-- 
    Document   : userAcessRightHome
    Created on : Mar 24, 2018, 1:05:01 PM
    Author     : RESEARCH
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-12">
    </div>
</div>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <legend>Procured Financial Years</legend>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <%@include file="../views/procuredfinancialyears.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div> 
<div class="row">
    <div class="col-md-12">
        <div id="viewprocuredfinancialyeardetails" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="title6heading2"> Procurement Plans</h2>
                    <hr>
                    <input id="selected_facility_unit_proc" type="hidden"> 
                    <input id="selected_facility_unit_proc_type" type="hidden">
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div id="">
                                    <div class="tile" id="viewprocuredfinancialyeardetailstable">

                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-4"></div>
                                            <div class="col-md-4"></div>
                                            <div class="col-md-4">
                                                <hr style="border:1px dashed #dddddd;">
                                                <button type="button" onclick="closedialog();" class="btn btn-secondary btn-block">OK</button>
                                            </div>   
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="viewprocuredfinancialyeardetailsitemsview" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content" style="width: 100%;">
                            <div class="modal-header">
                                <h5 class="modal-title" id="title"> Procurement plan Items</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div id="viewprocuredfinancialyeardetailsitemsDiv">
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
<script>
    $('#procuredfyrs').DataTable();
    function viewprocuredfinancialyeardetails(facilityfinancialyearid) {
        ajaxSubmitData('procurementplanmanagement/viewprocuredfinancialyeardetails.htm', 'viewprocuredfinancialyeardetailstable', 'act=a&financialyearid='+ facilityfinancialyearid +'&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        window.location='#viewprocuredfinancialyeardetails';
        initDialog('supplierCatalogDialog');
    }
   function closedialog(){
       window.location='#close';
   }
   function viewfinancialyeardetailsitemsview(facilityunitfinancialyearid,orderperiodtype){
        ajaxSubmitData('procurementplanmanagement/viewfinancialyeardetailsitemsviewtable.htm', 'viewprocuredfinancialyeardetailsitemsDiv', 'act=a&facilityunitfinancialyearid='+ facilityunitfinancialyearid +'&orderperiodtype='+orderperiodtype+'&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
       $('#viewprocuredfinancialyeardetailsitemsview').modal('show');
   }
</script>
