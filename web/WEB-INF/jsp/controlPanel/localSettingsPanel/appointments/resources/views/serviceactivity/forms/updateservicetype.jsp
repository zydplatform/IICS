<%-- 
    Document   : updateservicetype
    Created on : May 21, 2018, 9:54:40 AM
    Author     : RESEARCH
--%>
<div class="col-md-12">
    <div class="row">
        <div class="form-group">
            <label for="exampleInputEmail1"> Facility Name:</label>
            <b>${model.FacilityListZ.facilityname}</b>
            <input class="form-control" id="facilityid" type="hidden" value="${model.FacilityListZ.facilityid}">
            <input class="form-control" id="facilityname" type="hidden" value="${model.FacilityListZ.facilityname}">
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <label class="control-label">Service Type Name</label>
            <input class="form-control" id="editactname" name="blockname" placeholder="Please Enter Block/Building Name">
            <input class="form-control" id="editactid" name="editfacilityblkid" type="hidden">
        </div>
        <div class="col-md-6">
            <label class="control-label">Duration(min)</label>
            <input class="form-control" id="editactduration" name="blockname" placeholder="Please Enter Block/Building Name">
        </div>
    </div>
    <div class="col-md-12">
        <label class="control-label">More Information On Service Type</label>
        <div class="form-group row" id="descriptext">
            <textarea class="form-control" id="editactdescription" name="blkdescription" rows="4" placeholder="Enter More Information About Building/Block"></textarea>
        </div>
    </div>
</div>
<script>
    $('#editserviceactivity').click(function () {
        var namez = $('#editactname').val();
        var editedname = namez.bold();
        $.confirm({
            title: 'Message!',
            content: 'Your about to Update' + ' ' + editedname,
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        var facilityid = $('#facilityid').val();
                        var name = $('#editactname').val();
                        var stypeid = $('#editactid').val();
                        var sduration = $('#editactduration').val();
                        var sdescription = $('#editactdescription').val();

                        var data = {
                            servicetypeid: stypeid,
                            facilityid: facilityid,
                            name: name,
                            duration: sduration,
                            description: sdescription

                        };

                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "Appointmentresources/Updateserviceactivity.htm",
                            data: data,
                            success: function (response) {

                                $.alert({
                                    title: 'Alert!',
                                    content: editedname + ' ' + 'Successfully Updated',
                                });

                                $('#updateServiceActivity').modal('hide');
                                ajaxSubmitData('Appointmentresources/serviceActivities.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }

                        });
                    }
                },
                cancel: function () {
                    $.alert({
                        title: 'Alert!',
                        content: 'Update' + ' ' + editedname + ' ' + 'Cancelled',
                    });
                    ajaxSubmitData('Appointmentresources/serviceActivities.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            }
        });

    });
</script>