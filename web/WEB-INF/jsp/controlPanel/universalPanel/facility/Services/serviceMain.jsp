<%-- 
    Document   : serviceMain
    Created on : Jul 17, 2018, 6:53:03 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset>
    <legend>Setup/Manage Facility Services</legend>

    <div class="row">
        <div class="col-md-12">
            <div class="pull-right">
                <button data-toggle="modal" data-target="#getFacilityServiceForm"  id="formFacilityService" class="btn btn-primary pull-right" type="button">
                    <i class="fa fa-fw fa-lg fa-plus-circle"></i>Add Facility Service
                </button>
            </div>
        </div>
    </div>

    <div class="row" id="service-content">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <c:if test="${not empty  model.serviceList}">
                        <form id="manageGridView" name="manageGridView">

                            <!-- start: DYNAMIC TABLE PANEL -->
                            <table class="table table-hover table-bordered" id="serviceGridView">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Service Name</th> 
                                        <th>Description</th>
                                        <th>Status</th> 
                                        <th>Released</th> 
                                        <th>Date Added</th>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEFACILITYSERVICES,PRIVILEGE_DELETEFACILITYSERVICES')">
                                            <th>Manage</th> 
                                            </security:authorize>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="count" value="1"/>
                                    <c:set var="No" value="0" />
                                    <c:forEach items="${model.serviceList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                        <c:choose>
                                            <c:when test="${status.count % 2 != 0}">
                                                <tr>
                                                </c:when>
                                                <c:otherwise>
                                                <tr bgcolor="white">
                                                </c:otherwise>
                                            </c:choose>
                                            <td>${status.count}</td>
                                            <td>${list[1]}</td>
                                            <td>${list[2]}</td>
                                            <td><c:if test="${list[4]==true}">Active</c:if><c:if test="${list[4]==false}"><span style="color:red">Disabled</span></c:if></td>
                                            <td align="center"><c:if test="${list[5]==true}">Yes</c:if><c:if test="${list[5]==false}"><span style="color:red">No</span></c:if></td>
                                            <td><fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${list[6]}"/></td>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEFACILITYSERVICES,PRIVILEGE_DELETEFACILITYSERVICES')">
                                                <td align="center">
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEFACILITYSERVICES')">
                                                        <a href="#" onClick="ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'detailsResponse', 'act=b&i=${list[0]}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-fw fa-lg fa-dedent"></i></a>
                                                    </security:authorize><!-- $('#serviceid').val('${list[0]}'); $('#servicename2').val('${list[1]}'); $('#serviceDesc2').val('${list[2]}'); updateService(); if({list[4]}===false){$('#fstatus').prop('checked', true);}else{$('#tstatus').prop('checked', true);} if({list[5]}===false){$('#frelease').prop('checked', true);}else{$('#trelease').prop('checked', true);} -->

                                                </td>
                                            </security:authorize>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </form>
                    </c:if>
                    <c:if test="${empty model.serviceList}">
                        <div align="center"><h3>No Facility Services Registered!</h3></div>
                    </c:if>
                </div>
            </div>
        </div>

        <div id="detailsResponse"></div>
        <div id="addFacilityService" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" onClick="ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'servicePane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" class="close2">X</a>
                    <h2 class="modalDialog-title" id="policyTitle">Add Facility Service</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">

                    <div class="form-group row" style="width:100%">
                        <div class="col-md-4">
                            <div class="row">
                                <div class="col-md-10">
                                    <div class="tile">
                                        <h4 class="tile-title">Select Services</h4>
                                        <div class="tile-body">
                                            <form id="entryform">
                                                <table class="table table-sm">
                                                    <thead>
                                                        <tr>
                                                            <th>No.</th>
                                                            <th>Service Name</th>
                                                            <th>Add</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>1.</td>
                                                            <td>Administration</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="administration" name="administration" value="Administration" onChange="addService('Administration', 'adminDesc', 'adminKey', 'administration');"/>
                                                                <input type="hidden" id="adminDesc" value="Processes that run a facility through administration"/>
                                                                <input type="hidden" id="adminKey" value="key_administration"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>2.</td>
                                                            <td>Consultation</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="consultation" name="consultation" value="Consultation" onChange="addService('Consultation', 'consultDesc', 'consultKey', 'consultation');"/>
                                                                <input type="hidden" id="consultDesc" value="Triage/Processes of determining the priority of patients' treatments based on the severity of their condition"/>
                                                                <input type="hidden" id="consultKey" value="key_consultation"/>
                                                            </td>

                                                        </tr>
                                                        <tr>
                                                            <td>3.</td>
                                                            <td>Dispensing</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="dispensing" name="dispensing" value="Dispensing" onChange="addService('Dispensing', 'dispDesc', 'dispKey', 'dispensing');"/>
                                                                <input type="hidden" id="dispDesc" value="Processes related to issuing out supplies"/>
                                                                <input type="hidden" id="dispKey" value="key_dispensing"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>4.</td>
                                                            <td>Ordering</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="ordering" name="ordering" value="ordering" onChange="addService('Ordering', 'orderDesc', 'orderKey', 'ordering');"/>
                                                                <input type="hidden" id="orderDesc" value="Processes related to placing requests for a supply or to be served"/>
                                                                <input type="hidden" id="orderKey" value="key_ordering"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>5.</td>
                                                            <td>Triage</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="triage" name="triage" value="triage" onChange="addService('Triage', 'triageDesc', 'triageKey', 'triage');"/>
                                                                <input type="hidden" id="triageDesc" value="Performs capaturing of vitals"/>
                                                                <input type="hidden" id="triageKey" value="key_triage"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>6.</td>
                                                            <td>Supply Unit Store</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="supplyunit" name="supplyunit" value="supplyunit" onChange="addService('Supply Unit Store', 'supplyunitstoreDesc', 'supplyunitstoreKey', 'supplyunit');"/>
                                                                <input type="hidden" id="supplyunitstoreDesc" value="This is for Supply Unit stores"/>
                                                                <input type="hidden" id="supplyunitstoreKey" value="key_suppliyunitstore"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>7.</td>
                                                            <td>Laboratory</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="LaboratoryUnit" name="laboratoryUnit" value="LaboratoryUnit" onChange="addService('Laboratory', 'laboratoryDesc', 'laboratoryKey', 'LaboratoryUnit');"/>
                                                                <input type="hidden" id="laboratoryDesc" value="This is for Facility Units with Laboratory Services"/>
                                                                <input type="hidden" id="laboratoryKey" value="key_laboratory"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>8.</td>
                                                            <td>Sundries Unit Store</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="sundriesUnitStore" name="sundriesUnitStore" value="sundriesUnitStore" onChange="addService('Sundries Unit Store', 'sundriesUnitStoreDesc', 'sundriesUnitStoreKey', 'sundriesUnitStore');"/>
                                                                <input type="hidden" id="sundriesUnitStoreDesc" value="This is for Facility Units That Supplies Consuming Units with Sundries"/>
                                                                <input type="hidden" id="sundriesUnitStoreKey" value="key_sundriesUnitStore"/>
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                            <td>9.</td>
                                                            <td>Medicines Supplying Unit</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="medicinesUnitStore" name="medicinesUnitStore" value="medicinesUnitStore" onChange="addService('Medicines Supplying Unit', 'medicinesUnitStoreDesc', 'medicinesUnitStoreKey', 'medicinesUnitStore');"/>
                                                                <input type="hidden" id="medicinesUnitStoreDesc" value="This is for Facility Units That Supplies Consuming Units with Medicines"/>
                                                                <input type="hidden" id="medicinesUnitStoreKey" value="key_medicinesUnitStore"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>10.</td>
                                                            <td>Postnatal</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="postnatal" name="postnatal" value="postnatal" onChange="addService('Postnatal', 'postnatalDesc', 'postnatalKey', 'postnatal');"/>
                                                                <input type="hidden" id="postnatalDesc" value="for Postinatal mothers"/>
                                                                <input type="hidden" id="postnatalKey" value="key_postnatal"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>11.</td>
                                                            <td>Antenatal</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="antenatal" name="antenatal" value="antenatal" onChange="addService('Antenatal', 'antenatalDesc', 'antenatalKey', 'antenatal');"/>
                                                                <input type="hidden" id="antenatalDesc" value="For Antenatal Mothers"/>
                                                                <input type="hidden" id="antenatalKey" value="key_antenatal"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>11.</td>
                                                            <td>Delivery</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="delivery" name="delivery" value="delivery" onChange="addService('Delivery', 'deliveryDesc', 'deliveryKey', 'delivery');"/>
                                                                <input type="hidden" id="deliveryDesc" value="For delivery Mothers"/>
                                                                <input type="hidden" id="deliveryKey" value="key_delivery"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>12.</td>
                                                            <td>Nursery</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="nursery" name="nursery" value="nursery" onChange="addService('Nursery', 'nurseryDesc', 'nurseryKey', 'nursery');"/>
                                                                <input type="hidden" id="nurseryDesc" value="For nursery Mothers"/>
                                                                <input type="hidden" id="nurseryKey" value="key_nursery"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>13.</td>
                                                            <td>C/section</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="Csection" name="Csection" value="Csection" onChange="addService('C section', 'CsectionDesc', 'CsectionKey', 'Csection');"/>
                                                                <input type="hidden" id="CsectionDesc" value="For C section Mothers"/>
                                                                <input type="hidden" id="CsectionKey" value="key_Csection"/>
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                            <td>14.</td>
                                                            <td>Family Planning</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="familyplanning" name="familyplanning" value="familyplanning" onChange="addService('Family Planning', 'familyplanningDesc', 'familyplanningKey', 'familyplanning');"/>
                                                                <input type="hidden" id="familyplanningDesc" value="For Family Planning."/>
                                                                <input type="hidden" id="familyplanningKey" value="key_familyplanning"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>15.</td>
                                                            <td>Immunisation</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="immunisation" name="immunisation" value="immunisation" onChange="addService('Immunisation', 'immunisationDesc', 'immunisationKey', 'immunisation');"/>
                                                                <input type="hidden" id="immunisationDesc" value="For immunisation."/>
                                                                <input type="hidden" id="immunisationKey" value="key_immunisation"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>16.</td>
                                                            <td>Cancer Screening</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="cancerscreening" name="cancerscreening" value="cancerscreening" onChange="addService('Cancer Screening', 'cancerscreeningDesc', 'cancerscreeningKey', 'cancerscreening');"/>
                                                                <input type="hidden" id="cancerscreeningDesc" value="For cancer screening."/>
                                                                <input type="hidden" id="cancerscreeningKey" value="key_cancerscreening"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>16.</td>
                                                            <td>Circumcission</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="circumcission" name="circumcission" value="circumcission" onChange="addService('Circumcission', 'circumcissionDesc', 'circumcissionKey', 'circumcission');"/>
                                                                <input type="hidden" id="circumcissionDesc" value="For Circumcission."/>
                                                                <input type="hidden" id="circumcissionKey" value="key_circumcission"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>17.</td>
                                                            <td>Evacuations</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="evacuations" name="evacuations" value="evacuations" onChange="addService('Evacuations', 'evacuationsDesc', 'evacuationsKey', 'evacuations');"/>
                                                                <input type="hidden" id="evacuationsDesc" value="For Evacuations."/>
                                                                <input type="hidden" id="evacuationsKey" value="key_evacuations"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>18.</td>
                                                            <td>Counselling</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="counselling" name="counselling" value="counselling" onChange="addService('Counselling', 'counsellingDesc', 'counsellingKey', 'counselling');"/>
                                                                <input type="hidden" id="counsellingDesc" value="For Counselling."/>
                                                                <input type="hidden" id="counsellingKey" value="key_counselling"/>
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                            <td>19.</td>
                                                            <td>HT/DM Triage</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="htdm" name="htdm" value="htdm" onChange="addService('HT/DM Triage', 'htdmDesc', 'htdmKey', 'htdm');"/>
                                                                <input type="hidden" id="htdmDesc" value="For HT/DM Triage."/>
                                                                <input type="hidden" id="htdmKey" value="key_htdm"/>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <form id="submitService" name="submitService">
                                <div class="row">
                                    <div class="col-md-12" id="serviceResponse">
                                        <div class="tile">
                                            <h4 class="tile-title">Verify Services.</h4>
                                            <table class="table table-sm" id="verifyItems">
                                                <thead>
                                                    <tr>
                                                        <th>Service Name</th>
                                                        <th>Description</th>
                                                        <th>Remove</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="enteredItemsBody">

                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-12 text-right">
                                                <input type="hidden" id="addedOptions" value="false"/>
                                                <input type="hidden" id="addedRecs" value="0" name="itemSize"/>
                                                <input type="hidden" id="addedRecs2" value="0"/>
                                                <div id="hideSaveBtn">
                                                    <button type="button" disabled="disabled" class="btn btn-primary" id="savePolicy">Save New Service</button>
                                                </div>
                                                <div id="showSaveBtn" style="display:none">
                                                    <button type="button" class="btn btn-primary" id="savePolicy2" onClick="ajaxSubmitForm('facilityServicesManagement/registerFacService.htm', 'serviceResponse', 'submitService');">Save New Service</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group"></div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</fieldset>



<script>
    var itemList = new Set();
    var itemObjectList = [];
    
    function funRemoveService(trId,itemId) {
        $('#' + trId + '').remove();
        var addedRecs2 = (parseInt($('#addedRecs2').val()) - 1);
        //alert('addedRecs2:'+addedRecs2);
        $('#'+itemId).prop('checked', false); 
        $('#'+itemId).prop('disabled', false);
         $('#addedRecs2').val(addedRecs2);
        if (addedRecs2 === 0) {
            hideDiv('showSaveBtn');
            showDiv('hideSaveBtn');
            $('#addedRecs').val(0);
            $('#addedOptions').val('false')
        }
    }
    
    $(document).ready(function () {
        clearDiv('detailsResponse');
        $('#serviceGridView').DataTable();

        $('#formFacilityService').click(function () {
            window.location = '#addFacilityService';
            initDialog('supplierCatalogDialog');
        });
        $('#updateFacilityService').click(function () {
            window.location = '#updateFacServicePane';
            initDialog('supplierCatalogDialog');
        });
        

    <c:forEach items="${model.checkList}" var="list">
            //alert('List :::: ${list}');
            $('#${list}').prop('checked', true); 
            $('#${list}').prop('disabled', true);
    </c:forEach>
    })
     
    function addService(service,desc,key,id){
        var description = $('#'+desc+'').val();
        var serviceDevkey = $('#'+key+'').val();
        var addedRecs = $('#addedRecs').val();//(parseInt($('#addedRecs').val()) + 1);
        var addedRecs2 = $('#addedRecs2').val();
        
        var pHtmlContent =  
                    '<div class="form-group">' +
                    '<label>Service Name</label>' +
                    '<input type="text" id="name" name="name" value="'+service+'" placeholder="Enter Service Name" readonly="readonly" class="form-control col-md-8"/>' +
                    '<label>Description</label>' +
                    '<textarea id="desc" name="desc" placeholder="Enter Service Description" class="form-control col-md-8">'+description+'</textarea>' +
                    '<label>Service Key</label>' +
                    '<input type="text" id="key" name="key" value="'+serviceDevkey+'" placeholder="Enter Service Key" readonly="readonly" class="form-control col-md-8"/>' +
                    '<small><font color="red" id="codeError"></font></small>' +
                    '</div>';
        
        $.confirm({
            title: '<h3>Add ' + service + ' Service</h3>',
            content: '<h4 class="itemTitle">Fill All Fields</h4>' +
                    '' + pHtmlContent + '',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                
                formSubmit: {
                    text: 'Add Service',
                    btnClass: 'btn-purple submit',
                    action: function () {
                        //var res = this.$content.find('input:radio[name=res]:checked');
                        var validateOptions = true;
                            $('#desc').css('border', '2px solid #ced4da');
                            var checkDescEntry = $('#desc').val(); //this.$content.find('#pOption'+x+'');
                            if (checkDescEntry === '') {
                                $('#desc').focus();
                                $('#desc').css('border', '2px solid #f50808c4');
                                validateOptions = false;
                            }
                        if (validateOptions === false) {
                            return false;
                        } else {
                            addedRecs = (parseInt(addedRecs) + 1);
                            addedRecs2 = parseInt(addedRecs2);
                            
                            $('#addedOptions').val('true');
                            $('#enteredItemsBody').append(
                                    '<tr id="row' + addedRecs + '">' +
                                    '<td>' + service + '<input type=\'hidden\' name=\'sName' + addedRecs + '\' id=\'sName' + addedRecs + '\' value=\'' + service + '\'/><input type=\'hidden\' name=\'sKey' + addedRecs + '\' id=\'sKey' + addedRecs + '\' value=\'' + serviceDevkey + '\'/></td>' +
                                    '<td>' + description + '<input type=\'hidden\' name=\'sDesc' + addedRecs + '\' id=\'sDesc' + addedRecs + '\' value=\'' + description + '\'/></td>' +
                                    '<td class="center">' +
                                    '<span class="badge badge-danger icon-custom" onclick="funRemoveService(\'row' + addedRecs + '\',\'' + id + '\');">' +
                                    '<i class="fa fa-trash-o"></i></span></td></tr>'
                                    );

                            var data = {
                                name: service,
                                description: description,
                                key: serviceDevkey
                            };
                            itemList.add(service);
                            itemObjectList.push(data);
                            //Increment Count Of List To Save For Controlling Elements On Save Side
                            $('#addedRecs').val(addedRecs);
                            var addedRecs2 = (parseInt($('#addedRecs2').val()) + 1);
                            $('#addedRecs2').val(addedRecs2);
                            $('#'+id).prop('disabled', true);
                            //Show Button To Register Item Added To Save Side
                            showDiv('showSaveBtn');
                            hideDiv('hideSaveBtn');
                            //Clear Fields
                        }
                    }
                },
                close: {
                    text: 'Cancel',
                    btnClass: 'btn-red',
                    action: function () {
                        $('#' + id).prop('checked', false);
                        $('#' + id).prop('disabled', false);
                        }
                }
            },
            onContentReady: function () {}
        });
    }
    function updateService(){
        //ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    
</script>