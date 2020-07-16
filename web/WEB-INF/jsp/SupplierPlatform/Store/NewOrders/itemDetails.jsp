<%-- 
    Document   : itemDetails
    Created on : Sep 10, 2018, 1:54:54 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset>
    <c:if test="${c=='b'}">
        <div class="row">
            <div class="col-md-2">
                <label for="order">Facility Name:</label>
            </div>   
            <div class="col-md-2" id='facName'></div>
            <div class="col-md-2">
                <label for="order">Order Number:</label>
            </div>   
            <div class="col-md-2" id='orderNumber'></div>
        </div>
        <div class="row">
            <div class="col-md-3">
                <label for="sDate">Schedule Order / Set Date Needed:</label>
            </div>   
            <div class="col-md-2">
                <input class="form-control" id="orderDate" type="text" placeholder="DD-MM-YYYY">
            </div>
        </div>
    </c:if>

    <div class="tile">
        <div class="tile-body">
            <div id="itemView" style="width:70%">
                <main id="main">
                    <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                    <label class="tabLabels" onclick="showDiv('itemView'); hideDiv('catView');" for="tab1">Item View</label>
                    <input id="tab2" class="tabCheck" type="radio" name="tabs">
                    <label class="tabLabels" for="tab2" onclick="showDiv('catView'); hideDiv('itemView');">Catalogue View</label>    
                </main>
                <table class="table table-hover table-bordered col-md-12" id="table-ItemView-items-new-orders">
                    <thead class="col-md-12">
                        <tr>
                            <th class="center">No</th>
                            <th>Item</th>
                            <th>Code</th>
                            <th>Pack Size</th>
                            <th>Unit Cost</th>
                            <th class="right">Quantity Ordered</th>
                                <c:if test="${c=='b'}">
                                <th class="right">Verify</th>
                                </c:if>
                        </tr>
                    </thead>
                    <tbody class="col-md-12" id="tableFacilityOwner">
                        <% int v = 1;%>
                        <c:set var="x" value="0"></c:set>
                        <c:forEach items="${itemsList}" var="item">
                            <tr>
                                <td class="center"><%=v++%></td>
                                <td class="">${item.genericname} ${item.itemstrength}</td>
                                <td class="">${item.itemcode}</td>
                                <td class="">${item.packsize}</td>
                                <td class="">${item.unitcost}</td>
                                <td class="right">${item.qtyapproved}</td>
                                <c:if test="${c=='b'}">
                                    <td class="right">

                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div id="catView" style="display:none">
                <main id="main">
                    <input id="tab3" class="tabCheck" type="radio" name="tabs">
                    <label class="tabLabels" onclick="showDiv('itemView'); hideDiv('catView');" for="tab1">Item View</label>
                    <input id="tab4" class="tabCheck" type="radio" name="tabs" checked>
                    <label class="tabLabels" for="tab2" onclick="showDiv('catView'); hideDiv('itemView');">Catalogue View</label>    
                </main>
                <table class="table table-hover table-bordered col-md-12" id="table-CatView-items-new-orders">
                    <thead class="col-md-12">
                        <tr>
                            <th class="center">No</th>
                            <th>Classification</th>
                            <th>Category</th>
                            <th>Item</th>
                            <th>Code</th>
                            <th>Pack Size</th>
                            <th class="right">Quantity Ordered${c}</th>
                                <c:if test="${c=='b'}">
                                <th class="right">Verify</th>
                                </c:if>
                        </tr>
                    </thead>
                    <tbody class="col-md-12" id="tableFacilityOwner">
                        <% int v2 = 1;%>
                        <c:set var="i" value="0"></c:set>
                        <c:forEach items="${orderItemsList}" var="item">
                            <tr>
                                <td class="center"><%=v2++%></td>
                                <td class="">${item.classificationname}</td>
                                <td class="">${item.categoryname}</td>
                                <td class="">${item.genericname} ${item.itemstrength}</td>
                                <td class="">${item.itemcode}</td>
                                <td class="">${item.packsize}</td>
                                <td class="right">${item.qtyapproved}</td>
                                <c:if test="${c=='b'}">
                                    <td class="right">
                                        <input data-orderItemId="${item.itemid}" value="${item.itemid}" id="verifyItem[${i}]" type="checkbox" onChange="if (this.checked) {
                                                    $('#selectedItemId').val(this.value);
                                                    $('#selectedItemCount').val(${i});
                                                    var itemSize = $('#orderItemSize').val();
                                                    funDisableOtherCheckBoxes(itemSize, 'verifyItem', '${i}', 'itemsForm', 'check');
                                                    functionVerifyOrderItem(${item.itemid}, 'b');
                                                    $('#itemName').val('${item.genericname} ${item.itemstrength}');
                                                    $('#orderClientName').val($('#facilityName${i}').val());
                                                } else {
                                                    $('#selectedItemId').val(0);
                                                    $('#selectedItemCount').val(0);
                                                    funDisableOtherCheckBoxes(itemSize, 'verifyItem', '${i}', 'itemsForm', 'uncheck');
                                                }"/>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div>
        <input type="hidden" id="selectedItemId" value="0"/>
        <input type="hidden" id="selectedItemCount" value="0"/>
        <input type="hidden" id="orderItemSize" value="${i}"/>
        <input type="hidden" id="itemName" value=""/>
    </div>
</fieldset>                    
<script>
    $('#table-CatView-items-new-orders').DataTable();
    $('#table-ItemView-items-new-orders').DataTable();
    $('#facName').text($('#orderClientName').val());
    $('#orderNumber').text($('#clientOrderNo').val());

    $(document).ready(function () {
        $("#orderDate").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            minDate: new Date(),
            defaultDate: new Date()
        });

    });
</script>