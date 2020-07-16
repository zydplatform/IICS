<%-- 
    Document   : addNewPacks
    Created on : Sep 18, 2018, 3:37:09 PM
    Author     : HP
--%>

<div class="row" >
    <div class="col-md-4">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Enter Description Details</h4>
                    <div class="tile-body">

                        <form id="entryCategoryItemform">
                            <div class="form-group">
                                <label class="control-label">Description Name</label>
                                <input class=" form-control" id="descriptionsItems"  type="text" placeholder="Description Name">
                            </div>                              
                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="disablingTheItemAdd" onclick="addNewItemDescrip();" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Add Description
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
                    <h4 class="tile-title">Entered Descriptions.</h4>
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Description Name</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredItemsDescriptionsBody">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var ItemDescrips = new Set();
    function addNewItemDescrip() {
        var name = $('#descriptionsItems').val();
        if (name !== '') {
            ItemDescrips.add(name);
            $('#descriptionsItems').val('');
            $('#enteredItemsDescriptionsBody').append('<tr id="itms' + name + '"><td>' + name + '</td>' +
                    '<td align="center"><span  title="Delete Of This Item." onclick="removeItemDescr(\'' + name + '\');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');
        }
    }
    function removeItemDescr(name) {
        ItemDescrips.delete(name);
        $('#itms' + name).remove();
    }
</script>