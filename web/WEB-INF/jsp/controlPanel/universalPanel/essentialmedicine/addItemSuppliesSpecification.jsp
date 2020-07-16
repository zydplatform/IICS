<%-- 
    Document   : addItemSuppliesSpecification
    Created on : Sep 25, 2018, 10:18:45 AM
    Author     : HP
--%>
<input id="AddItemtypesId" type="hidden" value="${issupplies}">
<input id="AddItemSpecificationId" type="hidden" value="${medicalitemid}">
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
                                <input class=" form-control" id="addnewSundriescategoryitemname" value="${genericname}" type="text">
                            </div>

                            <div class="form-group">
                                <label>Item Specification</label>
                                <input type="text" placeholder="Item Specification" id="addnewcategoryitemSpecification" class=" form-control" required />
                            </div>

                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="disablingAddStrenghtTheItemAdd" onclick="addNewSpecificationCategorysItem();" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Add Item
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="overlaySpecificationdelete" style="display: none;">
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
                                <th>Item Specification</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredSpecificationCategoryItemsBody">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var itemSpecificationAdd = [];
    var itemSpecifications = new Set();
    var countingSp = 0;
    function addNewSpecificationCategorysItem() {
        var itemname = $('#addnewSundriescategoryitemname').val();
        var itemspecification = $('#addnewcategoryitemSpecification').val();
        if (itemname !== '' || itemspecification !== '') {
            countingSp++;
            itemSpecificationAdd.push({
                id: parseInt(countingSp),
                itemname: itemname,
                itemspecification: itemspecification
            });
            itemSpecifications.add(parseInt(countingSp));

            $('#enteredSpecificationCategoryItemsBody').append('<tr id="SpecificationItm' + countingSp + '"><td>' + itemname + '</td>' +
                    '<td>' + itemspecification + '</td>' +
                    '<td align="center"><span  title="Delete Of This Item." onclick="addSpecificationcategoryItem(' + countingSp + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');

            $('#addnewcategoryitemSpecification').val('');
        }
    }
    function addSpecificationcategoryItem(count){
        for (i in itemSpecificationAdd) {
            if (parseInt(itemSpecificationAdd[i].id) === parseInt(count)) {
                itemSpecificationAdd.splice(i, 1);
                itemSpecifications.delete(parseInt(count));
                $('#SpecificationItm' + count).remove();
                break;
            }
        } 
    }
</script>
