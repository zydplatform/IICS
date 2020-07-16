<%-- 
    Document   : itemBatches
    Created on : 09-May-2018, 16:14:42
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<style>
    .popover{
        z-index: 999999999;
    }
</style>
<div class="col-md-12">
    <div class="tile tile-no-padding">
        <section class="invoice">
            <div class="row mb-4">
                <div class="col-6">
                    <h3 class="page-header">
                        <i class="fa fa-globe"></i>&nbsp;
                        <c:if test="${batches == 1}">
                            ${batches} Batch.
                        </c:if>
                        <c:if test="${batches != 1}">
                            ${batches} Batches.
                        </c:if>
                    </h3>
                </div>
            </div>
            <div class="row invoice-info">
                <div class="col-3">
                    <table class="table table-striped">
                        <tbody>
                            <tr>
                                <td>Opening</td>
                                <td class="right">${opening}</td>
                            </tr>
                            <tr>
                                <td>Received</td>
                                <td class="right">${received}</td>
                            </tr>
                            <tr>
                                <td>Issued</td>
                                <td class="right">${issued}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-4">
                    <table class="table table-striped">
                        <tbody>
                            <tr>
                                <td>Discrepancies</td>
                                <td class="right">
                                    <span class="badge badge-pill badge-warning">${discrepancy}</span>
                                </td>
                            </tr>
                            <tr>
                                <td>Expired</td>
                                <td class="right">
                                    <span class="badge badge-pill badge-danger">${expired}</span>
                                </td>
                            </tr>
                            <tr>
                                <td>Usable Stock</td>
                                <td class="right">
                                    <span class="badge badge-pill badge-info">${usable}</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-5">
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <div class="embed-responsive embed-responsive-16by9">
                                <canvas class="embed-responsive-item" id="stockPie"></canvas>
                            </div>
                        </div>
                        <div class="col-md-2"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12 table-responsive">
                    <fieldset>
                        <div class="row">
                            <table class="table table-hover table-bordered dataTable no-footer" id="stockItemDetailsTable">
                                <thead>
                                    <tr role="row">
                                        <th>#</th>
                                        <th>Batch No.</th>
                                        <th class="center">Expiry</th>
                                        <th class="right">Opening</th>
                                        <th class="right">Received</th>
                                        <th class="center">Available</th>
                                        <th class="center">Booked</th>
                                        <th class="center">Rounds Delivered</th>
                                </thead>
                                <tbody>
                                    <% int x = 1;%>
                                    <c:forEach items="${items}" var="item">
                                        <tr>
                                            <td><%=x++%></td>
                                            <td>${item.batch}</td>
                                            <td class="center" title="${item.expirydate}">
                                                <c:if test="${item.expiry > 0}">
                                                    <c:if test="${item.expiry >= 365}">
                                                        <fmt:parseNumber var="years" integerOnly="true" type="number" value="${item.expiry/365}"/>
                                                        ${years} Years
                                                    </c:if>
                                                    <c:if test="${item.expiry < 365}">
                                                        <c:if test="${item.expiry >= 30}">
                                                            <fmt:parseNumber var="months" integerOnly="true" type="number" value="${item.expiry/30}"/>
                                                            ${months} Months
                                                        </c:if>
                                                        <c:if test="${item.expiry < 30}">
                                                            <c:if test="${item.expiry >= 1}">
                                                                ${item.expiry} Days
                                                            </c:if>
                                                            <c:if test="${item.expiry < 1}">
                                                                No Expiry Date
                                                            </c:if>
                                                        </c:if>
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${item.expiry <= 0}">
                                                    Expired
                                                </c:if>
                                            </td>
                                            <td class="right">${item.opening}</td>
                                            <td class="right">${item.received}</td>
                                            <td class="right">${item.available}</td>
                                            <td class="right">${item.booked}</td>
                                            <td class="center">
                                                <span onclick="popOverlay('${item.batch}')" id="pop${item.batch}" class="btn badge span-size-15 badge-patientinfo" data-toggle="popover" data-id="${item.batch}" data-container="body" data-placement="right" data-html="true" data-original-title="${item.batch}">
                                                    ${item.rounds}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                </div>
            </div>
        </section>
    </div>
</div>
<c:forEach items="${items}" var="item">
    <div id="details${item.batch}" class="hide">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <c:forEach items="${item.deliveries}" var="round">
                            <div id="horizontalwithwords">
                                <span class="pat-form-heading">
                                    <strong>${round.date}</strong>
                                </span>
                            </div>
                            <div class="form-group bs-component center">
                                <span class="control-label pat-form-heading patientConfirmFont">${round.qty}</span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
<script>
    $(document).ready(function () {
        $('#stockItemDetailsTable').DataTable();
        var pdata = [
            {
                value: parseInt('${usable}'.replace(/,/g, '')),
                color: "#27a2b8",
                highlight: "#46BFBD",
                label: "Usable"
            },
            {
                value: parseInt('${discrepancy}'.replace(/,/g, '')),
                color: "#fdc106",
                highlight: "#FDB45C",
                label: "Damaged"
            },
            {
                value: parseInt('${expired}'.replace(/,/g, '')),
                color: "#dc3644",
                highlight: "#F7464A",
                label: "Expired"
            }
        ];
        new Chart($("#stockPie").get(0).getContext("2d")).Pie(pdata);
    });
    function popOverlay(id) {
        $('#pop' + id).popover({
            html: true,
            content: function () {
                var id = $(this).attr('data-id');
                var popup = $('#details' + id).html();
                return popup;
            }
        });
        $('#pop' + id).popover('show');
    }
</script>