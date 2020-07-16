<%-- 
    Document   : visitDetails
    Created on : Nov 7, 2018, 11:42:52 AM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<style>
    .panel-group {
        padding-top: 0px;
    }
    .panel-default {
        border-radius: 0;
        border: none;
        background: none;
        margin-bottom: 0;
        padding-bottom: 2px;
    }
    .panel-default > .panel-heading {
        border: none;
        background: none;
        padding: 0;
    }
    .panel-default > .panel-heading + .panel-collapse .panel-body {
        border: none;
        padding: 0 0 0 32px;
    }
    .panel-default h5 {
        font: 300 19px "Open Sans", Arial, sans-serif;
        padding: 0;
        margin: 0 0 5px;
    }
    .panel-group .panel+.panel {
        margin-top: 15px;
    }
    .panel-default .accordion-toggle:before {
        content: "";
        width: 21px;
        height: 21px;
        display: inline-block;
        background: #e54a1a url(http://keenthemes.com/assets/bootsnipp/toggle-icons.png) no-repeat 6px 10px;
        border-radius: 50%;
        margin-right: 10px;
        position: relative;
        top: 4px;
    }
    .panel-default .collapsed:before {
        background: #495764 url(http://keenthemes.com/assets/bootsnipp/toggle-icons.png) no-repeat 6px -148px;
    }
    .panel-default .panel-title:hover .collapsed:before {
        background-color: #e54a1a;
    }
    .panel-default .accordion-toggle,
    .panel-default .accordion-toggle:focus,
    .panel-default .accordion-toggle:hover,
    .panel-default .accordion-toggle:active {
        color: #1ea9e3;
        text-decoration: none;
    }
    .panel-default .collapsed {
        color: #5f6f7e;
    }

    /*    list items*/
    .list-display li {
        margin-bottom:.4rem;
        font-size:1.1rem;
    }
    .list-checkmarks {
        padding-left:1.5rem;
    }
    .list-checkmarks li {
        list-style-type:none;
        padding-left:1rem;
    }
    .list-checkmarks li:before {    
        font-family: 'FontAwesome';
        content: "\f00c";
        margin:0 10px 0 -28px;
        color: #17aa1c;
    }
    table tr th, table tr td {
        max-width:100%;
        white-space:nowrap;
    }
    a.reasonDetails{
        color: #0000ff;
        font-weight: bold;
    }
</style>
<fieldset>
    <legend>
        <span onclick="patientFacilityVisits();" class="badge icon-custom"><i class="fa fa-backward"> &nbsp;Back</i> </span>
    </legend>
    <div class="row">
        <div class="col-md-4">
            <div class="form-group bs-component">
                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Facility :</strong></span>&nbsp;
                <strong >
                    <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${facility}</strong></span>
                </strong>
            </div> 
        </div>
        <div class="col-md-4">
            <div class="form-group bs-component">
                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Date:</strong></span>&nbsp;
                <strong >
                    <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${facilitydate}</strong></span>
                </strong>
            </div>   
        </div>
        <div class="col-md-4">
            <div class="form-group bs-component">
                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Visit Number</strong></span>&nbsp;
                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${visitnumber}</strong></span>
            </div> 
        </div>
    </div><br>
    <c:forEach items="${visitunitsFound}" var="unit"  varStatus="theCount">
        <div class="card">
            <header class="card-header">
                <a href="#" data-toggle="collapse" data-target="#collapse${theCount.count}" aria-expanded="<c:if test="${theCount.count==1}">true</c:if><c:if test="${theCount.count!=1}">false</c:if>" class="">
                        <i class="icon-action fa fa-chevron-down"></i>
                            <span class="title badge badge-patientinfo patientConfirmFont">Facility Unit: ${unit.facilityunitname}</span>
                </a>
            </header>
            <div class="collapse <c:if test="${theCount.count==1}">show</c:if><c:if test="${theCount.count!=1}"></c:if>" id="collapse${theCount.count}" style="">
                    <article class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <div class="container">
                                                <div class="panel-group" id="accordion1${unit.facilityunitid}">
                                            <%--<c:choose>--%>
                                                <%--<c:when test="${systolic == 0 && weight == 0 && height == 0 && temperature == 0 && bodysurfacearea == 0 && headcircum == 0 && pulse == 0 && respirationrate == 0}">--%>

                                                <%--</c:when>--%>
                                                <%--<c:otherwise>--%>
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <h5 class="panel-title">
                                                                <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion1${unit.facilityunitid}" href="#accordion1_1${unit.facilityunitid}">Patient Vitals <img src="static/images/authorisedsmall.png"></a>
                                                            </h5>
                                                        </div>
                                                        <div id="accordion1_1${unit.facilityunitid}" class="panel-collapse collapse collapse">
                                                            <div class="panel-body">
                                                                <div class="tile">
                                                                    <div class="tile-body" style="width: 75%; margin: auto;">
                                                                        <fieldset>
                                                                            <table class="table table-hover table-bordered" id="viewpatientvitalsstable" style="width: 100% !important;">
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th>No</th>
                                                                                        <th>Vital Name</th>
                                                                                        <th>Vital Measure</th>
                                                                                        <th>Reason</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>1</td>
                                                                                        <td>Blood Pressure (mmHg)</td>
                                                                                        <td align="center" id="bloodpressuretd">
                                                                                            <c:choose>
                                                                                                <c:when test="${systolic == 0}">
                                                                                                    <strong>
                                                                                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                                                                                    </strong>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    ${systolic}/${diastolic} mmHg
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                        <td>
                                                                                            <c:choose>
                                                                                                <c:when test="${PressureReason != null}">
                                                                                                    <a href="#" class="reasonDetails" data-toggle="modal" data-target="#reason-modal2">${PressureReason}</a>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    N/A
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>2</td>
                                                                                        <td>Weight (kg)</td>
                                                                                        <td align="center" id="weighttd">
                                                                                            <c:choose>
                                                                                                <c:when test="${weight == 0}">
                                                                                                    <strong>
                                                                                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                                                                                    </strong>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    ${weight} kg
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                        <td>
                                                                                            <c:choose>
                                                                                                <c:when test="${weightReason != null}">
                                                                                                    <a href="#" class="reasonDetails" data-toggle="modal" data-target="#reason-modal2">${weightReason}</a>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    N/A
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>3</td>
                                                                                        <td>Height (cm)</td>
                                                                                        <td align="center" id="heighttd">
                                                                                            <c:choose>
                                                                                                <c:when test="${height == 0}">
                                                                                                    <strong>
                                                                                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                                                                                    </strong>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    ${height} cm
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                        <td>
                                                                                            <c:choose>
                                                                                                <c:when test="${HeightReason != null}">
                                                                                                    <a href="#" class="reasonDetails" data-toggle="modal" data-target="#reason-modal2">${HeightReason}</a>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    N/A
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>4</td>
                                                                                        <td>Temperature (Celc)</td>
                                                                                        <td align="center" id="temperaturetd">
                                                                                            <c:choose>
                                                                                                <c:when test="${temperature == 0}">
                                                                                                    <strong>
                                                                                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                                                                                    </strong>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    ${temperature} Celc
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                        <td>
                                                                                            <c:choose>
                                                                                                <c:when test="${TempReason != null}">
                                                                                                    <a href="#" class="reasonDetails" data-toggle="modal" data-target="#reason-modal2">${TempReason}</a>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    N/A
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>5</td>
                                                                                        <td>Body Surface Area (cm)</td>
                                                                                        <td align="center" id="bodysurfaceareatd">
                                                                                            <c:choose>
                                                                                                <c:when test="${bodysurfacearea == 0}">
                                                                                                    <strong>
                                                                                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                                                                                    </strong>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    ${bodysurfacearea} cm
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                        <td>N/A</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>6</td>
                                                                                        <td>Head Circum (cm)</td>
                                                                                        <td align="center" id="headcircumtd">
                                                                                            <c:choose>
                                                                                                <c:when test="${headcircum == 0}">
                                                                                                    <strong>
                                                                                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                                                                                    </strong>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    ${headcircum} cm
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                        <td>N/A</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>7</td>
                                                                                        <td>Pulse (B/min)</td>
                                                                                        <td align="center" id="pulsetd">
                                                                                            <c:choose>
                                                                                                <c:when test="${pulse == 0}">
                                                                                                    <strong>
                                                                                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                                                                                    </strong>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    ${pulse} B/min
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                        <td>N/A</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>8</td>
                                                                                        <td>Respiration Rate (B/min)</td>
                                                                                        <td align="center" id="respirationratetd">
                                                                                            <c:choose>
                                                                                                <c:when test="${respirationrate == 0}">
                                                                                                    <strong>
                                                                                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                                                                                    </strong>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    ${respirationrate} B/min
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                        <td>
                                                                                            <c:choose>
                                                                                                <c:when test="${RespirationReason != null}">
                                                                                                    <a href="#" class="reasonDetails" data-toggle="modal" data-target="#reason-modal2">${RespirationReason}</a>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    N/A
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                            <div class="row">
                                                                                <div class="col-md-4"> 
                                                                                    <div class="form-group bs-component pull-left" >
                                                                                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>BMI:</strong></span>&nbsp;
                                                                                        <strong>
                                                                                            <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${bmi}</strong></span>
                                                                                        </strong>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>  
                                                <%--</c:otherwise>--%>
                                            <%--</c:choose>--%>

                                            <c:if test="${ not empty unit.complaintsFound}">
                                                <hr>
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <h5 class="panel-title">
                                                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion1${unit.facilityunitid}" href="#accordion1_2${unit.facilityunitid}">Patient Complaints & Diagnosis/Observations <c:if test="${empty unit.complaintsFound}"><img src="static/images/noaccesssmall.png"></c:if><c:if test="${not empty unit.complaintsFound}"><img src="static/images/authorisedsmall.png"></c:if></a>
                                                            </h5>
                                                        </div>
                                                            <div id="accordion1_2${unit.facilityunitid}" class="panel-collapse collapse">
                                                        <div class="panel-body">
                                                            <div class="tile">
                                                                <div class="tile-body">
                                                                    <div class="row">
                                                                        <div class="col-md-7">
                                                                            <fieldset>
                                                                                <legend>Patient Complaints</legend>
                                                                                <ul class="list-display list-checkmarks">
                                                                                    <c:if test="${ not empty unit.complaintsFound}">
                                                                                        <c:forEach items="${unit.complaintsFound}" var="a">
                                                                                            <li>${a.patientcomplaint}.</li> <p>${a.description}.</p>
                                                                                            </c:forEach>
                                                                                        </c:if>
                                                                                        <c:if test="${empty unit.complaintsFound}">
                                                                                        <div class="form-group bs-component">
                                                                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Patient Complaint:</strong></span>&nbsp;
                                                                                            <strong >
                                                                                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">No Patient Complaints</strong></span>
                                                                                            </strong>
                                                                                        </div>
                                                                                    </c:if>
                                                                                </ul> 
                                                                            </fieldset>  
                                                                        </div> 
                                                                        <div class="col-md-5">
                                                                            <fieldset>
                                                                                <legend>Observations/Diagnosis</legend>
                                                                                <ul class="list-display list-checkmarks">
                                                                                    <c:if test="${ not empty unit.observationsFound}">
                                                                                        <c:forEach items="${unit.observationsFound}" var="b">
                                                                                            <li>${b.observation}.</li>
                                                                                            </c:forEach>
                                                                                        </c:if>
                                                                                        <c:if test="${empty unit.observationsFound}">
                                                                                        <div class="form-group bs-component">
                                                                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Observations:</strong></span>&nbsp;
                                                                                            <strong >
                                                                                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">No Observations/Diagnosis</strong></span>
                                                                                            </strong>
                                                                                        </div>
                                                                                    </c:if>
                                                                                </ul>
                                                                            </fieldset>
                                                                        </div>
                                                                    </div> 
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>  
                                            </c:if>
                                            <c:if test="${not empty unit.labtestsFound}">
                                                <hr>
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <h5 class="panel-title">
                                                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion1${unit.facilityunitid}" href="#accordion1_3${unit.facilityunitid}">Patient Laboratory <c:if test="${empty unit.labtestsFound}"><img src="static/images/noaccesssmall.png"></c:if><c:if test="${not empty unit.labtestsFound}"><img src="static/images/authorisedsmall.png"></c:if></a>
                                                            </h5>
                                                        </div>
                                                            <div id="accordion1_3${unit.facilityunitid}" class="panel-collapse collapse">
                                                        <div class="panel-body">
                                                            <div class="tile">
                                                                <div class="tile-body">
                                                                    <fieldset>
                                                                        <div class="row">
                                                                            <div class="col-md-4">
                                                                                <div class="form-group bs-component">
                                                                                    <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Request Number:</strong></span>&nbsp;
                                                                                    <strong >
                                                                                        <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${unit.laboratoryrequestnumber}</strong></span>
                                                                                    </strong>
                                                                                </div> 
                                                                            </div>
                                                                            <div class="col-md-4">
                                                                                <div class="form-group bs-component">
                                                                                    <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Laboratory Unit:</strong></span>&nbsp;
                                                                                    <strong >
                                                                                        <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${unit.laboratoryunitname}</strong></span>
                                                                                    </strong>
                                                                                </div>   
                                                                            </div>
                                                                            <div class="col-md-4">
                                                                                <div class="form-group bs-component">
                                                                                    <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Requested By:</strong></span>&nbsp;
                                                                                    <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${unit.laboratoryaddedby}</strong></span>
                                                                                </div> 
                                                                            </div>
                                                                        </div>
                                                                        <hr>
                                                                        <div class="row">
                                                                            <div class="col-md-12">
                                                                                <div >
                                                                                    <table class="table table-hover table-bordered" id="patientHistorylaboratoryrequetTable">
                                                                                        <thead>
                                                                                            <tr>
                                                                                                <th>No</th>
                                                                                                <th>Test Name</th>
                                                                                                <th>Specimen</th>
                                                                                                <th>Tested</th>
                                                                                                <th>Results</th>
                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody >
                                                                                            <% int i = 1;%>
                                                                                            <c:forEach items="${unit.labtestsFound}" var="a">
                                                                                                <tr>
                                                                                                    <td><%=i++%></td>
                                                                                                    <td>${a.testname}</td>
                                                                                                    <td>${a.specimen}</td>
                                                                                                    <td align="center"><c:if test="${a.iscompleted==true}"><img src="static/images/authorisedsmall.png"></c:if> <c:if test="${a.iscompleted==false}"><img src="static/images/noaccesssmall.png"></c:if></td>
                                                                                                        <td align="center">
                                                                                                            <button onclick=""  title="Result of this Lab Request" class="btn btn-primary btn-sm add-to-shelf">
                                                                                                                <i class="fa fa-dedent"></i>
                                                                                                            </button>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                            </c:forEach>
                                                                                        </tbody>
                                                                                    </table>
                                                                                </div>
                                                                            </div> 
                                                                        </div>
                                                                    </fieldset> 
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty unit.prescriptionsFound}">
                                                <hr>
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <h5 class="panel-title">
                                                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion1${unit.facilityunitid}" href="#accordion1_4${unit.facilityunitid}">Patient Prescriptions <c:if test="${empty unit.prescriptionsFound}"><img src="static/images/noaccesssmall.png"></c:if><c:if test="${not empty unit.prescriptionsFound}"><img src="static/images/authorisedsmall.png"></c:if></a>
                                                            </h5>
                                                        </div>
                                                            <div id="accordion1_4${unit.facilityunitid}" class="panel-collapse collapse">
                                                        <div class="panel-body">
                                                            <div class="tile">
                                                                <div class="tile-body">
                                                                    <fieldset>
                                                                        <div class="row">
                                                                            <div class="col-md-4">
                                                                                <div class="form-group bs-component">
                                                                                    <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Prescribed By:</strong></span>&nbsp;
                                                                                    <strong >
                                                                                        <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${unit.presciptionaddedby}</strong></span>
                                                                                    </strong>
                                                                                </div> 
                                                                            </div>
                                                                            <div class="col-md-4">
                                                                                <div class="form-group bs-component">
                                                                                    <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Dispensing Unit:</strong></span>&nbsp;
                                                                                    <strong >
                                                                                        <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${unit.dispensingunitname}</strong></span>
                                                                                    </strong>
                                                                                </div>   
                                                                            </div>
                                                                            <div class="col-md-4">
                                                                                <div class="form-group bs-component">
                                                                                    <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Date:</strong></span>&nbsp;
                                                                                    <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${unit.prescriptiondate}</strong></span>
                                                                                </div> 
                                                                            </div>
                                                                        </div>
                                                                                <div class="row">
                                                                                    <div class="col-md-4">
                                                                                        <span class="control-label pat-form-heading patientConfirmFont" for="reference-number"><strong>Prescription Number: </strong></span>
                                                                                        <span class="badge badge-patientinfo patientConfirmFont"><strong>${unit.referencenumber}</strong></span>
                                                                                    </div>
                                                                                </div>
                                                                        <hr>
                                                                        <div class="row">
                                                                            <div class="col-md-12">
                                                                                <div >
                                                                                    <table class="table table-hover table-bordered" id="patientHistoryPrescriptions">
                                                                                        <thead>
                                                                                            <tr>
                                                                                                <th>No</th>
                                                                                                <th>Dug Name</th>
                                                                                                <th>Active Dose</th>
                                                                                                <th>Dosage</th>
                                                                                                <th>Duration</th>
                                                                                                <th>Comment</th>
                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody >
                                                                                            <% int j = 1;%>
                                                                                            <c:forEach items="${unit.prescriptionsFound}" var="a">
                                                                                                <tr>
                                                                                                    <td><%=j++%></td>
                                                                                                    <td>${a.fullname}</td>
                                                                                                    <td>${a.dose}</td>
                                                                                                    <td>${a.dosage}</td>
                                                                                                    <td>${a.days} &nbsp; ${a.daysname}</td>
                                                                                                    <td>${a.notes}</td>
                                                                                                </tr>
                                                                                            </c:forEach>
                                                                                        </tbody>
                                                                                    </table>
                                                                                </div>
                                                                            </div> 
                                                                        </div>
                                                                    </fieldset> 
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty unit.internalreferralsFound}">
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <h5 class="panel-title">
                                                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion1${unit.facilityunitid}" href="#accordion1_5${unit.facilityunitid}">Internal Referral<img src="static/images/authorisedsmall.png"></a>
                                                        </h5>
                                                    </div>
                                                    <div id="accordion1_5${unit.facilityunitid}" class="panel-collapse collapse">
                                                        <div class="panel-body">
                                                            <div class="tile">
                                                                <div class="tile-body">
                                                                    <fieldset>
                                                                        <legend>Patient Referral</legend>
                                                                        <ul class="list-display list-checkmarks">
                                                                            <c:if test="${not empty unit.internalreferralsFound}">
                                                                                <c:forEach items="${unit.internalreferralsFound}" var="a">
                                                                                    <li>Referred To:&nbsp; ${a.unit}.</li> <p>${a.referralnotes}.</p>
                                                                                    </c:forEach>
                                                                                </c:if>
                                                                        </ul> 
                                                                    </fieldset>   
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>   
                                        </div>
                                    </div>  
                                </div>
                            </div>
                        </div> 
                    </div>  
                </article>
            </div>
        </div><br><br>  
    </c:forEach>

</fieldset>

<div class="modal fade" id="reason-modal2" tabindex="-1" role="dialog" aria-labelledby="reason-modal2" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="container" style="width:auto; padding: 1%;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <fieldset>
                                        <div>
                                            <label class="text-muted">Reason By:</label> 
                                            <label><strong><div>${reasonBy}</div></strong></label>                                                
                                        </div>
                                        <div>
                                            <label class="text-muted">E-mail Address:</label> 
                                            <label><strong><div>${email}</div></strong></label>                                                
                                        </div>
                                        <div>
                                            <label class="text-muted">Phone Contacts:</label> 
                                            <label><strong><div>${contacts}</div></strong></label>                                                
                                        </div>
                                        <div>
                                            <label class="text-muted">Unit:</label> 
                                            <label><strong><div>${reasonUnit}</div></strong></label>                                                
                                        </div>       
<!--                                        <div>
                                            <label class="text-muted">Added:</label> 
                                            <label><strong><div>${reasonAdded}</div></strong></label>                                                
                                        </div> -->
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>            
            
<script>
    $('#patientHistorylaboratoryrequetTable').DataTable();
    $('#patientHistoryPrescriptions').DataTable();
    $('#viewpatientvitalsstable').DataTable();
    
    $('a.pending-link').on('click', function(e){
        e.preventDefault();
        e.stopPropagation();
    });
    
    function patientFacilityVisits() {
        var patientVisitsid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();
        ajaxSubmitData('doctorconsultation/patienthistory.htm', 'historyDiv', 'patientid=' + patientid + '&i=0&patientvisitid=' + patientVisitsid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>