<%-- 
    Document   : cellItems
    Created on : 14-Jun-2018, 09:11:47
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty items}">
    <c:forEach items="${items}" var="item">
        <div class="pane" id="item${item.itemid}">
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
                            <th class="right">Expected Items</th>
                            <th class="right">Counted Items</th>
                            <th class="center">Tally Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int p = 1;%>
                        <c:forEach items="${item.batches}" var="batch">
                            <tr>
                                <td><%=p++%></td>
                                <td>${batch.batch}</td>
                                <td>${batch.expiry}</td>
                                <td class="right">
                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${batch.expected}"/>
                                </td>
                                <td class="right">
                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${batch.counted}"/>
                                </td>
                                <td class="center">
                                    <c:if test="${batch.counted == batch.expected}">
                                        <img src="static/images/authorisedsmall.png"/>
                                    </c:if>
                                    <c:if test="${batch.counted != batch.expected}">
                                        <img src="static/images/noaccesssmall.png"/>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div class="col-md-6 left">
                    <p class="pagenavbox" id="pagenavigation">
                        Total Expected: <a href="#tablesintables" class="pagenav">${item.expected}</a>
                    </p>
                </div>
                <div class="col-md-6 right">
                    <p class="pagenavbox" id="pagenavigation">
                        Total Counted: <a href="#tablesintables" class="pagenav">${item.counted}</a>
                    </p>
                </div>
                <div class="col-md-11 right">
                    <c:if test="${closed == false}">
                        <c:if test="${(item.counted - item.expected) != 0}">
                            <button class="btn btn-sm btn-warning recount issue-recount${item.itemid}" onclick="recountCell(${item.itemid}, '${item.name}', ${activitycellid})">
                                <i class="fa fa-edit"></i>&nbsp;Issue Recount
                            </button>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </div>
    </c:forEach>
</c:if>
<c:if test="${empty items}">
    <div class="row">
        <div class="col-md-12 center">
            <h2>
                Cell Empty
            </h2>
        </div>
    </div>
</c:if>
<div class="row">
    <div class="col-md-12 center"><hr>
        <c:if test="${closed == false}">
            <c:if test="${recount == true}">
                <button class="btn btn-sm btn-info" disabled="true" title="Cell Requires Recount">
                    <i class="fa fa-spinner"></i>&nbsp;Pending Recount
                </button>
            </c:if>
            <c:if test="${recount != true}">
                <button class="btn btn-sm btn-info close-cell" onclick="closeCell(${activitycellid}, ${cellid})">
                    <i class="fa fa-check-circle"></i>&nbsp;Close Cell
                </button>
            </c:if>
        </c:if>
        <c:if test="${closed == true}">
            <button class="btn btn-sm btn-success" disabled="true" title="Cell Activities Closed">
                <i class="fa fa-close"></i>&nbsp;Cell Closed
            </button>
        </c:if>
    </div>
</div>
<script>
    $(document).ready(function () {
        var activitycellid = ${activitycellid};
        $.ajax({
            type: 'POST',
            data_type: 'JSON',
            data: {activitycellid: activitycellid},
            url: 'stock/fetchActivitycellRecountItems',
            success: function (data) {
                if (data === 'refresh') {
                    document.location.reload(true);
                } else {
                    var items = JSON.parse(data);
                    for (i in items) {
                        $('.issue-recount' + items[i]).html('<i class="fa fa-spinner"></i>&nbsp;Recount Issued');
                        $('.issue-recount' + items[i]).prop('disabled', true);
                    }
                }
            }
        });
    });
</script>