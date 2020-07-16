<%-- 
    Document   : otherstaffschedule
    Created on : May 22, 2018, 2:31:52 PM
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
                        <td>:${staffothermemberx.scheduletype}</td> 
                    </tr>
                    <tr>
                        <td><b>Facility Unit</b></td>
                        <td>:${staffothermemberx.facilityunitname} - <strong>[${staffothermemberx.facilityunitshortname}]</strong> </td> 
                    </tr>
                    <tr>
                        <td><b>Staff</b><span id="errorstaffname2"></span></td>
                        <td><select class="form-control" id="staffidx2">
                                <option value="0">------ Select Staff --------</option>
                                <c:forEach items="${stafffacilityListing}" var="k">                                                                  
                                    <option value="${k.staffid}">${k.StaffName}</option>
                                </c:forEach>     
                            </select>                       
                        </td>  
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
                            <td><span  id="errorshowstart2"></span>
                                <input class="form-control" id="startDatex" type="text" placeholder="Start Date">
                            </td> 
                        </tr>                    
                        <tr>
                            <td><b>End Date</b></td>
                            <td><span  id="errorshow2"></span>
                                <input class="form-control" id="endDatex" type="text" placeholder="End Date">
                            </td> 
                        </tr>
                        <tr>
                            <td><b>Schedule Days</b></td>
                            <td id ="disablethisScheduleTable2">
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
                                            <tr id="scheduledaysx2" style="background:whitesmoke;">
                                                <td data-label="Mon">&nbsp;<input type="checkbox" onChange="if (this.checked) {
                                                            checkedDateMon2('checked', $(this).attr('data-id'), this.id);
                                                        } else {
                                                            checkedDateMon2('unchecked', $(this).attr('data-id'), this.id);
                                                        }"id="Monday2" data-id="Monday"/>
                                                </td>
                                                <td data-label="Tue">&nbsp;<input type="checkbox" onChange="if (this.checked) {
                                                            checkedDateTue2('checked', $(this).attr('data-id'), this.id);
                                                        } else {
                                                            checkedDateTue2('unchecked', $(this).attr('data-id'), this.id);
                                                        }" id="Tuesday2" data-id="Tuesday"/>
                                                </td>
                                                <td data-label="Wed">&nbsp;<input type="checkbox"onChange="if (this.checked) {
                                                            checkedDateWed2('checked', $(this).attr('data-id'), this.id);
                                                        } else {
                                                            checkedDateWed2('unchecked', $(this).attr('data-id'), this.id);
                                                        }" id="Wednesday2" data-id="Wednesday"/>
                                                </td>
                                                <td data-label="Thur">&nbsp;<input type="checkbox"onChange="if (this.checked) {
                                                            checkedDateThur2('checked', $(this).attr('data-id'), this.id);
                                                        } else {
                                                            checkedDateThur2('unchecked', $(this).attr('data-id'), this.id);
                                                        }" id="Thursday2" data-id="Thursday"/>
                                                </td>
                                                <td data-label="Fri">&nbsp;<input type="checkbox"onChange="if (this.checked) {
                                                            checkedDateFri2('checked', $(this).attr('data-id'), this.id);
                                                        } else {
                                                            checkedDateFri2('unchecked', $(this).attr('data-id'), this.id);
                                                        }" id="Friday2" data-id="Friday"/>
                                                </td>
                                                <td data-label="Sat">&nbsp;<input type="checkbox" onChange="if (this.checked) {
                                                            checkedDateSat2('checked', $(this).attr('data-id'), this.id);
                                                        } else {
                                                            checkedDateSat2('unchecked', $(this).attr('data-id'), this.id);
                                                        }"id="Saturday2" data-id="Saturday"/>
                                                </td>
                                                <td data-label="Sun">&nbsp;<input type="checkbox"onChange="if (this.checked) {
                                                            checkedDateSun2('checked', $(this).attr('data-id'), this.id);
                                                        } else {
                                                            checkedDateSun2('unchecked', $(this).attr('data-id'), this.id);
                                                        }"id="Sunday2" data-id="Sunday"/>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>                                
                            </td> 
                        </tr>
                        <tr>
                            <td><b>Schedule Status</b></td>
                            <td>
                                <select class="form-control" id="schedulestate2">
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
                                        <div id="SetMonAddbtn2" class="center"></div>
                                        <div id="userMonSetTime2"></div>
                                    </td>
                                    <td data-label="Tuesday" id="Tueshow">
                                        <div id="SetTueAddbtn2" class="center"></div>
                                        <div id="userTueSetTime2"></div>
                                    </td>
                                    <td data-label="Wednesday" id="Wedshow">
                                        <div id="SetWedAddbtn2" class="center"></div>
                                        <div id="userWedSetTime2"></div>
                                    </td>
                                    <td data-label="Thursday" id="Thurshow">
                                        <div id="SetThurAddbtn2" class="center"></div>
                                        <div id="userThurSetTime2"></div>
                                    </td>
                                    <td data-label="Friday" id="Frishow">
                                        <div id="SetFriAddbtn2" class="center"></div>
                                        <div id="userFriSetTime2"></div>
                                    </td>
                                    <td data-label="Saturday"id="Satshow">
                                        <div id="SetSatAddbtn2" class="center"></div>
                                        <div id="userSatSetTime2"></div>
                                    </td>
                                    <td data-label="Sunday" id="Sunshow">
                                        <div id="SetSunAddbtn2" class="center"></div>
                                        <div id="userSunSetTime2"></div>
                                    </td>
                                </tr>                  
                            </tbody>
                        </table>

                        <div class="hidedisplaycontent" id="setSessionDay2">   
                            <fieldset>
                                <span id="dayx2"></span>
                                <p id="errorReport2"></p>
                                <legend align="center"><strong id="detailsdesign" > <span id="selectedsessionDay2"></span></strong></legend>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="date" class="col-sm-6 control-label">Start Time:</label>
                                        <input class=" form-control col-sm-6 timesent" type="text" value="" id="starttimepicker2" name="date">
                                    </div> 
                                    <div class="col-md-6">
                                        <label for="date" class="col-sm-6 control-label">End Time:</label>
                                        <input class="form-control col-sm-6 timesent" value="" type="text" id="endtimepicker2" name="date">
                                    </div>    
                                </div> <hr>
                                <div class="row" align="center">                                    
                                    <button class="btn btn-primary col-md-2" id="addsession2"> Add Session</button>&nbsp;
                                    <button class="btn btn-secondary col-md-2" id="closeSetSessionDay2">close</button> 
                                </div>
                            </fieldset>                       
                        </div>

                    </div>
                </div>
            </fieldset>
        </div>
    </div><hr>
    <div align="center" id="saveSchedule2" class="hidedisplaycontent">
        <button class="btn btn-primary col-md-2 " id="saveSchedulebtn2">Save Schedule</button>&nbsp;
        <button class="btn btn-secondary col-md-2" id="closeDialogschedule2">cancel</button> 
    </div>

</div>
<script>
    var serverDate = '${serverdate}';
    var checkedweekdays = new Set();
    var checkedweekdaySessions = [];
    var SundayCollisionList = [];
    var MondayCollisionList = [];
    var TuesdayCollisionList = [];
    var WednesdayCollisionList = [];
    var ThursdayCollisionList = [];
    var FridayCollisionList = [];
    var SaturdayCollisionList = [];
    $(document).ready(function () {
        $('#starttimepicker2').mdtimepicker({
            timeFormat: 'hh:mm:ss',
            format: 'h:mm tt',
            theme: 'purple',
            readOnly: true,
            hourPadding: false
        });
        $('#starttimepicker2').mdtimepicker().on('timechanged', function (e) {
            var time24Hrs = e.time;
            var time12Hrs = e.value;
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
            $('#endtimepicker2').val(timest);
        });
        $('#endtimepicker2').mdtimepicker({
            timeFormat: 'hh:mm:ss.000',
            format: 'h:mm tt',
            theme: 'purple',
            readOnly: true,
            hourPadding: false
        });

        /*--------Works on Start Date and End Date Begins------------*/
        $('#startDatex').datetimepicker({
            pickTime: false,
            format: "DD/MM/YYYY",
            minDate: new Date(serverDate)
                    // defaultDate: new Date()
        });

        var startdate = $('#startDatex').val();
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

        $('#endDatex').click(function () {
            var checkstartdate = $('#startDatex').val();
            if (checkstartdate === '') {
                $('#errorshowstart2').html('<span style="color:red;">* Error Start Date Required</span>');
                $('#startDatex').css('border-color', 'red');
                $("#endDatex").prop('disabled', true);
            } else {
                $('#errorshowstart2').html('');
                $('#startDatex').css('border-color', '');
                $('#endDatex').datetimepicker({
                    pickTime: false,
                    format: "DD/MM/YYYY",
                    minDate: someFormattedDate
                });
            }
        });
        $('#startDatex').on('change', function () {
            clearSection();
            $('#endDatex').val('');
            $('#endDatex').css('border-color', '');
            $('#errorshow2').html('');
            $("#endDatex").prop('disabled', false);
            $('#disablethisScheduleTable2 input[type=checkbox]').prop("disabled", true);
        });

        $('#endDatex').on('change', function () {
            var endx = $(this).val().split("/");
            var startx = $('#startDatex').val().split("/");
            var datestart = new Date(startx[2], startx[1] - 1, startx[0]);
            var dateEnd = new Date(endx[2], endx[1] - 1, endx[0]);
            if (datestart.getTime() > dateEnd.getTime()) {
                //console.log(datestart.getTime() + ' greater than ' + dateEnd.getTime());
                $('#errorshow2').html('<span style="color:red;">* Error End Date must be greater or Equal to Start Date</span>');
                $(this).css('border-color', 'red');
                $('#disablethisScheduleTable2 input[type=checkbox]').prop("disabled", true);
            } else if (datestart.getTime() <= dateEnd.getTime()) {
                //console.log(datestart.getTime() + ' less than ' + dateEnd.getTime());
                var start = datestart,
                        end = dateEnd,
                        currentDate = new Date(start),
                        between = [];
                while (currentDate <= end) {
                    between.push(new Date(currentDate).getDay());
                    currentDate.setDate(currentDate.getDate() + 1);
                }
                var selectedrangedays = between;
                //  console.log(selectedrangedays);
                var uniqueselectedrangedays = [];
                $.each(selectedrangedays, function (i, item) {
                    if ($.inArray(item, uniqueselectedrangedays) === -1)
                        uniqueselectedrangedays.push(item);

                });
                //console.log(uniqueselectedrangedays);
                for (var v in uniqueselectedrangedays) {
                    var dataSelectNumber = uniqueselectedrangedays[v];
                    //console.log(dataSelectNumber);
                    if (parseInt(dataSelectNumber) === parseInt(0)) {
                        $('#Sunday2').prop('checked', true);
                        if (document.getElementById('Sunday2').checked) {
                            checkedDateSun2("checked", "Sunday", "Sunday2");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(1)) {
                        $('#Monday2').prop('checked', true);
                        if (document.getElementById('Monday2').checked) {
                            checkedDateMon2("checked", "Monday", "Monday2");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(2)) {
                        $('#Tuesday2').prop('checked', true);
                        if (document.getElementById('Tuesday2').checked) {
                            checkedDateTue2("checked", "Tuesday", "Tuesday2");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(3)) {
                        $('#Wednesday2').prop('checked', true);
                        if (document.getElementById('Wednesday2').checked) {
                            checkedDateWed2("checked", "Wednesday", "Wednesday2");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(4)) {
                        $('#Thursday2').prop('checked', true);
                        if (document.getElementById('Thursday2').checked) {
                            checkedDateThur2("checked", "Thursday", "Thursday2");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(5)) {
                        $('#Friday2').prop('checked', true);
                        if (document.getElementById('Friday2').checked) {
                            checkedDateFri2("checked", "Friday", "Friday2");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(6)) {
                        $('#Saturday2').prop('checked', true);
                        if (document.getElementById('Saturday2').checked) {
                            checkedDateSat2("checked", "Saturday", "Saturday2");
                        }
                    }
                }
                $(this).css('border-color', '');
                $('#errorshow2').html('');
                $('#disablethisScheduleTable2 input[type=checkbox]').prop("disabled", false);
            } else {
                $('#errorshow2').html('');
                $('#disablethisScheduleTable2 input[type=checkbox]').prop("disabled", false);
            }
        });
        $('#disablethisScheduleTable2 input[type=checkbox]').prop("disabled", true);
        /*--------Works on Start Date and End Date Ends------------*/



        //saves the entire content--------------------Starts--------------------/
        $('#saveSchedulebtn2').click(function () {
            var startdate = $('#startDatex').val();
            var enddate = $('#endDatex').val();
            var schedulestat = $('#schedulestate2').val();
            var staffid = $('#staffidx2').val();
            if (parseInt(staffid) !== 0) {
                //console.log(schedulestat);
                // console.log(startdate);
                //console.log(enddate);
                var combinedata = [];
                combinedata.push({
                    staffid: parseInt(staffid),
                    schedulestat: schedulestat,
                    startdate: startdate,
                    enddate: enddate
                });
                //console.log(checkedweekdays);
                //console.log(checkedweekdaySessions);
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
                        window.location = '#close';
                        clearcollisions2();
                    }
                });
                $('#errorstaffname2').html('');
                $('#staffidx2').css('border-color', '');
            } else {
                $('#errorstaffname2').html('<span style="color:red;">* Error Staff Name Required</span>');
                $('#staffidx2').focus();
                $('#staffidx2').css('border-color', 'red');
            }



        });
        $('#closeDialogschedule2').click(function () {
            window.location = '#close';
            clearcollisions2();

        });
        //saves the entire content--------------------Stops--------------------/

        //adding session to days
        var x = 0;
        $('#addsession2').click(function () {
            var selectday = $('#dayx2').html();
            var starttime = $('#starttimepicker2').val();
            var endtime = $('#endtimepicker2').val();
            if (selectday === 'Mon') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport2').html('');
                    var starx, starx2a;
                    if (SundayCollisionList.length !== 0) {
                        var previousSundaytime = SundayCollisionList[SundayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange2(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal2(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the ' + SundayCollisionList[SundayCollisionList.length - 1].weekday + '!!!</strong>');
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
                            var checkresults2a = getTimeRangeFinal2(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (MondayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#errorReport2').html('');
                            $('#userMonSetTime2').append('<p id="saveMonSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveMonSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetMonSess(this.id)"></i></p>');
                            $('#starttimepicker2').val('');
                            $('#endtimepicker2').val('');
                            $('#starttimepicker2').css('border-color', '');
                            $('#endtimepicker2').css('border-color', '');
                            $('#saveSchedule2').show();
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
                    $('#starttimepicker2').css('border-color', '');
                    $('#endtimepicker2').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker2').css('border-color', '');
                    $('#starttimepicker2').css('border-color', 'red');
                } else {
                    $('#starttimepicker2').css('border-color', 'red');
                    $('#endtimepicker2').css('border-color', 'red');
                }
            } else if (selectday === 'Tue') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport2').html('');
                    var starx, starx2a;
                    if (MondayCollisionList.length !== 0) {
                        var previousSundaytime = MondayCollisionList[MondayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange2(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal2(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            starx = false;
                            $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the ' + MondayCollisionList[MondayCollisionList.length - 1].weekday + '!!!</strong>');
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
                            var checkresults2a = getTimeRangeFinal2(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (TuesdayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#errorReport2').html('');
                            $('#userTueSetTime2').append('<p id="saveTueSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveTueSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetTueSess(this.id)"></i></p>');
                            $('#starttimepicker2').val('');
                            $('#endtimepicker2').val('');
                            $('#starttimepicker2').css('border-color', '');
                            $('#endtimepicker2').css('border-color', '');
                            $('#saveSchedule2').show();
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
                    $('#starttimepicker2').css('border-color', '');
                    $('#endtimepicker2').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker2').css('border-color', '');
                    $('#starttimepicker2').css('border-color', 'red');
                } else {
                    $('#starttimepicker2').css('border-color', 'red');
                    $('#endtimepicker2').css('border-color', 'red');
                }
            } else if (selectday === 'Wed') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport2').html('');
                    var starx, starx2a;
                    if (TuesdayCollisionList.length !== 0) {
                        var previousSundaytime = TuesdayCollisionList[TuesdayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange2(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal2(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the ' + TuesdayCollisionList[TuesdayCollisionList.length - 1].weekday + '!!!</strong>');
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
                            var checkresults2a = getTimeRangeFinal2(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (WednesdayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#errorReport2').html('');
                            $('#userWedSetTime2').append('<p id="saveWedSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveWedSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetWedSess(this.id)"></i></p>');
                            $('#starttimepicker2').val('');
                            $('#endtimepicker2').val('');
                            $('#starttimepicker2').css('border-color', '');
                            $('#endtimepicker2').css('border-color', '');
                            $('#saveSchedule2').show();
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
                    $('#starttimepicker2').css('border-color', '');
                    $('#endtimepicker2').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker2').css('border-color', '');
                    $('#starttimepicker2').css('border-color', 'red');
                } else {
                    $('#starttimepicker2').css('border-color', 'red');
                    $('#endtimepicker2').css('border-color', 'red');
                }
            } else if (selectday === 'Thur') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport2').html('');
                    var starx, starx2a;
                    if (WednesdayCollisionList.length !== 0) {
                        var previousSundaytime = WednesdayCollisionList[WednesdayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange2(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal2(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the ' + WednesdayCollisionList[WednesdayCollisionList.length - 1].weekday + '!!!</strong>');
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
                            var checkresults2a = getTimeRangeFinal2(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (ThursdayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#errorReport2').html('');
                            $('#userThurSetTime2').append('<p id="saveThurSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveThurSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetThurSess(this.id)"></i></p>');
                            $('#starttimepicker2').val('');
                            $('#endtimepicker2').val('');
                            $('#starttimepicker2').css('border-color', '');
                            $('#endtimepicker2').css('border-color', '');
                            $('#saveSchedule2').show();
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
                    $('#starttimepicker2').css('border-color', '');
                    $('#endtimepicker2').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker2').css('border-color', '');
                    $('#starttimepicker2').css('border-color', 'red');
                } else {
                    $('#starttimepicker2').css('border-color', 'red');
                    $('#endtimepicker2').css('border-color', 'red');
                }
            } else if (selectday === 'Fri') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport2').html('');
                    var starx, starx2a;
                    if (ThursdayCollisionList.length !== 0) {
                        var previousSundaytime = ThursdayCollisionList[ThursdayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange2(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal2(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the ' + ThursdayCollisionList[ThursdayCollisionList.length - 1].weekday + '!!!</strong>');
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
                            var checkresults2a = getTimeRangeFinal2(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (FridayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#errorReport2').html('');
                            $('#userFriSetTime2').append('<p id="saveFriSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveFriSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetFriSess(this.id)"></i></p>');
                            $('#starttimepicker2').val('');
                            $('#endtimepicker2').val('');
                            $('#starttimepicker2').css('border-color', '');
                            $('#endtimepicker2').css('border-color', '');
                            $('#saveSchedule2').show();
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
                    $('#starttimepicker2').css('border-color', '');
                    $('#endtimepicker2').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker2').css('border-color', '');
                    $('#starttimepicker2').css('border-color', 'red');
                } else {
                    $('#starttimepicker2').css('border-color', 'red');
                    $('#endtimepicker2').css('border-color', 'red');
                }
            } else if (selectday === 'Sat') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport2').html('');
                    var starx, starx2a;
                    if (FridayCollisionList.length !== 0) {
                        var previousSundaytime = FridayCollisionList[FridayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange2(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal2(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the ' + FridayCollisionList[FridayCollisionList.length - 1].weekday + '!!!</strong>');
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
                            var checkresults2a = getTimeRangeFinal2(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (SaturdayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#errorReport2').html('');
                            $('#userSatSetTime2').append('<p id="saveSatSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveSatSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetSatSess(this.id)"></i></p>');
                            $('#starttimepicker2').val('');
                            $('#endtimepicker2').val('');
                            $('#starttimepicker2').css('border-color', '');
                            $('#endtimepicker2').css('border-color', '');
                            $('#saveSchedule2').show();
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
                    $('#starttimepicker2').css('border-color', '');
                    $('#endtimepicker2').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker2').css('border-color', '');
                    $('#starttimepicker2').css('border-color', 'red');
                } else {
                    $('#starttimepicker2').css('border-color', 'red');
                    $('#endtimepicker2').css('border-color', 'red');
                }
            } else if (selectday === 'Sun') {
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport2').html('');
                    var starx, starx2a;
                    if (SaturdayCollisionList.length !== 0) {
                        var previousSundaytime = SaturdayCollisionList[SaturdayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange2(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinal2(enddaysession, checkdaysession);
                        if (checkresults === false) {
                            starx = true;
                        } else {
                            $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the ' + SaturdayCollisionList[SaturdayCollisionList.length - 1].weekday + '!!!</strong>');
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
                            var checkresults2a = getTimeRangeFinal2(enddaysession2a, checkdaysession2a);
                            if (checkresults2a === false) {
                                starx2a = true;
                            } else {
                                starx2a = false;
                                $('#errorReport2').html('<strong class="text-danger">*Error Session Collison with the Current Sessions!!!</strong>');
                            }
                        } else if (SundayCollisionList.length === 0) {
                            starx2a = true;
                        }
                        if (starx2a === true) {
                            $('#userSunSetTime2').append('<p id="saveSunSess' + x + '"><strong style="font-size:0.8em">' + starttime + '-' + endtime + '</strong>&nbsp;<i id="saveSunSess' + x + '" style="color:red"class="fa fa-times" onclick="removeSetSunSess(this.id)"></i></p>');
                            $('#starttimepicker2').val('');
                            $('#endtimepicker2').val('');
                            $('#starttimepicker2').css('border-color', '');
                            $('#endtimepicker2').css('border-color', '');
                            $('#saveSchedule2').show();
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
                    /*
                     checkedweekdaySessions.push({
                     weekday: weekday,
                     sessiontimeSet: sessiontimeSet,
                     sessiontimeSetid: sessiontimeSetid
                     });*/
                } else if (starttime !== '' && endtime === '') {
                    $('#starttimepicker2').css('border-color', '');
                    $('#endtimepicker2').css('border-color', 'red');
                } else if (starttime === '' && endtime !== '') {
                    $('#endtimepicker2').css('border-color', '');
                    $('#starttimepicker2').css('border-color', 'red');
                } else {
                    $('#starttimepicker2').css('border-color', 'red');
                    $('#endtimepicker2').css('border-color', 'red');
                }
            }
        });
    });
    $('#closeSetSessionDay2').click(function () {
        $('#starttimepicker2').val('');
        $('#endtimepicker2').val('');
        $('#setSessionDay2').hide();
    });
    var checkedweekdaySessionsFinal = [];
    //-------------Monday- Starts------//
    var MondayCollisionListSessionsFinal = [];
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
        }
    }
    function checkedDateMon2(status, selectedday, id) {
        var enddateInput = $('#endDatex').val();
        if (enddateInput !== '') {
            if (selectedday === 'Monday' && status === 'checked') {
                $("#SetMonAddbtn2").html('<button class="btn btn-secondary" onclick="addMondaySchedules2()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDatex").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetMonAddbtn2").html('');
                $('#userMonSetTime2').html('');
                $('#setSessionDay2').hide();
                checkedweekdays.delete(selectedday);
            }
        }
    }
    function addMondaySchedules2() {
        $('#setSessionDay2').show();
        $('#endtimepicker2').val('');
        $('#starttimepicker2').val('');
        $('#selectedsessionDay2').html('<strong>Schedule Monday Sessions</strong>');
        $('#dayx2').html('Mon');
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
        }
    }
    function checkedDateTue2(status, selectedday, id) {
        var enddateInput = $('#endDatex').val();
        if (enddateInput !== '') {
            if (selectedday === 'Tuesday' && status === 'checked') {
                $("#SetTueAddbtn2").html('<button class="btn btn-secondary" onclick="addTuesdaySchedules2()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDatex").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetTueAddbtn2").html('');
                $('#userTueSetTime2').html('');
                $('#setSessionDay2').hide();
                checkedweekdays.delete(selectedday);
            }
        }
    }
    function addTuesdaySchedules2() {
        $('#setSessionDay2').show();
        $('#endtimepicker2').val('');
        $('#starttimepicker2').val('');
        $('#selectedsessionDay2').html('<strong>Schedule Tuesday Sessions</strong>');
        $('#dayx2').html('Tue');
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
        }
    }
    function checkedDateWed2(status, selectedday, id) {
        var enddateInput = $('#endDatex').val();
        if (enddateInput !== '') {
            if (selectedday === 'Wednesday' && status === 'checked') {
                $("#SetWedAddbtn2").html('<button class="btn btn-secondary" onclick="addWednesdaySchedules2()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDatex").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetWedAddbtn2").html('');
                $('#userWedSetTime2').html('');
                $('#setSessionDay2').hide();
                checkedweekdays.delete(selectedday);
            }
        }

    }
    function addWednesdaySchedules2() {
        $('#setSessionDay2').show();
        $('#endtimepicker2').val('');
        $('#starttimepicker2').val('');
        $('#selectedsessionDay2').html('<strong>Schedule Wednesday Sessions</strong>');
        $('#dayx2').html('Wed');
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
        }
    }
    function checkedDateThur2(status, selectedday, id) {
        var enddateInput = $('#endDatex').val();
        if (enddateInput !== '') {
            if (selectedday === 'Thursday' && status === 'checked') {
                $("#SetThurAddbtn2").html('<button class="btn btn-secondary" onclick="addThursdaySchedules2()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDatex").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetThurAddbtn2").html('');
                $('#userThurSetTime2').html('');
                $('#setSessionDay2').hide();
                checkedweekdays.delete(selectedday);
            }
        }
    }
    function addThursdaySchedules2() {
        $('#setSessionDay2').show();
        $('#endtimepicker2').val('');
        $('#starttimepicker2').val('');
        $('#selectedsessionDay2').html('<strong>Schedule Thursday Sessions</strong>');
        $('#dayx2').html('Thur');
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
        }
    }
    function checkedDateFri2(status, selectedday, id) {
        var enddateInput = $('#endDatex').val();
        if (enddateInput !== '') {
            if (selectedday === 'Friday' && status === 'checked') {
                $("#SetFriAddbtn2").html('<button class="btn btn-secondary" onclick="addFridaySchedules2()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDatex").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetFriAddbtn2").html('');
                $('#userFriSetTime2').html('');
                $('#setSessionDay2').hide();
                checkedweekdays.delete(selectedday);
            }
        }
    }
    function addFridaySchedules2() {
        $('#setSessionDay2').show();
        $('#endtimepicker2').val('');
        $('#starttimepicker2').val('');
        $('#selectedsessionDay2').html('<strong>Schedule Friday Sessions</strong>');
        $('#dayx2').html('Fri');
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
        }
    }
    function checkedDateSat2(status, selectedday, id) {
        var enddateInput = $('#endDatex').val();
        if (enddateInput !== '') {
            if (selectedday === 'Saturday' && status === 'checked') {
                $("#SetSatAddbtn2").html('<button class="btn btn-secondary" onclick="addSaturdaySchedules2()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDatex").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetSatAddbtn2").html('');
                $('#userSatSetTime2').html('');
                $('#setSessionDay2').hide();
                checkedweekdays.delete(selectedday);
            }
        }
    }
    function addSaturdaySchedules2() {
        $('#setSessionDay2').show();
        $('#endtimepicker2').val('');
        $('#starttimepicker2').val('');
        $('#selectedsessionDay2').html('<strong>Schedule Saturday Sessions</strong>');
        $('#dayx2').html('Sat');
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
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
            $('#saveSchedule2').hide();
        } else {
            $('#saveSchedule2').show();
        }
    }
    function checkedDateSun2(status, selectedday, id) {
        var enddateInput = $('#endDatex').val();
        if (enddateInput !== '') {
            if (selectedday === 'Sunday' && status === 'checked') {
                $("#SetSunAddbtn2").html('<button class="btn btn-secondary" onclick="addSundaySchedules2()"><i class="fa fa-plus-circle"></i></button>');
                $("#endDatex").prop('disabled', true);
                checkedweekdays.add(selectedday);
            } else {
                $("#SetSunAddbtn2").html('');
                $('#userSunSetTime2').html('');
                $('#setSessionDay2').hide();
                checkedweekdays.delete(selectedday);
            }
        }
    }
    function addSundaySchedules2() {
        $('#setSessionDay2').show();
        $('#endtimepicker2').val('');
        $('#starttimepicker2').val('');
        $('#selectedsessionDay2').html('<strong>Schedule Sunday Sessions</strong>');
        $('#dayx2').html('Sun');
    }
    //-------------Sunday- Ends------//
    function clearSection() {
        $('#Monday2').prop('checked', false);
        $('#Tuesday2').prop('checked', false);
        $('#Wednesday2').prop('checked', false);
        $('#Thursday2').prop('checked', false);
        $('#Friday2').prop('checked', false);
        $('#Saturday2').prop('checked', false);
        $('#Sunday2').prop('checked', false);

        $("#SetMonAddbtn2").html('');
        $('#userMonSetTime2').html('');
        $("#SetTueAddbtn2").html('');
        $('#userTueSetTime2').html('');
        $("#SetWedAddbtn2").html('');
        $('#userWedSetTime2').html('');
        $("#SetThurAddbtn2").html('');
        $('#userThurSetTime2').html('');
        $("#SetFriAddbtn2").html('');
        $('#userFriSetTime2').html('');
        $("#SetSatAddbtn2").html('');
        $('#userSatSetTime2').html('');
        $("#SetSunAddbtn2").html('');
        $('#userSunSetTime2').html('');
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
    function  getTimeRangeFinal2(prev, current) {
        var prevtv = timeConvertor(prev);
        var checktv = timeConvertor(current);
        var msecondsprev = parseInt((parseInt(prevtv.split(":")[0]) * 60 * 60) + (parseInt(prevtv.split(":")[1]) * 60)) * 1000;
        var msecondscurr = parseInt((parseInt(checktv.split(":")[0]) * 60 * 60) + (parseInt(checktv.split(":")[1]) * 60)) * 1000;
        var timeIsBetweenTest = (msecondsprev >= msecondscurr) ? true : false;
        return timeIsBetweenTest;
    }
    function getTimeRange2(startingtym, endingtym, checkingtym) {
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
    function clearcollisions2() {
        SundayCollisionList = [];
        MondayCollisionList = [];
        TuesdayCollisionList = [];
        WednesdayCollisionList = [];
        ThursdayCollisionList = [];
        FridayCollisionList = [];
        SaturdayCollisionList = [];
    }
</script>