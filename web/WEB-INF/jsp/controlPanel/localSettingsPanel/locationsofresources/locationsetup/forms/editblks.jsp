<%-- 
    Document   : editblks
    Created on : May 17, 2018, 11:25:07 AM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="col-md-12">
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label for="exampleInputEmail1"> Facility Name:</label>
                <input class="form-control" id="facilityid" type="hidden" value="${model.FacilityLists.facilityid}">
                <input class="form-control" id="facilityname" type="text" value="${model.FacilityLists.facilityname}">
            </div>
        </div>
        <div class="col-md-6">
            <label class="control-label">Block/Building Name</label>
            <input class="form-control" id="editblockname" name="blockname" placeholder="Please Enter Block/Building Name">
            <input class="form-control" id="editfacilityblkid" name="editfacilityblkid" type="hidden">
        </div>
    </div>
    <div class="col-md-12">
        <label class="control-label">More Information On Block/Building</label>
        <div class="form-group row" id="descriptext">
            <textarea class="form-control" id="editblkdescription" name="blkdescription" rows="4" placeholder="Enter More Information About Building/Block"></textarea>
        </div>
    </div>
</div>
<script>
    $('#updateblkz').click(function () {
         var blocknamez = $('#editblockname').val();
        $.confirm({
            title: 'Message!',
            content: 'Your about to Update'+ ' ' +blocknamez,
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        var facilityid = $('#facilityid').val();
                        var blockname = $('#editblockname').val();
                        var facilityblockid = $('#editfacilityblkid').val();
                        var description = $('#editblkdescription').val();

                        var data = {
                            facilityblockid: facilityblockid,
                            facilityid: facilityid,
                            blockname: blockname,
                            blockdescription: description

                        };

                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "locationofresources/Updatefacilityblock.htm",
                            data: data,
                            success: function (response) {

                                $.alert({
                                    title: 'Alert!',
                                    content: blockname +' '+ 'Successfully Updated',
                                });

                                document.getElementById('editblkdescription').value = "";
                                $('#editblk').modal('hide');
                               ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }

                        });
                    }
                },
                cancel: function () {
                    $.alert({
                        title: 'Alert!',
                        content: 'Update Cancelled',
                    });
                    ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            }
        });

    });
</script>