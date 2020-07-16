<%-- 
    Document   : approveItems
    Created on : Apr 30, 2018, 2:59:46 PM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty facilityUnits}">
    <div class="row">
        <div class="col-md-4">
            <select class="form-control" id="displayUnit">
                <c:forEach items="${facilityUnits}" var="unit">
                    <option id="class${unit.id}" data-name="${unit.name}" value="${unit.id}">${unit.name}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div id="catItems">

    </div>
</c:if>
<c:if test="${empty facilityUnits}">
    <div class="row">
        <div class="col-md-12 center">
            <h5>No Units With Pending Catalogue Items</h5>
        </div>
    </div>
</c:if>
<c:if test="${not empty facilityUnits}">
    <script>
        $(document).ready(function () {
            $('#displayUnit').select2();
            $('.select2').css('width', '100%');
            var facilityUnit = $('#displayUnit').val();
            $.ajax({
                type: 'POST',
                data: {facilityUnit: facilityUnit},
                url: 'catalogue/fetchCataloguePendingItems.htm',
                success: function (res) {
                    $('#catItems').html(res);
                }
            });

            $('#displayUnit').change(function () {
                $('#catItems').html('');
                facilityUnit = $('#displayUnit').val();
                $.ajax({
                    type: 'POST',
                    data: {facilityUnit: facilityUnit},
                    url: 'catalogue/fetchCataloguePendingItems.htm',
                    success: function (res) {
                        $('#catItems').html(res);
                    }
                });
            });
        });

        function deleteCatItem(id, itemName) {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Delete Item',
                content: '<strong>' + itemName + '</strong>',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Delete',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {id: id},
                                url: 'catalogue/deleteCatItem.htm',
                                success: function (res) {
                                    if (res === 'deleted') {
                                        $('#approveItemRow' + id).remove();
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Delete Item',
                                            icon: 'warning',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    }
                                }
                            });
                        }
                    },
                    close: {
                        text: 'Cancel'
                    }
                }
            });
        }

        function approveItem(id, itemName) {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Approve Catalogue Item',
                content: '<strong>' + itemName + '</strong>',
                type: 'blue',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Approve',
                        btnClass: 'btn-blue',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {id: id, value: true},
                                url: 'catalogue/approveCatItem.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#approveItemRow' + id).remove();
                                        $.toast({
                                            heading: 'Info',
                                            text: 'Item Activated',
                                            icon: 'info',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Activate Item',
                                            icon: 'warning',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    }
                                }
                            });
                        }
                    },
                    close: {
                        text: 'Cancel'
                    }
                }
            });
        }
    </script>
</c:if>
