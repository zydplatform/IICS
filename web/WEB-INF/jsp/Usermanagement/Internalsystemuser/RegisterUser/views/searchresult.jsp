<%--
    Document   : searchresult
    Created on : Apr 5, 2018, 1:57:21 AM
    Author     : IICS PROJECT
--%>

<%@include file="../../../../include.jsp" %>

<div style="margin-top: -5em">
    <c:if test="${requestsent != 'sent' && alreadyuser == 'no'}">
        <div class="tile">
            <div class="tile-body">
                <h4></h4>
                <div class="" >
                    <div class="panel panel-info">
                        <div class="">
                            <div class="row">
                                <div class="col-md-3 " align="center"> <img alt="User Pic" src="static/images/profile-picture-placeholder.jpg" class="img-circle img-responsive"> </div>
                                <div class="col-md-1"></div>
                                <div class=" col-md-8 ">
                                    <table class="table table-user-information">
                                        <tbody>
                                            <tr>
                                                <td>Name:</td>
                                                <td >
                                                    <strong><font color="blue">${firstname}&nbsp;${lastname}&nbsp;${othernames}</font></strong>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Facility Unit(s):</td>
                                                <td><c:if test="${empty stafffacilityunitss}">
                                                        <a href="#editfacility" data-toggle="modal tooltip" data-target="#editfacility" id="missingfacility" data-placement="bottom" title="" data-original-title="Click to add a facility unit(s)">Missing</a>
                                                    </c:if>
                                                    <c:if test="${ not empty stafffacilityunitss}">
                                                        <button  class="btn btn-secondary" onclick="showUnits()">${stafffacilityunits}</button> 
                                                    </c:if>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Designation:</td>
                                                <c:if test="${(empty designationname)}">
                                                    <td>
                                                        <a href="#" data-toggle="modal tooltip" data-target="#editpost" id="missingpost" data-placement="bottom" title="" data-original-title="Click to add missing post">Missing</a>
                                                    </td>
                                                </c:if>
                                                <c:if test="${(not empty designationname)}">
                                                    <td >
                                                        ${designationname}
                                                    </td>
                                                </c:if>
                                            </tr>
                                            <tr>
                                                <td>Email address:</td>
                                                <c:if test="${empty contactvalue}">
                                                    <td >
                                                        <a href="#" data-toggle="modal tooltip" data-target="#editcontacts" id="editmail" data-placement="bottom" title="" data-original-title="Click to add missing email address">Missing</a>
                                                    </td>
                                                </c:if>
                                                <c:if test="${not empty contactvalue}">
                                                    <td >
                                                        ${contactvalue}
                                                    </td>
                                                </c:if>
                                            </tr>
                                            <tr>
                                                <td>Phone contact:</td>
                                                <td><a href="#">${primarycontact}</a></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="row" style="margin-top: -2em">
                                        <div class="col-md-9"></div>
                                        <div class="col-md-3" >
                                            <c:if test="${requestsent =='sent'}">
                                                <button class="btn btn-primary" type="button" id="submitbtn" data-id1="${staffid}" disabled><i class="fa fa-arrow-right">Send request</i></button>
                                            </c:if>
                                            <c:if test="${requestsent =='notsent' &&( empty contactvalue || empty designationname)}">
                                                <button class="btn btn-primary" type="button" id="submitbtn"  data-id1="${staffid}"  disabled><i class="fa fa-arrow-right">Send request</i></button>
                                            </c:if>
                                            <c:if test="${requestsent =='notsent' && not empty contactvalue && not empty designationname}">
                                                <button class="btn btn-primary" type="button" id="submitbtn"  data-id1="${staffid}" data-id2="RequestSent"><i class="fa fa-arrow-right">Send request</i></button>
                                            </c:if>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    <c:if test="${requestsent =='sent'}">
        <div class="row" style="margin-top: 5em">
            <div class="col-md-4"></div>
            <div class="col-md-6">
                <h5 style="color: red">Request for ${firstname} &nbsp;${lastname} has been sent!!! </h5>
            </div>
            <div class="col-md-2"></div>
        </div>
    </c:if>
    <c:if test="${alreadyuser == 'yes' && requestsent !='sent'}">
        <div class="row" style="margin-top: 5em">
            <div class="col-md-4"></div>
            <div class="col-md-6">
                <h5 style="color: red"> ${firstname} &nbsp;${lastname} is a system user!!! </h5>
            </div>
            <div class="col-md-2"></div>
        </div>
    </c:if>
</div>
<div class="modal fade" id="editcontacts" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="title">Add contact email</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="control-label" id="space1" style="margin-top: 1em">USERNAME:</label>
                                    <label class="control-label" id="space2" style="margin-top: 3em">email:</label>
                                </div>
                            </div>
                            <div class="col-md-9" >
                                <input class="form-control" value="${staffid}" id="staffid" style="display: none">
                                <input class="form-control" value="${personid}" id="personid" style="display: none">
                                <input class="form-control" value="Email" id="email" style="display: none">
                                <input class="form-control"  id="username" type="text" value="${firstname} &nbsp;${lastname}" placeholder="username" required style="margin-bottom: 2.5em" size="15" disabled="">
                                <input class="form-control" autofocus  id="emailofUser" type="Email" placeholder="enter Email" required>
                                <div id="errormailmsg"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="form-group ">
                    <button class="btn btn-primary " id="savemail"><i class="fa fa-save">
                        </i>Save
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="editpost" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="title">Add post</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="control-label" id="space1" style="margin-top: 1em">USERNAME:</label>
                                    <label class="control-label" id="space2" style="margin-top: 3em">Post </label>
                                </div>
                            </div>
                            <div class="col-md-9" >
                                <input class="form-control" value="${staffid}" id="staffid" style="display: none">
                                <input class="form-control"  id="username" type="text" value="${firstname} &nbsp;${lastname}" placeholder="username" required style="margin-bottom: 2.5em" size="15" disabled="">
                                <select class="form-control" id="designationselect">
                                    <c:forEach items="${designations}" var ="posts">
                                        <option id="designations" value="${posts.designationid}">${posts.designationname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="form-group ">
                    <button class="btn btn-primary " id="savepost"><i class="fa fa-save">
                        </i>Save
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="editfacility" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="title">Add facility unit(s):</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="control-label" id="space1" style="margin-top: 1em">USERNAME:</label>
                                    <label class="control-label" id="space2" style="margin-top: 3em">Unit(s): </label>
                                </div>
                            </div>
                            <div class="col-md-9" >
                                <input class="form-control" value="${staffid}" id="staffid" style="display: none">
                                <input class="form-control"  id="username" type="text" value="${firstname} &nbsp;${lastname}" placeholder="username" required style="margin-bottom: 2.5em" size="15" disabled="">
                                <select class="form-control" id="unitselect" multiple="">
                                    <c:forEach items="${units}" var ="unit">
                                        <option id="units" value="${unit.facilityunitid}">${unit.facilityunitname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="form-group ">
                    <button class="btn btn-primary " id="savefacility"><i class="fa fa-save">
                        </i>Save
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="unitview" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="title">Add staff Number</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="control-label" id="space1" style="margin-top: 1em">USERNAME:</label>
                                    <label class="control-label" id="space2" style="margin-top: 3em">Staff number: </label>
                                </div>
                            </div>
                            <div class="col-md-9" >
                                <input class="form-control" value="${personid}" id="personid" style="display: none">
                                <input class="form-control"  id="username" type="text" value="${firstname} &nbsp;${lastname}" placeholder="username" required style="margin-bottom: 2.5em" size="15" disabled="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="form-group ">
                    <button class="btn btn-primary " id="savestaffnumber"><i class="fa fa-save">
                        </i>Save
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="showstaffList" class="hidedisplaycontent">
    <div id="showstaffListContent"></div>
</div>                         
<script>
    function validateEmail(email) {
        var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    }
    $('#unitselect').select2();
    $('#editmail').click(function () {
        $('#editcontacts').modal('show');


    });
    $('#emailofUser').on('input', function () {
        var inputzone = $('#emailofUser').val().toLowerCase();
        var Existingmail = ${jsonCreatedzone};
        var ExistingZoneNameSet = new Set();
        for (var x in Existingmail) {
            if (Existingmail.hasOwnProperty(x)) {
                ExistingZoneNameSet.add(Existingmail[x].contactvalue);
            }
        }
        if (ExistingZoneNameSet.has(inputzone)) {
            $('#errormailmsg').html('<span style="color:red;">' + inputzone + ' Already Exists!!!</span>');
            document.getElementById('savemail').disabled = true;
            $('#editcontact').modal('hide');
        } else {
            $('#errormailmsg').html('');
            document.getElementById('savemail').disabled = false;

        }
    });

    $('#savemail').click(function () {
        validate();
        var email = $("#emailofUser").val();
        if (email === '') {
            document.getElementById('emailofUser').style.borderColor = "red";
        }
        function validate() {
            var $result = $("#errormailmsg");
            var email = $("#emailofUser").val();

            $result.text("");
            if (validateEmail(email)) {
                $result.text(email + " is valid :)");
                $result.css("color", "green");
                var emailofUser = $('#emailofUser').val();
                var personid = $('#personid').val();
                var email = $('#email').val();
                var staffid = $('#staffid').val();
                ajaxSubmitData('staffdetails.htm', 'staffinfo', 'staffid=' + staffid, 'GET');
                $.ajax({
                    type: 'POST',
                    data: {emailofUser: emailofUser, personid: personid, email: email},
                    url: "savemail.htm",
                    success: function (data, textStatus, jqXHR) {
                        $('#editcontacts').modal('hide');
                        $('body').removeClass('modal-open');
                        $('.modal-backdrop').remove();
                        ajaxSubmitData('staffdetails.htm', 'staffinfo', 'staffid=' + staffid, 'GET');
                    }
                });
            } else {
                $result.text(email + " is not valid :(");
                $result.css("color", "red");
            }
            return false;
        }
    });

    $('#missingpost').click(function () {
        $('#editpost').modal('show');
        $('#savepost').click(function () {
            var designationselect = $("#designationselect").val();
            var staffid = $('#staffid').val();
            $.ajax({
                type: 'POST',
                data: {designationselect: designationselect, staffid: staffid},
                url: "adddesignation.htm",
                success: function (data, textStatus, jqXHR) {
                    $('#editpost').modal('hide');
                    ajaxSubmitData('staffdetails.htm', 'staffinfo', 'staffid=' + staffid, 'GET');
                    $.notify({
                        title: "Update Complete : ",
                        message: "Post has been added",
                        icon: 'fa fa-check'
                    }, {
                        type: "info"
                    });
                }

            });
        });

    });


    $('#missingfacility').click(function () {
        $('#editfacility').modal('show');
        $('#savefacility').click(function () {
            var staffid = $('#staffid').val();
            var facilityunitset = new Set();
            var unitselect = $('#unitselect').val().toString();
            var indunits = unitselect.split(',');
            facilityunitset.add(indunits);
            for (i = 0; i < indunits.length; i++) {
                console.log(indunits[i]);
            }

            $.ajax({
                type: 'POST',
                data: {staffid: staffid, units: JSON.stringify(facilityunitset)},
                url: "saveunit.htm",
                success: function (data, textStatus, jqXHR) {
                    ajaxSubmitData('staffdetails.htm', 'staffinfo', 'staffid=' + staffid, 'GET');
                    $('#editfacility').modal('hide');
                    $('body').removeClass('modal-open');
                    $('modal-backdrop').remove();
                    $.notify({
                        title: "Update Complete : ",
                        message: "unit has been added",
                        icon: 'fa fa-check'
                    }, {
                        type: "info"
                    });

                }
            });
        });
    });


    $('#submitbtn').click(function () {
        document.getElementById("submitbtn").disabled = true;
        var staffid = $(this).attr('data-id1').toString();
        $.confirm({
            title: 'Alert!',
            content: 'Are u sure you wish to send this requests?',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {staffid: staffid},
                            url: "saverequests.htm",
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('staffdetails.htm', 'staffinfo', 'staffid=${staffid}', 'GET');
                                ajaxSubmitData('usermanagement/registeruser.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                clearSearchResult();
                                $('#editcontacts').modal('hide');
                                $('body').removeClass('modal-open');
                                $('.modal-backdrop').remove();
                            }
                        });
                    }
                },
                No: function () {
                }
            }
        });
    });

    function showUnits() {
        var jsonstafffacilityunitList = ${jsonstafffacilityunitss};
        $('#showstaffListContent').html('');
        for (index in jsonstafffacilityunitList) {
            var data = jsonstafffacilityunitList[index];
            $('#showstaffListContent').append('<p>' + data.facilityunitname + '</p>');
        }
        var contentStaffxList = $('#showstaffListContent').html();
        $.confirm({
            title: 'Facility Unit(s)',
            type: 'purple',
            content: contentStaffxList,
        });
    }
</script>
