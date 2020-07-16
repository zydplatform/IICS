<%-- 
    Document   : cellItems
    Created on : 14-Jun-2018, 09:11:47
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<h2 class="heading" id="colouredborders">Discrepancy:&nbsp;${change}</h2>
<div class="itemBatches">
    <table class="table table-hover table-striped" id="cellRecounts">
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
            <c:forEach items="${batches}" var="batch">
                <tr>
                    <td><%=p++%></td>
                    <td>${batch.batch}</td>
                    <td class="no-wrap">${batch.expiry}</td>
                    <td class="right">${batch.expected}</td>
                    <td class="right">${batch.counted}</td>
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
            Total Expected: <a href="#tablesintables" class="pagenav">${expected}</a>
        </p>
    </div>
    <div class="col-md-6 right">
        <p class="pagenavbox" id="pagenavigation">
            Total Counted: <a href="#tablesintables" class="pagenav">${counted}</a>
        </p>
    </div>
</div>
<div class="row">
    <div class="col-md-12"><hr></div>
    <div class="col-md-11 right">
        <c:if test="${reviewed == false}">
            <button class="btn btn-sm btn-success updateCount" onclick="closeRecount(${recountid}, ${activitycellid})">
                <i class="fa fa-check-circle"></i>&nbsp;Update Previous Count
            </button>
            <button class="btn btn-sm btn-warning updateCount" onclick="ignoreRecount(${recountid}, ${activitycellid})">
                <i class="fa fa-close"></i>&nbsp;Ignore Recount
            </button>
        </c:if>
    </div>
</div>
<script type="text/javascript">
    $('#cellRecounts').DataTable();
</script>