<%-- 
    Document   : shelfItems
    Created on : Apr 19, 2018, 12:52:04 PM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<div class="col-sm-12 col-md-12">
    <table class="table table-hover table-bordered" id="shelfItems">
        <thead>
            <tr>
                <th>No</th>
                <th>Item</th>
                <th>Batch</th>
                <th class="right">Quantity</th>
                <th class="center">Expiry</th>
                <th class="center">Transfer</th>
            </tr>
        </thead>
        <tbody id="bodyItems">
            <% int k = 1;%>
            <c:forEach items="${stockItems}" var="item">
                <tr>
                    <td><%=k++%></td>
                    <td>${item.name}</td>
                    <td>${item.batch}</td>
                    <td class="right">${item.qty}</td>
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
                    <td class="center">
                        <button onclick="isolateExpiredItem(${item.id}, '${item.name}', '${item.qty}', ${item.stockid}, ${item.expiry})" title="Isolate Item." class="btn btn-primary btn-sm">
                            <i class="fa fa-share"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script>
    $('#shelfItems').dataTable();
</script>