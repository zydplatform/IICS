<%-- 
    Document   : composeprocurementplanform
    Created on : Apr 10, 2018, 1:30:09 PM
    Author     : RESEARCH
--%>

</style>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<c:if test="${size > 0}">
<div class="form-group row">
    <label class="control-label col-md-4">Procurement Plan For Financial Year:</label>
    <div class="col-md-6">
        <select class="form-control" id="selectprocurementyr">
            <c:forEach items="${financialyr}" var="fyr">
                <option  value="${fyr.financialyearid}">${fyr.startyear}-${fyr.endyear}</option>
            </c:forEach>
        </select>    
    </div>
</div>
</c:if>
<div id="">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <c:if test="${size > 0}">
                            <div class="row">
                                <div class="col-md-12">
                                    <button onclick="importitemfromfinancialyrs();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Import</button>
                                </div>
                            </div><br>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="tile">
                                                <div class="tile-body">
                                                    <form id="entryform">
                                                        <div class="form-group">
                                                            <label class="control-label">Select Item Classification</label>
                                                            <select class="form-control" id="ItemSClassification">
                                                                <c:forEach items="${itemsclassificationlist}" var="classification">
                                                                    <option id="${classification.itemclassificationid}" data-name="${classification.classificationname}" value="${classification.itemclassificationid}">${classification.classificationname}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </form>
                                                    <div id="custom-search-input">
                                                        <div class="input-group col-md-12">
                                                            <input id="myInput" onkeyup="searchlist()" type="text" class="form-control" placeholder="Search" />
                                                        </div><br>
                                                        <div id="itemsPane"></div>
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
                                                <table class="table table-sm">
                                                    <thead>
                                                        <tr>
                                                            <th>No</th>
                                                            <th>Item Name</th>
                                                            <th>Pack Size</th>
                                                            <th>Monthly Need</th>
                                                            <th>Annual Need</th>
                                                            <th>Remove</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="">

                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <hr style="border:1px dashed #dddddd;">
                                                        <button type="button"  onclick="addtopause();"class="btn btn-primary btn-block">Add & Pause</button>
                                                    </div>   
                                                    <div class="col-sm-4">
                                                        <hr style="border:1px dashed #dddddd;">
                                                        <button type="button" onclick="addandsubmitprocurementplan();" class="btn btn-primary btn-block">Add & Submit</button>
                                                    </div> 
                                                    <div class="col-sm-4">
                                                        <hr style="border:1px dashed #dddddd;">
                                                        <button type="button" class="btn btn-secondary btn-block">Cancel</button>
                                                    </div> 
                                                </div>
                                            </div>
                                            <div class="form-group"></div>
                                        </div>
                                    </div>
                                    <div id="snackbar"></div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${size ==0}">
                            <legend style="color: red;">No Financial Year !! All Financial Years Already Procured</legend>
                            <p>Create New Financial Year To Procure Items For It</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    <div id="imports"></div>
    <div class="modal fade" id="" style="padding-right: 21% !important;"tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 153%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Import From Financial Year</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-12">
                                <input type="hidden" id="procurementid">
                            </div>
                            <!-- panel preview -->
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                       
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <button class="btn btn-primary" type="button" onclick="importfinancialyearsitems();"><i class="fa fa-fw fa-lg fa-check-circle"></i>Import</button>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary" href="#" data-dismiss="modal" ><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="financialyearsitemsview" style="padding-right: 21% !important;"tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 153%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle"> Financial Year Items</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-12">
                                <legend></legend>
                            </div>
                            <!-- panel preview -->
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <div class="row">
                                            <div class="col-md-6">

                                            </div>
                                            <div class="col-md-6">
                                                <input type="text" id="searchtable" class="form-control" onkeyup="searchtable()" placeholder="Search for items..">
                                            </div>
                                        </div><br>
                                        <table class="table table-hover table-bordered" id="itemssearchabletable">
                                            <thead>
                                                <tr>
                                                    <th>No</th>
                                                    <th>Generic Name</th>
                                                    <th>Pack Size</th>
                                                    <th>Monthly Needed</th>
                                                    <th>Annual Needed</th>
                                                </tr>
                                            </thead>
                                            <tbody id="finanacialsitems">

                                            </tbody>
                                        </table>
                                        <div id="loading" style="display: block;" >
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <legend>Getting Items Please Wait....................</legend>
                                                </div></div>
                                        </div>
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <button class="btn btn-primary" type="button" data-dismiss="modal"><i class="fa fa-fw fa-lg fa-check-circle"></i>Ok</button>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary" href="#" data-dismiss="modal" ><i class="fa fa-fw fa-lg fa-times-circle"></i>Close</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var itemclassification = $('#ItemSClassification').val();
    var financialyr = $('#selectprocurementyr').val();
    if (itemclassification !== '' || itemclassification !== null && financialyr !== '' || financialyr !== null) {
        document.getElementById('myInput').focus();
        ajaxSubmitData('procurementplanmanagement/classificationitems.htm', 'itemsPane', 'act=a&itemclassification=' + itemclassification + '&financialyrid=' + financialyr + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    $('#ItemSClassification').change(function () {
        var itemclassification2 = $('#ItemSClassification').val();
        var financialyr2 = $('#selectprocurementyr').val();
        if (financialyr2 !== '' || financialyr2 !== null) {
            document.getElementById('myInput').focus();
            ajaxSubmitData('procurementplanmanagement/classificationitems.htm', 'itemsPane', 'act=a&itemclassification=' + itemclassification2 + '&financialyrid=' + financialyr2 + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    });
    $('#selectprocurementyr').change(function () {
        var itemclassification2 = $('#ItemSClassification').val();
        var financialyr2 = $('#selectprocurementyr').val();
        document.getElementById('myInput').focus();
        ajaxSubmitData('procurementplanmanagement/classificationitems.htm', 'itemsPane', 'act=a&itemclassification=' + itemclassification2 + '&financialyrid=' + financialyr2 + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    var count = 0;
    var procurementitms = [];
    var deleteitems = new Set();
    function additemtoprocurementplan(itemid) {
        $.ajax({
            type: 'POST',
            data: {itemid: itemid},
            url: "procurementplanmanagement/getitemlastprocurementstatisticsandaverage.htm",
            success: function (data, textStatus, jqXHR) {
                if (data !== '') {
                    var response = JSON.parse(data);
                    for (index in response) {
                        count++;
                        var resp = response[index];
                        $('#entereditemsBody').append('<tr id="itms-' + itemid + '"><td>' + count + '</td>' +
                                '<td>' + resp["genericname"] + '</td>' +
                                '<td>' + resp["packsize"] + '</td>' +
                                '<td class="eitted" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;-moz-border-radius: ;" id="month-' + count + '" onkeyup="updatemonthorannual(this.id);">' + resp["monthlyaverage"] + '</td>' +
                                '<td class="eitted" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;-moz-border-radius: ;" id="annual-' + count + '" onkeyup="updatemonthorannual(this.id);">' + resp["annualaverage"] + '</td>' +
                                '<td><a href="#" title="Update From List" onclick="remove(this.id);" href="#" id="up' + count + '"><i class="fa fa-fw fa-lg fa-remove"></i></a></td></tr>');

                    }

                }
            }
        });
        $('#' + itemid).parent().remove();
    }
   
    
  
    
    function viewfinancialyearsitems(id) {
        document.getElementById('searchtable').value = '';
        document.getElementById('loading').style.display = 'block';
        $('#finanacialsitems').html('');
        $.ajax({
            type: 'POST',
            data: {financialyearid: id},
            url: "procurementplanmanagement/getfinancialyearprocurementplanitems.htm",
            success: function (data, textStatus, jqXHR) {
                if (data !== '') {
                    document.getElementById('loading').style.display = 'none';
                    var i = 0;
                    var response = JSON.parse(data);
                    for (index in response) {
                        i++;
                        var resp = response[index];
                        $('#finanacialsitems').append('<tr><td>' + i + '</td>' +
                                '<td>' + resp["genericname"] + '</td>' +
                                '<td>' + resp["packsize"] + '</td>' +
                                '<td>' + resp["amc"] + '</td>' +
                                '<td>' + resp["aac"] + '</td></tr>');
                    }
                }
            }

        });
        document.getElementById('searchtable').focus();
        $('#financialyearsitemsview').modal('show');
    }
    function searchtable() {
        var input, value;
        input = document.getElementById("searchtable");
        value = input.value.toLowerCase().trim();
        $("#itemssearchabletable tr").each(function (index) {
            if (!index)
                return;
            $(this).find("td").each(function () {
                var id = $(this).text().toLowerCase().trim();
                var not_found = (id.indexOf(value) === -1);
                $(this).closest('tr').toggle(!not_found);
                return not_found;
            });
        });
    }
    var imports = new Set();
    function addingtofinancialimportslist(type, id, checkboxid) {
        if (type === 1 && imports.size !== 0) {
            $('#' + checkboxid).prop('checked', false);
            $.toast({
                heading: 'Error',
                text: ' You Can Only Import From One Financial Year Un Check Selected To select Another!!!!',
                icon: 'error',
                hideAfter: 3000,
                position: 'bottom-center'
            });
        } else if (type === 1 && imports.size === 0) {
            imports.add(id);
        } else if (type === 0 && imports.size !== 0) {
            imports.delete(id);
        }
    }
    function importfinancialyearsitems() {

        if (imports.size !== 0) {
            var procurementid = $('#procurementid').val();
            $('#importfromprocuredfinancialyears').modal('hide');
            ajaxSubmitData('procurementplanmanagement/itemsdialog.htm', 'imports', 'act=a&importids=' + JSON.stringify(Array.from(imports)) + '&procurementid=' + procurementid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        } else {
            $.toast({
                heading: 'Error',
                text: ' Select What To Import !!!!',
                icon: 'error',
                hideAfter: 3000,
                position: 'bottom-center'
            });
        }

    }
   
</script>