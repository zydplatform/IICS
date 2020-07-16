<%-- 
    Document   : categoryTable
    Created on : Mar 23, 2018, 10:57:19 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<table class="table table-hover table-bordered" id="categoriesTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Category</th>
            <th class="center">Activation</th>
            <th class="center">Details</th>
            <th class="center">Update</th>
        </tr>
    </thead>
    <tbody id="bodyCategories">
        <% int x = 1;%>
        <c:forEach items="${categories}" var="category">
            <tr>
                <td><%=x++%></td>
                <td id="catName${category.id}">${category.name}</td>
                <td class="center" id="cat${category.id}content">
                    <label class="switch">
                        <input id="cat${category.id}" type="checkbox" ${category.status}>
                        <span onclick="categoryStatus(${category.id}, '${category.name}', '${category.status}')" class="slider round"></span>
                    </label>
                </td>
                <td class="center">
                    <a data-container="body" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="${category.desc}" data-original-title="Description" href="#!">
                        <i class="fa fa-fw fa-lg fa-dedent"></i>
                    </a>
                </td>
                <td class="center">
                    <a href="#!" id="editCat${category.id}" onclick="editCategory(${category.id}, '${category.name}', '${category.desc}')">
                        <i class="fa fa-fw fa-lg fa-edit"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<div class="modal fade" id="addCategory" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="title"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="row">
                                <div class="col-md-12">
                                    <form>
                                        <div class="form-group">
                                            <label for="itemclass">Category Name</label>
                                            <input class="form-control" id="itemCat" type="text"  placeholder="Item Classification">
                                        </div>
                                        <div class="form-group">
                                            <label for="catDesc">Description</label>
                                            <textarea class="form-control" id="desc" rows="10"></textarea>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="tile-footer">
                                <button class="btn btn-primary" id="saveCategory" type="submit">
                                    <i class="fa fa-check-circle"></i>
                                    Save
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('[data-toggle="popover"]').popover();
        $('#categoriesTable').DataTable();
        $('#addnewcat').click(function () {
            $('#addCategory').modal('show');
            var classid = parseInt($('#selectClassification').val());
            var className = $('#class' + classid).data('name');
            $('#title').html(className);
            console.log(className);
        });

        $('#saveCategory').click(function () {
            var itemCat = $('#itemCat').val();
            var desc = $('#CatDesc').val();
            var classid = parseInt($('#selectClassification').val());
            if (itemCat.length > 0) {
                $.ajax({
                    dataType: 'JSON',
                    type: 'POST',
                    data: {classid: classid, name: itemCat, desc: desc},
                    url: 'store/saveClassificationCategory.htm',
                    success: function (data) {
                        if (!(data === '')) {
                            $('.pagination li:nth-last-child(2)').click();
                            $('#bodyCategories').append(
                                    '<tr><td><%=x++%></td>' +
                                    '<td>' + itemCat + '</td>' +
                                    '<td class="center"><label class="switch">' +
                                    '<input type="checkbox" checked><span class="slider round"></span>' +
                                    '</label></td><td class="center"><a href="#">' +
                                    '<i class="fa fa-fw fa-lg fa-dedent"></i></a></td>' +
                                    '<td class="center"><a href="#">' +
                                    '<i class="fa fa-fw fa-lg fa-edit"></i></a></td></tr>'
                                    );
                            $('#addCategory').modal('hide');
                            $('.odd').hide();
                            $('.even').hide();
                        }
                    }
                });
            } else {
                $('#itemCat').focus();
                $('#itemCat').css('border', '2px solid #f50808c4');
            }
        });
    });

    function categoryStatus(id, categoryName, status) {
        if (status.length < 1) {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Activate Category',
                content: '<strong>' + categoryName + '</strong>',
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
                                url: 'store/activateCategory.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#cat' + id + 'content').html('<label class="switch"><input id="cat' + id + '" type="checkbox" checked><span onclick="categoryStatus(' + id + ', \'' + categoryName + '\', \'checked\')" class="slider round"></span></label>');
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Category Activated',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Activate Category',
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
                            $('#cat' + id).click();
                        }
                    }
                }
            });
        } else {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Deactivate Category',
                content: '<strong>' + categoryName + '</strong>',
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
                                url: 'store/activateCategory.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#cat' + id + 'content').html('<label class="switch"><input id="cat' + id + '" type="checkbox"><span onclick="categoryStatus(' + id + ', \'' + categoryName + '\', \'\')" class="slider round"></span></label>');
                                        $.toast({
                                            heading: 'Info',
                                            text: 'Category Dectivated',
                                            icon: 'info',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Deactivate Category',
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
                            $('#cat' + id).click();
                        }
                    }
                }
            });
        }
    }

    function editCategory(id, categoryName, description) {
        $.confirm({
            title: 'Update Category Details!',
            content: '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Category Name</label>' +
                    '<input type="text" id="catName" value="' + categoryName + '" placeholder="Classification Name" class="form-control"/></div>' +
                    '<div class="form-group">' +
                    '<label for="catDesc">Description</label>' +
                    '<textarea class="form-control" id="catDesc" rows="6">' + description + '</textarea></div>' +
                    '</form>',
            boxWidth: '40%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                formSubmit: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var desc = this.$content.find('#catDesc').val();
                        var className = this.$content.find('#catName').val();
                        if (className.length > 0) {
                            $.ajax({
                                type: 'POST',
                                data: {id: id, name: className, desc: desc},
                                url: 'store/updateCategory.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#catName' + id).html(className);
                                        $('#editCat' + id).attr('onclick', 'editCategory(' + id + ', \'' + className + '\', \'' + desc + '\')');
                                        $.toast({
                                            heading: 'Info',
                                            text: 'Category Updated.',
                                            icon: 'info',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Update Category',
                                            icon: 'warning',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    }
                                }
                            });
                        } else {
                            $.toast({
                                heading: 'Warning',
                                text: 'Failed to Update Category',
                                icon: 'warning',
                                hideAfter: 2000,
                                position: 'mid-center'
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
            }
        });
    }
</script>