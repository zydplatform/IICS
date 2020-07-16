<%-- 
    Document   : itemPackages
    Created on : Aug 22, 2018, 6:43:29 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div id="addingItmsPackingDiv"> 
    <div style="margin: 10px;">
        <div class="row">
            <div class="col-md-6">
                <button onclick="addnewItemStrength(${itemid});" class="btn btn-primary pull-left" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Strength</button>
            </div>
            <div class="col-md-6">
                <button onclick="addnewItemPackSizie(${itemid});" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Description</button>
            </div>
        </div>
        <fieldset style="min-height:100px;">
            <table class="table table-hover table-bordered" id="ItemPacksTable">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Description</th>
                        <th>Size</th>
                        <th>Activation</th>
                    </tr>
                </thead>
                <tbody >
                    <% int k = 1;%>
                    <% int p = 1;%>
                    <c:forEach items="${itemPackagesFound}" var="b">
                        <tr>
                            <td><%=k++%></td>
                            <td>${b.packagename}</td>
                            <td>${b.qty}</td>
                            <td align="center">
                                <div class="toggle-flip">
                                    <label>
                                        <input id="apack<%=p++%>" type="checkbox"<c:if test="${b.isactive==true}">checked="checked"</c:if> onchange="if (this.checked) {
                                                    disablingpackagingItems(${b.itemid}, 'checked',${size}, this.id);
                                                } else {
                                                    disablingpackagingItems(${b.itemid}, 'unchecked', ${size}, this.id);
                                                }"><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Active" data-toggle-off="Disabled"></span>
                                    </label>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table> 
        </fieldset>
    </div>  
</div>

<script>
    $('#ItemPacksTable').DataTable();
    function addnewItemPackSizie(itemid) {
        $.ajax({
            type: 'GET',
            data: {itemid: itemid},
            url: "essentialmedicinesandsupplieslist/addnewItemPackSizie.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'ADD NEW ITEM DESCRIPTION',
                    content: '' + data,
                    type: 'purple',
                    closeIcon: true,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Save',
                            btnClass: 'btn-purple',
                            action: function () {
                                var ItemPack = this.$content.find('.selectItemPack').val();
                                var itempacksizes = this.$content.find('.itempacksizes').val();
                                if (!itempacksizes) {
                                    $.alert('provide a valid Size');
                                    return false;
                                }
                                if (ItemPack === 'select') {
                                    $.alert('provide a valid Pack');
                                    return false;
                                }
                                $.ajax({
                                    type: 'POST',
                                    data: {ItemPack: ItemPack, itempacksizes: itempacksizes, itemid: itemid},
                                    url: "essentialmedicinesandsupplieslist/saveitempackagesizes.htm",
                                    success: function (data, textStatus, jqXHR) {
                                        $.confirm({
                                            title: 'ADD NEW ITEM DESCRIPTIONS',
                                            content: 'Do You Want To Add Another Description?',
                                            type: 'red',
                                            typeAnimated: true,
                                            buttons: {
                                                tryAgain: {
                                                    text: 'Yes',
                                                    btnClass: 'btn-red',
                                                    action: function () {
                                                        addnewItemPackSizie(itemid);
                                                    }
                                                },
                                                No: function () {
                                                    ajaxSubmitData('essentialmedicinesandsupplieslist/itempackages.htm', 'addingItmsPackingDiv', 'itemid=' + itemid + '&act=b&type=categoery&ofst=1&maxR=100&sStr=', 'GET');
                                                }
                                            }
                                        });
                                    }
                                });
                            }
                        },
                        close: function () {
                        }
                    }
                });
            }
        });
    }
    function disablingpackagingItems(itemid, type, size, id) {
        if (type === 'unchecked') {
            if (size > 1) {
                $.confirm({
                    title: 'DISABLE DESCRIPTION',
                    content: 'Are You Sure You Want To Disable?',
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Yes',
                            btnClass: 'btn-purple',
                            action: function () {
                                $.ajax({
                                    type: 'POST',
                                    data: {itemid: itemid, type: 'disable'},
                                    url: "essentialmedicinesandsupplieslist/disableitempackagings.htm",
                                    success: function (data, textStatus, jqXHR) {
                                        $.confirm({
                                            title: 'DISABLE DESCRIPTION',
                                            content: 'Disabled Successfully',
                                            type: 'purple',
                                            typeAnimated: true,
                                            buttons: {
                                                close: function () {

                                                }
                                            }
                                        });
                                    }
                                });
                            }
                        },
                        close: function () {
                            $('#' + id).prop('checked', true);
                        }
                    }
                });
            } else {
                $.confirm({
                    title: 'DISABLE PACK',
                    content: 'Can Not Be Disable Because Its Only One!!',
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                            $('#' + id).prop('checked', true);
                        }
                    }
                });
            }
        } else {
            $.confirm({
                title: 'ACTIVATE PACK',
                content: 'Are You Sure You Want To Activate?',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-purple',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {itemid: itemid, type: 'activate'},
                                url: "essentialmedicinesandsupplieslist/disableitempackagings.htm",
                                success: function (data) {
                                    $.confirm({
                                        title: 'ACTIVATED PACK',
                                        content: 'Activated Successfully',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {

                                            }
                                        }
                                    });
                                }
                            });
                        }
                    },
                    close: function () {
                        $('#' + id).prop('checked', false);
                    }
                }
            });
        }
    }
    function addnewItemStrength(medicalitemid) {
        $.ajax({
            type: 'GET',
            data: {medicalitemid: medicalitemid},
            url: "essentialmedicinesandsupplieslist/addnewItemStrength.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'ADD ITEM STREGTH',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '80%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Save',
                            btnClass: 'btn-purple',
                            action: function () {
                                var typesel = $('#AddItemtypesId').val();
                                if (typesel === 'yes') {
                                    if (itemSpecificationAdd.length > 0) {
                                        var itemid = $('#AddItemSpecificationId').val();
                                        $.ajax({
                                            type: 'POST',
                                            data: {values: JSON.stringify(itemSpecificationAdd), medicalitemid: itemid},
                                            url: "essentialmedicinesandsupplieslist/saveaddnewItemSpecification.htm",
                                            success: function (data, textStatus, jqXHR) {
                                                $.confirm({
                                                    title: 'ADD ITEM SPECIFICATION',
                                                    content: 'Saved Successfully',
                                                    type: 'purple',
                                                    typeAnimated: true,
                                                    buttons: {
                                                        close: function () {

                                                        }
                                                    }
                                                });
                                            }
                                        });
                                    }
                                } else {
                                    if (itemStregthAdd.length > 0) {
                                        var itemid = $('#AddStregthItemId').val();
                                        $.ajax({
                                            type: 'POST',
                                            data: {values: JSON.stringify(itemStregthAdd), medicalitemid: itemid},
                                            url: "essentialmedicinesandsupplieslist/saveaddnewItemStrength.htm",
                                            success: function (data, textStatus, jqXHR) {
                                                $.confirm({
                                                    title: 'ADD ITEM STRENGTH',
                                                    content: 'Saved Successfully',
                                                    type: 'purple',
                                                    typeAnimated: true,
                                                    buttons: {
                                                        close: function () {

                                                        }
                                                    }
                                                });
                                            }
                                        });
                                    }
                                }
                            }
                        },
                        close: function () {
                        }
                    }
                });
            }
        });
    }
</script>