<%-- 
    Document   : viewqueuetypes
    Created on : Apr 12, 2018, 11:38:20 AM
    Author     : SAMINUNU
--%>
<%@include file="../../../../include.jsp" %>
<div class="row user">
    <div class="col-md-12">
        <div class="tab-pane active" id="classifications">
            <div class="tile">
                <div class="tile-body">

                    <p>
                        <a class="btn btn-primary icon-btn" id="addnewqueuetype" href="#">
                            <i class="fa fa-plus"></i>
                            Add Queue Type
                        </a>
                    </p>
                    <fieldset>
                        <table class="table table-hover table-bordered col-md-12" id="classificationTable">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Name</th>
                                    <th>Weight</th>
                                    <th>More Info.</th>
                                    <security:authorize access="hasRole('ROLE_ROOTADMIN')or hasAuthority('PRIVILEGE_UPDATEQUEUES')">
                                    <th>Update</th>
                                    </security:authorize>
                                    <security:authorize access="hasRole('ROLE_ROOTADMIN')or hasAuthority('PRIVILEGE_DELETEQUEUES')">
                                    <th class="center">Remove</th>
                                    </security:authorize>
                                </tr>
                            </thead>
                            <tbody class="col-md-12" id="bodyClassifications">
                                <% int n = 1;%>
                                <% int p = 1;%>
                                <% int rq = 1;%>
                                <c:forEach items="${model.queuingList}" var="q">
                                    <tr id="${q.queuetypeid}">
                                        <td><%=n++%></td>
                                        <td>${q.name}</td>
                                        <td>${q.weight}</td>
                                        <td>${q.description}</td>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN')or hasAuthority('PRIVILEGE_UPDATEQUEUES')">
                                            <td class="center">
                                            <a href="#">
                                                <i class="fa fa-fw fa-lg fa-edit" onclick="updateQueues(this.id);" id="up9<%=p++%>"></i>
                                            </a>
                                        </td>
                                        </security:authorize>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN')or hasAuthority('PRIVILEGE_DELETEQUEUES')">
                                             <td class="center"><a href="#" onclick="removeQueueType(this.id);" id="up9<%=rq++%>" class="btn btn-xs btn-teal tooltips" style="background-color: purple; color: white"><i class="fa fa-remove"></i></a></td>
                                        </security:authorize>                                       
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </fieldset>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addqueuetype" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Add Queuing Type</h5>
                <span aria-hidden="true" class="close" data-dismiss="modal" aria-label="Close">&times;</span>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="row">
                                <div class="col-md-12">
                                    <form>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label for="itemclass">Queue Name</label>
                                                    <input class="form-control" id="queuetypename" required="true" type="text"  placeholder="Enter Queue Type">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="desc">Weight</label>
                                                    <input class="form-control" id="queuetypeweight" type="text" oninput="checkWeights()" required="true"  placeholder="Enter Queue Type Weight">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="desc">More Information</label>
                                            <textarea class="form-control" id="queuetypedesc" rows="4"></textarea>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="tile-footer">
                                <button class="btn btn-primary" id="savequeuetype" type="submit"><i class="fa fa-check-circle"></i>Save</button>
                                <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="updatequeuetype" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Edit Queuing Type</h5>
                <span aria-hidden="true" class="close" data-dismiss="modal" aria-label="Close">&times;</span>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="row">
                                <div class="col-md-12">
                                    <form>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label for="itemclass">Queue Type</label>
                                                    <input class="form-control" id="queuetypeupdatename" type="text"  placeholder="Enter Queue Type" disabled="true">
                                                    <input class="form-control" id="queuetypeupdateid" type="hidden"  placeholder="Enter Queue id">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="desc">Weight</label>
                                                    <input class="form-control" id="queuetypeupdateweight" type="text"  placeholder="Enter Queue Type Weight">
                                                </div>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="desc">More Information</label>
                                            <textarea class="form-control" id="queuetypeupdatedesc" rows="4"></textarea>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="tile-footer">
                                <button class="btn btn-primary" id="editqueuetype" type="submit"><i class="fa fa-check-circle" ></i>Save Changes</button>
                                <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
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
        $('#classificationTable').DataTable();


    });


    function removeQueueType(id) {
        $.confirm({
            title: 'Message!',
            content: 'Do You Seriously Want To Delete This Queue Type?',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        var tablerowid = $('#' + id).closest('tr').attr('id');
                        $.ajax({
                            type: 'POST',
                            data: {queuetypeid: tablerowid},
                            url: "queuingsystemsettings/removequeuetype",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    $.alert({
                                        title: 'Alert!',
                                        content: 'Queue Type Successfully Removed',
                                    });
                                    $('#' + tablerowid).remove();

                                    ajaxSubmitData('queuingsystemsettings/queuepane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }

                        });
                    }
                },
                No: function () {
                    ajaxSubmitData('queuingsystemsettings/queuepane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            }
        });

    }

    $('#savequeuetype').click(function () {
        var validqueuename = $("#queuetypename").val();
        var validweight = $("#queuetypeweight").val();

        if (validqueuename === '' || validweight === '') {
            if (validqueuename === '')
                alert('Please Enter The Queue Name/Type!!');
            else if (validweight === '')
                alert('Please Enter The Queue Weight!!');
        } else {
            swal({
                title: "Save Queue Types?",
                type: "warning",
                showCancelButton: true,
                confirmButtonText: "Cancel",
                cancelButtonText: "Save",
                closeOnConfirm: true,
                closeOnCancel: false
            }
            ,
                    function (isConfirm) {
                        if (isConfirm) {

                            document.getElementById('queuetypename').value = "";
                            document.getElementById('queuetypeweight').value = "";
                            document.getElementById('queuetypedesc').value = "";


                            swal("Deleted!", );
                        } else {
                            $('.close').click();
                            var name = $('#queuetypename').val();
                            var weight = $('#queuetypeweight').val();
                            var description = $('#queuetypedesc').val();

                            $.ajax({
                                type: 'POST',
                                data: {name: name, weight: weight, description: description},
                                dataType: 'text',
                                url: "queuingsystemsettings/savequeuingtypes.htm",
                                success: function (data, textStatus, jqXHR) {

                                    document.getElementById('queuetypename').value = "";
                                    document.getElementById('queuetypeweight').value = "";
                                    document.getElementById('queuetypedesc').value = "";

                                    ajaxSubmitData('queuingsystemsettings/queuepane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                            swal("Saved", "Queue Types Added", "success");
                        }
                    });
        }
    });

</script>
