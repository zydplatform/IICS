<%@include file="../../../include.jsp"%>
<link rel="stylesheet" type="text/css" href="static/res/css/jqueryNewDatePicker.css">
<div class="tile">
    <div class="tile-body" >
        <form class="form-horizontal" id="userDetailsform">
            <br>
            <div id="horizontalwithwords"><span class="pat-form-heading">Staff Details</span></div>
            <c:forEach items="${staffDetails}" var="staffDetail"> 
                <br>
                <div class="row">
                    <div class="col-md-6 boldedlabels">
                        Staff Name:
                    </div>
                    <div class="col-md-6 boldedlabels" id="issuedByNameValue">${staffDetail.firstname} ${staffDetail.lastname}
                        <input type="hidden" value="${staffDetail.staffid}" id="staffidIdDtails"/>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-md-6 boldedlabels">
                        Staff No:
                    </div>
                    <div class="col-md-6 boldedlabels" id="issuedByNameValue">${staffDetail.staffno}
                        <input type="hidden" value="${staffDetail.staffno}" id="staffnovalue"/></div>
                </div>
                <br>
                <div class="row">
                    <div class="col-md-6 boldedlabels">
                        Facility Unit Name:
                    </div>
                    <div class="col-md-6 boldedlabels" id="issuedByNameValue">${staffDetail.facilityunitname}
                        <input type="hidden" id="facilityunitidValue" value="${staffDetail.facilityunitid}"/>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-md-6 boldedlabels">
                        Designation Name:
                    </div>
                    <div class="col-md-6 boldedlabels" id="issuedByNameValue">${staffDetail.designationname}
                        <input type="hidden" value="${staffDetail.designationid}"/>
                    </div>
                </div>
            </c:forEach> 
            <br>
            <div id="returnDateContainer">
                <div class="row">
                    <div class="col-md-6 boldedlabels">
                        Return Date:
                    </div>
                    <div class="col-md-6 boldedlabels" id="issuedByNameValue">
                        <input value="" id="returnDateValue"class="form-control col-md-6" required />
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-md-6 boldedlabels">
                    </div>
                    <div class="col-md-6 boldedlabels" id="issuedByNameValue">
                        <input class="btn btn-primary col-md-6" style="margin-right:10px;"type="button" value="Issue" onclick="ajaxSubmitNewAssignment('fileassignment/saveassignment.htm', 'POST')"/>
                    </div>
                </div>

            </div>

            <div class="row" id="showReturnDateContainerx">
                <div class="col-md-6 boldedlabels">
                </div>
                <div class="col-md-6 boldedlabels" id="issuedByNameValue">
                    <input class="btn btn-primary col-md-6" style="margin-right:10px;"type="button" value="Assign Date" id="showReturnDateContainer"/>
                </div>
            </div>
            <br>
        </form>
    </div>
</div>
<script>
   
    $(document).ready(function () {
   $('#returnDateContainer').hide();
    
    $('#returnDateValue').datepicker({
            format: "dd/mm/yyyy",
            autoclose: true
        });
   
   $("#showReturnDateContainer").click(function () {
       
          $('#showReturnDateContainerx').hide();
           $('#returnDateContainer').show();
        });
        
     });
        function ajaxSubmitNewAssignment(Url, method) {
        var staffid= $('#staffidIdDtails').val();
        var fileno = $('#filenoValue').val();
        var fileid = $('#fileIdvalue').val();
         var facilityunitidValue = $('#facilityunitidValue').val();
        var returnDateValue = $('#returnDateValue').val();
        var data = {recepientStaffid : staffid,
            fileno:fileno, fileid:fileid,returnDateValue:returnDateValue,facilityunitid:facilityunitidValue};
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            timeout: 98000,
            success: function (resp) {
                if(resp==='success'){
                    confirmFileHandOvers();
                }else{
                    
                }
            },
            error: function (jqXHR, error, errorThrown) {
                if (Url !== 'checkUserNotification.htm') {
                    if (jqXHR.status && jqXHR.status === 400) {
                        alert('Server returned an Error, contact admin');
                    } else if (error === "timeout") {
                        alert("Request timed out, contact admin");
                    } else {
                        //                    alert("Something went wrong, contact system admin");
                    }
                }
            }
        });
    }
 function confirmFileHandOvers() {
                $.confirm({
                    title: 'Upadate File Assignment',
                    content: ''  +
                            '<form action="" class="formName">' +
                            '<div class="form-group">' +
                            '<label>USERNAME:</label>' +
                            '<input class="form-control"  id="borrowerusername" type="text" placeholder="username" required style="margin-bottom: 2.5em" size="15">'+
                            '</div>' +
                            '<div class="form-group">' +
                            '<label>PASSWORD:</label>' +
                            '<input class="form-control" id="borrowerpassword" type="password" placeholder="Password" required size="15">'+
                            '</div>' +
                            '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Confirm',
                            btnClass: 'btn btn-primary',
                            action: function () {
                               var password = this.$content.find('#borrowerpassword').val();
                                 var username = this.$content.find('#borrowerusername').val();
                                if (username!== null ||username!== ''||password !== null || password!== '') {
                                authenticateUser(password,username);
                            } else {
         $.alert({
        content: 'Fields can not be empty.',
              });  
                                }
                            }
                        },
                       cancel: function () {
                            //close
                        },
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
             function authenticateUser(password,username) {
      var pass;
       if(username=== ''&&password ===''){
            alert('Enter Your Credentials');
        }else{
           pass= md5(password);
        }
         $.ajax({
                type: "GET",
                cache: false,
                url: "fileassignment/confirmassignment.htm",
                data: {username:username,password:pass},
                success: function (response) {
             
              var obj = JSON.parse(response);
              if(obj.status==='success'){ 
              window.location = '#close';
              var fileid = $('#fileIdvalue').val();
                    var fileno = $('#filenovalue').val();
                    var pname = $('#pnamelabel').val();
                    var datecreatedId = $('#datecreatedIdvalue').val();
                    var statusId ='Out';
                    var staffid = $('#staffidvalue').val();
               viewPatientFileDetails(fileid, fileno, pname, datecreatedId, statusId, staffid);
                }else{
                $.alert({
       title: 'Feed Back',
        content: obj.message
              });
               }
                }
            });
        }
</script>
