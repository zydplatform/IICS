<%-- 
    Document   : itemSearchResults
    Created on : Apr 10, 2018, 5:41:41 PM
    Author     : IICS
--%>
<%@include file="include.jsp" %>
<c:if test="${not empty facilities}">
    <div class="row resultDiv">
        <div class="col-sm-12 col-md-12">
            <div class="account-wall accountchooser">
                <ol class="accounts">
                    <c:forEach items="${facilities}" var="facility">
                        <li onclick="selectFacility(${facility.id}, '${facility.name}')">
                            <button type="submit" name="Email" value="example@gmail.com">
                                <span class="account-name">${facility.name} (${facility.level})</span>
                                <span class="account-email">${facility.village}&nbsp;(${facility.sub})</span>
                            </button>
                        </li>
                    </c:forEach>
                </ol>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${empty facilities}">
    <p class="center">
        <br>
        No Results found for search <strong>${name}</strong>.
    </p>
</c:if>
<script>
    function selectFacility(facilityid, facilityName) {
        $.confirm({
            title: '<h3 class="itemTitle">' + facilityName + '</h3>',
            content: '<div class="row"><div class="col-md-12">' +
                    '<div class="form-group"> ' +
                    '<label for="units">Select Unit</label>' +
                    '<select id="units" class="form-control"/>' +
                    '</select></div>' +
                    '</div></div>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Switch',
                    btnClass: 'btn-purple',
                    action: function () {
                        var selectedUnit = this.$content.find('#units').val();
                        if (parseInt(selectedUnit) > 0) {
                            var data = {
                                facilityid: facilityid,
                                unitid: selectedUnit
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'switchLocations/changeUserSession.htm',
                                success: function (res) {
                                    document.location.reload(true);
                                }
                            });
                        }
                    }
                },
                close: {
                    text: 'Cancel',
                    btnClass: 'btn-red',
                    action: function () {

                    }
                }
            },
            onContentReady: function () {
                // bind to events
                var units = this.$content.find('#units');
                $.ajax({
                    type: 'POST',
                    data: {facilityid: facilityid},
                    url: 'switchLocations/fetchFacilityUnits.htm',
                    success: function (res) {
                        if (res !== 'refresh') {
                            var unitList = JSON.parse(res);
                            if (unitList.length > 0) {
                                for (i in unitList) {
                                    units.append('<option value="' + unitList[i].id + '">' + unitList[i].name + '</option>');
                                }
                            } else {
                                units.append('<option value="0">No Units Set</option>');
                            }
                        } else {
                            document.location.reload(true);
                        }
                    }
                });
            }
        });
    }
</script>
