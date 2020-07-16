<%-- 
    Document   : staffAssignedItems
    Created on : 19-Jun-2018, 12:30:30
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<div class="tile">
    <div class="row">
        <c:if test="${not empty assignedItems}">
            <div class="col-md-12">
                <table class="table table-hover table-striped" id="assignedItems">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Item</th>
                            <th>Cell</th>
                            <th class="right">Quantity Counted</th>
                            <th class="center">Status</th>
                            <th class="center">Manage</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int p = 1;%>
                        <c:forEach items="${assignedItems}" var="item">
                            <tr>
                                <td class="middle"><%=p++%></td>
                                <td class="middle">${item.name}</td>
                                <td class="middle">${item.cell}</td>
                                <td class="middle right">${item.qty}</td>
                                <td class="middle" id="recountStatus${item.id}">
                                    <c:if test="${item.status == 'PENDING'}">
                                        <span class="order-items-process span-size">
                                            <span class="badge badge-warning">Pending</span>
                                        </span>
                                    </c:if>
                                    <c:if test="${item.status != 'PENDING'}">
                                        <span class="order-items-process span-size">
                                            <span class="badge badge-info">Submitted</span>
                                        </span>
                                    </c:if>
                                </td>
                                <td class="center" id="manageR${item.id}">
                                    <c:if test="${item.status == 'PENDING'}">
                                        <a href="#!" onclick="submitItemRecount(${item.id}, '${item.name}')" title="Submit Items">
                                            <i class="fa fa-fw fa-lg fa-check-square"></i>
                                        </a><br><br>
                                        <a href="#viewItemRecount" onclick="viewItemRecounts(${item.id}, '${item.name}')" title="View Item Recount">
                                            <i class="fa fa-fw fa-lg fa-dedent"></i>
                                        </a>
                                        <a href="#recountItem" onclick="recountCellItems(${item.id}, '${item.name}')" title="Recount Item">
                                            <i class="fa fa-fw fa-lg fa-edit"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${item.status != 'PENDING'}">
                                        <a href="#viewItemRecount" onclick="viewItemRecounts(${item.id}, '${item.name}')" title="View Items">
                                            <i class="fa fa-fw fa-lg fa-dedent"></i>
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        <c:if test="${empty assignedItems}">
            <div class="col-md-12 center">
                <h5>No Pending Item Recounts Assigned to You.</h5>
            </div>
        </c:if>
    </div>
</div>
<c:if test="${not empty assignedItems}">
    <script type="text/javascript">
        $('#assignedItems').DataTable();
    </script>
</c:if>