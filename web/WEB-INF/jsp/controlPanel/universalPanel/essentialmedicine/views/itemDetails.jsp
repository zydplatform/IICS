<%-- 
    Document   : itemDetails
    Created on : Jul 6, 2018, 1:07:17 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">
    <div class="col-md-4"></div>
    <div class="col-md-4">
        <span><b>Item Name:</b></span> <h5 style="" id="displaythenavigationspanItem"><span class="badge badge-secondary"><strong id="dispthenavigationspanItem">${name}</strong></span></h5> 
    </div>
    <div class="col-md-4"></div>
</div>
<table class="table table-hover table-bordered" id="searcheditemcategorydtailsTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Dosage Form</th>
            <th>Strength</th>
            <th>Level</th>
            <th>Class</th>
            <th>Activation</th>
            <th>Description</th>
            <th>Update</th>
        </tr>
    </thead>
    <tbody id="searchitemcategorydtailTb">
        <% int k = 1;%>
        <% int p = 1;%>
        <c:forEach items="${itemsFound}" var="b">
            <tr <c:if test="${b.isspecial==true}">style="color:  green;" </c:if>>
                <td><%=k++%></td>
                <td>${b.dosageform}</td>
                <td>${b.itemstrength}</td>
                <td>${b.levelofuse}</td>
                <td>${b.itemusage}</td>
                <td align="center">
                    <div class="toggle-flip">
                        <label>
                            <input id="actdeactItm<%=p++%>" type="checkbox"<c:if test="${b.isactive==true}">checked="checked"</c:if> onchange="if (this.checked) {
                                        activateodiactivatItMs('activate', ${itemid}, this.id);
                                    } else {
                                        activateodiactivatItMs('diactivate', ${itemid}, this.id);
                                    }"><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Active" data-toggle-off="Disabled"></span>
                        </label>
                    </div>
                </td>
                <td align="center"> <span  title="Item packages." onclick="viewadditemspacking(${itemid});" class="badge badge-danger icon-custom">${b.itempackages}</span></td>
                <td align="center">
                    <span  title="Edit Of This Item." onclick="editSearchedItemDetails(${itemid});"  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                    |
                    <span  title="Delete Of This Item." onclick="deleteSearchedItemDetails(${itemid});"  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span>
                </td>
            </tr>
        </c:forEach>

    </tbody>
</table> 
<script>
    $('#searcheditemcategorydtailsTable').DataTable();
    document.getElementById('displaythenavigationspanCat').style.display = 'none';
    document.getElementById('spanCategoryHeading').style.display = 'none';

    document.getElementById('spanClassificationHeading').style.display = 'none';
    document.getElementById('displaythenavigationspan').style.display = 'none';
    function activateodiactivatItMs(type, value, id) {
        if (type === 'activate') {
            $.confirm({
                title: 'Activate Item!',
                content: 'Are You Sure You Want To Activate This Item?',
                type: 'red',
                icon: 'fa fa-warning',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {itemid: value, type: 'activate'},
                                url: "essentialmedicinesandsupplieslist/activateordeactivateitemorcategory.htm",
                                success: function (data, textStatus, jqXHR) {

                                }
                            });
                        }
                    },
                    close: function () {
                        $('#' + id).prop('checked', false);
                    }
                }
            });
        } else {
            $.confirm({
                title: 'De-Activate Item!',
                content: 'Are You Sure You Want To De-Activate This Item?',
                type: 'red',
                icon: 'fa fa-warning',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {itemid: value, type: 'deactivate'},
                                url: "essentialmedicinesandsupplieslist/activateordeactivateitemorcategory.htm",
                                success: function (data, textStatus, jqXHR) {

                                }
                            });
                        }
                    },
                    close: function () {
                        $('#' + id).prop('checked', true);
                    }
                }
            });
        }
    }
    function editSearchedItemDetails(itemid) {
        $.ajax({
            type: 'GET',
            data: {itemid: itemid},
            url: "essentialmedicinesandsupplieslist/editclassificationcategoryitem.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'Update Item!',
                    content: '' + data,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Update',
                            btnClass: 'btn-purple',
                            action: function () {
                                var itemname = $('#updateItemName').val();
                                var dosageform = $('#updateItemForm').val();
                                var useclass = $('#updateItemClass').val();
                                var level = $('#updateItemlevel').val();
                                var strength = $('#updateItemstrength').val();
                                var isspecial = $('input[name=updateInlineRadioSpecial]:checked').val();
                                if (!itemname || !dosageform || !useclass || !strength) {
                                    $.alert('provide a valid Item Details');
                                    return false;
                                }
                                $.ajax({
                                    type: 'POST',
                                    data: {itemname: itemname, dosageform: dosageform, useclass: useclass, level: level, strength: strength, isspecial: isspecial, itemid: itemid},
                                    url: "essentialmedicinesandsupplieslist/updatecategoryitem.htm",
                                    success: function (data, textStatus, jqXHR) {
                                        ajaxSubmitData('essentialmedicinesandsupplieslist/getitemtreeclassification.htm', 'categoryItemsDivs', 'act=b&itemid=' + itemid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
    function deleteSearchedItemDetails(itemid) {
        $.confirm({
            title: 'Delete Item!',
            content: 'Are You Sure You Want To Delete This Item?',
            type: 'purple',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes,Delete',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {itemid: itemid},
                            url: "essentialmedicinesandsupplieslist/deletecategoryitem.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'deleted') {
                                    $.confirm({
                                        title: 'Item Deleted!',
                                        content: 'Item Deleted Successfully !!!',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                document.getElementById('dispthenavigationspanItem').innerHTML = 'Item Deleted';
                                                document.getElementById('searchitemcategorydtailTb').innerHTML = '';
                                            }
                                        }
                                    });
                                } else {
                                    $.confirm({
                                        title: 'Item Deletion!',
                                        content: 'Can Not Delete Because Of Attachments?',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                            }
                                        }
                                    });
                                }
                            }
                        });
                    }
                },
                close: function () {

                }
            }
        });
    }
    function viewadditemspacking(itemid) {
        $.ajax({
            type: 'GET',
            data: {itemid: itemid},
            url: "essentialmedicinesandsupplieslist/itempackages.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'Item Description',
                    content: '' + data,
                    boxWidth: '50%',
                    closeIcon: true,
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                            ajaxSubmitData('essentialmedicinesandsupplieslist/getitemtreeclassification.htm', 'categoryItemsDivs', 'act=b&itemid=' + itemid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    }
                });
            }
        });
    }
</script>