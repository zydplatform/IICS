<%-- 
    Document   : nonMedicalPane
    Created on : Oct 29, 2018, 12:23:52 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div>
    <div class="row user">
        <div class="col-md-12" id="moreClassificationContent">
            <div class="row">
                <div class="col-md-12" id="BldFac">
                    <button class="btn btn-primary pull-right" type="button"  id="registerClassification" onclick="registerClassification()" style="float: right"><i class="fa fa-plus-circle"></i>Add Classification</button>
                </div>
            </div>
            <fieldset>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <table class="table table-hover table-bordered col-md-12" id="nonMedicalClassifications">
                                    <thead class="col-md-12">
                                        <tr>
                                            <th class="center">No</th>
                                            <th class="left">Classification Name</th>
                                            <th class="left">More Information</th>
                                            <th class="center">No. Of Items</th>
                                            <th class="center">Manage</th>
                                        </tr>
                                    </thead>
                                    <tbody class="col-md-12">
                                        <% int c = 1;%>
                                        <c:forEach items="${viewNonMedicalAssetsClassificationList}" var="classifications">
                                            <tr id="${classifications.assetclassificationid}">
                                                <td class="center"><%=c++%></td>
                                                <td class="left">${classifications.classificationname}</td>
                                                <td class="left">${classifications.moreinfo}</td>
                                                <td class="center"><span class="badge badge-pill badge-success" onclick="viewClassificationItems(${classifications.assetclassificationid}, '${classifications.classificationname}')">${classifications.numberOfAssets}</span></td>
                                                <td class="center">
                                                    <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                                        <div class="btn-group" role="group">
                                                            <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <i class="fa fa-sliders" aria-hidden="true"></i>
                                                            </button>
                                                            <div class="dropdown-menu dropdown-menu-left">
                                                                <a class="dropdown-item" href="#!" id="load-edit-classification" onclick="editClassificationDetails(${classifications.assetclassificationid}, '${classifications.classificationname}', '${classifications.moreinfo}')">Edit Classification</a><hr>
                                                                <a class="dropdown-item" id="load-additemsto-classifcation" onclick="addItemsToClassification(${classifications.assetclassificationid}, '${classifications.classificationname}')">Add Items</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
</div>
<!--add classification dialog-->
<div class="row">
    <div class="col-md-12">
        <div id="addNewNonClassification" class="supplierCatalogDialog">
            <div id="divSection4">
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h5 class="modalDialog-title">Add Classification</h5>
                </div>
                <div class="row scrollbar" id="addclassificationContent" style="height: 530px;">

                </div>
            </div>
        </div>

    </div>
</div>

<!-- add asset to classification-->
<div class="row">
    <div class="col-md-12">
        <div id="addNewNonItems" class="newPatientFileForm">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h5 class="modalDialog-title">Add Item</h5>
                </div>
                <div class="row scrollbar" id="addNonItemContents" style="height: 530px;">
vbbbbbbbbbbbbbbbbbbbbbbbbbb
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#nonMedicalClassifications').DataTable();
    });
    
     function registerClassification() {
        window.location = '#addNewNonClassification';
        initDialog('supplierCatalogDialog');
        ajaxSubmitData('medicalandnonmedicalequipment/addNewNonClassification.htm', 'addclassificationContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }

    function editClassificationDetails(assetclassificationid, classificationname, moreinfo) {
        $.dialog({
            title: '<strong class="center"> EDIT CLASSIFICATION DETAILS. </strong>',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Classification Name</label><br>' +
                    '<span id="errormessage" style="color: red"><strong><strong></span>' +
                    '<input  id="editedClassName" type="text" value="' + classificationname + '" class="myform form-control" oninput="checkClassificationName();" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>More Information</label><br>' +
                    '<textarea rows="4" id="editedDesrcription" type="text" value="' + moreinfo + '" class="myform form-control">' + moreinfo + '</textarea>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<div class="col-sm-12 text-right">'+
                    '<button type="button" class="btn btn-primary" style="float: right" id="updateClassDetails" onclick="UpdateClassDetails(' + assetclassificationid + ')">' + "SAVE" + '</button>' +
                    '</div>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true

        });
    }

    function UpdateClassDetails(assetclassificationid) {
        var classificationname = $('#editedClassName').val();
        var description = $('#editedDesrcription').val();

        $.ajax({
            type: "GET",
            cache: false,
            url: "medicalandnonmedicalequipment/updateClassificationDetails.htm",
            data: {assetclassificationid: assetclassificationid, classificationname: classificationname, description: description},
            success: function (data) {
                if (data === "success") {
                    $.toast({
                        heading: 'Success',
                        text: 'Successfully Updated Classification.',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    ajaxSubmitData('medicalandnonmedicalequipment/nonMedicalEquipmentPane.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    window.location = '#close';
                } else {
                    $.toast({
                        heading: 'Error',
                        text: 'An Unexpected Error Occured While Trying To Update Classification.',
                        icon: 'error'
                    });
                    ajaxSubmitData('medicalandnonmedicalequipment/nonMedicalEquipmentPane.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    window.location = '#close';
                }
            }
        });

    }


    function addItemsToClassification(assetclassificationid, classificationname) {
        window.location = '#addNewNonItems';
        initDialog('newPatientFileForm');
        ajaxSubmitData('medicalandnonmedicalequipment/addNewNonMedicalItem.htm', 'addNonItemContents', 'assetclassificationid='+assetclassificationid+'&classificationname='+classificationname+'&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }

    function viewClassificationItems(assetclassificationid, classificationname) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "medicalandnonmedicalequipment/viewNonMedicalEquipment.htm",
            data: {assetclassificationid: assetclassificationid, classificationname: classificationname},
            success: function (data) {
                $.dialog({
                    title: '<strong class="center">Classification:' + '<span class="badge badge-patientinfo patientConfirmFont">' + classificationname + '</span>' + '</strong>',
                    content: '' + data,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
    }