<%-- 
    Document   : stockCard
    Created on : Oct 23, 2018, 11:08:42 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<div class="col-md-12">
    <div class="tile tile-no-padding">
        <section class="invoice">
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-striped">
                        <tbody>
                            <tr>
                                <td class="span-size-15">
                                    <strong>Average Consumption</strong>
                                </td>
                                <td class="right">
                                    <c:if test="${averageConsumption == 0}">
                                        <span class="badge span-size-15 badge-warning">Undefined</span>
                                    </c:if>
                                    <c:if test="${averageConsumption > 0}">
                                        <span class="badge span-size-15 badge-warning">
                                            <fmt:formatNumber type="number" maxFractionDigits="0" value="${averageConsumption}"/>/Week
                                        </span>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <td class="span-size-15">
                                    <strong>Stock Available</strong>
                                </td>
                                <td class="right">
                                    <span class="badge span-size-15 badge-warning">${available}</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="span-size-15">
                                    <strong>Estimated Duration</strong>
                                </td>
                                <td class="right">
                                    <c:if test="${projection == -1}">
                                        <span class="badge span-size-15 badge-success">&infin;</span>
                                    </c:if>
                                    <c:if test="${projection != -1}">
                                        <span class="badge span-size-15 badge-success">
                                            <c:if test="${projection < 1}">
                                                <fmt:parseNumber var="days" integerOnly="true" type="number" value="${projection * 7}"/>
                                                <c:if test="${days < 1}">
                                                    0 Weeks
                                                </c:if>
                                                <c:if test="${days == 1}">
                                                    1 Day.
                                                </c:if>
                                                <c:if test="${days > 1}">
                                                    ${days} Days
                                                </c:if>
                                            </c:if>
                                            <c:if test="${projection >= 1}">
                                                <c:if test="${projection < 1.5}">
                                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${projection}"/>&nbsp;Week
                                                </c:if>
                                                <c:if test="${projection >= 1.5}">
                                                    <c:if test="${projection < 6}">
                                                        <fmt:formatNumber type="number" maxFractionDigits="0" value="${projection/4}"/>&nbsp;Month
                                                    </c:if>
                                                    <c:if test="${projection >= 6}">
                                                        <c:if test="${projection < 56}">
                                                            <fmt:formatNumber type="number" maxFractionDigits="0" value="${projection/4}"/>&nbsp;Months
                                                        </c:if>
                                                        <c:if test="${projection >= 56}">
                                                            <fmt:formatNumber type="number" minFractionDigits="1" maxFractionDigits="1" value="${projection/56}"/>&nbsp;Years
                                                        </c:if>
                                                    </c:if>
                                                </c:if>
                                            </c:if>
                                        </span>
                                    </c:if>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12 table-responsive">
                    <fieldset>
                        <div class="row">
                            <table class="table table-hover table-bordered dataTable no-footer" id="stockItemDetailsTable">
                                <thead>
                                    <tr role="row">
                                        <th>Date</th>
                                        <th>To/From</th>
                                        <th>Reference</th>
                                        <th class="right">Qty In</th>
                                        <th class="right">Qty Out</th>
                                        <th class="right">Balance</th>
                                        <th class="right">User</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>${openingStock.date}</td>
                                        <td>B/cF</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td class="right">${openingStock.opening}</td>
                                        <td class="right">-</td>
                                    </tr>
                                    <c:forEach items="${dailyTransactions}" var="transaction">
                                        <c:if test="${transaction.type == 'in'}">
                                            <tr class="text-success">
                                                <td>${transaction.date}</td>
                                                <td>${transaction.reference}</td> 
                                                <c:if test="${transaction.refno.length() == 1}">
                                                    <td>${transaction.refno}</td>
                                                </c:if>                                                
                                                <c:if test="${transaction.refno.length() > 1 && transaction.reference.toLowerCase() != 'Dispensed'.toLowerCase()}">    
                                                    <td><a href="#" class="text-info reference-link" data-ref-no="${transaction.refno}">${transaction.refno}</a></td>
                                                </c:if>
                                                <td class="right">${transaction.bal}</td>
                                                <td class="right"></td>
                                                <td class="right">
                                                    <u><strong>${transaction.total}</strong></u>
                                                </td>
                                                <td class="right">
                                                    <strong>${transaction.user}</strong>
                                                </td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${transaction.type != 'in'}">
                                            <tr class="text-info">
                                                <td>${transaction.date}</td>
                                                <td>${transaction.reference}</td>
                                                <c:if test="${transaction.refno.length() == 1}">
                                                    <td>${transaction.refno}</td>
                                                </c:if>
                                                <c:if test="${transaction.refno.length() > 1 && transaction.reference.toLowerCase() == 'Dispensed'.toLowerCase()}">    
                                                    <td><a href="#" class="text-info prescription-reference-link" data-ref-no="${transaction.refno}">${transaction.refno}</a></td>
                                                </c:if>
                                                <c:if test="${transaction.refno.length() > 1 && transaction.reference.toLowerCase() != 'Dispensed'.toLowerCase()}">    
                                                    <td><a href="#" class="text-info reference-link" data-ref-no="${transaction.refno}">${transaction.refno}</a></td>
                                                </c:if>
                                                <td class="right"></td>
                                                <td class="right">${transaction.bal}</td>
                                                <td class="right">
                                                    <u><strong>${transaction.total}</strong></u>
                                                </td>
                                                <td class="right">
                                                    <strong>${transaction.user}</strong>
                                                </td>
                                            </tr>
                                        </c:if>
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
<script>
    $('a.prescription-reference-link').on('click', function(e){
        e.preventDefault();
        e.stopPropagation();
        var referenceNumber = $(this).data('ref-no');
        $.ajax({
            type: 'GET',
            url: 'store/prescriptioninfo.htm',
            data: { referencenumber: referenceNumber },
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                        icon: 'info',
                        title: 'PRESCRIPTION INFO',
                        content: data,
                        type: 'purple',
                        typeAnimated: true,
                        boxWidth: '35%',
                        useBootstrap: false,
                        buttons: {
                            cancel: {
                                text: 'Cancel',
                                btnClass: 'btn-purple',
                                action: function () {
                                }
                            }
                        }
                    });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    });
    
    $('a.reference-link').on('click', function(e){
        e.preventDefault();
        e.stopPropagation();
        var referenceNumber = $(this).data('ref-no');
        $.ajax({
            type: 'GET',
            url: 'store/orderinfo.htm',
            data: { referencenumber: referenceNumber },
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                        icon: 'info',
                        title: 'ORDER INFO',
                        content: data,
                        type: 'purple',
                        typeAnimated: true,
                        boxWidth: '35%',
                        useBootstrap: false,
                        buttons: {
                            cancel: {
                                text: 'Cancel',
                                btnClass: 'btn-purple',
                                action: function () {
                                }
                            }
                        }
                    });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    });
</script>                                        