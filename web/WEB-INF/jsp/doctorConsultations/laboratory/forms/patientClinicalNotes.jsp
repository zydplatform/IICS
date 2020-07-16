<%-- 
    Document   : patientClinicalNotes
    Created on : Oct 7, 2018, 10:08:13 AM
    Author     : HP
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${act=='a'}">
    <fieldset>
        <legend>Patient Complaints</legend>
        <div >
            <div class="row">
                <div class="col-md-4">
                    <div class="tile">
                        <div class="tile-body">
                            <div>
                                <div class="form-group">
                                    <label for="batch">Complaint</label>
                                    <input class="form-control patcomplaint" placeholder="Enter Complaint" type="text">
                                </div>
                                <div class="form-group">
                                    <label for="batch">Comments</label>
                                    <textarea class="patientComplaintdesc form-control" placeholder="Enter Complaint Description" rows="3"></textarea>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-12 right">
                                    <button type="button" class="btn btn-primary" onclick="addpatientcomplaint();">
                                        Add Complaint
                                    </button>
                                </div>
                            </div>  
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <table class="table table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Complaint</th>
                                            <th>Description</th>
                                            <th>Remove</th>
                                        </tr>
                                    </thead>
                                    <tbody id="patientComplaintBody">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    <fieldset>
        <legend>Clinician's Comments</legend>
        <div >
            <div class="row">
                <div class="col-md-4">
                    <div class="tile">
                        <div class="tile-body">
                            <div>
                                <div class="form-group">
                                    <label for="batch">Comments</label>
                                    <textarea class="clinicianscomments form-control" placeholder="Enter Comment" rows="3"></textarea>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-12 right">
                                    <button type="button" class="btn btn-primary" onclick="addclinicianscomments();">
                                        Add Comment
                                    </button>
                                </div>
                            </div>  
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <table class="table table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Comment</th>
                                            <th>Remove</th>
                                        </tr>
                                    </thead>
                                    <tbody id="clinicianCommentsBody">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    <div class="form-group">
        <div class="row">
            <div class="col-md-12 right" id="savepatientcomplaintsbtv">
                <hr style="border:1px dashed #dddddd;">
                <button type="button"  onclick="savelabpatientcomplaints();" class="btn btn-primary">Save</button>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${act=='b'}">
    <div >
        <div class="row">
            <div class="col-md-7">
                <div class="tile">
                    <div class="tile-body">
                        <fieldset>
                            <table class="table table-hover table-bordered" id="patientsCompaints">
                                <thead>
                                    <tr>
                                         <th>No</th>
                                        <th>Complaint</th>
                                        <th>Description</th>
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
                                            <td align="center"><span title="Edit This Complaint."  class="badge badge-danger icon-custom" ><i class="fa fa-edit"></i></span>|<span title="Delete This Complaint."  class="badge badge-danger icon-custom" ><i class="fa fa-trash-o"></i></span></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table> 
                        </fieldset>
                    </div>
                </div>
            </div>
            <div class="col-md-5">
                <div class="tile">
                    <div class="tile-body">
                        <fieldset>
                            <legend>Clinician's Observations.</legend>
                            <table class="table table-hover table-bordered" id="cliniciansObservations">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Observations.</th>
                                        <th>Update</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% int j = 1;%>
                                    <c:forEach items="${commentsFound}" var="b">
                                        <tr>
                                            <td><%=j++%></td>
                                            <td>${b.observation}</td>
                                            <td align="center"><span title="Edit This Complaint."  class="badge badge-danger icon-custom" ><i class="fa fa-edit"></i></span>|<span title="Delete This Complaint."  class="badge badge-danger icon-custom" ><i class="fa fa-trash-o"></i></span></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table> 
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>
<script>
    var labcunts = 0;
    var labcomplaintspatient = [];
    var labcountSet = new Set();
    function addpatientcomplaint() {
        var patientcomplaint = $('.patcomplaint').val();
        var desc = $('.patientComplaintdesc').val();
        if (patientcomplaint !== '' && desc !== '') {
            labcunts++;
            labcountSet.add(parseInt(labcunts));
            labcomplaintspatient.push({
                count: parseInt(labcunts),
                patientcomplaint: patientcomplaint,
                desc: desc
            });
            $('#patientComplaintBody').append('<tr id="labpatientcomplaints' + labcunts + '"><td>' + patientcomplaint + '</td>' +
                    '<td>' + desc + '</td>' +
                    '<td align="center"><span  title="Delete Of This Complaint." onclick="removelabPatientComplaint(' + labcunts + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');

            $('.patcomplaint').val('');
            $('.patientComplaintdesc').val('');
        }
    }
    function removelabPatientComplaint(labcunts) {
        for (i in labcomplaintspatient) {
            if (parseInt(labcomplaintspatient[i].count) === parseInt(labcunts)) {
                labcomplaintspatient.splice(i, 1);
                labcountSet.delete(parseInt(labcunts));
                $('#labpatientcomplaints' + labcunts).remove();
                break;
            }
        }
    }
    var labclinicianCommentSet = new Set();
    var labclinicianComment = [];
    var labnumb = 0;
    function addclinicianscomments() {
        var patientobservation = $('.clinicianscomments').val();
        if (patientobservation !== '') {
            labnumb++;
            labclinicianCommentSet.add(parseInt(labnumb));
            labclinicianComment.push({
                count: parseInt(labnumb),
                observation: patientobservation
            });

            $('#clinicianCommentsBody').append('<tr id="labpatientobservation' + labnumb + '"><td>' + patientobservation + '</td>' +
                    '<td align="center"><span  title="Delete Of This Observation." onclick="removeLabPatientComplaintObservation(' + labnumb + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');
            $('.clinicianscomment').val('');
        }
    }
    function removeLabPatientComplaintObservation(labnumb) {
        for (i in labclinicianComment) {
            if (parseInt(labclinicianComment[i].count) === parseInt(labnumb)) {
                labclinicianComment.splice(i, 1);
                labclinicianCommentSet.delete(parseInt(labnumb));
                $('#labpatientobservation' + labnumb).remove();
                break;
            }
        }
    }
    function savelabpatientcomplaints() {
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        if (labcomplaintspatient.length > 0 && labclinicianComment.length > 0) {
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
                                data: {complaintspatient: JSON.stringify(labcomplaintspatient), clinicianComment: JSON.stringify(labclinicianComment), patientvisitid: patientvisitid,act:'b'},
                                url: "doctorconsultation/savepatientscomplaintandcomments.htm",
                                success: function (data, textStatus, jqXHR) {
                                    ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientvisitid='+patientvisitid+'&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    },
                    close: function () {
                    }
                }
            });
        }
        if (labcomplaintspatient.length > 0 && labclinicianComment.length < 1) {
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
                                                data: {complaintspatient: JSON.stringify(labcomplaintspatient), patientvisitid: patientvisitid,act:'a'},
                                                url: "doctorconsultation/savepatientscomplaintandcomments.htm",
                                                success: function (data, textStatus, jqXHR) {
                                                    ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientvisitid='+patientvisitid+'&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                }
                                            });
                                        }
                                    },
                                    close: function () {
                                    }
                                }
                            });
                        }
                    },
                    close: function () {

                    }
                }
            });
        }
    }
</script>
