<%-- 
    Document   : timer
    Created on : 28-May-2018, 17:49:38
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<div id="clockdiv">
    <div>
        <span class="days"></span>
        <div class="smalltext">Days</div>
    </div>
    <div>
        <span class="hours"></span>
        <div class="smalltext">Hours</div>
    </div>
    <div>
        <span class="minutes"></span>
        <div class="smalltext">Minutes</div>
    </div>
    <div>
        <span class="seconds"></span>
        <div class="smalltext">Seconds</div>
    </div>
</div>
<script type="text/javascript">
    var activityid = 0;
    $(document).ready(function () {
        var deadline = new Date(parseInt(${time}));
        initializeClock('clockdiv', deadline);
    });
</script>