<%-- 
    Document   : activityReport
    Created on : 27-Jun-2018, 17:01:02
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty reportItems}">
    <section class="invoice">
        <div class="row">
            <div class="col-md-4">
                <h2 class="page-header">${activity}</h2>
            </div>
            <div class="col-md-4 col-sm-4 center">
                <h6><strong>Assigned Locations</strong></h6>
                <span class="badge badge-pill span-size-15 badge-info">${assigned}</span>
            </div>
            <div class="col-md-4 col-sm-4 right">
                <h6><strong>Submitted Locations</strong></h6>
                <span class="badge badge-pill span-size-15 badge-success">${submitted}</span>
            </div>
        </div>
        <div class="row invoice-info">
            <div class="col-md-6 col-sm-6">
                From:<br>
                <strong>${start}</strong><br>
                To:<br>
                <strong>${end}</strong>
            </div>
            <div class="col-md-6 col-sm-6 right">
                <br>User:<br>
                ${staff}
                <address>
                    <strong>${designation}</strong>
                </address>
            </div>
        </div>
    </section>
    <c:forEach items="${reportItems}" var="item">
        <div class="pane" id="item${item.itemid}">
            <h2 class="heading" id="colouredborders">${item.itemname}</h2>
            <div class="itemBatches">
                <table class="table table-hover table-sm table-striped" id="cellCounts">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Batch</th>
                            <th class="right">Expiry Date</th>
                            <th class="right">Quantity Counted</th>
                            <th class="right">Date Counted</th>
                            <th class="right">Cell</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int r = 1;%>
                        <c:forEach items="${item.batches}" var="batch">
                            <tr>
                                <td><%=r++%></td>
                                <td>${batch.batch}</td>
                                <td class="right">${batch.expiry}</td>
                                <td class="right">${batch.counted}</td>
                                <td class="right">${batch.dateadded}</td>
                                <td class="right">${batch.cell}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div class="col-md-6"></div>
                <div class="col-md-6 right">
                    <p class="pagenavbox" id="pagenavigation">
                        Total Counted:&nbsp;
                        <a href="#tablesintables" class="pagenav">
                            <fmt:formatNumber type="number" maxFractionDigits="0" value="${item.counted}"/>
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </c:forEach>
    <div class="row">
        <div class="col-md-12 right">
            <button class="btn btn-primary btn-sm" onclick="printUserReport('${file}')">
                <i class="fa fa-print"></i>Print
            </button>
        </div>
    </div>
</c:if>
<c:if test="${empty reportItems}">
    <div class="row">
        <div class="col-md-12 center">
            <h2>
                No Items Counted by this user.
            </h2>
        </div>
    </div>
</c:if>