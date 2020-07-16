<%-- 
    Document   : approveexternalfacorders
    Created on : Aug 16, 2018, 2:33:02 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>
<style>
    .pastapproval{
        text-transform: uppercase;
        font-family: "Times New Roman", Times, serif;
        color: red;
        font-size:40px;
        font-weight: bold;
        
    }
    
    .beforeapproval{
        text-transform: uppercase;
        color: orangered;
        font-family: "Times New Roman", Times, serif;
        font-size:40px;
        font-weight: bold;
    }
</style>
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-12">
                <fieldset>
                    <c:forEach items="${externalFacilityOrders}" var="pk">
                        <c:if test="${pk.message == 'PAST DATE'}">
                            <p class="pastapproval">PAST APPROVAL DATE</p>
                        </c:if>
                        <c:if test="${pk.message == 'NOT REACHED'}">
                            <p class="beforeapproval">NO ORDER TO APPROVE BEFORE APPROVAL DATE IS REACHED</p>
                        </c:if>
                        <c:if test="${pk.message == 'TABLE VISIBLE'}">
                            <table class="table table-hover table-bordered" id="approveFacilityexternalorders">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Facility Order No.</th>
                                        <th class="center">Facility Order Items</th>
                                        <th class="center">Approve Order Items</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% int s = 1;%>
                                    <% int a = 1;%>
                                    <% int i = 1;%>
                                    <c:forEach items="${externalFacilityOrders}" var="e">
                                        <tr id="${e.externalfacilityordersid}"<c:if test="${not empty facilityprocplans}">style="display: none"</c:if>>
                                            <td><%=s++%></td>
                                            <td>${e.neworderno}</td>
                                            <td class="center"><button onclick="externalfacorderitems(${e.externalfacilityordersid}, '${e.neworderno}')" class="btn btn-secondary btn-sm add-to-shelf" style="background-color: green; important">
                                                    ${e.externalfacordersitemscount} Items
                                                </button></td>
                                            <td align="center">
                                                <button class="btn btn-primary btn-sm add-to-shelf" onclick="verifyexternalfacilityorders(${e.externalfacilityordersid}, '${e.neworderno}');">
                                                    <i class="fa fa-dedent"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </c:forEach>   
                </fieldset>
            </div>
        </div>
    </div>
    <div class="">
        <div id="approveExtFacOrder" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title"><b>APPROVE FACILITY ORDER ITEMS</b></h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="approvalFacContents">

                </div>  
            </div>
        </div>
    </div>
</div>
<script>
    $('#approveFacilityexternalorders').DataTable();

    function externalfacorderitems(externalfacilityordersid, neworderno) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "extordersmanagement/viewFacExternalOrderItems.htm",
            data: {externalfacilityordersid: externalfacilityordersid},
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">Items Ordered With Order No.:' + '<font color="green">' + neworderno + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '40%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
    }

    function verifyexternalfacilityorders(externalfacilityordersid, neworderno) {
        window.location = '#approveExtFacOrder';
        initDialog('supplierCatalogDialog');

        ajaxSubmitData('extordersmanagement/approveFacilityExternalOrderItems.htm', 'approvalFacContents', 'externalfacilityordersid=' + externalfacilityordersid + '&neworderno=' + neworderno + '&nvb=0', 'GET');
    }
</script>

