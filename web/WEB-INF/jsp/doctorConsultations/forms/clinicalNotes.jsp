<%-- 
    Document   : clinicalNotes
    Created on : Oct 8, 2018, 7:03:16 AM
    Author     : HP
--%>

<%@include file="../../include.jsp" %>
<input type="hidden" name="_act" id="_act" value="${act}" />
<c:if test="${act=='a'}">
    <div class="row">
        <div class="col-md-7">
            <fieldset>
                <legend>Patient Complaints</legend>
                <div>
                    <div class="row after-add-more">
                        <div class="col-md-5">
                            <div class="tile">
                                <div class="tile-body">
                                    <div>
                                        <div class="form-group">
                                            <label for="batch">Complaint</label>
                                            <textarea class="patientscomplaint form-control complaint" id="complaintmain"
                                                      name="patientscomplaint[]" placeholder="Enter Complaints" rows="3"
                                                      required="required"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="tile">
                                <div class="tile-body">
                                    <div>
                                        <div class="form-group">
                                            <label for="batch">History</label>
                                            <textarea class="patientsComplaintdesc form-control history"
                                                      placeholder="Enter Complaint History" id="history" name="patientsComplaintdesc[]"
                                                      rows="3" ></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div>
                                <div class="form-group">
                                    <button type="button" class="btn btn-primary add-more">+ Add</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row control-group control-groupz">
                        <div class="col-md-5">
                            <div class="tile">
                                <div class="tile-body">
                                    <div>
                                        <div class="form-group">
                                            <label for="batch">Complaint</label>
                                            <textarea class="patientscomplaint form-control complaint" id="complaint"
                                                      name="patientscomplaint[]" placeholder="Enter Complaints" rows="3"
                                                      required="required"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="tile">
                                <div class="tile-body">
                                    <div>
                                        <div class="form-group">
                                            <label for="batch">History</label>
                                            <textarea class="patientsComplaintdesc form-control history"
                                                      placeholder="Enter Complaint History" id="history" name="patientscomplaintdesc[]"
                                                      rows="3"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div>
                                <div class="form-group">
                                    <button type="button" class="btn btn-primary remove">- Remove</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="col-md-5">
            <fieldset>
                <legend>Clinician's Observations/Diagnosis</legend>
                <div>
                    <div class="row">
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <div>
                                        <div class="form-group">
                                            <label for="batch">Observation</label>
                                            <textarea class="clinicianscomment form-control"
                                                      placeholder="Enter Observation/Diagnosis" id="observation"
                                                      rows="3"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <div>
                                        <div class="form-group">
                                            <label for="batch">Interim Diagnosis</label>
                                            <textarea class="clinicianscomment form-control"
                                                      placeholder="Enter Observation/Diagnosis" id ="diagnosis" name="diagnosis"
                                                      rows="3"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </fieldset>
            <div class="row">
                <div class="col-md-12 right" id="savepatientcomplaintsbtv">
                    <hr style="border:1px dashed #dddddd;">
                    <button type="button" id="savepeople" class="btn btn-primary" onclick="savepeople()">Save</button>
                </div>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${act=='b'}">
    <div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <fieldset>
                            <legend>Patient Complaints</legend>
                            <table class="table table-hover table-bordered" id="patientsCompaints">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Complaint</th>
                                        <th>History</th>
                                        <th>Update</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% int i = 1;%>
                                    <c:forEach items="${complaintsFound}" var="a">
                                        <tr>
                                            <td><%=i++%></td>
                                            <td>${a.patientcomplaint}</td>
                                            <td>${a.description}</td>
                                            <td align="center"><span title="Edit This Complaint."
                                                                     onclick="editpatientcomplaint(${a.patientcomplaintid}, '${a.patientcomplaint}', '${a.description}');"
                                                                     class="badge badge-danger icon-custom"><i
                                                        class="fa fa-edit"></i></span>|<span
                                                    title="Delete This Complaint."
                                                    onclick="deletepatientcomplaint(${a.patientcomplaintid});"
                                                    class="badge badge-danger icon-custom"><i
                                                        class="fa fa-trash-o"></i></span></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-md-12">
                                    <button type="button" onclick="addmorepatientcomplaints();"
                                            class="btn btn-primary pull-right">
                                        Add More Complaint(s)
                                    </button>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-6">

                        <div class="tile">
                            <div class="tile-body">

                                <fieldset>
                                    <legend>Clinician's Observations.</legend>
                                    <button type="button" onclick="addmoreobservations();"
                                            class="btn btn-primary pull-right">
                                        Add Observation
                                    </button>
                                    <c:forEach items="${commentsFound}" var="b">
                                        <div class="form-group">
                                            <label for="batch">Observation</label>
                                            <textarea class="clinicianscomment form-control"
                                                      placeholder="Enter Observation/Diagnosis" id="observation"
                                                      disabled="disabled" rows="5">${b.observation}</textarea>
                                        </div>

                                        <button type="button" class="btn pull-right"> <span
                                                title="Edit This Observation."
                                                onclick="editpatientComplaintObservations(${b.patientobservationid}, '${b.observation}');"
                                                class="badge badge-danger icon-custom"><i class="fa fa-edit"></i></span>
                                        </button>
                                        <button type="button" class="btn pull-right"> <span
                                                title="Delete This Observation."
                                                onclick="deleteObservation(${b.patientobservationid});"
                                                class="badge badge-danger icon-custom"><i
                                                    class="fa fa-trash-o"></i></span> </button>
                                            </c:forEach>
                                    <!--  <div class="row">
                                <div class="col-md-12">
                                    <button type="button" onclick="addmoreobservations();"
                                        class="btn btn-success pull-right">
                                        Add More Observation(s)
                                    </button>
                                </div>
                            </div> -->
                                </fieldset>
                            </div>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="tile">
                            <div class="tile-body">
                                <fieldset>
                                    <legend>Interim Diagnosis.</legend>
                                    
                                    <button type="button" onclick="addinterim();"
                                            class="btn btn-primary pull-right">
                                        Add Interim Diagnosis
                                    </button>
                                    <c:forEach items="${interimFound}" var="b">
                                        <div class="form-group">
                                            <label for="batch">Interim Diagnosis</label>
                                            <textarea class="clinicianscomment form-control"
                                                      placeholder="Enter Observation/Diagnosis" id="observation"
                                                      disabled="disabled" rows="5">${b.interimdiagnosis}</textarea>
                                        </div>
                                        <button type="button" class="btn pull-right"> <span
                                                title="Delete This Diagnosis."
                                                onclick="deleteinterim(${b.diagnosisid});"
                                                class="badge badge-danger icon-custom"><i
                                                    class="fa fa-trash-o"></i></span> </button>
                                            </c:forEach>
                                    <!--  <div class="row">
                                <div class="col-md-12">
                                    <button type="button" onclick="addmoreobservations();"
                                        class="btn btn-success pull-right">
                                        Add More Observation(s)
                                    </button>
                                </div>
                            </div> -->
                                </fieldset>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    <div class="copy hide">
        <div class="row control-groupz">
            <div class="col-md-5">
                <div class="tile">
                    <div class="tile-body">
                        <div>
                            <div class="form-group">
                                <label for="batch">Complaint</label>
                                <textarea class="patientscomplaint form-control complaint" id="complaint" name="patientscomplaint[]"
                                          placeholder="Enter Complaints" rows="3"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-5">
                <div class="tile">
                    <div class="tile-body">
                        <div>
                            <div class="form-group">
                                <label for="batch">History</label>
                                <textarea class="patientsComplaintdesc form-control history"
                                          placeholder="Enter Complaint History" id="history" rows="3"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div>
                    <div class="form-group">
                        <button type="button" class="btn btn-primary remove">- Remove</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        var complaintspatient = [];
        var countSet = new Set();
        var clinicianCommentSet = new Set();
        var clinicianComment = [];
        var numb = 0;
        //
        $(function () {
            var value = ($('#_act').val() === 'a') ? true : false;
            toggleTabs(value);
            $(".add-more").click(function () {
                var html = $(".copy").html();
                $(".after-add-more").after(html);
            });


            $("body").on("click", ".remove", function () {
                $(this).parents(".control-groupz").remove();
            });



        });

        function savepeople() {
            debugger
            var complaints = [];
            var complaintshistory = [];
            var result = "true";
            if ($('#observation').val() === "" && $('#complaintmain').val() === "") {
                $('#observation').css('borderColor', 'red');
                $('#complaintmain').css('borderColor', 'red');
            }
            if ($('#observation').val() === "" && $('#complaintmain').val() !== "") {
                $('#observation').css('borderColor', 'red');
                $('#complaintmain').css('borderColor', 'green');
            }
            if ($('#observation').val() !== "" && $('#complaintmain').val() === "") {
                $('#observation').css('borderColor', 'green');
                $('#complaintmain').css('borderColor', 'red');
            }
            if ($('#observation').val() !== "" && $('#diagnosis').val() === "") {
                $('#diagnosis').css('borderColor', 'red');
                $('#observation').css('borderColor', 'green');
            }
            
            
            if ($('#observation').val() !== "" && $('#complaintmain').val() !== "" && $('#diagnosis').val() !== "") {
                $('#observation').css('borderColor', 'green');
                $('#complaintmain').css('borderColor', 'green');
                $('#diagnosis').css('borderColor', 'green');
                jQuery("textarea.complaint").each(function () {
                    if (jQuery(this).val() === "") {
                    } else {
                        complaints.push(jQuery(this).val());
                    }
                });
                jQuery("textarea.history").each(function () {
                    if (jQuery(this).val() === "") {
                    } else {
                        complaintshistory.push(jQuery(this).val());
                    }
                });
                var complaintstemp = complaints;
                var complaintshistorytemp = complaintshistory;
                debugger
                complaints = [];
                complaintshistory = [];
                return savepatientscomplaintM(complaintstemp, complaintshistorytemp);
            } else {
                complaints = [];
                complaintshistory = [];
                return false;
            }
        }
        function savepatientscomplaintM(complaints, complaintshistory) {
            debugger
            var index = 0;
            var numb = 0;
            complaints.forEach(element => {
                numb++;
                countSet.add(parseInt(numb));
                if (element !== "") {
                    complaintspatient.push({
                        count: parseInt(numb),
                        patientcomplaint: element,
                        desc: complaintshistory[index]
                    });
                }
                index++;
            });

            clinicianCommentSet.add(1);
            clinicianComment.push({
                count: 1,
                observation: $('#observation').val()
            });

            debugger
            var interimdiagnosis = $('#diagnosis').val();
            var patientvisitid = $('#facilityvisitPatientvisitid').val();
            toggleCloseButton(patientvisitid);
            if (complaintspatient.length > 0 && clinicianComment.length > 0) {
                $.confirm({
                    title: 'PATIENT COMPLAINT AND OBSERVATIONS',
                    content: 'Saved Successfully',
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Ok',
                            btnClass: 'btn-purple',
                            action: function () {
                                $.ajax({
                                    type: 'POST',
                                    data: {complaintspatient: JSON.stringify(complaintspatient), clinicianComment: JSON.stringify(clinicianComment), patientvisitid: patientvisitid, interimdiagnosis: interimdiagnosis, act: 'b'},
                                    url: "doctorconsultation/savepatientscomplaintandcomments.htm",
                                    success: function (data, textStatus, jqXHR) {
                                        complaintspatient = [];
                                        toggleCloseButton(patientvisitid); //
                                        toggleTabs(false); //
                                        ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
                                });
                            }
                        },
                        close: function () {
                        }
                    }
                });
                return true;
            } else if (complaintspatient.length > 0 && clinicianComment.length < 1) {
                $.confirm({
                    title: 'PATIENT COMPLAINT AND OBSERVATIONS',
                    content: 'Are You Sure You Want Save Patient Complaints WithOut Your Observations?',
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Yes',
                            btnClass: 'btn-purple',
                            action: function () {
                                $.ajax({
                                    type: 'POST',
                                    data: {complaintspatient: JSON.stringify(complaintspatient), patientvisitid: patientvisitid, interimdiagnosis: interimdiagnosis, act: 'b'},
                                    url: "doctorconsultation/savepatientscomplaintandcomments.htm",
                                    success: function (data) {
                                        complaintspatient = [];
                                        toggleCloseButton(patientvisitid); // 
                                        toggleTabs(false); // 
                                        ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
                                });
                            }
                        },
                        close: function () {

                        }
                    }
                });
                return true;
            } else {
                return false;
            }
        }
        function addmorepatientcomplaints() {
            var patientvisitid = $('#facilityvisitPatientvisitid').val();
            $.confirm({
                title: 'Add More Patient Complaints',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label>Patient Complaint</label>' +
                        '<textarea placeholder="Enter Patient Complaint" class="form-control patientcomplaint" rows="2"></textarea>' +
                        '</div>' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label>Patient Complaint History</label>' +
                        '<textarea placeholder="Enter Patient Complaint History" class="form-control patientcomplainthistory" rows="2"></textarea>' +
                        '</div>' +
                        '</form>',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Save',
                        btnClass: 'btn-purple',
                        action: function () {
                            var complaint = this.$content.find('.patientcomplaint').val();
                            var history = this.$content.find('.patientcomplainthistory').val();
                            if (!complaint) {
                                $.alert('provide a valid Complaint');
                                return false;
                            }
                            if (!history) {
                                $.alert('provide a valid Complaint history');
                                return false;
                            }
                            complaintspatient.push({
                                count: parseInt(numb),
                                patientcomplaint: complaint,
                                desc: history
                            });
                            $.ajax({
                                type: 'POST',
                                data: {complaintspatient: JSON.stringify(complaintspatient), patientvisitid: patientvisitid, act: 'a'},
                                url: "doctorconsultation/savepatientscomplaintandcomments.htm",
                                success: function (data) {
                                    complaintspatient = [];
                                    toggleCloseButton(patientvisitid); // 
                                    ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });

                        }
                    },
                    close: function () {

                    }
                }
            });
        }
        function addmoreobservations() {
            var patientvisitid = $('#facilityvisitPatientvisitid').val();
            $.confirm({
                title: 'Add More Observation(s)',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label>Observation/Diagnosis</label>' +
                        '<textarea placeholder="Enter Observation/Diagnosis" class="form-control patientcomplaintobservation" rows="2"></textarea>' +
                        '</div>' +
                        '</form>',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Save',
                        btnClass: 'btn-purple',
                        action: function () {
                            var observation = this.$content.find('.patientcomplaintobservation').val();
                            if (!observation) {
                                $.alert('provide a valid Observations');
                                return false;
                            }
                            $.ajax({
                                type: 'POST',
                                data: {observation: observation, patientvisitid: patientvisitid},
                                url: "doctorconsultation/savepatientcomplaintobservation.htm",
                                success: function (data) {
                                    toggleCloseButton(patientvisitid); //
                                    ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    },
                    close: function () {
                    }
                }
            });
        }
        function addinterim() {
            var patientvisitid = $('#facilityvisitPatientvisitid').val();
            $.confirm({
                title: 'Add Interim Diagnosis',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label>Interim Diagnosis</label>' +
                        '<textarea placeholder="Enter Interim Diagnosis" class="form-control patientcomplaintobservation" rows="2"></textarea>' +
                        '</div>' +
                        '</form>',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Save',
                        btnClass: 'btn-purple',
                        action: function () {
                            var observation = this.$content.find('.patientcomplaintobservation').val();
                            if (!observation) {
                                $.alert('provide a valid Interim Diagnosis');
                                return false;
                            }
                            $.ajax({
                                type: 'POST',
                                data: {interim: observation, patientvisitid: patientvisitid},
                                url: "doctorconsultation/savepatientinterim.htm",
                                success: function (data) {
                                    toggleCloseButton(patientvisitid); //
                                    ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    },
                    close: function () {
                    }
                }
            });
        }
        function deletepatientcomplaint(patientcomplaintid) {
            var patientvisitid = $('#facilityvisitPatientvisitid').val();
            $.ajax({
                type: 'POST',
                data: {patientcomplaintid: patientcomplaintid, act: 'a'},
                url: "doctorconsultation/deletepatientcomplaintorobservation.htm",
                success: function (data) {
                    toggleCloseButton(patientvisitid); // 
                    ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        }
        function deleteObservation(patientobservationid) {
            var patientvisitid = $('#facilityvisitPatientvisitid').val();
            $.ajax({
                type: 'POST',
                data: {patientobservationid: patientobservationid, act: 'b'},
                url: "doctorconsultation/deletepatientcomplaintorobservation.htm",
                success: function (data) {
                    toggleCloseButton(patientvisitid); //
                    ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        }
        function deleteinterim(diagnosisid) {
            var patientvisitid = $('#facilityvisitPatientvisitid').val();
            $.ajax({
                type: 'POST',
                data: {patientdiagnosisid: diagnosisid, act: 'b'},
                url: "doctorconsultation/deletepatientinterim.htm",
                success: function (data) {
                    toggleCloseButton(patientvisitid); //
                    ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        }
        function editpatientcomplaint(patientcomplaintid, patientcomplaint, description) {
            var patientvisitid = $('#facilityvisitPatientvisitid').val();
            $.confirm({
                title: 'Update Patient Complaint',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label>Patient Complaint</label>' +
                        '<textarea class="form-control updatepatientcomplaint" rows="2">' + patientcomplaint + '</textarea>' +
                        '</div>' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label>Patient Complaint History</label>' +
                        '<textarea class="form-control updatepatientcomplainthist" rows="2">' + description + '</textarea>' +
                        '</div>' +
                        '</form>',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Update',
                        btnClass: 'btn-purple',
                        action: function () {
                            var complaint = this.$content.find('.updatepatientcomplaint').val();
                            var history = this.$content.find('.updatepatientcomplainthist').val();
                            if (!complaint) {
                                $.alert('provide a valid Complaint');
                                return false;
                            }
                            if (!history) {
                                $.alert('provide a valid Complaint history');
                                return false;
                            }
                            if (patientcomplaint === complaint && description === history) {

                            } else {
                                $.ajax({
                                    type: 'POST',
                                    data: {complaint: complaint, history: history, patientcomplaintid: patientcomplaintid, act: 'a'},
                                    url: "doctorconsultation/updatepatientcomplaint.htm",
                                    success: function (data) {
                                        toggleCloseButton(patientvisitid); //
                                        ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
                                });
                            }
                        }
                    },
                    close: function () {
                    }
                }
            });
        }
        function editpatientComplaintObservations(patientobservationid, observations) {
            var patientvisitid = $('#facilityvisitPatientvisitid').val();
            $.confirm({
                title: 'Update Observation/Diagnosis',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label>Observation/Diagnosis</label>' +
                        '<textarea class="form-control updatepatientobservation" rows="2">' + observations + '</textarea>' +
                        '</div>' +
                        '</form>',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Update',
                        btnClass: 'btn-purple',
                        action: function () {
                            var observation = this.$content.find('.updatepatientobservation').val();
                            if (!observation) {
                                $.alert('provide a valid Observation/Diagnosis.');
                                return false;
                            }
                            if (observation === observations) {

                            } else {
                                $.ajax({
                                    type: 'POST',
                                    data: {observation: observation, patientobservationid: patientobservationid, act: 'b'},
                                    url: "doctorconsultation/updatepatientcomplaint.htm",
                                    success: function (data) {
                                        toggleCloseButton(patientvisitid); //
                                        ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
                                });
                            }
                        }
                    },
                    close: function () {
                    }
                }
            });
        }
    </script>