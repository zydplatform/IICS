<%-- 
    Document   : inventoryPane
    Created on : Apr 10, 2018, 7:24:47 AM
    Author     : IICS
--%>
<div class="app-title" id="">
    <input value="${tab}" type="hidden" id="curTab"/>
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>
    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="window.location.reload(true);"></a></li>
                    <li><a href="#" onclick="ajaxSubmitData('store/inventoryAndSupplies.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Inventory & Supplies</a></li>
                    <li class="last active"><a href="#">Unit Catalogue</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <main id="main">
            <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab1">Set Items</label>

            <input id="tab2" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab2">
                Approve Items
                <span class="badge badge-pill badge-info">${pending}</span>
            </label>

            <input id="tab3" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab3">Approved Items</label>

            <section class="tabContent" id="content1">
                <div>
                    <%@include file="manageItems.jsp" %>
                </div>
            </section>
            <section class="tabContent" id="content2">
                <div>
                    <%@include file="approveItems.jsp" %>
                </div>
            </section>
            <section class="tabContent" id="content3">
                <div>
                    <%@include file="approvedItems.jsp" %>
                </div>
            </section>
        </main>
    </div>
</div>
<script>
    $(document).ready(function () {
        var tab = parseInt($('#curTab').val());
        if(tab === 2)
            $('#tab2').click();
        else if(tab === 3)
            $('#tab3').click();
    });
    breadCrumb();
    function catItemStatus(id, itemName, status) {
        if (status.length < 1) {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Activate Item',
                content: '<strong>' + itemName + '</strong>',
                type: 'blue',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Activate',
                        btnClass: 'btn-blue',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {id: id, value: true},
                                url: 'catalogue/activateCatItem.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#switch' + id + 'content').html('<label class="switch"><input id="swith' + id + 'Value" type="checkbox" checked><span onclick="catItemStatus(' + id + ', \'' + itemName + '\', \'checked\')" class="slider round"></span></label>');
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Item Activated',
                                            icon: 'success',
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
                        text: 'Cancel',
                        action: function () {
                            $('#swith' + id + 'Value').click();
                        }
                    }
                }
            });
        } else {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Deactivate Item',
                content: '<strong>' + itemName + '</strong>',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Deactivate',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {id: id, value: false},
                                url: 'catalogue/activateCatItem.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#switch' + id + 'content').html('<label class="switch"><input id="swith' + id + 'Value" type="checkbox"><span onclick="catItemStatus(' + id + ', \'' + itemName + '\', \'\')" class="slider round"></span></label>');
                                        $.toast({
                                            heading: 'Info',
                                            text: 'Item Dectivated',
                                            icon: 'info',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Deactivate Item',
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
                        text: 'Cancel',
                        action: function () {
                            $('#swith' + id + 'Value').click();
                        }
                    }
                }
            });
        }
    }
</script>