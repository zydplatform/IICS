<%-- 
    Document   : activity
    Created on : Aug 24, 2018, 4:19:26 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="col-md-12">
    <div class="tile">
        <div class="tile-body">
            <c:if test="${not empty  model.activityList}">
                <form id="manageGridView" name="manageGridView">

                    <!-- start: DYNAMIC TABLE PANEL -->
                    <table class="table table-hover table-bordered" id="activityGridView">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Activity Name</th> 
                                <th>Description</th>
                                <th>Status</th> 
                                <th>Released</th> 
                                <th>Date Added</th>
                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEDEVSYSTEMACTIVITY,PRIVILEGE_DELETEDEVSYSTEMACTIVITY')">
                                    <th>Manage</th> 
                                    </security:authorize>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="count" value="1"/>
                            <c:set var="No" value="0" />
                            <c:forEach items="${model.activityList}" var="list" varStatus="status" begin="0" end="${model.size}">
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
                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEDEVSYSTEMACTIVITY,PRIVILEGE_DELETEDEVSYSTEMACTIVITY')">
                                        <td align="center">
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEDEVSYSTEMACTIVITY')">
                                                <a href="#" onClick="ajaxSubmitData('systemActivity/activityManagement.htm', 'detailsResponse', 'act=b&i=${list[0]}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-fw fa-lg fa-dedent"></i></a>
                                            </security:authorize>

                                        </td>
                                    </security:authorize>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </form>
            </c:if>
            <c:if test="${empty model.activityList}">
                <div align="center"><h3>No System Activity Registered!</h3></div>
            </c:if>
        </div>
    </div>
</div>
<div id="detailsResponse"></div>
        <div id="addSystemActivity" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" onClick="ajaxSubmitData('systemActivity/activityManagement.htm', 'activityPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" class="close2">X</a>
                    <h2 class="modalDialog-title" id="policyTitle">Add System Activity</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">

                    <div class="form-group row" style="width:100%">
                        <div class="col-md-4">
                            <div class="row">
                                <div class="col-md-10">
                                    <div class="tile">
                                        <h4 class="tile-title">Select Activities</h4>
                                        <div class="tile-body">
                                            <form id="entryform">
                                                <table class="table table-sm">
                                                    <thead>
                                                        <tr>
                                                            <th>No.</th>
                                                            <th>Activity Name</th>
                                                            <th>Add</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>1.</td>
                                                            <td>Administration</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="administration" name="administration" value="Administration" onChange="addService('Administration','adminDesc','adminKey','administration');"/>
                                                                <input type="hidden" id="adminDesc" value="Processes that run a facility through administration"/>
                                                                <input type="hidden" id="adminKey" value="key_administration"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>2.</td>
                                                            <td>Consultation</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="consultation" name="consultation" value="Consultation" onChange="addService('Consultation','consultDesc','consultKey','consultation');"/>
                                                                <input type="hidden" id="consultDesc" value="Triage/Processes of determining the priority of patients' treatments based on the severity of their condition"/>
                                                                <input type="hidden" id="consultKey" value="key_consultation"/>
                                                            </td>

                                                        </tr>
                                                        <tr>
                                                            <td>3.</td>
                                                            <td>Dispensing</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="dispensing" name="dispensing" value="Dispensing" onChange="addService('Dispensing','dispDesc','dispKey','dispensing');"/>
                                                                <input type="hidden" id="dispDesc" value="Processes related to issuing out supplies"/>
                                                                <input type="hidden" id="dispKey" value="key_dispensing"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>4.</td>
                                                            <td>Ordering</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="ordering" name="ordering" value="Ordering" onChange="addService('Ordering','orderDesc','orderKey','ordering');"/>
                                                                <input type="hidden" id="orderDesc" value="Processes related to placing requests for a supply or to be served"/>
                                                                <input type="hidden" id="orderKey" value="key_ordering"/>
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
    
    $('.body').removeClass('modal-open');
                                    $('.modal-backdrop').remove();
                                    $('.close').click();
</script>