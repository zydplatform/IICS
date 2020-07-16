<%-- 
    Document   : approveOrdersHome
    Created on : May 18, 2018, 9:37:16 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div class="tabsSec">
    <div class="tabsnew row" style="background: #ffffffe6 !important;">
        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-1" checked class="tab-switch">
            <label for="tab-1" class="tab-label">Internal Orders <span class="badge badge badge-info">${internalorders}</span></label>
            <div class="tab-content">
                <fieldset>
                    <div class="tile">
                        <div class="tile-body">
                            <div class="row">
                                <div class="col-md-11 col-sm-11 right">
                                    <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                        <div class="btn-group" role="group">
                                            <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="fa fa-sliders" aria-hidden="true"></i>
                                            </button>
                                            <div class="dropdown-menu dropdown-menu-left">
                                                <a class="dropdown-item" href="#" onclick="facilityunitapprovedandunapprovedorders('unapprove');" >Un Approved Orders</a><hr>
                                                <a class="dropdown-item" href="#" onclick="facilityunitapprovedandunapprovedorders('approved');">Approved Orders</a><hr />
                                                <!---->
                                                <a class="dropdown-item" href="#" onclick="facilityunitapprovedandunapprovedorders('rejecteditems');">Approval Rejects</a>
                                                <!---->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><br>
                            <div id="unitApprovedOrdersItmsdiv">
                                <h3>Un Approved Orders<span class="badge badge badge-info">${internalOrdersize}</span></h3>
                                <table class="table table-hover table-bordered col-md-12" id="tableapproveOrders">
                                    <thead class="col-md-12">
                                        <tr>
                                            <th class="center">No</th>
                                            <th>Order Number</th>
                                            <th class="">Destination Unit</th>
                                            <th class="">Order Date</th>
                                            <th class="center">Date Needed</th>
                                            <th class="center">No. of Items</th>
                                            <th class="">Prepared By</th>
                                            <th class="">Status</th>
                                            <th class="">Verify Items</th>
                                        </tr>
                                    </thead>
                                    <tbody class="col-md-12">
                                        <% int y = 1;%>
                                        <c:forEach items="${internalOrders}" var="a">
                                            <tr id="${a.facilityorderid}">
                                                <td class="center"><%=y++%></td>
                                                <td><a><font color="blue"><strong>${a.facilityorderno}</strong></font></a></td>
                                                <td class=""><a href="#"><font color="blue"><strong>${a.destinationfacilityunit}</strong></font></a></td>
                                                <td class="">${a.dateprepared}</td>
                                                <td class="center">${a.dateneeded}</td>
                                                <td class="center"><span class="badge badge-pill badge-success">${a.internalordersitemscount}</span></td>
                                                <td class="">${a.personname}</td>   
                                                <td class=""><c:if test="${a.isemergency==true}">Emergency Order</c:if><c:if test="${a.isemergency==false}">Normal Order</c:if></td>
                                                    <td align="center">
                                                            <button onclick="verifyfacilityunitorders(${a.facilityorderid}, '${a.facilityorderno}', '${a.destinationfacilityunit}',${a.isemergency}, '${a.personname}', '${a.dateneeded}', '${a.dateprepared}');"  title="Verify Order Items" class="btn btn-primary btn-sm add-to-shelf">
                                                        <i class="fa fa-dedent"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-2" class="tab-switch">
            <label for="tab-2" class="tab-label">External Orders <span class="badge badge-beige badge-info">${externalorders}</span></label>
            <div class="tab-content" id="externalOrderContent" style="margin-left: -10%">

            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="verifyorderitemsandsub" class="modalDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleverifyheading">Verify Order Items</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="verifyorderitemsandsubdiv">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#tableapproveOrders').DataTable();
    function verifyfacilityunitorders(facilityorderid, facilityorderno, destinationfacilityunit, isemergency, personname, dateneeded, dateprepared) {
        ajaxSubmitData('ordersmanagement/verifyfacilityunitorders.htm', 'verifyorderitemsandsubdiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&destinationfacilityunit=' + destinationfacilityunit + '&isemergency=' + isemergency + '&personname=' + personname + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&nbs=8&dtf=', 'GET');
        window.location = '#verifyorderitemsandsub';
        initDialog('modalDialog');
    }

    $('#tab-2').click(function () {
        ajaxSubmitData('externalordersapproval/externalorderstables.htm', 'externalOrderContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    function facilityunitapprovedandunapprovedorders(type) {
//        if (type === 'approved') {
//            ajaxSubmitData('approvefacilityorders/unitapprovedorders.htm', 'unitApprovedOrdersItmsdiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//        } else {
//            ajaxSubmitData('ordersmanagement/approveorconsolidateordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//        }
        if (type === 'approved') {
            ajaxSubmitData('approvefacilityorders/unitapprovedorders.htm', 'unitApprovedOrdersItmsdiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }else if(type === 'rejecteditems'){
            ajaxSubmitData('approvefacilityorders/rejectedorders.htm', 'unitApprovedOrdersItmsdiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        } else {
            ajaxSubmitData('ordersmanagement/approveorconsolidateordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    }
</script>