<%-- 
    Document   : attachedFacility
    Created on : May 25, 2018, 10:12:42 AM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../include.jsp"%>

<fieldset><legend>Facility Attached To Facility Owner: ${model.facOwner.ownername}</legend>
    <div class="row">
        <div class="col-md-12">
            <div>
                <div class="tile-body">
                    <form id="manageFormField" name="manageFormField">
                    <table class="table table-hover table-bordered col-md-12" id="searchedFacility">
                        <thead class="col-md-12">
                            <tr>
                                <th class="center">No</th>
                                <th>Facility</th>
                                <th class="center">Level</th>
                                <th class="center">Transfer</th>
                            </tr>
                        </thead>
                        <tbody class="col-md-12" id="tableFacilityDomain">
                            <% int d = 1;%>
                            <% int k = 1;%>
                            <c:forEach items="${model.facilityList}" var="list">
                                <tr id="${list.facilityid}">
                                    <td class="center"><%=k++%></td>
                                    <td>${list.facilityname}</td>
                                    <td>${list.facilitylevelid.facilitylevelname}</td>
                                    <td>
                                        <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="${list.facilityid}" onChange="if (this.checked) {
                                                    document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) + 1
                                                } else {
                                                    document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) - 1
                                                }
                                                var ticks = document.getElementById('selectedObjs').value;
                                                if (ticks > 0) {
                                                    showDiv('selectObjBtn');
                                                }
                                                if (ticks == 0) {
                                                    hideDiv('selectObjBtn');
                                                }"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div id="selectObjBtn" style="display:none; float:right">
                        <input type="hidden" id="ownerId" name="ownerId" value="${model.facOwner.facilityownerid}"/>
                        <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                        <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
                        <select class="form-control" id="fowner" name="owner">
                            <option value="0">--Select New Ownership--</option>
                            <c:forEach items="${model.facilityOwnerList}" var="owners">                                
                                <option value="${owners.facilityownerid}">${owners.ownername}</option>
                            </c:forEach>
                        </select>
                        <input type="button" value="Transfer Facility" class='btn btn-primary' onClick="var resp = confirm('Transfer Facility(s)?');
                                if (resp == false) {return false;}
                                var ownerid= $('#fowner').val(); if(ownerid<1){alert('Select New Ownership!'); return false;}
                                ajaxSubmitData('facility/transferFacility.htm', 'facliltyOwnerContent', $('#manageFormField').serialize(), 'POST');"/>
                    </div>
                            </form>
                    <div id="addnew-pane"></div>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<script>
    $(document).ready(function () {
        $('#searchedFacility').DataTable();
    })
</script>
