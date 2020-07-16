<%-- 
    Document   : staffScheduleEdit
    Created on : May 29, 2018, 9:41:09 AM
    Author     : user
--%>

<%@include file="../../../../../../../include.jsp" %>
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
                <span id="schedulesidSelect" class="hidedisplaycontent">${schedulesid}</span>
                <legend align="center"><strong id="detailsdesign" >Schedule Details</strong></legend>
                <table style="border:whitesmoke;" class="table table-responsive xv" align="center">
                    <tbody>
                        <tr>
                            <td><b>Start Date</b></td>
                            <td><span  id="errorshowstart"></span>
                                <input class="form-control" id="startDate" value="${staffmemberx.Startdates}" type="text" placeholder="Start Date">
                            </td> 
                        </tr>                    
                        <tr>
                            <td><b>End Date</b></td>
                            <td><span  id="errorshow"></span>
                                <input class="form-control" id="endDate" type="text" value="${staffmemberx.Enddates}" placeholder="End Date">
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
                            <td><b>Schedule Status</b><span id="scheduleqw" class="hidedisplaycontent">${staffmemberx.schedulestatusx}</span></td>
                            <td>
                                <select class="form-control" id="schedulestate">
                                    <c:if test="${staffmemberx.schedulestatusx == 'ON'}">
                                        <option value="ON" selected="selected">ON</option>
                                        <option value="Paused">Paused</option>
                                    </c:if> 
                                    <c:if test="${staffmemberx.schedulestatusx == 'Paused'}">
                                        <option value="ON">ON</option>
                                        <option value="Paused" selected="selected">Paused</option>
                                    </c:if> 
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
                                        <div id="SetMonAddbtn"></div>
                                        <div id="userMonSetTimex">
                                            <c:forEach items="${staffscheduleday}" var="t">
                                                <c:if test="${t.weekday == 'Monday'}">
                                                    <c:forEach items="${staffschedulesession}" var="t1">
                                                        <c:if test="${t.scheduledayid == t1.scheduledayid}">
                                                            <p id="saveMonSess${t1.scheduledaysessionid}"><strong style="font-size:0.8em">${t1.starttime}-${t1.endtime}</strong>&nbsp;<i id="saveMonSess${t1.scheduledaysessionid}" data-id="${t1.scheduledaysessionid}" data-time="${t1.starttime}-${t1.endtime}" style="color:red"class="fa fa-times" onclick="removeSetMonSess2(this.id, $(this).attr('data-id'), $(this).attr('data-time'))"></i></p>
                                                            <span id="scheduledayidMon" class="hidedisplaycontent">${t1.scheduledayid}</span>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                        <div id="userMonSetTime"></div>
                                    </td>
                                    <td data-label="Tuesday" id="Tueshow">
                                        <div id="SetTueAddbtn"></div>
                                        <div id="userTueSetTimex">
                                            <c:forEach items="${staffscheduleday}" var="t">
                                                <c:if test="${t.weekday == 'Tuesday'}">
                                                    <c:forEach items="${staffschedulesession}" var="t1">
                                                        <c:if test="${t.scheduledayid == t1.scheduledayid}">
                                                            <p id="saveTueSess${t1.scheduledaysessionid}"><strong style="font-size:0.8em">${t1.starttime}-${t1.endtime}</strong>&nbsp;<i id="saveTueSess${t1.scheduledaysessionid}" data-id="${t1.scheduledaysessionid}" data-time="${t1.starttime}-${t1.endtime}" style="color:red"class="fa fa-times" onclick="removeSetTueSess2(this.id, $(this).attr('data-id'), $(this).attr('data-time'))"></i></p>
                                                            <span id="scheduledayidTue" class="hidedisplaycontent">${t1.scheduledayid}</span>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                        <div id="userTueSetTime"></div>                                        
                                    </td>
                                    <td data-label="Wednesday" id="Wedshow">
                                        <div id="SetWedAddbtn"></div>
                                        <div id="userWedSetTimex">
                                            <c:forEach items="${staffscheduleday}" var="t">
                                                <c:if test="${t.weekday == 'Wednesday'}">
                                                    <c:forEach items="${staffschedulesession}" var="t1">
                                                        <c:if test="${t.scheduledayid == t1.scheduledayid}">
                                                            <p id="saveWedSess${t1.scheduledaysessionid}"><strong style="font-size:0.8em">${t1.starttime}-${t1.endtime}</strong>&nbsp;<i id="saveWedSess${t1.scheduledaysessionid}" data-id="${t1.scheduledaysessionid}" data-time="${t1.starttime}-${t1.endtime}" style="color:red"class="fa fa-times" onclick="removeSetWedSess2(this.id, $(this).attr('data-id'), $(this).attr('data-time'))"></i></p>
                                                            <span id="scheduledayidWed" class="hidedisplaycontent">${t1.scheduledayid}</span>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                        <div id="userWedSetTime"></div>                                       
                                    </td>
                                    <td data-label="Thursday" id="Thurshow">                                        
                                        <div id="SetThurAddbtn"></div>
                                        <div id="userThurSetTimex">
                                            <c:forEach items="${staffscheduleday}" var="t">
                                                <c:if test="${t.weekday == 'Thursday'}">
                                                    <c:forEach items="${staffschedulesession}" var="t1">
                                                        <c:if test="${t.scheduledayid == t1.scheduledayid}">
                                                            <p id="saveThurSess${t1.scheduledaysessionid}"><strong style="font-size:0.8em">${t1.starttime}-${t1.endtime}</strong>&nbsp;<i id="saveThurSess${t1.scheduledaysessionid}" data-id="${t1.scheduledaysessionid}" data-time="${t1.starttime}-${t1.endtime}" style="color:red"class="fa fa-times" onclick="removeSetThurSess2(this.id, $(this).attr('data-id'), $(this).attr('data-time'))"></i></p>
                                                            <span id="scheduledayidThur" class="hidedisplaycontent">${t1.scheduledayid}</span>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                        <div id="userThurSetTime"></div>
                                    </td>
                                    <td data-label="Friday" id="Frishow">
                                        <div id="SetFriAddbtn"></div>
                                        <div id="userFriSetTimex">
                                            <c:forEach items="${staffscheduleday}" var="t">
                                                <c:if test="${t.weekday == 'Friday'}">
                                                    <c:forEach items="${staffschedulesession}" var="t1">
                                                        <c:if test="${t.scheduledayid == t1.scheduledayid}">
                                                            <p id="saveFriSess${t1.scheduledaysessionid}"><strong style="font-size:0.8em">${t1.starttime}-${t1.endtime}</strong>&nbsp;<i id="saveFriSess${t1.scheduledaysessionid}" data-id="${t1.scheduledaysessionid}" data-time="${t1.starttime}-${t1.endtime}" style="color:red"class="fa fa-times" onclick="removeSetFriSess2(this.id, $(this).attr('data-id'), $(this).attr('data-time'))"></i></p>
                                                            <span id="scheduledayidFri" class="hidedisplaycontent">${t1.scheduledayid}</span>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                        <div id="userFriSetTime"></div>                                        
                                    </td>
                                    <td data-label="Saturday"id="Satshow">
                                        <div id="SetSatAddbtn"></div>
                                        <div id="userSatSetTimex">
                                            <c:forEach items="${staffscheduleday}" var="t">
                                                <c:if test="${t.weekday == 'Saturday'}">
                                                    <c:forEach items="${staffschedulesession}" var="t1">
                                                        <c:if test="${t.scheduledayid == t1.scheduledayid}">
                                                            <p id="saveSatSess${t1.scheduledaysessionid}"><strong style="font-size:0.8em">${t1.starttime}-${t1.endtime}</strong>&nbsp;<i id="saveSatSess${t1.scheduledaysessionid}" data-id="${t1.scheduledaysessionid}" data-time="${t1.starttime}-${t1.endtime}" style="color:red"class="fa fa-times" onclick="removeSetSatSess2(this.id, $(this).attr('data-id'), $(this).attr('data-time'))"></i></p>
                                                            <span id="scheduledayidSat" class="hidedisplaycontent">${t1.scheduledayid}</span>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                        <div id="userSatSetTime"></div>                                        
                                    </td>
                                    <td data-label="Sunday" id="Sunshow">                                        
                                        <div id="SetSunAddbtn"></div>
                                        <div id="userSunSetTimex">
                                            <c:forEach items="${staffscheduleday}" var="t">
                                                <c:if test="${t.weekday == 'Sunday'}">
                                                    <c:forEach items="${staffschedulesession}" var="t1">
                                                        <c:if test="${t.scheduledayid == t1.scheduledayid}">
                                                            <p id="saveSunSess${t1.scheduledaysessionid}"><strong style="font-size:0.8em">${t1.starttime}-${t1.endtime}</strong>&nbsp;<i id="saveSunSess${t1.scheduledaysessionid}" data-id="${t1.scheduledaysessionid}" data-time="${t1.starttime}-${t1.endtime}" style="color:red"class="fa fa-times" onclick="removeSetSunSess2(this.id, $(this).attr('data-id'), $(this).attr('data-time'))"></i></p>
                                                            <span id="scheduledayidSun" class="hidedisplaycontent">${t1.scheduledayid}</span>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </c:forEach>
                                        </div>
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
        <button class="btn btn-primary col-md-2 " id="saveSchedulebtn">Save Schedule Changes</button>&nbsp;
        <button class="btn btn-secondary col-md-2" id="closeDialogschedule">cancel</button> 
    </div>

</div>
<script>
    var serverDate = '${serverdate}';
    var checkedweekdays = new Set();
    var checkedweekdaysNew = new Set();
    var checkedweekdaySessions = [];
    var checkedDaysofweek = [];
    var SundayCollisionList = [];
    var MondayCollisionList = [];
    var TuesdayCollisionList = [];
    var WednesdayCollisionList = [];
    var ThursdayCollisionList = [];
    var FridayCollisionList = [];
    var SaturdayCollisionList = [];
    $(document).ready(function () {
        var jsonscheduledDays = ${jsonstaffscheduleday};
        var jsonsessiondays =${jsonstaffschedulesession};
        for (var index in jsonscheduledDays) {
            var t = jsonscheduledDays[index];
            if (t.weekday === 'Monday') {
                for (var index1 in jsonsessiondays) {
                    var t1 = jsonsessiondays[index1];
                    if (t.scheduledayid === t1.scheduledayid) {
                        var sessiontimeSet = t1.starttime + '-' + t1.endtime;
                        var sessiontimeSetid = 'saveMonSess' + t1.scheduledaysessionid;
                        var weekday = t.weekday;
                        MondayCollisionList.push({
                            weekday: weekday,
                            sessiontimeSet: sessiontimeSet,
                            sessiontimeSetid: sessiontimeSetid
                        });
                    }
                }
            }
            if (t.weekday === 'Tuesday') {
                for (var index1 in jsonsessiondays) {
                    var t1 = jsonsessiondays[index1];
                    if (t.scheduledayid === t1.scheduledayid) {
                        var sessiontimeSet = t1.starttime + '-' + t1.endtime;
                        var sessiontimeSetid = 'saveTueSess' + t1.scheduledaysessionid;
                        var weekday = t.weekday;
                        TuesdayCollisionList.push({
                            weekday: weekday,
                            sessiontimeSet: sessiontimeSet,
                            sessiontimeSetid: sessiontimeSetid
                        });
                    }
                }
            }
            if (t.weekday === 'Wednesday') {
                for (var index1 in jsonsessiondays) {
                    var t1 = jsonsessiondays[index1];
                    if (t.scheduledayid === t1.scheduledayid) {
                        var sessiontimeSet = t1.starttime + '-' + t1.endtime;
                        var sessiontimeSetid = 'saveWedSess' + t1.scheduledaysessionid;
                        var weekday = t.weekday;
                        WednesdayCollisionList.push({
                            weekday: weekday,
                            sessiontimeSet: sessiontimeSet,
                            sessiontimeSetid: sessiontimeSetid
                        });
                    }
                }
            }
            if (t.weekday === 'Thursday') {
                for (var index1 in jsonsessiondays) {
                    var t1 = jsonsessiondays[index1];
                    if (t.scheduledayid === t1.scheduledayid) {
                        var sessiontimeSet = t1.starttime + '-' + t1.endtime;
                        var sessiontimeSetid = 'saveThurSess' + t1.scheduledaysessionid;
                        var weekday = t.weekday;
                        ThursdayCollisionList.push({
                            weekday: weekday,
                            sessiontimeSet: sessiontimeSet,
                            sessiontimeSetid: sessiontimeSetid
                        });
                    }
                }
            }
            if (t.weekday === 'Friday') {
                for (var index1 in jsonsessiondays) {
                    var t1 = jsonsessiondays[index1];
                    if (t.scheduledayid === t1.scheduledayid) {
                        var sessiontimeSet = t1.starttime + '-' + t1.endtime;
                        var sessiontimeSetid = 'saveFriSess' + t1.scheduledaysessionid;
                        var weekday = t.weekday;
                        FridayCollisionList.push({
                            weekday: weekday,
                            sessiontimeSet: sessiontimeSet,
                            sessiontimeSetid: sessiontimeSetid
                        });
                    }
                }
            }
            if (t.weekday === 'Saturday') {
                for (var index1 in jsonsessiondays) {
                    var t1 = jsonsessiondays[index1];
                    if (t.scheduledayid === t1.scheduledayid) {
                        var sessiontimeSet = t1.starttime + '-' + t1.endtime;
                        var sessiontimeSetid = 'saveSatSess' + t1.scheduledaysessionid;
                        var weekday = t.weekday;
                        SaturdayCollisionList.push({
                            weekday: weekday,
                            sessiontimeSet: sessiontimeSet,
                            sessiontimeSetid: sessiontimeSetid
                        });
                    }
                }
            }
            if (t.weekday === 'Sunday') {
                for (var index1 in jsonsessiondays) {
                    var t1 = jsonsessiondays[index1];
                    if (t.scheduledayid === t1.scheduledayid) {
                        var sessiontimeSet = t1.starttime + '-' + t1.endtime;
                        var sessiontimeSetid = 'saveSunSess' + t1.scheduledaysessionid;
                        var weekday = t.weekday;
                        SundayCollisionList.push({
                            weekday: weekday,
                            sessiontimeSet: sessiontimeSet,
                            sessiontimeSetid: sessiontimeSetid
                        });
                    }
                }
            }
        }
        $('#startDate').html();
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

        /*----------More Modifications Starts---------------*/
        var checkstartdatetest = $('#startDate').val();
        var checkEnddatetest = $('#endDate').val();
        if (checkstartdatetest !== '' && checkEnddatetest !== '') {
            var endx = $('#endDate').val().split("/");
            var startx = $('#startDate').val().split("/");
            var datestart = new Date(startx[2], startx[1] - 1, startx[0]);
            var dateEnd = new Date(endx[2], endx[1] - 1, endx[0]);
            if (datestart.getTime() > dateEnd.getTime()) {
                //console.log(datestart.getTime() + ' greater than ' + dateEnd.getTime());
                $('#errorshow').html('<span style="color:red;">* Error End Date must be greater or Equal to Start Date</span>');
                $('#endDate').css('border-color', 'red');
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
                // console.log(selectedrangedays);
                var uniqueselectedrangedays = [];
                $.each(selectedrangedays, function (i, item) {
                    if ($.inArray(item, uniqueselectedrangedays) === -1)
                        uniqueselectedrangedays.push(item);

                });
                //console.log(uniqueselectedrangedays);
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
        }
        /*----------More Modifications Ends---------------*/
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
            clearSection();
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
                console.log(selectedrangedays);
                var uniqueselectedrangedays = [];
                $.each(selectedrangedays, function (i, item) {
                    if ($.inArray(item, uniqueselectedrangedays) === -1)
                        uniqueselectedrangedays.push(item);

                });
                // console.log(uniqueselectedrangedays);
                for (var v in uniqueselectedrangedays) {
                    var dataSelectNumber = uniqueselectedrangedays[v];
                    // console.log(dataSelectNumber);
                    if (parseInt(dataSelectNumber) === parseInt(0)) {
                        $('#Sunday').prop('checked', true);
                        if (document.getElementById('Sunday').checked) {
                            checkedDateSun("checked", "Sunday");
                            checkedweekdaysNew.add("Sunday");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(1)) {
                        $('#Monday').prop('checked', true);
                        if (document.getElementById('Monday').checked) {
                            checkedDateMon("checked", "Monday");
                            checkedweekdaysNew.add("Monday");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(2)) {
                        $('#Tuesday').prop('checked', true);
                        if (document.getElementById('Tuesday').checked) {
                            checkedDateTue("checked", "Tuesday");
                            checkedweekdaysNew.add("Tuesday");
                        }
                    }
                    if (parseInt(dataSelectNumber) === parseInt(3)) {
                        $('#Wednesday').prop('checked', true);
                        if (document.getElementById('Wednesday').checked) {
                            checkedDateWed("checked", "Wednesday");
                            checkedweekdaysNew.add("Wednesday");
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
        //$('#disablethisScheduleTable input[type=checkbox]').prop("disabled", true);
        /*--------Works on Start Date and End Date Ends------------*/


        //saves the entire content--------------------Starts--------------------/
        var statusSchedule = $('#scheduleqw').html();
        $('#schedulestate').change(function () {
            var statusSchedule2 = $(this).val();
            if (statusSchedule !== statusSchedule2) {
                $('#saveSchedule').show();
            } else {
                $('#saveSchedule').hide();
            }
        });
        var addnewSchedulesession = [];
        var addnewSchedulecheckedDaysofweek = [];
        var updateSchedulesession = [];

        $('#saveSchedulebtn').click(function () {
            var startdate = $('#startDate').val();
            var enddate = $('#endDate').val();
            var staffid = $('#staffidx').html();
            var schedulesidSelectid = $('#schedulesidSelect').html();
            var schedulestatex = $('#schedulestate').val();
            var combinedata = [];
            combinedata.push({
                staffid: staffid,
                startdate: startdate,
                enddate: enddate,
                schedulestatex: schedulestatex
            });
            var jsoncheckedDaysofweekALL = removeDuplicates(checkedDaysofweek);
            for (var x in jsoncheckedDaysofweekALL) {
                var data = jsoncheckedDaysofweekALL[x];
                if (typeof data.scheduledayid === "undefined") {
                    addnewSchedulecheckedDaysofweek.push({
                        weekday: data.weekday
                    });
                }
            }
            for (var x in checkedweekdaySessions) {
                var data = checkedweekdaySessions[x];
                if (typeof data.scheduledayid === "undefined") {
                    addnewSchedulesession.push({
                        weekday: data.weekday,
                        sessiontimeSetid: data.sessiontimeSetid,
                        sessiontimeSet: data.sessiontimeSet
                    });
                } else {
                    updateSchedulesession.push({
                        weekday: data.weekday,
                        sessiontimeSetid: data.sessiontimeSetid,
                        sessiontimeSet: data.sessiontimeSet,
                        scheduledayid: data.scheduledayid
                    });
                }
            }
            $.ajax({
                type: 'GET',
                cache: false,
                dataType: 'text',
                data: {scheduleid: schedulesidSelectid, schedulesupdatedata: JSON.stringify(combinedata), addschedulesessionExist: JSON.stringify(updateSchedulesession), addNewDay: JSON.stringify(addnewSchedulecheckedDaysofweek), addNewDaysessions: JSON.stringify(addnewSchedulesession)},
                url: "appointmentandSchedules/addoreditstaffSchedule.htm",
                success: function (data) {
                    if (data === 'success') {
                        $.toast({
                            heading: 'Success',
                            text: 'Schedule Edited Successfully',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        ajaxSubmitData('appointmentandSchedules/activeuserschedules.htm', 'activeContentdisplay', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'An unexpected error occured while trying to Edit Schedule',
                            icon: 'error',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                    }
                    window.location = '#close';
                    clearcollisionsx();
                }
            });
        });
        $('#closeDialogschedule').click(function () {
            window.location = '#close';
            clearcollisionsx();
        });
        //saves the entire content--------------------Stops--------------------/

        //adding session to days
        var x = 0;
        $('#addsession').click(function () {
            var selectday = $('#dayx').html();
            var starttime = $('#starttimepicker').val();
            var endtime = $('#endtimepicker').val();
            if (selectday === 'Mon') {
                var scheduledayidMonday = $('#scheduledayidMon').html();
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (SundayCollisionList.length !== 0) {
                        var previousSundaytime = SundayCollisionList[SundayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinalx(enddaysession, checkdaysession);
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
                            var checkresults2a = getTimeRangeFinalx(enddaysession2a, checkdaysession2a);
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
                            checkedDaysofweek.push({
                                weekday: weekday,
                                scheduledayid: scheduledayidMonday
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid,
                                scheduledayid: scheduledayidMonday
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
                var scheduledayidTuesday = $('#scheduledayidTue').html();
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (MondayCollisionList.length !== 0) {
                        var previousSundaytime = MondayCollisionList[MondayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinalx(enddaysession, checkdaysession);
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
                            var checkresults2a = getTimeRangeFinalx(enddaysession2a, checkdaysession2a);
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
                            checkedDaysofweek.push({
                                weekday: weekday,
                                scheduledayid: scheduledayidTuesday
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid,
                                scheduledayid: scheduledayidTuesday
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
                var scheduledayidWednesday = $('#scheduledayidWed').html();
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (TuesdayCollisionList.length !== 0) {
                        var previousSundaytime = TuesdayCollisionList[TuesdayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinalx(enddaysession, checkdaysession);
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
                            var checkresults2a = getTimeRangeFinalx(enddaysession2a, checkdaysession2a);
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
                            checkedDaysofweek.push({
                                weekday: weekday,
                                scheduledayid: scheduledayidWednesday
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid,
                                scheduledayid: scheduledayidWednesday
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
                var scheduledayidThursday = $('#scheduledayidThur').html();
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (WednesdayCollisionList.length !== 0) {
                        var previousSundaytime = WednesdayCollisionList[WednesdayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinalx(enddaysession, checkdaysession);
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
                            var checkresults2a = getTimeRangeFinalx(enddaysession2a, checkdaysession2a);
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
                            checkedDaysofweek.push({
                                weekday: weekday,
                                scheduledayid: scheduledayidThursday
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid,
                                scheduledayid: scheduledayidThursday
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
                var scheduledayidFriday = $('#scheduledayidFri').html();
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (ThursdayCollisionList.length !== 0) {
                        var previousSundaytime = ThursdayCollisionList[ThursdayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinalx(enddaysession, checkdaysession);
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
                            var checkresults2a = getTimeRangeFinalx(enddaysession2a, checkdaysession2a);
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
                            checkedDaysofweek.push({
                                weekday: weekday,
                                scheduledayid: scheduledayidFriday
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid,
                                scheduledayid: scheduledayidFriday
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
                var scheduledayidSaturday = $('#scheduledayidSat').html();
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (FridayCollisionList.length !== 0) {
                        var previousSundaytime = FridayCollisionList[FridayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinalx(enddaysession, checkdaysession);
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
                            var checkresults2a = getTimeRangeFinalx(enddaysession2a, checkdaysession2a);
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
                            checkedDaysofweek.push({
                                weekday: weekday,
                                scheduledayid: scheduledayidSaturday
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid,
                                scheduledayid: scheduledayidSaturday
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
                var scheduledayidSunday = $('#scheduledayidSun').html();
                x = x + 1;
                if (starttime !== '' && endtime !== '') {
                    $('#errorReport').html('');
                    var starx, starx2a;
                    if (SaturdayCollisionList.length !== 0) {
                        var previousSundaytime = SaturdayCollisionList[SaturdayCollisionList.length - 1].sessiontimeSet;
                        var startdaysession = previousSundaytime.split('-')[0];
                        var enddaysession = previousSundaytime.split('-')[1];
                        var checkdaysession = starttime;
                        var checkresults = getTimeRange(startdaysession, enddaysession, checkdaysession);//getTimeRangeFinalx(enddaysession, checkdaysession);
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
                            var checkresults2a = getTimeRangeFinalx(enddaysession2a, checkdaysession2a);
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
                            checkedDaysofweek.push({
                                weekday: weekday,
                                scheduledayid: scheduledayidSunday
                            });
                            checkedweekdaySessions.push({
                                weekday: weekday,
                                sessiontimeSet: sessiontimeSet,
                                sessiontimeSetid: sessiontimeSetid,
                                scheduledayid: scheduledayidSunday
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
    //-------------Monday- Starts------//
    function removeSetMonSess2(id, sessionid, time) {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Remove Session!',
            content: 'Session ' + time,
            type: 'red',
            typeAnimated: true,
            draggable: true,
            buttons: {
                delete: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $('#' + id).remove();
                        $.ajax({
                            type: 'GET',
                            cache: false,
                            dataType: 'text',
                            data: {sessionidx: sessionid},
                            url: "appointmentandSchedules/deleteDaySession.htm",
                            success: function (data) {
                                //alert(data);
                            }
                        });
                    }
                },
                No: function () {
                }
            }
        });
    }
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
        deletefromJsonObject(MondayCollisionList,id);
    }
    function checkedDateMon(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Monday' && status === 'checked') {
                $("#SetMonAddbtn").html('<button class="btn btn-secondary" onclick="addMondaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                //$("#endDate").prop('disabled', true);
                if (checkedweekdays.has(selectedday)) {
                    checkedweekdays.delete(selectedday);
                } else {
                    checkedweekdays.add(selectedday);
                }
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
    function removeSetTueSess2(id, sessionid, time) {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Remove Session!',
            content: 'Session ' + time,
            type: 'red',
            typeAnimated: true,
            draggable: true,
            buttons: {
                delete: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $('#' + id).remove();
                        $.ajax({
                            type: 'GET',
                            cache: false,
                            dataType: 'text',
                            data: {sessionidx: sessionid},
                            url: "appointmentandSchedules/deleteDaySession.htm",
                            success: function (data) { }
                        });
                    }
                },
                No: function () {
                }
            }
        });
    }
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
        deletefromJsonObject(TuesdayCollisionList,id);
    }
    function checkedDateTue(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Tuesday' && status === 'checked') {
                $("#SetTueAddbtn").html('<button class="btn btn-secondary" onclick="addTuesdaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                // $("#endDate").prop('disabled', true);
                if (checkedweekdays.has(selectedday)) {
                    checkedweekdays.delete(selectedday);
                } else {
                    checkedweekdays.add(selectedday);
                }
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
    function removeSetWedSess2(id, sessionid, time) {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Remove Session!',
            content: 'Session ' + time,
            type: 'red',
            typeAnimated: true,
            draggable: true,
            buttons: {
                delete: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $('#' + id).remove();
                        $.ajax({
                            type: 'GET',
                            cache: false,
                            dataType: 'text',
                            data: {sessionidx: sessionid},
                            url: "appointmentandSchedules/deleteDaySession.htm",
                            success: function (data) { }
                        });
                    }
                },
                No: function () {
                }
            }
        });
    }
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
        deletefromJsonObject(WednesdayCollisionList,id);
    }
    function checkedDateWed(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Wednesday' && status === 'checked') {
                $("#SetWedAddbtn").html('<button class="btn btn-secondary" onclick="addWednesdaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                //$("#endDate").prop('disabled', true);
                if (checkedweekdays.has(selectedday)) {
                    checkedweekdays.delete(selectedday);
                } else {
                    checkedweekdays.add(selectedday);
                }
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
    function removeSetThurSess2(id, sessionid, time) {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Remove Session!',
            content: 'Session ' + time,
            type: 'red',
            typeAnimated: true,
            draggable: true,
            buttons: {
                delete: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $('#' + id).remove();
                        $.ajax({
                            type: 'GET',
                            cache: false,
                            dataType: 'text',
                            data: {sessionidx: sessionid},
                            url: "appointmentandSchedules/deleteDaySession.htm",
                            success: function (data) { }
                        });
                    }
                },
                No: function () {
                }
            }
        });
    }
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
        deletefromJsonObject(ThursdayCollisionList,id);
    }
    function checkedDateThur(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Thursday' && status === 'checked') {
                $("#SetThurAddbtn").html('<button class="btn btn-secondary" onclick="addThursdaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                //  $("#endDate").prop('disabled', true);
                if (checkedweekdays.has(selectedday)) {
                    checkedweekdays.delete(selectedday);
                } else {
                    checkedweekdays.add(selectedday);
                }
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
    function removeSetFriSess2(id, sessionid, time) {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Remove Session!',
            content: 'Session ' + time,
            type: 'red',
            typeAnimated: true,
            draggable: true,
            buttons: {
                delete: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $('#' + id).remove();
                        $.ajax({
                            type: 'GET',
                            cache: false,
                            dataType: 'text',
                            data: {sessionidx: sessionid},
                            url: "appointmentandSchedules/deleteDaySession.htm",
                            success: function (data) { }
                        });
                    }
                },
                No: function () {
                }
            }
        });
    }
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
        deletefromJsonObject(FridayCollisionList,id);
    }
    function checkedDateFri(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Friday' && status === 'checked') {
                $("#SetFriAddbtn").html('<button class="btn btn-secondary" onclick="addFridaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                //$("#endDate").prop('disabled', true);
                if (checkedweekdays.has(selectedday)) {
                    checkedweekdays.delete(selectedday);
                } else {
                    checkedweekdays.add(selectedday);
                }
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
    function removeSetSatSess2(id, sessionid, time) {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Remove Session!',
            content: 'Session ' + time,
            type: 'red',
            typeAnimated: true,
            draggable: true,
            buttons: {
                delete: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $('#' + id).remove();
                        $.ajax({
                            type: 'GET',
                            cache: false,
                            dataType: 'text',
                            data: {sessionidx: sessionid},
                            url: "appointmentandSchedules/deleteDaySession.htm",
                            success: function (data) { }
                        });
                    }
                },
                No: function () {
                }
            }
        });
    }
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
        deletefromJsonObject(SaturdayCollisionList,id);
    }
    function checkedDateSat(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Saturday' && status === 'checked') {
                $("#SetSatAddbtn").html('<button class="btn btn-secondary" onclick="addSaturdaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                //  $("#endDate").prop('disabled', true);
                if (checkedweekdays.has(selectedday)) {
                    checkedweekdays.delete(selectedday);
                } else {
                    checkedweekdays.add(selectedday);
                }
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
    function removeSetSunSess2(id, sessionid, time) {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Remove Session!',
            content: 'Session ' + time,
            type: 'red',
            typeAnimated: true,
            draggable: true,
            buttons: {
                delete: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $('#' + id).remove();
                        $.ajax({
                            type: 'GET',
                            cache: false,
                            dataType: 'text',
                            data: {sessionidx: sessionid},
                            url: "appointmentandSchedules/deleteDaySession.htm",
                            success: function (data) { }
                        });
                    }
                },
                No: function () {
                }
            }
        });
    }
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
        deletefromJsonObject(SundayCollisionList,id);
    }
    function checkedDateSun(status, selectedday) {
        var enddateInput = $('#endDate').val();
        if (enddateInput !== '') {
            if (selectedday === 'Sunday' && status === 'checked') {
                $("#SetSunAddbtn").html('<button class="btn btn-secondary" onclick="addSundaySchedules()"><i class="fa fa-plus-circle"></i></button>');
                // $("#endDate").prop('disabled', true);
                if (checkedweekdays.has(selectedday)) {
                    checkedweekdays.delete(selectedday);
                } else {
                    checkedweekdays.add(selectedday);
                }
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
        $('#saveSchedule').hide();
        $('#schedulestate').val($('#scheduleqw').html());
    }
    function removeDuplicates(jsonall) {
        var arr = [], collection = [];
        $.each(jsonall, function (index, value) {
            if ($.inArray(value.weekday, arr) == -1) {
                arr.push(value.weekday);
                collection.push(value);
            }
        });
        return collection;
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
    function  getTimeRangeFinalx(prev, current) {
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
    function clearcollisionsx() {
        SundayCollisionList = [];
        MondayCollisionList = [];
        TuesdayCollisionList = [];
        WednesdayCollisionList = [];
        ThursdayCollisionList = [];
        FridayCollisionList = [];
        SaturdayCollisionList = [];
    }
    var temp = [];
    function deletefromJsonObject(JsonObj,id) {
        //@Author Andrew-k for simplicity
        for (index in JsonObj) {
            var res = JsonObj[index];
            if (id === res["sessiontimeSetid"]) {

            } else {
                temp.push({
                    sessiontimeSet: res["sessiontimeSet"],
                    sessiontimeSetid: res["sessiontimeSetid"]
                });
            }
        }
        JsonObj = [];
        for (index1 in temp) {
            var res1 = temp[index1];
            JsonObj.push({
                sessiontimeSet: res1["sessiontimeSet"],
                sessiontimeSetid: res1["sessiontimeSetid"]
            });

        }
        temp = [];
        if (parseInt(JsonObj.length) === 0) {
            $('#saveSchedule').hide();
        } else {
            $('#saveSchedule').show();
        }
    }
</script>