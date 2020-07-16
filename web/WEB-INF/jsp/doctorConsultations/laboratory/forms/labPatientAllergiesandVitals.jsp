<%-- 
    Document   : labPatientAllergiesandVitals
    Created on : Oct 6, 2018, 12:24:43 PM
    Author     : HP
--%>
<%@include file="../../../include.jsp" %>
<div class="row">
    <div class="col-md-6">
        <fieldset>
            <legend>Patient Vitals</legend>
            <table class="table table-hover table-bordered" id="patientvitalsstable" style="width: 100% !important;">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Vital Name</th>
                        <th>Vital Measure</th>
                        <th>Update</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Blood Pressure</td>
                        <td align="center">
                            <c:choose>
                                <c:when test="${bloodpressure == 'pending'}">
                                    <strong>
                                        <a href="#"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${bloodpressure}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="center"><span  title="Update Of This Item." onclick="bloodpressureedit('${bloodpressure}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Weight</td>
                        <td align="center">
                            <c:choose>
                                <c:when test="${weight == 'pending'}">
                                    <strong>
                                        <a href="#"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${weight}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="center"><span  title="Update Of This Item." onclick="" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>Height</td>
                        <td align="center">
                            <c:choose>
                                <c:when test="${height == 'pending'}">
                                    <strong>
                                        <a href="#"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${height}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="center"><span  title="Update Of This Item." onclick="" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>Temperature</td>
                        <td align="center">
                            <c:choose>
                                <c:when test="${temperature == 'pending'}">
                                    <strong>
                                        <a href="#"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${temperature}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="center"><span  title="Update Of This Item." onclick="" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>Body Surface Area</td>
                        <td align="center">
                            <c:choose>
                                <c:when test="${bodysurfacearea == 'pending'}">
                                    <strong>
                                        <a href="#"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${bodysurfacearea}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="center"><span  title="Update Of This Item." onclick="" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td>Head Circum</td>
                        <td align="center">
                            <c:choose>
                                <c:when test="${headcircum == 'pending'}">
                                    <strong>
                                        <a href="#"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${headcircum}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="center"><span  title="Update Of This Item." onclick="" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                    </tr>
                    <tr>
                        <td>7</td>
                        <td>Pulse</td>
                        <td align="center">
                            <c:choose>
                                <c:when test="${pulse == 'pending'}">
                                    <strong>
                                        <a href="#"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${pulse}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="center"><span  title="Update Of This Item." onclick="" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                    </tr>
                    <tr>
                        <td>8</td>
                        <td>Respiration Rate</td>
                        <td align="center">
                            <c:choose>
                                <c:when test="${respirationrate == 'pending'}">
                                    <strong>
                                        <a href="#"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${respirationrate}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="center"><span  title="Update Of This Item." onclick="" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
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
                <div class="col-md-8">
                    <div class="form-group row">
                        <div class="col-sm-8">
                            <textarea class="form-control exampleFormControlTextarea1" id="exampleFormControlTextarea1" placeholder="Add Notes" rows="1"></textarea>
                        </div>
                        <input for="exampleFormControlTextarea1" onclick="savetriageaddednotes();" type="button" value="Add Notes" class="col-sm-4 btn btn-primary">
                    </div>
                </div>
            </div>
        </fieldset> 
    </div>
    <div class="col-md-6">
        <fieldset>
            <legend>Patient Allergies</legend>
            <div id="labpatientIssuesAndAllergiesDiv">

            </div>
        </fieldset> 
    </div>
</div>
<script>
    function savetriageaddednotes() {
        var patientvisit = $('#facilityLabvisitPatientvisitid').val();
    }
    function bloodpressureedit(bloodpressure) {
        var inputbloodpressure;
        if (bloodpressure === 'pending') {
            inputbloodpressure = '';
        } else {
            inputbloodpressure = bloodpressure;
        }
        var patientsvisitid = $('#facilityLabvisitPatientvisitid').val();
        $.confirm({
            title: 'UPDATE BLOOD PRESSURE',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Blood Pressure</label>' +
                    '<input type="text" placeholder="pending" value="' + inputbloodpressure + '" class="bloodpressure form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var bldpressure = this.$content.find('.bloodpressure').val();
                        if (!bldpressure) {
                            $.alert('provide a valid Blood Pressure.');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {patientvisitid: patientsvisitid},
                            url: "doctorconsultation/editpatienttriagedata.htm",
                            success: function (data) {
                                
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });

    }
</script>