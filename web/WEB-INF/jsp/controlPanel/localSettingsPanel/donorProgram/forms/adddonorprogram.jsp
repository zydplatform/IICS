<%-- 
    Document   : adddonorprogram
    Created on : Sep 4, 2018, 3:06:14 PM
    Author     : RESEARCH
--%>
<style>
    .error
    {
        border:2px solid red;
    }
    .myform{
        width: 100% !important;
    }

</style>
<div class="row">
    <div class="col-md-4">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <div id="horizontalwithwords"><span class="pat-form-heading">DONOR BASIC DETAILS</span></div>
                        <form id="donorentryform">
                            <div class="form-group">
                                <label class="control-label">Donor Program Name:</label>
                                <input class="form-control myform" oninput="checkdonorprogramname();" autofocus="autofocus" id="donorprogramname" type="text" placeholder="Enter Donor Program Name">
                            </div>
                            <div class="form-group">
                                <label class="control-label">Funder:</label>
                                <input class="form-control myform" autofocus="autofocus" id="funder" type="text" placeholder="Enter Donor Program Type">
                            </div>
                            <div class="form-group">
                                <label class="control-label">Donor Program Type:</label>
                                <input class="form-control myform" autofocus="autofocus" id="donorprogramtype" type="text">
                            </div>
                            <div class="form-group">
                                <b>Donor Program Time Line?</b>
                                <div class="toggle-flip">
                                    <label>
                                        <input type="checkbox" onclick="checkTimeLine();" id="checktimeline"><span class="flip-indecator" data-toggle-on="YES" data-toggle-off="NO"></span>
                                    </label>
                                </div>
                            </div>
                            <div id="hastimeline">
                                <div class="form-group">
                                    <label class="control-label required">Start Date:</label>
                                    <span id="errorshowstart"></span>
                                    <input class="form-control myform" id="startdate" type="text" placeholder="Enter Start Date">
                                </div>
                                <div class="form-group">
                                    <label class="control-label required">End Date:</label>
                                    <span id="errorshow"></span>
                                    <input class="form-control myform" id="enddate" type="text" placeholder="Enter End Date">
                                </div>
                            </div>
                        </form>
                        <div id="horizontalwithwords"><span class="pat-form-heading">DONOR CONTACT DETAILS</span></div>
                        <form id="buildingentryform">
                            <div class="form-group">
                                <label class="control-label">Tel No.:</label>
                                <input class="form-control myform" autofocus="autofocus" id="telno" type="text" placeholder="Enter Telephone Number">
                            </div>
                            <div class="form-group">
                                <label class="control-label">Email:</label>
                                <input class="form-control myform" autofocus="autofocus" id="email" oninput="checkEmail();" type="text" placeholder="Enter Email Address">
                                <h6 id='result'></h6>
                            </div>
                            <div class="form-group">
                                <label class="control-label">Fax:</label>
                                <input class="form-control myform" oninput="checkfax();" autofocus="autofocus" id="fax" type="text" placeholder="Enter Fax">
                            </div>
                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="captureDonorProgram" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Add Donor Program
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
                    <h4 class="tile-title">Entered Donor Program(s).</h4>
                    <table class="table table-sm table-bordered">
                        <thead>
                            <tr>
                                <th>Donor Program Name</th>
                                <th>Funder</th>
                                <th>Donor Program Type</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Tel No.</th>
                                <th>Email</th>
                                <th>Fax</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredDonorProgBody">

                        </tbody>
                    </table>
                </div>
                <div class="form-group">
                    <div class="col-sm-12 text-right">
                        <button type="button" class="btn btn-primary" id="savedonorprograms">
                            Finish
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var serverDate = '${serverdate}';
    var donorprogList = new Set();
    var donorprogObjectList = [];
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
    function checkTimeLine() {
        var x = document.getElementById("hastimeline");
        if (x.style.display === "none") {
            x.style.display = "block";
        } else {
            x.style.display = "none";
        }
    }

    function validateEmail(email) {
        var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    }

    function checkEmail() {
        var $result = $("#result");
        var email = $("#email").val();
        $result.text("");

        if (validateEmail(email)) {
            $result.css("color", "green");
            $.ajax({
                type: 'POST',
                data: {email: email},
                url: "donorprogram/checkdonoremail.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'existing') {
                        $('#donorprogramname').addClass('error');
                        $result.text(email + " already exists");
                        document.getElementById('captureDonorProgram').disabled = true;
                        document.getElementById('donorprogramname').value = "";
                    } else {
                        $('#donorprogramname').removeClass('error');
                        document.getElementById('captureDonorProgram').disabled = false;
                    }
                }
            });

        } else {
            $result.text(email + " is not a valid email");
            $('#email').addClass('error');
            $result.css("color", "red");
        }
        return false;
    }

    function checkdonorprogramname() {
        var donorprogramname = document.getElementById('donorprogramname').value;
        if (donorprogramname.length > 0) {
            document.getElementById('captureDonorProgram').disabled = true;
            $.ajax({
                type: 'POST',
                data: {donorname: donorprogramname},
                url: "donorprogram/checkdonorprogramname.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'existing') {
                        $('#donorprogramname').addClass('error');
                        $.alert({
                            title: 'Alert!',
                            content: donorprogramname + ' Already Exists',
                        });
                        document.getElementById('captureDonorProgram').disabled = true;
                        document.getElementById('donorprogramname').value = "";
                    } else {
                        $('#donorprogramname').removeClass('error');
                        document.getElementById('captureDonorProgram').disabled = false;
                    }
                }
            });
        }
    }


    var donornames = [];
    var donornamestestSet = new Set();
    $('#captureDonorProgram').click(function () {
        var funder = $('#funder').val();
        var donorprogramtype = $('#donorprogramtype').val();
        var telno = $('#telno').val();
        var email = $('#email').val();
        var fax = $('#fax').val();
        var donorProgramName = $('#donorprogramname').val();
        var startdate = $('#startdate').val();
        var enddate = $('#enddate').val();

        document.getElementById('funder').value = "";
        document.getElementById('donorprogramtype').value = "";
        document.getElementById('telno').value = "";
        document.getElementById('email').value = "";
        document.getElementById('fax').value = "";
        document.getElementById('donorprogramname').value = "";
        document.getElementById('startdate').value = "";
        document.getElementById('enddate').value = "";

        if (donorProgramName !== '') {
            var donorProgramNameUpper = donorProgramName.toUpperCase();
            console.log("------------------donorProgramNameUpper" + donorProgramNameUpper);
            console.log(donornamestestSet);
            if (donornamestestSet.has(donorProgramNameUpper)) {
                $.alert({
                    title: '',
                    content: '<div class="center">' + '<font size="5">' + '<strong class="text-danger">' + donorProgramName + '</strong> &nbsp;Already Exists!!</font></div>',
                    type: 'red',
                    typeAnimated: true,
                });
            } else {
                document.getElementById('savedonorprograms').disabled = false;
                var i = 1;
                $('#enteredDonorProgBody').append(
                        '<tr id="rowg' + i + '">' +
                        '<td class="center">' + donorProgramName + '</td>' +
                        '<td class="center" >' + funder + '</td>' +
                        '<td class="center" >' + donorprogramtype + '</td>' +
                        '<td class="center" >' + startdate + '</td>' +
                        '<td class="center" >' + enddate + '</td>' +
                        '<td class="center" >' + telno + '</td>' +
                        '<td class="center" >' + email + '</td>' +
                        '<td class="center" >' + fax + '</td>' +
                        '<td class="center">' +
                        '<span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')">' +
                        '<i class="fa fa-trash-o"></i></span></td></tr>'
                        );
                document.getElementById("donorentryform").reset();
                $('#donorProgramName').css('border', '2px solid #6d0a70');
                $('#funder').css('border', '2px solid #6d0a70');
                $('#donorprogramtype').css('border', '2px solid #6d0a70');
                $('#telno').css('border', '2px solid #6d0a70');
                $('#email').css('border', '2px solid #6d0a70');
                $('#fax').css('border', '2px solid #6d0a70');
                $('#startdate').css('border', '2px solid #6d0a70');
                $('#enddate').css('border', '2px solid #6d0a70');
                var data = {
                    donorProgramName: donorProgramName,
                    funder: funder,
                    donorprogramtype: donorprogramtype,
                    telno: telno,
                    email: email,
                    fax: fax,
                    startdate: startdate,
                    enddate: enddate
                };
                donornamestestSet.add(donorProgramName);
                donorprogObjectList.push(data);
            }

        } else {

            $('#donorProgramName').focus();
            $('#donorProgramName').css('border', '2px solid #f50808c4');
            $('#funder').focus();
            $('#funder').css('border', '2px solid #f50808c4');
            $('#donorprogramtype').focus();
            $('#donorprogramtype').css('border', '2px solid #f50808c4');
            $('#telno').focus();
            $('#telno').css('border', '2px solid #f50808c4');
            $('#email').focus();
            $('#email').css('border', '2px solid #f50808c4');
            $('#fax').focus();
            $('#fax').css('border', '2px solid #f50808c4');
            $('#startdate').focus();
            $('#startdate').css('border', '2px solid #f50808c4');
            $('#enddate').focus();
            $('#enddate').css('border', '2px solid #f50808c4');
        }
    });


    function remove(i) {
        $('#rowg' + i).remove();
        donorprogList.delete(i);
    }

    $('#savedonorprograms').click(function () {
        if (donorprogObjectList.length > 0) {
            var data = {
                donorProgramObject: JSON.stringify(donorprogObjectList)
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'donorprogram/saveDonorProgram.htm',
                success: function (data) {
                    console.log("=---------------------res" + data);
                    if (data === 'success') {
                        $.toast({
                            heading: 'Success',
                            text: 'Donor Program(s) Successfully Registered.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        ajaxSubmitData('donorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        window.location = '#close';
                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'An unexpected error occured while trying to register Donor Program(s).',
                            icon: 'error'
                        });
                        ajaxSubmitData('donorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        window.location = '#close';
                    }
                }
            });
        }

    });


</script>
