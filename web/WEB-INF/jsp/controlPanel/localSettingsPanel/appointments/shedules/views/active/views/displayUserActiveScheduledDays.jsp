<%-- 
    Document   : displayUserActiveScheduledDays
    Created on : May 24, 2018, 5:59:21 PM
    Author     : user
--%>
<%@include file="../../../../../../../include.jsp" %>
<style>
    #testtable td{padding:4px;}
</style>
<div class="tile-body" id="changetableview">
    <div id="">
        <table class="table table-hover table-bordered" id="scheduleweektype">
            <thead>
                <tr>
                    <th>No:</th>
                    <th class="center">Schedule Day</th>
                    <th class="center">Weekday</th>
                    <th class="center">Schedule Day Session</th>
                </tr>
            </thead>
            <tbody>
                <% int g = 1;%>
                <c:forEach items="${staffweeksdayscheduleslist}" var="a2">
                    <tr>
                        <td data-label="No:"><%=g++%></td>
                        <td data-label="Schedule Day">${a2.scheduleDate}</td>
                        <td data-label="Weekday">${a2.weekday}</td>
                        <td data-label="Schedule Day Session" class="center"><button class="btn btn-sm btn-primary" data-date="${a2.scheduleDate}" data-day="${a2.weekday}" id="${a2.scheduleDayzid}" onclick="viewDaySessions(this.id, $(this).attr('data-day'), $(this).attr('data-date'));"> <i class="fa fa-fw fa-lg fa-dedent"></i></button></td>                     
                    </tr> 
                </c:forEach>                                                
            </tbody>
        </table>
    </div>
</div>   
<div id="scheduledlistcontent" class="hidedisplaycontent">
    <div id="showcontentsSchedules"></div>
</div>
<script>
    $(document).ready(function () {
    $('#scheduleweektype').DataTable();
    });
    
    function viewDaySessions(scheduledaysid, day, date) {
    var jsonDaySessions = ${jsonweekDaySessions};
   // console.log(jsonDaySessions);
   $('#showcontentsSchedules').html('');
    var count = 0;
    for (var v in jsonDaySessions) {
     var weekDayzid = jsonDaySessions[v].weekdayid;
     var startTime = jsonDaySessions[v].starttime;
     var endTime = jsonDaySessions[v].endtime;       
        if (parseInt(scheduledaysid) === parseInt(weekDayzid)) { 
           var count = parseInt(count)+ parseInt(1);
        //console.log(scheduledaysid + '-------' + weekDayzid + '-----Start----' + startTime + '----End-------' + endTime);
        $('#showcontentsSchedules').append('<div>' +
               '<table id="testtable"><tbody>' +
               '<tr><td><strong>'+count+'): Weekday</strong></td>' +
               '<td>:' + day + '</td></tr>' +
               '<tr><td><strong>Date</strong></td>' +
               '<td>:' + date + '</td></tr>' +
               '<tr><td><strong>Start Time</strong></td>' +
               '<td class="text-success"><b>:' + startTime + '</b></td></tr>' +
               '<tr><td><strong>End Time</strong></td>' +
               '<td class="text-danger"><b>:' + endTime + '</b></td></tr>' +
               '</tbody></table>' +
            '</div><hr>');  
        }
        //$('#showcontentsSchedules').html('<div><strong class="text-danger">No Session Set Yet!!!</strong></div>');
        
     }
    var showListScheduleALL = $('#showcontentsSchedules').html();
    $.dialog({
        icon: 'fa fa-calendar-check-o',
        title: 'Day Sessions',
        content: ''+showListScheduleALL,
        type:'purple'
    });
    }
</script>