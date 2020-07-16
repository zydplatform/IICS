<%-- 
    Document   : discardFacOwnerResp
    Created on : May 24, 2018, 10:37:38 PM
    Author     : user
--%>
<%@include file="../../../../include.jsp"%>
<div class="modal fade col-md-12" id="discardPane" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 170%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Manage Owners</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('facility/facilityhome', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET'); clearDiv('facliltyOwnerContent');">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container" id="transfer-pane">
                    <fieldset><legend>Discard Facility Owner: ${model.facOwner.ownername}</legend>
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile-body">
                                        <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                                            <thead class="col-md-12">
                                                <tr>
                                                    <th class="center">No</th>
                                                    <th>Facility Owner</th>
                                                    <th class="center">Status</th>
                                                    <th class="center">More Info</th>
                                                </tr>
                                            </thead>
                                            <tbody class="col-md-12" id="tableFacilityDomain">
                                                <% int d = 1;%>
                                                <% int k = 1;%>
                                                <tr id="${model.facOwner.facilityownerid}">
                                                    <td class="center"><%=k++%></td>
                                                    <td>${model.facOwner.ownername}</td>
                                                    <td><c:if test="${model.facOwner.active==true}">Deleted</c:if><c:if test="${model.facOwner.active==false}">Not Deleted</c:if></td>
                                                    <td>${model.facOwner.description}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <div id="addnew-pane"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $('#discardPane').modal('show');
        });
    </script>
