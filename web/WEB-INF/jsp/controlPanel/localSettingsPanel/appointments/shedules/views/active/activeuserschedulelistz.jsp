<%-- 
    Document   : activeschedulelistz
    Created on : May 23, 2018, 1:04:21 PM
    Author     : user
--%>
<%@include file="../../../../../../include.jsp" %>
<fieldset>
    <div id="contentalldisplay">
        <h6>Active Schedules for <strong class="text-success" id="staffNam"> ${activeStaffScheduleMap.StaffName}</strong>  </h6>
        <div class="tile-body" id="changetableview"><span id="staffiDz" class="hidedisplaycontent">${activeStaffScheduleMap.staffid}</span>
            <div id="testshow1">
                <table class="table table-hover table-bordered" id="schedulestafftype">
                    <thead>
                        <tr>
                            <th>No:</th>
                            <th class="center">Start Date</th>
                            <th class="center">End Date</th>
                            <th class="center">Schedule Days</th>
                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEACTIVESTAFFSCHEDULE')"> 
                             <th class="center"> Manage </th>
                             </security:authorize>
                        </tr>
                    </thead>
                    <tbody>                        
                        <% int q = 1;%>
                        <c:forEach items="${activeStaffSchedules}" var="a1">
                            <tr>
                                <td data-label="No:"><%=q++%></td>
                                <td data-label="Start Date">${a1.startdate}</td>
                                <td data-label="End Date">${a1.enddate}</td>
                                <td data-label="Schedule Days" class="center"><button class="btn btn-sm btn-primary"  data-id="${a1.scheduleid}" data-start="${a1.startdate}"  data-end="${a1.enddate}" onclick="viewCalendarRange($(this).attr('data-id'), $(this).attr('data-start'), $(this).attr('data-end'));"> <i class="fa fa-fw fa-lg fa-dedent"></i></button></td>                                
                              <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEPROCUREMENTPLAN')"> 
                                  <c:if test="${activeStaffScheduleMap.managedelete == true}">
                                    <td data-label="Manage" class="center"><button class="btn btn-sm btn-primary" data-id="${a1.scheduleid}" data-start="${a1.startdate}"  data-end="${a1.enddate}" data-state="${a1.schedulestate}" onclick="showStaffUpdate($(this).attr('data-id'), $(this).attr('data-start'), $(this).attr('data-end'), $(this).attr('data-state'))"><i class="fa fa-fw  fa-lg fa-edit"></i></button> | <button class="btn btn-sm btn-primary " data-start="${a1.startdate}"  data-end="${a1.enddate}" id="${a1.scheduleid}" onclick="deleteStaffSchedule(this.id, $(this).attr('data-start'), $(this).attr('data-end'))"><i class="fa fa-fw  fa-lg fa-trash"></i></button></td> 
                                </c:if>
                                <c:if test="${activeStaffScheduleMap.managedelete == false}">
                                    <td data-label="Manage" class="center"><button class="btn btn-sm btn-primary" data-id="${a1.scheduleid}" data-start="${a1.startdate}"  data-end="${a1.enddate}" data-state="${a1.schedulestate}" onclick="showStaffUpdate($(this).attr('data-id'), $(this).attr('data-start'), $(this).attr('data-end'), $(this).attr('data-state'))"><i class="fa fa-fw  fa-lg fa-edit"></i></button></td> 
                                </c:if> 
                                </security:authorize>
                            </tr> 
                        </c:forEach>                                              
                    </tbody>
                </table>
            </div>
            <div id="testshow2" class="hidedisplaycontent">
                <button onclick="gobacktoschedulerange()" class="btn btn-secondary"><i class="fa fa-arrow-left"></i>Back</button><br><br>
                <div id="showRangedates"></div>
            </div>  
        </div> 
    </div> 
    <div id="showUpdateSchedule3" class="hidedisplaycontent">          
        <div id="showupdatepage">Loading content Please wait..................</div>
    </div>
</fieldset> 
<script>
    $(document).ready(function () {
        $('#schedulestafftype').DataTable();
    });
    function showStaffUpdate(schedulesid, start, end,state) {
        var staffnum = $('#staffNam').html();
        var staffidz = $('#staffiDz').html();
       // console.log(schedulesid);
        //console.log(staffidz);
       // console.log(staffnum);
        //console.log(start);
       // console.log(end);
       $.confirm({
            title: 'Modify Schedule!',
            content: 'Schedule from ' + start + ' to ' + end,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                delete: {
                    text: 'Yes',
                    btnClass: 'btn-primary',
                    action: function () {
                        $('#showUpdateSchedule3').show();
                        $('#contentalldisplay').hide();
                        ajaxSubmitDataNoLoader('appointmentandSchedules/showupdatingPage.htm', 'showupdatepage', 'staffid=' + staffidz + '&staffname=' + staffnum + '&schedulesid=' + schedulesid + '&start=' + start + '&end=' + end + '&state='+state+'&act=a&&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                },
                No: function () {
                }
            }
        });
    }
    function deleteStaffSchedule(scheduleid, start, end) {
        //console.log(scheduleid);Delete Schedule from '+start+' to '+end,
        $.confirm({
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
                                    var staffid = $('#staffiDz').html();                                   
                                    $.toast({
                                        heading: 'Success',
                                        text: 'Schedule Deleted Successfully',
                                        icon: 'success',
                                        hideAfter: 2000,
                                        position: 'bottom-center'
                                    });
                                     ajaxSubmitData('appointmentandSchedules/activeuserschedules.htm', 'activeContentdisplay', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                     window.location = '#close';
                                    //ajaxSubmitDataNoLoader('appointmentandSchedules/activeuserschedulelist.htm', 'show1', 'staffid=' + staffid + '&act=a&&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
   
    function gobacktoschedulerange() {
        $('#testshow1').show();
        $('#testshow2').hide();
    }
    var datesRange = [];
    function viewCalendarRange(scheduleid, startD, endD) {
        $('#testshow1').hide();
        $('#testshow2').show();
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
                datesRange.push({
                    day: 'Sunday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(1)) {
                //console.log(dayNumber + '---Monday--' + givendate);
                datesRange.push({
                    day: 'Monday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(2)) {
                //console.log(dayNumber + '-- Tuesday---' + givendate);
                datesRange.push({
                    day: 'Tuesday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(3)) {
                //console.log(dayNumber + '---Wednesday--' + givendate);
                datesRange.push({
                    day: 'Wednesday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(4)) {
                // console.log(dayNumber + '-- Thursday---' + givendate);
                datesRange.push({
                    day: 'Thursday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(5)) {
                // console.log(dayNumber + '---Friday--' + givendate);
                datesRange.push({
                    day: 'Friday',
                    userdate: givendate
                });
            }
            if (parseInt(dayNumber) === parseInt(6)) {
                //console.log(dayNumber + '---Saturday--' + givendate);
                datesRange.push({
                    day: 'Saturday',
                    userdate: givendate
                });
            }

        }
        //console.log(datesRange);
        var datesUser = JSON.stringify(datesRange);
        //console.log(datesUser);
        ajaxSubmitDataNoLoader('appointmentandSchedules/viewActiveScheduleday.htm', 'showRangedates', 'act=a&dateSchedules=' + datesUser + ' &scheduleid=' + scheduleid + ' &c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');             
        datesRange = [];
    }
</script>      