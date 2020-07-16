<%-- 
    Document   : addItemStrength
    Created on : Sep 24, 2018, 5:02:13 PM
    Author     : HP
--%>
<%@include file="../../../include.jsp" %>
<input id="AddItemtypesId" type="hidden" value="${issupplies}">
<input id="AddStregthItemId" type="hidden" value="${medicalitemid}">
<div class="row" >
    <div class="col-md-4">
        <div class="row" style="overflow: auto; height: 350px;" id="scrollingItemDiv">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Enter Item Details</h4>
                    <div class="tile-body">
                        <form id="entryCategoryItemform">
                            <div class="form-group">
                                <label class="control-label">Item Name</label>
                                <input class=" form-control" id="addnewcategoryitemname" value="${genericname}" type="text">
                            </div>
                            <div class="form-group">
                                <label class="control-label">Dosage Form</label>
                                <input class=" form-control" id="addnewcategoryitemform" type="text" value="${itemform}" placeholder="Item Form">
                            </div>
                            <div class="form-group">
                                <label>Item Strength</label>
                                <input type="text" placeholder="Item Strength" id="addnewcategoryitemstrength" class=" form-control" required />
                            </div>

                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="disablingAddStrenghtTheItemAdd" onclick="addNewStregthCategorysItem();" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Add Item
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="overlayStregthdelete" style="display: none;">
        <img src="static/img2/loader.gif" alt="Loading" /><br/>
        Please Wait...
    </div>
    <div class="col-md-8">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Entered Items.</h4>
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Item Name</th>
                                <th>Item Form</th>
                                <th>Item Strength</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredStregthCategoryItemsBody">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var itemStregthAdd = [];
    var itemstrengths = new Set();
    var counting = 0;
    function addNewStregthCategorysItem() {
        var itemname = $('#addnewcategoryitemname').val();
        var itemform = $('#addnewcategoryitemform').val();
        var itemstregth = $('#addnewcategoryitemstrength').val();
        if (itemname !== '' || itemform !== '' || itemstregth !== '') {
            counting++;
            itemStregthAdd.push({
                id: parseInt(counting),
                itemname: itemname,
                itemform: itemform,
                itemstregth: itemstregth
            });
            itemstrengths.add(parseInt(counting));

            $('#enteredStregthCategoryItemsBody').append('<tr id="StrengthItm' + counting + '"><td>' + itemname + '</td>' +
                    '<td>' + itemform + '</td>' +
                    '<td>' + itemstregth + '</td>' +
                    '<td align="center"><span  title="Delete Of This Item." onclick="addStregthcategoryItem(' + counting + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');

            $('#addnewcategoryitemstrength').val('');
        }
    }
    function addStregthcategoryItem(count) {
        for (i in itemStregthAdd) {
            if (parseInt(itemStregthAdd[i].id) === parseInt(count)) {
                itemStregthAdd.splice(i, 1);
                itemstrengths.delete(parseInt(count));
                $('#StrengthItm' + count).remove();
                break;
            }
        }
    }
</script>