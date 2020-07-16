<%-- 
    Document   : editFinancialYearItemToImport
    Created on : Apr 11, 2018, 11:29:39 AM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<div class="modal fade" id="finacialeditedititems" style="padding-right: 21% !important;"tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle"> Financial Year Items</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12">
                            <input value="${procurementid}" type="hidden" id="procurementidtoimportto">
                        </div>
                        <!-- panel preview -->
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body"  style="height:400px;overflow: scroll;">
                                    <div id="itemstable">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <legend>Getting Item Please Wait...................</legend>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tile-footer">
                                    <div class="row">
                                        <div class="col-md-8 col-md-offset-3">
                                            <button class="btn btn-primary" onclick="saveandpauseitemsaddedtoproc();" type="button" ><i class="fa fa-fw fa-lg fa-check-circle"></i>Add & Pause</button>&nbsp;&nbsp;&nbsp;<a class="btn btn-primary" href="#"onclick="addandsubmitproc();" ><i class="fa fa-fw fa-lg fa-times-circle"></i>Add & Submit</a>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary" href="#" data-dismiss="modal" ><i class="fa fa-fw fa-lg fa-times-circle"></i>Close</a>
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
    ajaxSubmitData('procurementplanmanagement/getfinancialyearsitemstoimport.htm', 'itemstable', 'act=a&importids=' + '${importids}' + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    $('#finacialeditedititems').modal('show');
    
</script>
