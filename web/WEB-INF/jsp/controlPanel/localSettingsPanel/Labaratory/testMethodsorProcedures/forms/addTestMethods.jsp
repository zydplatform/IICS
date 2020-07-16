<%-- 
    Document   : addTestMethods
    Created on : Sep 6, 2018, 1:47:05 AM
    Author     : HP
--%>
<hr>
<div class="row" >
    <div class="col-md-4">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Enter Item Details</h4>
                <div class="tile-body">
                    <form id="entryLabTestProcedureform">
                        <div class="form-group">
                            <label class="control-label">Test Method Name</label>
                            <input class=" form-control" id="testMethodsName" oninput="checkforexistingTestMethod(this.value);" type="text" placeholder="Test Method Name">
                            <p  id="alreadytestMethodsExistingParagraph" style="color: red; display: none;">Method Already Exists &nbsp;<i class="fa fa-fw fa-dedent icon-custom"  onclick=""></i></p>
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="disablingLatTestProcAdd" onclick="addNewTestLabMethod(this.id);" type="button">
                        <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                        Add Test Method
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-8">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Entered Methods.</h4>
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Item Name</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredLabTestMethodsBody">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var addTestMethods = new Set();
    var methodcount = 0;
    function addNewTestLabMethod(id) {
        var testmethod = $('#testMethodsName').val();
        if (testmethod !== '') {
            methodcount++;
            addTestMethods.add(testmethod);
            $('#enteredLabTestMethodsBody').append('<tr id="testmethodct' + testmethod + '"><td>' + testmethod + '</td>' +
                    '<td align="center"><span  title="Delete Of This Lab Test Method." onclick="deleteLabTestsmethod(\'' + testmethod + '\');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');

            $('#testMethodsName').val('');
        }
    }
    function deleteLabTestsmethod(testmethod) {
        addTestMethods.delete(testmethod);
        $('#testmethodct' + testmethod).remove();
    }
</script>