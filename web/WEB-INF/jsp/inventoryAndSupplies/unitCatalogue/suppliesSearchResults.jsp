<%-- 
    Document   : itemSearchResults
    Created on : Apr 10, 2018, 5:41:41 PM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<c:if test="${not empty items}">
    <ul class="items" id="foundItems">
        <c:forEach items="${items}" var="item">
            <li id="li${item.id}" class="classItem border-groove" onclick="addCatalogueItem(${item.id}, '${item.name}', '${item.specification}')">
                <h5 class="itemTitle">
                    ${item.name}
                </h5>
                <p class="itemContent">
                    ${item.specification}
                </p>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty items}">
    <p class="center">
        <br>
        Item <strong>${name}</strong> Not Found under Medical Supplies.
    </p>
</c:if>
<script>
    $(document).ready(function () {
        var items = Array.from(itemList);
        for (i in items) {
            $('#li' + items[i]).remove();
        }
    });
    function addCatalogueItem(itemid, itemName, specification) {
        $.confirm({
            title: '<h3>Add Selected Item</h3>',
            content: '<h4 class="itemTitle">' + itemName + '</h4>' +
                    '<h4 class="itemContent">Specification: ' + specification + '</h4>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Add',
                    btnClass: 'btn-purple',
                    action: function () {
                        if (!itemList.has(itemid)) {
                            itemList.add(itemid);
                            $('#enteredSuppliesBody').append(
                                    '<tr id="row' + itemid + '">' +
                                    '<td>' + itemName + '</td>' +
                                    '<td class="right">' + specification + '</td>' +
                                    '<td class="center">' +
                                    '<span class="badge badge-danger icon-custom" onclick="remove(' + itemid + ')">' +
                                    '<i class="fa fa-close"></i></span></td>' +
                                    '</tr>'
                                    );
                            $('#li' + itemid).remove();
                        }
                    }
                },
                close: {
                    text: 'Cancel',
                    btnClass: 'btn-red'
                }
            }
        });
    }
</script>
