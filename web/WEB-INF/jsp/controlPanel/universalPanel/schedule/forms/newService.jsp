<%-- 
    Document   : newService
    Created on : Jun 18, 2018, 12:25:20 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<form id="createServiceForm">
    <input type="hidden" name="cronexpression" id="cron" />
    <div style="height: 460px;width: 100%; margin-left: 8%;" align="center" class="tile-body">                                    
        <div align="left" style="width: 80%; height: 30px" class="form-group">                                                                        
            <table style="width: 100%">
                <tr>
                    <td style="background-color: transparent;border-color: #ffffff;width: 100px">
                        <label>Service<font color="red">*</font></label>
                    </td>
                    <td style="background-color: transparent;border-color: #ffffff">
                        <input readonly="" data-toggle="tooltip" title="Service Name" placeholder="Select from dropdown" onkeyup="isEmptyField('servicename');" style="width: 230px;;float: left;" class="form-control input-sm" value="" name="servicename" id="servicename" onKeyPress='return isAlphaNumericSpecial(event)' type="text"/>                                                                        
                        <input value="" name="beanname" id="beanname" type="hidden"/>
                        <input value="" name="autoid" id="autoid" type="hidden"/>
                        <select class="form-control input-sm" style="width: 220px;" name="service" id="service">
                            <option value="select">--Select a Service below--</option>
                            <c:forEach items="${activityFound}" varStatus="cnt" var="service">
                                <option id="schdulingservices${service.autoactivityrunsettingid}" data-autoid="${service.autoactivityrunsettingid}" data-beanname="${service.beanname}" data-servicename="${service.activityname}" data-description="${service.description}" value="${service.autoactivityrunsettingid}">${service.activityname}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
            </table>
        </div>                             
        <div align="left" style="width: 80%; height: 30px" class="form-group">
            <table style="width: 30%">
                <tr>
                    <td style="background-color: transparent;border-color: #ffffff;width: 150px">
                        <label>Run Manually<font color="red"></font></label>
                    </td>
                    <td style="background-color: transparent;border-color: #ffffff">
                        <input onclick="if ($(this).prop('checked')) {
                                    $('#runonstartup').prop('checked', false);
                                    $('#contentDIV').fadeOut(800);
                                    $(this).val(1);
                                } else {
                                    $('#runonstartup').prop('checked', true);
                                    $('#contentDIV').fadeIn(800);
                                    $(this).val(0);
                                }" type="checkbox" name="startoncreation" id="startoncreation" value="0"/>
                    </td>
                </tr>
            </table>
        </div>
        <div align="left" style="width: 80%; height: 30px" class="form-group">
            <table style="width: 30%">
                <tr>
                    <td style="background-color: transparent;border-color: #ffffff;width: 150px">
                        <label>Run Automatically<font color="red"></font></label>
                    </td>
                    <td style="background-color: transparent;border-color: #ffffff">
                        <input checked="" onclick="if ($(this).prop('checked')) {
                                    $('#startoncreation').prop('checked', false);
                                    $('#startoncreation').val(0);
                                    $('#contentDIV').fadeIn(800);
                                    $(this).val(1);
                                } else {
                                    $('#startoncreation').prop('checked', true);
                                    $('#startoncreation').val(1);
                                    $('#contentDIV').fadeOut(800);
                                    $(this).val(0);
                                }" type="checkbox" name="runonstartup" id="runonstartup" value="0"/>
                    </td>
                </tr>
            </table>
        </div>
        <div align="left" style="width: 80%; height: 50px" class="form-group">
            <table style="width: 100%">
                <tr>
                    <td style="background-color: transparent;border-color: #ffffff;width: 100px">
                        <label>Description<font color="red">*</font></label>
                    </td>
                    <td style="background-color: transparent;border-color: #ffffff">
                        <textarea onkeyup="isEmptyField('description');" placeholder="Enter Description" style="width: 600px; margin-right: 20%" class="form-control RequiredField" type="text" class="" id="description" name="description"></textarea>
                    </td>
                </tr>
            </table>
        </div>
        <div id="contentDIV" align="center" style="width: 100%; height: 150px" class="form-group">
            <div style="float: left;">
                <fieldset style="min-width: 800px ; height: 370px;" class="FieldsetContainer">
                    <legend class="H5">Runtime Settings</legend>
                    <div class="tabsSec" id="CronGenMainDiv">
                        <div class="tabsnew row" style="background: #ffffffe6 !important;" id="CronGenTabs">
                            <div class="tab">
                                <input type="radio" name="css-tabs" onclick="" id="MinutesTab" checked class="tab-switch">
                                <label for="MinutesTab" class="tab-label">Minutes<span class="badge badge badge-info"></span></label>
                                <div class="tab-content" style="margin-left: 2%;">
                                    <fieldset>
                                        <div class="tile">
                                            <div class="tile-body">
                                                <%@include file="minutes.jsp" %>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                            <div class="tab">
                                <input type="radio" name="css-tabs" onclick="" id="HourlyTab" class="tab-switch">
                                <label for="HourlyTab" class="tab-label">Hourly <span class="badge badge-info"></span></label>
                                <div class="tab-content" style="margin-left: -13%;"> 
                                    <fieldset>
                                        <div class="tile">
                                            <div class="tile-body">
                                                <%@include file="hourly.jsp" %>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                            <div class="tab">
                                <input type="radio" name="css-tabs" id="DailyTab" class="tab-switch">
                                <label for="DailyTab" class="tab-label">Daily <span class="badge badge-info"></span></label>
                                <div class="tab-content" style="margin-left: -24%;">
                                    <fieldset>
                                        <div class="tile">
                                            <div class="tile-body">
                                                <%@include file="daily.jsp" %> 
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                            <div class="tab">
                                <input type="radio" name="css-tabs" id="WeeklyTab" class="tab-switch">
                                <label for="WeeklyTab" class="tab-label">Weekly <span class="badge badge-info"></span></label>
                                <div class="tab-content" style="margin-left: -36%;"> 
                                    <fieldset>
                                        <div class="tile">
                                            <div class="tile-body">
                                                <%@include file="weekly.jsp" %>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                            <div class="tab">
                                <input type="radio" name="css-tabs" id="MonthlyTab" class="tab-switch">
                                <label for="MonthlyTab" class="tab-label">Monthly <span class="badge badge-info"></span></label>
                                <div class="tab-content" style="margin-left: -48%;"> 
                                    <fieldset>
                                        <div class="tile">
                                            <div class="tile-body">
                                                <%@include file="monthly.jsp" %>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                            <div class="tab">
                                <input type="radio" name="css-tabs" id="YearlyTab" class="tab-switch">
                                <label for="YearlyTab" class="tab-label">Yearly <span class="badge badge-info"></span></label>
                                <div class="tab-content" style="margin-left: -63%;">
                                    <fieldset>
                                        <div class="tile">
                                            <div class="tile-body">
                                                <%@include file="yearly.jsp" %>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
    <div style="width: 30%" align="center" class="modal-footer"><!--btn btn-default btn-sm-->                       
        <input value="1" type="hidden" name="selectedtab" id="selectedtab"/>
        <div id="saveDiv"></div>
        <button  style="float: right" id="submitButton"  <c:if test="${empty activityFound}">disabled="true"</c:if> type="button" class="btn btn-primary" 
                onclick="saveServiceToRun();">SAVE</button>
        <button type="button" class="btn btn-secondary " onclick="window.location = '#close';">CANCEL</button>
    </div>
</form>
<script>
    $(function () {
        $("#cron").cronGen();
    });
    $('#service').change(function () {
        var selectedservice = $('#service').val();
        var auto = $('#schdulingservices' + selectedservice).data('autoid');
        var databeanname = $('#schdulingservices' + selectedservice).data('beanname');
        var dataservicename = $('#schdulingservices' + selectedservice).data('servicename');
        var datadescription = $('#schdulingservices' + selectedservice).data('description');

        $('#servicename').prop('readonly', false);
        document.getElementById('autoid').value = auto;
        document.getElementById('beanname').value = databeanname;
        document.getElementById('servicename').value = dataservicename;
        document.getElementById('description').value = datadescription;
    });
    function saveServiceToRun() {
        var startoncreation = $('#startoncreation').val();
        var runonstartup = $('#runonstartup').val();
        var autoid = $('#autoid').val();
        var service = $('#service').val();
        var description = $('#description').val();
        var servicename = $('#servicename').val();
        var cron = $('#cron').val();
        var beanname = $('#beanname').val();
        
        if (parseInt(startoncreation) === 1) {
            if (description !== '' && service !== 'select' && servicename !== '') {
                document.getElementById('submitButton').disabled = true;
                $.ajax({
                    type: 'POST',
                    data: {autoid: autoid, description: description, type: 'manual', servicename: servicename, beanname: beanname, cron: cron},
                    url: "schedulerservicesmanagement/saveScheduledService.htm",
                    success: function (data, textStatus, jqXHR) {
                        window.location = '#close';
                        ajaxSubmitData('schedulerservicesmanagement/scheduledservicesmanagementhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                });
            }
        } else if (parseInt(runonstartup) === 0 && cron !== '') {
            document.getElementById('submitButton').disabled = true;
            $.ajax({
                type: 'POST',
                data: {autoid: autoid, description: description, type: 'auto', servicename: servicename, cron: cron, beanname: beanname},
                url: "schedulerservicesmanagement/saveScheduledService.htm",
                success: function (data, textStatus, jqXHR) {
                    window.location = '#close';
                    ajaxSubmitData('schedulerservicesmanagement/scheduledservicesmanagementhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        }else{
            
            console.log('nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
        }
    }
</script>