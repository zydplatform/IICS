<%-- 
    Document   : classCategories
    Created on : May 2, 2018, 12:48:02 PM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<div class="tile">
    <ul class="items" id="foundItems">
        <c:forEach items="${categories}" var="category">
            <li class="classItem border-groove" id="cat-li${category.id}" onclick="fetchCategoryItems(${category.id})">
                <h5 class="itemTitle">
                    ${category.name}
                </h5>
                <p class="itemContent">
                    <c:if test="${category.count == 1}">
                        ${category.count} Item
                    </c:if>
                    <c:if test="${category.count != 1}">
                        ${category.count} Items
                    </c:if>
                </p>
            </li>
        </c:forEach>
    </ul>
</div>
<script>
    $(document).ready(function () {
        $('#tab2').click(function () {
            $('#classCategories > .tile > .items li:first-child').click();
            $('#classCategories > .tile > .items li:first-child').addClass('active-li');
        });
        $('#classCategories > .tile > .items li:first-child').click();
        $('#classCategories > .tile > .items li:first-child').addClass('active-li');
    });
</script>