<%-- 
    Document   : approveItems
    Created on : Apr 30, 2018, 2:59:46 PM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<div class="row">
    <div class="col-md-4">
        <form>
            <div class="form-group">
                <select class="form-control" id="approvalgroup">
                    <option value="0" selected="true">Medicines</option>
                    <option value="1">Supplies</option>
                </select>
            </div>
        </form>
    </div>
</div>
<div id="unitItems">
    
</div>
<script>
    $(document).ready(function () {
        $('#approvalgroup').select2();
        $('.select2').css('width', '100%');
        var issupplies = parseInt($('#approvalgroup').val()) === 1;
        ajaxSubmitData('catalogue/fetchUnitPendingItems.htm', 'unitItems', '&issupplies=' + issupplies, 'GET');
        $('#approvalgroup').change(function () {
            $('#unitItems').html('');
            issupplies = parseInt($('#approvalgroup').val()) === 1;
            ajaxSubmitData('catalogue/fetchUnitPendingItems.htm', 'unitItems', '&issupplies=' + issupplies, 'GET');
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
                                    ajaxSubmitData('catalogue/loadUnitCatalogPane.htm', 'workpane', 'tab=2', 'GET');
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
                                        text: 'Item Approved',
                                        icon: 'info',
                                        hideAfter: 2000,
                                        position: 'mid-center'
                                    });
                                    ajaxSubmitData('catalogue/loadUnitCatalogPane.htm', 'workpane', 'tab=2', 'GET');
                                } else if (res === 'refresh') {
                                    document.location.reload(true);
                                } else {
                                    $.toast({
                                        heading: 'Warning',
                                        text: 'Failed to Approve Item',
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
