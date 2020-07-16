<%-- 
    Document   : addpost
    Created on : Mar 24, 2018, 9:47:06 AM
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
        <div class="tile" id="addpostform">
            <h3 class="tile-title">ADD NEW DESIGNATION</h3>
            <div class="tile-body">
                <form>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="control-label">Designation Category</label>
                                <input class="form-control" id="postdesignation" name="shortname" type="text" disabled="true" placeholder="Enter Designation">
                                <input id="designationcategoryid" name="designationcategoryid" type="hidden">
                            </div>
                            <div class="col-md-6">
                                <label class="control-label">Designation Name</label>
                                <input class="form-control" id="designationnames" required name="designationname" type="text" oninput="checkdesigname();" placeholder="Enter Designation Name">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <p><b>Additional Information</b></p>
                        <textarea class="form-control" id="descriptions" name="description" rows="3" placeholder="Enter Information About Designation"></textarea>
                    </div> 
                </form>
            </div>
            <div class="tile-footer">
                <button class="btn btn-primary" id="saveUniversalPosts" name="savepost" type="button"><a href="#" data-toggle="modal" data-target="#mey" style="color: whitesmoke"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save Designation</a></button>
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#posttext').hide();
        //$('#domainselect').select2();
    });

    function checkdesigname() {
        var designationname = document.getElementById('designationnames').value;
        var designationcategoryid = document.getElementById('designationcategoryid').value;

        if (designationname.length > 0) {
            document.getElementById('saveUniversalPosts').disabled = true;
            $.ajax({
                type: 'POST',
                data: {designationcategoryid: designationcategoryid, designationname: designationname},
                url: "postsandactivities/checkdesignationname.htm",
                success: function (response, textStatus, jqXHR) {
                    debugger
                    data = JSON.parse(response);
                    if (data.error === 'existing') {
                        $('#designationnames').addClass('error');
                        $.alert({
                            title: 'Alert!',
                            content: designationname + ' Already Exists in ' + data.category,
                        });
                        document.getElementById('saveUniversalPosts').disabled = true;
                        document.getElementById('designationnames').value = "";
                    } else {
                        $('#designationnames').removeClass('error');
                        document.getElementById('saveUniversalPosts').disabled = false;
                    }
                }
            });
        }
    }


    $('#saveUniversalPosts').click(function () {

        var validpostname = $("#designationnames").val();

        if (validpostname === '') {
            $('#designationnames').addClass('error');
            $.alert({
                title: 'Alert!',
                content:'Please Enter Designation Name',
            });
        } else {
            swal({
                title: "Save Designation?",
                type: "warning",
                showCancelButton: true,
                confirmButtonText: "Cancel",
                cancelButtonText: "Save",
                closeOnConfirm: true,
                closeOnCancel: false
            }
            ,
                    function (isConfirm) {
                        if (isConfirm) {

                            document.getElementById('designationnames').value = "";
                            document.getElementById('descriptions').value = "";

                        } else {
                            var designationname = $('#designationnames').val();
                            var designationcategoryid = $('#designationcategoryid').val();
                            var description = $('#descriptions').val();
                            $.ajax({
                                type: 'POST',
                                data: {designationname: designationname, description: description, designationcategoryid: designationcategoryid},
                                dataType: 'text',
                                url: "postsandactivities/savePosts.htm",
                                success: function (data, textStatus, jqXHR) {

                                    document.getElementById('designationnames').value = "";
                                    document.getElementById('descriptions').value = "";

                                    $('#addpost').modal('hide');
                                    $('.body').removeClass('modal-open');
                                    $('.modal-backdrop').remove();
                                    ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'workpane', '&uni', 'GET');
                                }
                            });
                            swal("Saved", "Post Added", "success");
                        }
                    });
        }
    });

</script>




