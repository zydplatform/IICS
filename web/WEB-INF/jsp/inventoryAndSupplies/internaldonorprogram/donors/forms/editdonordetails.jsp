<%-- 
    Document   : editdonordetails
    Created on : Sep 5, 2018, 10:16:37 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <div class="row tile">
            <form id="donorentryform" class="col-md-12">
                <div class="form-group">
                    <label class="control-label">Contact Person Name:</label>
                    <input class="form-control myform" id="personid" value="${contactperson}" type="hidden">
                    <input class="form-control myform" value="${facilitydonorid}" autofocus="autofocus" id="facilitydonorid" type="hidden" placeholder="Enter Donor Program Name">
                    <input class="form-control myform" value="${personname}" oninput="checkdonorprogramname();" autofocus="autofocus" id="contactpersonname" type="text" readonly="true">
                </div>
                <div class="form-group">
                    <label class="control-label">Primary Contact:</label>
                    <input class="form-control myform" value="${primarycontact}" autofocus="autofocus" id="priContact" type="text" placeholder="Enter Donor Program Type">
                </div>
                <div class="form-group">
                    <label class="control-label">Secondary Contact:</label>
                    <input class="form-control myform" value="${secondarycontact}" autofocus="autofocus" id="secContact" type="text">
                </div>
                <div class="form-group">
                    <label class="control-label required">Email:</label>
                    <input class="form-control myform" value="${email}" autofocus="autofocus" id="personemail" type="text">
                </div>
            </form>

        </div>
        <div class="tile-footer">
            <button class="btn btn-primary col-md-12" id="captureDonorProgram" onclick="saveEditedDetails()" type="button">
                <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                Save Donor Program
            </button>
        </div>
    </div>
</div>

<script>

    jQuery(document).ready(function () {
        $('[data-toggle="popover"]').popover();
        document.getElementById('captureDonorProgram').disabled = false;
        
         $('#priContact').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });

        $('#secContact').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });

    });
    function saveEditedDetails() {
        var personid = $('#personid').val();
        var facilitydonorid = $('#facilitydonorid').val();
        var contactpersonname = $('#contactpersonname').val();
        var priContact = $('#priContact').val();
        var secContact = $('#secContact').val();
        var personemail = $('#personemail').val();

        $.ajax({
            type: 'POST',
            data: {personid: personid, facilitydonorid: facilitydonorid, contactpersonname: contactpersonname, priContact: priContact, secContact: secContact, personemail: personemail},
            url: 'internaldonorprogram/saveEditedDonorProgramInfo.htm',
            success: function (data) {
                console.log("=---------------------res" + data);
                if (data === 'success') {
                    $.toast({
                        heading: 'Success',
                        text: 'Donor Contact Person Details Successfully Edit.',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    window.location = '#close';
                } else {
                    $.toast({
                        heading: 'Error',
                        text: 'An unexpected error occured while trying to edit Donor Contact Person Deatils.',
                        icon: 'error'
                    });
                    ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    window.location = '#close';
                }
            }
        });

    }
</script>