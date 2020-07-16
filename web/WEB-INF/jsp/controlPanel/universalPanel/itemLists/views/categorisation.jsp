<%-- 
    Document   : categorisation
    Created on : Mar 21, 2018, 11:13:11 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-11 col-sm-11 right">
        <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
            <div class="btn-group" role="group">
                <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-sliders" aria-hidden="true"></i>
                </button>
                <div class="dropdown-menu dropdown-menu-left">
                    <a class="dropdown-item" href="#" id="claseSwitch">Item Classifications</a><hr>
                    <a class="dropdown-item" href="#" id="catSwitch">Item Categories</a>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="clase">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <p>
                    <a class="btn btn-primary icon-btn" id="addnewclass" href="#">
                        <i class="fa fa-plus"></i>
                        Add Classification
                    </a>
                </p>
                <fieldset>
                    <table class="table table-hover table-bordered" id="classificationTable">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Name</th>
                                <th class="center">Activation</th>
                                <th class="center">Details</th>
                                <th class="center">Update</th>
                            </tr>
                        </thead>
                        <tbody id="bodyClassifications">
                            <% int i = 1;%>
                            <c:forEach items="${classifications}" var="classification">
                                <tr>
                                    <td><%=i++%></td>
                                    <td id="classname${classification.id}">${classification.name}</td>
                                    <td class="center" id="switch${classification.id}content">
                                        <label class="switch">
                                            <input id="class${classification.id}" type="checkbox" ${classification.status}>
                                            <span onclick="classificationStatus(${classification.id}, '${classification.name}', '${classification.status}')" class="slider round"></span>
                                        </label>
                                    </td>
                                    <td class="center" id="classpop${classification.id}">
                                        <a data-container="body" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="${classification.desc}" data-original-title="Description" href="#!">
                                            <i class="fa fa-fw fa-lg fa-dedent"></i>
                                        </a>
                                    </td>
                                    <td class="center">
                                        <a href="#!" id="editClass${classification.id}" onclick="editClassification(${classification.id}, '${classification.name}', '${classification.desc}')" class="edit-classification">
                                            <i class="fa fa-fw fa-lg fa-edit"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </fieldset>
            </div>
        </div>
    </div>
</div>
<div id="cats">
    <div class="row">
        <div class="col-md-8"></div>
        <div class="col-md-4">
            <select class="form-control" id="selectClassification">
                <c:if test="${not empty classifications}">
                    <c:forEach items="${classifications}" var="classification">
                        <option id="class${classification.id}" data-name="${classification.name}" value="${classification.id}">${classification.name}</option>
                    </c:forEach>
                </c:if>
                <c:if test="${empty classifications}">
                    <option value="0">No Classifications Set</option>
                </c:if>
            </select>
        </div>
    </div>
    <p>
        <a class="btn btn-primary icon-btn" id="addnewcat" href="#">
            <i class="fa fa-plus"></i>
            Add Category
        </a>
    </p>
    <fieldset id="catTableDiv">

    </fieldset>
</div>
<div class="modal fade" id="addclassification" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Add Classification</h5>
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
                                            <label for="itemclass">Classification</label>
                                            <input class="form-control" id="itemclass" type="text"  placeholder="Item Classification">
                                        </div>
                                        <div class="form-group">
                                            <label for="desc">Description</label>
                                            <textarea class="form-control" id="desc" rows="10"></textarea>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="tile-footer">
                                <button class="btn btn-primary" id="saveclassification" type="submit">
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
<script type="text/javascript">
    $(document).ready(function () {
        $('#cats').hide();
        $('#claseSwitch').click(function () {
            $('#clase').show();
            $('#cats').hide();
        });
        $('#catSwitch').click(function () {
            $('#cats').show();
            $('#clase').hide();
        });
        $('[data-toggle="popover"]').popover();
        $('#classificationTable').DataTable();
        $('#addnewclass').click(function () {
            $('#addclassification').modal('show');
        });
        $('#cancel').click(function () {
            $('#addclassification').modal('hide');
        });

        $('#saveclassification').click(function () {
            var itemClass = $('#itemclass').val();
            var desc = $('#desc').val();

            if (itemClass.length > 0) {
                $.ajax({
                    dataType: 'JSON',
                    type: 'POST',
                    data: {name: itemClass, desc: desc},
                    url: 'store/saveclassification.htm',
                    success: function (data) {
                        if (!(data === '')) {
                            $('.pagination li:nth-last-child(2)').click();
                            $('#bodyClassifications').append(
                                    '<tr><td><%=i++%></td>' +
                                    '<td>' + itemClass + '</td>' +
                                    '<td class="center"><label class="switch">' +
                                    '<input type="checkbox" checked><span class="slider round"></span>' +
                                    '</label></td><td class="center"><a href="#">' +
                                    '<i class="fa fa-fw fa-lg fa-dedent"></i></a></td>' +
                                    '<td class="center"><a href="#">' +
                                    '<i class="fa fa-fw fa-lg fa-edit"></i></a></td></tr>'
                                    );
                            $('#addclassification').modal('hide');
                        }
                    }
                });
            } else {
                $('#itemclass').focus();
                $('#itemclass').css('border', '2px solid #f50808c4');
            }
        });
        $('#catTableDiv').html('');
        var classification = parseInt($('#selectClassification').val());
        if (!(classification === 0)) {
            $.ajax({
                type: 'POST',
                data: {classification: classification},
                url: 'store/fetchClassificationCategories.htm',
                success: function (res) {
                    $('#catTableDiv').html(res);
                }
            });
        }
        $('#selectClassification').change(function () {
            $('#catTableDiv').html('');
            var classification = parseInt($('#selectClassification').val());
            if (classification > 0) {
                $.ajax({
                    type: 'POST',
                    data: {classification: classification},
                    url: 'store/fetchClassificationCategories.htm',
                    success: function (res) {
                        $('#catTableDiv').html(res);
                    }
                });
            }
        });
    });

    function classificationStatus(id, className, status) {
        if (status.length < 1) {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Activate Classification',
                content: '<strong>' + className + '</strong>',
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
                                url: 'store/activateClassification.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#switch' + id + 'content').html('<label class="switch"><input id="class' + id + '" type="checkbox" checked><span onclick="classificationStatus(' + id + ', \'' + className + '\', \'checked\')" class="slider round"></span></label>');
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Classification Activated',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Activate Classification',
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
                            $('#class' + id).click();
                        }
                    }
                }
            });
        } else {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Deactivate Classification',
                content: '<strong>' + className + '</strong>',
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
                                url: 'store/activateClassification.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#switch' + id + 'content').html('<label class="switch"><input id="class' + id + '" type="checkbox"><span onclick="classificationStatus(' + id + ', \'' + className + '\', \'\')" class="slider round"></span></label>');
                                        $.toast({
                                            heading: 'Info',
                                            text: 'Classification Dectivated',
                                            icon: 'info',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Deactivate Classification',
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
                            $('#class' + id).click();
                        }
                    }
                }
            });
        }
    }

    function editClassification(id, classificationName, description) {
        $.confirm({
            title: 'Update Classification Details!',
            content:'<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Classification Name</label>' +
                    '<input type="text" id="className" value="' + classificationName + '" placeholder="Classification Name" class="form-control"/></div>' +
                    '<div class="form-group">' +
                    '<label for="desc">Description</label>' +
                    '<textarea class="form-control" id="desc" rows="6">' + description + '</textarea></div>' +
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
                        var desc = this.$content.find('#desc').val();
                        var className = this.$content.find('#className').val();
                        if (className.length > 0) {
                            $.ajax({
                                type: 'POST',
                                data: {id: id, name: className, desc: desc},
                                url: 'store/updateClassification.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#classname' + id).html(className);
                                        $('#editClass' + id).attr('onclick', 'editClassification(' + id + ', \'' + className + '\', \'' + desc + '\')');
                                        $.toast({
                                            heading: 'Info',
                                            text: 'Classification Updated.',
                                            icon: 'info',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Update Classification',
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
                                text: 'Failed to Update Classification',
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
