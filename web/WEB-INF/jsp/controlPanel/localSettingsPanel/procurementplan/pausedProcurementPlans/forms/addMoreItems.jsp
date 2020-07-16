<%-- 
    Document   : addMoreItems
    Created on : Apr 12, 2018, 5:13:19 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<fieldset style="min-height:100px;">
    <legend>Procurement Plan For:&nbsp; ${procurementname}</legend>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div id="addmoreitems"></div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile">
                                        <div class="tile-body">
                                            <form id="entryform">
                                                <div class="form-group">
                                                    <label class="control-label">Select Item Classification</label>
                                                    <select class="form-control" id="addItemSClassification">
                                                        <c:forEach items="${itemsclassificationlist}" var="classification">
                                                            <option id="${classification.itemclassificationid}" data-name="${classification.classificationname}" value="${classification.itemclassificationid}">${classification.classificationname}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </form>
                                            <div id="custom-search-input">
                                                <div class="input-group col-md-12">
                                                    <input id="myInput2" onkeyup="searchlist2()" type="text" class="form-control" placeholder="Search" />
                                                </div><br>
                                                <div id="itemsPane2"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile">
                                        <table class="table table-sm" id="entereditms2">
                                            <thead>
                                                <tr>
                                                    <th>No</th>
                                                    <th>Item Name</th>
                                                    <th>Monthly Need</th>
                                                    <th>Annual Need</th>
                                                    <th>Remove</th>
                                                </tr>
                                            </thead>
                                            <tbody id="pausedentereditemsBody">

                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <hr style="border:1px dashed #dddddd;">
                                                <button type="button"  onclick="pausedaddtopause();"class="btn btn-primary btn-block">Add & Pause</button>
                                            </div>   
                                            <div class="col-sm-4">
                                                <hr style="border:1px dashed #dddddd;">
                                                <button type="button" onclick="pausedaddandsubmitprocurementplan();" class="btn btn-primary btn-block">Add & Submit</button>
                                            </div> 
                                            <div class="col-sm-4">
                                                <hr style="border:1px dashed #dddddd;">
                                                <button type="button" onclick="cancel();" class="btn btn-secondary btn-block">Cancel</button>
                                            </div> 
                                        </div>
                                    </div><br>
                                    <div class="row pull-right">
                                        <div class="col-xs-12">
                                            <a href="#" title="Number of Items In Cart" href="#"><i class="fa fa-shopping-cart">&nbsp;${totalitemsincart}</i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="snackbar">
                                <input id="procurementidpaused" value="${fanancialyearid}" type="hidden">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<script>
    var addItemSClassification = $('#addItemSClassification').val();
    if (addItemSClassification !== '' || addItemSClassification !== null) {
        document.getElementById('myInput2').focus();
        var financialyearid = $('#procurementidpaused').val();
        ajaxSubmitData('procurementplanmanagement/pausedclassificationitems.htm', 'itemsPane2', 'act=a&itemclassification=' + addItemSClassification + '&financialyrid=' + financialyearid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    $('#addItemSClassification').change(function () {
        document.getElementById('myInput2').focus();
        var itemclassification2 = $('#addItemSClassification').val();
        var financialyearid2 = $('#procurementidpaused').val();
        ajaxSubmitData('procurementplanmanagement/pausedclassificationitems.htm', 'itemsPane2', 'act=a&itemclassification=' + itemclassification2 + '&financialyrid=' + financialyearid2 + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    var sum = 0;
    function pausedadditemtoprocurementplan(itemid) {
        var financialyearid3 = $('#procurementidpaused').val();
        $.ajax({
            type: 'POST',
            data: {itemid: itemid, financialyearid: financialyearid3},
            url: "procurementplanmanagement/getitemlastprocurementstatisticsandaverage.htm",
            success: function (data, textStatus, jqXHR) {
                if (data !== '') {
                    var response = JSON.parse(data);
                    for (index in response) {
                        sum++;
                        var resp = response[index];
                        $('#pausedentereditemsBody').append('<tr id="itmz-' + itemid + '"><td>' + sum + '</td>' +
                                '<td>' + resp["genericname"] + '</td>' +
                                '<td class="eitted" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;-moz-border-radius: ;" id="monthpaused-' + sum + '" onkeyup="pausedupdatemonthorannual(this.id);">' + resp["monthlyaverage"] + '</td>' +
                                '<td class="eitted" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;-moz-border-radius: ;" id="annualpaused-' + sum + '" onkeyup="pausedupdatemonthorannual(this.id);">' + resp["annualaverage"] + '</td>' +
                                '<td><a href="#" title="Update From List" onclick="removepaused(this.id);" href="#" id="paused' + sum + '"><i class="fa fa-fw fa-lg fa-remove"></i></a></td></tr>');

                    }

                }
            }
        });
        $('#' + itemid).parent().remove();
    }
    function removepaused(id) {
        var tablerowid = $('#' + id).closest('tr').attr('id');

        $('#' + tablerowid).remove();
//        var fields = tablerowid.split('-');
//        var itemid = fields[1];
//        
//        var tableData = $('#' + tablerowid).closest('tr')
//                    .find('td')
//                    .map(function () {
//                        return $(this).text();
//                    }).get();
//                    
//        var ul = document.getElementById("myUL2");
//        var li = document.createElement("li");
//        li.setAttribute('id', itemid);
//        li.appendChild(document.createTextNode(tableData[1]));
//        ul.appendChild(li);

    }
    function pausedupdatemonthorannual(id) {
        var fields = id.split('-');
        var type = fields[0];
        var posid = fields[1];
        var value = $('#' + id).text();
        if (value !== '' || value.length !== 0) {
            if (type === 'monthpaused') {
                document.getElementById('annualpaused-' + posid).innerHTML = parseInt(value) * 12;
            } else {
                document.getElementById('monthpaused-' + posid).innerHTML = Math.round(parseInt(value) / 12);
            }
        }
    }
    function pausedaddtopause() {
        var addandpauseitems = [];
        var tablebody = document.getElementById("pausedentereditemsBody");
        var x = document.getElementById("pausedentereditemsBody").rows.length;
        for (var i = 0; i < x; i++) {
            var row = tablebody.rows[i];
            var ids = row.id;
            var tableData = $('#' + ids).closest('tr')
                    .find('td')
                    .map(function () {
                        return $(this).text();
                    }).get();

            var fields = ids.split('-');
            var iditem = fields[1];
            addandpauseitems.push({
                itemid: iditem,
                monthly: tableData[2],
                annual: tableData[3]
            });
        }
        var financialyearidpaused = $('#procurementidpaused').val();
        if (addandpauseitems.length !== 0) {
            $.ajax({
                type: 'POST',
                data: {procurementid: financialyearidpaused, values: JSON.stringify(addandpauseitems), type: 'paused'},
                url: "procurementplanmanagement/saveandorsubmitprocurementplan.htm",
                success: function (data, textStatus, jqXHR) {
                    $.toast({
                        heading: 'Success',
                        text: 'Successfully Saved !!!!',
                        icon: 'success',
                        hideAfter: 5000,
                        position: 'bottom-center'
                    });
                    ajaxSubmitData('procurementplanmanagement/pausedprocurementplans.htm', 'content3', 'act=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        } else {
            $.toast({
                heading: 'Error',
                text: 'Nothing To Save !!!!',
                icon: 'error',
                hideAfter: 3000,
                position: 'bottom-center'
            });
        }
    }
    function pausedaddandsubmitprocurementplan() {
        var addandsubmititems = [];
        var tablebody = document.getElementById("pausedentereditemsBody");
        var x = document.getElementById("pausedentereditemsBody").rows.length;
        for (var i = 0; i < x; i++) {
            var row = tablebody.rows[i];
            var ids = row.id;
            var tableData = $('#' + ids).closest('tr')
                    .find('td')
                    .map(function () {
                        return $(this).text();
                    }).get();

            var fields = ids.split('-');
            var iditem = fields[1];
            addandsubmititems.push({
                itemid: iditem,
                monthly: tableData[2],
                annual: tableData[3]
            });
        }
        var financialyearidpaused = $('#procurementidpaused').val();
        if (addandsubmititems.length !== 0) {
            $.ajax({
                type: 'POST',
                data: {procurementid: financialyearidpaused, values: JSON.stringify(addandsubmititems), type: 'submit'},
                url: "procurementplanmanagement/saveandorsubmitprocurementplan.htm",
                success: function (data, textStatus, jqXHR) {
                    $.toast({
                        heading: 'Success',
                        text: 'Successfully Saved !!!!',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    ajaxSubmitData('procurementplanmanagement/pausedprocurementplans.htm', 'content3', 'act=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        } else {
            $.toast({
                heading: 'Error',
                text: 'Nothing To Save !!!!',
                icon: 'error',
                hideAfter: 3000,
                position: 'bottom-center'
            });
        }
    }
    function cancel() {
        ajaxSubmitData('procurementplanmanagement/pausedprocurementplans.htm', 'content3', 'act=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>