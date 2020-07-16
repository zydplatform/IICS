<%-- 
    Document   : addNewLabClassificationSubCategory
    Created on : Sep 13, 2018, 2:09:02 PM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<input id="addingClassificationsSubCategoryid" value="${labtestclassificationid}" type="hidden">
<div class="row" >
    <div class="col-md-4">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Sub Category Details.</h4>
                    <div class="tile-body">
                        <form id="entryClassificationLabform">
                            <div class="form-group">
                                <label class="control-label">Sub Category Name</label>
                                <input class=" form-control" id="labClassificationSubCategoryName" type="text" placeholder="Sub Category Name">
                            </div>
                            <div class="form-group">
                                <label class="control-label">Description</label>
                                <textarea class="form-control" id="labClassificationSubCategoryDescrips" rows="2"></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="disablingTheClassSubCatAdd" onclick="addLabClassificationSubCategory();" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Add 
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
                    <h4 class="tile-title">Entered Sub Category.</h4>
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Sub Category Name</th>
                                <th>Description</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredLabClassificationSubCategoryBody">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function addLabClassificationSubCategory() {
        var categoryname = $('#labClassificationSubCategoryName').val();
        var description = $('#labClassificationSubCategoryDescrips').val();
        var classifid = $('#addingClassificationsSubCategoryid').val();
        if (categoryname !== '') {
            document.getElementById('disablingTheClassSubCatAdd').disabled = true;
            $.ajax({
                type: 'POST',
                data: {categoryname: categoryname, description: description, classifid: classifid},
                url: "locallaboratorysetingmanagement/addLabClassificationSubCategory.htm",
                success: function (data) {
                    document.getElementById('disablingTheClassSubCatAdd').disabled = false;
                    if (data === 'reload') {
                        document.location.reload(true);
                    } else {
                        $('#enteredLabClassificationSubCategoryBody').append('<tr id="deleteSuCatId' + data + '"><td>' + categoryname + '</td>' +
                                '<td>' + description + '</td>' +
                                '<td><span  title="Delete Of This Lab Test." onclick="deleteLabSubCategory(' + data + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');
                    }
                }
            });
        }
    }
    function deleteLabSubCategory(labtestclassificationid) {
        $.ajax({
            type: 'POST',
            url: "locallaboratorysetingmanagement/deleteLabClassTestes.htm",
            data: {labtestclassificationid: labtestclassificationid},
            success: function (data, textStatus, jqXHR) {
                if (data === 'reload') {
                    document.location.reload(true);
                } else if (data === 'delete') {
                    $('#deleteSuCatId' + labtestclassificationid).remove();
                }
            }
        });
    }
</script>