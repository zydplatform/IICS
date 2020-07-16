<%-- 
    Document   : activityMain
    Created on : Aug 24, 2018, 9:29:44 AM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset>
    <legend>Setup/Manage System Activity</legend>

    <div class="row">
        <div class="col-md-12">
            <div class="pull-right">
                <button data-toggle="modal" data-target="#getSystemActivityForm"  id="formSystemActivity" class="btn btn-primary pull-right" type="button">
                    <i class="fa fa-fw fa-lg fa-plus-circle"></i>Add Activity
                </button>
            </div>
        </div>
    </div>

    <div class="row" id="activity-content">
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
                                        <th>Assigned Service</th> 
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
                                            <td>${list.activityname}</td>
                                            <td>${list.description}</td>
                                            <td><c:if test="${list.active==true}">Active</c:if><c:if test="${list.active==false}"><span style="color:red">Disabled</span></c:if></td>
                                            <td align="center">
                                                <span style="float:left">
                                                    <c:if test="${list.units==0}">${list.units}</c:if>
                                                    <c:if test="${list.units>0}"><a href="#" onclick="functionViewActivityServices(${list.activityid},'a')">${list.units}</a></c:if>
                                                </span>
                                                <span style="float:right"><a href="#" onClick="ajaxSubmitData('systemActivity/activityManagement.htm', 'servicePane', 'act=e&i=${list.activityid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Add</a></span>
                                            </td>
                                            <td><fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${list.dateadded}"/></td>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEDEVSYSTEMACTIVITY,PRIVILEGE_DELETEDEVSYSTEMACTIVITY')">
                                                <td align="center">
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEDEVSYSTEMACTIVITY')">
                                                        <a href="#" onClick="ajaxSubmitData('systemActivity/activityManagement.htm', 'detailsResponse', 'act=b&i=${list.activityid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-fw fa-lg fa-dedent"></i></a>
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
                                        <h4 class="tile-title">Select Activity</h4>
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
                                                            <td>Patient Management</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="patientmanagement" name="patientmanagement" value="Patient Management" onChange="addSystemActivity('Patient Management','patientDesc','patientKey','patientmanagement');"/>
                                                                <input type="hidden" id="patientDesc" value="System Component For Managing Patients"/>
                                                                <input type="hidden" id="patientKey" value="key_patientmanagement"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>2.</td>
                                                            <td>Patient Consultation</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="consultation" name="consultation" value="Consultation" onChange="addSystemActivity('Consultation','consultDesc','consultKey','consultation');"/>
                                                                <input type="hidden" id="consultDesc" value="System Component For Managing of patients' treatments based on the severity of their condition"/>
                                                                <input type="hidden" id="consultKey" value="key_consultation"/>
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
                            <form id="submitActivity" name="submitActivity">
                                <div class="row">
                                    <div class="col-md-12" id="activityResponse">
                                        <div class="tile">
                                            <h4 class="tile-title">Verify Activity.</h4>
                                            <table class="table table-sm" id="verifyItems">
                                                <thead>
                                                    <tr>
                                                        <th>Activity Name</th>
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
                                                    <button type="button" disabled="disabled" class="btn btn-primary" id="saveActivity">Save New Activity</button>
                                                </div>
                                                <div id="showSaveBtn" style="display:none">
                                                    <button type="button" class="btn btn-primary" id="saveSystemActivity">Save New Activity</button>
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
    <div class="">
    <div id="modalActivityServices" class="modalOrderitemsdialog">
        <div class="">
            <div id="head">
                <h3 class="modal-title" id="title"><font color="purple">Activity Services</font></h3>
                <a href="#close" title="Close" class="close2" onClick="">X</a>
                <hr>
            </div>
            <div class="scrollbar row" id="content">
                
            </div>
        </div>
    </div>
</div>
</fieldset>



<script>
    var itemList = new Set();
    var itemObjectList = [];
    
    function funRemoveSystemActivity(trId,itemId) {
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
        $('#activityGridView').DataTable();

        $('#formSystemActivity').click(function () {
            window.location = '#addSystemActivity';
            initDialog('supplierCatalogDialog');
        });
        $('#updateSystemActivity').click(function () {
            window.location = '#updateSystemActivityPane';
            initDialog('supplierCatalogDialog');
        });
        

    <c:forEach items="${model.checkList}" var="list">
            $('#${list}').prop('checked', true); 
            $('#${list}').prop('disabled', true);
    </c:forEach>
    })
     
    function addSystemActivity(activity,desc,key,id){
        var description = $('#'+desc+'').val();
        var activityDevkey = $('#'+key+'').val();
        var addedRecs = $('#addedRecs').val();//(parseInt($('#addedRecs').val()) + 1);
        var addedRecs2 = $('#addedRecs2').val();
        
        var pHtmlContent =  
                    '<div class="form-group">' +
                    '<label>Service Name</label>' +
                    '<input type="text" id="name" name="name" value="'+activity+'" placeholder="Enter Service Name" readonly="readonly" class="form-control col-md-8"/>' +
                    '<label>Description</label>' +
                    '<textarea id="desc" name="desc" placeholder="Enter Service Description" class="form-control col-md-8">'+description+'</textarea>' +
                    '<label>Service Key</label>' +
                    '<input type="text" id="key" name="key" value="'+activityDevkey+'" placeholder="Enter Service Key" readonly="readonly" class="form-control col-md-8"/>' +
                    '<small><font color="red" id="codeError"></font></small>' +
                    '</div>';
        
        $.confirm({
            title: '<h3>Add ' + activity + '</h3>',
            content: '<h4 class="itemTitle">Fill All Fields</h4>' +
                    '' + pHtmlContent + '',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                
                formSubmit: {
                    text: 'Add System Activity',
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
                                    '<td>' + activity + '<input type=\'hidden\' name=\'aName' + addedRecs + '\' id=\'aName' + addedRecs + '\' value=\'' + activity + '\'/><input type=\'hidden\' name=\'aKey' + addedRecs + '\' id=\'aKey' + addedRecs + '\' value=\'' + activityDevkey + '\'/></td>' +
                                    '<td>' + description + '<input type=\'hidden\' name=\'aDesc' + addedRecs + '\' id=\'aDesc' + addedRecs + '\' value=\'' + description + '\'/></td>' +
                                    '<td class="center">' +
                                    '<span class="badge badge-danger icon-custom" onclick="funRemoveSystemActivity(\'row' + addedRecs + '\',\'' + id + '\');">' +
                                    '<i class="fa fa-trash-o"></i></span></td></tr>'
                                    );

                            var data = {
                                name: activity,
                                description: description,
                                key: activityDevkey
                            };
                            itemList.add(activity);
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
    function updateSystemActivity(){
        //ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    
    $('#saveSystemActivity').click(function () {
            swal({
                title: "Confirm Save?",
                type: "warning",
                showCancelButton: true,
                confirmButtonText: "Cancel",
                cancelButtonText: "Save Activity",
                closeOnConfirm: true,
                closeOnCancel: true
            }
            ,
                    function (isConfirm) {
                        if (isConfirm) {
                            
                            swal("Deleted!", );
                        } else {
                            $('.close').click();
                            ajaxSubmitForm('systemActivity/registerSystemActivity.htm', 'activityResponse', 'submitActivity');
                            //swal("Saved", "Queue Types Added", "success");
                        }
                    });
        
    });
    
    function functionViewActivityServices(activityId,act) {
        //onClick="ajaxSubmitData('systemActivity/activityManagement.htm', 'activity-content', 'act=f&i=${list.activityid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"
        var title="ACTIVITY ASSIGNED SERVICES.";
        $.ajax({
            type: "GET",
            cache: false,
            url: "systemActivity/activityManagement.htm",
            data: {act:'f',i:activityId,b:'a',c:act,d:0,ofst:1,maxR:100,sStr:''},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">'+title+'</strong>',
                    content: '' + jsonorderitemslist,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: false,
                    buttons: {
                        somethingElse: {
                            text: 'CLOSE',
                            btnClass: 'btn-purple',
                            action: function () {
                                ajaxSubmitData('systemActivity/activityManagement.htm', 'servicePane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        }
                    }
                });
            }
        });
    }
    
</script>