<%-- 
    Document   : viewdonordetails
    Created on : Sep 1, 2018, 11:31:23 PM
    Author     : SAMINUNU
--%>
<%@include file="../../../../include.jsp" %>
<style>
    .cl{color: #465cba;}
</style>
<div>
<input class="form-group" id="donorprogramid" value="${donorprogramid}" type="hidden">
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend><strong>Basic Details</strong></legend>
                <div>
                    <div class="form-group bs-component">   
                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Donor Name:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="donor-edit-name">${donorname}</strong></span>
                        <span><a href="#" onclick="editfacDonorName()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Donor Email:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="donor-edit-email">${email}</strong></span>
                        <span><a href="#" onclick="editfacDonorEmail()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Donor Telno.:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="donor-edit-telno">${telno}</strong></span>
                        <span><a href="#" onclick="editfacDonorTelno()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Donor Fax:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="donor-edit-fax">${fax}</strong></span>
                        <span><a href="#" onclick="editfacDonorFax()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                    </div>


                </div>
            </fieldset>
        </div>

    </div>
</div>
<script>
    function editfacDonorName() {
        var donorname = $('#donor-edit-name').text();
        var donorprogramid = $('#donorprogramid').val();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Donor Name:</label>' +
                    '<input type="text" class="form-control" value="' + donorname + '" id="dnameedit"/>' +
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
                        var dnameedit = this.$content.find('#dnameedit').val();

                        var data = {
                            updatedname: dnameedit,
                            donorprogramid: donorprogramid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "internaldonorprogram/updateName.htm",
                            data: data,
                            success: function (rep) {
                                $("#donor-edit-name").text(dnameedit);
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

    function editfacDonorEmail() {
        var editemail = $('#donor-edit-email').text();
        var donorprogramid = $('#donorprogramid').val();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Donor Email:</label>' +
                    '<input type="text" class="form-control" value="' + editemail + '" id="emailedit"/>' +
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
                        var emailedit = this.$content.find('#emailedit').val();
                        console.log("-----------------------email"+emailedit);

                        var data = {
                            updateemail: emailedit,
                            donorprogramid: donorprogramid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "internaldonorprogram/updateEmail.htm",
                            data: data,
                            success: function (rep) {
                                $("#donor-edit-email").text(emailedit);
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

    function editfacDonorTelno() {
        var edittelno = $('#donor-edit-telno').text();
        var donorprogramid = $('#donorprogramid').val();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Donor Tel No.:</label>' +
                    '<input type="text" class="form-control" value="' + edittelno + '" id="telnoedit"/>' +
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
                        var telnoedit = this.$content.find('#telnoedit').val();

                        var data = {
                            updatetelno: telnoedit,
                            donorprogramid: donorprogramid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "internaldonorprogram/updateTelNo.htm",
                            data: data,
                            success: function (rep) {
                                $("#donor-edit-telno").text(telnoedit);
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

    function editfacDonorFax() {
        var editfax = $('#donor-edit-fax').text();
        var donorprogramid = $('#donorprogramid').val();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Donor Fax:</label>' +
                    '<input type="text" class="form-control" value="' + editfax + '" id="faxedit"/>' +
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
                        var faxedit = this.$content.find('#faxedit').val();

                        var data = {
                            updatefax: faxedit,
                            donorprogramid: donorprogramid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "internaldonorprogram/updateFax.htm",
                            data: data,
                            success: function (rep) {
                                $("#donor-edit-fax").text(faxedit);
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