<%-- 
    Document   : itemPacks
    Created on : Sep 18, 2018, 2:53:16 PM
    Author     : HP
--%>
<%@include file="../../../include.jsp" %>
<div id="addItmsPackingDiv"> 
    <div style="margin: 10px;">
        <div class="row">
            <div class="col-md-12">
                <button onclick="addnewItemPackDescription();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Descriptions</button>
            </div>
        </div>
        <fieldset style="min-height:100px;">
            <table class="table table-hover table-bordered" id="ItemPackDescriptionTable">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Item Description</th>
                        <th>Update</th>
                    </tr>
                </thead>
                <tbody >
                    <% int k = 1;%>
                    <% int p = 1;%>
                    <c:forEach items="${packsFound}" var="b">
                        <tr>
                            <td><%=k++%></td>
                            <td>${b.packagename}</td>
                            <td align="center">
                                <span  title="Edit Of This Description." onclick="editItemDescription(${b.packagesid}, '${b.packagename}');"  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                                |
                                <span  title="Delete Of This Description." onclick="deleteItemDescription(${b.packagesid});"  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table> 
        </fieldset>
    </div>  
</div>
<script>
    $('#ItemPackDescriptionTable').DataTable();
    function editItemDescription(packagesid, packagename) {
        $.confirm({
            title: 'UPDATE ITEM DESCRIPTION',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Description Name</label>' +
                    '<input type="text" value="' + packagename + '"  class="descripname form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var name = this.$content.find('.descripname').val();
                        if (!name) {
                            $.alert('provide a valid Description Name');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {packagesid: packagesid, name: name, type: 'update'},
                            url: "essentialmedicinesandsupplieslist/updateitemdescriptions.htm",
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('essentialmedicinesandsupplieslist/getitemsdescriptionspacks.htm', 'addItmsPackingDiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });

                    }
                },
                close: function () {

                }
            }
        });
    }
    function deleteItemDescription(packagesid) {
        $.ajax({
            type: 'POST',
            data: {packagesid: packagesid, type: 'delete'},
            url: "essentialmedicinesandsupplieslist/updateitemdescriptions.htm",
            success: function (data, textStatus, jqXHR) {
                if (data === 'comps') {
                    $.confirm({
                        title: 'DELETE DESCRIPTION',
                        content: 'Can Not Be Delete Because Of Attachments!!!',
                        type: 'red',
                        typeAnimated: true,
                        buttons: {
                            close: function () {

                            }
                        }
                    });
                } else if (data === 'deleted') {
                    ajaxSubmitData('essentialmedicinesandsupplieslist/getitemsdescriptionspacks.htm', 'addItmsPackingDiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            }
        });
    }
    function addnewItemPackDescription() {
        $.ajax({
            type: 'GET',
            data: {},
            url: "essentialmedicinesandsupplieslist/addnewitemdescrips.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'ADD DESCRIPTIONS',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '70%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Save',
                            btnClass: 'btn-purple',
                            action: function () {
                                if (ItemDescrips.size > 0) {
                                    $.ajax({
                                        type: 'POST',
                                        data: {values:JSON.stringify(Array.from(ItemDescrips))},
                                        url: "essentialmedicinesandsupplieslist/savenewitemdescriptions.htm",
                                        success: function (response) {
                                            ajaxSubmitData('essentialmedicinesandsupplieslist/getitemsdescriptionspacks.htm', 'addItmsPackingDiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                        }
                                    });
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