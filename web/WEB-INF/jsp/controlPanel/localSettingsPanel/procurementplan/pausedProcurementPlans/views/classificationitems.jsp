<%-- 
    Document   : classificationitems
    Created on : Apr 10, 2018, 2:47:28 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<style>
    li:nth-child(even) {
        background-color: #dddddd;
    }
</style>
<c:if test="${size <= 3}">
    <ul id="myUL2" class="list-group" style="height:auto;overflow: scroll;">
        <c:forEach items="${items}" var="item">
            <li class="list-group-item"><a id="${item.itemid}" onclick="pausedadditemtoprocurementplan(this.id);" href="#">${item.genericname}</a></li>
            </c:forEach>
    </ul>
</c:if>
<c:if test="${size >= 4}">
    <ul id="myUL2" class="list-group" style="height:200px;overflow: scroll;">
        <c:forEach items="${items}" var="item">
            <li class="list-group-item"><a id="${item.itemid}" onclick="pausedadditemtoprocurementplan(this.id);" href="#">${item.genericname}</a></li>
        </c:forEach>
    </ul>
</c:if>
<script>
    function searchlist2() {
        var input, filter, ul, li, a, i;
        input = document.getElementById('myInput2');
        filter = input.value.toUpperCase();
        ul = document.getElementById("myUL2");
        li = ul.getElementsByTagName('li');

        // Loop through all list items, and hide those who don't match the search query
        for (i = 0; i < li.length; i++) {
            a = li[i].getElementsByTagName("a")[0];
            if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
                li[i].style.display = "";
            } else {
                li[i].style.display = "none";
            }
        }
    }
</script>