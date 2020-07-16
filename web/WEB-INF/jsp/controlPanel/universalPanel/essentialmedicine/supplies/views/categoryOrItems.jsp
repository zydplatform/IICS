<%-- 
    Document   : categoryOrItems
    Created on : Jul 19, 2018, 12:19:49 PM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../../include.jsp" %>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-6">
        <button onclick="newSuppliesItems('${act}');" class="btn btn-primary pull-left" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Items</button>   
    </div>
    <div class="col-md-6">
        <button onclick="newSuppliesCatgoery('${act}');" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Category</button>  
    </div>
</div>
<table class="table table-hover table-bordered" id="SuppliesitemcategorydtailsTable">
    <c:if test="${act=='c'}">
        <thead>
            <tr>
                <th>No</th>
                <th>Item Name</th>
                <th>Specification</th>
                <th>Level</th>
                <th>Class</th>
                <th>Activation</th>
                <th>Description</th>
                <th>Update</th>
            </tr>
        </thead>
        <tbody>
            <% int k = 1;%>
            <% int p = 1;%>
            <c:forEach items="${categorysFound}" var="b">
                <tr <c:if test="${b.isspecial==true}">style="color:  green;" </c:if>>
                    <td><%=k++%></td>
                    <td>${b.genericname}</td>
                    <td>${b.specification}</td>
                    <td>${b.levelofuse}</td>
                    <td>${b.itemusage}</td>
                    <td align="center">
                        <div class="toggle-flip">
                            <label>
                                <input id="Suppactdeact<%=p++%>" type="checkbox"<c:if test="${b.isactive==true}">checked="checked"</c:if> onchange="if (this.checked) {
                                            activateSuppliesodiactivateItem('activate', ${b.itemid}, this.id);
                                        } else {
                                            activateSuppliesodiactivateItem('diactivate', ${b.itemid}, this.id);
                                        }"><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Active" data-toggle-off="Disabled"></span>
                            </label>
                        </div>
                    </td>
                    <td align="center"> <span  title="Item packages." onclick="viewSundriesadditemspacking(${b.itemid},${itemcategoryid});" class="badge badge-danger icon-custom">${b.itempackages}</span></td>
                    <td align="center">
                        <span  title="Edit Of This Item." onclick="updateSuppliesCatItemDetails(${b.itemid});" class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                        |
                        <span onclick="deleteSuppliesCategoryItem(${b.itemid});" title="Delete Of This Item."  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span>
                    </td>
                </tr>
            </c:forEach>

        </tbody>
    </c:if>
    <c:if test="${act !='c'}">
        <thead>
            <tr>
                <th>No</th>
                <th>Category</th>
                <th>Activation</th>
                <th>Update</th>
            </tr>
        </thead>
        <tbody>
            <% int i = 1;%>
            <% int de = 1;%>
            <c:forEach items="${categorysFound}" var="a">
                <tr>
                    <td><%=i++%></td>
                    <td>${a.categoryname}</td>
                    <td align="center">
                        <div class="toggle-flip">
                            <label>
                                <input id="Suppactdeactcat<%=de++%>" type="checkbox"<c:if test="${a.isactive==true}">checked="checked"</c:if> onchange="if (this.checked) {
                                            activateodiactivatecategory('activate', ${a.itemcategoryid}, this.id);
                                        } else {
                                            activateodiactivatecategory('diactivate', ${a.itemcategoryid}, this.id);
                                        }"><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Active" data-toggle-off="Disabled"></span>
                            </label>
                        </div>
                    </td>
                    <td align="center">
                        <span onclick="updateSuppliesCategoryDetails(${a.itemcategoryid}, '${a.categoryname}', '${a.categorydescription}');" title="Edit Of This Category."  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                        |
                        <span onclick="deleteSuppliesCategory(${a.itemcategoryid});" title="Delete Of This Category."  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span>
                    </td>
                </tr>
            </c:forEach>

        </tbody>
    </c:if>

</table> 

<script>
    $('#SuppliesitemcategorydtailsTable').DataTable();
    function newSuppliesCatgoery(act) {
        var classificationid = $('#SuppliesItemclassificationid').val();
        var classificationname = $('#SuppliesItemclassificationname').val();
        var Itemcategoryid = $('#SuppliesItemclassificationcategoryid').val();
        var categoryname = $('#SuppliesItemclassificationcategoryname').val();
        if (act === 'a') {
            $.confirm({
                title: 'Add Category!',
                type: 'purple',
                boxWidth: '30%',
                useBootstrap: false,
                typeAnimated: true,
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label>Classification</label>' +
                        '<input type="text" value="' + classificationname + '" disabled="true" class="form-control" required />' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label>Enter Category here</label>' +
                        '<input type="text" placeholder="Your Category" oninput="" class="Suppliescategorynname form-control" required />' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label>Enter Description here</label>' +
                        '<textarea class="Suppliescategorydesc form-control" rows="5"></textarea>' +
                        '</div>' +
                        '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-purple',
                        action: function () {
                            var categoryname = this.$content.find('.Suppliescategorynname').val();
                            var categorydesc = this.$content.find('.Suppliescategorydesc').val();
                            if (!categoryname) {
                                $.alert('provide a valid category Name');
                                return false;
                            }
                            if (!categorydesc) {
                                $.alert('provide a valid category Description');
                                return false;
                            }
                            $.ajax({
                                type: 'POST',
                                data: {categoryname: categoryname, categorydesc: categorydesc, classificationid: classificationid, type: 'category'},
                                url: "essentialmedicinesandsupplieslist/savenewsuppliesclassification.htm",
                                success: function (data, textStatus, jqXHR) {
                                    $.confirm({
                                        title: 'Add Category!',
                                        content: 'Do You Want To Add Another Category',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'Yes',
                                                btnClass: 'btn-red',
                                                action: function () {
                                                    newSuppliesCatgoery(act);
                                                }
                                            },
                                            close: function () {
                                                ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliesclassificationcategories.htm', 'SuppliescategoryItemsDivs', 'itemclassificationid=' + classificationid + '&act=' + act + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            }
                                        }
                                    });

                                }
                            });
                        }
                    },
                    cancel: function () {
                        //close
                    },
                }
            });

        } else {
            $.confirm({
                title: 'Add Category!',
                type: 'purple',
                boxWidth: '30%',
                useBootstrap: false,
                typeAnimated: true,
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label>Category</label>' +
                        '<input type="text" value="' + categoryname + '" disabled="true" class="form-control" required />' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label>Enter Category here</label>' +
                        '<input type="text" placeholder="Your Category" class="categorysubnname form-control" required />' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label>Enter Description here</label>' +
                        '<textarea class="categorysubdesc form-control" rows="5"></textarea>' +
                        '</div>' +
                        '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-purple',
                        action: function () {
                            var categoryname = this.$content.find('.categorysubnname').val();
                            var categorydesc = this.$content.find('.categorysubdesc').val();
                            if (!categoryname) {
                                $.alert('provide a valid category Name');
                                return false;
                            }
                            if (!categorydesc) {
                                $.alert('provide a valid category Description');
                                return false;
                            }
                            $.ajax({
                                type: 'POST',
                                data: {categoryname: categoryname, categorydesc: categorydesc, Itemcategoryid: Itemcategoryid, classificationid: classificationid, type: 'subcategory'},
                                url: "essentialmedicinesandsupplieslist/savenewitemclassification.htm",
                                success: function (data, textStatus, jqXHR) {
                                    $.confirm({
                                        title: 'Add Category!',
                                        content: 'Do You Want To Add Another SubCategory',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'Yes',
                                                btnClass: 'btn-purple',
                                                action: function () {
                                                    newSuppliesCatgoery(act);
                                                }
                                            },
                                            close: function () {
                                                ajaxSubmitData('essentialmedicinesandsupplieslist/getcategoriessubcategorylist.htm', 'categoryItemsDivs', 'itemcategoryid=' + Itemcategoryid + '&act=' + act + '&c=a&type=g&ofst=1&maxR=100&sStr=', 'GET');
                                            }
                                        }
                                    });

                                }
                            });
                        }
                    },
                    cancel: function () {
                        //close
                    },
                }
            });
        }
    }
    function newSuppliesItems() {
        var classificationname = $('#SuppliesItemclassificationname').val();
        var Itemcategoryid = $('#SuppliesItemclassificationcategoryid').val();
        var categoryname = $('#SuppliesItemclassificationcategoryname').val();
        $.ajax({
            type: 'GET',
            data: {type: 'page', categoryname: categoryname, classificationname: classificationname},
            url: "essentialmedicinesandsupplieslist/addnewsuppliesitemform.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'Add Item!',
                    type: 'purple',
                    boxWidth: '80%',
                    useBootstrap: false,
                    typeAnimated: true,
                    content: '' + data,
                    buttons: {
                        formSubmit: {
                            text: 'Finish',
                            btnClass: 'btn-purple',
                            action: function () {
                                ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliesclassificationcategories.htm', 'SuppliescategoryItemsDivs', 'itemcategoryid=' + Itemcategoryid + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        }
                    }
                });
            }
        });
    }
    function activateSuppliesodiactivateItem(type, value, id) {
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
    function activateodiactivatecategory(type, value, id) {
        if (type === 'activate') {
            $.confirm({
                title: 'Activate Category!',
                content: 'Are You Sure You Want To Activate Category?',
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
                                data: {itemcategoryid: value, type: 'activate'},
                                url: "essentialmedicinesandsupplieslist/activatedordeactivatedcategory.htm",
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
                title: 'De-Activate Category!',
                content: 'Are You Sure You Want To De-Activate Category?',
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
                                data: {itemcategoryid: value, type: 'deactivate'},
                                url: "essentialmedicinesandsupplieslist/activatedordeactivatedcategory.htm",
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
    function updateSuppliesCatItemDetails(itemid) {
        var Itemcategoryid = $('#SuppliesItemclassificationcategoryid').val();
        $.ajax({
            type: 'GET',
            data: {itemid: itemid},
            url: "essentialmedicinesandsupplieslist/editsuppliesclassificationcategoryitem.htm",
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
                                var itemname = $('#updateSuppliesItemName').val();
                                var specification = $('#updateSuppliesItemspecification').val();
                                var useclass = $('#updateSuppliesItemClass').val();
                                var level = $('#updateSuppliesItemlevel').val();
                                var isspecial = $('input[name=updateSuppliesInlineRadioSpecial]:checked').val();
                                if (!itemname || !specification) {
                                    $.alert('provide a valid Item Details');
                                    return false;
                                }
                                $.ajax({
                                    type: 'POST',
                                    data: {itemname: itemname, specification: specification, useclass: useclass, level: level, itemid: itemid, isspecial: isspecial},
                                    url: "essentialmedicinesandsupplieslist/updatesuppliescategoryitem.htm",
                                    success: function (data, textStatus, jqXHR) {
                                        ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliesclassificationcategories.htm', 'SuppliescategoryItemsDivs', 'itemcategoryid=' + Itemcategoryid + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
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
    function deleteSuppliesCategoryItem(itemid) {
        var Itemcategoryid = $('#SuppliesItemclassificationcategoryid').val();
        $.confirm({
            title: 'Delete Item!',
            content: 'Are You Sure You Want To Delete This Item?',
            type: 'red',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes,Delete',
                    btnClass: 'btn-red',
                    action: function () {
//                        document.getElementById('overlaydelete').style.display = 'block';
                        $.ajax({
                            type: 'POST',
                            data: {itemid: itemid},
                            url: "essentialmedicinesandsupplieslist/deletecategoryitem.htm",
                            success: function (data, textStatus, jqXHR) {
//                                document.getElementById('overlaydelete').style.display = 'none';
                                if (data === 'deleted') {
                                    ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliesclassificationcategories.htm', 'SuppliescategoryItemsDivs', 'itemcategoryid=' + Itemcategoryid + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                                } else {
                                    $.confirm({
                                        title: 'Delete Item!',
                                        icon: 'fa fa-warning',
                                        content: 'CanNot Delete Item Because Of Attachments!!!',
                                        type: 'red',
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
//                    document.getElementById('overlaydelete').style.display = 'none';
                }
            }
        });
    }
    function updateSuppliesCategoryDetails(itemcategoryid, categoryname, categorydescription) {
        var ParentItemcategoryid = $('#SuppliesItemclassificationcategoryid').val();
        $.confirm({
            title: 'Update Category!',
            typeAnimated: true,
            type: 'purple',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Category Name</label>' +
                    '<input type="text" value="' + categoryname + '" class="SuppliesCategoryUpdatename form-control" required  />' +
                    '</div>' +
                    '<label>Category Description</label>' +
                    '<textarea class="SupppliescategorydescriptionUpdate form-control" rows="5">' + categorydescription + '</textarea>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var name = this.$content.find('.SuppliesCategoryUpdatename').val();
                        var description = this.$content.find('.SupppliescategorydescriptionUpdate').val();
                        if (!name) {
                            $.alert('provide a valid name');
                            return false;
                        }
                        if (!description) {
                            $.alert('provide a valid Description');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {itemcategoryid: itemcategoryid, categoryname: name, categorydescription: description},
                            url: "essentialmedicinesandsupplieslist/updatecategory.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (ParentItemcategoryid === '') {
                                    var classificationid = $('#SuppliesItemclassificationid').val();
                                    ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliesclassificationcategories.htm', 'SuppliescategoryItemsDivs', 'itemclassificationid=' + classificationid + '&act=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                } else {
                                    ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliescategoriessubcategorylist.htm', 'SuppliescategoryItemsDivs', 'itemcategoryid=' + ParentItemcategoryid + '&act=b&type=categoery&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                },
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    function deleteSuppliesCategory(itemcategoryid) {
        var parentItemcategoryid = $('#SuppliesItemclassificationcategoryid').val();
        $.ajax({
            type: 'POST',
            data: {itemcategoryid: itemcategoryid, parentItemcategoryid: parentItemcategoryid},
            url: "essentialmedicinesandsupplieslist/deletingclassificationcategory.htm",
            success: function (data, textStatus, jqXHR) {
                if (data === 'failed') {
                    $.confirm({
                        title: 'Delete Category!',
                        content: 'Can Not Delete Because Of Attachments!!',
                        type: 'purple',
                        typeAnimated: true,
                        buttons: {
                            close: function () {
                            }
                        }
                    });
                } else {
                    if (data === 'hassubcomponents') {
                        ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliescategoriessubcategorylist.htm', 'SuppliescategoryItemsDivs', 'itemcategoryid=' + parentItemcategoryid + '&act=b&type=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    } else {
                        ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliescategoriessubcategorylist.htm', 'SuppliescategoryItemsDivs', 'itemcategoryid=' + parentItemcategoryid + '&act=b&type=items&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }

                }
            }
        });
    }
    function viewSundriesadditemspacking(itemid, itemcategoryid) {
        $.ajax({
            type: 'GET',
            data: {itemid: itemid},
            url: "essentialmedicinesandsupplieslist/itemsundriespackages.htm",
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
                            ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliesclassificationcategories.htm', 'SuppliescategoryItemsDivs', 'itemcategoryid=' + itemcategoryid + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    }
                });
            }
        });
    }
</script>