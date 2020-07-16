<%-- 
    Document   : allergies
    Created on : Aug 31, 2018, 9:48:54 AM
    Author     : HP
--%>
<%@include file="../../../include.jsp" %>

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
    .widget-list:last-of-type {
        display: block;
    }
    .widget-list:target {
        display: block;
    }
    .widget-list:target ~ .widget-list {
        display: none;
    }
    #history, #issues-and-allergies {
        padding-left: 1.5%;
        padding-right: 1.5%;
    }
</style>

<div class="widget">  
    <div class="widget-list" id="history">
        <hr />
        <div>
            <!--<span class="textbolder text-info" style="font-size: 23px">Smoking</span>-->
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

    <ul class="widget-tabs">    
        <!-- Omitting the end tag is valid HTML and removes the space in-between inline blocks. -->
        <li class="widget-tab">
            <a href="#history" class="widget-tab-link" data-show-target="#history" data-hide-targets="#issues-and-allergies">History</a>
        <li class="widget-tab widget-tab-active">
            <a href="#issues-and-allergies" data-show-target="#issues-and-allergies" data-hide-targets="#history" class="widget-tab-link">Issues & Allergies</a>
    </ul>
</div>

<script>
    var smokingPast = false;
    $(document).ready(function () {
        var issueKeys = ${issueKeys};
        for (i in issueKeys) {
            $('#' + issueKeys[i].key).prop('checked', 'checked');
            if (issueKeys[i].key === '6yes') {
                $('#7no').prop('disabled', true);
            }
        }

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
