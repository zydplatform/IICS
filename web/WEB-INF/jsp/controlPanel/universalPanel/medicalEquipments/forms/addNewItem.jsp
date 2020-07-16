<%-- 
    Document   : addNewItem
    Created on : Oct 29, 2018, 11:25:17 AM
    Author     : IICS
--%>
<style>
    .error
    {
        border:2px solid red;
    }

    .myform{
        width:100% !important;
    }
</style>
<div class="col-md-4">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Enter Item Details</h4>
                <div class="tile-body">
                    <form id="itementryform">
                        <div class="form-group">
                            <label class="control-label">Classification:</label>
                            <input class="form-control myform" id="assetclassificationid" value="${assetclassificationid}" type="hidden">
                            <input class="form-control myform" id="classificationname" value="${classificationname}" type="text" disabled="true">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Item Name</label>
                            <input class="form-control myform"  oninput="checkEquipmentName();" id="equipmentname" type="text" placeholder="Enter Item Name">
                            <h6 id="itemResults"></h6>
                        </div>
                        <div class="form-group">
                            <label class="control-label">More Information</label>
                            <textarea class="form-control myform" rows="4" id="description" type="text" placeholder="Enter More Info. About Classification"></textarea>
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="captureItemsDetails" type="button">
                        <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                        Add Item
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="col-md-8">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Entered Item(s).</h4>
                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Item Name</th>
                            <th>More Information</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody id="enteredItemsBody">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="saveEquipments" disabled="true">
                        <i class="fa fa-save"></i>
                        Save
                    </button>
                </div>
            </div>
            <span id="incrementx" class="hidedisplaycontent">0</span>
        </div>
    </div>
</div>
<script>
    var itemList = new Set();
    var itemObjectList = [];
    var itemtestSet = new Set();
    $('#captureItemsDetails').click(function () {
        var itemname = $('#equipmentname').val();
        var description = $('#description').val();
        var count = $('#incrementx').html();

        if (itemname !== '') {
            if (itemtestSet.has(itemname)) {
                $.alert({
                    title: '',
                    content: '<div class="center">' + '<font size="5">' + '<strong class="text-danger">' + itemname + '</strong> &nbsp;Already Exists!!</font></div>',
                    type: 'red',
                    typeAnimated: true
                });
            } else {
                document.getElementById('saveEquipments').disabled = false;
                var xcount = parseInt(count) + 1;
                $('#incrementx').html(xcount);
                $('#enteredItemsBody').append(
                        '<tr id="rowfg' + count + '">' +
                        '<td class="center">' + itemname + '</td>' +
                        '<td class="center" >' + description + '</td>' +
                        '<td class="center">' +
                        '<span class="badge badge-danger icon-custom" onclick="remove(\'' + count + '\')">' +
                        '<i class="fa fa-trash-o"></i></span></td></tr>'
                        );
                document.getElementById("itementryform").reset();
                $('#selectClassification').css('border', '2px solid #6d0a70');
                $('#itemname').css('border', '2px solid #6d0a70');
                $('#description').css('border', '2px solid #6d0a70');
                var data = {
                    itemname: itemname,
                    description: description,
                    itemxid: xcount
                };
                itemtestSet.add(count);
                itemList.add(itemname);
                itemObjectList.push(data);
            }

        } else {

            $('#selectClassification').focus();
            $('#selectClassification').css('border', '2px solid #f50808c4');
            $('#itemname').focus();
            $('#itemname').css('border', '2px solid #f50808c4');
            $('#description').focus();
            $('#description').css('border', '2px solid #f50808c4');
        }
    });

    function remove(count) {
        $('#rowfg' + count).remove();
        itemtestSet.delete(count);
    }
    
    //CHECKING EQUIPMENT NAME
    function checkEquipmentName(){
        var assetclassificationid = $('#assetclassificationid').val();
        var equipmentname = $('#equipmentname').val();
        var ItemResults = $("#itemResults");
        
        var size = equipmentname.length;
        if (size >= 3) {
            $.ajax({
                type: "POST",
                cache: false,
                url: "medicalandnonmedicalequipment/checkEquipmentName.htm",
                data: {searchValue: equipmentname, assetclassificationid: assetclassificationid},
                success: function (data) {
                    if (data === "exists") {
                        $('#equipmentname').addClass('error');
                        ItemResults.css("color", "red");
                        ItemResults.text(equipmentname + " Already Exists");
                    } else {
                        $('#equipmentname').removeClass('error');
                        ItemResults.css("color", "green");
                        ItemResults.text(" ");
                    }
                }
            });
        }
    }

//SAVING EQUIMENT
    $('#saveEquipments').click(function (){
        var classificationid = $('#assetclassificationid').val();
        
        if (itemObjectList.length > 0) {
            var data = {
                assetclassificationid: classificationid,
                equipments: JSON.stringify(itemObjectList)
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'medicalandnonmedicalequipment/saveEquipment.htm',
                success: function (res) {
                    if (res === "Success") {
                        document.getElementById('equipmentname').value = "";
                        document.getElementById('description').value = "";
                        $.toast({
                            heading: 'Success',
                            text: 'Item Added Successfully.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        ajaxSubmitData('medicalandnonmedicalequipment/medicalEquipmentPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        window.location = '#close';
                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'An Unexpected Error Occured While Trying To Add Item.',
                            icon: 'error'
                        });
                        ajaxSubmitData('medicalandnonmedicalequipment/medicalEquipmentPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        window.location = '#close';

                    }
                }
            });
        }
    });
    
    
</script>