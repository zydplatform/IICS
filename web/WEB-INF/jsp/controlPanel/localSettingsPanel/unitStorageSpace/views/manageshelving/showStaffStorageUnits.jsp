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
<div id="showzones">
<c:if test = "${Zonetree.staffcheck == 0}">
    <div class="row">
        <div class="col-md-8">
            <h5>Assigned Units for ${Zonetree.staffName}</h5> 
        </div>
        <div class="col-md-4">
            <label class="mb-2 btn btn-primary btn-block" id="alertmsg">Previous Assigned <c:if test="${Zonetree.StaffassignedcellCount > 1}">Cells</c:if>
            <c:if test="${Zonetree.StaffassignedcellCount == 1}">Cell</c:if>: <span class="badge badge-pill badge-light">${Zonetree.StaffassignedcellCount}</span></label>     
        </div>
    </div>   
   <hr>   
    <span id="staffid" style="display:none;">${Zonetree.staffid}</span>
    <span id="zoneid" style="display:none;">${Zonetree.zoneid}</span>
    <div class="tile-body">
        <div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
            <ul id="treeview0" class="hummingbird-base">
                <button class="btn btn-success" id="expandAll0"><i class="fa fa-expand">&nbsp;Expand All</i> </button> | <button class="btn btn-success" id="collapseAll0"><i class="fa fa-arrows">&nbsp;Collapse ALL</i> </button>
                <li style="margin-left: 9%;">
                    <i class="fa fa-plus"></i> <label> <!--<input id="" data-id="custom-1" type="checkbox">--> ${Zonetree.zonelabel}</label>
                    <ul id="xx">
                        <c:forEach items="${Zonetree.bays}" var="bay" varStatus="baystatus" begin="0" end="${Zonetree.baysize}">
                            <li>
                                <i class="fa fa-plus"></i><label><!--<input <c:if test="${bay.assigned==true}">checked="checked"</c:if> class="hummingbirdNoParent" id="" data-id="custom-1-3" type="checkbox">--> ${bay.bayName} </label>
                                    <ul id="xx">
                                    <c:forEach items="${bay.rows}" var="row"  varStatus="rowstatus" begin="0" end="${bay.rowsize}">
                                        <li>
                                            <i class="fa fa-plus"></i><label><!--<input class="hummingbirdNoParent" id="" data-id="custom-1-3" <c:if test="${row.assigned==true}">checked="checked"</c:if> type="checkbox">-->  ${row.rowlabel}  </label>
                                                <ul id="xx">
                                                <c:forEach items="${row.cells}" var="cell" varStatus="cellstatus" begin="0" end="${row.cellsize}">
                                                    <!--<li>
                                                        <i class="fa fa-long-arrow-right"></i><label> <input <c:if test="${cell.assigned==true}">checked="checked"</c:if> class="hummingbirdNoParent" id="${cell.cellid}" data-id="${cell.assigned}" type="checkbox"onChange="if (this.checked) {
                                                                checkedoruncheckStaffCell('checked', this.id, $(this).attr('data-id'));
                                                            } else {
                                                                checkedoruncheckStaffCell('unchecked', this.id, $(this).attr('data-id'));
                                                            }">${cell.cellLabel} </label>
                                                    </li>-->
                                                    <li>
                                                       <label class="containerxTree">&#8594
                                                            <input <c:if test="${cell.assigned==true}">checked="checked"</c:if> class="hummingbirdNoParent" id="${cell.cellid}" data-id="${cell.assigned}" type="checkbox" onChange="if (this.checked) {
                                                                checkedoruncheckStaffCell('checked', this.id, $(this).attr('data-id'));
                                                            } else {
                                                                checkedoruncheckStaffCell('unchecked', this.id, $(this).attr('data-id'));
                                                            }">
                                                            <span class="checkmarkTree"></span>
                                                            ${cell.cellLabel}</label>
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

    <div id="addcellsdiv" style="display: none;">
        <label class="formLabelTxt">Add:&nbsp;<Strong id="addcellsdivitems"></Strong> &nbsp; Staff Cell </label> &nbsp;&nbsp;&nbsp;
    </div>
    <div id="removecellsdiv" style="display: none;">
        <label class="formLabelTxt">Remove:&nbsp;<Strong id="removecellsdivitems"></Strong> &nbsp;Staff Cell </label> &nbsp;&nbsp;&nbsp;
    </div>
    <div class="modal-footer">
        <div id="savecellassignmentordesignment" style="display: none;">
            <button  class="btn btn-success pull-right" onclick="savestaffcellassignmentordesignment();"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save Changes</button>
        </div>
    </div>

</c:if>
<c:if test = "${Zonetree.staffcheck == 1}">        
    <h5>Assign Storage Units to  ${Zonetree.staffName}</h5>
    <hr>
    <span id="staffid" style="display:none;">${Zonetree.staffid}</span>
    <span id="zoneid" style="display:none;">${Zonetree.zoneid}</span>
    <div class="tile-body">
        <div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
            <ul id="treeview1" class="hummingbird-base">
               <button class="btn btn-success" id="expandAll1"><i class="fa fa-expand">&nbsp;Expand All</i> </button> | <button class="btn btn-success" id="collapseAll1"><i class="fa fa-arrows">&nbsp;Collapse ALL</i> </button>
                <li style="margin-left: 9%;">
                    <i class="fa fa-plus"></i> <label> <input id="" data-id="custom-1" type="checkbox"> ${Zonetree.zonelabel}</label>
                    <ul id="xx">
                        <c:forEach items="${Zonetree.bays}" var="bay" varStatus="baystatus" begin="0" end="${Zonetree.baysize}">
                            <li>
                                <i class="fa fa-plus"></i><label><input <c:if test="${bay.assigned==true}">checked="checked"</c:if> class="hummingbirdNoParent" id="" data-id="custom-1-3" type="checkbox"> ${bay.bayName} </label>
                                    <ul id="xx">
                                    <c:forEach items="${bay.rows}" var="row"  varStatus="rowstatus" begin="0" end="${bay.rowsize}">
                                        <li>
                                            <i class="fa fa-plus"></i><label><input class="hummingbirdNoParent" id="" data-id="" <c:if test="${row.assigned==true}">checked="checked"</c:if> type="checkbox">  ${row.rowlabel}  </label>
                                                <ul id="xx">
                                                <c:forEach items="${row.cells}" var="cell" varStatus="cellstatus" begin="0" end="${row.cellsize}">
                                                    <li>
                                                        <i class="fa fa-long-arrow-right"></i><label> <input class="hummingbirdNoParent" id="${cell.cellid}" data-id="custom-1-5" type="checkbox">${cell.cellLabel} </label>
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
        <!--  <button class="btn btn-primary" id="checkAll">Check All</button>
          <button class="btn btn-primary" id="uncheckAll">Uncheck All</button>-->  
    </div>
    <div class="modal-footer">
        <button  class="btn btn-success pull-right" id="showdataAssignedCells"><i class="fa fa-plus"></i>&nbsp;Assign Cell</button>
    </div>
</c:if>               
</div>
<script src="static/mainpane/js/hummingbird-treeview.js"></script>
<script>
$(document).ready(function () {
    $("#treeview0").hummingbird();
    $("#treeview1").hummingbird();
    /*$("#checkAll").click(function () {
     $("#treeview").hummingbird("checkAll");
     });
     $("#uncheckAll").click(function () {
     $("#treeview").hummingbird("uncheckAll");
     });*/
    $("#collapseAll0").click(function () {
        $("#treeview0").hummingbird("collapseAll");
    });
    $('#expandAll0').click(function () {
        $("#treeview0").hummingbird("expandAll");
    });
       $("#collapseAll1").click(function () {
        $("#treeview1").hummingbird("collapseAll");
    });
    $('#expandAll1').click(function () {
        $("#treeview1").hummingbird("expandAll");
    });
    // get checked nodes
    $('#showdataAssignedCells').click(function () {
        var staffid = $('#staffid').html();
        var zonxeid = $('#zoneid').html();
        var List = [];
        $("#treeview1").hummingbird("getChecked", {
            attr: "id",
            list: List,
            OnlyFinalInstance: true
        });
        var ListwithoutEmptyspace = List.filter(o => Object.keys(o).length);
        var CurrentList = [];
        if (!isEmpty(ListwithoutEmptyspace)) {
            CurrentList.push({
                staffid: staffid,
                staffcells: ListwithoutEmptyspace,
                zoneid: zonxeid
            });
            $.ajax({
                type: 'GET',
                cache: false,
                dataType: 'text',
                data: {selectedstaffbayrowcells: JSON.stringify(CurrentList)},
                url: "localsettigs/savestaffbayrowcell.htm",
                success: function (data) {
                    if (data === 'success') {
                        $.toast({
                            heading: 'Success',
                            text: 'Staff Cells Saved Successfully.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                       // $('#staffList').show();
                       // $('#showStaffUnitsx').hide();
                        window.location = '#close';
                    }
                }
            });
        }

    });
});
function isEmpty(obj) {
    for (var key in obj) {
        if (obj.hasOwnProperty(key))
            return false;
    }
    return true;
}
var addassignmentstaff = new Set();
var dessignmentstaff = new Set();
function checkedoruncheckStaffCell(type, selectedCellid, state) {    
    if (type === 'checked' && state === 'false') {
        addassignmentstaff.add(selectedCellid);
    } else if (type === 'unchecked' && state === 'true') {
        dessignmentstaff.add(selectedCellid);
    } else if (type === 'checked' && state === 'true') {
        if (dessignmentstaff.has(selectedCellid)) {
            dessignmentstaff.delete(selectedCellid);
        }
    } else if (type === 'unchecked' && state === 'false') {
        if (addassignmentstaff.has(selectedCellid)) {
            addassignmentstaff.delete(selectedCellid);      
        }
    }else {
    }
        
    if (parseInt(addassignmentstaff.size) === 0) {
        document.getElementById('addcellsdiv').style.display = 'none';
    } else {
        document.getElementById('addcellsdivitems').innerHTML = addassignmentstaff.size;
        document.getElementById('addcellsdiv').style.display = 'block';
    }
    if (parseInt(dessignmentstaff.size) === 0) {
        document.getElementById('removecellsdiv').style.display = 'none';
    } else {
        document.getElementById('removecellsdiv').style.display = 'block';
        document.getElementById('removecellsdivitems').innerHTML = dessignmentstaff.size;
    }
    if (parseInt(addassignmentstaff.size) === 0 && parseInt(dessignmentstaff.size) === 0) {
        document.getElementById('savecellassignmentordesignment').style.display = 'none';
    } else {
        document.getElementById('savecellassignmentordesignment').style.display = 'block';
    }
}    
function savestaffcellassignmentordesignment(){    
    var staffid = $('#staffid').html();
    var zonxeid = $('#zoneid').html();
    //console.log(zonxeid);
    //console.log(staffid);
    //console.log(addassignmentstaff);   
    //console.log(dessignmentstaff);
    $.ajax({
     type: 'POST',
     data: {zoneid:zonxeid,staffid:staffid,add: JSON.stringify(Array.from(addassignmentstaff)), remove: JSON.stringify(Array.from(dessignmentstaff))},
     url: "localsettigs/saveorremovecellsfromstaff.htm",
     success: function (data, textStatus, jqXHR) {
         addassignmentstaff.clear();
         dessignmentstaff.clear();
         $.toast({
             heading: 'Success',
             text: 'Selected Cells Successfully Add And/Or Removed from The Staff',
             icon: 'success',
             hideAfter: 2000,
             position: 'bottom-center'
         });
        window.location = '#close';
     },
     error: function (jqXHR, textStatus, errorThrown) {
         $.toast({
             heading: 'Error',
             text: 'An unexpected error occured while trying to Add / Remove Cells From the Staff',
             icon: 'error',
             hideAfter: 2000,
             position: 'bottom-center'
         });
            window.location = '#close';
     }
 });
}    
</script>