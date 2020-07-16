<%-- 
    Document   : manageDonorPane
    Created on : Oct 4, 2018, 11:06:00 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<script>
    // document.getElementById('managecollapsethistestcontent').style.display = 'none';
    function manageCollapseandExapand(id) {
        if ($('#' + id).hasClass("manageactiveselected")) {
            $('#' + id).toggleClass('managecollapseselected manageactiveselected');
            $('#managexxicon').attr('class', 'fa fa-2x fa-minus');
            document.getElementById('managecollapsethistestcontent').style.display = 'block';
        } else if ($('#' + id).hasClass("managecollapseselected")) {
            $('#' + id).toggleClass('manageactiveselected managecollapseselected');
            $('#managexxicon').attr('class', 'fa fa-2x fa-plus');
            document.getElementById('managecollapsethistestcontent').style.display = 'none';

        }
    }

</script>
<style>
    #managecollapsethistest {
        background-color:#D8BFD8 !important;
        color: black !important;
        cursor: pointer;
    }

    #managecollapsethistest:hover {
        background-color: plum;
    }

    .donorFont{
        font-size: 20px;
    }

</style>
<div class="col-md-12" style="padding-top: 10px;">
    <div class="btn btn-sm btn-plum horizontalwithwordsleft manageactiveselected col-md-12" id="managecollapsethistest" onclick="manageCollapseandExapand(this.id);">
        <strong><span class="title badge donorFont" style="float: left"><i id="managexxicon" class="fa fa-2x fa-plus"></i>&nbsp; DONOR DETAILS</span></strong>   
    </div>
</div>
<div class="col-md-12" id="managecollapsethistestcontent">
    <div class="tile">
        <div class="tile-body">
            <c:if test="${donortype == 'Organisation'}">
                <div class="row" style="margin-top: 0em">
                    <div class="col-md-7">
                        <fieldset>
                            <legend><strong>Donor Details</strong></legend>
                            <div class="row">
                                <div class="col-md-6">
                                    <div>
                                        <div class="form-group bs-component">
                                            <input type="hidden" value="${facilitydonorid}">
                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Donor Name:</strong></span>&nbsp;
                                            <strong >
                                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${donorname}</strong></span>
                                            </strong>
                                        </div>

                                        <div class="form-group bs-component">
                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Tel No.:</strong></span>&nbsp;
                                            <strong >
                                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${telno}</strong></span>
                                            </strong>
                                        </div>
                                        <div class="form-group bs-component">
                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Fax:</strong></span>&nbsp;
                                            <strong >
                                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${fax}</strong></span>
                                            </strong>
                                        </div>
                                        <div class="form-group bs-component">
                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Email:</strong></span>&nbsp;
                                            <strong >
                                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${email}</strong></span>
                                            </strong>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group bs-component">
                                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Donor Type:</strong></span>&nbsp;
                                        <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${donortype}</strong></span>
                                    </div>
                                    <div class="form-group bs-component">
                                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Country:</strong></span>&nbsp;
                                        <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${origincountry}</strong></span>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-md-5">
                        <fieldset>
                            <legend><strong>Contact Person Details</strong></legend>
                            <div class="row">
                                <div class="col-md-12">
                                    <div>
                                        <div class="form-group bs-component">
                                            <input type="hidden" value="${contactperson}">
                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Name:</strong></span>&nbsp;
                                            <strong>
                                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${personname}</strong></span>
                                            </strong>
                                        </div>
                                        <div class="form-group bs-component">
                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Primary Contact:</strong></span>&nbsp;
                                            <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${primarycontact}</strong></span>
                                        </div>
                                        <div class="form-group bs-component">
                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Email:</strong></span>&nbsp;
                                            <strong >
                                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${personEmail}</strong></span>
                                            </strong>
                                        </div>
                                        <div class="form-group bs-component">
                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Secondary Contact:</strong></span>&nbsp;
                                            <strong >
                                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${secondarycontact}</strong></span>
                                            </strong>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </fieldset>
                        <div class="row" style="float: right; padding-top: 10px">
                            <button class="btn btn-primary" id="updateDonorInfo" type="button" onclick="updateDonorInfo(${facilitydonorid}, '${contactperson}', '${personname}', '${primarycontact}', '${personEmail}', '${secondarycontact}')">
                                <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                                Edit Donor Information
                            </button>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${donortype == 'Individual'}">
                <div class="row" style="margin-top: 0em">
                    <div class="col-md-12">
                        <fieldset>
                            <legend><strong>Donor Details</strong></legend>
                            <div class="row">
                                <div class="col-md-6">
                                    <div>
                                        <div class="form-group bs-component">
                                            <input type="hidden" value="${facilitydonorid}">
                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Donor Name:</strong></span>&nbsp;
                                            <strong >
                                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${donorname}</strong></span>
                                            </strong>
                                        </div>

                                        <div class="form-group bs-component">
                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Tel No.:</strong></span>&nbsp;
                                            <strong >
                                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${telno}</strong></span>
                                            </strong>
                                        </div>
                                        <div class="form-group bs-component">
                                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Fax:</strong></span>&nbsp;
                                            <strong >
                                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${fax}</strong></span>
                                            </strong>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group bs-component">
                                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Email:</strong></span>&nbsp;
                                        <strong >
                                            <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${email}</strong></span>
                                        </strong>
                                    </div>
                                    <div class="form-group bs-component">
                                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Donor Type:</strong></span>&nbsp;
                                        <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${donortype}</strong></span>
                                    </div>
                                    <div class="form-group bs-component">
                                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Country:</strong></span>&nbsp;
                                        <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${origincountry}</strong></span>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </c:if>
            </div>	
        </div> <!-- collapse .// -->
    </div>
</div>
<div class="col-md-12">
    <span class="title badge badge-patientinfo patientConfirmFont col-md-12">Donation History</span>
</div>

<div class="tile col-md-12">
    <div class="tile-body">
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover table-bordered col-md-12" id="manageDonorsTable">
                    <thead class="col-md-12">
                        <tr>
                            <th class="center">No</th>
                            <th>Donation Ref No.</th>
                            <th class="">Donation Date</th>
                            <th class="">Receiver</th>
                            <th class="">Items Donated</th>
                        </tr>
                    </thead>
                    <tbody class="col-md-12">
                        <% int m = 1;%>
                        <c:forEach items="${donationsList}" var="d">
                            <tr id="${d.donationsid}">
                                <td class="center"><%=m++%></td>
                                <td class="">${d.donorrefno}</td>
                                <td class="">${d.datereceived}</td>
                                <td class="">${d.personname}</td>
                                <td align="center">
                                    <button title=" The Items To Be Order For." class="btn btn-secondary btn-sm add-to-shelf" style="background-color: green; important" onclick="viewDonatedItems(${d.donationsid}, '${d.donorrefno}')">
                                        ${d.totalDonatedItems} Items
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>
<script>
    $('#manageDonorsTable').DataTable();
    function viewDonatedItems(donationsid, donorrefno) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "internaldonorprogram/viewDonatedItems.htm",
            data: {donationsid: donationsid, donorrefno: donorrefno},
            success: function (data) {
                $.dialog({
                    title: '<strong class="center"> View Donated Items </strong>',
                    content: '' + data,
                    boxWidth: '70%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true
                });
            }
        });

        //        window.location = '#donateditems';
        //        initDialog('supplierCatalogDialog');
        //        ajaxSubmitData('internaldonorprogram/viewDonatedItems.htm', 'donatedItemContent', 'donationsid=' + donationsid + '&donorrefno=' + donorrefno + '&nvb=0', 'GET');
        //        //ajaxSubmitData('internaldonorprogram/viewDonorItems.htm', 'donatedItemContent', '&nvb=0', 'GET');
    }

    function updateDonorInfo(facilitydonorid, contactperson, personname, primarycontact, email, secondarycontact) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "internaldonorprogram/editDonorDetails.htm",
            data: {facilitydonorid: facilitydonorid, contactperson: contactperson, personname: personname, primarycontact: primarycontact, email: email, secondarycontact: secondarycontact},
            success: function (data) {
                $.dialog({
                    title: '<strong class="center"> EDIT CONTACT PERSON DETAILS </strong>',
                    content: '' + data,
                    boxWidth: '30%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
    }
</script>