<%-- 
    Document   : itemSearchResults
    Created on : Apr 10, 2018, 5:41:41 PM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty unitStaffList}">
    <ul class="items" id="foundItems">
        <c:forEach items="${unitStaffList}" var="staff">
            <li id="li${staff.id}" class="classItem border-groove" onclick="selectStaff(${staff.id}, '${staff.names}')">
                <h5 class="itemTitle">
                    ${staff.names}
                </h5>
                <p class="itemContent">
                    <c:if test="${staff.cellCount == 1}">
                        ${staff.cellCount} Cell.
                    </c:if>
                    <c:if test="${staff.cellCount != 1}">
                        ${staff.cellCount} Cells.
                    </c:if>
                </p>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty unitStaffList}">
    <p class="center">
        <br>
        No Facility Unit found for this Facility.
    </p>
</c:if>
<script>
    function selectStaff(staffid, staffnames) {
        $.confirm({
            title: '<h3>' + staffnames + '</h3>',
            content: '<h4 class="itemTitle">Assign ' + selectedCells.size + ' cell(s) to <strong>' + staffnames + '</strong></h4>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Save Allocation',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {staffid:staffid, cells:JSON.stringify(Array.from(selectedCells))},
                            url: 'stock/saveStaffAllocations.htm',
                            success: function (res) {
                                if (res === 'updated') {
                                    ajaxSubmitData('stock/stockManagementPane.htm', 'workpane', '&tab=tab2', 'GET');
                                } else if (res === 'refresh') {
                                    document.location.reload(true);
                                }
                            }
                        });
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
</script>
