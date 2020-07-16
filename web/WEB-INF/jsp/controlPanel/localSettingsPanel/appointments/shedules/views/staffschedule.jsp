<%-- 
    Document   : staffschedule
    Created on : May 16, 2018, 8:33:09 AM
    Author     : user
--%>
<%@include file="../../../../../include.jsp" %>
<style>
    .xv  tr td{border: whitesmoke;}
    #detailsdesign{font-size: .6em;background: purple;color: whitesmoke;padding: 2px;}
</style>
<div class="">
    <div class="col-md-12">
        <fieldset>
            <legend align="center"><strong id="detailsdesign" >Resource Details</strong></legend>
            <table style="border:whitesmoke;" class="table table-responsive xv" align="center">
                <tbody>
                    <tr>
                        <td><b>Resource Type</b></td>
                        <td>:${staffmemberx.scheduletype}</td> 
                    </tr>
                    <tr>
                        <td><b>Facility Unit</b></td>
                        <td>:${staffmemberx.facilityunitname} - <strong>[${staffmemberx.facilityunitshortname}]</strong> </td> 
                    </tr>
                    <tr>
                        <td><b>Staff</b><span id="staffidx" class="hidedisplaycontent">${staffmemberx.staffid}</span></td>
                        <td>:${staffmemberx.StaffName}</td> 
                    </tr>
                </tbody>
            </table>  
        </fieldset>
    </div>
    <div class="row">
        <div class="col-md-5">
            <fieldset>
                <legend align="center"><strong id="detailsdesign" >Schedule Details</strong></legend>
                <table style="border:whitesmoke;" class="table table-responsive xv" align="center">
                    <tbody>
                        <tr>
                            <td><b>Start Date</b></td>
                            <td><span  id="errorshowstart"></span>
                                <input class="form-control" id="startDate" type="text" placeholder="Start Date">
                            </td> 
                        </tr>                    
                        <tr>
                            <td><b>End Date</b></td>
                            <td><span  id="errorshow"></span>
                                <input class="form-control" id="endDate" type="text" placeholder="End Date">
                            </td> 
                        </tr>
                        <tr>
                            <td><b>Schedule Days</b></td>
                            <td id ="disablethisScheduleTable">
                                <div id="changetableview">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Mon</th>
                                                <th>Tue</th>
                                                <th>Wed</th>
                                                <th>Thur</th>
                                                <th>Fri</th>
                                                <th>Sat</th>
                                                <th>Sun</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr id="scheduledaysx" style="background:whitesmoke;">
                                                <td data-label="Mon">&nbsp;<input type="checkbox" onChange="if (this.checked) {
                                                            checkedDateMon('checked', this.id);
                                                        } else {
                                                            checkedDateMon('unchecked', this.id);
                                                        }"id="Monday"/></td>
                                                <td data-label="Tue">&nbsp;<input type="checkbox" onChange="if (this.checked) {
                                                            checkedDateTue('checked', this.id);
                                                        } else {
                                                            checkedDateTue('unchecked', this.id);
                                                        }" id="Tuesday"/></td>
                                                <td data-label="Wed">&nbsp;<input type="checkbox"onChange="if (this.checked) {
                                                            checkedDateWed('checked', this.id);
                                                        } else {
                                                            checkedDateWed('unchecked', this.id);
                                                        }" id="Wednesday"/></td>
                                                <td data-label="Thur">&nbsp;<input type="checkbox"onChange="if (this.checked) {
                                                            checkedDateThur('checked', this.id);
                                                        } else {
                                                            checkedDateThur('unchecked', this.id);
                                                        }" id="Thursday"/></td>
                                                <td data-label="Fri">&nbsp;<input type="checkbox"onChange="if (this.checked) {
                                                            checkedDateFri('checked', this.id);
                                                        } else {
                                                            checkedDateFri('unchecked', this.id);
                                                        }" id="Friday"/></td>
                                                <td data-label="Sat">&nbsp;<input type="checkbox" onChange="if (this.checked) {
                                                            checkedDateSat('checked', this.id);
                                                        } else {
                                                            checkedDateSat('unchecked', this.id);
                                                        }"id="Saturday"/></td>
                                                <td data-label="Sun">&nbsp;<input type="checkbox"onChange="if (this.checked) {
                                                            checkedDateSun('checked', this.id);
                                                        } else {
                                                            checkedDateSun('unchecked', this.id);
                                                        }"id="Sunday"/></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>                                
                            </td> 
                        </tr>
                        <tr>
                            <td><b>Schedule Status</b></td>
                            <td>
                                <select class="form-control" id="schedulestate">
                                    <option value="ON">ON</option>
                                    <option value="Paused">Paused</option>
                                </select>
                            </td> 
                        </tr>
                    </tbody>
                </table>
            </fieldset>
        </div>
        <div class="col-md-7"> 
            <fieldset>
                <legend align="center"><strong id="detailsdesign" >Schedule Day Sessions</strong></legend>
                <div class="tile">
                    <div class="tile-body" id="changetableview">
                        <table class="table table-hover table-bordered" id="storetype">
                            <thead>
                                <tr>
                                    <th class="center">Monday</th>
                                    <th class="center">Tuesday</th>
                                    <th class="center">Wednesday</th>
                                    <th class="center">Thursday</th>
                                    <th class="center">Friday</th>
                                    <th class="center">Saturday</th>
                                    <th class="center">Sunday</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td data-label="Monday" id="Monshow">
                                        <div id="SetMonAddbtn" class="center"></div>
                                        <div id="userMonSetTime"></div>
                                    </td>
                                    <td data-label="Tuesday" id="Tueshow">
                                        <div id="SetTueAddbtn" class="center"></div>
                                        <div id="userTueSetTime"></div>
                                    </td>
                                    <td data-label="Wednesday" id="Wedshow">
                                        <div id="SetWedAddbtn" class="center"></div>
                                        <div id="userWedSetTime"></div>
                                    </td>
                                    <td data-label="Thursday" id="Thurshow">
                                        <div id="SetThurAddbtn" class="center"></div>
                                        <div id="userThurSetTime"></div>
                                    </td>
                                    <td data-label="Friday" id="Frishow">
                                        <div id="SetFriAddbtn" class="center"></div>
                                        <div id="userFriSetTime"></div>
                                    </td>
                                    <td data-label="Saturday"id="Satshow">
                                        <div id="SetSatAddbtn" class="center"></div>
                                        <div id="userSatSetTime"></div>
                                    </td>
                                    <td data-label="Sunday" id="Sunshow">                                        
                                        <div id="SetSunAddbtn" class="center"></div>
                                        <div id="userSunSetTime"></div>
                                    </td>
                                </tr>                  
                            </tbody>
                        </table>

                        <div class="hidedisplaycontent" id="setSessionDay">   
                            <fieldset>
                                <span id="dayx"></span>
                                <p id="errorReport"></p>
                                <legend align="center"><strong id="detailsdesign" > <span id="selectedsessionDay"></span></strong></legend>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="date" class="col-sm-6 control-label">Start Time:</label>
                                        <input class=" form-control col-sm-6 timesent" type="text" value="" id="starttimepicker" name="date">
                                    </div> 
                                    <div class="col-md-6">
                                        <label for="date" class="col-sm-6 control-label">End Time:</label>
                                        <input class="form-control col-sm-6 timesent" value="" type="text" id="endtimepicker" name="date">
                                    </div>    
                                </div> <hr>
                                <div class="row" align="center">                                    
                                    <button class="btn btn-primary col-md-2" id="addsession"> Add Session</button>&nbsp;
                                    <button class="btn btn-secondary col-md-2" id="closeSetSessionDay">close</button> 
                                </div>
                            </fieldset>                       
                        </div>

                    </div>
                </div>
            </fieldset>
        </div>
    </div><hr>
    <div align="center" id="saveSchedule" class="hidedisplaycontent">
        <button class="btn btn-primary col-md-2 " id="saveSchedulebtn">Save Schedule</button>&nbsp;
        <button class="btn btn-secondary col-md-2" id="closeDialogschedule">cancel</button> 
    </div>

</div>
<script>
    var serverDate = '${serverdate}';
    var checkedweekdays = new Set();
    var checkedweekdaySessions = [];
    var SundayCollisionList = [];
    var MondayCollisionList = [];
    var TuesdayCollisionList = [];
    var WednesdayCollisionList =[];
    var ThursdayCollisionList =[];
    var FridayCollisionList = [];
    var SaturdayCollisionList = [];
    $(document).ready(function () {
        $('#starttimepicker').mdtimepicker({
            timeFormat: 'hh:mm:ss',
            format: 'h:mm tt',
            theme: 'purple',
            readOnly: true,
            hourPadding: false
        });
        $('#starttimepicker').mdtimepicker().on('timechanged', function (e) {
            var time24Hrs = e.time;
            var time12Hrs = e.value;
            // console.log(time12Hrs);
            //console.log(time24Hrs);

            var k = new Array();
            k = time24Hrs.split(':');
            var hours = k[0];
            var minutes = k[1];
            var seconds = k[2];
            var d1 = new Date(serverDate);
            d1.setHours(parseInt(hours));
            d1.setMinutes(parseInt(minutes) + 240);
            d1.setSeconds(parseInt(seconds));
            var hrs = d1.getHours();
            hrs = parseInt(hrs, 10);
            var hrs12 = hrs > 12 ? hrs - 12 : hrs;
            var hrsstate = hrs12 > 6 ? 'AM' : 'PM';
            var timest = '';
            if (d1.getMinutes() < 10) {
                timest = hrs12 + ":0" + d1.getMinutes() + " " + hrsstate;
                //console.log('-----------12 hr----------------' + hrs12 + ":0" + d1.getMinutes() + " " + hrsstate);
            } else {
                timest = hrs12 + ":" + d1.getMinutes() + " " + hrsstate;
                // console.log('-----------12 hr----------------' + hrs12 + ":" + d1.getMinutes() + " " + hrsstate);
            }
            $('#endtimepicker').val(timest);
        });
        $('#endtimepicker').mdtimepicker({
            timeFormat: 'hh:mm:ss.000',
            format: 'h:mm tt',
            theme: 'purple',
            readOnly: true,
            hourPadding: false
        });

        /*--------Works on Start Date and End Date Begins------------*/
        $('#startDate').datetimepicker({
            pickTime: false,
            format: "DD/MM/YYYY",
            minDate: new Date(serverDate)
                    // defaultDate: new Date()
        });

        var startdate = $('#startDate').val();
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

        $('#endDate').click(function () {
            var checkstartdate = $('#startDate').val();
            if (checkstartdate === '') {
                $('#errorshowstart').html('<span style="color:red;">* Error Start Date Required</span>');
                $('#startDate').css('border-color', 'red');
                $("#endDate").prop('disabled', true);
            } else {
                $('#errorshowstart').html('');
                $('#startDate').css('border-color', '');
                $('#endDate').datetimepicker({
                    pickTime: false,
                    format: "DD/MM/YYYY",
                    minDate: someFormattedDate
                });
            }
        });
        $('#startDate').on('change', function () {
            clearSection();
            $('#endDate').val('');
            $('#endDate').css('border-color', '');
            $('#errorshow').html('');
            $("#endDate").prop('disabled', false);
            $('#disablethisScheduleTable input[type=checkbox]').prop("disabled", true);
        });

        $('#endDate').on('change', function () {
            var endx = $(this).val().split("/");
            var startx = $('#startDate').val().split("/");
            var datestart = new Date(startx[2], startx[1] - 1, startx[0]);
            var dateEnd = new Date(endx[2], endx[1] - 1, endx[0]);
            if (datestart.getTime() > dateEnd.getTime()) {
                //console.log(datestart.getTime() + ' greater than ' + dateEnd.getTime());
                $('#errorshow').html('<span style="color:red;">* Error End Date must be greater or Equal to Start Date</span>');
                $(this).css('border-color', 'red');
                $('#disablethisScheduleTable input[type=checkbox]').prop("disabled", true);
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
                for (var v in uniqueselectedrangedays) {
                    var dataSelectNumber = uniqueselectedrangedays[v];
                    // console.log(dataSelectNumber);
                    if (parseInt(dataSelectNumber) === parseInt(0)) {
                        $('#Sunday').prop('checked', true);
                        if (document.getElementById('Sunday').checked) {
                            checkedDateSun("checked", "Sunday");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(1)) {
                        $('#Monday').prop('checked', true);
                        if (document.getElementById('Monday').checked) {
                            checkedDateMon("checked", "Monday");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(2)) {
                        $('#Tuesday').prop('checked', true);
                        if (document.getElementById('Tuesday').checked) {
                            checkedDateTue("checked", "Tuesday");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(3)) {
                        $('#Wednesday').prop('checked', true);
                        if (document.getElementById('Wednesday').checked) {
                            checkedDateWed("checked", "Wednesday");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(4)) {
                        $('#Thursday').prop('checked', true);
                        if (document.getElementById('Thursday').checked) {
                            checkedDateThur("checked", "Thursday");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(5)) {
                        $('#Friday').prop('checked', true);
                        if (document.getElementById('Friday').checked) {
                            checkedDateFri("checked", "Friday");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(6)) {
                        $('#Saturday').prop('checked', true);
                        if (document.getElementById('Saturday').checked) {
                            checkedDateSat("checked", "Saturday");
                        }
                    }
                }

                $(this).css('border-color', '');
                $('#errorshow').html('');
                $('#disablethisScheduleTable input[type=checkbox]').prop("disabled", false);
            } else {
                $('#errorshow').html('');
                $('#disablethisScheduleTable input[type=checkbox]').prop("disabled", false);
            }
        });
        $('#disablethisScheduleTable input[type=checkbox]').prop("disabled", true);
        /*--------Works on Start Date and End Date Ends------------*/



        //saves the entire content--------------------Starts--------------------/
        $('#saveSchedulebtn').click(function () {
            var startdate = $('#startDate').val();
            var enddate = $('#endDate').val();
            var schedulestat = $('#schedulestate').val();
            var staffid = $('#staffidx').html();
            
            var combinedata = [];
            combinedata.push({
                staffid: staffid,
                schedulestat: schedulestat,
                startdate: startdate,
                enddate: enddate
            });
            $.ajax({
                type: 'GET',
                cache: false,
                dataType: 'text',
                data: {weekdaySession: JSON.stringify(checkedweekdaySessions), weeks: JSON.stringify(Array.from(checkedweekdays)), data: JSON.stringify(combinedata)},
                url: "appointmentandSchedules/createStaffSchedule.htm",
                success: function (data) {
                    //console.log(data);
                    if (data === 'success') {
                        $.toast({
                            heading: 'Success',
                            text: 'Schedule created Successfully',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        ajaxSubmitData('appointmentandSchedules/activeuserschedules.htm', 'activeContentdisplay', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        combinedata = [];
                        checkedweekdays.clear();
                        checkedweekdaySessions = [];                        

                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'An unexpected error occured while trying to Create Schedule',
                            icon: 'error',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        combinedata = [];
                        checkedweekdays.clear();
                        checkedweekdaySessions = [];
                    }
                    clearcollisions();
                    window.location = '#close';
                }
            });
            //
        });
        $('#closeDialogschedule').click(function () {
            window.location = '#close';
            clearcollisions();
        });
        //saves the entire content--------------------Stops--------------------/

        //adding session to days
        var x = 0;
        $('#addsession').click(function () {
            var selectday = $('#dayx').html();
            var starttime = $('#starttimepicker').val();
            var endtime = $('#endtimepicker').val();
            if (selectday === 'Mon') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (SundayCollisionList.length !== 0) {
                        var previousSundaytime = SundayCollisionList[SundayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the ' + SundayCollisionList[SundayCollisionList.length - 1].weekday + '!!!</strong>');
                            starx = false;
                        }
                    } else if (SundayCollisionList.length === 0) {
                        starx = true;
                    }
                    if (starx === true) {
                        //remove Collision from a given day
                        if (MondayCollisionList.length !== 0) {
                            var previousSessiontime2a = MondayCollisionList[MondayCollisionList.length - 1].sessiontimeSet;
                            var startdaysession2a = previousSessiontime2a.split('-')[0];
                            var enddaysession2a = previousSessiontime2a.split('-')[1];
                            var checkdaysession2a = starttime;
                            var checkresults2a = getTimeRangeFinal(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (MondayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#errorReport').html('');
                            $('#userMonSetTime').append('<p id="saveMonSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveMonSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetMonSess(this.id)"></i></p>');
                            $('#starttimepicker').val('');
                            $('#endtimepicker').val('');
                            $('#starttimepicker').css('border-color', '');
                            $('#endtimepicker').css('border-color', '');
                            $('#saveSchedule').show();
                            var sessiontimeSet = starttime + '-' + endtime;
                            var sessiontimeSetid = 'saveMonSess' + x;
                            var weekday = 'Monday';
                            MondayCollisionList.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                        }
                    }

                } else if (starttime !== '' && endtime === '') {
                    $('#starttimepicker').css('border-color', '');
                    $('#endtimepicker').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker').css('border-color', '');
                    $('#starttimepicker').css('border-color', 'red');
                } else {
                    $('#starttimepicker').css('border-color', 'red');
                    $('#endtimepicker').css('border-color', 'red');
                }
            } else if (selectday === 'Tue') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (MondayCollisionList.length !== 0) {
                        var previousSundaytime = MondayCollisionList[MondayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            starx = false;
                            $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the ' + MondayCollisionList[MondayCollisionList.length - 1].weekday + '!!!</strong>');
                        }

                    } else if (MondayCollisionList.length === 0) {
                        starx = true;
                    }
                    if (starx === true) {
                        //remove Collision from a given day
                        if (TuesdayCollisionList.length !== 0) {
                            var previousSessiontime2a = TuesdayCollisionList[TuesdayCollisionList.length - 1].sessiontimeSet;
                            var startdaysession2a = previousSessiontime2a.split('-')[0];
                            var enddaysession2a = previousSessiontime2a.split('-')[1];
                            var checkdaysession2a = starttime;
                            var checkresults2a = getTimeRangeFinal(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (TuesdayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#errorReport').html('');
                            $('#userTueSetTime').append('<p id="saveTueSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveTueSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetTueSess(this.id)"></i></p>');
                            $('#starttimepicker').val('');
                            $('#endtimepicker').val('');
                            $('#starttimepicker').css('border-color', '');
                            $('#endtimepicker').css('border-color', '');
                            $('#saveSchedule').show();
                            var sessiontimeSet = starttime + '-' + endtime;
                            var sessiontimeSetid = 'saveTueSess' + x;
                            var weekday = 'Tuesday';
                            TuesdayCollisionList.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                        }
                    }
                } else if (starttime !== '' && endtime === '') {
                    $('#starttimepicker').css('border-color', '');
                    $('#endtimepicker').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker').css('border-color', '');
                    $('#starttimepicker').css('border-color', 'red');
                } else {
                    $('#starttimepicker').css('border-color', 'red');
                    $('#endtimepicker').css('border-color', 'red');
                }
            } else if (selectday === 'Wed') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (TuesdayCollisionList.length !== 0) {
                        var previousSundaytime = TuesdayCollisionList[TuesdayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the ' + TuesdayCollisionList[TuesdayCollisionList.length - 1].weekday + '!!!</strong>');
                            starx = false;
                        }
                    } else if (TuesdayCollisionList.length === 0) {
                        starx = true;
                    }
                    if (starx === true) {
                        //remove Collision from a given day
                        if (WednesdayCollisionList.length !== 0) {
                            var previousSessiontime2a = WednesdayCollisionList[WednesdayCollisionList.length - 1].sessiontimeSet;
                            var startdaysession2a = previousSessiontime2a.split('-')[0];
                            var enddaysession2a = previousSessiontime2a.split('-')[1];
                            var checkdaysession2a = starttime;
                            var checkresults2a = getTimeRangeFinal(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (WednesdayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#errorReport').html('');
                            $('#userWedSetTime').append('<p id="saveWedSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveWedSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetWedSess(this.id)"></i></p>');
                            $('#starttimepicker').val('');
                            $('#endtimepicker').val('');
                            $('#starttimepicker').css('border-color', '');
                            $('#endtimepicker').css('border-color', '');
                            $('#saveSchedule').show();
                            var sessiontimeSet = starttime + '-' + endtime;
                            var sessiontimeSetid = 'saveWedSess' + x;
                            var weekday = 'Wednesday';
                            WednesdayCollisionList.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                        }
                    }

                } else if (starttime !== '' && endtime === '') {
                    $('#starttimepicker').css('border-color', '');
                    $('#endtimepicker').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker').css('border-color', '');
                    $('#starttimepicker').css('border-color', 'red');
                } else {
                    $('#starttimepicker').css('border-color', 'red');
                    $('#endtimepicker').css('border-color', 'red');
                }
            } else if (selectday === 'Thur') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (WednesdayCollisionList.length !== 0) {
                        var previousSundaytime = WednesdayCollisionList[WednesdayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the ' + WednesdayCollisionList[WednesdayCollisionList.length - 1].weekday + '!!!</strong>');
                            starx = false;
                        }
                    } else if (WednesdayCollisionList.length === 0) {
                        starx = true;
                    }
                    if (starx === true) {
                        //remove Collision from a given day
                        if (ThursdayCollisionList.length !== 0) {
                            var previousSessiontime2a = ThursdayCollisionList[ThursdayCollisionList.length - 1].sessiontimeSet;
                            var startdaysession2a = previousSessiontime2a.split('-')[0];
                            var enddaysession2a = previousSessiontime2a.split('-')[1];
                            var checkdaysession2a = starttime;
                            var checkresults2a = getTimeRangeFinal(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (ThursdayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#errorReport').html('');
                            $('#userThurSetTime').append('<p id="saveThurSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveThurSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetThurSess(this.id)"></i></p>');
                            $('#starttimepicker').val('');
                            $('#endtimepicker').val('');
                            $('#starttimepicker').css('border-color', '');
                            $('#endtimepicker').css('border-color', '');
                            $('#saveSchedule').show();
                            var sessiontimeSet = starttime + '-' + endtime;
                            var sessiontimeSetid = 'saveThurSess' + x;
                            var weekday = 'Thursday';
                            ThursdayCollisionList.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                        }
                    }
                } else if (starttime !== '' && endtime === '') {
                    $('#starttimepicker').css('border-color', '');
                    $('#endtimepicker').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker').css('border-color', '');
                    $('#starttimepicker').css('border-color', 'red');
                } else {
                    $('#starttimepicker').css('border-color', 'red');
                    $('#endtimepicker').css('border-color', 'red');
                }
            } else if (selectday === 'Fri') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (ThursdayCollisionList.length !== 0) {
                        var previousSundaytime = ThursdayCollisionList[ThursdayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the ' + ThursdayCollisionList[ThursdayCollisionList.length - 1].weekday + '!!!</strong>');
                            starx = false;
                        }
                    } else if (ThursdayCollisionList.length === 0) {
                        starx = true;
                    }
                    if (starx === true) {
                        //remove Collision from a given day
                        if (FridayCollisionList.length !== 0) {
                            var previousSessiontime2a = FridayCollisionList[FridayCollisionList.length - 1].sessiontimeSet;
                            var startdaysession2a = previousSessiontime2a.split('-')[0];
                            var enddaysession2a = previousSessiontime2a.split('-')[1];
                            var checkdaysession2a = starttime;
                            var checkresults2a = getTimeRangeFinal(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (FridayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#errorReport').html('');
                            $('#userFriSetTime').append('<p id="saveFriSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveFriSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetFriSess(this.id)"></i></p>');
                            $('#starttimepicker').val('');
                            $('#endtimepicker').val('');
                            $('#starttimepicker').css('border-color', '');
                            $('#endtimepicker').css('border-color', '');
                            $('#saveSchedule').show();
                            var sessiontimeSet = starttime + '-' + endtime;
                            var sessiontimeSetid = 'saveFriSess' + x;
                            var weekday = 'Friday';
                            FridayCollisionList.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                        }
                    }
                } else if (starttime !== '' && endtime === '') {
                    $('#starttimepicker').css('border-color', '');
                    $('#endtimepicker').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker').css('border-color', '');
                    $('#starttimepicker').css('border-color', 'red');
                } else {
                    $('#starttimepicker').css('border-color', 'red');
                    $('#endtimepicker').css('border-color', 'red');
                }
            } else if (selectday === 'Sat') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (FridayCollisionList.length !== 0) {
                        var previousSundaytime = FridayCollisionList[FridayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the ' + FridayCollisionList[FridayCollisionList.length - 1].weekday + '!!!</strong>');
                            starx = false;
                        }
                    } else if (FridayCollisionList.length === 0) {
                        starx = true;
                    }
                    if (starx === true) {
                        //remove Collision from a given day
                        if (SaturdayCollisionList.length !== 0) {
                            var previousSessiontime2a = SaturdayCollisionList[SaturdayCollisionList.length - 1].sessiontimeSet;
                            var startdaysession2a = previousSessiontime2a.split('-')[0];
                            var enddaysession2a = previousSessiontime2a.split('-')[1];
                            var checkdaysession2a = starttime;
                            var checkresults2a = getTimeRangeFinal(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (SaturdayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#errorReport').html('');
                            $('#userSatSetTime').append('<p id="saveSatSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveSatSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetSatSess(this.id)"></i></p>');
                            $('#starttimepicker').val('');
                            $('#endtimepicker').val('');
                            $('#starttimepicker').css('border-color', '');
                            $('#endtimepicker').css('border-color', '');
                            $('#saveSchedule').show();
                            var sessiontimeSet = starttime + '-' + endtime;
                            var sessiontimeSetid = 'saveSatSess' + x;
                            var weekday = 'Saturday';
                            SaturdayCollisionList.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                        }
                    }
                } else if (starttime !== '' && endtime === '') {
                    $('#starttimepicker').css('border-color', '');
                    $('#endtimepicker').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker').css('border-color', '');
                    $('#starttimepicker').css('border-color', 'red');
                } else {
                    $('#starttimepicker').css('border-color', 'red');
                    $('#endtimepicker').css('border-color', 'red');
                }
            } else if (selectday === 'Sun') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (SaturdayCollisionList.length !== 0) {
                        var previousSundaytime = SaturdayCollisionList[SaturdayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the ' + SaturdayCollisionList[SaturdayCollisionList.length - 1].weekday + '!!!</strong>');
                            starx = false;
                        }
                    } else if (SaturdayCollisionList.length === 0) {
                        starx = true;
                    }
                    if (starx === true) {
                        //remove Collision from a given day
                        if (SundayCollisionList.length !== 0) {
                            var previousSessiontime2a = SundayCollisionList[SundayCollisionList.length - 1].sessiontimeSet;
                            var startdaysession2a = previousSessiontime2a.split('-')[0];
                            var enddaysession2a = previousSessiontime2a.split('-')[1];
                            var checkdaysession2a = starttime;
                            var checkresults2a = getTimeRangeFinal(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (SundayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#userSunSetTime').append('<p id="saveSunSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveSunSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetSunSess(this.id)"></i></p>');
                            $('#starttimepicker').val('');
                            $('#endtimepicker').val('');
                            $('#starttimepicker').css('border-color', '');
                            $('#endtimepicker').css('border-color', '');
                            $('#saveSchedule').show();
                            var sessiontimeSet = starttime + '-' + endtime;
                            var sessiontimeSetid = 'saveSunSess' + x;
                            var weekday = 'Sunday';
                            SundayCollisionList.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid
                            });
                        }
                    }
                } else if (starttime !== '' && endtime === '') {
                    $('#starttimepicker').css('border-color', '');
                    $('#endtimepicker').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker').css('border-color', '');
                    $('#starttimepicker').css('border-color', 'red');
                } else {
                    $('#starttimepicker').css('border-color', 'red');
                    $('#endtimepicker').css('border-color', 'red');
                }
            }
        });
    });
    $('#closeSetSessionDay').click(function () {
        $('#starttimepicker').val('');
        $('#endtimepicker').val('');
        $('#setSessionDay').hide();
    });
    var checkedweekdaySessionsFinal = [];
    var MondayCollisionListSessionsFinal = [];
    //-------------Monday- Starts------//
    function removeSetMonSess(id) {
        $('#' + id).remove();
        for (index in checkedweekdaySessions) {
            var res = checkedweekdaySessions[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                checkedweekdaySessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        checkedweekdaySessions = [];
        for (index1 in checkedweekdaySessionsFinal) {
            var res1 = checkedweekdaySessionsFinal[index1];
            checkedweekdaySessions.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        checkedweekdaySessionsFinal = [];
        if (parseInt(checkedweekdaySessions.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
        // remove items from MondayCollisionList
        for (index in MondayCollisionList) {
            var res = MondayCollisionList[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                MondayCollisionListSessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        MondayCollisionList = [];
        for (index1 in MondayCollisionListSessionsFinal) {
            var res1 = MondayCollisionListSessionsFinal[index1];
            MondayCollisionList.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        MondayCollisionListSessionsFinal = [];
        if (parseInt(MondayCollisionList.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
    }

    function checkedDateMon(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Monday' && status === 'checked') {
                $("#SetMonAddbtn").html('<button class="btn btn-secondary" onclick="addMondaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDate").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetMonAddbtn").html('');
                $('#userMonSetTime').html('');
                $('#setSessionDay').hide();
                checkedweekdays.delete(selectedday);
            }
        }
    }
    function addMondaySchedules() {
        $('#setSessionDay').show();
        $('#endtimepicker').val('');
        $('#starttimepicker').val('');
        $('#selectedsessionDay').html('<strong>Schedule Monday Sessions</strong>');
        $('#dayx').html('Mon');
    }
    //-------------Monday- Ends------//

    //-------------Tuesday--Starts------//
    var TuesdayCollisionListSessionsFinal = [];
    function removeSetTueSess(id) {
        $('#' + id).remove();
        for (index in checkedweekdaySessions) {
            var res = checkedweekdaySessions[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                checkedweekdaySessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        checkedweekdaySessions = [];
        for (index1 in checkedweekdaySessionsFinal) {
            var res1 = checkedweekdaySessionsFinal[index1];
            checkedweekdaySessions.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        checkedweekdaySessionsFinal = [];
        if (parseInt(checkedweekdaySessions.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
        
        // remove items from TuesdayCollisionList
        for (index in TuesdayCollisionList) {
            var res = TuesdayCollisionList[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                TuesdayCollisionListSessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        TuesdayCollisionList = [];
        for (index1 in TuesdayCollisionListSessionsFinal) {
            var res1 = TuesdayCollisionListSessionsFinal[index1];
            TuesdayCollisionList.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        TuesdayCollisionListSessionsFinal = [];
        if (parseInt(TuesdayCollisionList.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
    }
    function checkedDateTue(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Tuesday' && status === 'checked') {
                $("#SetTueAddbtn").html('<button class="btn btn-secondary" onclick="addTuesdaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDate").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetTueAddbtn").html('');
                $('#userTueSetTime').html('');
                $('#setSessionDay').hide();
                checkedweekdays.delete(selectedday);
            }
        }
    }
    function addTuesdaySchedules() {
        $('#setSessionDay').show();
        $('#endtimepicker').val('');
        $('#starttimepicker').val('');
        $('#selectedsessionDay').html('<strong>Schedule Tuesday Sessions</strong>');
        $('#dayx').html('Tue');
    }
    //-------------Tuesday- Ends------//

    //-------------Wednesday--Starts------//
    var WednesdayCollisionListSessionsFinal = [];
    function removeSetWedSess(id) {
        $('#' + id).remove();
        for (index in checkedweekdaySessions) {
            var res = checkedweekdaySessions[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                checkedweekdaySessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        checkedweekdaySessions = [];
        for (index1 in checkedweekdaySessionsFinal) {
            var res1 = checkedweekdaySessionsFinal[index1];
            checkedweekdaySessions.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        checkedweekdaySessionsFinal = [];
        if (parseInt(checkedweekdaySessions.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
        // remove items from WednesdayCollisionList
        for (index in WednesdayCollisionList) {
            var res = WednesdayCollisionList[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                WednesdayCollisionListSessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        WednesdayCollisionList = [];
        for (index1 in WednesdayCollisionListSessionsFinal) {
            var res1 = WednesdayCollisionListSessionsFinal[index1];
            WednesdayCollisionList.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        WednesdayCollisionListSessionsFinal = [];
        if (parseInt(WednesdayCollisionList.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
    }
    function checkedDateWed(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Wednesday' && status === 'checked') {
                $("#SetWedAddbtn").html('<button class="btn btn-secondary" onclick="addWednesdaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDate").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetWedAddbtn").html('');
                $('#userWedSetTime').html('');
                $('#setSessionDay').hide();
                checkedweekdays.delete(selectedday);
            }
        }

    }
    function addWednesdaySchedules() {
        $('#setSessionDay').show();
        $('#endtimepicker').val('');
        $('#starttimepicker').val('');
        $('#selectedsessionDay').html('<strong>Schedule Wednesday Sessions</strong>');
        $('#dayx').html('Wed');
    }
    //-------------Wednesday- Ends------//

    //-------------Thursday--Starts------//
    var ThursdayCollisionListSessionsFinal = [];
    function removeSetThurSess(id) {
        $('#' + id).remove();
        for (index in checkedweekdaySessions) {
            var res = checkedweekdaySessions[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                checkedweekdaySessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        checkedweekdaySessions = [];
        for (index1 in checkedweekdaySessionsFinal) {
            var res1 = checkedweekdaySessionsFinal[index1];
            checkedweekdaySessions.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        checkedweekdaySessionsFinal = [];
        if (parseInt(checkedweekdaySessions.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
        // remove items from ThursdayCollisionList
        for (index in ThursdayCollisionList) {
            var res = ThursdayCollisionList[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                ThursdayCollisionListSessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        ThursdayCollisionList = [];
        for (index1 in ThursdayCollisionListSessionsFinal) {
            var res1 = ThursdayCollisionListSessionsFinal[index1];
            ThursdayCollisionList.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        ThursdayCollisionListSessionsFinal = [];
        if (parseInt(ThursdayCollisionList.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
    }
    function checkedDateThur(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Thursday' && status === 'checked') {
                $("#SetThurAddbtn").html('<button class="btn btn-secondary" onclick="addThursdaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDate").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetThurAddbtn").html('');
                $('#userThurSetTime').html('');
                $('#setSessionDay').hide();
                checkedweekdays.delete(selectedday);
            }
        }
    }
    function addThursdaySchedules() {
        $('#setSessionDay').show();
        $('#endtimepicker').val('');
        $('#starttimepicker').val('');
        $('#selectedsessionDay').html('<strong>Schedule Thursday Sessions</strong>');
        $('#dayx').html('Thur');
    }
    //-------------Thursday- Ends------//

    //-------------Friday--Starts------//
    var FridayCollisionListSessionsFinal = [];
    function removeSetFriSess(id) {
        $('#' + id).remove();
        for (index in checkedweekdaySessions) {
            var res = checkedweekdaySessions[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                checkedweekdaySessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        checkedweekdaySessions = [];
        for (index1 in checkedweekdaySessionsFinal) {
            var res1 = checkedweekdaySessionsFinal[index1];
            checkedweekdaySessions.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        checkedweekdaySessionsFinal = [];
        if (parseInt(checkedweekdaySessions.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
        // remove items from FridayCollisionList
        for (index in FridayCollisionList) {
            var res = FridayCollisionList[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                FridayCollisionListSessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        FridayCollisionList = [];
        for (index1 in FridayCollisionListSessionsFinal) {
            var res1 = FridayCollisionListSessionsFinal[index1];
            FridayCollisionList.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        FridayCollisionListSessionsFinal = [];
        if (parseInt(FridayCollisionList.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
    }
    function checkedDateFri(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Friday' && status === 'checked') {
                $("#SetFriAddbtn").html('<button class="btn btn-secondary" onclick="addFridaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDate").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetFriAddbtn").html('');
                $('#userFriSetTime').html('');
                $('#setSessionDay').hide();
                checkedweekdays.delete(selectedday);
            }
        }
    }
    function addFridaySchedules() {
        $('#setSessionDay').show();
        $('#endtimepicker').val('');
        $('#starttimepicker').val('');
        $('#selectedsessionDay').html('<strong>Schedule Friday Sessions</strong>');
        $('#dayx').html('Fri');
    }
    //-------------Friday- Ends------//

    //-------------Saturday--Starts------//
    var SaturdayCollisionListSessionsFinal = [];
    function removeSetSatSess(id) {
        $('#' + id).remove();
        for (index in checkedweekdaySessions) {
            var res = checkedweekdaySessions[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                checkedweekdaySessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        checkedweekdaySessions = [];
        for (index1 in checkedweekdaySessionsFinal) {
            var res1 = checkedweekdaySessionsFinal[index1];
            checkedweekdaySessions.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        checkedweekdaySessionsFinal = [];
        if (parseInt(checkedweekdaySessions.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
        // remove items from SaturdayCollisionList
        for (index in SaturdayCollisionList) {
            var res = SaturdayCollisionList[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                SaturdayCollisionListSessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        SaturdayCollisionList = [];
        for (index1 in SaturdayCollisionListSessionsFinal) {
            var res1 = SaturdayCollisionListSessionsFinal[index1];
            FridayCollisionList.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        SaturdayCollisionListSessionsFinal = [];
        if (parseInt(SaturdayCollisionList.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
    }
    function checkedDateSat(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Saturday' && status === 'checked') {
                $("#SetSatAddbtn").html('<button class="btn btn-secondary" onclick="addSaturdaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDate").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetSatAddbtn").html('');
                $('#userSatSetTime').html('');
                $('#setSessionDay').hide();
                checkedweekdays.delete(selectedday);
            }
        }
    }
    function addSaturdaySchedules() {
        $('#setSessionDay').show();
        $('#endtimepicker').val('');
        $('#starttimepicker').val('');
        $('#selectedsessionDay').html('<strong>Schedule Saturday Sessions</strong>');
        $('#dayx').html('Sat');
    }
    //-------------Saturday- Ends------//

    //-------------Sunday--Starts------//
    var SundayCollisionListSessionsFinal = [];
    function removeSetSunSess(id) {
        $('#' + id).remove();
        for (index in checkedweekdaySessions) {
            var res = checkedweekdaySessions[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                checkedweekdaySessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        checkedweekdaySessions = [];
        for (index1 in checkedweekdaySessionsFinal) {
            var res1 = checkedweekdaySessionsFinal[index1];
            checkedweekdaySessions.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        checkedweekdaySessionsFinal = [];
        if (parseInt(checkedweekdaySessions.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
        // remove items from SundayCollisionList
        for (index in SundayCollisionList) {
            var res = SundayCollisionList[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                SundayCollisionListSessionsFinal.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        SundayCollisionList = [];
        for (index1 in SundayCollisionListSessionsFinal) {
            var res1 = SundayCollisionListSessionsFinal[index1];
            SundayCollisionList.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        SundayCollisionListSessionsFinal = [];
        if (parseInt(SundayCollisionList.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
    }
    function checkedDateSun(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Sunday' && status === 'checked') {
                $("#SetSunAddbtn").html('<button class="btn btn-secondary" onclick="addSundaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDate").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetSunAddbtn").html('');
                $('#userSunSetTime').html('');
                $('#setSessionDay').hide();
                checkedweekdays.delete(selectedday);
            }
        }
    }
    function addSundaySchedules() {
        $('#setSessionDay').show();
        $('#endtimepicker').val('');
        $('#starttimepicker').val('');
        $('#selectedsessionDay').html('<strong>Schedule Sunday Sessions</strong>');
        $('#dayx').html('Sun');
    }
    //-------------Sunday- Ends------//
    function clearSection() {
        $('#Monday').prop('checked', false);
        $('#Tuesday').prop('checked', false);
        $('#Wednesday').prop('checked', false);
        $('#Thursday').prop('checked', false);
        $('#Friday').prop('checked', false);
        $('#Saturday').prop('checked', false);
        $('#Sunday').prop('checked', false);
        
        $("#SetMonAddbtn").html('');
        $('#userMonSetTime').html('');
        $("#SetTueAddbtn").html('');
        $('#userTueSetTime').html('');
        $("#SetWedAddbtn").html('');
        $('#userWedSetTime').html('');
        $("#SetThurAddbtn").html('');
        $('#userThurSetTime').html('');
        $("#SetFriAddbtn").html('');
        $('#userFriSetTime').html('');
        $("#SetSatAddbtn").html('');
        $('#userSatSetTime').html('');
        $("#SetSunAddbtn").html('');
        $('#userSunSetTime').html('');
    }
    function timeConvertor(time) {
        var PM = time.match('PM') ? true : false

        time = time.split(':')
        var min = time[1].split(' ')[0]

        if (PM) {
            var hour = 12 + parseInt(time[0], 10)
            var sec = time[1].split(' ')[1].replace('PM', '00')
        } else {
            var hour = time[0]
            var sec = time[1].split(' ')[1].replace('AM', '00')
        }
        return hour + ':' + min + ':' + sec;
    }
    function  getTimeRangeFinal(prev, current) {
        var prevtv = timeConvertor(prev);
        var checktv = timeConvertor(current);
        var msecondsprev = parseInt((parseInt(prevtv.split(":")[0]) * 60 * 60) + (parseInt(prevtv.split(":")[1]) * 60)) * 1000;
        var msecondscurr = parseInt((parseInt(checktv.split(":")[0]) * 60 * 60) + (parseInt(checktv.split(":")[1]) * 60)) * 1000;
        var timeIsBetweenTest = (msecondsprev >= msecondscurr) ? true : false;
        return timeIsBetweenTest;
    }
    function getTimeRange(startingtym, endingtym, checkingtym) {
        var Time = function (timeString) {
            var t = timeString.split(":");
            this.hour = parseInt(t[0]);
            this.minutes = parseInt(t[1]);
            this.isBiggerThan = function (other) {
                return (this.hour >= other.hour) || (this.hour === other.hour) && (this.minutes > other.minutes);
            };
        }

        var timeIsBetween = function (start, end, check) {
            return (start.hour <= end.hour) ? check.isBiggerThan(start) && !check.isBiggerThan(end)
                    : (check.isBiggerThan(start) && check.isBiggerThan(end)) || (!check.isBiggerThan(start) && !check.isBiggerThan(end));
        }
        var startv = timeConvertor(startingtym);
        var endtv = timeConvertor(endingtym);
        var checktv = timeConvertor(checkingtym);

        var openTime = new Time(startv);
        var closeTime = new Time(endtv);
        var checkTime = new Time(checktv);

        var isBetween = timeIsBetween(openTime, closeTime, checkTime);
        return isBetween;
    }
    function clearcollisions(){        
        SundayCollisionList = [];
        MondayCollisionList = [];
        TuesdayCollisionList = [];
        WednesdayCollisionList = [];
        ThursdayCollisionList = [];
        FridayCollisionList = [];
        SaturdayCollisionList = [];
    }
</script>