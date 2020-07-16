<%-- 
    Document   : shelfPane
    Created on : Apr 18, 2018, 8:36:22 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<c:if test="${not empty bays}">
    <ul class="a-container">
        <c:forEach items="${bays}" var="bay">
            <li class="a-items">
                <input type="radio" name="ac" id="${bay.id}" />
                <label for="${bay.id}">
                    ${bay.name}
                </label>
                <div class="a-content">
                    <ul class="items">
                        <c:forEach items="${bay.rows}" var="row">
                            <li id="bayRow${row.id}" class="classItem border-groove" onclick="bayRowClick(${row.id},'${row.name}')">
                                <h4 class="itemTitle">
                                    ${row.name}
                                </h4>
                                <p class="itemContent">
                                    <strong>
                                        <c:if test="${row.count == 1}">
                                            ${row.count} Cell.
                                        </c:if>
                                        <c:if test="${row.count != 1}">
                                            ${row.count} Cells.
                                        </c:if>
                                    </strong>
                                </p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>
<script>
    $(document).ready(function () {
        breadCrumb();
        $('.a-container li:first-child > label').click();
        $('.a-container li:first-child > .a-content > .items li:first-child').click();
        $('.a-container li:first-child > .a-content > .items li:first-child').addClass('active-li');
    });
    
    function bayRowClick(rowid, rowName) {
        $('#bayRow' + rowid).siblings().removeClass('active-li');
        $('#bayRow' + rowid).addClass('active-li');
        document.getElementById('selectedRow').value = rowid;
        if (rowid > 0) {
            $.ajax({
                type: 'POST',
                data: {rowid: rowid, rowname: rowName},
                url: 'store/fetchRowCellContent.htm',
                success: function (response) {
                    $('#cellContent').html(response);
                }
            });
        }
    }
</script>