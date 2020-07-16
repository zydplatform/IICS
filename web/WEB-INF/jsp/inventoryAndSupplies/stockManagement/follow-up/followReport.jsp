<%-- 
    Document   : followReport
    Created on : 27-Jun-2018, 17:01:02
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty reportItems}">
    <section class="invoice">
        <div class="row">
            <div class="col-md-11 col-sm-11 right">
                <span class="badge badge-pill span-size-15 badge-info">
                    ${itemCount}&nbsp;
                    <c:if test="${itemCount == 1}">
                        Item
                    </c:if>
                    <c:if test="${itemCount != 1}">
                        Items
                    </c:if>
                </span>
            </div>
        </div>
    </section>
    <c:forEach items="${reportItems}" var="item">
        <div class="pane" id="discItem${item.itemid}">
            <h2 class="heading" id="colouredborders">${item.itemname}</h2>
            <div class="byline">
                &#916;&nbsp;
                <a href="#!" class="more" title="Discripancy">
                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${item.counted - item.expected}"/>
                </a>
            </div>
            <div class="itemBatches">
                <table class="table table-hover table-striped" id="cellCounts">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Batch</th>
                            <th>Expiry Date</th>
                            <th class="right">Quantity Expected</th>
                            <th class="right">Quantity Counted</th>
                            <th class="right">Difference</th>
                            <th class="center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int q = 1;%>
                        <c:forEach items="${item.batches}" var="batch">
                            <tr>
                                <td><%=q++%></td>
                                <td>${batch.batch}</td>
                                <td>${batch.expiry}</td>
                                <td class="right">
                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${batch.expected}"/>
                                </td>
                                <td class="right">
                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${batch.counted}"/>
                                </td>
                                <td class="right">
                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${batch.counted - batch.expected}"/>
                                </td>
                                <td class="center" id="batch${item.itemid}${batch.batch}">
                                    <button class="btn btn-info btn-sm"  id="button${item.itemid}${batch.batch}" disabled="true" onclick="discrepancyAction(${item.itemid}, ${batch.counted - batch.expected}, '${batch.batch}', '${item.itemname}', '${batch.expiry}')">
                                        <i class="fa fa-spinner fa-spin fa-2x"></i>
                                    </button>
                                    <script>checkItemFollowupStatus(${item.itemid}, '${batch.batch}', ${batch.counted - batch.expected});</script>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:forEach>    
    <div class="row">
        <div class="col-md-12 right"><hr/>
            <button class="btn btn-primary btn-sm" onclick="printDiscrepancyReport('${file}')">
                <i class="fa fa-print"></i>Print
            </button>
        </div>
    </div>
</c:if>
<c:if test="${empty reportItems}">
    <div class="row">
        <div class="col-md-12 center">
            <h5 id="errorPane"></h5>
        </div>
    </div>
    <script>
        $('#errorPane').html('No Items Pending Follow Up for <strong style="color: green;">' + $('#fol' + activityid).data('name') + '</strong> Stock Taking');
    </script>
</c:if>