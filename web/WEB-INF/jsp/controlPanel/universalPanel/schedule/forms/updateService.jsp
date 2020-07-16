<%-- 
    Document   : updateService
    Created on : Jun 19, 2018, 3:15:53 PM
    Author     : IICS
--%>

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
                        <input readonly="" data-toggle="tooltip" title="Service Name"  onkeyup="isEmptyField('servicename');" style="width: 230px;;float: left;" class="form-control input-sm" value="${servicename}" name="servicename" id="updateservicename" onKeyPress='return isAlphaNumericSpecial(event)' type="text"/>                                                                        
                        <input value="${beanname}" name="beanname" id="updatebeanname" type="hidden"/>
                        <input value="${autoactivityrunsettingid}" name="autoid" id="updateautoid" type="hidden"/>
                        <select class="form-control input-sm" style="width: 220px;" name="service" id="updateservice">
                            <option  value="${serviceid}">${activityname}</option>
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
                        <input <c:if test="${startondemand}">checked="checked"</c:if> onclick="if ($(this).prop('checked')) {
                                    $('#updaterunonstartup').prop('checked', false);
                                    $('#contentDIV').fadeOut(800);
                                    $(this).val(1);
                                } else {
                                    $('#updaterunonstartup').prop('checked', true);
                                    $('#contentDIV').fadeIn(800);
                                    $(this).val(0);
                                }" type="checkbox" name="startoncreation" id="updatestartoncreation" value="0"/>
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
                            <input <c:if test="${startonstartup}"> checked="checked"</c:if> onclick="if ($(this).prop('checked')) {
                                        $('#updatestartoncreation').prop('checked', false);
                                        $('#updatestartoncreation').val(0);
                                        $('#contentDIV').fadeIn(800);
                                        $(this).val(1);
                                    } else {
                                        $('#updatestartoncreation').prop('checked', true);
                                        $('#updatestartoncreation').val(1);
                                        $('#contentDIV').fadeOut(800);
                                        $(this).val(0);
                                    }" type="checkbox" name="runonstartup" id="updaterunonstartup" value="0"/>
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
                            <textarea onkeyup="isEmptyField('description');"  style="width: 600px; margin-right: 20%" class="form-control RequiredField" type="text" class="" id="updatedescription" name="description">${description}</textarea>
                    </td>
                </tr>
            </table>
        </div>
        <c:if test="${startonstartup}">

        </c:if>
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
        <button style="float: left" id="updatesubmitButton" type="button" class="btn btn-primary" 
                onclick="updateServicesedToRun(${startonstartup});">UPDATE</button>
        <button type="button" class="btn btn-secondary " onclick="window.location = '#close';">CANCEL</button>
    </div>
</form>
<script>
    $(function () {
        $("#cron").cronGen();
        if(${startondemand}){
            $('#contentDIV').fadeOut(800);
        }
    });
    function updateServicesedToRun(isstartonstartup) {
        var startoncreation = $('#updatestartoncreation').val();
        var runonstartup = $('#updaterunonstartup').val();
        var autoid = $('#updateautoid').val();
        var description = $('#updatedescription').val();
        var servicename = $('#updateservicename').val();
        var serviceid = $('#updateservice').val();
        var cron = $('#cron').val();
        var beanname = $('#updatebeanname').val();
        if (servicename !== '' && description !== '') {
            if (isstartonstartup === true && parseInt(startoncreation) === 1) {
                $.ajax({
                    type: 'POST',
                    data: {type: 'tomannual', beanname: beanname, servicename: servicename, description: description, autoid: autoid, cron: cron, serviceid: serviceid},
                    url: "schedulerservicesmanagement/updateScheduledService.htm",
                    success: function (data, textStatus, jqXHR) {
                        $.confirm({
                            title: 'Update Service!',
                            content: 'Service Updated SuccessFully !!!',
                            type: 'orange',
                            typeAnimated: true,
                            buttons: {
                                close: function () {
                                    window.location = '#close';
                                    ajaxSubmitData('schedulerservicesmanagement/scheduledgetupdatedservices.htm', 'getupdatedservices', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                });
            } else if (isstartonstartup === true && parseInt(startoncreation) === 0) {
                $.ajax({
                    type: 'POST',
                    data: {type: 'auto', beanname: beanname, servicename: servicename, description: description, autoid: autoid, cron: cron, serviceid: serviceid},
                    url: "schedulerservicesmanagement/updateScheduledService.htm",
                    success: function (data, textStatus, jqXHR) {
                        $.confirm({
                            title: 'Update Service!',
                            content: 'Service Updated SuccessFully !!!',
                            type: 'orange',
                            typeAnimated: true,
                            buttons: {
                                close: function () {
                                    window.location = '#close';
                                    ajaxSubmitData('schedulerservicesmanagement/scheduledgetupdatedservices.htm', 'getupdatedservices', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                });
            } else if (isstartonstartup === false && parseInt(runonstartup) === 1) {
                $.ajax({
                    type: 'POST',
                    data: {type: 'toauto', beanname: beanname, servicename: servicename, description: description, autoid: autoid, cron: cron, serviceid: serviceid},
                    url: "schedulerservicesmanagement/updateScheduledService.htm",
                    success: function (data, textStatus, jqXHR) {
                        $.confirm({
                            title: 'Update Service!',
                            content: 'Service Updated SuccessFully !!!',
                            type: 'orange',
                            typeAnimated: true,
                            buttons: {
                                close: function () {
                                    window.location = '#close';
                                    ajaxSubmitData('schedulerservicesmanagement/scheduledgetupdatedservices.htm', 'getupdatedservices', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                });
            } else {
                $.ajax({
                    type: 'POST',
                    data: {type: 'mannual', beanname: beanname, servicename: servicename, description: description, autoid: autoid, cron: cron, serviceid: serviceid},
                    url: "schedulerservicesmanagement/updateScheduledService.htm",
                    success: function (data, textStatus, jqXHR) {
                        $.confirm({
                            title: 'Update Service!',
                            content: 'Service Updated SuccessFully !!!',
                            type: 'orange',
                            typeAnimated: true,
                            buttons: {
                                close: function () {
                                    window.location = '#close';
                                    ajaxSubmitData('schedulerservicesmanagement/scheduledgetupdatedservices.htm', 'getupdatedservices', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                });
            }
        } else {
             console.log('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        }

    }
</script>