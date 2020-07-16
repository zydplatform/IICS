<%-- 
    Document   : Staffregform
    Created on : Jun 1, 2018, 10:20:19 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<!DOCTYPE html>

<style>
    #heading{
        color: black;
    }
    #headingrow{
        background: linear-gradient(purple, white,purple);
    }
    #row1{
        margin-top: 3em;
    }

    .required:after { 
        content:" *"; 
        color: red;
    }
    #textsize{
        max-width: 10ch;
    }
    #closebtn{
        border-radius: 5em;
    }
    .capitalize {
        text-transform: capitalize;   
    }
</style>
<div class="row">
    <div class="col-md-10"></div>
    <div class="col-md-2"><button class="btn btn-info" onclick="closemodule()"id="closebtn"><i class="fa fa-close"></i>Close Section</button></div>
</div>
<div class="row" id="headingrow">
    <div class="col-md-4"></div>
    <div class="col-md-4">
        <h3 id="heading" >
            Staff Registration form
        </h3>

    </div>
    <div class="col-md-4"></div>
</div>
<div class="tile">
    <div class="tile-body">
        <form id="userregform">
            <div class="row" style="margin-top: 2em">
                <div class="col-md-4">
                    <div class="tile">
                        <div class="tile-body">
                            <div id="horizontalwithwords"><span class="pat-form-heading">BASIC DETAILS</span></div>
                            <label class="control-label" for="staffnumber">Staff number:</label>
                            <input style="display: unset !important" class="form-control col-md-10" id="staffnumber" name="staffnumber" value="${StaffgenNumber}" readonly="readonly"><span><a id="editStaffno"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span><br>&nbsp;&nbsp;

                             <div class="form-group">
                                <label for="firtname" class="required">Title</label>
                               
                            <select id="title" class="form-control"> <option>Select</option>
                                <option>Doctor</option>
                                <option>professor</option>
                                <option>Mr</option>
                                <option>Mrs</option>
                            </select>
                            </div>
                            
                            
                            <div class="form-group">
                                <label for="firstname" class="required">First Name</label>
                                <input class="form-control capitalize" id="fname" maxlength="30" type="text" placeholder="Enter First Name" value="${userFirstName}" >
                            </div>
                            <div class="form-group">
                                <label for="lastname" class="required" >Last Name</label>
                                <input class="form-control capitalize" id="lastname" type="text" maxlength="30" aria-describedby="emailHelp" placeholder="Enter Last Name" value="${userLastName}">
                            </div>
                            <div class="form-group">
                                <label for="othername">Other Name</label>
                                <input class="form-control capitalize" id="othername" type="text" maxlength="30" aria-describedby="emailHelp" placeholder="Enter Other name" value="${userOtherName}">
                            </div>

                        </div>
                    </div> 
                </div>
                <div class="col-md-4">
                    <div class="tile">
                        <div class="tile-body">
                            <div id="horizontalwithwords"><span class="pat-form-heading">Contact Details</span></div> 
                            
<!--                             <div class="form-group">
                                <label for="firstname" class="required">Gender</label>
                                <br>
                               
                                <form action="" >
                              <input type="radio" name="gender" value="male"class="sex"> Male<br>
                              <input type="radio" name="gender" value="female" class="sex"> Female<br>
                              <input type="radio" name="gender" value="other" class="sex"> Other
                            </form>
                            </div>-->
                            <div class="form-group">
                                <div>
                                    <label class="required">Gender</label>
                                </div>
                                <div class="form-check" id="genderdiv">
                                    <label class="form-check-label">
                                        <input id="malegender" value="Male" class="form-check-input" type="radio" name="gender"><span class="label-text">Male</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </label>

                                    <label class="form-check-label">
                                        <input id="femalegender" value="Female" class="form-check-input" type="radio" name="gender"><span class="label-text">Female</span>
                                    </label>
                                </div>
                            </div>  <div class="form-group" >
                                <label for="email">Email address</label>
                                <input class="form-control" id="email" type="email" data-idemail="EMAIL" placeholder="Enter email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$">
                            </div> 
                            <div id="errormailmsg"></div>
                            <div id="correctmail"></div>
                            <div class="form-group">
                                <label for="primarycontact" class="required">Primary Phone contact</label>
                                <input class="form-control" id="pcontact" type="text" aria-describedby="emailHelp" placeholder="Enter number" data-idprimary="PRIMARYCONTACT">
                            </div> 
                            <div class="form-group">
                                <label for="secondarycontact">Secondary Phone contact</label>
                                <input class="form-control" id="scontact" type="text" aria-describedby="emailHelp" placeholder="Enter number" data-idsecondary="SECONDARYCONTACT">
                            </div>


                            <div class="tile-footer">
                                <div class="form-group">
                                    <div class="btn-group">
                                        <a class="btn btn-select btn-outline-primary dropdown-toggle" data-toggle="dropdown" href="#"><i class="fa fa-picture-o"></i>Add Photo<span class="caret"></span></a>
                                        <div class="dropdown-menu myselect">
                                            <a class="dropdown-item" href="#"  onid="addpatientphoto1" data-toggle="modal">From WebCam</a>
                                            <a class="dropdown-item" href="#"  id="scannedpics" data-toggle="modal">From Scanner</a>
                                            
                                        </div>
                                    </div>

                                    <button class ="btn btn-outline-primary float-right" type="button">
                                        <i class="fa fa-hand-paper-o"></i>
                                        <span style="font-weight: bold">Enroll Finger Print</span>
                                        
                                    </button>
                                </div>
                            </div>

                            <div id="errosecontact"></div>
                        </div>
                    </div> 
                </div>
                <div class="col-md-4">
                    <div class="tile">
                        <div class="tile-body">
                            <div id="horizontalwithwords"><span class="pat-form-heading">Job details</span></div>
                            <label for="Designation" class="required">Designation(s)</label>
                            <select class="form-control" id="designationselect" width= "80%" >
                                <c:forEach items="${designations}" var ="posts">
                                    <option id="designations" value="${posts.designationid}">${posts.designationname}</option>
                                </c:forEach>
                            </select>
                            <div class="form-group">
                                <label for="facilityunit" class="required">Facility unit(s)</label>
                                <select class="form-control" id="unitselect" multiple="" required="true">
                                    <c:forEach items="${units}" var ="unit">
                                        <option id="units" value="${unit.facilityunitid}">${unit.facilityunitname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div id="errorunit"></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-5"></div>
                        <div class="col-md-3">
                            <button class="btn btn-secondary " id="clear"><i class="fa fa-close">
                                </i>clear
                            </button>
                        </div>
                        <div class="col-md-3">
                            <button class="btn btn-primary " id="saveuser"><i class="fa fa-save">
                                </i>Save
                            </button>



                        </div>

                        <div class="col-md-1"></div>
                    </div>
                </div>
            </div> 
        </form>
    </div>
</div>

<!--model Capture Scanned Image-->
<div class="modal fade" id="modelscannedpics" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="" id="dialogs">Add Staff Scanned Photo</h3>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <form class="form-group">
                            <div class="form-group">
                                <label class="control-label">Reference Number</label>
                                <input class="form-control" id="" type="text" placeholder="Enter Reference Number">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" >Save</button>
            </div>
        </div>
    </div>
</div>                        


<script>
    $(function () {
        $('#designationselect').select2();
        $('#unitselect').select2();
        $('.select2').css('width', '100%');
    });
</script>
<script>
    function checkEmail() {
        var patt = /[a-z0-9._%+-]+@[a-z0-9.]+\.[a-z]{2,3}$/;
        var res = patt.test($('#email').val());
        return res;
    }
    $('#email').on('input', function () {
        document.getElementById('email').style.removeProperty('border');
        var inputmail = $('#email').val().toLowerCase();
        var Existingmail = ${jsonCreatedmail};
        var ExistingmailNameSet = new Set();
        for (var x in Existingmail) {
            if (Existingmail.hasOwnProperty(x)) {
                ExistingmailNameSet.add(Existingmail[x].contactvalue);
            }
        }
        if (ExistingmailNameSet.has(inputmail) || !checkEmail()) {
            if (ExistingmailNameSet.has(inputmail)) {
                $('#errormailmsg').html('<span style="color:red;">' + inputmail + ' Already Exists!!!</span>');
            }
            $('#saveuser').prop('disabled', true);
        } else {
            $('#saveuser').prop('disabled', false);
            $('#errormailmsg').html('');
        }
    });

    $('#pcontact').on('input', function () {
        document.getElementById('pcontact').style.removeProperty('border');
        var pcontact = $('#pcontact').val().toLowerCase();
        var Existingmail = ${jsonCreatedmail};
        var ExistingmailNameSet = new Set();
        for (var x in Existingmail) {
            if (Existingmail.hasOwnProperty(x)) {
                ExistingmailNameSet.add(Existingmail[x].contactvalue);
            }
        }
        if (ExistingmailNameSet.has(pcontact)) {
            $('#errorcontact').html('<span style="color:red;">' + pcontact + ' Already Exists!!!</span>');
        } else {
            $('#errorcontact').html('');
        }

    });
    $('#scontact').on('input', function () {
        var scontact = $('#scontact').val().toLowerCase();
        var Existingmail = ${jsonCreatedmail};
        var ExistingmailNameSet = new Set();
        for (var x in Existingmail) {
            if (Existingmail.hasOwnProperty(x)) {
                ExistingmailNameSet.add(Existingmail[x].contactvalue);
            }
        }
        if (ExistingmailNameSet.has(scontact)) {

            $('#errosecontact').html('<span style="color:red;">' + scontact + ' Already Exists!!!</span>');
        } else {
            $('#errosecontact').html('');
        }

    });
    $('#clear').click(function () {
        document.getElementById("userregform").reset();
    });
    function titleCase(str) {
        var splitStr = str.toLowerCase().split(' ');
        for (var i = 0; i < splitStr.length; i++) {
            splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);
        }
        return splitStr.join(' ');
    }
    $('#saveuser').click(function () {
        debugger
        
        
        
        var emailflag = $('#email').attr('data-idemail');
        var primarycontactflag = $('#pcontact').attr('data-idprimary');
        var secondarycontactflag = $('#scontact').attr('data-idsecondary');
        var fname = $('#fname').val();
        var fnames = titleCase(fname);
        var lastname = $('#lastname').val();
        var lastnames = titleCase(lastname);
        var othername = $('#othername').val();
        var othernames = titleCase(othername);
        var email = $('#email').val();
        var pcontact = $('#pcontact').val();
        var scontact = $('#scontact').val();
        var designationselect = $('#designationselect').val();
        var unitselect = $('#unitselect').val();
        var staffnumber = $('#staffnumber').val();
        var options = $('#unitselect > option:selected');
         var title = $('#title').val();
          var Gender = $("input:radio[name=gender]:checked").val();
//        var Gender = $('.sex').val();
debugger
        if (title===''|| title==='Select'||Gender===''|| fname === '' || lastname === ''|| pcontact === '' || options.length === 0 || staffnumber === '') {
            alert("Please make sure to fill in all the required input fields");
        } else {
            document.getElementById('saveuser').disabled = false;
            $('#Newuserregform').html('');
            $.ajax({
                type: 'POST',
                data: {title:title,Gender:Gender,emailflag: emailflag, primarycontactflag: primarycontactflag, secondarycontactflag: secondarycontactflag, fname: fnames, lastname: lastnames, othername: othernames, email: email, pcontact: pcontact, scontact: scontact, designationselect: designationselect, unitselect: JSON.stringify(unitselect), staffnumber: staffnumber},
                url: "staffmanager/savenewuser.htm",
                success: function (data) {

                }
            });
            debugger
            $.notify({
                title: "Registration Complete : ",
                message: "This user has successfully been registered",
                icon: 'fa fa-check'
            }, {
                type: "info"
            });
        }
    });
    $('#fname').on('input', function () {
        document.getElementById('fname').style.removeProperty('border');
        var elem = $("#fname").val();
        if (elem) {
            elem.keydown(function () {
                if (elem.val().length > 10)
                    elem.val(elem.val().substr(0, 10));
            });
        }
    });
    $('#lastname').on('input', function () {
        document.getElementById('lastname').style.removeProperty('border');

    });
    $('#editStaffno').click(function () {
        document.getElementById("staffnumber").readOnly = false;
        document.getElementById('staffnumber').focus();
    });
    $(document).ready(function () {
        $('#pcontact').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });
        $('#scontact').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });
    });
    function closemodule() {
        $('#Newuserregform').html('');
    }

    $('#scannedpics').click(function () {
        $('#modelscannedpics').modal('show');
    });

    //trials  










</script>
<script type="text/javascript">
    function onBtnUploadClick() {
        var imageViewer = dcsObject.getImageViewer('image-container');
        var counter,
                url = getCurPagePath() + 'ActionPage.jsp',
                fileName = “test.jpg”,
                imageType = imageViewer.io.EnumImageType.JPEG;
        imageIndexArray = [0];

        imageViewer.io.setHTTPFormFields({"fileName": fileName});
        imageViewer.io.httpUploadAsync(url, imageIndexArray, imageType, onUploadSuccess, onUploadFailure);

    }
</script>
