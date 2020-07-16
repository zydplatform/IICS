<%-- 
    Document   : addNewLabClassification
    Created on : Sep 9, 2018, 10:23:20 PM
    Author     : HP
--%>

<div class="row" >
    <div class="col-md-4">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Classification Details.</h4>
                    <div class="tile-body">
                        <form id="entryClassificationLabform">
                            <div class="form-group">
                                <label class="control-label">Classification Name</label>
                                <input class=" form-control" id="labClassificationName" type="text" placeholder="Classification Name">
                            </div>
                            <div class="form-group">
                                <label class="control-label">Description</label>
                                <textarea class="form-control" id="labClassificationDescriptions" rows="2"></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="disablingTheClassAdd" onclick="addLabClassifications();" type="button">
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
                    <h4 class="tile-title">Entered Classifications.</h4>
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Classification Name</th>
                                <th>Description</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredLabClassificationssBody">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function addLabClassifications() {
        var classificationname = $('#labClassificationName').val();
        var description = $('#labClassificationDescriptions').val();
        if (classificationname !== '') {
            $.ajax({
                type: 'POST',
                data: {classificationname: classificationname, description: description},
                url: "locallaboratorysetingmanagement/addnewLabClassifications.htm",
                success: function (data, textStatus, jqXHR) {
                    document.getElementById('entryClassificationLabform').reset();
                    if (data === 'reload') {
                        document.location.reload(true);
                    } else {
                        $('#enteredLabClassificationssBody').append('<tr id="deletLabClassif' + data + '"><td>' + classificationname + '</td>' +
                                '<td>' + description + '</td>' +
                                '<td align="center"><span  title="Delete Of This Lab Test." onclick="deleteLabClassTestes(' + data + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');
                    }
                }
            });
        }
    }
    function deleteLabClassTestes(labtestclassificationid) {
        $.ajax({
            type: 'POST',
            data: {labtestclassificationid: labtestclassificationid},
            url: "locallaboratorysetingmanagement/deleteLabClassTestes.htm",
            success: function (data, textStatus, jqXHR) {
                if (data === 'reload') {
                    document.location.reload(true);
                } else if (data === 'delete') {
                    $('#deletLabClassif' + labtestclassificationid).remove();
                }
            }
        });
    }
</script>