<%-- 
    Document   : editdonordetails
    Created on : Sep 5, 2018, 10:16:37 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-6">
        <div class="row tile">
            <div id="horizontalwithwords"><span class="pat-form-heading">DONOR BASIC DETAILS</span></div>
            <form id="donorentryform" class="col-md-12">
                <div class="form-group">
                    <label class="control-label">Donor Program Name:</label>
                    <input class="form-control myform" value="${donorprogramid}" oninput="checkdonorprogramname();" autofocus="autofocus" id="donorprogramid" type="hidden" placeholder="Enter Donor Program Name">
                    <input class="form-control myform" value="${donorname}" oninput="checkdonorprogramname();" autofocus="autofocus" id="donorname" type="text" placeholder="Enter Donor Program Name">
                </div>
                <div class="form-group">
                    <label class="control-label">Funder:</label>
                    <input class="form-control myform" value="${funder}" autofocus="autofocus" id="funder" type="text" placeholder="Enter Donor Program Type">
                </div>
                <div class="form-group">
                    <label class="control-label">Donor Program Type</label>
                    <input class="form-control myform" value="${donortype}" autofocus="autofocus" id="donortype" type="text">
                </div>
                <div class="form-group">
                    <b>Donor Program Time Line?</b>
                </div>
                <div class="form-group">
                    <label class="control-label required">Start Date:</label>
                    <span id="errorshowstart"></span>
                    <input class="form-control myform" id="startdate" value="${startdate}" type="text" placeholder="Enter Start Date">
                </div>
                <div class="form-group">
                    <label class="control-label required">End Date:</label>
                    <span id="errorshow"></span>
                    <input class="form-control myform" id="enddate" value="${enddate}" type="text" placeholder="Enter End Date">
                </div>
            </form>
        </div>
    </div>
    <div class="col-md-6">
        <div class="row tile">

            <div id="horizontalwithwords"><span class="pat-form-heading">DONOR CONTACT DETAILS</span></div>
            <form id="buildingentryform" class="col-md-12">
                <div class="form-group">
                    <label class="control-label">Tel No.:</label>
                    <input class="form-control myform" value="${telno}" autofocus="autofocus" id="telno" type="text" placeholder="Enter Telephone Number">
                </div>
                <div class="form-group">
                    <label class="control-label">Email:</label>
                    <input class="form-control myform" value="${email}" oninput="checkemail();" autofocus="autofocus" id="email" type="text" placeholder="Enter Email Address">
                </div>
                <div class="form-group">
                    <label class="control-label">Fax:</label>
                    <input class="form-control myform" value="${fax}" oninput="checkfax();" autofocus="autofocus" id="fax" type="text" placeholder="Enter Fax">
                </div>
            </form>
        </div>
    </div>

    <div class="tile-footer">
        <button class="btn btn-primary" id="captureDonorProgram" onclick="saveEditedDetails()" type="button">
            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
            Save Donor Program
        </button>
    </div>
</div>

<script>
    var serverDate = '${serverdate}';
    jQuery(document).ready(function () {
        $('[data-toggle="popover"]').popover();
        document.getElementById('savedonorprograms').disabled = true;

        $('#hastimeline').hide();

        $('#startdate').datetimepicker({
            pickTime: false,
            format: "DD/MM/YYYY",
            minDate: new Date(serverDate)
                    // defaultDate: new Date()
        });

        var startdate = $('#startdate').val();
        var newdate = new Date(serverDate);
        var v = new Array();
        v = startdate.split('/');
        var dayx = v[0];
        var monthx = v[1];
        var yearx = v[2];
        var dd = newdate.setDate(dayx);
        var mm = newdate.setMonth(monthx);
        var y = newdate.setFullYear(yearx);
        var someFormattedDate = newdate.getDate() + '/' + newdate.getMonth() + '/' + newdate.getFullYear();

        $('#enddate').click(function () {
            var checkorderingstartDate = $('#startdate').val();
            if (checkorderingstartDate === '') {
                $('#errorshowstart').html('<span style="color:red;">* Error Donor Program Start Date Required</span>');
                $('#startdate').css('border-color', 'red');
                $("#enddate").prop('disabled', true);
            } else {
                $('#errorshowstart').html('');
                $('#startdate').css('border-color', '');
                $('#enddate').datetimepicker({
                    pickTime: false,
                    format: "DD/MM/YYYY",
                    minDate: someFormattedDate
                });
            }
        });
        $('#startdate').on('change', function () {
            $('#enddate').val('');
            $('#enddate').css('border-color', '');
            $('#errorshow').html('');
            $("#enddate").prop('disabled', false);
            $('#disablethisScheduleTable input[type=checkbox]').prop("disabled", true);
        });

        $('#enddate').on('change', function () {
            var endx = $(this).val().split("/");
            var startx = $('#startdate').val().split("/");
            var datestart = new Date(startx[2], startx[1] - 1, startx[0]);
            var dateEnd = new Date(endx[2], endx[1] - 1, endx[0]);
            if (datestart.getTime() > dateEnd.getTime()) {
                //console.log(datestart.getTime() + ' greater than ' + dateEnd.getTime());
                $('#errorshow').html('<span style="color:red;">* Error  Donor Program End Date must be greater or Equal to Ordering Start Date</span>');
                $(this).css('border-color', 'red');
            } else if (datestart.getTime() <= dateEnd.getTime()) {
                var start = datestart,
                        end = dateEnd,
                        currentDate = new Date(start),
                        between = [];
                while (currentDate <= end) {
                    between.push(new Date(currentDate).getDay());
                    currentDate.setDate(currentDate.getDate() + 1);
                }
                var selectedrangedays = between;
                var uniqueselectedrangedays = [];
                $.each(selectedrangedays, function (i, item) {
                    if ($.inArray(item, uniqueselectedrangedays) === -1)
                        uniqueselectedrangedays.push(item);

                });
                $(this).css('border-color', '');
                $('#errorshow').html('');
            } else {
                $('#errorshow').html('');
            }
        });
    });
    function saveEditedDetails() {
        var donorprogramid = $('#donorprogramid').val();
        var funder = $('#funder').val();
        var donortype = $('#donortype').val();
        var telno = $('#telno').val();
        var email = $('#email').val();
        var fax = $('#fax').val();
        var donorname = $('#donorname').val();
        var startdate = $('#startdate').val();
        var enddate = $('#enddate').val();

        $.ajax({
            type: 'POST',
            data: {donorprogramid: donorprogramid, donorname: donorname, funder: funder, donortype: donortype, telno: telno, email: email, fax: fax, startdate: startdate, enddate: enddate},
            url: 'donorprogram/saveEditedDonorProgramInfo.htm',
            success: function (data) {
                console.log("=---------------------res" + data);
                if (data === 'success') {
                    $.toast({
                        heading: 'Success',
                        text: 'Donor Program Details Successfully Edit.',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    ajaxSubmitData('donorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    window.location = '#close';
                } else {
                    $.toast({
                        heading: 'Error',
                        text: 'An unexpected error occured while trying to edit Donor Program Deatils.',
                        icon: 'error'
                    });
                    ajaxSubmitData('donorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    window.location = '#close';
                }
            }
        });

    }
</script>