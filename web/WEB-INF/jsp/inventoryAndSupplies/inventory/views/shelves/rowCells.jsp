<%-- 
    Document   : rowCells
    Created on : Apr 18, 2018, 2:43:37 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<fieldset>
    <c:if test="${not empty cells}">
        <div class="row">
            <c:forEach items="${cells}" var="cell">
                <div class="col-md-4 col-sm-4 padding">
                    <div class="card text-center">
                        <div class="card-header">
                            <h5 class="card-title">
                                ${cell.name}
                            </h5>
                        </div>
                        <div class="card-body">
                            <h5 class="card-subtitle mb-2 text-muted">
                                <c:if test="${cell.count == '1'}">
                                    ${cell.count} Item
                                </c:if>
                                <c:if test="${cell.count != '1'}">
                                    <c:if test="${cell.count == '0'}">
                                        Cell Empty
                                    </c:if>
                                    <c:if test="${cell.count != '0'}">
                                        ${cell.count} Items
                                    </c:if>
                                </c:if>
                            </h5>
                        </div>
                        <div class="card-footer text-muted">
                            <c:if test="${cell.count == '0'}">
                                <button disabled="true" class="btn btn-warning item-full-width">
                                    No Items
                                </button>
                            </c:if>
                            <c:if test="${cell.count != '0'}">
                                <button onclick="cellClick(${cell.id}, '${cell.name}')" class="btn btn-primary item-full-width">
                                    View Items
                                </button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    <c:if test="${empty cells}">
        <c:if test="${search == false}">
            <h5 class="center">
                Row <strong>${rowName}</strong> has no <strong>cells.</strong>
            </h5>
        </c:if>
        <c:if test="${search == true}">
            <h5 class="center">
                No results found for <strong>${rowName}</strong> Search.
            </h5>
        </c:if>
    </c:if>
</fieldset>