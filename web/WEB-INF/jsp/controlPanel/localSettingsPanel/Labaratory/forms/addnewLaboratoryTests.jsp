<%-- 
    Document   : addnewLaboratoryTests
    Created on : Sep 12, 2018, 12:20:23 PM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<hr>
<input id="InputPatientLabSubClassificationsid" value="${labSubCategoryid}" type="hidden">
<div class="row" >
    <div class="col-md-4">
        <div class="row" style="">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Enter Lab Tests Details</h4>
                    <div class="tile-body">
                        <form id="entryLabClassificationTestsform">
                            <div class="form-group">
                                <label>Lab Test Name</label>
                                <input type="text" placeholder="Lab Test Name" id="labClassificationTestName" class=" form-control" required />
                            </div>
                            <div class="form-group">
                                <label>Select Test Procedure</label>
                                <select  id="selectTestProcedure" class=" form-control" required>
                                    <option  value="">-------Select-------</option>  
                                    <c:forEach items="${laboratorytestMethodsList}" var="c">
                                        <option  value="${c.testmethodid}">${c.testmethodname}</option>   
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Test Units</label>
                                <input type="text" placeholder="Lab Test Unit" id="labtestunits" class=" form-control" required />
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <textarea class="form-control rounded-0" id="labTestsDescriptions" rows="3"></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="LabTestsbtn" onclick="addClassificationLabTest(this.id);" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Add Test
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
                    <h4 class="tile-title">Entered Lab Test.</h4>
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Lab Test</th>
                                <th>Test Method</th>
                                <th>Test Unit</th>
                                <th>Description</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredClassificationTestsBody">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function addClassificationLabTest(id) {
        var testname = $('#labClassificationTestName').val();
        var testmethod = $('#selectTestProcedure').val();
        var desc = $('#labTestsDescriptions').val();
        var classifid = $('#InputPatientLabSubClassificationsid').val();
        var testunits=$('#labtestunits').val();
        if (testname !== '') {
            document.getElementById(id).disabled = true;
            $.ajax({
                type: 'POST',
                url: "locallaboratorysetingmanagement/addClassificationLabTests.htm",
                data: {testname: testname, testmethod: testmethod, desc: desc, classifid: classifid,testunits:testunits},
                success: function (data) {
                    document.getElementById('entryLabClassificationTestsform').reset();
                    if (data === 'reload') {
                        document.location.reload(true);
                    } else if (data !== 'failed' || data !== 'reload') {
                        $('#enteredClassificationTestsBody').append('<tr id="LabTestId' + data + '"><td>' + testname + '</td>' +
                                '<td>' + testmethod + '</td>' +
                                '<td>' + testunits + '</td>' +
                                '<td>' + desc + '</td>' +
                                '<td align="center"><span  title="Delete Of This Lab Test." onclick="deleteLabTestes(' + data + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');

                        document.getElementById(id).disabled = false;
                        
                    }
                }
            });

        }
    }
    function deleteLabTestes(laboratorytestid) {
        $.ajax({
            type: 'POST',
            data: {laboratorytestid: laboratorytestid},
            url: "locallaboratorysetingmanagement/deleteClassificationLabTests.htm",
            success: function (data) {
                if (data === 'delete') {
                    $('#LabTestId' + laboratorytestid).remove();
                } else if (data === 'reload') {
                    document.location.reload(true);
                }
            }
        });
    }
</script>