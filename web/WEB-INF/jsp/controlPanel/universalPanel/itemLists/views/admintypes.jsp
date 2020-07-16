<%-- 
    Document   : categoryTable
    Created on : Mar 23, 2018, 10:57:19 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <br>
        <a class="btn btn-primary icon-btn pull-right" id="addnewadmintype" href="#">
            <i class="fa fa-plus"></i>
            Add Administration Route
        </a>
    </div>
</div>
<fieldset>
    <table class="table table-hover table-bordered" id="admintypeTable">
        <thead>
            <tr>
                <th>No</th>
                <th>Item Administration Route</th>
                <th class="center">Update</th>
            </tr>
        </thead>
        <tbody id="bodyadmintypes">
            <% int j = 1;%>
            <c:forEach items="${types}" var="admintypes">
                <tr>
                    <td><%=j++%></td>
                    <td id="adminType${admintypes.id}">${admintypes.name}</td>
                    <td class="center">
                        <a href="#!" id="editAdminType${admintypes.id}" onclick="editAdminType(${admintypes.id}, '${admintypes.name}')">
                            <i class="fa fa-fw fa-lg fa-edit"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</fieldset>
<div class="modal fade" id="addadmintype" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
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
                                            <label for="itemclass">Item Administration Route</label>
                                            <input class="form-control" id="itemadmintype" type="text"  placeholder="Item Classification">
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="tile-footer">
                                <button class="btn btn-primary" id="savetype" type="submit">
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
        $('#admintypeTable').DataTable();
        $('#addnewadmintype').click(function () {
            $('#addadmintype').modal('show');
        });

        $('#savetype').click(function () {
            var itemAdminType = $('#itemadmintype').val();
            if (itemAdminType.length > 0) {
                $('#itemadmintype').css('border', '2px solid #7c047d');
                $.ajax({
                    dataType: 'JSON',
                    type: 'POST',
                    data: {name: itemAdminType},
                    url: 'store/saveitemadmintype.htm',
                    success: function (data) {
                        if (!(data === '')) {
                            $('.pagination li:nth-last-child(2)').click();
                            $('#bodyadmintypes').append(
                                    '<tr><td><%=j++%></td>' +
                                    '<td>' + itemAdminType + '</td>' +
                                    '</td><td class="center"><a href="#">' +
                                    '<i class="fa fa-fw fa-lg fa-edit"></i></a></td></tr>'
                                    );
                            $('#addadmintype').modal('hide');
                            $('.odd').hide();
                            $('.even').hide();
                        }
                    }
                });
            } else {
                $('#itemadmintype').focus();
                $('#itemadmintype').css('border', '2px solid #f50808c4');
            }
        });
    });

    function editAdminType(id, adminType) {
        $.confirm({
            title: 'Update Drug Administration Type!',
            content: '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Administration Type Name</label>' +
                    '<input type="text" id="typeName" value="' + adminType + '" placeholder="Administration Type Name" class="form-control"/>' +
                    '</div>' +
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
                        var typeName = this.$content.find('#typeName').val();
                        if (typeName.length > 0) {
                            $.ajax({
                                type: 'POST',
                                data: {id: id, name: typeName},
                                url: 'store/updateAdminTypeName.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#adminType' + id).html(typeName);
                                        $('#editAdminType' + id).attr('onclick', 'editAdminType(' + id + ', \'' + typeName + '\')');
                                        $.toast({
                                            heading: 'Info',
                                            text: 'Drug Administration Type Updated.',
                                            icon: 'info',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Update Drug Administration Type',
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
                                text: 'Failed to Update Drug Administration Type',
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