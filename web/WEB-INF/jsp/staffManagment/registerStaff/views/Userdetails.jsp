<%--
    Document   : Userdetails
    Created on : Jun 1, 2018, 10:28:00 AM
    Author     : user
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<style>
    #heading{
        color: black;
    }
    #headingrow{
        background: linear-gradient(purple, white,purple);
    }
    #design{
        background-color: blueviolet;
        color: white;
        border-radius: 3px;
        font-size: 1.5em;
    }
    #namedesign{
        font-size: 1.2em;
    }
    #closebtn{
        border-radius: 5em;
    }

</style>
<div class="row">
    <div class="col-md-10"></div>
    <div class="col-md-2"><button class="btn btn-info" onclick="closemodule()"id="closebtn"><i class="fa fa-close"></i>Close Section</button></div>
</div>
<div class="tile">
    <input type="hidden" id="personid" value="${personid}">
    <input type="hidden" id="contactdetailsid" value="${contactdetailsid}">
    <input type="hidden" id="primarycontactid" value="${primarycontactid}">
    <input type="hidden" id="secondarycontactid" value="${secondarycontactid}">
    <div class="tile-body">
        <fieldset> <div class="row" id="headingrow">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <h3 id="heading" >
                        View/Edit Staff Details
                    </h3>
                </div>
                <div class="col-md-4"></div>
            </div>
            <div class="row" style="margin-top: 3em">
                <div class="col-md-1"></div>
                <div class="col-md-5">
                    <fieldset>
                        <legend><strong>Basic Details</strong></legend>
                        <div>
                            <div class="form-group bs-component">
                                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Staff Number:</strong></span>&nbsp;
                                <c:if test="${staffno == ' '}">
                                    <strong onclick="functionEditstaffno()" >
                                        <a href="#"><font color="blue" class="staffno">Pending</font></a>
                                    </strong>
                                </c:if>
                                <c:if test="${staffno != ' '}">
                                    <span class="badge badge-patientinfo patientConfirmFont" id=""><strong class="staffno">${staffno}</strong></span>
                                    <span>
                                        <a href="#" onclick="functionEditstaffno()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                    </span>
                                </c:if>
                            </div>
                            
                  <div class="form-group bs-component" id="old-patient-gender">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Title:</strong></span>&nbsp;
                        
                         <c:if test="${title == 'Pending'}">
                             <span id="patient-edit-title-container">
                                <strong onclick="functionEdittitle()">
                                    <a href="#"><font color="blue">Pending</font></a>
                                </strong>
                             </span>
                            </c:if>
                            
                            <c:if test="${title != 'Pending'}">
                                <span id="patient-edit-title-container">
                                <span class="badge badge-patientinfo patientConfirmFont" id=""><strong id="patient-edit-title">${title}</strong></span>
                                <span>
                                    <a href="#" onclick="functionEdittitle()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                                </span>
                            </c:if>
                        
                    </div>

                            <div class="form-group bs-component">
                                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>First Name:</strong></span>&nbsp;
                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${firstname}</strong></span>
                                <span><a href="#" onclick="functionEditFirstname()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                            </div>
                            <div class="form-group bs-component">
                                <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Last Name:</strong></span>&nbsp;
                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="lastname">${lastname}</strong></span>
                                <span><a href="#" onclick="functionEditLastname()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                            </div>
                            <div class="form-group bs-component">
                                <span class="control-label pat-form-heading patientConfirmFont" for="Othername"><strong>Other Name:</strong></span>&nbsp;
                                <c:if test="${empty othernames}">
                                    <strong onclick="functionEditOthername1()" >
                                        <a href="#"><font color="blue" class="othername">Pending</font></a>
                                    </strong>
                                </c:if>
                                <c:if test="${not empty othernames}">
                                    <span class="badge badge-patientinfo patientConfirmFont" id=""><strong class="othername">${othernames}</strong></span>
                                    <span>
                                        <a href="#" onclick="functionEditOthername()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                    </span>
                                </c:if>
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="col-md-5">
                    <fieldset>
                        <legend>Contact Details</legend>
                        
                    
                    <div class="form-group bs-component" id="old-patient-gender">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Gender:</strong></span>&nbsp;
                        
                         <c:if test="${gender == 'Pending'}">
                             <span id="patient-edit-gender-container">
                                <strong onclick="functionEditGender()">
                                    <a href="#"><font color="blue">Pending</font></a>
                                </strong>
                             </span>
                            </c:if>
                            
                            <c:if test="${gender != 'Pending'}">
                                <span id="patient-edit-gender-container">
                                <span class="badge badge-patientinfo patientConfirmFont" id=""><strong id="patient-edit-gender">${gender}</strong></span>
                                <span>
                                    <a href="#" onclick="functionEditGender()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                                </span>
                            </c:if>
                        
                    </div>
                    
                    
                    

                    
                         <div class="form-group bs-component">
                            <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Email:</strong></span>&nbsp;
                            <c:if test="${empty contactvalue}">
                                <strong onclick="Editmail1()" >
                                    <a href="#"><font color="blue" class="email">Pending</font></a>
                                </strong>
                            </c:if>
                            <c:if test="${not empty contactvalue }">
                                <span class="badge badge-patientinfo patientConfirmFont" id=""><strong class="email">${contactvalue}</strong></span>
                                <span>
                                    <a href="#" onclick="Editmail()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                            </c:if>
                        </div>
                   <div class="form-group bs-component">
                            <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Primary Telephone number:</strong></span>&nbsp;
                            <c:if test="${empty primarycontact}">
                                <strong onclick="Editprimarycontact()" >
                                    <a href="#"><font color="blue" class="primarycontact">Pending</font></a>
                                </strong>
                            </c:if>
                            <c:if  test="${not empty primarycontact}">
                                <span class="badge badge-patientinfo patientConfirmFont" id=""><strong class="primarycontact">${primarycontact}</strong></span>
                                <span>
                                    <a href="#" onclick="Editprimarycontact()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                            </c:if>
                        </div>
                        <div class="form-group bs-component">
                            <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Secondary Telephone number:</strong></span>&nbsp;
                            <c:if test="${empty Secondarycontact}">
                                <strong onclick="Editsecondarycontact1()" >
                                    <a href="#"><font color="blue" class="secondarycontact">Pending</font></a>
                                </strong>
                            </c:if>
                            <c:if test="${not empty Secondarycontact}">
                                <span class="badge badge-patientinfo patientConfirmFont" id=""><strong class="secondarycontact">${Secondarycontact}</strong></span>
                                <span>
                                    <a href="#" onclick="Editsecondarycontact()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                            </c:if>
                        </div>
                    </fieldset>
                </div>
                <div class="col-md-1"></div>
            </div>
            <div class="row" style="margin-top: 2em">
                <div class="col-md-1"></div>
                <div class="col-md-4">
                    <fieldset>
                        <legend>Job details</legend>
                        <div class="form-group bs-component">
                            <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Designation:</strong></span>&nbsp;
                            <c:if test="${empty designationname}">
                                <strong onclick="Editpost()" >
                                    <a href="#"><font color="blue" >Pending</font></a>
                                </strong>
                            </c:if>
                            <c:if test="${not empty designationname}">
                                <span class="badge badge-patientinfo patientConfirmFont" id=""><strong >${designationname}</strong></span>
                                <span>
                                    <a href="#" onclick="Editpost()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                            </c:if>
                        </div>
                        <div class="form-group bs-component">
                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Facility Unit(s):</strong></span>&nbsp;
                            <button  class="btn btn-info" onclick="showUnits()">${stafffacilityunits}</button>
                            <span><a href="#" onclick="Editunits()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                        </div>
                    </fieldset>
                </div>
                <div class="col-md-7"></div>
            </div>
        </fieldset>
    </div>
</div>
<div class="modal fade" id="editpost" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="title">Edit post</h5>
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
                                    <label class="control-label" id="space2" >Designation: </label>
                                </div>
                            </div>
                            <div class="col-md-9" >
                                <input class="form-control" value="${staffid}" id="staffid" style="display: none">
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
                    <button class="btn btn-primary " id="Editpost"><i class="fa fa-save">
                        </i>Submit
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
     debugger
     var patientPersonid = ${personid};
     //var ygd = ${title}.toString();
 

     $('#unitselect').select2();
    var Existingmail = ${jsonCreatedmail};
    var ExistingmailNameSet = new Set();
    for (var x in Existingmail) {
        if (Existingmail.hasOwnProperty(x)) {
            ExistingmailNameSet.add(Existingmail[x].contactvalue);
        }
    }
    function functionEditstaffno() {
        var staffno = $('.staffno').html();
        var staffid = $('#staffid').val();
        $.confirm({
            title: 'Edit!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Edit Staff Number</label>' +
                    '<input type="text" class="Staffno form-control" value=' + staffno + ' maxlength="30" required/>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var Staffnumber = this.$content.find('.Staffno').val();
                        var personid = $('#personid').val();
                        if (Staffnumber === '') {
                            $.alert('This field has been emptied');
                            return false;
                        } else if (Staffnumber === 'Pending') {
                            $.alert('You cant submit this information');
                            return false;
                        }
                        $.alert('Your Staff number is ' + Staffnumber);
                        $(".staffno").text(Staffnumber);
                        $.ajax({
                            type: 'POST',
                            data: {Staffnumber: Staffnumber, staffid: staffid},
                            url: "staffmanager/editstaffnumber.htm",
                            success: function (respose) {
                                ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    function functionEditFirstname() {
        var editfname = $('.fname').text();
        $.confirm({
            title: 'Edit!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Edit First Name</label>' +
                    '<input type="text" class="fname form-control" value=' + editfname + ' maxlength="30" required/>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var fname = this.$content.find('.fname').val();
                        var personid = $('#personid').val();

                        if (!fname) {
                            $.alert('You cannot submit an empty field!');
                            return false;
                        }
                        $.alert('Your name is ' + fname);
                        $(".fname").text(fname);
                        $.ajax({
                            type: 'POST',
                            data: {name: fname, personid: personid},
                            url: "staffmanager/updatefirstname.htm",
                            success: function (respose) {

                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    function functionEditLastname() {
        var lname = $('.lastname').html();
        $.confirm({
            title: 'Edit!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Edit Last Name</label>' +
                    '<input type="text" class="lname form-control" value=' + lname + ' maxlength="30" required/>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var lname = this.$content.find('.lname').val();
                        var personid = $('#personid').val();
                        if (!lname) {
                            $.alert('You cannot submit an empty field!');
                            return false;
                        }
                        $.alert('Your name is ' + lname);
                        $(".lastname").text(lname);
                        $.ajax({
                            type: 'POST',
                            data: {lname: lname, personid: personid},
                            url: "staffmanager/updatelastname.htm",
                            success: function (respose) {
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    function functionEditOthername() {
        var othername = $('.othername').html();
        $.confirm({
            title: 'Edit!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Edit Other Name</label>' +
                    '<input type="text" class="oname form-control" value=' + othername + ' maxlength="30" required/>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var Othername = this.$content.find('.oname').val();
                        var personid = $('#personid').val();
                        var staffid = $('#staffid').val();
                        if (Othername === '') {
                            $.alert('An empty field can not be submitted');
                            return false;
                        } else if (Othername === 'Pending') {
                            $.alert('You cant submit this information');
                            return false;
                        }
                        $.alert('Your name is ' + Othername);
                        $(".othername").text(Othername);
                        $.ajax({
                            type: 'POST',
                            data: {Othername: Othername, personid: personid},
                            url: "staffmanager/updateOthername.htm",
                            success: function (respose) {
                                ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    
    function functionEditOthername1() {
        var othername = $('.othername').html();
        $.confirm({
            title: 'Edit!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Edit Other Name</label>' +
                    '<input type="text" class="oname form-control" maxlength="30" required/>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var Othername = this.$content.find('.oname').val();
                        var personid = $('#personid').val();
                        var staffid = $('#staffid').val();
                        if (Othername === '') {
                            $.alert('An empty field can not be submitted');
                            return false;
                        } else if (Othername === 'Pending') {
                            $.alert('You cant submit this information');
                            return false;
                        }
                        $.alert('Your name is ' + Othername);
                        $(".othername").text(Othername);
                        $.ajax({
                            type: 'POST',
                            data: {Othername: Othername, personid: personid},
                            url: "staffmanager/updateOthername.htm",
                            success: function (respose) {
                                ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    
    
   function Editmail() {
        var emaill = $('.email').html();
        var personid = $('#personid').val();
        var contacttype = "EMAIL";
        $.confirm({
            title: 'Edit!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Edit mail contact</label>' +
                    '<input type="email" class="emailinput form-control" value=' + emaill + ' maxlength="30" required name="email"/>' +
                    '<div id="errormailx"></div>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var email = this.$content.find('.emailinput').val();
                        var contactdetailsid = $('#contactdetailsid').val();
                        if (!email) {
                            $.alert("Cannot submit an empty field");
                            return false;
                        } else if (email === "Pending") {
                            $.alert("Invalid submission values");
                            return false;
                        } else if (trim(email) === trim(emaill)) {
                            $.alert("The two Emails are the same");
                            return false;
                        } else if (ExistingmailNameSet.has(trim(email))) {
                            $.alert("Email already Exists");
                            return false;
                        } else {
                            if (contactdetailsid === '') {
                                if (ExistingmailNameSet.has(trim(email))) {
                                    $.alert("Email already Exists");
                                    return false;
                                } else {
                                    var $email = $('form input[name="email');
                                    var re = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
                                    if ($email.val() === '' || !re.test($email.val())) {
                                        $.alert('Please enter a valid email address.');
                                        return false;
                                    } else {
                                        $(".email").text(email);

                                        $.ajax({
                                            type: 'POST',
                                            data: {email: email, personid: personid, contacttype: contacttype},
                                            url: "staffmanager/addmail.htm",
                                            success: function (respose) {
                                            }
                                        });
                                    }
                                }
                            } else {
                                var $email = $('form input[name="email');
                                var re = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
                                if ($email.val() === '' || !re.test($email.val())) {
                                    $.alert('Please enter a valid email address.');
                                    return false;
                                } else {
                                    $(".email").text(email);
                                    $.ajax({
                                        type: 'POST',
                                        data: {email: email, contactdetailsid: contactdetailsid},
                                        url: "staffmanager/updatemail.htm",
                                        success: function (respose) {
                                        }
                                    });
                                }
                            }
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });

    }
    
    
    function Editmail1() {
        var emaill = $('.email').html();
        var personid = $('#personid').val();
        var contacttype = "EMAIL";
        $.confirm({
            title: 'Edit!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Edit mail contact</label>' +
                    '<input type="email" class="emailinput form-control" maxlength="30" required name="email"/>' +
                    '<div id="errormailx"></div>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var email = this.$content.find('.emailinput').val();
                        var contactdetailsid = $('#contactdetailsid').val();
                        if (!email) {
                            $.alert("Cannot submit an empty field");
                            return false;
                        } else if (email === "Pending") {
                            $.alert("Invalid submission values");
                            return false;
                        } else if (trim(email) === trim(emaill)) {
                            $.alert("The two Emails are the same");
                            return false;
                        } else if (ExistingmailNameSet.has(trim(email))) {
                            $.alert("Email already Exists");
                            return false;
                        } else {
                            if (contactdetailsid === '') {
                                if (ExistingmailNameSet.has(trim(email))) {
                                    $.alert("Email already Exists");
                                    return false;
                                } else {
                                    var $email = $('form input[name="email');
                                    var re = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
                                    if ($email.val() === '' || !re.test($email.val())) {
                                        $.alert('Please enter a valid email address.');
                                        return false;
                                    } else {
                                        $(".email").text(email);

                                        $.ajax({
                                            type: 'POST',
                                            data: {email: email, personid: personid, contacttype: contacttype},
                                            url: "staffmanager/addmail.htm",
                                            success: function (respose) {
                                      ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');

                                            }
                                        });
                                    }
                                }
                            } else {
                                var $email = $('form input[name="email');
                                var re = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
                                if ($email.val() === '' || !re.test($email.val())) {
                                    $.alert('Please enter a valid email address.');
                                    return false;
                                } else {
                                    $(".email").text(email);
                                    $.ajax({
                                        type: 'POST',
                                        data: {email: email, contactdetailsid: contactdetailsid},
                                        url: "staffmanager/updatemail.htm",
                                        success: function (respose) {
                                       ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');
                      
                                        }
                                    });
                                }
                            }
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });

    } 
    
    
    
    function trim(x) {
        return x.replace(/^\s+|\s+$/gm, '');
    }
    function Editprimarycontact() {
        var primarycontact = $('.primarycontact').html();
        var primarycontactid = $('#primarycontactid').val();
        $.confirm({
            title: 'Edit!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Primary Phone No:</label>' +
                    '<input type="text" class="form-control" value="' + primarycontact + '" id="primarycontactedit"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var Phonenoedit = this.$content.find('#primarycontactedit').val();
                        if (Phonenoedit === '') {
                            $.alert('You cant sumbit empty info');
                            return false;
                        } else if (Phonenoedit.length < 10) {
                            $.alert('The digits in the number are incomplete!');
                            return false;
                        } else if (Phonenoedit === 'Pending') {
                            $.alert('You cant submit this information');
                            return false;
                        } else if (ExistingmailNameSet.has(Phonenoedit)) {
                            $.alert("Contact already submitted");
                            return false;
                        } else if (primarycontact === Phonenoedit) {
                            $.alert('No changes made to contact value');
                            return false;
                        } else {
                            if (primarycontactid === '') {
                                $.alert('Your telephone contact is ' + Phonenoedit);
                                $(".primarycontact").text(Phonenoedit);
                                var personid = $('#personid').val();
                                var contacttype = "primaryconract";
                                var staffid = $('#staffid').val();
                                $.ajax({
                                    type: 'POST',
                                    data: {PrimaryContact: Phonenoedit, contacttype: contacttype, personid: personid},
                                    url: "staffmanager/addprimarycontact.htm",
                                    success: function (respose) {
                                        ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');
                                    }
                                });
                            } else {
                                $.alert('Your telephone contact is ' + Phonenoedit);
                                $(".primarycontact").text(Phonenoedit);
                                $.ajax({
                                    type: 'POST',
                                    data: {PrimaryContact: Phonenoedit, primarycontactid: primarycontactid},
                                    url: "staffmanager/updateprimarycontact.htm",
                                    success: function (respose) {
                                        ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');
                                    }
                                });
                            }
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#primarycontactedit').usPhoneFormat({
                    format: '(xxx) xxx-xxxx'
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    function Editsecondarycontact() {
        var secondarycontact = $('.secondarycontact').html();
        var secondarycontactid = $('#secondarycontactid').val();
        var personid = $('#personid').val();
        var contacttype = "Secondarycontact";
        $.confirm({
            title: 'Edit!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Secondary Phone No:</label>' +
                    '<input type="text" class="form-control" value="' + secondarycontact + '" id="secondarycontactedit"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var Secondarycontact = this.$content.find('#secondarycontactedit').val();
                        var staffid = $('#staffid').val();
                        if (Secondarycontact === '') {
                            $.alert('You cant sumbit empty info');
                            return false;
                        } else if (Secondarycontact.length < 10) {
                            $.alert('The digits in the number are incomplete!');
                            return false;
                        } else if (Secondarycontact === 'Pending') {
                            $.alert('You cant submit this information');
                            return false;
                        } else if (ExistingmailNameSet.has(Secondarycontact)) {
                            $.alert("Contact already submitted");
                            return false;
                        } else if (secondarycontact === Secondarycontact) {
                            $.alert('No changes made to contact value');
                            return false;
                        } else {
                            if (secondarycontactid === '') {
                                $.alert('Your telephone contact is ' + Secondarycontact);
                                $(".secondarycontact").text(Secondarycontact);
                                $.ajax({
                                    type: 'POST',
                                    data: {SecondaryContact: Secondarycontact, personid: personid, contacttype: contacttype},
                                    url: "staffmanager/addsecondarycontact.htm",
                                    success: function (respose) {
                                        ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');
                                    }
                                });

                            } else {
                                $.alert('Your telephone contact is ' + Secondarycontact);
                                $(".secondarycontact").text(Secondarycontact);
                                $.ajax({
                                    type: 'POST',
                                    data: {SecondaryContact: Secondarycontact, secondarycontactid: secondarycontactid, },
                                    url: "staffmanager/updatesecondarycontact.htm",
                                    success: function (respose) {
                                        ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');
                                    }

                                });

                            }
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#secondarycontactedit').usPhoneFormat({
                    format: '(xxx) xxx-xxxx'
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    
    function Editsecondarycontact1() {
        var secondarycontact = $('.secondarycontact').html();
        var secondarycontactid = $('#secondarycontactid').val();
        var personid = $('#personid').val();
        var contacttype = "Secondarycontact";
        $.confirm({
            title: 'Edit!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Secondary Phone No:</label>' +
                    '<input type="text" class="form-control" id="secondarycontactedit"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var Secondarycontact = this.$content.find('#secondarycontactedit').val();
                        var staffid = $('#staffid').val();
                        if (Secondarycontact === '') {
                            $.alert('You cant sumbit empty info');
                            return false;
                        } else if (Secondarycontact.length < 10) {
                            $.alert('The digits in the number are incomplete!');
                            return false;
                        } else if (Secondarycontact === 'Pending') {
                            $.alert('You cant submit this information');
                            return false;
                        } else if (ExistingmailNameSet.has(Secondarycontact)) {
                            $.alert("Contact already submitted");
                            return false;
                        } else if (secondarycontact === Secondarycontact) {
                            $.alert('No changes made to contact value');
                            return false;
                        } else {
                            if (secondarycontactid === '') {
                                $.alert('Your telephone contact is ' + Secondarycontact);
                                $(".secondarycontact").text(Secondarycontact);
                                $.ajax({
                                    type: 'POST',
                                    data: {SecondaryContact: Secondarycontact, personid: personid, contacttype: contacttype},
                                    url: "staffmanager/addsecondarycontact.htm",
                                    success: function (respose) {
                                        ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');
                                    }
                                });

                            } else {
                                $.alert('Your telephone contact is ' + Secondarycontact);
                                $(".secondarycontact").text(Secondarycontact);
                                $.ajax({
                                    type: 'POST',
                                    data: {SecondaryContact: Secondarycontact, secondarycontactid: secondarycontactid, },
                                    url: "staffmanager/updatesecondarycontact.htm",
                                    success: function (respose) {
                                        ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');
                                    }

                                });

                            }
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#secondarycontactedit').usPhoneFormat({
                    format: '(xxx) xxx-xxxx'
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    
    function Editpost() {
        $('#editpost').modal('show');
        $('#Editpost').click(function () {
            var designationselect = $("#designationselect").val();
            var staffid = $('#staffid').val();
            $.ajax({
                type: 'POST',
                data: {designationselect: designationselect, staffid: staffid},
                url: "staffmanager/editdesignation.htm",
                success: function (data, textStatus, jqXHR) {
                    $('#editpost').modal('hide');
                    $('body').removeClass('modal-open');
                    $('.modal-backdrop').remove();
                    ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');
                    $.notify({
                        title: "Update Complete : ",
                        message: "Your post has been edited",
                        icon: 'fa fa-check'
                    }, {
                        type: "info"
                    });
                }
            });
        });
    }
    function Editunits() {
        var editfname = $('.fname').text();
        var lname = $('.lastname').html();
        var othername = $('.othername').html();
        var fullname =editfname+" "+lname;
        var staffid = $('#staffid').val();
        $.ajax({
            type: 'GET',
            data: {staffid: staffid},
            url: "staffmanager/staffunits.htm",
            success: function (respose) {
                $.confirm({
                    title: '<strong class="center">Units for:' + '<font color="green">' + fullname + '</font>' + '</strong>',
                    content: '' + respose,
                    boxWidth: '60%',
                    height: '100%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    draggable: true
                });
            }
        });
    }
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
            content: contentStaffxList
        });
    }


    $(document).ready(function () { 
        $('#scontact').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });
    });
    function convertformat(id) {
        $('#' + id).usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });
    }
    function convertform(id) {
        $('#' + id).usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });
    }
    function closemodule() {
        $('#Usersearch').val('');
        $('#Userdetails').html('');
    }
    
     function functionEditGender() {
         debugger
        var editgender = $('#patient-edit-gender').text();
//        if (editgender === 'Female') {
            $.confirm({
                title: 'Edit Gender',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="">' +
                        ' <label class="control-label">Gender:</label>' +
                        ' <select class="form-control patientgenderedit" id="patientgenderedit">' +
                        '<option value="Female">Female</option>' +
                        '<option value="Male">Male</option>' +
                        ' </select>' +
                        '</div>' +
                        '</form>',
                boxWidth: '30%',
                useBootstrap: false,
                type: 'purple',
                typeAnimated: true,
                closeIcon: true,
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn-blue',
                        action: function () {
                            var patientgenderedit = this.$content.find('.patientgenderedit').val();

                            var data = {
                                updateGender: patientgenderedit,
                                personid: patientPersonid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "staffmanager/updateGender.htm",
                                data: data,
                                success: function (rep) {
//                                    $("#patient-edit-gender").text(patientgenderedit);
                                $("#patient-edit-gender-container").html('<span class="badge badge-patientinfo patientConfirmFont" id=""><strong>' + rep+'</strong></span><span><a href="#" onclick="functionEditGender()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>');  

                                }
                            });

                        }
                    },
                    cancel: function () {
                        //close
                    }
                },
                onContentReady: function () {
                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                }
            });

    }
    
    
    function functionaddgender() {
        $.confirm({
            title: 'Edit Gender',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="">' +
                    ' <label class="control-label">Gender:</label>' +
                    ' <select class="form-control patientgenderedit" id="patientgenderedit">' +
                    '<option value="Male">Male</option>' +
                    '<option value="Female">Female</option>' +
                    ' </select>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var patientgenderedit = this.$content.find('.patientgenderedit').val();
                        var data = {
                            updateGender: patientgenderedit,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updateGender.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-gender2").text(patientgenderedit);
                                $("#old-patient-gender").hide();
                                $("#new-patient-gender").show();
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    
 
  function functionEdittitle() {
//        var edittile = $('#patient-edit-title').text();

            debugger
            $.confirm({
             title: 'Edit Title',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Title</label>' +
                    '<select id="title" class="form-control">'+
                   '<option value="Doctor">Doctor</option>'+
                                '<option value="professor">professor</option>'+
                                '<option value="Mr">Mr</option>'+
                                '<option value="Mrs">Mrs</option>'+
                            '</select>' +
                    '</div>' +
                    '</form>',
                  boxWidth: '30%',
                useBootstrap: false,
                type: 'purple',
                typeAnimated: true,
                closeIcon: true,
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn-blue',
                        action: function () {
                            debugger
                            var title = this.$content.find('#title').val();
                          var patientPersonid = ${personid};

                            var data = {
                                updateTitle: title,
                                personid: patientPersonid
                            };
                 
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "staffmanager/updatetitle.htm",
                                data: data,
                                success: function (response) {
                                   debugger
//                                ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + staffid, 'GET');
                            
//                                    $("#patient-edit-title").text(response);
                                  $("#patient-edit-title-container").html('<span class="badge badge-patientinfo patientConfirmFont" id=""><strong>' + response +'</strong></span><span><a href="#" onclick="functionEdittitle()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>');  
                                }
                            });

                        }
                    },
                    cancel: function () {
                        //close
                    }
                },
                onContentReady: function () {
                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                }
            });
            
     

    }
    
    

    
    
    
    
</script>
