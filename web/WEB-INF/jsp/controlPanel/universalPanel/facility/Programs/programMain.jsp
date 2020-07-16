<%-- 
    Document   : programMain
    Created on : Nov 6, 2018, 4:45:47 PM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset>
    <legend>Manage Facility Programs</legend>

    <div class="row">
        <div class="col-md-12">
            <div class="pull-right">
                <button data-toggle="modal" data-target="#getFacilityProgramForm"  id="formFacilityProgram" class="btn btn-primary pull-right" type="button">
                    <i class="fa fa-fw fa-lg fa-plus-circle"></i>Add Facility Program
                </button>
            </div>
        </div>
    </div>

    <div class="row" id="program-content">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <c:if test="${not empty  model.programList}">
                        <form id="manageGridView" name="manageGridView">

                            <!-- start: DYNAMIC TABLE PANEL -->
                            <table class="table table-hover table-bordered" id="programGridView">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Program Name</th> 
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEFACILITYPROGRAMS,PRIVILEGE_DELETEFACILITYPROGRAMS')">
                                            <th>Manage</th> 
                                            </security:authorize>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="count" value="1"/>
                                    <c:set var="No" value="0" />
                                    <c:forEach items="${model.programList}" var="list" varStatus="status" begin="0" end="${model.size}">
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
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEFACILITYPROGRAMS,PRIVILEGE_DELETEFACILITYPROGRAMS')">
                                                <td align="center">
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEFACILITYPROGRAMS')">
                                                        <a href="#" onClick="ajaxSubmitData('systemActivity/programManagement.htm', 'detailsResponse', 'act=b&i=${list[0]}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-fw fa-lg fa-dedent"></i></a>
                                                    </security:authorize>

                                                </td>
                                            </security:authorize>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </form>
                    </c:if>
                    <c:if test="${empty model.programList}">
                        <div align="center"><h3>No Facility programs Registered!</h3></div>
                    </c:if>
                </div>
            </div>
        </div>

        <div id="detailsResponse"></div>
        <div id="addFacilityProgram" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" onClick="ajaxSubmitData('systemActivity/programManagement.htm', 'servicePane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" class="close2">X</a>
                    <h2 class="modalDialog-title" id="policyTitle">Add Facility Program</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">

                    <div class="form-group row" style="width:100%">
                        <div class="col-md-4">
                            <div class="row">
                                <div class="col-md-10">
                                    <div class="tile">
                                        <h4 class="tile-title">Select Program</h4>
                                        <div class="tile-body">
                                            <form id="entryform">
                                                <table class="table table-sm">
                                                    <thead>
                                                        <tr>
                                                            <th>No.</th>
                                                            <th>Program Name</th>
                                                            <th>Add</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>1.</td>
                                                            <td>Antenatal</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="antenatal" name="antenatal" value="Antenatal" onChange="addProgram('Antenatal', 'antenatalDesc', 'antenatalKey', 'antenatal');"/>
                                                                <input type="hidden" id="antenatalDesc" value="Regular check-ups throughout  pregnancy"/>
                                                                <input type="hidden" id="antenatalKey" value="key_antenatal"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>2.</td>
                                                            <td>Immunization</td>
                                                            <td>
                                                                <input type="checkbox" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="immunization" name="immunization" value="Immunization" onChange="addProgram('Immunization', 'immunizationDesc', 'immunizationKey', 'immunization');"/>
                                                                <input type="hidden" id="immunizationDesc" value="The administration of a vaccine."/>
                                                                <input type="hidden" id="immunizationKey" value="key_immunization"/>
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
                            <form id="submitProgram" name="submitProgram">
                                <div class="row">
                                    <div class="col-md-12" id="programResponse">
                                        <div class="tile">
                                            <h4 class="tile-title">Verify Programs.</h4>
                                            <table class="table table-sm" id="verifyItems">
                                                <thead>
                                                    <tr>
                                                        <th>Program Name</th>
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
                                                    <button type="button" disabled="disabled" class="btn btn-primary" id="saveProgram">Save New Program</button>
                                                </div>
                                                <div id="showSaveBtn" style="display:none">
                                                    <button type="button" class="btn btn-primary" id="saveProgram2" onClick="ajaxSubmitForm('systemActivity/registerFacProgram.htm', 'programResponse', 'submitProgram');">Save New Program</button>
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
    
    function funRemoveProgram(trId,itemId) {
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
        $('#programGridView').DataTable();

        $('#formFacilityProgram').click(function () {
            window.location = '#addFacilityProgram';
            initDialog('supplierCatalogDialog');
        });
        $('#updateFacilityProgram').click(function () {
            window.location = '#updateFacProgramPane';
            initDialog('supplierCatalogDialog');
        });
        

    <c:forEach items="${model.checkList}" var="list">
            //alert('List :::: ${list}');
            $('#${list}').prop('checked', true); 
            $('#${list}').prop('disabled', true);
    </c:forEach>
    })
     
    function addProgram(program,desc,key,id){
        var progDevkey = $('#'+key+'').val();
        var addedRecs = $('#addedRecs').val();//(parseInt($('#addedRecs').val()) + 1);
        var addedRecs2 = $('#addedRecs2').val();
        
        var pHtmlContent =  
                    '<div class="form-group">' +
                    '<label>Program Name</label>' +
                    '<input type="text" id="name" name="name" value="'+program+'" placeholder="Enter Program Name" readonly="readonly" class="form-control col-md-8"/>' +
                    '<label>Program Key</label>' +
                    '<input type="text" id="key" name="key" value="'+progDevkey+'" placeholder="Enter Program Key" readonly="readonly" class="form-control col-md-8"/>' +
                    '<small><font color="red" id="codeError"></font></small>' +
                    '</div>';
        
        $.confirm({
            title: '<h3>Add ' + program + ' Program</h3>',
            content: '<h4 class="itemTitle">Fill All Fields</h4>' +
                    '' + pHtmlContent + '',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                
                formSubmit: {
                    text: 'Add Program',
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
                                    '<td>' + program + '<input type=\'hidden\' name=\'pName' + addedRecs + '\' id=\'pName' + addedRecs + '\' value=\'' + program + '\'/><input type=\'hidden\' name=\'pKey' + addedRecs + '\' id=\'pKey' + addedRecs + '\' value=\'' + progDevkey + '\'/></td>' +
                                    '<td class="center">' +
                                    '<span class="badge badge-danger icon-custom" onclick="funRemoveProgram(\'row' + addedRecs + '\',\'' + id + '\');">' +
                                    '<i class="fa fa-trash-o"></i></span></td></tr>'
                                    );

                            var data = {
                                name: program,
                                key: progDevkey
                            };
                            itemList.add(program);
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
    function updateProgram(){
    }
    
</script>