<%-- 
    Document   : expireduserschedulelistz
    Created on : May 24, 2018, 3:02:09 PM
    Author     : user
--%>

<%@include file="../../../../../../include.jsp" %>
<fieldset>
    <h6>Expired Schedules for <strong class="text-success"> ${expiredStaffSchedulesMap.StaffName}</strong>  </h6>
    <div class="tile-body" id="changetableview"><span id="staffiDzk" class="hidedisplaycontent">${expiredStaffSchedulesMap.staffid}</span>
        <div id="testshow1b">
            <table class="table table-hover table-bordered" id="schedulestafftypeExpired">
                <thead>
                    <tr>
                        <th>No:</th>
                        <th class="center">Start Date</th>
                        <th class="center">End Date</th>
                        <th class="center">Schedule Days</th>
                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_REMOVESTAFFSCHEDULEHISTORY')"> 
                         <c:if test="${expiredStaffSchedulesMap.managedelete == true}">
                            <th class="center"> Remove </th>
                        </c:if>   
                          </security:authorize>
                    </tr>
                </thead>
                <tbody>
                    <% int q = 1;%>
                    <c:forEach items="${expiredStaffSchedules}" var="a1">
                        <tr>
                            <td data-label="No:"><%=q++%>${a1.scheduleid}</td>
                            <td data-label="Start Date">${a1.startdate} </td>
                            <td data-label="End Date">${a1.enddate}</td>
                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_REMOVESTAFFSCHEDULEHISTORY')"> 
                            <td data-label="Schedule Days" class="center"><button class="btn btn-sm btn-primary" data-id="${a1.scheduleid}" data-start="${a1.startdate}"  data-end="${a1.enddate}" onclick="viewCalendarRangeExpired($(this).attr('data-id'), $(this).attr('data-start'), $(this).attr('data-end'));"> <i class="fa fa-fw fa-lg fa-dedent"></i></button></td>
                            <c:if test="${expiredStaffSchedulesMap.managedelete == true}">
                                <td data-label="Remove" class="center"><button class="btn btn-sm btn-primary" data-start="${a1.startdate}"  data-end="${a1.enddate}" id="${a1.scheduleid}" onclick="deleteStaffScheduleExpired(this.id, $(this).attr('data-start'), $(this).attr('data-end'))"><i class="fa fa-fw  fa-lg fa-trash-o"></i></button></td>  
                            </c:if>  
                          </security:authorize>
                        </tr> 
                    </c:forEach>                                                
                </tbody>
            </table>
        </div> 
        <div id="testshow2b" class="hidedisplaycontent">
            <button onclick="gobacktoschedulerangeExpired()" class="btn btn-secondary"><i class="fa fa-arrow-left"></i>Back</button><br><br>
            <div id="showRangedatesexpired"></div>
        </div> 
    </div>
</fieldset> 
<script>
    $(document).ready(function () {
        $('#schedulestafftypeExpired').DataTable();
    });
    function deleteStaffScheduleExpired(scheduleid, start, end) {
        $.confirm({
            icon:'fa fa-warning',
            title: 'Do you wish to continue? ',
            content: 'Delete Schedule from ' + start + ' to ' + end,
            type: 'red',
            typeAnimated: true,
            buttons: {
                delete: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'GET',
                            cache: false,
                            dataType: 'text',
                            data: {scheduleid: scheduleid},
                            url: "appointmentandSchedules/deleteStaffactiveSchedule.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    var staffid = $('#staffiDzk').html();    
                                    $.toast({
                                        heading: 'Success',
                                        text: 'Schedule Deleted Successfully',
                                        icon: 'success',
                                        hideAfter: 2000,
                                        position: 'bottom-center'
                                    }); 
                                    ajaxSubmitData('appointmentandSchedules/expireduserschedules.htm', 'expiredContentdisplay', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    window.location = '#close';
                                     //ajaxSubmitDataNoLoader('appointmentandSchedules/expireduserschedulelist.htm', 'show3', 'staffid='+staffid+'&act=a&&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');                                 
                                } 
                            }
                        });
                    }
                },
                No: function () {
                }
            }
        });
    }
    function gobacktoschedulerangeExpired() {
        $('#testshow1b').show();
        $('#testshow2b').hide();
    }
    var datesRangeExpired = [];
    function viewCalendarRangeExpired(scheduleid, startD, endD) {
        $('#testshow1b').hide();
        $('#testshow2b').show();
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
                datesRangeExpired.push({
                    day: 'Sunday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(1)) {
                //console.log(dayNumber + '---Monday--' + givendate);
                datesRangeExpired.push({
                    day: 'Monday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(2)) {
                //console.log(dayNumber + '-- Tuesday---' + givendate);
                datesRangeExpired.push({
                    day: 'Tuesday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(3)) {
                //console.log(dayNumber + '---Wednesday--' + givendate);
                datesRangeExpired.push({
                    day: 'Wednesday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(4)) {
                // console.log(dayNumber + '-- Thursday---' + givendate);
                datesRangeExpired.push({
                    day: 'Thursday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(5)) {
                // console.log(dayNumber + '---Friday--' + givendate);
                datesRangeExpired.push({
                    day: 'Friday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(6)) {
                //console.log(dayNumber + '---Saturday--' + givendate);
                datesRangeExpired.push({
                    day: 'Saturday',
                    userdate: givendate
                });
            }

        }
        //console.log(datesRange);
        var datesUser = JSON.stringify(datesRangeExpired);
        //console.log(datesUser);
        ajaxSubmitDataNoLoader('appointmentandSchedules/viewActiveScheduleday.htm', 'showRangedatesexpired', 'act=a&dateSchedules=' + datesUser + ' &scheduleid=' + scheduleid + ' &c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        datesRangeExpired = [];
    }
</script>      