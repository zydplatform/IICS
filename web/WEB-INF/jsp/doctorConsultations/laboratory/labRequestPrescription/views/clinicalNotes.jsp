<%-- 
    Document   : clinicalNotes
    Created on : Oct 26, 2018, 11:42:22 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
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
                                    <textarea class="labpatientscomplaint form-control" placeholder="Enter Complaints" rows="3"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="batch">History</label>
                                    <textarea class="labpatientsComplaintdesc form-control" placeholder="Enter Complaint History" rows="3"></textarea>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-12 right">
                                    <button type="button" class="btn btn-primary" onclick="addlabpatientscomplaint();">
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
                                            <th>Complaint History</th>
                                            <th>Remove</th>
                                        </tr>
                                    </thead>
                                    <tbody id="labpatientsComplaintBody">

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
        <legend>Clinician's Observations/Diagnosis</legend>
        <div >
            <div class="row">
                <div class="col-md-4">
                    <div class="tile">
                        <div class="tile-body">
                            <div>
                                <div class="form-group">
                                    <label for="batch">Observations/Diagnosis</label>
                                    <textarea class="labclinicianscomment form-control" placeholder="Enter Observation/Diagnosis" rows="3"></textarea>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-12 right">
                                    <button type="button" class="btn btn-primary" onclick="addlabclinicianscomment();">
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
                                            <th>Observation/Diagnosis</th>
                                            <th>Remove</th>
                                        </tr>
                                    </thead>
                                    <tbody id="labcliniciansCommentsBody">

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
                <button type="button"  onclick="savelabpatientscomplaint();" class="btn btn-primary">Save</button>
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
                                            <td align="center"><span title="Edit This Complaint." onclick="labeditcomplaint(${a.patientcomplaintid}, '${a.patientcomplaint}', '${a.description}');" class="badge badge-danger icon-custom" ><i class="fa fa-edit"></i></span>|<span title="Delete This Complaint." onclick="labdeletecomplaint(${a.patientcomplaintid});"  class="badge badge-danger icon-custom" ><i class="fa fa-trash-o"></i></span></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table> 
                            <div class="row">
                                <div class="col-md-12">
                                    <button type="button"   onclick="labaddmorecomplaints();" class="btn btn-success pull-right">
                                        Add More Complaint(s)
                                    </button>
                                </div>
                            </div>
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
                                            <td align="center"><span title="Edit This Complaint." onclick="editlabpatientobservations(${b.patientobservationid}, '${b.observation}');"  class="badge badge-danger icon-custom" ><i class="fa fa-edit"></i></span>|<span title="Delete This Complaint." onclick="deletelabpatientobservations(${b.patientobservationid});" class="badge badge-danger icon-custom" ><i class="fa fa-trash-o"></i></span></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table> 
                            <div class="row">
                                <div class="col-md-12">
                                    <button type="button"   onclick="labaddmoreobservations();" class="btn btn-success pull-right">
                                        Add More Observation(s)
                                    </button>
                                </div>
                            </div>    
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>
<script>
    var labcomplaintspatient = [];
    var numcunts = 0;
    function labaddmorecomplaints() {
        var patientvisitid = $('#facilitylabvisitPatientvisitid').val();
        $.confirm({
            title: 'ADD PATIENT COMPLAINT',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Patient Complaint</label>' +
                    '<textarea placeholder="Enter Patient Complaint" class="form-control labpatientcomplaint" rows="2"></textarea>' +
                    '</div>' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Patient Complaint History</label>' +
                    '<textarea placeholder="Enter Patient Complaint History" class="form-control labpatientcomplainthistory" rows="2"></textarea>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Add',
                    btnClass: 'btn-purple',
                    action: function () {
                        var complaint = this.$content.find('.labpatientcomplaint').val();
                        var history = this.$content.find('.labpatientcomplainthistory').val();
                        if (!complaint) {
                            $.alert('provide a valid Complaint');
                            return false;
                        }
                        if (!history) {
                            $.alert('provide a valid Complaint history');
                            return false;
                        }
                        labcomplaintspatient.push({
                            count: parseInt(numcunts),
                            patientcomplaint: complaint,
                            desc: history
                        });
                        $.ajax({
                            type: 'POST',
                            data: {complaintspatient: JSON.stringify(labcomplaintspatient), patientvisitid: patientvisitid, act: 'a'},
                            url: "doctorconsultation/savepatientscomplaintandcomments.htm",
                            success: function (data) {
                                labcomplaintspatient = [];
                                numcunts = 0;
                                ajaxSubmitData('doctorconsultation/labpatientclinicalnotesform.htm', 'patientsenttolabnotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });


                    }
                },
                close: function () {
                }
            }
        });
    }
    function labaddmoreobservations() {
        var patientvisitid = $('#facilitylabvisitPatientvisitid').val();
        $.confirm({
            title: 'ADD OBSERVATION/DIAGNOSIS',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Observation/Diagnosis</label>' +
                    '<textarea class="form-control labobservationdiagnosis" id="exampleFormControlTextarea1" rows="3"></textarea>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Add',
                    btnClass: 'btn-purple',
                    action: function () {
                        var observation = this.$content.find('.labobservationdiagnosis').val();
                        if (!observation) {
                            $.alert('provide a valid Observation/Diagnosis');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {observation: observation, patientvisitid: patientvisitid},
                            url: "doctorconsultation/savepatientcomplaintobservation.htm",
                            success: function (data) {
                                ajaxSubmitData('doctorconsultation/labpatientclinicalnotesform.htm', 'patientsenttolabnotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function labeditcomplaint(patientcomplaintid, patientcomplaint, description) {
        var patientvisitid = $('#facilitylabvisitPatientvisitid').val();
        $.confirm({
            title: 'Update Patient Complaint',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Patient Complaint</label>' +
                    '<textarea class="form-control labupdatepatientcomplaint" rows="2">' + patientcomplaint + '</textarea>' +
                    '</div>' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Patient Complaint History</label>' +
                    '<textarea class="form-control labupdatepatientcomplainthist" rows="2">' + description + '</textarea>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var complaint = this.$content.find('.labupdatepatientcomplaint').val();
                        var history = this.$content.find('.labupdatepatientcomplainthist').val();
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
                                    ajaxSubmitData('doctorconsultation/labpatientclinicalnotesform.htm', 'patientsenttolabnotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
    function editlabpatientobservations(patientobservationid, observations) {
        var patientvisitid = $('#facilitylabvisitPatientvisitid').val();
        $.confirm({
            title: 'Update Observation/Diagnosis',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Observation/Diagnosis</label>' +
                    '<textarea class="form-control labupdatepatientobservation" rows="2">' + observations + '</textarea>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var observation = this.$content.find('.labupdatepatientobservation').val();
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
                                    ajaxSubmitData('doctorconsultation/labpatientclinicalnotesform.htm', 'patientsenttolabnotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
    function labdeletecomplaint(patientcomplaintid) {
        var patientvisitid = $('#facilitylabvisitPatientvisitid').val();
        $.ajax({
            type: 'POST',
            data: {patientcomplaintid: patientcomplaintid, act: 'a'},
            url: "doctorconsultation/deletepatientcomplaintorobservation.htm",
            success: function (data) {
                ajaxSubmitData('doctorconsultation/labpatientclinicalnotesform.htm', 'patientsenttolabnotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            }
        });
    }
    function deletelabpatientobservations(patientobservationid) {
        var patientvisitid = $('#facilitylabvisitPatientvisitid').val();
        $.ajax({
            type: 'POST',
            data: {patientobservationid: patientobservationid, act: 'b'},
            url: "doctorconsultation/deletepatientcomplaintorobservation.htm",
            success: function (data) {
                ajaxSubmitData('doctorconsultation/labpatientclinicalnotesform.htm', 'patientsenttolabnotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            }
        });
    }
    var labpatientcomplaints = [];
    var labpatientSet = new Set();
    var cnts = 0;
    function addlabpatientscomplaint() {
        var complaint = $('.labpatientscomplaint').val();
        var history = $('.labpatientsComplaintdesc').val();
        if (complaint === '') {
            $('.labpatientscomplaint').addClass("focus");
        } else {
            $('.labpatientscomplaint').removeClass("focus");
        }

        if (history === '') {
            $('.labpatientsComplaintdesc').addClass("focus");
        } else {
            $('.labpatientsComplaintdesc').removeClass("focus");
        }
        if (complaint !== '' && history !== '') {
            cnts++;
            labpatientSet.add(parseInt(cnts));
            labpatientcomplaints.push({
                count: parseInt(cnts),
                patientcomplaint: complaint,
                desc: history
            });
            
            $('#labpatientsComplaintBody').append('<tr id="labpatientcomplaints' + cnts + '"><td>' + complaint + '</td>' +
                    '<td>' + history + '</td>' +
                    '<td align="center"><span  title="Delete Of This Complaint." onclick="removeLabPatientComplaint(' + cnts + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');

            $('.labpatientscomplaint').val('');
            $('.labpatientsComplaintdesc').val('');
        }
    }
    function removeLabPatientComplaint(count) {
        for (i in labpatientcomplaints) {
            if (parseInt(labpatientcomplaints[i].count) === parseInt(count)) {
                labpatientcomplaints.splice(i, 1);
                labpatientSet.delete(parseInt(count));
                $('#labpatientcomplaints' + count).remove();
                break;
            }
        }
    }
    var labclinicianCommentSet = new Set();
    var labclinicianComment = [];
    var labnumb = 0;
    function addlabclinicianscomment() {
        var observation = $('.labclinicianscomment').val();
        if (!observation) {
            $('.labclinicianscomment').addClass("focus");
        } else {
            $('.labclinicianscomment').removeClass("focus");
            
            labnumb++;
            labclinicianCommentSet.add(parseInt(labnumb));
            labclinicianComment.push({
                count: parseInt(labnumb),
                observation: observation
            });
            $('#labcliniciansCommentsBody').append('<tr id="labpatientobservation' + labnumb + '"><td>' + observation + '</td>' +
                    '<td align="center"><span  title="Delete Of This Observation." onclick="remPatientComplaintObservation(' + labnumb + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');
            $('.labclinicianscomment').val('');
        }
    }
    function remPatientComplaintObservation(count) {
        for (i in labclinicianComment) {
            if (parseInt(labclinicianComment[i].count) === parseInt(count)) {
                labclinicianComment.splice(i, 1);
                labclinicianCommentSet.delete(parseInt(count));
                $('#labpatientobservation' + count).remove();
                break;
            }
        }
    }
    function savelabpatientscomplaint() {
        var patientvisitid = $('#facilitylabvisitPatientvisitid').val();
        if (labpatientcomplaints.length > 0 && labclinicianComment.length > 0) {
            $.ajax({
                type: 'POST',
                data: {complaintspatient: JSON.stringify(labpatientcomplaints), clinicianComment: JSON.stringify(labclinicianComment), patientvisitid: patientvisitid, act: 'b'},
                url: "doctorconsultation/savepatientscomplaintandcomments.htm",
                success: function (data) {
                    labpatientcomplaints = [];
                    ajaxSubmitData('doctorconsultation/labpatientclinicalnotesform.htm', 'patientsenttolabnotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        }
        if (labpatientcomplaints.length > 0 && labclinicianComment.length < 1) {
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
                                data: {complaintspatient: JSON.stringify(labclinicianComment), patientvisitid: patientvisitid, act: 'a'},
                                url: "doctorconsultation/savepatientscomplaintandcomments.htm",
                                success: function (data) {
                                    labclinicianComment = [];
                                    ajaxSubmitData('doctorconsultation/labpatientclinicalnotesform.htm', 'patientsenttolabnotesdiv', 'patientvisitid=' + patientvisitid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
