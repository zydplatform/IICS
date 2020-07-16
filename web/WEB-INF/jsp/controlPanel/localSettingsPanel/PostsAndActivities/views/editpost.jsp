<%-- 
    Document   : viewlocaldesignations
    Created on : Jul 2, 2009, 1:33:51 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>
<div class="tile">
    <div class="tile-body">
        <form>
            <div class="form-group">
                <div class="row">
                    <div class="col-md-6">
                        <label class="control-label">Designation Category</label>
                        <input class="form-control" id="localpostdesignations" name="domain" value="${categoryname}" type="text" disabled="true">
                        <input class="form-control" id="localpostdesignationsid" name="domain" value="${designationcategoryid}" type="hidden" disabled="true">
                    </div>
                    <div class="col-md-6">
                        <label class="control-label">Post</label>
                        <input class="form-control" id="localdesignationname" name="name" type="text" placeholder="Enter Designation Name" value="${designationname}">
                        <input class="form-control" id="localdesignationid" type="hidden" value="${designationid}">
                    </div>
                </div>
            </div>
            <div class="form-group" id="desigtext">
                <label class="control-label">Additional Information</label>
                <textarea class="form-control" id="localpostdescription" value="${description}" name="description" rows="3" placeholder="Enter Information About Post"></textarea>
            </div>
        </form>
    </div>
    <div class="tile-footer">
        <button class="btn btn-primary" id="saveUpdateLocalPost" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save Post</button>
        <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
    </div>
</div>
<script>
    $('#saveUpdateLocalPost').click(function () {
        var validdesigname = $("#localdesignationname").val();
        if (validdesigname === '') {
            $('#localdesignationname').addClass('error');
            $.alert({
                title: 'Alert!',
                content: ' Please Enter Post'
            });
        } else {
            $.confirm({
                title: 'Message!',
                content: 'Are You Sure You Want Update this Post?',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {

                            var designationcategoryid = $('#localpostdesignationsid').val();
                            var categoryname = $('#localpostdesignations').val();
                            var designationids = $('#localdesignationid').val();
                            var designationnames = $('#localdesignationname').val();
                            var description = $('#localpostdescription').val();

                            var data = {
                                designationcategoryid: designationcategoryid,
                                categoryname: categoryname,
                                designationid: designationids,
                                designationname: designationnames,
                                description: description

                            };

                            $.ajax({
                                type: 'POST',
                                dataType: 'text',
                                url: "localsettingspostsandactivities/saveUpdatelocalPosts.htm",
                                data: data,
                                success: function (results) {
                                    console.log("data------------"+results);
                                    if (results === 'success') {
                                        $('.close').click();
                                        ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                                    } else {

                                    }
                                }
                            });
                        }
                    },
                    NO: function () {
                        $('#updatelocalposts').modal('hide');
                    }
                }
            });
        }
    });
</script>