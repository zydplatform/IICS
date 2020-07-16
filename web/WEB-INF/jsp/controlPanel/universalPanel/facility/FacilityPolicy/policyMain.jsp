<%-- 
    Document   : policyMain
    Created on : Jul 2, 2018, 10:46:49 AM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset>
    <legend>Setup/Manage Facility Policy</legend>

    <div class="row">
        <div class="col-md-12">
            <div class="pull-right">
                <button data-toggle="modal" data-target="#getFacilityPolicyForm"  id="formFacilityPolicy" class="btn btn-primary pull-right" type="button">
                    <i class="fa fa-fw fa-lg fa-plus-circle"></i>Add Facility Policy
                </button>
            </div>
        </div>
    </div>

    <div class="row" id="policy-content">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <c:if test="${not empty  model.policyList}">
                        <form id="manageGridView" name="manageGridView">

                            <!-- start: DYNAMIC TABLE PANEL -->
                            <table class="table table-hover table-bordered" id="policyGridView">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Category</th> 
                                        <th>Policy Name</th> 
                                        <th>Data Type</th>
                                        <th>Options</th>
                                        <th>Status</th> 
                                        <th>Date Added</th>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEFACILITYPOLICY') or hasRole('PRIVILEGE_DELETEFACILITYPOLICY')">
                                            <th>Manage</th> 
                                            </security:authorize>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="count" value="1"/>
                                    <c:set var="No" value="0" />
                                    <c:forEach items="${model.policyList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                        <c:choose>
                                            <c:when test="${status.count % 2 != 0}">
                                                <tr>
                                                </c:when>
                                                <c:otherwise>
                                                <tr bgcolor="white">
                                                </c:otherwise>
                                            </c:choose>
                                            <td>${status.count}</td>
                                            <td>${list.category}</td>
                                            <td>${list.policyname}</td>
                                            <td>${list.datatype}</td>
                                            <td>${list.options} <input type="hidden" id="options2${status.count}" value="${list.options2}"/></td>
                                            <td><c:if test="${list.status==true}">Active</c:if><c:if test="${list.status==false}">Disabled</c:if></td>
                                            <td><fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${list.dateadded}"/></td>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEFACILITYPOLICY') or hasRole('PRIVILEGE_DELETEFACILITYPOLICY')">
                                                <td align="center">
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEFACILITYPOLICY')">
                                                        <a href="#updatePolicy" onclick="$('#policyid').val('${list.policyid}'); $('#policyname2').val('${list.policyname}'); $('#pdatatype2').val('${list.datatype}'); $('#policyDesc2').val('${list.description}'); updatePolicy(${list.policyid},${status.count}); ajaxSubmitData('entityPolicySetting.htm', 'updateContentResp', 'act=b&i=${list.policyid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-edit"></i></a>
                                                        </security:authorize>
                                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITYPOLICY')">
                                                        <a href="#deleteFacPolicy" data-dismiss="modal" aria-hidden="true" class="btn btn-xs btn-bricky tooltips" data-dismiss="modal" aria-hidden="true" data-placement="top" data-original-title="Remove" onClick="var resp = confirm('Delete Facility Policy?');
                                                                if (resp === true) {
                                                                    ajaxSubmitData('entityPolicySetting.htm', 'deleteContentResp', 'act=c&i=${list.policyid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');
                                                                }"><i class="fa fa-times fa fa-white"></i></a>
                                                        </security:authorize>    
                                                </td>
                                            </security:authorize>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </form>
                    </c:if>
                    <c:if test="${empty model.policyList}">
                        <div align="center"><h3>No Facility Policies Registered!</h3></div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<div id="addFacilityPolicy" class="supplierCatalogDialog">
    <div>
        <div id="head">
            <a href="#close" title="Close" onClick="ajaxSubmitData('entityPolicySetting.htm', 'descContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" class="close2">X</a>
            <h2 class="modalDialog-title" id="policyTitle">Add Facility Policy</h2>
            <hr>
        </div>
        <div class="row scrollbar" id="content">

            <div class="form-group row" style="width:100%">
                <div class="col-md-4">
                    <div class="row">
                        <div class="col-md-10">
                            <div class="tile">
                                <h4 class="tile-title">Enter Policy Details</h4>
                                <div class="tile-body">
                                    <form id="entryform">
                                        <div class="form-group required">
                                            <label class="control-label">Policy Category</label>
                                            <select class="form-control col-md-10" id="pcategory" name="pcategory" onChange="">
                                                <option id="0" value="0">-Select Category-</option>
                                                <option id="1" value="Patient Policy" <c:if test="${model.policyObj.category=='Patient Policy'}">selected="selected"</c:if>>Patient Policy</option>
                                                <option id="2" value="Supplier Policy" <c:if test="${model.policyObj.category=='Supplier Policy'}">selected="selected"</c:if>>Supplier Policy</option>
                                                <option id="3" value="Procurement Policy" <c:if test="${model.policyObj.category=='Procurement Policy'}">selected="selected"</c:if>>Procurement Policy</option>
                                            </select>
                                        </div>
                                        <div class="form-group required">
                                            <label class="control-label">Policy Name</label>
                                            <input class="form-control col-md-10" id="policyname" name="policyname" type="text" placeholder="Policy Name">
                                        </div>
                                        <div class="form-group required">
                                            <label class="control-label">Description</label>
                                            <textarea class="form-control col-md-10" rows="2" id="policyDesc" name="description" placeholder="About Policy"></textarea>
                                        </div>
                                        <div class="form-group required">
                                            <label class="control-label">Data Type</label>
                                            <select class="form-control col-md-10" id="pdatatype" name="pdatatype" onChange="">
                                                <option id="0" value="0">-Select Data type-</option>
                                                <option id="1" value="Single Option">Single Option</option>
                                                <option id="2" value="Multiple Option">Multiple Option</option>
                                            </select>
                                        </div>
                                        <div class="form-group required">
                                            <label class="control-label">No. Of Options</label>
                                            <input type="number" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="policyOptions" name="policyOptions" max="5" min="0" size="3">
                                        </div>
                                    </form>
                                </div>
                                <div class="tile-footer">
                                    <button class="btn btn-primary" id="addPolicy" type="button">
                                        <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                                        Add Policy
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <form id="submitPolicy" name="submitPolicy">
                        <div class="row">
                            <div class="col-md-12" id="policyResponse">
                                <div class="tile">
                                    <h4 class="tile-title">Verify Entered Items.</h4>
                                    <table class="table table-sm" id="verifyItems">
                                        <thead>
                                            <tr>
                                                <th>Category</th>
                                                <th>Policy Name</th>
                                                <th>Data Type</th>
                                                <th>Options</th>
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
                                            <button type="button" disabled="disabled" class="btn btn-primary" id="savePolicy">Save New Policy</button>
                                        </div>
                                        <div id="showSaveBtn" style="display:none">
                                            <button type="button" class="btn btn-primary" id="savePolicy2" onClick="ajaxSubmitForm('registerFacPolicy.htm', 'policyResponse', 'submitPolicy');">Save New Policy</button>
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
<div id="updatePolicy" class="registerSupplier updateSupplier">
    <div>
        <div id="head">
            <a href="#close" title="Close" onClick="ajaxSubmitData('entityPolicySetting.htm', 'descContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" class="close2">X</a>
            <h2 class="modalDialog-title">Update Facility Policy Details</h2>
            <hr>
        </div>
        <div class="row scrollbar" id="updateContentResp">
            <form id="submitData2" name="submitData2" style="width:100%">
                <div class="form-group row" style="width:100%">
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-10">
                                <div class="tile">
                                    <h4 class="tile-title">Enter Policy Details</h4>
                                    <div class="tile-body">
                                        <div class="form-group">
                                            <label class="control-label">Policy Category</label>
                                            <select class="form-control col-md-10" id="pcategory2" name="pcategory" onChange="">
                                                <option id="0" value="0">-Select Category-</option>
                                                <option id="1" value="Patient Policy">Patient Policy</option>
                                                <option id="2" value="Supplier Policy">Supplier Policy</option>
                                                <option id="3" value="Procurement Policy">Procurement Policy</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Policy Name</label>
                                            <input class="form-control col-md-10" id="policyname2" name="policyname" type="text" placeholder="Policy Name">
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Description</label>
                                            <textarea class="form-control col-md-10" rows="2" id="policyDesc2" name="description" placeholder="About Policy"></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Data Type</label>
                                            <select class="form-control col-md-10" id="pdatatype2" name="pdatatype" onChange="">
                                                <option id="0" value="0">-Select Data type-</option>
                                                <option id="1" value="Single Option">Single Option</option>
                                                <option id="2" value="Multiple Option">Multiple Option</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <button type="button" class="btn btn-dark-grey" id="updatePolicy" onClick="updateAddPolicy(0);">Add Option</button>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="tile">
                                <h4 class="tile-title">Update Policy Options/Attributes</h4>
                                <div class="tile-body">
                                    <div class="col-md-10" id="policy2Response">
                                        
                                    </div>
                                    <input type="hidden" id="policyid" name="policy" value=""/>
                                    <input type="hidden" id="optionSize" name="optionSize" value=""/>
                                    <input type="hidden" id="selectedCount" name="selectedCount" value=""/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="tile-footer" style="margin: auto;">
                        <button type="button" class="btn btn-primary" id="updatePolicy2" onClick="ajaxSubmitForm('updateFacPolicy.htm', 'updateContentResp', 'submitData2');">Update Policy</button>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>
<div id="deletePolicy" class="registerSupplier updateSupplier">
    <div>
        <div id="head">
            <a href="#close" title="Close" onClick="ajaxSubmitData('entityPolicySetting.htm', 'descContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" class="close2">X</a>
            <h2 class="modalDialog-title">Facility Policy Deletion</h2>
            <hr>
        </div>
        <div class="row scrollbar" id="deleteContentResp"></div>
    </div>
</div>
<script>
    var itemList = new Set();
    var itemObjectList = [];

    function funRemovePolicy(trId) {
        $('#pcategory').val('0');
        $('#policyname').val('');
        $('#policyDesc').val('');
        $('#policyOptions').val('');
        $('#pdatatype').val('0');

        $('#' + trId + '').remove();
        var addedRecs2 = (parseInt($('#addedRecs2').val()) - 1);
        if (addedRecs2 === 0) {
            hideDiv('showSaveBtn');
            showDiv('hideSaveBtn');
            $('#addedRecs').val(0);
            $('#addedOptions').val('false')
        }
    }

    $(document).ready(function () {
        //$('#policyGridView').DataTable();
        $('#datatype').select2();
        $('#setOptionsNo').select2();
        $('.select2').css('width', '100%');
        $('#formFacilityPolicy').click(function () {
            $('#pcategory').val('0');
            $('#policyname').val('');
            $('#policyDesc').val('');
            $('#policyOptions').val('');
            $('#pdatatype').val('0');

            window.location = '#addFacilityPolicy';
            initDialog('supplierCatalogDialog');
        });

        $('#addPolicy').click(function () {
            var category = $('#pcategory').val();
            var policyname = $('#policyname').val();
            var description = $('#policyDesc').val();
            var datatype = $('#pdatatype').val();
            var policyOptions = parseInt($('#policyOptions').val());

            var addedRecs = (parseInt($('#addedRecs').val()) + 1);
            var addedRecs2 = parseInt($('#addedRecs2').val());

            if (category !== '0' && policyname !== '' && description !== '' && datatype !== '0' && policyOptions > 0) {
                //alert("No Zibs!!!!");
                $('#pcategory').css('border', '2px solid #ced4da');
                $('#policyname').css('border', '2px solid #ced4da');
                $('#pdatatype').css('border', '2px solid #ced4da');
                $('#policyDesc').css('border', '2px solid #ced4da');
                $('#policyOptions').css('border', '2px solid #ced4da');

                var addedOptions = $('#addedOptions').val();

                addFacilityOptions(category, policyname, policyOptions, policyname, description, datatype, policyOptions, itemList, itemObjectList, addedRecs);

            } else {
                if (category === '0') {
                    //alert("No datatype!!!!");
                    $('#pcategory').focus();
                    $('#pcategory').css('border', '2px solid #f50808c4');
                }
                if (policyname === '') {
                    //alert("No policyname!!!!");
                    $('#policyname').focus();
                    $('#policyname').css('border', '2px solid #f50808c4');
                }
                if (policyname !== '') {
                    $('#policyname').css('border', '2px solid #6d0a70');
                }
                if (datatype === '0') {
                    //alert("No datatype!!!!");
                    $('#pdatatype').focus();
                    $('#pdatatype').css('border', '2px solid #f50808c4');
                }
                if (datatype !== '0') {
                    $('#pdatatype').css('border', '2px solid #ced4da');
                }
                if (description === '') {
                    //alert("No description!!!!");
                    $('#policyDesc').focus();
                    $('#policyDesc').css('border', '2px solid #f50808c4');
                }
                if (description !== '') {
                    $('#policyDesc').css('border', '2px solid #ced4da');
                }
                if (!(policyOptions > 0) || policyOptions === 0) {
                    //alert("No policyOptions!!!!");
                    $('#policyOptions').focus();
                    $('#policyOptions').css('border', '2px solid #f50808c4');
                }
                if (policyOptions !== 0) {
                    $('#policyOptions').css('border', '2px solid #ced4da');
                }
            }
        });
    })

    function addFacilityOptions(category, policyName, num, policyname, description, datatype, policyOptions, itemList, itemObjectList, addedRecs) {
        var optionList = new Set();
        var options = [];

        var pHtmlContent = '';
        for (var x = 1; x <= num; x++) {
            pHtmlContent += '<div class="form-group">' +
                    '<label>Attribute/Option ' + x + '</label>' +
                    '<input type="text" id="pOption' + x + '" name="pOption' + x + '" value="" placeholder="Enter Option ' + x + '" class="form-control col-md-8"/>' +
                    '<small><font color="red" id="codeError"></font></small>' +
                    '</div>';
        }
        $.confirm({
            title: '<h3>Add ' + policyName + ' Options</h3>',
            content: '<h4 class="itemTitle">Fill All Fields</h4>' +
                    '' + pHtmlContent + '',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                formSubmit: {
                    text: 'Add Options',
                    btnClass: 'btn-purple submit',
                    action: function () {
                        //var res = this.$content.find('input:radio[name=res]:checked');
                        var validateOptions = true;
                        for (var x = 1; x <= num; x++) {
                            $('#pOption' + x + '').css('border', '2px solid #ced4da');
                            var checkOptionEntry = $('#pOption' + x + '').val(); //this.$content.find('#pOption'+x+'');
                            if (checkOptionEntry !== '') {
                                options.push(checkOptionEntry);
                            } else {
                                //if (optionList.has(checkOptionEntry)){
                                //    alert('Option Already Added!!');
                                //}
                                $('#pOption' + x + '').focus();
                                $('#pOption' + x + '').css('border', '2px solid #f50808c4');
                                validateOptions = false;
                            }
                        }
                        if (validateOptions === false) {
                            return false;
                        } else {

                            $('#addedOptions').val('true');
                            $('#enteredItemsBody').append(
                                    '<tr id="row' + addedRecs + '">' +
                                    '<td>' + category + '<input type=\'hidden\' name=\'pCat' + addedRecs + '\' id=\'pCat' + addedRecs + '\' value=\'' + category + '\'/></td>' +
                                    '<td>' + policyname + '<input type=\'hidden\' name=\'pName' + addedRecs + '\' id=\'pName' + addedRecs + '\' value=\'' + policyname + '\'/></td>' +
                                    '<td>' + datatype + ' <input type=\'hidden\' name=\'dType' + addedRecs + '\' id=\'dType' + addedRecs + '\' value=\'' + datatype + '\'/></td>' +
                                    '<td>' + policyOptions + '<input type=\'hidden\' name=\'pOptionsCount' + addedRecs + '\' id=\'pOptionsCount' + addedRecs + '\' value=\'' + policyOptions + '\'/><input type=\'hidden\' name=\'pOptions' + addedRecs + '\' id=\'pOptions' + addedRecs + '\' value=\'\'/></td>' +
                                    '<td>' + description + '<input type=\'hidden\' name=\'pDesc' + addedRecs + '\' id=\'pDesc' + addedRecs + '\' value=\'' + description + '\'/></td>' +
                                    //'<td>' + $('#form' + itemForm).data('name') + '</td>' +
                                    '<td class="center">' +
                                    '<span class="badge badge-danger icon-custom" onclick="funRemovePolicy(\'row' + addedRecs + '\');">' +
                                    '<i class="fa fa-trash-o"></i></span></td></tr>'
                                    );

                            document.getElementById("entryform").reset();
                            $('#pcategory').css('border', '2px solid #6d0a70');
                            $('#policyname').css('border', '2px solid #6d0a70');
                            $('#pdatatype').css('border', '2px solid #6d0a70');
                            $('#policyOptions').css('border', '2px solid #6d0a70');
                            $('#policyDesc').css('border', '2px solid #6d0a70');
                            var data = {
                                cat: category,
                                name: policyname,
                                datatype: datatype,
                                options: policyOptions,
                                description: description,
                                optionsAdded: options
                            };
                            itemList.add(policyname);
                            itemObjectList.push(data);
                            //Increment Count Of List To Save For Controlling Elements On Save Side
                            $('#addedRecs').val(addedRecs);
                            var addedRecs2 = (parseInt($('#addedRecs2').val()) + 1);
                            $('#addedRecs2').val(addedRecs2);
                            //Show Button To Register Item Added To Save Side
                            showDiv('showSaveBtn');
                            hideDiv('hideSaveBtn');
                            //Clear Fields
                            $('#pcategory').val('0');
                            $('#policyname').val('');
                            $('#policyDesc').val('');
                            $('#policyOptions').val('');
                            $('#pdatatype').val('0');

                            //Set Options Added To Input Field For Record
                            var optionVals = "";
                            for (var i = 0; i < options.length; i++) {
                                optionVals += options[i] + ":";
                            }
                            $('#pOptions' + addedRecs + '').val(optionVals);
                        }
                    }
                },
                close: {
                    text: 'Cancel',
                    btnClass: 'btn-red'
                }
            },
            onContentReady: function () {}
        });
    }

    function updatePolicy(id, count) {
        window.location = '#updatePolicy';
        var str = $("#options2" + count + "").val();
        var res = str.split(":");
        //alert("res ::: " + res);
        $("#optionSize").val((res.length-1));
        $("#selectedCount").val(""+count+"");
        var pHtmlContent = '';
        var y = 0;
        for (var x = 0; x < res.length; x++) {
            y += 1;
            if (x !== (res.length - 1)) {
                pHtmlContent += '<div class="form-group">' +
                        '<label>Attribute/Option ' + y + '</label>' +
                        '<input type="text" id="pOptionId' + x + '" name="pOptionId' + x + '" value="' + res[x] + '" placeholder="Enter Option ' + x + '" class="form-control col-md-8"/>' +
                        '<input type="text" id="pOption' + x + '" name="pOption' + x + '" value="' + res[x] + '" placeholder="Enter Option ' + x + '" class="form-control col-md-8"/>' +
                        '<small><font color="red" id="codeError"></font></small>' +
                        '</div>';
            }
        }
        pHtmlContent += '<div class="form-group" id="y'+(y)+'"></div>';
        $("#policy2Response").html(pHtmlContent);
    }
    function updateAddPolicy(id) {
        var count = parseInt($("#optionSize").val());
        $("#optionSize").val(count+1);
        //alert("res ::: " + res);
        var pHtmlContent = '';
        var y = count+1;
        
        pHtmlContent += '<div class="form-group">' +
                        '<label>Attribute/Option ' + y + '</label>' +
                        '<input type="hidden" id="pOptionId' + y + '" name="pOptionId' + y + '" value="" placeholder="Enter Option ' + y + '" class="form-control col-md-8"/>' +
                        '<input type="text" id="pOption' + y + '" name="pOption' + y + '" value="" placeholder="Enter Option ' + y + '" class="form-control col-md-8"/>' +
                        '<small><font color="red" id="codeError"></font></small>' +
                        '</div>';
        pHtmlContent += '<div class="form-group" id="y'+(y+1)+'"></div>';        
        $("#y"+y).html(pHtmlContent);
    }
    $('#deleteFacPolicy').click(function () {
        window.location = '#deletePolicy';
    });
</script>