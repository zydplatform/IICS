<%-- 
    Document   : adddesigantions
    Created on : Mar 22, 2018, 10:46:13 AM
    Author     : SAMINUNU
--%>
<style>
    .error
    {
        border:2px solid red;
    }
</style>

<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <h3 class="tile-title">ADD NEW DESIGNATION CATEGORY</h3>
            <div class="tile-body">
                <form>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="control-label">Domain</label>
                                <input class="form-control" id="domainname" name="domain_name" disabled="true">
                                <input id="facilitydomainid" name="facilitydomainid" type="hidden">
                            </div>
                            <div class="col-md-6">
                                <label class="control-label">Designation Category Name</label>
                                <input class="form-control" id="categoryname" oninput="checkdesignationCategoryname();" required="true" name="categoryname" type="text" placeholder="Enter Designation Category Name">

                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <p><b>Additional Information</b></p>

                        <textarea class="form-control" id="description" name="description" rows="3" placeholder="Enter Information About Desigantion Category"></textarea>
                    </div>
                </form>
            </div>
            <div class="tile-footer">
                <button class="btn btn-primary" id="savedesignation" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save Designation Category</button>
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#desigtext').hide();
        //$('#domainselect').select2();
    });

    function checkdesignationCategoryname() {
        var categoryname = document.getElementById('categoryname').value;
        var facilitydomainid = document.getElementById('facilitydomainid').value;

        if (categoryname.length > 0) {
            document.getElementById('savedesignation').disabled = true;
            $.ajax({
                type: 'POST',
                data: {facilitydomainid: facilitydomainid, categoryname: categoryname},
                url: "postsandactivities/checkdesignationcategoryname.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'existing') {
                        $('#categoryname').addClass('error');
                        $.alert({
                            title: 'Alert!',
                            content: categoryname + ' Already Exists' ,
                        });
                        document.getElementById('savedesignation').disabled = true;
                        document.getElementById('categoryname').value = "";
                    } else {
                        $('#categoryname').removeClass('error');
                        document.getElementById('savedesignation').disabled = false;
                    }
                }
            });
        }
    }

</script>

