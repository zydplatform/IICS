<%-- 
    Document   : categoryTable
    Created on : Mar 23, 2018, 10:57:19 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <br>
        <a class="btn btn-primary icon-btn pull-right" id="addnewform" href="#">
            <i class="fa fa-plus"></i>
            Add Item Form
        </a>
    </div>
</div>
<fieldset>
    <table class="table table-hover table-bordered" id="dosageTable">
        <thead>
            <tr>
                <th>No</th>
                <th>Item Form</th>
                <th class="center">Details</th>
                <th class="center">Update</th>
            </tr>
        </thead>
        <tbody id="bodyForm">
            <% int c = 1;%>
            <c:forEach items="${forms}" var="form">
                <tr>
                    <td><%=c++%></td>
                    <td id="dosageName${form.id}">${form.name}</td>
                    <td class="center">
                        <a id="" data-container="body" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="${form.desc}" data-original-title="Description" href="#!">
                            <i class="fa fa-fw fa-lg fa-dedent"></i>
                        </a>
                    </td>
                    <td class="center">
                        <a href="#!" id="editDosage${form.id}" onclick="editDosageForm(${form.id}, '${form.name}', '${form.desc}')">
                            <i class="fa fa-fw fa-lg fa-edit"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</fieldset>
<div class="modal fade" id="addform" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="title">Add New Item Form</h5>
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
                                            <label for="itemclass">Item Form</label>
                                            <input class="form-control" id="itemform" type="text"  placeholder="Item Classification">
                                        </div>
                                        <div class="form-group">
                                            <label for="catDesc">Description</label>
                                            <textarea class="form-control" id="formDesc" rows="10"></textarea>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="tile-footer">
                                <button class="btn btn-primary" id="saveform" type="submit">
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
        $('#dosageTable').DataTable();
        $('#addnewform').click(function () {
            $('#addform').modal('show');
        });

        $('#saveform').click(function () {
            var itemform = $('#itemform').val();
            var desc = $('#formDescDesc').val();
            if (itemform.length > 0) {
                $('#itemform').css('border', '2px solid #7c047d');
                $.ajax({
                    dataType: 'JSON',
                    type: 'POST',
                    data: {name: itemform, desc: desc},
                    url: 'store/saveitemform.htm',
                    success: function (data) {
                        if (!(data === '')) {
                            $('.pagination li:nth-last-child(2)').click();
                            $('#bodyForm').append(
                                    '<tr><td><%=c++%></td>' +
                                    '<td>' + itemform + '</td>' +
                                    '</td><td class="center"><a href="#">' +
                                    '<i class="fa fa-fw fa-lg fa-dedent"></i></a></td>' +
                                    '<td class="center"><a href="#">' +
                                    '<i class="fa fa-fw fa-lg fa-edit"></i></a></td></tr>'
                                    );
                            $('#addform').modal('hide');
                            $('.odd').hide();
                            $('.even').hide();
                        }
                    }
                });
            } else {
                $('#itemform').focus();
                $('#itemform').css('border', '2px solid #f50808c4');
            }
        });
    });

    function editDosageForm(id, formName, description) {
        $.confirm({
            title: 'Update Dosage Form!',
            content: '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Form Name</label>' +
                    '<input type="text" id="formName" value="' + formName + '" placeholder="Classification Name" class="form-control"/></div>' +
                    '<div class="form-group">' +
                    '<label for="catDesc">Description</label>' +
                    '<textarea class="form-control" id="formDesc" rows="6">' + description + '</textarea></div>' +
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
                        var desc = this.$content.find('#formDesc').val();
                        var className = this.$content.find('#formName').val();
                        if (className.length > 0) {
                            $.ajax({
                                type: 'POST',
                                data: {id: id, name: className, desc: desc},
                                url: 'store/updateDosageForm.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#dosageName' + id).html(className);
                                        $('#editDosage' + id).attr('onclick', 'editDosageForm(' + id + ', \'' + className + '\', \'' + desc + '\')');
                                        $.toast({
                                            heading: 'Info',
                                            text: 'Dosage Form Updated.',
                                            icon: 'info',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Update Dosage Form',
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
                                text: 'Failed to Update Dosage Form',
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