<%-- 
    Document   : deletedItemsHome
    Created on : Aug 23, 2018, 12:52:44 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-12">
                <button onclick="addNewdeletedItems();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add New Item</button>
            </div>
        </div><br>
        <table class="table table-hover table-bordered" id="deletedItemsTable">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Item Name</th>
                    <th>Deleted</th>
                    <th>Update</th>
                </tr>
            </thead>
            <tbody >
                <% int j = 1;%>
                <% int p = 1;%>
                <% int k = 1;%>
                <c:forEach items="${itemsFound}" var="a">
                    <tr>
                        <td><%=j++%></td>
                        <td>${a.fullname}</td>
                        <td align="center"><div class="toggle-flip">
                                <label>
                                    <input id="<%=k++%>deletedItm" type="checkbox"checked="checked"onchange="if (this.checked) {
                                                activateDeletedEssentialItems(${a.itemid}, 'unchecked', this.id, '${a.fullname}');
                                            } else {
                                                activateDeletedEssentialItems(${a.itemid}, 'checked', this.id, '${a.fullname}');
                                            }"><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                                </label>
                            </div></td>
                        <td align="center">
                            <a href="#!" title="delete" onclick="" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                            |
                            <a href="#!" title="delete" onclick="deletedEssentialDeletedMedicinesListItems(${a.itemid});" ><i class="fa fa-fw fa-lg fa-remove"></i></a>
                        </td>                                                  
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </fieldset>
</div>
<script>
    $('#deletedItemsTable').DataTable();
    function addNewdeletedItems() {
        $.ajax({
            type: 'GET',
            data: {data: 'data'},
            url: "essentialmedicinesandsupplieslist/addnewdeleteditems.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'ADD ITEMS',
                    content: '' + data,
                    closeIcon: true,
                    type: 'purple',
                    typeAnimated: true,
                    boxWidth: '70%',
                    useBootstrap: false,
                    buttons: {
                        tryAgain: {
                            text: 'Finish',
                            btnClass: 'btn-purple',
                            action: function () {
                                ajaxSubmitData('essentialmedicinesandsupplieslist/deletedessentiallistmedicines.htm', 'deletedItemsDiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        }
                    }
                });
            }
        });
    }
    function deletedEssentialDeletedMedicinesListItems(itemid) {
        $.confirm({
            title: 'Delete Item',
            content: 'Are You Sure You Want To Delete Item?',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {itemid: itemid},
                            url: "essentialmedicinesandsupplieslist/deletedEssentialDeletedMedicinesListItems.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'deleted') {
                                    ajaxSubmitData('essentialmedicinesandsupplieslist/deletedessentiallistmedicines.htm', 'deletedItemsDiv', 'deleted=deleted&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                } else {
                                    $.confirm({
                                        title: 'Encountered an error!',
                                        content: 'Something went Wrong While Trying To Delete Item',
                                        type: 'red',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'Try again',
                                                btnClass: 'btn-red',
                                                action: function () {
                                                    deletedEssentialDeletedMedicinesListItems(itemid);
                                                }
                                            },
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
    function activateDeletedEssentialItems(itemid, type, id, itemname) {
        if (type === 'checked') {
            $.confirm({
                title: 'Activate Item',
                content: 'Are You Sure You Want To Activate ' + itemname + ' ' + '?',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-purple',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {itemid:itemid},
                                url: "essentialmedicinesandsupplieslist/activateDeletedEssentialItems.htm",
                                success: function (data) {
                                    if(data==='success'){
                                     ajaxSubmitData('essentialmedicinesandsupplieslist/deletedessentiallistmedicines.htm', 'deletedItemsDiv', 'deleted=deleted&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');    
                                    }else{
                                       $.confirm({
                                        title: 'Encountered an error!',
                                        content: 'Something went Wrong While Trying To Activate Item',
                                        type: 'red',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'Try again',
                                                btnClass: 'btn-red',
                                                action: function () {
                                                    activateDeletedEssentialItems(itemid, type, id, itemname);
                                                }
                                            },
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
                        $('#' + id).prop('checked', true);
                    }
                }
            });
        }
    }
</script>