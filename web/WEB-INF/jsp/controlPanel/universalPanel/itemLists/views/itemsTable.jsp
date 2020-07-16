<%-- 
    Document   : itemsTable
    Created on : Mar 24, 2018, 8:19:32 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<table class="table table-hover table-bordered" id="itemsTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Item</th>
            <th>Code</th>
            <th class="center">Form</th>
            <th class="center">Activation</th>
            <th class="center">Manage</th>
        </tr>
    </thead>
    <tbody id="bodyItems">
        <% int k = 1;%>
        <c:forEach items="${items}" var="item">
            <tr>
                <td><%=k++%></td>
                <td id="tdname${item.id}">${item.name}</td>
                <td id="tdcode${item.id}">${item.code}</td>
                <td id="tdform${item.id}">${item.form}</td>
                <td class="center" id="item${item.id}content">
                    <label class="switch">
                        <input id="item${item.id}" type="checkbox" ${item.status}>
                        <span onclick="itemStatus(${item.id}, '${item.name}', '${item.status}')" class="slider round"></span>
                    </label>
                </td>
                <td id="tdmanage${item.id}" class="center">
                    <a href="#!" data-trigger="focus" data-toggle="popover" data-id="${item.id}" data-container="body" data-placement="right" data-html="true" data-original-title="${item.name}">
                        <i class="fa fa-fw fa-lg fa-dedent"></i>
                    </a>&nbsp;|&nbsp;
                    <a href="#!" onclick="editItem(${item.id}, '${item.name}', '${item.code}', ${item.formid}, ${item.typeid}, ${item.catid}, ${item.classid})">
                        <i class="fa fa-fw fa-lg fa-edit"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<c:forEach items="${items}" var="item">
    <div id="itemDetails${item.id}" class="hide">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <form id="entryform">
                            <div id="horizontalwithwords">
                                <span class="pat-form-heading"><strong>System Item Code</strong></span>
                            </div>
                            <div class="form-group bs-component center">
                                <span class="control-label pat-form-heading patientConfirmFont code${item.id}">${item.code}</span>
                            </div><br>
                            <div id="horizontalwithwords">
                                <span class="pat-form-heading"><strong>Dosage Form</strong></span>
                            </div>
                            <div class="form-group bs-component center">
                                <span class="control-label pat-form-heading patientConfirmFont form${item.id}">${item.form}</span>
                            </div><br>
                            <div id="horizontalwithwords">
                                <span class="pat-form-heading"><strong>Administration</strong></span>
                            </div>
                            <div class="form-group bs-component center">
                                <span class="control-label pat-form-heading patientConfirmFont type${item.id}">${item.type}</span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
<script>
    $(document).ready(function () {
        $('#itemsTable').DataTable();
        $('[data-toggle=popover]').each(function (i, obj) {
            $(this).popover({
                html: true,
                content: function () {
                    var id = $(this).attr('data-id');
                    var popup = $('#itemDetails' + id).html();
                    return popup;
                }
            });
        });
        $('#itemsTable_paginate > .pagination > li').click(function () {
            $('[data-toggle=popover]').each(function (i, obj) {
                $(this).popover({
                    html: true,
                    content: function () {
                        var id = $(this).attr('data-id');
                        console.log(id);
                        var popup = $('#itemDetails' + id).html();
                        return popup;
                    }
                });
            });
        });
    });

    function itemStatus(id, itemName, status) {
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
                                url: 'store/activateItem.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#item' + id + 'content').html('<label class="switch"><input id="item' + id + '" type="checkbox" checked><span onclick="itemStatus(' + id + ', \'' + itemName + '\', \'checked\')" class="slider round"></span></label>');
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
                            $('#item' + id).click();
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
                                url: 'store/activateItem.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#item' + id + 'content').html('<label class="switch"><input id="item' + id + '" type="checkbox"><span onclick="itemStatus(' + id + ', \'' + itemName + '\', \'\')" class="slider round"></span></label>');
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
                            $('#item' + id).click();
                        }
                    }
                }
            });
        }
    }
</script>