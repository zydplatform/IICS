<%-- 
    Document   : rowCells
    Created on : Apr 18, 2018, 2:43:37 PM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
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
                            <button onclick="viewExpiredCellItems(${cell.id}, '${cell.name}')" class="btn btn-primary item-full-width">
                                View Items
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
</fieldset>