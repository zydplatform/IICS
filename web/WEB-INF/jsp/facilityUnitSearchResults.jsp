<%-- 
    Document   : facilityUnitSearchResults
    Created on : Sep 11, 2018, 4:05:38 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="include.jsp" %>
<c:if test="${not empty units}">
    <div class="row resultDiv">
        <div class="col-sm-12 col-md-12">
            <div class="account-wall accountchooser">
                <ol class="accounts">
                    <c:forEach items="${units}" var="unit">
                        <li onclick="selectFacilityUnit('${unit.id}', '${unit.name}', '${unit.facilityid}');">
                            <button type="submit" name="unit" value="${unit.name}">
                                <span class="account-name">${unit.name}</span>
                            </button>
                        </li>
                    </c:forEach>
                </ol>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${empty units}">
    <p class="center">
        <br>
        No Results found for search <strong>${name}</strong>.
    </p>
</c:if>
<script>
    function selectFacilityUnit(selectedUnit, unitName, facilityid) {
        $.ajax({
            type: "POST",
            cache: false,
            url: "switchLocations/changeUserSession.htm",
            data: {facilityid: facilityid,unitid: selectedUnit},
            success: function (res) {
                document.location.reload(true);
            }
        });
    }
</script>
