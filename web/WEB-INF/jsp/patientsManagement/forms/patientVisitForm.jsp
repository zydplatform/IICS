<%--
    Document   : patientVisitForm
    Created on : Apr 21, 2018, 12:11:57 AM
    Author     : Grace-K
--%>
<style>
    .widget {
        position: relative;
        /*margin: 20px auto 10px;*/
        width: 100%;
        background: white;
        border: 1px solid #ccc;
        border-radius: 4px;
        -webkit-box-shadow: 0 0 8px rgba(0, 0, 0, 0.07);
        box-shadow: 0 0 8px rgba(0, 0, 0, 0.07);
    }

    .widget-tabs {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        padding: 9px 12px 0;
        text-align: left;
        direction: rtl;
        background: #f5f5f5;
        border-bottom: 1px solid #ddd;
        border-radius: 3px 3px 0 0;
    }

    .widget-tab,
    .widget-list:target:first-of-type ~ .widget-tabs > .widget-tab:first-child ~ .widget-tab,
    .widget-list:target:nth-of-type(2) ~ .widget-tabs > .widget-tab:nth-child(2) ~ .widget-tab,
    .widget-list:target:last-of-type ~ .widget-tabs > .widget-tab:last-child ~ .widget-tab {
        position: relative;
        display: inline-block;
        vertical-align: top;
        margin-top: 3px;
        line-height: 36px;
        font-weight: normal;
        color: #999;
        background: #fcfcfc;
        border: solid #ddd;
        border-width: 1px 1px 0;
        border-radius: 5px 5px 0 0;
        padding-bottom: 0;
        bottom: auto;
    }

    .widget-tab > .widget-tab-link,
    .widget-list:target:first-of-type ~ .widget-tabs > .widget-tab:first-child ~ .widget-tab > .widget-tab-link,
    .widget-list:target:nth-of-type(2) ~ .widget-tabs > .widget-tab:nth-child(2) ~ .widget-tab > .widget-tab-link,
    .widget-list:target:last-of-type ~ .widget-tabs > .widget-tab:last-child ~ .widget-tab > .widget-tab-link {
        margin: 0;
        border-top: 0;
    }

    .widget-tab + .widget-tab {
        margin-right: -1px;
    }

    .widget-tab:last-child,
    .widget-list:target:first-of-type ~ .widget-tabs > .widget-tab:first-child,
    .widget-list:target:nth-of-type(2) ~ .widget-tabs > .widget-tab:nth-child(2),
    .widget-list:target:last-of-type ~ .widget-tabs > .widget-tab:last-child {
        bottom: -1px;
        margin-top: 0;
        padding-bottom: 2px;
        line-height: 34px;
        font-weight: bold;
        color: #555;
        background: white;
        border-top: 0;
    }

    .widget-tab:last-child > .widget-tab-link,
    .widget-list:target:first-of-type ~ .widget-tabs > .widget-tab:first-child > .widget-tab-link,
    .widget-list:target:nth-of-type(2) ~ .widget-tabs > .widget-tab:nth-child(2) > .widget-tab-link,
    .widget-list:target:last-of-type ~ .widget-tabs > .widget-tab:last-child > .widget-tab-link {
        margin: 0 -1px;
    }
    ul.widget-tabs li.widget-tab-active {
        margin: 0 -1px;  
        border-top: 4px solid #4cc8f1;
    }
    .widget-tab-link {
        display: block;
        min-width: 60px;
        padding: 0 15px;
        color: inherit;
        text-align: center;
        text-decoration: none;
        border-radius: 4px 4px 0 0;
    }

    .widget-list {
        display: none;
        padding-top: 50px;
    }

    .widget-list > li + li {
        border-top: 1px solid #e8e8e8;
    }

    .widget-list:last-of-type {
        display: block;
    }

    .widget-list:target {
        display: block;
    }

    .widget-list:target ~ .widget-list {
        display: none;
    }

    .widget-list-link {
        display: block;
        line-height: 18px;
        padding: 10px 12px;
        font-weight: bold;
        color: #555;
        text-decoration: none;
        cursor: pointer;
    }

    .widget-list-link:hover {
        background: #f7f7f7;
    }

    li:last-child > .widget-list-link {
        border-radius: 0 0 3px 3px;
    }

    .widget-list-link > img {
        float: left;
        width: 32px;
        height: 32px;
        margin: 2px 12px 0 0;
    }

    .widget-list-link > span {
        display: block;
        font-size: 11px;
        font-weight: normal;
        color: #999;
    }
    #history, #issues-and-allergies {
        padding-right: 1.5%;
        padding-left: 1.5%;
    }
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="app-title">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>
    <div class="">
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                    <li><a href="#" onclick="ajaxSubmitData('patient/patientmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Patient Management</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('patient/patientvisits.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Search Patient</a></li>
                    <li class="last active"><a href="#">Patient Visit</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<h3 class="center text-muted">Patient Visit</h3>
<div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-4">
        <div class="tile">
            <div class="tile-body">
                <div class="">
                    <span class="textbolder" style="color: #79047d; font-size: 25px">${name}</span>
                </div><br>
                <div class="form-group">
                    <label class="control-label" for="">Patient Identification No:</label>
                    <input class="form-control" id="pin" type="text" value="${pin}" disabled="true"/>
                </div>
                <div class="form-group">
                    <label class="control-label" for="">Visit Number:</label>
                    <input class="form-control" id="visitno" type="text" value="${visitno}"/>
                    <!--                    readonly="readonly"/><span>
                                            <a id="editPatientPin">
                                                <i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i>
                                            </a>
                                        </span>-->
                </div>
                <div class="form-group">
                    <label for="">Unit</label>
                    <select class="form-control" id="unitVisited">
                        <option value="0">---Select Unit---</option>
                        <c:forEach items="${facilityunits}" var="unit">
                            <option value="${unit.id}">${unit.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="">Service</label>
                    <select class="form-control" id="unitService"></select>
                </div>
                <div class="form-group">
                    <label for="relationship">Visit Type</label>
<!--                    <select class="form-control" id="visitType">
                        <option value="NEWVISIT">New Visit</option>
                        <option value="REVISIT">Re-Visit</option>
                    </select>-->
                    <select class="form-control" id="visitType" disabled="disabled">
                        <option value="NEWVISIT" <c:if test="${isnewpatient == Boolean.TRUE}">selected="selected"</c:if>>New Visit</option>
                        <option value="REVISIT" <c:if test="${isnewpatient == Boolean.FALSE}">selected="selected"</c:if>>Re-Visit</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="">Visit Priority</label>
                    <select class="form-control" id="visitPriority">
                        <option value="NORMAL">Normal</option>
                        <option value="EMERGENCY">Emergency</option>
                        <option value="APPOINTMENT">Appointment</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="tile">

            <div class="widget">  
                <div class="widget-list" id="history">
                    <hr />
                    <div>
                        <!--                    <span class="textbolder text-info" style="font-size: 23px">Smoking</span>-->
                        <span class="textbolder text-info" style="font-size: 23px">Social History</span>
                    </div><hr/>
                    <table class="table table-hover table-striped">
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Do You Currently Smoke?</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="smoking" value="6" type="radio" id="6yes" name="smokeNow">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="smoking" value="6" type="radio" id="6no" name="smokeNow">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Have you smoked before?</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="smoking" value="7" type="radio" id="7yes" name="smokePast">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="smoking" value="7" type="radio" id="7no" name="smokePast">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Do You Drink Alcohol?</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="drink" value="8" type="radio" id="8yes" name="drinkNow">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="drink" value="8" type="radio" id="8no" name="drinkNow">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td> Do You Take Drugs?</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="drugs" value="9" type="radio" id="9yes" name="drugsNow">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="drugs" value="9" type="radio" id="9no" name="drugsNow">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                        </tbody>
                    </table>                    
                    <div>
                        <span class="textbolder text-info" style="font-size: 23px">Family History</span>
                    </div>
                    <hr/>
                    <table class="table table-hover table-striped">
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Diabetes</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="family-history" value="10" type="radio" id="10yes" name="diabetes">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="family-history" value="10" type="radio" id="10no" name="diabetes">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Twins</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="family-history" value="11" type="radio" id="11yes" name="twins">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="family-history" value="11" type="radio" id="11no" name="twins">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Hypertension</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="family-history" value="12" type="radio" id="12yes" name="hypertension">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="family-history" value="12" type="radio" id="12no" name="hypertension">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td> Sickle Cell</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="family-history" value="13" type="radio" id="13yes" name="sickleCell">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="family-history" value="13" type="radio" id="13no" name="sickleCell">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td> Epilepsy</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="family-history" value="14" type="radio" id="14yes" name="epilepsy">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="family-history" value="14" type="radio" id="14no" name="epilepsy">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="widget-list" id="issues-and-allergies">
                    <hr />
                    <div>
                        <span class="textbolder text-info" style="font-size: 23px">Issues & Allergies</span>
                    </div><hr/>
                    <table class="table table-hover table-striped">
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Asthma</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="medicalIssues" value="1" type="radio" id="1yes" name="asthma">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="medicalIssues" value="1" type="radio" id="1no" name="asthma">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label no-wrap">Not Tested
                                        <input class="medicalIssues" value="1" type="radio" id="1not" name="asthma">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Cancer</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="medicalIssues" value="2" type="radio" id="2yes" name="cancer">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="medicalIssues" value="2" type="radio" id="2no" name="cancer">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label no-wrap">Not Tested
                                        <input class="medicalIssues" value="2" type="radio" id="2not" name="cancer">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Diabetes</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="medicalIssues" value="3" type="radio" id="3yes" name="diabetes">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="medicalIssues" value="3" type="radio" id="3no" name="diabetes">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label no-wrap">Not Tested
                                        <input class="medicalIssues" value="3" type="radio" id="3not" name="diabetes">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>High Blood Pressure</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="medicalIssues" value="4" type="radio" id="4yes" name="hbp">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="medicalIssues" value="4" type="radio" id="4no" name="hbp">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label no-wrap">Not Tested
                                        <input class="medicalIssues" value="4" type="radio" id="4not" name="hbp">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>Ulcers</td>
                                <td class="center">
                                    <label class="check-Label">Yes
                                        <input class="medicalIssues" value="5" type="radio" id="5yes" name="ulcers">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label">No
                                        <input class="medicalIssues" value="5" type="radio" id="5no" name="ulcers">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                                <td class="center">
                                    <label class="check-Label no-wrap">Not Tested
                                        <input class="medicalIssues" value="5" type="radio" id="5not" name="ulcers">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <ul class="widget-tabs">    
                <!-- Omitting the end tag is valid HTML and removes the space in-between inline blocks. -->
                <li class="widget-tab">
                    <a href="#history" class="widget-tab-link" data-show-target="#history" data-hide-targets="#issues-and-allergies">History</a>
                <li class="widget-tab widget-tab-active">
                    <a href="#issues-and-allergies" data-show-target="#issues-and-allergies" data-hide-targets="#history" class="widget-tab-link">Issues & Allergies</a>
            </ul>
        </div>

        <div class="row">
            <div class="col-md-12">
                <button class="btn btn-primary icon-btn pull-right" id="initiateVisit" data-facility-id="${facilityid}">
                    Initiate Visit.
                </button>
            </div>
        </div>
        <br />
    </div>
</div>
</div>
<script>
    var smokingPast = false;
    $(document).ready(function () {
        breadCrumb();
        connect();
        var issueKeys = ${issueKeys};
        var currentUnit = ${currentUnit};
        $('#unitVisited').val(currentUnit);
        for (i in issueKeys) {
            $('#' + issueKeys[i].key).prop('checked', 'checked');
            if (issueKeys[i].key === '6yes') {
                $('#7no').prop('disabled', true);
            }
        }

        var unitid = parseInt($('#unitVisited').val());
        if (unitid > 0) {
            $.ajax({
                type: 'POST',
                data: {unitid: unitid},
                data_type: 'JSON',
                url: 'patient/getUnitServices.htm',
                success: function (res) {
                    var services = JSON.parse(res);
                    if (services.length > 0) {
                        for (i in services) {
                            $('#unitService').append('<option value="' + services[i].usid + '">' + services[i].serviceName + '</option>');
                        }
                    } else {
                        $('#unitService').html('<option value="0">No Services Set</option>');
                    }
                }
            });
        } else {
            $('#unitVisited').val(0);
        }

        $('#unitVisited').change(function () {
            $('#unitService').html('');
            unitid = parseInt($('#unitVisited').val());
            $.ajax({
                type: 'POST',
                data: {unitid: unitid},
                data_type: 'JSON',
                url: 'patient/getUnitServices.htm',
                success: function (res) {
                    var services = JSON.parse(res);
                    if (services.length > 0) {
                        for (i in services) {
                            $('#unitService').append('<option value="' + services[i].usid + '">' + services[i].serviceName + '</option>');
                        }
                    } else {
                        $('#unitService').append('<option value="0">No Services Set</option>');
                    }
                }
            });
        });

        $('.medicalIssues').click(function (event) {
            var issueKey = event.target.id;
            var issueId = event.target.value;
            $('#' + issueId + 'yes').prop('disabled', true);
            $('#' + issueId + 'no').prop('disabled', true);
            $('#' + issueId + 'not').prop('disabled', true);
            var operation = 'save';
            for (i in issueKeys) {
                if ((issueKeys[i].id).toString() === issueId.toString()) {
                    operation = 'update';
                    break;
                }
            }
            var data = {
                operation: operation,
                patientid: '${patientid}',
                issuekey: issueKey,
                issueid: parseInt(issueId)
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'patient/managePatientIssues.htm',
                success: function (res) {
                    if (res === 'refresh') {
                        document.location.reload(true);
                    }
                    if (data.operation === 'save') {
                        var newIssue = {
                            id: parseInt(issueId),
                            key: issueKey
                        };
                        issueKeys.push(newIssue);
                    }
                    $('#' + issueId + 'yes').prop('disabled', false);
                    $('#' + issueId + 'no').prop('disabled', false);
                    $('#' + issueId + 'not').prop('disabled', false);
                }
            });
        });

        $('.smoking').click(function (event) {
            var issueKey = event.target.id;
            var issueId = event.target.value;
            if (issueKey === '6yes') {
                smokingPast = true;
                $('#7no').prop('disabled', true);
                $('#7yes').prop('checked', 'checked');
                $('#7yes').click();
            } else if (issueKey === '6no') {
                smokingPast = false;
                $('#7no').prop('disabled', false);
            }
            $('#' + issueId + 'yes').prop('disabled', true);
            $('#' + issueId + 'no').prop('disabled', true);
            var operation = 'save';
            for (i in issueKeys) {
                if ((issueKeys[i].id).toString() === issueId.toString()) {
                    operation = 'update';
                    break;
                }
            }
            var data = {
                operation: operation,
                patientid: '${patientid}',
                issuekey: issueKey,
                issueid: parseInt(issueId)
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'patient/managePatientIssues.htm',
                success: function (res) {
                    if (res === 'refresh') {
                        document.location.reload(true);
                    }
                    if (data.operation === 'save') {
                        var newIssue = {
                            id: parseInt(issueId),
                            key: issueKey
                        };
                        issueKeys.push(newIssue);
                    }
                    if (issueKey === '7yes' && smokingPast === true) {
                        $('#' + issueId + 'yes').prop('disabled', false);
                    } else {
                        $('#' + issueId + 'yes').prop('disabled', false);
                        $('#' + issueId + 'no').prop('disabled', false);
                    }
                }
            });
        });
        //
        $('.drink').on('click', function (e) {
            var issueKey = e.target.id;
            var issueId = e.target.value;
            $('#' + issueId + 'yes').prop('disabled', true);
            $('#' + issueId + 'no').prop('disabled', true);
            var operation = 'save';
            for (var i in issueKeys) {
                if ((issueKeys[i].id).toString() === issueId.toString()) {
                    operation = 'update';
                    break;
                }
            }
            var data = {
                operation: operation,
                patientid: '${patientid}',
                issuekey: issueKey,
                issueid: parseInt(issueId)
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'patient/managePatientIssues.htm',
                success: function (res) {
                    if (res === 'refresh') {
                        document.location.reload(true);
                    }
                    if (data.operation === 'save') {
                        var newIssue = {
                            id: parseInt(issueId),
                            key: issueKey
                        };
                        issueKeys.push(newIssue);
                    }
                    $('#' + issueId + 'yes').prop('disabled', false);
                    $('#' + issueId + 'no').prop('disabled', false);
                }
            });
        });
        $('.drugs').on('click', function (e) {
            var issueKey = e.target.id;
            var issueId = e.target.value;
            $('#' + issueId + 'yes').prop('disabled', true);
            $('#' + issueId + 'no').prop('disabled', true);
            var operation = 'save';
            for (var i in issueKeys) {
                if ((issueKeys[i].id).toString() === issueId.toString()) {
                    operation = 'update';
                    break;
                }
            }
            var data = {
                operation: operation,
                patientid: '${patientid}',
                issuekey: issueKey,
                issueid: parseInt(issueId)
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'patient/managePatientIssues.htm',
                success: function (res) {
                    if (res === 'refresh') {
                        document.location.reload(true);
                    }
                    if (data.operation === 'save') {
                        var newIssue = {
                            id: parseInt(issueId),
                            key: issueKey
                        };
                        issueKeys.push(newIssue);
                    }
                    $('#' + issueId + 'yes').prop('disabled', false);
                    $('#' + issueId + 'no').prop('disabled', false);
                }
            });
        });
        $('.family-history').on('click', function (e) {
            var issueKey = e.target.id;
            var issueId = e.target.value;
            $('#' + issueId + 'yes').prop('disabled', true);
            $('#' + issueId + 'no').prop('disabled', true);
            var operation = 'save';
            for (var i in issueKeys) {
                if ((issueKeys[i].id).toString() === issueId.toString()) {
                    operation = 'update';
                    break;
                }
            }
            var data = {
                operation: operation,
                patientid: '${patientid}',
                issuekey: issueKey,
                issueid: parseInt(issueId)
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'patient/managePatientIssues.htm',
                success: function (res) {
                    if (res === 'refresh') {
                        document.location.reload(true);
                    }
                    if (data.operation === 'save') {
                        var newIssue = {
                            id: parseInt(issueId),
                            key: issueKey
                        };
                        issueKeys.push(newIssue);
                    }
                    $('#' + issueId + 'yes').prop('disabled', false);
                    $('#' + issueId + 'no').prop('disabled', false);
                }
            });
        });
        //
        $('#initiateVisit').click(function () {
            $('#initiateVisit').prop('disabled', true);
            var patientid = parseInt('${patientid}');
            var visitno = $('#visitno').val();
            var visitType = $('#visitType').val();
            var unitService = $('#unitService').val();
            var visitPriority = $('#visitPriority').val();
            var facilityUnit = parseInt($('#unitVisited').val());
            //
            var facilityId = $(this).data('facility-id');
            //

            if (visitno.length > 0 && facilityUnit > 0 && unitService > 0) {
                $('#visitno').removeClass('error-field');
                $('#unitService').removeClass('error-field');
                $('#unitVisited').removeClass('error-field');
                var data = {
                    type: visitType,
                    visitno: visitno,
                    unit: facilityUnit,
                    priority: visitPriority,
                    patientid: patientid
                };
                $.ajax({
                    type: 'POST',
                    data: data,
                    url: 'patient/initiatePatientVisit.htm',
                    success: function (res) {
//                        if (res !== 'refresh' && res !== '') {
//                            var staffid = ${staffid};
//                            var queueData = {
//                                type: 'ADD',
//                                visitid: parseInt(res),
//                                serviceid: unitService,
//                                staffid: staffid
//                            };
//                            var host = location.host;
//                            var url = 'ws://' + host + '/IICS/queuingServer';
//                            var ws = new WebSocket(url);
//                            //
//                            queueData.host = host;
//                            //
//                            ws.onopen = function (ev) {
//                                ws.send(JSON.stringify(queueData));
//                            };
//                            ws.onmessage = function (ev) {
//                                if (ev.data === 'ADDED') {                                    
//                                    ajaxSubmitData('patient/patientvisits.htm', 'workpane', '', 'GET');
//                                }
//                            };                            
//                        } else {
//                            if (res === 'refresh') {
//                                document.location.reload(true);
//                            }
//                        }
                        //
                            var staffid = ${staffid};
                        $.ajax({
                            type: 'GET',
                            url: 'queuingSystem/pushPatient',
                            data: { visitid: parseInt(res), serviceid: unitService, staffid: staffid },
                            success: function (data, textStatus, jqXHR) {
                                stompClient.send('/app/patientqueuesize/' + facilityUnit + '/' + facilityId + '/' + unitService, {}, JSON.stringify({ unitserviceid: unitService }));
                                    ajaxSubmitData('patient/patientvisits.htm', 'workpane', '', 'GET');
                            },
                            error: function (jqXHR, textStatus, errorThrown) {                                
                                console.log(jqXHR);
                                console.log(textStatus);
                                console.log(errorThrown);
                                }
                        });                        
                        stompClient.send('/app/patientcount/' + facilityId, {}, JSON.stringify({ facilityid: facilityId }));
                        //
                    }
                });
            } else {
                $('#initiateVisit').prop('disabled', false);
                if (!(visitno.length > 0)) {
                    $('#visitno').addClass('error-field');
                }
                if (!(unitService > 0)) {
                    $('#unitVisited').addClass('error-field');
                }
                if (!(facilityUnit > 0)) {
                    $('#unitService').addClass('error-field');
                }
            }
        });
    });
    $('a.widget-tab-link').on('click', function (e) {        
        e.preventDefault();
        e.stopPropagation();
        var showTarget = $(this).data('show-target');
        var hideTargets = $(this).data('hide-targets');
        $(showTarget).css('display', 'block');
        $(hideTargets).css('display', 'none');
        $('li.widget-tab').removeClass('widget-tab-active');
        $(this).parent('li.widget-tab').css('border-top', '4px solid #4cc8f1');
        $(this).parent('li.widget-tab').siblings('li.widget-tab').css('border-top', '0');
    });
</script>