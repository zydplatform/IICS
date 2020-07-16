<%-- 
    Document   : itemSearchResults
    Created on : Apr 10, 2018, 5:41:41 PM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty cells}">
    <ul class="items" id="foundItems">
        <c:forEach items="${cells}" var="cell">
            <li id="li${cell.id}" class="classItem border-groove" onclick="selectCell(${cell.id}, '${cell.name}', '${cell.row}', '${cell.bay}', '${cell.zone}')">
                <h5 class="itemTitle">
                    ${cell.name}
                </h5>
                <p class="itemContent">
                    ${cell.bay}
                </p>
            </li>
        </c:forEach>
        <li id="li${cell.id}" class="classItem text-center">
            <button class="btn btn-sm btn-primary icon-btn" onclick="selectAll()">
                Select All
            </button>
        </li>
    </ul>
</c:if>
<c:if test="${empty cells}">
    <p class="center">
        <br>
        No cells found for search <strong>${name}</strong>.
    </p>
</c:if>
<script>
    var allCells = ${jsonCells};
    $(document).ready(function () {
        var cells = Array.from(cellList);
        for (i in cells) {
            $('#li' + cells[i]).remove();
            for (x in allCells) {
                if (allCells[x].id === cells[i]) {
                    allCells.splice(x, 1);
                }
            }
        }
    });
    function selectCell(cellId, cellLabel, rowLabel, bayLabel, zoneLabel) {
        $.confirm({
            title: '<h3>Add Selected Cell</h3>',
            content: '<h4 class="itemTitle">' + cellLabel + '</h4>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Add',
                    btnClass: 'btn-purple',
                    action: function () {
                        if (!cellList.has(cellId)) {
                            cellList.add(cellId);
                            $('#enteredItemsBody').append(
                                    '<tr id="cellrow' + cellId + '">' +
                                    '<td>' + zoneLabel + '</td>' +
                                    '<td>' + bayLabel + '</td>' +
                                    '<td>' + rowLabel + '</td>' +
                                    '<td>' + cellLabel + '</td>' +
                                    '<td class="center">' +
                                    '<span class="badge badge-danger icon-custom" onclick="removeCell(' + cellId + ')">' +
                                    '<i class="fa fa-close"></i></span></td>' +
                                    '</tr>'
                                    );
                            $('#li' + cellId).remove();
                            for (i in allCells) {
                                if (allCells[i].id === cellId) {
                                    allCells.splice(i, 1);
                                    break;
                                }
                            }
                        }
                    }
                },
                close: {
                    text: 'Cancel',
                    btnClass: 'btn-red',
                    action: function () {

                    }
                }
            }
        });
    }

    function selectAll() {
        for (i in allCells) {
            if (!cellList.has(allCells[i].id)) {
                cellList.add(allCells[i].id);
                $('#enteredItemsBody').append(
                        '<tr id="cellrow' + allCells[i].id + '">' +
                        '<td>' + allCells[i].zone + '</td>' +
                        '<td>' + allCells[i].bay + '</td>' +
                        '<td>' + allCells[i].row + '</td>' +
                        '<td>' + allCells[i].name + '</td>' +
                        '<td class="center">' +
                        '<span class="badge badge-danger icon-custom" onclick="removeCell(' + allCells[i].id + ')">' +
                        '<i class="fa fa-close"></i></span></td>' +
                        '</tr>'
                        );
                $('#li' + allCells[i].id).remove();
            }
        }
        allCells = [];
    }
</script>
