<%-- 
    Document   : desigCatPosts
    Created on : Apr 25, 2018, 4:35:59 PM
    Author     : SAMINUNU
--%>
<%@include file="../../../../include.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<style>
    .error
    {
        border:2px solid red;
    }
</style>
<input value="${designationcategoryid}" type="hidden" id="designationcategoryid">
<input value="${categoryname}" type="hidden" id="categoryname">
<table class="table table-hover table-bordered col-md-12" id="designationTables">
    <thead>
        <tr>
            <th class="center">No</th>
            <th>Post Name</th>
            <th class="center">More Info About Posts</th>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGELOCALDESIGNATION')">
                <th class="center">Update Posts</th>
                </security:authorize>
        </tr>
    </thead>
    <tbody class="col-md-12" id="viewposttable">
        <% int im = 1;%>
        <% int ulp = 1;%>
        <% int j = 1;%>
        <c:forEach items="${facilityPostsList}" var="ab">
            <tr id="${ab.designationid}">
                <td><%=im++%></td>
                <td contenteditable="false" class="levelnamefield">${ab.designationname}</td>
                <td contenteditable="false">${ab.description}</td>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGELOCALDESIGNATION')">
                    <td align="center">
                        <div class="btn-group" role="group">
                            <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-sliders" aria-hidden="true"></i>
                            </button>
                            <div class="dropdown-menu dropdown-menu-left">
                                <a class="dropdown-item" href="#!" onclick="updateLocalPost(this.id);" id="up11<%=ulp++%>">Edit Designation</a>
                                <a class="dropdown-item" style="cursor: pointer;" onclick="deletedesignation(${ab.designationid}, '${ab.designationname}');" id="up<%=j++%>">Delete Designation</a>
                            </div>
                        </div>
                    </td>
                </security:authorize>
            </tr>
        </c:forEach>
    </tbody>
</table>

<script>
    $('#edituniversalposts').click(function () {
        $('#updatelocaldesigna').modal('hide');
    });
    $('#designationTables').DataTable();

    function updateLocalPost(id) {
        var designationcategoryid = document.getElementById('designationcategoryid').value;
        var categoryname = document.getElementById('categoryname').value;

        var tableData1 = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        $.ajax({
            type: "GET",
            cache: false,
            url: "localsettingspostsandactivities/editlocalposts.htm",
            data: {designationcategoryid: designationcategoryid, categoryname: categoryname, designationid: tablerowid, designationname: tableData1[1], description: tableData1[2]},
            success: function (data) {
                $.dialog({
                    title: '<strong class="center">EDIT POST' + '</strong>',
                    content: '' + data,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
    }

    function deletedesignation(designationid, designationname) {

        $.confirm({
            title: 'Delete/Discard ' + designationname,
            content: 'Are You Sure You Want To Delete' + ' ' + designationname,
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'YES',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {designationid: designationid},
                            url: "postsandactivities/deleteDesignation.htm",
                            success: function (data, textStatus, jqXHR) {
                                console.log("designationcategoryid:::::::::::::" + designationid);
                                if (data === 'success') {
                                    $.confirm({
                                        title: 'Deleted/Discarded ' + designationname + 'Successfully',
                                        type: 'orange',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                                            }
                                        }
                                    });
                                } else {
                                    $.alert({
                                        title: 'Alert!',
                                        content: 'Failed To Delete/Discard' + ' ' + designationname
                                    });
                                }
                            }
                        });
                    }
                },
                NO: function () {
                }
            }
        });
    }

</script>