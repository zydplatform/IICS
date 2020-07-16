<%-- 
    Document   : incompleteExternalOrders
    Created on : Aug 27, 2018, 7:49:17 AM
    Author     : HP
--%>
<%@include file="../../../../../../include.jsp" %>
<fieldset>
    <legend>Created Orders</legend>
    <table class="table table-hover table-bordered" id="facilityexternalorderstable">
        <c:if test="${act=='a'}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Order Number</th>
                    <th>Supplier</th>
                    <th>Items</th>
                    <th>Created By</th>
                    <th>Order Stage</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody>
                <% int j = 1;%>
                <c:forEach items="${ordersFound}" var="a">
                    <tr>
                        <td><%=j++%></td>
                        <td><a href="#!" onclick="viewfacilityunitplacedOrders(${a.facilityorderid}, '${a.status}');">${a.neworderno}</a></td>
                        <td>${a.facilityordersuppliername}</td>
                        <td align="center">
                            <button onclick="viewfacilityunitplacedOrders(${a.facilityorderid}, '${a.status}');"  title="Items On Order" class="btn btn-secondary btn-sm add-to-shelf">
                                ${a.externalorderscomplete} Item(s)
                            </button>
                        </td>
                        <td>${a.name}</td>
                        <td><c:if test="${a.status=='PAUSED'}">
                                <button onclick=""  title="Add Items To This Order" class="btn btn-secondary btn-sm add-to-shelf">
                                    PAUSED
                                </button>
                            </c:if><c:if test="${a.status=='SUBMITTED'}">WAITING APPROVAL</c:if></td>
                            <td align="center"> 
            <!--                            <button onclick="deleteorderanditems(${a.facilityorderid});"  title="Delete or Recall Order" class="btn btn-primary btn-sm add-to-shelf">
                                    <i class="fa fa-remove"></i>
                                </button>-->
                            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                <div class="btn-group" role="group">
                                    <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="fa fa-sliders" aria-hidden="true"></i>
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-left">
                                        <a class="dropdown-item" href="#!" onclick="deleteorderanditems(${a.facilityorderid});">Delete</a>
                                        <c:if test="${a.status=='SUBMITTED'}">
                                            <a class="dropdown-item" href="#" onclick="recallsubmittedExternalorder(${a.facilityorderid},'${act}');">Edit(Recall)</a>  
                                        </c:if>
                                        <c:if test="${a.status=='PAUSED'}">
                                            <a class="dropdown-item" href="#" onclick="submitOrderForApproval(${a.facilityorderid},'${act}');">Submit</a>  
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if>
        <c:if test="${act=='b'}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Order Number</th>
                    <th>Destination</th>
                    <th>Items</th>
                    <th>Date Needed</th>
                    <th>Date Created</th>
                    <th>Created By</th>
                    <th>Order Stage</th>
                </tr>
            </thead>
            <tbody>
                <% int d = 1;%>
                <c:forEach items="${ordersFound}" var="a">
                    <tr>
                        <td><%=d++%></td>
                        <td>${a.facilityorderno}</td>
                        <td>${a.facilitysuppliername}(${a.shortname})</td>
                        <td align="center">
                            <button onclick="viewOrderItems(${a.facilityorderid}, '${a.facilityorderno}', '${a.facilitysuppliername}',${a.internalordersitemscount}, '${a.dateneeded}', '${a.dateprepared}', '${a.personname}', '${a.status}',${a.criteria});"  title="Items On Order" class="btn btn-secondary btn-sm add-to-shelf">
                                ${a.internalordersitemscount} Item(s)
                            </button></td>
                        <td>${a.dateneeded}</td>
                        <td>${a.dateprepared}</td>
                        <td>${a.personname}</td>
                        <td><c:if test="${a.status=='SENT'}">
                                WAITING SERVICE 
                            </c:if><c:if test="${a.status=='RECEIVED'}">SERVICED</c:if></td>
                        </tr>
                </c:forEach>
            </tbody>
        </c:if>

    </table>
</fieldset>
<script>
    $('#facilityexternalorderstable').DataTable();
    function viewfacilityunitplacedOrders(facilityorderid, status) {
        $.ajax({
            type: 'GET',
            data: {facilityorderid: facilityorderid, status: status},
            url: "extordersmanagement/facilityunitexternalorderitems.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'Order Items',
                    closeIcon: true,
                    boxWidth: '70%',
                    useBootstrap: false,
                    content: '' + data,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        close: function () {

                        }
                    }
                });
            }
        });
    }
    function submitOrderForApproval(facilityorderid,act) {
        $.confirm({
            title: 'Submit Order',
            content: 'Are You Sure You Want To Submit Order For Approval?',
            type: 'purple',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityorderid:facilityorderid},
                            url: "extordersmanagement/submitexternalorderforapproval.htm",
                            success: function (data, textStatus, jqXHR) {
                                 ajaxSubmitData('extordersmanagement/externalordersview.htm', 'createdordersdiv', 'act='+act+'&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {

                }
            }
        });
    }
    function recallsubmittedExternalorder(facilityorderid,act) {
        $.confirm({
            title: 'Recall External Order',
            content: 'Are You Sure You Want To Recall This Order?',
            type: 'purple',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityorderid:facilityorderid},
                            url: "extordersmanagement/recallsubmittedExternalorder.htm",
                            success: function (data, textStatus, jqXHR) {
                                 ajaxSubmitData('extordersmanagement/externalordersview.htm', 'createdordersdiv', 'act='+act+'&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
</script>