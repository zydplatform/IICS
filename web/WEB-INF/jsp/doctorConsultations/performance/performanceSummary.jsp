<%-- 
    Document   : performanceSummary
    Created on : Oct 17, 2018, 4:14:07 PM
    Author     : IICS
--%>
<%@include file="../../include.jsp"%>
<div class="row">
    <div class="col-md-12 col-sm-12">
        <div class="card border-top-purple border-top-3 border-bottom-success border-bottom-3 box-shadow-0">
            <div class="card-header">
                <h3>
                    <strong>
                        <%--${dailySummary.serviced + dailySummary.canceled + dailySummary.unattended}--%>                        
                        <fmt:formatNumber maxFractionDigits="0" type="number" value="${dailySummary.serviced + dailySummary.canceled + dailySummary.unattended}"/>
                    </strong> Patients Received
                </h3>
            </div>
            <div id="current-fy" class="card-content collapse show">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4 col-sm-4">
                            <div class="card border-success text-center bg-transparent">
                                <div class="card-content">
                                    <div class="card-body pt-3">
                                        <h5 class="card-text">
                                            <strong>Serviced</strong>
                                        </h5>
                                        <button id="editStartCurrent" class="btn btn-outline-success">
                                            <strong>${dailySummary.serviced}</strong>
                                        </button>
                                        <span class="success">
                                            <fmt:formatNumber maxFractionDigits="0" type="number" value="${(dailySummary.serviced/(dailySummary.serviced + dailySummary.canceled + dailySummary.unattended))*100}" pattern = "#,###"/>%
                                        </span>                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-4">
                            <div class="card border-info text-center bg-transparent">
                                <div class="card-content">
                                    <div class="card-body pt-3">
                                        <h5 class="card-text">
                                            <strong>Canceled</strong>
                                        </h5>
                                        <button class="btn btn-outline-info">
                                            <strong>${dailySummary.canceled}</strong>
                                        </button>
                                        <span class="danger">
                                            <fmt:formatNumber maxFractionDigits="0" type="number" value="${(dailySummary.canceled/(dailySummary.serviced + dailySummary.canceled + dailySummary.unattended))*100}"/>%
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-4">
                            <div class="card border-danger text-center bg-transparent">
                                <div class="card-content">
                                    <div class="card-body pt-3">
                                        <h5 class="card-text">
                                            <strong>Un-Attended</strong>
                                        </h5>
                                        <button class="btn btn-outline-danger">
                                            <strong>${dailySummary.unattended}</strong>
                                        </button>
                                        <span class="danger">
                                            <fmt:formatNumber maxFractionDigits="0" type="number" value="${(dailySummary.unattended/(dailySummary.serviced + dailySummary.canceled + dailySummary.unattended))*100}"/>%
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div><br/>
<div class="row">
    <div class="col-md-12">
        <div class="card border-top-purple border-top-3">
            <div class="card-content">
                <div class="row">
                    <div class="col-md-5 col-sm-12">
                        <div class="card-header text-center">
                            <h4 class="card-title">Visit Outcomes</h4>
                        </div>
                        <div class="card-body">
                            <div class="chartjs">
                                <div id="donut-chartDaily"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="c0l-md-4 col-sm-4">
                                <h6 class="text-success">
                                    <i class="fa fa-circle"></i>
                                    <span>Serviced</span>
                                </h6>
                            </div>
                            <div class="c0l-md-4 col-sm-4">
                                <h6 class="text-info">
                                    <i class="fa fa-circle"></i>
                                    <span>Canceled</span>
                                </h6>
                            </div>
                            <div class="c0l-md-4 col-sm-4">
                                <h6 class="text-danger">
                                    <i class="fa fa-circle"></i>
                                    <span>Unattended</span>
                                </h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-7 col-sm-12">
                        <div class="card-header text-center">
                            <h4 class="card-title">Staff Performance</h4>
                        </div>
                        <div class="card-body">
                            <div class="chartjs">
                                <div id="dailyPerformance" class="height-300"></div>
                            </div>
                        </div>
                        <ul class="list-inline text-center m-0">
                            <li class="mr-1">
                                <h6 class="text-success">
                                    <i class="fa fa-circle"></i>
                                    <span>Total Patients Seen</span>
                                </h6>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <div class="card-header text-center">
                            <h4 class="card-title">Staff Performance</h4>
                        </div>
                        <div class="card-body">
                            <table class="table table-hover table-bordered table-striped" id="patients">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Staff</th>
                                        <th>Staff No.</th>
                                        <th>Initials</th>
                                        <th>Designation</th> <!---->
                                        <th>Timeline</th>
                                        <th>Time On Task</th>
                                        <th>Patients Seen</th>
                                        <th>Rate</th>
                                    </tr>
                                </thead>
                                <tbody id="bodyItems">
                                    <% int k = 1;%>
                                    <c:forEach items="${dailyPerformance}" var="staff">
                                        <tr>
                                            <td><%=k++%></td>
                                            <td>${staff.names}</td>
                                            <td>${staff.stno}</td>
                                            <td>${staff.user}</td>
                                            <td>${staff.designation}</td> <!---->
                                            <td>
                                                <span class="badge badge-patientinfo">${staff.first}</span>
                                                <br/><span class="badge badge-danger">${staff.last}</span>
                                            </td>
                                            <td>
                                                ${staff.timeontask}
                                            </td>
                                            <td>
                                                <button class="btn btn-outline-info btn-sm">
                                                    <strong>${staff.patients} of ${dailySummary.serviced + dailySummary.unattended}</strong>
                                                </button>
                                                <span class="danger">
                                                    <fmt:formatNumber maxFractionDigits="0" type="number" value="${(staff.patients/(dailySummary.serviced + dailySummary.unattended))*100}"/>%
                                                </span>
                                            </td>
                                            <td class="right">${staff.rate}&nbsp;Mins/Patient</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        var data2 = ${dailyPlots};
        var lineProperties2 = {
            element: 'dailyPerformance',
            data: data2,
            xkey: 'user',
            ykeys: ['patients'],
            labels: ['Patients Seen'],
            barGap: 4,
            barSizeRatio: .3,
            gridTextColor: '#bfbfbf',
            gridLineColor: '#E4E7ED',
            numLines: 6,
            gridtextSize: 14,
            resize: !0,
            barColors: ['#28a745'],
            xLabelAngle: 20,
            hideHover: 'auto'
        };
        Morris.Bar(lineProperties2);

        var donutProperties2 = {
            element: 'donut-chartDaily',
            data: [
                {label: 'Serviced', value: ${dailySummary.serviced}},
                {label: 'Canceled', value: ${dailySummary.canceled}},
                {label: 'Unattended', value: ${dailySummary.unattended}}
            ],
            resize: !0,
            colors: ['#28a745', '#00A5A8', '#FF4558']
        };
        Morris.Donut(donutProperties2);
    });
</script>