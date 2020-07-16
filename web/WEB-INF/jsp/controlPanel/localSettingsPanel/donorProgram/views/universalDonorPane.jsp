<%-- 
    Document   : donorPane
    Created on : Sep 4, 2018, 2:48:55 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>

<div class="container-fluid">
    <div class="app-title" id="">
        <div class="col-md-5">
            <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
            <p>Together We Save Lives...!</p>
        </div>

        <div>
            <div class="mmmains">
                <div class="wrapper">
                    <ul class="breadcrumbs">
                        <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li> 
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Local Setting</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('localsettigs/manage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Manage</a></li>
                        <li class="last active"><a href="#">Donor Program</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row"></div>
    <div class="row" id="">
        <div class="col-md-12">
            <div id="makingDonationsPane">
                <div class="row">
                    <div class="col-md-12">
                        <button onclick="registerNewDonor();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>Register Donor</button>
                    </div>
                </div>
                <div style="margin: 10px;">
                    <fieldset style="min-height:100px;">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <table class="table table-hover table-bordered" id="universaldonorTable">
                                            <thead>
                                                <tr>
                                                    <th>No</th>
                                                    <th>Donor Name</th>
                                                    <th>Funder</th>
                                                    <th>Donor Type</th>
                                                    <th class="center">More Info.</th>
                                                    <th class="center">Edit</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% int k = 1;%>
                                                <c:forEach items="${donorProgramList}" var="d">
                                                    <tr id="${d.donorprogramid}">
                                                        <td><%=k++%></td>
                                                        <td>${d.donorname}</td>
                                                        <td>${d.donationfunder}</td>
                                                        <td><a><font color="blue"><strong>${d.donationtype}</strong></font></a></td>
                                                        <td class="center">
                                                            <button  data-toggle="popover" onclick="viewDonorDetails(${d.telno},'${d.emial}','${d.fax}','${d.startdate}','${d.enddate}');" class="btn btn-primary btn-sm add-to-shelf subscribe">
                                                                <i class="fa fa-fw fa-lg fa-dedent"></i>
                                                            </button>
                                                        </td>
                                                        <td class="center">
                                                            <button  data-toggle="popover" onclick="editDonorDetails(${d.donorprogramid},'${d.donorname}','${d.donationfunder}','${d.donationtype}','${d.telno}','${d.emial}','${d.fax}','${d.startdate}','${d.enddate}');" class="btn btn-primary btn-sm add-to-shelf subscribe">
                                                                <i class="fa fa-fw fa-lg fa-edit"></i>
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
                    </fieldset>
                </div> 
            </div>
        </div>
    </div>
</div>
<script>
    $('#universaldonorTable').DataTable();

    function registerNewDonor() {
        $.ajax({
            type: "GET",
            cache: false,
            url: "donorprogram/registerNewDonor.htm",
            data: {},
            success: function (data) {
                $.confirm({
                    title: '<font color="green">' + '<strong class="center">Register Donor' + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '95%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
    }
    function viewDonorDetails(telno,email,fax,startdate,enddate) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "donorprogram/viewDonorDetails.htm",
            data: {telno: telno,email: email,fax: fax,startdate: startdate,enddate: enddate},
            success: function (data) {
                $.confirm({
                    title: '<font color="green">' + '<strong class="center">View Donor Details' + '</font>' + '</strong>',
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

    function editDonorDetails(donorprogramid,donorname,funder,donortype,telno,email,fax,startdate,enddate) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "donorprogram/editDonorDetails.htm",
            data: {donorprogramid: donorprogramid, donorname: donorname,funder: funder,donortype: donortype,telno: telno,email: email,fax: fax,startdate: startdate,enddate: enddate},
            success: function (data) {
                $.confirm({
                    title: '<font color="green">' + '<strong class="center">Edit Donor Details' + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '50%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
    }
    function makeDonations() {
        ajaxSubmitData('internaldonorprogram/donationsPane', 'makingDonationsPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>