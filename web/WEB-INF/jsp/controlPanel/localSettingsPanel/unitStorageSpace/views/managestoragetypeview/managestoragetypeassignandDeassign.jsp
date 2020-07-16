<%-- 
    Document   : managestoragetypeassignandDeassign
    Created on : Jun 5, 2018, 6:20:24 PM
    Author     : user
--%>

<%@include file="../../../../../include.jsp" %>
<style>
    .stylish-input-group .input-group-addon{
        background: white !important;
    }
    .stylish-input-group .form-control{
        box-shadow:0 0 0;
        border-color:#ccc;
    }
    .stylish-input-group button{
        border:0;
        background:transparent;
    }

    .h-scroll {
        background-color: #fcfdfd;
        height: 260px;
        overflow-y: scroll;
    }
    #xx{
        margin-left: 1.5em;
    }
    #alertmsg{color:whitesmoke;}
    .hummingbird-base li{font-size: 0.8em;}
</style>
<link href="static/mainpane/css/hummingbird-treeview.css" rel="stylesheet">
<c:if test="${Zonetree.status =='storageunTyped'}">
    <div class="row">   
        <div class="col-md-8">
            <h5>Assign Storage Types to Zone &nbsp; <strong class="text-success">${Zonetree.zonelabel}</strong></h5>
        </div>  
        <div class="col-md-4">
            <label class="mb-2 btn btn-primary btn-block" id="alertmsg">Storage Un-Typed <c:if test="${Zonetree.cellsUnassignedType > 1}">Cells</c:if>
                <c:if test="${Zonetree.cellsUnassignedType <= 1}">Cell</c:if>: <span class="badge badge-pill badge-light">${Zonetree.cellsUnassignedType}</span></label>     
            </div>
        </div>
        <div class="tile-body">
            <div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
                <ul id="treeviewx1" class="hummingbird-base">
                    <button class="btn btn-success" id="expandAllx1"><span><i class="fa fa-expand">&nbsp;Expand All</i> </span></button> | <button class="btn btn-success" id="collapseAllx1"><span><i class="fa fa-arrows"> &nbsp;Collapse ALL</i></span></button>
                    <li style="margin-left: 9%;">
                        <i class="fa fa-plus"></i> <label> <!--input id="" data-id="custom-1" type="checkbox"--> ${Zonetree.zonelabel}</label>
                    <ul id="xx">
                        <c:forEach items="${Zonetree.bays}" var="bay" varStatus="baystatus" begin="0" end="${Zonetree.baysize}">
                            <li>
                                <i class="fa fa-plus"></i><label><!--input <c:if test="${bay.assigned==true}">checked="checked"</c:if> class="hummingbirdNoParent" id="" data-id="custom-1-3" type="checkbox"--> ${bay.bayName} </label>
                                    <ul id="xx">
                                    <c:forEach items="${bay.rows}" var="row"  varStatus="rowstatus" begin="0" end="${bay.rowsize}">
                                        <li>
                                            <i class="fa fa-plus"></i><label><!--input class="hummingbirdNoParent" id="" data-id="" <c:if test="${row.assigned==true}">checked="checked"</c:if> type="checkbox"-->  ${row.rowlabel}</label>
                                                <ul id="xx">
                                                <c:forEach items="${row.cells}" var="cell" varStatus="cellstatus" begin="0" end="${row.cellsize}">
                                                    <li>
                                                        <i class="fa fa-long-arrow-right"></i><label> <!--input class="hummingbirdNoParent" id="${cell.cellid}" data-id="custom-1-5" type="checkbox"-->${cell.cellLabel} 
                                                        &nbsp;<select id="sType${cell.cellid}" data-id="${cell.cellid}" onchange="addselectedstoragetypeTOcell(this.id, $(this).attr('data-id'))">
                                                                <option value="">----- Select Storage Type-------</option>
                                                                <c:forEach items="${StorageTypex}" var="stype">
                                                                    <option value="${cell.cellLabel},${cell.cellid},${stype.stypeid},${stype.stypeName}">${stype.stypeName}</option>
                                                                </c:forEach>
                                                        </select> &nbsp;<span id="indicatestate${cell.cellid}" class="hidedisplaycontent" ><i class="fa fa-check-circle text-success"></i></span>&nbsp;<span id="cellLimit${cell.cellid}" class="hidedisplaycontent"><span id="limitNum${cell.cellid}" class="text-danger"></span>&nbsp;<i onclick="editTransLimit(${cell.cellid})" class="fa fa-edit"></i></span>
                                                        </label>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:forEach>
                    </ul>
                </li>                                   
            </ul>
        </div> 
    </div>
    <div id="addcellsdivx" class="hidedisplaycontent">
        <label class="formLabelTxt">Add:&nbsp;<Strong id="addcellsdivitemsx"></Strong> &nbsp; Storage Type Cell </label> &nbsp;&nbsp;&nbsp;
    </div>
    <div class="modal-footer">
        <div id="savebuttondiv" class="hidedisplaycontent">
            <button  class="btn btn-success pull-right" onclick="SaveAssignedStorageType()"><i class="fa fa-plus"></i>&nbsp;Assign Storage Type</button>
        </div>   
    </div>
</c:if>
<c:if test="${Zonetree.status =='storageTyped'}">
    <div class="row">   
        <div class="col-md-8">
            <h5>Assigned Storage Types to Zone &nbsp; <strong class="text-success">${Zonetree.zonelabel}</strong></h5>
        </div>  
        <div class="col-md-4">
            <label class="mb-2 btn btn-primary btn-block" id="alertmsg">Previous Storage Typed <c:if test="${Zonetree.cellsAssignedType > 1}">Cells</c:if>
                <c:if test="${Zonetree.cellsAssignedType == 1}">Cell</c:if>: <span class="badge badge-pill badge-light">${Zonetree.cellsAssignedType}</span></label>     
            </div>
        </div>
        <div class="tile-body">
            <div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
                <ul id="treeviewx2" class="hummingbird-base">
                    <button class="btn btn-success" id="expandAllx2"><span><i class="fa fa-expand">&nbsp;Expand All</i> </span></button> | <button class="btn btn-success" id="collapseAllx2"><span><i class="fa fa-arrows"> &nbsp;Collapse ALL</i></span></button>
                    <li style="margin-left: 9%;">
                        <i class="fa fa-plus"></i> <label> <!--input id="" data-id="custom-1" type="checkbox"--> ${Zonetree.zonelabel}</label>
                    <ul id="xx">
                        <c:forEach items="${Zonetree.bays}" var="bay" varStatus="baystatus" begin="0" end="${Zonetree.baysize}">
                            <li>
                                <i class="fa fa-plus"></i><label><!--input <c:if test="${bay.assigned==true}">checked="checked"</c:if> class="hummingbirdNoParent" id="" data-id="custom-1-3" type="checkbox"--> ${bay.bayName}</label>
                                    <ul id="xx">
                                    <c:forEach items="${bay.rows}" var="row"  varStatus="rowstatus" begin="0" end="${bay.rowsize}">
                                        <li>
                                            <i class="fa fa-plus"></i><label><!--input class="hummingbirdNoParent" id="" data-id="" <c:if test="${row.assigned==true}">checked="checked"</c:if> type="checkbox"-->  ${row.rowlabel}</label>
                                                <ul id="xx">
                                                <c:forEach items="${row.cells}" var="cell" varStatus="cellstatus" begin="0" end="${row.cellsize}">
                                                    <li>
                                                        <i class="fa fa-long-arrow-right"></i><label> <!--input class="hummingbirdNoParent" id="${cell.cellid}" data-id="custom-1-5" type="checkbox"-->${cell.cellLabel} 
                                                            &nbsp;<select id="sTypev${cell.cellid}" data-id="${cell.cellid}" data-status="${cell.assigned}"onchange="addorRemoveselectedstoragetypeTOcell(this.id, $(this).attr('data-id'),$(this).attr('data-status'))">
                                                                <option value="">----- Select Storage Type-------</option>
                                                                <c:forEach items="${StorageTypex}" var="stype">
                                                                    <c:if test="${cell.assigned == true}">
                                                                        <c:if test="${cell.storetype == stype.stypeid}">
                                                                            <option value="${cell.cellLabel},${cell.cellid},${stype.stypeid},${stype.stypeName}" selected="selected">${stype.stypeName}</option>  
                                                                        </c:if>
                                                                        <c:if test="${cell.storetype != stype.stypeid}">
                                                                            <option value="${cell.cellLabel},${cell.cellid},${stype.stypeid},${stype.stypeName}">${stype.stypeName}</option>
                                                                        </c:if>
                                                                    </c:if>
                                                                    <c:if test="${cell.assigned == false}">
                                                                        <option value="${cell.cellLabel},${cell.cellid},${stype.stypeid},${stype.stypeName}">${stype.stypeName}</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </select> &nbsp;<span id="indicatestate${cell.cellid}" class="hidedisplaycontent" ><i class="fa fa-check-circle text-success"></i></span>&nbsp;<span id="cellLimitx${cell.cellid}" class="hidedisplaycontent"><span id="limitNumx${cell.cellid}" class="text-danger">${cell.transLimit}</span>&nbsp;<i onclick="editTransLimit2(${cell.cellid})" class="fa fa-edit"></i></span>
                                                                <c:if test="${cell.assigned == true}">
                                                                <span id="indicateSelectedstate${cell.cellid}"><i class="fa fa-check-circle text-success"></i></span>&nbsp;<span id="cellLimitx${cell.cellid}" class="hidedisplaycontent"><span id="limitNumx${cell.cellid}" class="text-danger">${cell.transLimit}</span>&nbsp;<span><i onclick="editTransLimit2(${cell.cellid})" class="fa fa-edit"></i></span></span>
                                                                </c:if>
                                                        </label>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:forEach>
                    </ul>
                </li>                                   
            </ul>
        </div> 
    </div>
    <div id="addStoragetypetocellsdiv" class="hidedisplaycontent">
        <label class="formLabelTxt">Add:&nbsp;<Strong id="addStoragetypetocellsdivitems"></Strong> &nbsp; Storage Type Cell </label> &nbsp;&nbsp;&nbsp;
    </div>
    <div id="removeStoragetypefromcellsdiv" style="display: none;">
        <label class="formLabelTxt">Remove:&nbsp;<Strong id="removeStoragetypefromcellsdivitems"></Strong> &nbsp;Storage Type Cell </label> &nbsp;&nbsp;&nbsp;
    </div>
    <div class="modal-footer">
        <div id="saveStoragecellassignmentordesignment" class="hidedisplaycontent">
            <button  class="btn btn-success pull-right" onclick="SaveorRemoveassignedStorageType()"><i class="fa fa-plus"></i>&nbsp;Save Changes</button>
        </div>   
    </div>
</c:if>
<script src="static/mainpane/js/hummingbird-treeview.js"></script>
<script>
$(document).ready(function () {
    $("#treeviewx1").hummingbird();
    $("#treeviewx2").hummingbird();
    $("#collapseAllx1").click(function () {
        $("#treeviewx1").hummingbird("collapseAll");
    });
    $('#expandAllx1').click(function () {
        $("#treeviewx1").hummingbird("expandAll");
    });
    $("#collapseAllx2").click(function () {
        $("#treeviewx2").hummingbird("collapseAll");
    });
    $('#expandAllx2').click(function () {
        $("#treeviewx2").hummingbird("expandAll");
    });
});
function checkstate(cellselect,selectedCellid,id){
    $.confirm({
        title: ''+cellselect,
        type:'purple',
        content: '' +
        '<form action="" class="formName">' +
        '<div class="form-group">' +
        '<div id="errorInput"></div>'+
        '<label>Set Transactional Limit on cell</label>' +
        '<input type="text" maxlength="3" placeholder="Enter cell Limit number" class="name form-control" required onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57"/>' +
        '</div>' +
        '</form>',
        buttons: {
            formSubmit: {
                text: 'Set',
                btnClass: 'btn-success',
                action: function () {
                    var name = this.$content.find('.name').val();
                    if(!name){
                        $('#errorInput').html('<span class="text-danger">* Error Input Field Required</span>');
                        return false;
                    }else if(parseInt(name) === 0){
                        $('#errorInput').html('<span class="text-danger">* Error Valid Input Required</span>');
                         return false;
                    }else if(parseInt(name) > 100){
                        $('#errorInput').html('<span class="text-danger">*Required value must be between [ 1-100 ]</span>');
                        return false;
                    }
                    $('#cellLimitx'+selectedCellid).show();
                    $('#limitNumx'+selectedCellid).html(name);
                 }
                },
                close: function () {
                    $('#' + id).val('');
                    $('#cellLimitx'+selectedCellid).hide();
                },
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
    });
}
var addStorageassignment = new Set();
var removeStorageassignment = new Set();
var addStorageassignmentFinal = [];
function addorRemoveselectedstoragetypeTOcell(id, selectedCellid,state){
    var selectstoragetype = $('#' + id).val();
    if (selectstoragetype !== '') {
        var typeid = selectstoragetype.split(",")[2];
        var cellselect = selectstoragetype.split(",")[0];
        if(parseInt(typeid) === parseInt(4)){
            if (state === 'true' || state === 'false') {
                checkstate(cellselect,selectedCellid,id);
                removeStorageassignment.delete(selectedCellid);
                addStorageassignment.add(selectedCellid);          
                $('#indicatestate' + selectedCellid).show();
                $('#cellLimitx'+selectedCellid).show();
            }else{
                 checkstate(cellselect,selectedCellid,id);
                 addStorageassignment.delete(selectedCellid);
                 removeStorageassignment.add(selectedCellid);             
                 $('#indicateSelectedstate' + selectedCellid).hide();             
                 $('#indicatestate' + selectedCellid).hide();
                 $('#cellLimitx'+selectedCellid).hide();
            }
            
        }else if(parseInt(typeid) === parseInt(3)){
            if (state === 'true' || state === 'false') {
                checkstate(cellselect,selectedCellid,id);
                removeStorageassignment.delete(selectedCellid);
                addStorageassignment.add(selectedCellid);          
                $('#indicatestate' + selectedCellid).show();
                $('#cellLimitx'+selectedCellid).show();
            }else{
                 checkstate(cellselect,selectedCellid,id);
                 addStorageassignment.delete(selectedCellid);
                 removeStorageassignment.add(selectedCellid);             
                 $('#indicateSelectedstate' + selectedCellid).hide();             
                 $('#indicatestate' + selectedCellid).hide();
                 $('#cellLimitx'+selectedCellid).hide();
            }
        }else{
            if (state === 'true' || state === 'false') {
                removeStorageassignment.delete(selectedCellid);
                addStorageassignment.add(selectedCellid);          
                $('#indicatestate' + selectedCellid).show();
            }else{
                 addStorageassignment.delete(selectedCellid);
                 removeStorageassignment.add(selectedCellid);             
                 $('#indicateSelectedstate' + selectedCellid).hide();             
                 $('#indicatestate' + selectedCellid).hide();
                 $('#cellLimitx'+selectedCellid).hide();
            }
        }
    }else{
        removeStorageassignment.add(selectedCellid);
        addStorageassignment.delete(selectedCellid);
        $('#indicatestate' + selectedCellid).hide();
        $('#indicateSelectedstate' + selectedCellid).hide(); 
    }
    if (parseInt(addStorageassignment.size) === 0) {
        document.getElementById('addStoragetypetocellsdiv').style.display = 'none';
    } else {
        document.getElementById('addStoragetypetocellsdivitems').innerHTML = addStorageassignment.size;
        document.getElementById('addStoragetypetocellsdiv').style.display = 'block';
    }
    if (parseInt(removeStorageassignment.size) === 0) {
        document.getElementById('removeStoragetypefromcellsdiv').style.display = 'none';
    } else {
        document.getElementById('removeStoragetypefromcellsdiv').style.display = 'block';
        document.getElementById('removeStoragetypefromcellsdivitems').innerHTML = removeStorageassignment.size;
    }
    if (parseInt(addStorageassignment.size) === 0 && parseInt(removeStorageassignment.size) === 0) {
        document.getElementById('savecellassignmentordesignment').style.display = 'none';
    } else {
        document.getElementById('saveStoragecellassignmentordesignment').style.display = 'block';
    }
}
function SaveorRemoveassignedStorageType(){
    var addStorageassignmentObj = Array.from(addStorageassignment);
    for (var x in addStorageassignmentObj) {
        var id = addStorageassignmentObj[x];
        var selectedstoragetype = $('#sTypev' + id).val();
        var limittransx = $('#limitNumx'+id).html();
        addStorageassignmentFinal.push({
            addStoragetypecontent: selectedstoragetype,
             transLimit:limittransx
        });
    }
    $.ajax({
     type: 'POST',
     data: {addstoragetype: JSON.stringify(addStorageassignmentFinal), removestoragetype: JSON.stringify(Array.from(removeStorageassignment))},
     url: "localsettigs/addorremovestoragetype.htm",
     success: function (data, textStatus, jqXHR) {
          addStorageassignment.clear();
          removeStorageassignment.clear();
          addStorageassignmentFinal =[];
          $.toast({
                heading: 'Success',
                text: 'Selected Storage Type(s) Successfully Added / Removed',
                icon: 'success',
                hideAfter: 2000,
                position: 'bottom-center'
            });
            ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            window.location = '#close';
     },
      error: function (jqXHR, textStatus, errorThrown) {
          addStorageassignment.clear();
          removeStorageassignment.clear();
          addStorageassignmentFinal =[];
            $.toast({
                heading: 'Error',
                text: 'An unexpected error occured while trying to Add / Remove Storage Type(s)',
                icon: 'error',
                hideAfter: 2000,
                position: 'bottom-center'
            });
            // ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            window.location = '#close';
        }
    });
}
var addassignmentcellid = new Set();
var addassignmentcellidFinal = [];
var addassignmentcellidtest = [];
function addselectedstoragetypeTOcell(id, cellxid) {
    var selectedstoragetype = $('#' + id).val();
    if (selectedstoragetype !== '') {
        var typeid = selectedstoragetype.split(",")[2];
        var cellselect = selectedstoragetype.split(",")[0];
        if(parseInt(typeid) === parseInt(4)){
            $.confirm({
                title: ''+cellselect,
                type:'purple',
                content: '' +
                '<form action="" class="formName">' +
                '<div class="form-group">' +
                '<div id="errorInput"></div>'+
                '<label>Set Transactional Limit on cell</label>' +
                '<input type="text" maxlength="3" placeholder="Enter cell Limit number" class="name form-control" required onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57"/>' +
                '</div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Set',
                        btnClass: 'btn-success',
                        action: function () {
                            var name = this.$content.find('.name').val();
                            if(!name){
                                $('#errorInput').html('<span class="text-danger">* Error Input Field Required</span>');
                                return false;
                            }else if(parseInt(name) === 0){
                                $('#errorInput').html('<span class="text-danger">* Error Valid Input Required</span>');
                                 return false;
                            }else if(parseInt(name) > 100){
                                $('#errorInput').html('<span class="text-danger">*Required value must be between [ 1-100 ]</span>');
                                return false;
                            }
                            $('#cellLimit'+cellxid).show();
                            $('#indicatestate'+cellxid).show();                                                   
                            addassignmentcellid.add(cellxid);                            
                            $('#limitNum'+cellxid).html(name);  
                            
                        }
                    },
                    close: function () {
                        $('#' + id).val('');
                    },
                },
                onContentReady: function () {
                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                }
            });
        }else if(parseInt(typeid) === parseInt(3)){
                $.confirm({
                title: ''+cellselect,
                type:'purple',
                content: '' +
                '<form action="" class="formName">' +
                '<div class="form-group">' +
                '<div id="errorInput"></div>'+
                '<label>Set Transactional Limit on cell</label>' +
                '<input type="text" maxlength="3" placeholder="Enter cell Limit number" class="name form-control" required onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57"/>' +
                '</div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Set',
                        btnClass: 'btn-success',
                        action: function () {
                            var name = this.$content.find('.name').val();
                            if(!name){
                                $('#errorInput').html('<span class="text-danger">* Error Input Field Required</span>');
                                return false;
                            }else if(parseInt(name) === 0){
                                $('#errorInput').html('<span class="text-danger">* Error Valid Input Required</span>');
                                 return false;
                            }else if(parseInt(name) > 100){
                                $('#errorInput').html('<span class="text-danger">*Required value must be between [ 1-100 ]</span>');
                                return false;
                            }
                            $('#cellLimit'+cellxid).show();
                            $('#indicatestate'+cellxid).show();                                                   
                            addassignmentcellid.add(cellxid);                            
                            $('#limitNum'+cellxid).html(name);  
                            
                        }
                    },
                    close: function () {
                        $('#' + id).val('');
                    },
                },
                onContentReady: function () {
                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                }
            });
        }else{
            $('#limitNum'+cellxid).html('');
            $('#cellLimit'+cellxid).hide();  
            addassignmentcellid.add(cellxid);
            $('#indicatestate' + cellxid).show();
            
        }
    } else {
        addassignmentcellid.delete(cellxid);
        $('#indicatestate' + cellxid).hide();
        $('#cellLimit'+cellxid).hide();
    }
    if (parseInt(addassignmentcellid.size) === 0) {
        document.getElementById('addcellsdivx').style.display = 'none';
    } else {
        document.getElementById('addcellsdivitemsx').innerHTML = addassignmentcellid.size;
        document.getElementById('addcellsdivx').style.display = 'block';
    }
    if (parseInt(addassignmentcellid.size) === 0) {
        document.getElementById('savebuttondiv').style.display = 'none';
    } else {
        document.getElementById('savebuttondiv').style.display = 'block';
    }
}
function SaveAssignedStorageType() {
    var addassignmentcellidObj = Array.from(addassignmentcellid);
    for (var x in addassignmentcellidObj) {
        var id = addassignmentcellidObj[x];
        var selectedstoragetype = $('#sType' + id).val();
        var limittrans = $('#limitNum'+id).html();
        addassignmentcellidFinal.push({
            addStoragecontent: selectedstoragetype,
            transLimit:limittrans
        });
    }
    $.ajax({
        type: 'POST',
        data: {add: JSON.stringify(addassignmentcellidFinal)},
        url: "localsettigs/saveselectedstoragetype.htm",
        success: function (data, textStatus, jqXHR) {
            addassignmentcellid.clear();
            addassignmentcellidFinal = [];
            $.toast({
                heading: 'Success',
                text: 'Selected Storage Type(s) Successfully Added',
                icon: 'success',
                hideAfter: 2000,
                position: 'bottom-center'
            });
            ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            window.location = '#close';
        },
        error: function (jqXHR, textStatus, errorThrown) {
            addassignmentcellid.clear();
            addassignmentcellidFinal = [];
            $.toast({
                heading: 'Error',
                text: 'An unexpected error occured while trying to Add Storage Type(s)',
                icon: 'error',
                hideAfter: 2000,
                position: 'bottom-center'
            });
            // ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            window.location = '#close';
        }
    });
}
function editTransLimit(cellid){
    var limitval = $('#limitNum'+cellid).html();
    var cellselect = $('#sType'+cellid).val().split(",")[0];
    $.confirm({
        title: ''+cellselect,
        type:'purple',
        content: '' +
        '<form action="" class="formName">' +
        '<div class="form-group">' +
        '<div id="errorInput"></div>'+
        '<label>Set Transactional Limit on cell</label>' +
        '<input type="text" maxlength="3" value="'+limitval+'" class="name form-control" required onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57"/>' +
        '</div>' +
        '</form>',
        buttons: {
            formSubmit: {
                text: 'Edit',
                btnClass: 'btn-success',
                action: function () {
                    var name = this.$content.find('.name').val();
                    if(!name){
                        $('#errorInput').html('<span class="text-danger">* Error Input Field Required</span>');
                        return false;
                    }else if(parseInt(name) === 0){
                        $('#errorInput').html('<span class="text-danger">* Error Valid Input Required</span>');
                        return false;
                    }else if(parseInt(name)=== parseInt(limitval)){
                         $('#errorInput').html('<span class="text-danger">* Error Limit Value Must be Different</span>');
                         return false;
                    }else if(parseInt(name) > 100){
                        $('#errorInput').html('<span class="text-danger">*Required value must be between [ 1-100 ]</span>');
                        return false;
                    }
                    $('#limitNum'+cellid).html(name);
                    $('#cellLimit'+cellid).show();              
                }
            },
            close: function () {
                
            },
        },
        onContentReady: function () {
            // bind to events
            var jc = this;
            this.$content.find('form').on('submit', function (e) {
                // if the user submits the form by pressing enter in the field.
                e.preventDefault();
                jc.$$formSubmit.trigger('click'); // reference the button and click it
            });
        }
    });
}
function editTransLimit2(cellid){
    var limitval = $('#limitNumx'+cellid).html();
    var cellselect = $('#sTypev'+cellid).val().split(",")[0];
    $.confirm({
        title: ''+cellselect,
        type:'purple',
        content: '' +
        '<form action="" class="formName">' +
        '<div class="form-group">' +
        '<div id="errorInput"></div>'+
        '<label>Set Transactional Limit on cell</label>' +
        '<input type="text" maxlength="3" value="'+limitval+'" class="name form-control" required onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57"/>' +
        '</div>' +
        '</form>',
        buttons: {
            formSubmit: {
                text: 'Edit',
                btnClass: 'btn-success',
                action: function () {
                    var name = this.$content.find('.name').val();
                    if(!name){
                        $('#errorInput').html('<span class="text-danger">* Error Input Field Required</span>');
                        return false;
                    }else if(parseInt(name) === 0){
                        $('#errorInput').html('<span class="text-danger">* Error Valid Input Required</span>');
                        return false;
                    }else if(parseInt(name)=== parseInt(limitval)){
                         $('#errorInput').html('<span class="text-danger">* Error Limit Value Must be Different</span>');
                         return false;
                    }else if(parseInt(name) > 100){
                        $('#errorInput').html('<span class="text-danger">*Required value must be between [ 1-100 ]</span>');
                        return false;
                    }
                    $('#limitNumx'+cellid).html(name);
                    $('#cellLimitx'+cellid).show();              
                }
            },
            close: function () {
                
            },
        },
        onContentReady: function () {
            // bind to events
            var jc = this;
            this.$content.find('form').on('submit', function (e) {
                // if the user submits the form by pressing enter in the field.
                e.preventDefault();
                jc.$$formSubmit.trigger('click'); // reference the button and click it
            });
        }
    });
}
</script>