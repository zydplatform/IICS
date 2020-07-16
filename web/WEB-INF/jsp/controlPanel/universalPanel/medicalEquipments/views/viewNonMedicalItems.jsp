<%-- 
    Document   : viewNonMedicalItems
    Created on : Oct 30, 2018, 11:58:29 AM
    Author     : IICS
--%>

<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <div class="form-group bs-component">
            <input id="classificationid" class="form-group" type="hidden" value="${assetclassificationid}"/>
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="tile">
        <table class="table table-hover table-striped table-bordered" id="medicalEquipmentTables">
            <thead>
                <tr>
                    <th class="center">#</th>
                    <th>Item</th>
                    <th>More Info.</th>
                    <th>Edit</th>
                </tr>
            </thead>
            <tbody>
                <% int a = 1;%>
                <c:forEach items="${viewNonMedicalAssetsList}" var="assets">
                    <tr id="${assets.assetsid}">
                    <td class="center"><%=a++%></td>
                    <td class="">${assets.assetsname}</td>
                    <td class="">${assets.moreinfo}</td>
                    <td class="">
                        <button onclick="manageMedicalEquipments(${assets.assetsid},'${assets.assetsname}','${assets.moreinfo}');"  title="Manage Donors" class="btn btn-primary btn-sm add-to-shelf">
                            <i class="fa fa-edit"></i>
                        </button>
                    </td>
                </tr>
                </c:forEach>
                
            </tbody>
        </table>
    </div>
</div>
<script>
    $('#medicalEquipmentTables').DataTable();
    
    function manageMedicalEquipments(assetsid, assetsname, moreinfo){
        $.dialog({
            title: '<strong class="center"> EDIT ITEM DETAILS. </strong>',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Item Name</label><br>' +
                    '<span id="errormessage" style="color: red"><strong><strong></span>' +
                    '<input  id="editedName" type="text" value="' + assetsname + '" class="myform form-control" oninput="checkItemName();" required />' +
                    '</div>'+
                    '<div class="form-group">' +
                    '<label>More Information</label><br>' +
                    '<textarea rows="4" id="editedDesrcription" type="text" value="' + moreinfo + '" placeholder="Please Enter More Info. Here" class="myform form-control">' + moreinfo + '</textarea>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<div class="col-sm-12 text-right">'+
                    '<button class="btn btn-primary" type="button" id="updateItemDetails" onclick="UpdateItemDetails(' + assetsid + ')">' + "SAVE" + '</button>' +
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
    
        function UpdateItemDetails(assetsid) {
        var assetsname = $('#editedName').val();
        var description = $('#editedDesrcription').val();

        $.ajax({
            type: "GET",
            cache: false,
            url: "medicalandnonmedicalequipment/updateEquipmentDetails.htm",
            data: {assetsid: assetsid, assetsname: assetsname, description: description},
            success: function (data) {
                if (data === "success") {
                    $.toast({
                        heading: 'Success',
                        text: 'Successfully Updated Asset.',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    ajaxSubmitData('medicalandnonmedicalequipment/nonMedicalEquipmentPane.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    window.location = '#close';
                } else {
                    $.toast({
                        heading: 'Error',
                        text: 'An Unexpected Error Occured While Trying To Update Asset.',
                        icon: 'error'
                    });
                    ajaxSubmitData('medicalandnonmedicalequipment/nonMedicalEquipmentPane.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    window.location = '#close';
                }
            }
        });

    }
</script>

