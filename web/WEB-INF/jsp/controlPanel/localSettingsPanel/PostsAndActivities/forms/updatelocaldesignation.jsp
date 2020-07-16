<%-- 
    Document   : updatelocaldesignation
    Created on : Apr 5, 2018, 3:04:10 PM
    Author     : SAMINUNU
--%>


<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <h3 class="tile-title">UPDATE DESIGNATION CATEGORY</h3>
            <div class="tile-body">
                <form>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="control-label">Facility</label>
                                <input class="form-control" id="facilityupdatename" name="facilityname" value="" type="text" disabled="true">
                                <input class="form-control" id="facilityupdateid" name="facilityid" value="" disabled="true" hidden="true">
                            </div>
                            <div class="col-md-6">
                                <label class="control-label">Designation Category Name</label>
                                <input class="form-control" id="localdesignationcategoryname" hidden="true" name="designationcategoryname" type="text" placeholder="Enter Name" value="">
                                <input class="form-control" id="loacldesignationcategoryid" type="text">
                            </div>

                        </div>
                    </div>
<!--                    <div class="form-group">
                        <label class="control-label">Additional Information</label>
                        <textarea class="form-control" id="localdesignationcategorydesc" name="designationcategorydesc" rows="3" placeholder="Enter Information About Desigantion"></textarea>
                    </div>-->
                </form>
            </div>
            <div class="tile-footer">
                <button class="btn btn-primary" id="updatedesignation" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save Designation Category</button>
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#domainselect').select2();
    });
    $('#updatedesignation').click(function () {

        var validdesigCatname = $("#loacldesignationcategoryid").val();
        if (validdesigCatname === '') {
            $('#loacldesignationcategoryid').addClass('error');
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

                            var designationcategoryid = $('#loacldesignationcategoryid').val();
                            var categoryname = $('#localdesignationcategoryname').val();
                            var facilityid = $('#facilityupdateid').val();
                            //var description = $('#localdesignationcategorydesc').val();

                            var data = {
                                designationcategoryid: designationcategoryid,
                                facilityid: facilityid,
                                categoryname: categoryname,
                                //description: description

                            };

                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "localsettingspostsandactivities/saveUpdateLocalDesignations.htm",
                                data: data,
                                success: function (response) {

                                    //document.getElementById('description').value = "";
                                    $('#updatelocaldesigna').modal('hide');
                                    $('.body').removeClass('modal-open');
                                    $('.modal-backdrop').remove();
                                    $('.close').click();
                                    ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
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

