<%-- 
    Document   : patientConditions
    Created on : Oct 23, 2018, 10:05:12 AM
    Author     : IICS
--%>
<style>
    .table tbody tr:hover {
        cursor: pointer;
        background-color: #cfe7f3;
    }
    tr.border_top td {
        border-bottom:2.5px solid #daa6da;
        border-top:2.5px solid #daa6da;
    }

    /* The customcheck */
    .customcheck {
        display: block;
        position: relative;
        padding-left: 35px;
        margin-bottom: 12px;
        cursor: pointer;
        font-size: 22px;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
    }

    /* Hide the browser's default checkbox */
    .customcheck input {
        position: absolute;
        opacity: 0;
        cursor: pointer;
    }

    /* Create a custom checkbox */
    .checkmark {
        position: absolute;
        top: 0;
        left: 0;
        height: 25px;
        width: 25px;
        background-color: #b1a9a9;
        border-radius: 5px;
    }

    /* On mouse-over, add a grey background color */
    .customcheck:hover input ~ .checkmark {
        background-color: #ccc;
    }

    /* When the checkbox is checked, add a blue background */
    .customcheck input:checked ~ .checkmark {
        background-color: #02cf32;
        border-radius: 5px;
    }

    /* Create the checkmark/indicator (hidden when not checked) */
    .checkmark:after {
        content: "";
        position: absolute;
        display: none;
    }

    /* Show the checkmark when checked */
    .customcheck input:checked ~ .checkmark:after {
        display: block;
    }

    /* Style the checkmark/indicator */
    .customcheck .checkmark:after {
        left: 9px;
        top: 5px;
        width: 5px;
        height: 10px;
        border: solid white;
        border-width: 0 3px 3px 0;
        -webkit-transform: rotate(45deg);
        -ms-transform: rotate(45deg);
        transform: rotate(45deg);
    }
</style>
<%@include file="../../include.jsp" %>
<div class="tile">
    <div class="tile-title"><h5>Possible Conditions</h5></div>
    <hr>
    <div class="tile-body" style="overflow-y: scroll; height:251px;"><br>
        <div id="patientConddiv2">
            <div class="table-container">
                <table class="table table-bordred">
                    <tbody>
                        <% int j = 1;%>
                        <c:forEach items="${conditionsFound}" var="a">
                            <tr class="border_top">
                                <td onclick="selectedPatientCondition(${a.diseaseid});"><%=j++%>.&nbsp;<font color="blue"><strong>${a.diseasename}</strong></font><p class="summary" style="margin-left: 22px;margin-top: 5px;">${a.diseasecategory}</p></td>
                                <td>
                                    <label class="customcheck pull-right">
                                        <input value="${a.diseaseid}" onchange="if (this.checked) {
                                                    setCheckedCondition('checked', this.value,${a.count});
                                                } else {
                                                    setCheckedCondition('unchecked', this.value,${a.count});
                                                }" type="checkbox">
                                        <span class="checkmark"></span>
                                    </label>
                                </td>
                            </tr>  
                        </c:forEach>
                    </tbody>
                </table>
            </div> 
        </div>
    </div>
    <div class="card" style="background-color:aliceblue; display: none;" id="confirmorSetforConfirmation">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6"><button  type="button" class="btn btn-success">Confirm Condition(s)</button></div>
                <div class="col-md-6"><button  type="button" onclick="setPatientConditionforconfirm();" class="btn btn-primary">Set For Confirmation</button></div>
            </div>
        </div>
    </div>
</div>
<script>
    function setCheckedCondition(type, conditionid, count) {
        if (type === 'checked') {
            checkedpatientconditions.add(conditionid);
            checkedpatientconditionList.push({
                conditionid: conditionid,
                count: count
            });
        } else {
            for (i in checkedpatientconditionList) {
                if (checkedpatientconditionList[i].conditionid === conditionid) {
                    checkedpatientconditionList.splice(i, 1);
                    checkedpatientconditions.delete(conditionid);
                    break;
                }
            }
        }
        if (checkedpatientconditions.size > 0) {
            document.getElementById('confirmorSetforConfirmation').style.display = 'block';
        } else {
            document.getElementById('confirmorSetforConfirmation').style.display = 'none';
        }
    }

</script>