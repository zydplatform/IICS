<%-- 
    Document   : addMoreUnits
    Created on : Sep 14, 2018, 5:20:23 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="form-group row" style="width:100%">
    <div class="col-md-4">
        <div class="row">
            <div class="col-md-10">
                <div class="tile">
                    <h4 class="tile-title"><c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if> Details</h4>
                        <div class="tile-body">
                            <form id="entryform">
                                <div class="form-group required">
                                        <label class="control-label"><c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if> Name</label>
                                <input class="form-control col-md-10" id="unitname" name="unitname" type="text" placeholder="<c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if> Name">
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Short Name</label>
                                    <input class="form-control col-md-10" id="shortname" name="shortname" type="text" placeholder="Short Name">
                                </div>
                                <div class="form-group required">
                                    <label class="control-label">Description</label>
                                        <textarea class="form-control col-md-10" rows="2" id="unitDesc" name="description" placeholder="About <c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if>"></textarea>
                                </div>                                                
                            </form>
                        </div>
                        <div class="tile-footer">
                            <button class="btn btn-primary" id="addMoreUnits" type="button">
                                <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                                    Add <c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <form id="submitUnit" name="submitUnit">
                <div class="row">
                    <div class="col-md-12" id="unitResponse">
                        <div class="tile">
                            <h4 class="tile-title">Verify Entered Items.</h4>
                            <table class="table table-sm" id="verifyItems">
                                <thead>
                                    <tr>
                                        <th>Unit Name</th>
                                        <th>Short Name</th>
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
                                        <button type="button" disabled="disabled" class="btn btn-primary" id="saveUnit">Save New <c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if></button>
                                </div>
                                <div id="showSaveBtn" style="display:none">
                                        <button type="button" class="btn btn-primary" id="saveUnit2" onClick="ajaxSubmitForm('registerUnitsList.htm', 'addUnitResponse-pane', 'submitUnit');">Save New <c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if></button>
                            </div>
                        </div>
                    </div>
                    <div class="form-group"></div>
                </div>
            </div>
        </form>
    </div>
</div>
                            <script>
                                                            $(document).ready(function () {
        
        $('#formAddMoreFacilityUnit').click(function () {
            $('#unitname').val('');
            $('#shortname').val('');
            $('#unitDesc').val('');

            window.location = '#addMoreFacilityUnit';
            initDialog('supplierCatalogDialog');
        });

        $('#addMoreUnits').click(function () {
            var unitname = $('#unitname').val();
            var shortname = $('#shortname').val();
            var description = $('#unitDesc').val();

            var addedRecs = (parseInt($('#addedRecs').val()) + 1);
            var addedRecs2 = parseInt($('#addedRecs2').val());

            if (unitname !== '' && description !== '') {
                //alert("No Zibs!!!!");
                $('#unitname').css('border', '2px solid #ced4da');
                $('#unitDesc').css('border', '2px solid #ced4da');
                $.ajax({
                    type: 'GET',
                    url: "checkExistingRecord.htm",
                    data: {act:'a',i:0,b:'b',sStr:unitname},
                    success: function (items) {
                        //alert('Found Item'+items);
                    }
                });

                addFacilityUnit(unitname, shortname, description, itemList, itemObjectList, addedRecs);

            } else {
                if (unitname === '') {
                    //alert("No policyname!!!!");
                    $('#unitname').focus();
                    $('#unitname').css('border', '2px solid #f50808c4');
                }
                if (unitname !== '') {
                    $('#unitname').css('border', '2px solid #6d0a70');
                }
                if (description === '') {
                    //alert("No description!!!!");
                    $('#unitDesc').focus();
                    $('#unitDesc').css('border', '2px solid #f50808c4');
                }
                if (description !== '') {
                    $('#unitDesc').css('border', '2px solid #ced4da');
                }
            }
        });
    
    });
    function addFacilityUnit(unitname, shortname, description, itemList, itemObjectList, addedRecs) {
        $('#addedOptions').val('true');
                            $('#enteredItemsBody').append(
                                    '<tr id="row' + addedRecs + '">' +
                                    '<td>' + unitname + '<input type=\'hidden\' name=\'uUnitName' + addedRecs + '\' id=\'uUnitName' + addedRecs + '\' value=\'' + unitname + '\'/></td>' +
                                    '<td>' + shortname + ' <input type=\'hidden\' name=\'uShortName' + addedRecs + '\' id=\'uShortName' + addedRecs + '\' value=\'' + shortname + '\'/></td>' +
                                    '<td>' + description + '<input type=\'hidden\' name=\'uDesc' + addedRecs + '\' id=\'uDesc' + addedRecs + '\' value=\'' + description + '\'/></td>' +
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
                                name: unitname,
                                shortname: shortname,
                                description: description
                            };
                            itemList.add(unitname);
                            itemObjectList.push(data);
                            //Increment Count Of List To Save For Controlling Elements On Save Side
                            $('#addedRecs').val(addedRecs);
                            var addedRecs2 = (parseInt($('#addedRecs2').val()) + 1);
                            $('#addedRecs2').val(addedRecs2);
                            //Show Button To Register Item Added To Save Side
                            showDiv('showSaveBtn');
                            hideDiv('hideSaveBtn');
                            //Clear Fields
                            $('#unitname').val('');
                            $('#unitDesc').val('');
                            $('#shortname').val('');
                        
    }
                                                        </script>