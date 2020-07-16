<%-- 
    Document   : makedonation
    Created on : Jul 2, 2009, 1:41:49 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript" src="static/js/jquery.autocomplete.min.js"></script>
<script>
    document.getElementById('collapsethistestcontent').style.display = 'none';
    function collapseandExapand(id) {
        if ($('#' + id).hasClass("activeselected")) {
            $('#' + id).toggleClass('collapseselected activeselected');
            $('#xxicon').attr('class', 'fa fa-2x fa-minus');
            document.getElementById('collapsethistestcontent').style.display = 'block';
            $('#' + id).toggleClass('medicinesactiveselected medicinescollapseselected');
            $('#medicinesxxicon').attr('class', 'fa fa-2x fa-plus');
            document.getElementById('medicinescollapsethistestcontent').style.display = 'none';
        } else if ($('#' + id).hasClass("collapseselected")) {
            $('#' + id).toggleClass('activeselected collapseselected');
            $('#xxicon').attr('class', 'fa fa-2x fa-plus');
            document.getElementById('collapsethistestcontent').style.display = 'none';

        }
    }

    function medicinesCollapseandExapand(id) {
        if ($('#' + id).hasClass("medicinesactiveselected")) {
            $('#' + id).toggleClass('medicinescollapseselected medicinesactiveselected');
            $('#medicinesxxicon').attr('class', 'fa fa-2x fa-minus');
            document.getElementById('medicinescollapsethistestcontent').style.display = 'block';
        } else if ($('#' + id).hasClass("medicinescollapseselected")) {
            $('#' + id).toggleClass('medicinesactiveselected medicinescollapseselected');
            $('#medicinesxxicon').attr('class', 'fa fa-2x fa-plus');
            document.getElementById('medicinescollapsethistestcontent').style.display = 'none';
        }
    }
</script>
<style>
    .error
    {
        border:2px solid red;
    }
    .autocomplete-suggestions { border: 1px solid #2E8B57; width: 26.5% !important; background: #fff; margin-top: -16px; cursor: default; overflow: auto; z-index: 99999999 !important; }
    .autocomplete-suggestion { padding: 10px 5px; width: 100% !important; font-size: 1.2em; white-space: nowrap; overflow: hidden; z-index: 99999999 !important;}
    .autocomplete-selected { background: #f0f0f0; }
    .autocomplete-suggestions strong { font-weight: normal; color: #3399ff; }

    .error
    {
        border:2px solid red;
    }
    .myform{
        width: 100% !important;
    }

    * {
        box-sizing: border-box;
    }

    body {
        font: 16px Arial;  
    }

    #searchfield { display: block; width: 100%; text-align: center; margin-bottom: 35px; }

    #searchfield form {
        display: inline-block;
        background: #eeefed;
        padding: 0;
        margin: 0;
        padding: 5px;
        border-radius: 3px;
        margin: 5px 0 0 0;
    }
    #searchfield form .biginput {
        width: 600px;
        height: 40px;
        padding: 0 10px 0 10px;
        background-color: #fff;
        border: 1px solid #c8c8c8;
        border-radius: 3px;
        color: #aeaeae;
        font-weight:normal;
        font-size: 1.5em;
        -webkit-transition: all 0.2s linear;
        -moz-transition: all 0.2s linear;
        transition: all 0.2s linear;
    }
    #searchfield form .biginput:focus {
        color: #858585;
    }

    #medicinescollapsethistest {
        background-color:#D8BFD8 !important;
        color: black !important;
        cursor: pointer;
    }

    #medicinescollapsethistest:hover {
        background-color: plum;
    }

    #collapsethistest {
        background-color:#D8BFD8 !important;
        color: black !important;
        cursor: pointer;
    }

    #collapsethistest:hover {
        background-color: plum;
    }

    .donorFont{
        font-size: 20px;
    }

    .donorcollapsible:after {
        content: '\002B';
        color: white;
        font-weight: bold;
        float: right;
        margin-left: 5px;
    }

    .active:after {
        content: "\2212";
    }

</style>
<div class="col-md-12">
    <div class="tile">
        <fieldset>
            <div class="col-md-12 form-horizontal">
                <div class="row">
                    <div class="col-md-6">
                        <div class="row">
                            <label class="control-label col-md-4"><font size="4"><strong>Donation No.:</strong></font></label>
                            <div class="col-md-8">
                                <input class="form-control col-md-8 donationnos" id="donationno" type="text" value="${donorNumber}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <label class="control-label col-md-4" for="description"><font size="4"><strong>Donation Date:</strong></font></label>
                            <div class="col-md-8">
                                <input class="form-control col-md-8" id="donationDate" type="text" placeholder="Donation Date">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
    </div>
    <div class="row" style="padding-top: 10px;">
        <div class="col-md-12">
            <div class="btn btn-sm horizontalwithwordsleft medicinesactiveselected col-md-12" id="medicinescollapsethistest" onclick="medicinesCollapseandExapand(this.id);">
                <strong><span class="title badge donorFont" style="float: left"><i id="medicinesxxicon" class="fa fa-2x fa-minus"></i>&nbsp; Medicines & Supplies</span></strong>   
            </div>
        </div>
    </div>
    <div class="row" id="medicinescollapsethistestcontent">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="collapse show" id="collapse100" style="">
                        <div class="row" style="margin-top: 0em">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <div class="tile-body">
                                    <div id="search-form_3">
                                        <input id="Searchitem" type="text" oninput="searchItem()" placeholder="Search Item" onfocus="displaySearchResults()" class="search_3 dropbtn"/>
                                    </div>
                                    <div id="myDropdowned" class="search-content">

                                    </div><br>
                                </div>
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h4>Entered Item(s).</h4>
                                <table class="table table-sm table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Item</th>
                                            <th class="right">Batch No</th>
                                            <th class="right">Total Quantity</th>
                                            <th>Expiry Date</th>
                                            <th class="center">Remove</th>
                                        </tr>
                                    </thead>
                                    <tbody id="enteredDonorItemsBody">

                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>	
                </div> <!-- collapse .// -->
            </div>
        </div>
        <div class="modal fade" id="addDonationItems" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width: 100%;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="title">Enter item Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-12">
                                        <form>
                                            <div class="form-group">
                                                <label class="control-label">Item Name:</label>
                                                <input class="form-control myform" id="itemid" value="" type="hidden">
                                                <input class="form-control myform" id="facilitydonorid" value="${facilitydonorid}" type="hidden">
                                                <input class="form-control myform" id="donorname" value="${donorname}" type="hidden">
                                                <input class="form-control myform" id="itemname" value="" type="text" readonly="true">
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">Batch No.:</label>
                                                <input class="form-control myform" id="batchno" oninput="checkBatchNo()" value="" type="text" placeholder="Enter Batch No.">
                                            </div>
                                            <div class="form-group row">
                                                <label class="control-label required">Expiry Date:</label>
                                                <input class="form-control" id="expirydate" onkeypress="return false;" oninput="checkExpiryDate()" type="text" placeholder="Enter Expiry Date">
                                                <h6 id='err'></h6>
                                            </div>
                                            <div class="form-group" id="package">
                                                <label for="itemclass" id="packageLabel"></label>
                                                <input class="form-control" id="packageQty" type="text"  placeholder="Quantity Available" disabled="true">
                                            </div>
                                            <div class="form-group row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="itemclass" id="packsLabel">Quantity</label>
                                                        <input class="form-control" oninput="flagQuantityEmpty()" id="itemQty" type="number"  placeholder="Quantity">
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="itemclass" id="packsLabel">Packs</label>
                                                        <input class="form-control" oninput="flagPacksEmpty()" id="packsQty" type="number"  placeholder="Packs">
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="itemclass" id="packsLabel">loose Items</label>
                                                        <input class="form-control" oninput="flaglooseEmpty()" id="looseQty" type="number"  placeholder="loose Items">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="itemclass" id="packsLabel">Total Quantity</label>
                                                <input class="form-control" id="totalQty" type="number"  placeholder="Total Quantity" disabled="true">
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" align="right">
                                        <button class="btn btn-primary" id="captureItems" type="submit">
                                            <i class="fa fa-check-circle"></i>
                                            Add Item
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!--    <div class="row" style="padding-top: 10px;">
        <div class="col-md-12">
            <div class="btn btn-sm btn-plum horizontalwithwordsleft activeselected col-md-12" id="collapsethistest" onclick="collapseandExapand(this.id);">
                <strong><span class="title badge donorFont" style="float: left"><i id="xxicon" class="fa fa-2x fa-plus"></i>&nbsp; OTHER ITEMS</span></strong>   
            </div>
        </div>
    </div>
    <div class="row" id="collapsethistestcontent">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="col-md-12" style="margin-top: 0em">
                        <div class="row">
                            <div class="col-md-5">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="tile">
                                            <div class="tile-body">
                                                <form id="otheritementryforms">
                                                    <div class="form-group" id="searchfield">
                                                        <label class="control-label" style="float: left">Item Name:</label>
                                                        <input class="form-control myform" id="otheritemid" type="hidden" placeholder="Item Id"> 
                                                        <div id="searchfield">
                                                            <form><input type="text" name="currency" class="form-control biginput" id="otheritemname" placeholder="Enter Item Name"></form>
                                                        </div>
                                                        <div id="outputbox">
                                                            <p id="outputcontent" style="display: none;"></p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label">Enter Specification:</label>
                                                        <input class="form-control myform" id="specification" type="text" placeholder="Enter Item Specification">
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="itemclass" id="packsLabel">Total Quantity</label>
                                                        <input class="form-control" id="quantity" type="number" oninput="flagOtherQuantityEmpty()"  placeholder="Enter Item Quantity">
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="tile-footer">
                                                <button class="btn btn-primary" id="captureOtherItems" type="button">
                                                    <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                                                    Add Item(s)
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4>Entered Item(s).</h4>
                                        <table class="table table-sm table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>Item</th>
                                                    <th class="right">Item Specifications</th>
                                                    <th>Total Quantity</th>
                                                    <th class="center">Remove</th>
                                                </tr>
                                            </thead>
                                            <tbody id="enteredOtherDonorItemsBody">

                                            </tbody>
                                        </table>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>	
                </div> 
            </div>
        </div>
    </div>-->
    <div class="row" style="padding-top: 10px;">
        <div class="col-md-12">
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="savedonations">
                        <i class="fa fa-save"></i>
                        Save
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var serverDate = '${serverdate}';
    var count = 1000;
    var items = [];
    var otheritems = [];
    var otherExistingItems = [];
    var shelfList = [];
    var shelfCells = new Set();
    var size = 1;
    var itemQty = 0;
    var packsQty = 1;
    var looseQty = 0;
    var totalItemQuantity = 0;
    var batchNoSet = new Set();
    jQuery(document).ready(function () {
        //$('#savedonations').prop('disabled', true);
        var coll = document.getElementsByClassName("donorcollapsible");
        var i;
        for (i = 0; i < coll.length; i++) {
            coll[i].addEventListener("click", function () {
                this.classList.toggle("active");
                var content = this.nextElementSibling;
                if (content.style.maxHeight) {
                    content.style.maxHeight = null;
                } else {
                    content.style.maxHeight = content.scrollHeight + "px";
                }
            });
        }

        var dt = new Date(serverDate);
        var mer = new Date(dt.setMonth(dt.getMonth() + 4));
        $('#expirydate').focus(function () {
            $('#expirydate').datetimepicker({
                pickTime: false,
                format: "DD-MM-YYYY",
                minDate: mer,
                defaultDate: mer,
                todayHighlight: false
            });
        });

        $('#donationDate').datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate)
                    // defaultDate: new Date()
        });

        if (totalQty > 0) {
            $('#captureItems').prop('disabled', false);
        } else {
            $('#captureItems').prop('disabled', true);
        }

        var quantity = $('#quantity').val();
        var otheritemname = $('#otheritemname').val();
        if (quantity > 0 && otheritemname === "") {
            $('#captureOtherItems').prop('disabled', false);
        } else {
            $('#captureOtherItems').prop('disabled', true);
        }


        var itemname = $('#otheritemname').val();
        var otherDonatedItems = [];
        $.ajax({
            type: "POST",
            cache: false,
            url: "internaldonorprogram/fetchOtherDonorItems.htm",
            data: {searchValue: itemname},
            success: function (data) {
                if (data !== null) {
                    var response = JSON.parse(data);
                    console.log(response);
                    for (index in response) {
                        var results = response[index];
                        otherDonatedItems.push({
                            value: results["value"],
                            data: results["data"]
                        });
                    }
                } else {
                    var errMsg = "Does Not Exist";
                    otherDonatedItems.push({
                        errMsg: results[errMsg]
                    });
                }

                console.log(otherDonatedItems);
            }
        });

        $('#otheritemname').autocomplete({
            lookup: otherDonatedItems,
            onSelect: function (suggestion) {
                document.getElementById("otheritemid").value = suggestion.data;
            }
        });

    });

    function checkExpiryDate() {
        var expiry = $('#expirydate').val();
        var c = new Date(new Date(serverDate).getFullYear() + 1, new Date(serverDate).getMonth(), new Date(serverDate).getDate());
        if (expiry <= c) {
            $('#expirydate').addClass('error');
            $('#err').text("Expiry Date Is Less Than A Year");
            $('#err').css("color", "red");
        } else {
            $('#expirydate').removeClass('error');
            $('#err').text("");
            $('#err').css("color", "green");
        }
        console.log("this is c" + c);
    }

    function checkBatchNo() {
        $('#batchno').val(($('#batchno').val()).toString().toUpperCase());
        var batchno = $('#batchno').val();
        var itemid = $('#itemid').val();
        $.ajax({
            type: 'POST',
            data: {batchno: batchno, itemid: itemid},
            url: 'internaldonorprogram/checkBatchNo.htm',
            success: function (res) {
                if (res !== "") {
                    console.log("-------------------------------response" + res);
                    document.getElementById('expirydate').value = res;
                }
            }
        });
    }

    function displaySearchResults() {
        document.getElementById("myDropdowned").classList.add("showSearch");
    }

    window.onclick = function (event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("search-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('showSearch')) {
                    openDropdown.classList.remove('showSearch');
                }
            }
        }
    };


    function searchItem() {
        displaySearchResults();
        var name = $('#Searchitem').val();
        if (name.length >= 3)
            ajaxSubmitDataNoLoader('internaldonorprogram/searchItem.htm', 'myDropdowned', '&name=' + name, 'GET');
        else
            $('#myDropdowned').html('');
    }

    function flagQuantityEmpty() {
        var qty = parseInt($('#itemQty').val());
        if (qty > 0) {
            $('#itemQty').css('border', '2px solid #7d047d');
            itemQty = qty;
            totalItemQuantity = size * itemQty * packsQty + looseQty;
            $('#totalQty').val(totalItemQuantity);
        } else {
            if ($('#itemQty').val() !== '') {
                $('#itemQty').val(1);
            }
            itemQty = 0;
            totalItemQuantity = size * itemQty * packsQty + looseQty;
            $('#totalQty').val(totalItemQuantity);
        }

        if (totalItemQuantity > 0) {
            $('#captureItems').prop('disabled', false);
        } else {
            $('#captureItems').prop('disabled', true);
        }
    }

    function flagPacksEmpty() {
        var qty = parseInt($('#packsQty').val());
        if (qty > 0) {
            $('#packsQty').css('border', '2px solid #7d047d');
            packsQty = qty;
            totalItemQuantity = size * itemQty * packsQty + looseQty;
            $('#totalQty').val(totalItemQuantity);
        } else {
            if ($('#packsQty').val() !== '') {
                $('#packsQty').val(1);
            }
            packsQty = 1;
            totalItemQuantity = size * itemQty * packsQty + looseQty;
            $('#totalQty').val(totalItemQuantity);
        }

        if (totalItemQuantity > 0) {
            $('#captureItems').prop('disabled', false);
        } else {
            $('#captureItems').prop('disabled', true);
        }
    }

    function flaglooseEmpty() {
        var qty = parseInt($('#looseQty').val());
        if (qty > 0) {
            $('#looseQty').css('border', '2px solid #7d047d');
            looseQty = qty;
            totalItemQuantity = size * itemQty * packsQty + looseQty;
            $('#totalQty').val(totalItemQuantity);
        } else {
            if ($('#looseQty').val() !== '') {
                $('#looseQty').val(1);
            }
            looseQty = 0;
            totalItemQuantity = size * itemQty * packsQty + looseQty;
            $('#totalQty').val(totalItemQuantity);
        }

        if (totalItemQuantity > 0) {
            $('#captureItems').prop('disabled', false);
        } else {
            $('#captureItems').prop('disabled', true);
        }
    }

    function flagOtherQuantityEmpty() {
        var qty = parseInt($('#quantity').val());
        var otheritemname = $('#otheritemname').val();
        if (otheritemname === "") {
            $('#captureOtherItems').prop('disabled', true);
            $('#otheritemname').css("border", "2px solid red");
        } else {
            $('#otheritemname').css("border", "");
            if (qty > 0) {
                $('#captureOtherItems').prop('disabled', false);
            } else {
                $('#captureOtherItems').prop('disabled', true);
            }
        }
    }

    function requestFocus(id) {
        $('#' + id).focus();
    }

    $('#captureOtherItems').click(function () {
        var otheritemid = $('#otheritemid').val();
        var otheritemname = $('#otheritemname').val();
        var itemspecification = $('#specification').val();
        var otherqty = $('#quantity').val();

        //Edits 
        if (itemspecification === '') {
            $.confirm({
                title: '<h3>Missing Fileds!</h3>',
                content: '<h4 class="itemTitle">Item missing <strong>Specification</strong></h4>',
                type: 'orange',
                icon: 'fa fa-warning',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Save Anyway',
                        btnClass: 'btn-orange',
                        action: function () {
                            $('#enteredOtherDonorItemsBody').append(
                                    '<tr id="row' + count + '">' +
                                    '<td>' + otheritemname + '</td>' +
                                    '<td style="display: none">' + otheritemid + '</td>' +
                                    '<td class="right">' + itemspecification + '</td>' +
                                    '<td class="right">' + $('#quantity').val() + '</td>' +
                                    '<td class="center">' +
                                    '<span class="badge badge-danger icon-custom" onclick="removeOther(\'' + count + '\')">' +
                                    '<i class="fa fa-trash-o"></i></span></td>' +
                                    '</tr>'
                                    );
                            var data = {
                                count: count,
                                otheritemname: otheritemname,
                                otheritemid: otheritemid,
                                itemspecification: itemspecification,
                                newotherqty: parseInt($('#quantity').val())
                            };
                            $('#otheritemname').val('');
                            $('#quantity').val('');
                            $('#specification').val('');
                            otheritems.push(data);
                            count = count + 1;
                        }
                    },
                    close: {
                        text: 'Add Missing Fields',
                        btnClass: 'btn-purple',
                        action: function () {
                            requestFocus('specification');
                        }
                    }
                }
            });
        } else {
            $('#enteredOtherDonorItemsBody').append(
                    '<tr id="row' + count + '">' +
                    '<td>' + otheritemname + '</td>' +
                    '<td style="display: none">' + otheritemid + '</td>' +
                    '<td class="right">' + itemspecification + '</td>' +
                    '<td class="right">' + otherqty + '</td>' +
                    '<td class="center">' +
                    '<span class="badge badge-danger icon-custom" onclick="removeOther(\'' + count + '\')">' +
                    '<i class="fa fa-trash-o"></i></span></td>' +
                    '</tr>'
                    );
            var data = {
                count: count,
                otheritemname: otheritemname,
                otheritemid: otheritemid,
                itemspecification: itemspecification,
                newotherqty: parseInt($('#quantity').val())
            };
            $('#otheritemname').val('');
            $('#quantity').val('');
            $('#specification').val('');
            count = count + 1;
        }
        otheritems.push(data);
    });

    function removeOther(count) {
        $('#row' + count).remove();
        for (i in otheritems) {
            if (otheritems[i].count === count) {
                otheritems[i].splice(i, 1);
                break;
            }
        }
    }

    $('#captureItems').click(function () {
        var itemid = $('#itemid').val();
        var batch = $('#batchno').val();
        var qty = totalItemQuantity;
        var expiry = $('#expirydate').val();
        var batchSize = batch.length;
        if (qty > 0) {
            if (batch === '' || expiry === '') {
                if (batch === '' && expiry === '') {
                    $.confirm({
                        title: '<h3>Missing Fileds!</h3>',
                        content: '<h4 class="itemTitle">Item missing <strong>Batch No</strong> And <strong>Expiry Date.</strong></h4>',
                        type: 'orange',
                        icon: 'fa fa-warning',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Save Anyway',
                                btnClass: 'btn-orange',
                                action: function () {
                                    $('#enteredDonorItemsBody').append(
                                            '<tr id="row' + count + '">' +
                                            '<td>' + $('#itemname').val() + '</td>' +
                                            '<td class="right">' + batch + '</td>' +
                                            '<td class="right">' + $('#totalQty').val() + '</td>' +
                                            '<td>' + expiry + '</td>' +
                                            '<td class="center">' +
                                            '<span class="badge badge-danger icon-custom" onclick="remove(\'' + count + '\')">' +
                                            '<i class="fa fa-trash-o"></i></span></td>' +
                                            '</tr>'
                                            );
                                    $('#addDonationItems').modal('hide');
                                    $('#savedonations').prop('disabled', false);
                                    var data = {
                                        count: count,
                                        itemid: itemid,
                                        batch: batch,
                                        qty: qty,
                                        expiry: expiry,
                                        newqty: parseInt($('#totalQty').val())
                                    };
                                    var found = false;
                                    for (i in items) {
                                        if (items[i].batch === data.batch && items[i].itemid === data.itemid && items[i].expiry === data.expiry) {
                                            items[i].qty = items[i].qty + data.qty;
                                            found = true;
                                            break;
                                        }
                                    }
                                    if (!found) {
                                        items.push(data);
                                    }
                                    $('#batchno').val('');
                                    $('#totalQty').val('');
                                    $('#expirydate').val('');
                                    count = count + 1;
                                }
                            },
                            close: {
                                text: 'Add Missing Fields',
                                btnClass: 'btn-purple',
                                action: function () {
                                    requestFocus('batchno');
                                }
                            }
                        }
                    });
                } else if (batch === '') {
                    $.confirm({
                        title: '<h3>Missing Fileds!</h3>',
                        content: '<h4 class="itemTitle">Item missing <strong>Batch No</strong></h4>',
                        type: 'orange',
                        icon: 'fa fa-warning',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Save Anyway',
                                btnClass: 'btn-orange',
                                action: function () {
                                    $('#enteredDonorItemsBody').append(
                                            '<tr id="row' + count + '">' +
                                            '<td>' + $('#itemname').val() + '</td>' +
                                            '<td class="right">' + batch + '</td>' +
                                            '<td class="right">' + $('#totalQty').val() + '</td>' +
                                            '<td>' + expiry + '</td>' +
                                            '<td class="center">' +
                                            '<span class="badge badge-danger icon-custom" onclick="remove(\'' + count + '\')">' +
                                            '<i class="fa fa-trash-o"></i></span></td>' +
                                            '</tr>'
                                            );
                                    $('#addDonationItems').modal('hide');
                                    var data = {
                                        count: count,
                                        itemid: itemid,
                                        batch: batch,
                                        qty: qty,
                                        expiry: expiry
                                    };
                                    var found = false;
                                    for (i in items) {
                                        if (items[i].batch === data.batch && items[i].itemid === data.itemid && items[i].expiry === data.expiry) {
                                            items[i].qty = items[i].qty + data.qty;
                                            found = true;
                                            break;
                                        }
                                    }
                                    if (!found) {
                                        items.push(data);
                                    }
                                    $('#batchno').val('');
                                    $('#totalQty').val('');
                                    $('#expirydate').val('');
                                    count = count + 1;
                                }
                            },
                            close: {
                                text: 'Add Batch No.',
                                btnClass: 'btn-purple',
                                action: function () {
                                    requestFocus('batchno');
                                }
                            }
                        }
                    });
                } else if (expiry === '') {
                    $.confirm({
                        title: '<h3>Missing Fileds!</h3>',
                        content: '<h4 class="itemTitle">Item missing <strong>Expiry Date.</strong></h4>',
                        type: 'orange',
                        icon: 'fa fa-warning',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Save Anyway',
                                btnClass: 'btn-orange',
                                action: function () {
                                    $('#enteredDonorItemsBody').append(
                                            '<tr id="row' + count + '">' +
                                            '<td>' + $('#itemname').val() + '</td>' +
                                            '<td class="right">' + batch + '</td>' +
                                            '<td class="right">' + $('#totalQty').val() + '</td>' +
                                            '<td>' + expiry + '</td>' +
                                            '<td class="center">' +
                                            '<span class="badge badge-danger icon-custom" onclick="remove(\'' + count + '\')">' +
                                            '<i class="fa fa-trash-o"></i></span></td>' +
                                            '</tr>'
                                            );
                                    $('#addDonationItems').modal('hide');
                                    var data = {
                                        count: count,
                                        itemid: itemid,
                                        batch: batch,
                                        qty: qty,
                                        expiry: expiry
                                    };
                                    var found = false;
                                    for (i in items) {
                                        if (items[i].batch === data.batch && items[i].itemid === data.itemid && items[i].expiry === data.expiry) {
                                            items[i].qty = items[i].qty + data.qty;
                                            found = true;
                                            break;
                                        }
                                    }
                                    if (!found) {
                                        items.push(data);
                                    }
                                    $('#batchno').val('');
                                    $('#totalQty').val('');
                                    $('#expirydate').val('');
                                    count = count + 1;
                                }
                            },
                            close: {
                                text: 'Add Expiry Date',
                                btnClass: 'btn-purple',
                                action: function () {
                                    requestFocus('expirydate');
                                }
                            }
                        }
                    });
                }
            } else {
                $('#enteredDonorItemsBody').append(
                        '<tr id="row' + count + '">' +
                        '<td>' + $('#itemname').val() + '</td>' +
                        '<td class="right">' + batch + '</td>' +
                        '<td class="right">' + $('#totalQty').val() + '</td>' +
                        '<td>' + expiry + '</td>' +
                        '<td class="center">' +
                        '<span class="badge badge-danger icon-custom" onclick="remove(\'' + count + '\')">' +
                        '<i class="fa fa-trash-o"></i></span></td>' +
                        '</tr>'
                        );
                $('#addDonationItems').modal('hide');
                var data = {
                    count: count,
                    itemid: itemid,
                    batch: batch,
                    qty: qty,
                    expiry: expiry
                };
                var found = false;
                for (i in items) {
                    if (items[i].batch === data.batch && items[i].itemid === data.itemid && items[i].expiry === data.expiry) {
                        items[i].qty = items[i].qty + data.qty;
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    items.push(data);
                }
                $('#batchno').val('');
                $('#totalQty').val('');
                $('#expirydate').val('');
                count = count + 1;
            }
        } else {
            $('#totalQty').css('border', '2px solid #f50808c4');
        }
    });


    function remove(count) {
        $('#row' + count).remove();
        for (i in items) {
            if (items[i].count === count) {
                items[i].splice(i, 1);
                break;
            }
        }
    }

    $('#savedonations').click(function () {
        var donationno = $('#donationno').val();
        var donationDate = $('#donationDate').val();
        var facilitydonorid = $('#facilitydonorid').val();

        if (donationno === "") {
            $('#donationno').css("border", "2px solid red");
        } else {
            $('#donationno').css("border", "");
        }
        if (donationDate === "") {
            $('#donationDate').addClass('error');
        } else {
            $('#donationDate').removeClass('error');
        }
//        if ($('#enteredDonorItemsBody').html('') && $('#enteredOtherDonorItemsBody').html('')) {
//            $.confirm({
//                boxWidth: '30%',
//                useBootstrap: false,
//                title: '<strong><font color="red">Alert!</font></strong>',
//                content: '' + '<div class="card-recieve-items-error">' +
//                        '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  PLEASE ENTER ITEMS BEING DONATED!</span></b></div>',
//                type: 'red',
//                typeAnimated: true,
//                icon: 'fa fa-warning', 
//                closeIcon: true,
//                buttons: {
//                    OK: function () {
//
//                    }
//                }
//            });
//        } else {
//
//        }
        if (donationno !== "" && donationDate !== "") {
          $('#savedonations').prop('disabled', true);
            if (items.length > 0 || otheritems.length > 0) {
                var data = {
                    donoritems: JSON.stringify(items),
                    otherdonoritems: JSON.stringify(otheritems),
                    donationno: donationno,
                    donationDate: donationDate,
                    facilitydonorid: facilitydonorid
                };
                $.ajax({
                    type: 'POST',
                    data: data,
                    url: 'internaldonorprogram/saveDonation.htm',
                    success: function (res) {
                        if (res === 'Saved') {
                            $('#batchno').val('');
                            $('#totalQty').val('');
                            $('#expirydate').val('');
                            $('#itemQty').val('');
                            $('#itemname').val('');
                            $('#packsQty').val('');
                            $('#looseQty').val('');
                            items = [];
                            $('#savedonations').prop('disabled', true);
                            $.toast({
                                heading: 'Success',
                                text: 'Donation Successfully Made.',
                                icon: 'success',
                                hideAfter: 2000,
                                position: 'bottom-center'
                            });
                            ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            window.location = '#close';
                        } else {
                            $('#savedonations').prop('disabled', true);
                            $.toast({
                                heading: 'Error',
                                text: 'An unexpected error occured while trying to make donation.',
                                icon: 'error'
                            });
                            ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            window.location = '#close';
                        }
                    }
                });
            }
        }
    });

</script>