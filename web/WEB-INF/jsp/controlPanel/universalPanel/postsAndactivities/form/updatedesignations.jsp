<%-- 
    Document   : updatedesignations
    Created on : Mar 24, 2018, 5:43:44 AM
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
            <h3 class="tile-title">UPDATE DESIGNATION CATEGORY</h3>
            <div class="tile-body">
                <form>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label class="control-label">Domain</label>
                                <input class="form-control" id="domain_name" name="domain_name" value="" disabled="true">
                                <input class="form-control" id="domain_id" name="domain_name" value="" disabled="true" type="hidden">
                            </div>
                            <div class="col-md-8">
                                <label class="control-label">Name</label>
                                <input class="form-control" id="designationcategoryname" name="designationcategoryname" type="text" placeholder="Enter Name">
                                <input class="form-control" id="designationcategoryids" type="hidden">
                            </div>
                        </div>
                    </div>  
                    <div class="form-group">
                        <label class="control-label">Additional Information</label>
                        <textarea class="form-control" id="designationcategorydesc" name="designationcategorydesc" rows="3" placeholder="Enter Information About Desigantion"></textarea>
                    </div>
                </form>
            </div>
            <div class="tile-footer">
                <button class="btn btn-primary" id="updatedesignation" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save Changes</button>
                <button class="btn btn-secondary dismiss-modal" type="button" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#domainselect').select2();
    });

    $('#updatedesignation').click(function () {
        var validdesigCatname = $("#designationcategoryname").val();
        if (validdesigCatname === '') {
            $('#designationcategoryname').addClass('error');
            $.alert({
                title: 'Alert!',
                content: ' Please Enter Designation Category Name'
            });
        } else {

            $.confirm({
                title: 'Message!',
                content: 'Are You Sure You Want Update this Designation Category?',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {

                            var designationcategoryid = $('#designationcategoryids').val();
                            var categoryname = $('#designationcategoryname').val();
                            var facilitydomainid = $('#domain_id').val();
                            var description = $('#designationcategorydesc').val();

                            var data = {
                                designationcategoryid: designationcategoryid,
                                facilitydomainid: facilitydomainid,
                                categoryname: categoryname,
                                description: description

                            };

                            $.ajax({
                                type: 'POST',
                                dataType: 'text',
                                url: "postsandactivities/saveUpdateDesignations.htm",
                                data: data,
                                success: function (data, textStatus, jqXHR) {
                                    document.getElementById('description').value = "";
                                    ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'workpane', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    $('#updatedesigna').modal('hide');
                                }
                            });
                        }
                    },
                    NO: function () {
                        $('#updatedesigna').modal('hide');
                    }
                }
            });
        }
    });

</script>
