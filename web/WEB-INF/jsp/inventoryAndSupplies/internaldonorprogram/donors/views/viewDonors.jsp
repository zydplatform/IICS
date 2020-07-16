<%-- 
    Document   : viewDonors
    Created on : Oct 4, 2018, 10:18:16 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-body">
                <table class="table table-hover table-bordered col-md-12" id="tableviewdonors">
                    <thead class="col-md-12">
                        <tr>
                            <th class="center">No</th>
                            <th>Donor Name</th>
                            <th class="">Donor Type</th>
                            <th class="">Country Of Origin</th>
                            <th class="">Manage</th>
                        </tr>
                    </thead>
                    <tbody class="col-md-12">
                        <% int y = 1;%>
                        <c:forEach items="${donorProgramList}" var="a">
                            <tr id="${a.facilitydonorid}">
                                <td class="center"><%=y++%></td>
                                <td class="">${a.donorname}</td>
                                <td class="">${a.donortype}</td>
                                <td class="">${a.origincountry}</td>
                                <td align="center">
                                    <button onclick="manageDonors(${a.facilitydonorid}, '${a.donorname}', '${a.donortype}', '${a.origincountry}', '${a.telno}', '${a.emial}', '${a.fax}', '${a.personname}', '${a.contactperson}', '${a.primarycontact}', '${a.secondarycontact}', '${a.email}');"  title="Manage Donors" class="btn btn-primary btn-sm add-to-shelf">
                                        <i class="fa fa-edit"></i>
                                    </button>
                                    |
                                    <button onclick="makeDonations(${a.facilitydonorid}, '${a.donorname}')"  title="Make Donations" class="btn btn-primary btn-sm add-to-shelf">
                                        <i class="fa fa-dedent"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <!--        <div class="">
                    <div id="managedonors" class="supplierCatalogDialog">
                        <div>
                            <div id="divSection1">
                                <div id="head">
                                    <a href="#close" title="Close" class="close2">X</a>
                                    <h2 class="modalDialog-title">Manage Donors</h2>
                                    <hr>
                                </div>
                                <div class="scrollbar" id="manageDonorContent">
        
                                </div>                                        
                            </div>
                        </div>
                    </div>
                </div>-->

        <div class="row">
            <div class="col-md-12">
                <div id="managedonors" class="shelveItemDialog">
                    <div>
                        <div id="head">
                            <a href="#close" title="Close" class="close2">X</a>
                            <h5 class="modalDialog-title">Manage Donors</h5>
                        </div>
                        <div class="row scrollbar" id="manageDonorContent" style="height: 561px;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="makedonations" class="shelveItemDialog">
            <div>
                <div id="divSection3">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h5 class="modalDialog-title">Make Donations</h5>
                    </div>
                    <div class="row scrollbar" id="makeDonationContent" style="height: 561px;">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#tableviewdonors').DataTable();
    function manageDonors(facilitydonorid, donorname, donortype, origincountry, telno, email, fax, personname, contactperson, primarycontact, secondarycontact, personEmail) {
        window.location = '#managedonors';
        initDialog('shelveItemDialog');
        ajaxSubmitData('internaldonorprogram/manageDonorsPane.htm', 'manageDonorContent', 'facilitydonorid=' + facilitydonorid + '&donorname=' + donorname + '&donortype=' + donortype + '&origincountry=' + origincountry + '&telno=' + telno + '&email=' + email + '&fax=' + fax + '&personname=' + personname + '&contactperson=' + contactperson + '&primarycontact=' + primarycontact + '&secondarycontact=' + secondarycontact + '&personEmail=' + personEmail + '&nvb=0', 'GET');
    }

    function makeDonations(facilitydonorid, donorname) {
        window.location = '#makedonations';
        initDialog('shelveItemDialog');
        ajaxSubmitData('internaldonorprogram/makeDonation.htm', 'makeDonationContent', 'facilitydonorid=' + facilitydonorid + '&donorname=' + donorname + '&nvb=0', 'GET');

//        $.ajax({
//            type: "GET",
//            cache: false,
//            url: "internaldonorprogram/makeDonation.htm",
//            data: {donorprogramid: donorprogramid, donorname: donorname},
//            success: function (data) {
//                $.dialog({
//                    title: '<strong class="center"> MAKE DONATION </strong>',
//                    content: '' + data,
//                    boxWidth: '90%',
//                    useBootstrap: false,
//                    type: 'purple',
//                    typeAnimated: true,
//                    closeIcon: true
//
//                });
//            }
//        });
    }
</script>