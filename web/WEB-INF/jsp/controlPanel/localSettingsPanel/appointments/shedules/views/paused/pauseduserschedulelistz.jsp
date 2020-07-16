<%-- 
    Document   : pauseduserschedulelistz
    Created on : May 24, 2018, 1:29:55 PM
    Author     : user
--%>

<%@include file="../../../../../../include.jsp" %>
<fieldset>
    <h6>Paused Schedules for <strong class="text-success"> ${pausedStaffSchedulesMap.StaffName}</strong>  </h6> 
    <div class="tile-body" id="changetableview">
        <div id="testshow1a">
            <table class="table table-hover table-bordered" id="schedulestafftypepaused">
                <thead>
                    <tr>
                        <th>No:</th>
                        <th class="center">Start Date</th>
                        <th class="center">End Date</th>
                        <th class="center">Schedule Days</th>
                       <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_CHANGEPAUSEDSTAFFSCHEDULE')"> 
                          <th class="center"> Change Schedule Status </th>
                       </security:authorize>
                    </tr>
                </thead>
                <tbody>
                    <% int q = 1;%>
                    <c:forEach items="${pausedStaffSchedules}" var="a1">
                        <tr>
                            <td data-label="No:"><%=q++%></td>
                            <td data-label="Start Date">${a1.startdate}</td>
                            <td data-label="End Date">${a1.enddate}</td>
                            <td data-label="Schedule Days" class="center"><button class="btn btn-sm btn-primary" data-id="${a1.scheduleid}" data-start="${a1.startdate}"  data-end="${a1.enddate}" onclick="viewCalendarRangePaused($(this).attr('data-id'), $(this).attr('data-start'), $(this).attr('data-end'));"><i class="fa fa-fw fa-lg fa-dedent"></i></button></td>
                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEACTIVESTAFFSCHEDULE')"> 
                            <td data-label=" Change Schedule Status" class="center"><button class="btn btn-sm btn-success" data-end="${a1.enddate}" data-start="${a1.startdate}" data-state="${a1.schedulestate}" id="${a1.scheduleid}" onclick="changeSchedulestatus(this.id, $(this).attr('data-state'), $(this).attr('data-start'), $(this).attr('data-end'))"><i class="fa fa-undo"></i></button></td> 
                             </security:authorize>
                            </tr> 
                    </c:forEach>                                                
                </tbody>
            </table>
        </div> 
        <div id="testshow2a" class="hidedisplaycontent">
            <button onclick="gobacktoschedulerangePaused()" class="btn btn-secondary"><i class="fa fa-arrow-left"></i>Back</button><br><br>
            <div id="showRangedatespaused"></div>
        </div>  
    </div>
</fieldset> 
<script>
    $(document).ready(function () {
        $('#schedulestafftypepaused').DataTable();
    });
    function changeSchedulestatus(id, state, start, end) {
        $.confirm({
            icon: 'fa fa-undo',
            title: 'Change Schedule Status!',
            content: '' + start + ' - ' + end + ' From <strong class="text-danger">' + state + '</strong> to <strong class="text-success">Active</strong>',
            type: 'green',
            typeAnimated: true,
            buttons: {
                Yes: {
                    text: 'Yes',
                    btnClass: 'btn-sm btn-success',
                    action: function () {
                        $.ajax({
                            type: 'GET',
                            cache: false,
                            dataType: 'text',
                            data: {scheduleid: id},
                            url: "appointmentandSchedules/updateschedulestatus.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.toast({
                                        heading: 'Success',
                                        text: 'Schedule Status Updated Successfully',
                                        icon: 'success',
                                        hideAfter: 2000,
                                        position: 'bottom-center'
                                    });
                                    ajaxSubmitData('appointmentandSchedules/pauseduserschedules.htm', 'pausedContentdisplay', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                } else {
                                    $.toast({
                                        heading: 'Error',
                                        text: 'An unexpected error occured while trying to Update Schedule Status',
                                        icon: 'error',
                                        hideAfter: 2000,
                                        position: 'bottom-center'
                                    });
                                }
                                window.location = '#close';
                            }
                        });
                    }
                },
                No: function () {
                }
            }
        });
    }
    function gobacktoschedulerangePaused() {
        $('#testshow1a').show();
        $('#testshow2a').hide();
    }
    var datesRangePaused = [];
    function viewCalendarRangePaused(scheduleid, startD, endD) {
        $('#testshow1a').hide();
        $('#testshow2a').show();
        var endx = endD.split("/");
        var startx = startD.split("/");
        var datestart = new Date(startx[2], startx[1] - 1, startx[0]);
        var dateEnd = new Date(endx[2], endx[1] - 1, endx[0]);
        var start = datestart,
                end = dateEnd,
                currentDate = new Date(start),
                between = [];
        while (currentDate <= end) {
            var x = new Date(currentDate);
            var weekdayNumber = x.getDay();
            var monthk = parseInt(x.getMonth()) + parseInt(1);
            if (monthk < 10) {
                var someFormattedxDate = x.getDate() + '/0' + monthk + '/' + x.getFullYear();
            } else {
                var someFormattedxDate = x.getDate() + '/' + monthk + '/' + x.getFullYear();

            }
            between.push({
                weekdayxNumber: weekdayNumber,
                dates: someFormattedxDate
            });
            currentDate.setDate(currentDate.getDate() + 1);
        }
        var selectedrangedays = between;
        // $('#showRangedates').html(selectedrangedays);
        for (var v in selectedrangedays) {
            var dayNumber = selectedrangedays[v].weekdayxNumber;
            var givendate = selectedrangedays[v].dates;

            if (parseInt(dayNumber) === parseInt(0)) {
                //console.log(dayNumber + '-- Sunday---' + givendate);
                datesRangePaused.push({
                    day: 'Sunday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(1)) {
                //console.log(dayNumber + '---Monday--' + givendate);
                datesRangePaused.push({
                    day: 'Monday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(2)) {
                //console.log(dayNumber + '-- Tuesday---' + givendate);
                datesRangePaused.push({
                    day: 'Tuesday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(3)) {
                //console.log(dayNumber + '---Wednesday--' + givendate);
                datesRangePaused.push({
                    day: 'Wednesday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(4)) {
                // console.log(dayNumber + '-- Thursday---' + givendate);
                datesRangePaused.push({
                    day: 'Thursday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(5)) {
                // console.log(dayNumber + '---Friday--' + givendate);
                datesRangePaused.push({
                    day: 'Friday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(6)) {
                //console.log(dayNumber + '---Saturday--' + givendate);
                datesRangePaused.push({
                    day: 'Saturday',
                    userdate: givendate
                });
            }

        }
        //console.log(datesRange);
        var datesUser = JSON.stringify(datesRangePaused);
        //console.log(datesUser);
        ajaxSubmitDataNoLoader('appointmentandSchedules/viewActiveScheduleday.htm', 'showRangedatespaused', 'act=a&dateSchedules=' + datesUser + ' &scheduleid=' + scheduleid + ' &c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        datesRangePaused = [];
    }
</script>      