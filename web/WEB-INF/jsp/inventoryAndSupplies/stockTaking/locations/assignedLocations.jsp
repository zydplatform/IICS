<%-- 
    Document   : assignedLocations
    Created on : 28-May-2018, 14:35:15
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty activities}">
    <div class="tile">
        <div class="row">
            <div class="col-md-4 col-sm-4">
                <form action="" class="formName">
                    <div class="form-group">
                        <select class="form-control" id="activity-select">
                            <c:forEach items="${activities}" var="activity">
                                <option value="${activity.id}" data-time="${activity.end}" id="act${activity.id}">${activity.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="col-md-8 col-sm-8 right" id="timer">
                
            </div>
        </div>
        <div class="row">
            <div class="col-md-12" id="staffCells">

            </div>
        </div>
    </div>
</c:if>
<c:if test="${empty activities}">
    <div class="row">
        <div class="col-md-12 text-center">
            <h5>
                No running stock taking activities.
            </h5>
        </div>
    </div>
</c:if>
<c:if test="${not empty activities}">
    <script type="text/javascript">
        var serverDate = '${serverdate}';
        var activityid = 0;
        $(document).ready(function () {
            $('#activity-select').select2();
            $('.select2').css('width', '100%');
            activityid = $('#activity-select').val();
            ajaxSubmitData('stock/fetchStaffCellAllocation.htm', 'staffCells', '&activityid=' + activityid, 'POST');
            ajaxSubmitData('stock/fetchCounter.htm', 'timer', '&time=' + $('#act' + $('#activity-select').val()).data('time'), 'POST');
            $('#activity-select').change(function () {
                $('#staffCells').html('');
                activityid = $('#activity-select').val();
                ajaxSubmitData('stock/fetchStaffCellAllocation.htm', 'staffCells', '&activityid=' + activityid, 'POST');
                ajaxSubmitData('stock/fetchCounter.htm', 'timer', '&time=' + $('#act' + $('#activity-select').val()).data('time'), 'POST');
            });
        });

        function getTimeRemaining(endtime) {
            var t = Date.parse(endtime) - Date.parse(new Date(serverDate)) + 1000 * 60 * 60 * 24;
            var seconds = Math.floor((t / 1000) % 60);
            var minutes = Math.floor((t / 1000 / 60) % 60);
            var hours = Math.floor((t / (1000 * 60 * 60)) % 24);
            var days = Math.floor(t / (1000 * 60 * 60 * 24));
            return {
                'total': t,
                'days': days,
                'hours': hours,
                'minutes': minutes,
                'seconds': seconds
            };
        }

        function initializeClock(id, endtime) {
            var clock = document.getElementById(id);
            var daysSpan = clock.querySelector('.days');
            var hoursSpan = clock.querySelector('.hours');
            var minutesSpan = clock.querySelector('.minutes');
            var secondsSpan = clock.querySelector('.seconds');

            function updateClock() {
                var t = getTimeRemaining(endtime);

                daysSpan.innerHTML = t.days;
                hoursSpan.innerHTML = ('0' + t.hours).slice(-2);
                minutesSpan.innerHTML = ('0' + t.minutes).slice(-2);
                secondsSpan.innerHTML = ('0' + t.seconds).slice(-2);

                if (t.total <= 0) {
                    clearInterval(timeinterval);
                }
            }

            updateClock();
            var timeinterval = setInterval(updateClock, 1000);
        }
    </script>
</c:if>