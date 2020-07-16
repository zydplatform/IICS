<%-- 
    Document   : UnidesigCatPosts
    Created on : May 2, 2018, 12:13:02 PM
    Author     : SAMINUNU
--%>
<%@include file="../../../../include.jsp"%>
<style>
    .error
    {
        border:2px solid red;
    }
</style>
<table class="table table-hover table-bordered col-md-12" id="designationCategoryTable">
    <thead>
        <tr>
            <th class="center">No</th>
            <th>Post Name</th>
            <th>Duties and Responsibilities</th>
            <th width="20%">More Info About Post</th>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_UNIVERSALUPDATEORDELETESELECTEDDESIGNATION')"> 
                <th class="center" width="30%">Update Post</th>
                </security:authorize>            
        </tr>
    </thead>
    <tbody class="col-md-12" id="viewposttable">
        <% int c = 1;%>
        <% int bt = 1;%>
        <% int j = 1;%>
        <c:forEach items="${model.viewUniversaldesignationposts}" var="ab">
            <tr id="${ab.designationid}">
                <td><%=c++%></td>
                <td contenteditable="false" class="levelnamefield">${ab.designationname}</td>
                <td align="center">
                    <button class="btn btn-sm btn-secondary" onclick="fetchDutiestable(${ab.designationid}, '${ab.designationname}')">
                        <i class="fa fa-dedent"></i>
                    </button>
                </td>
                <td contenteditable="false">${ab.description}</td>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_UNIVERSALUPDATEORDELETESELECTEDDESIGNATION')"> 
                    <%--                    <td align="center">
                                            <span style="color:white ; background-color: green" onclick="updateUniversalPost(this.id);" id="jk9<%=bt++%>" class="btn btn-xs btn-teal tooltips editDomainLevels" data-placement="top" data-original-title="Edit/Update">Edit</span>
                                            <span class="btn btn-xs" style="background-color: red; color: white;" onclick="deletedesignation(${ab.designationid}, '${ab.designationname}');" id="up<%=j++%>"><i class="fa fa-fw fa-lg fa-times"></i></span>
                                        </td>--%>
                    <td align="center" width="20%">
                        <span style="color:white ; background-color: purple" onclick="postShift(this.id)"
                              id="jk9<%=bt++%>" class="btn btn-xs btn-teal tooltips editDomainLevels" data-placement="top" 
                              data-original-title="Edit/Update">Shift</span>

                        <span style="color:white ; background-color: green" onclick="updateUniversalPost(this.id);" id="jk9<%=bt++%>" class="btn btn-xs btn-teal tooltips editDomainLevels"
                              data-placement="top" data-original-title="Edit/Update">Edit</span>
                        <span class="btn btn-xs" style="background-color: red; color: white;" onclick="deletedesignation(${ab.designationid},
                                        '${ab.designationname}',${ab.designationcategoryid}, ${model.facilitydomainid});" id="up<%=j++%>"><i class="fa fa-fw fa-lg fa-times"></i></span>

                    </td>
                </security:authorize>
            </tr>
        </c:forEach>
    </tbody>
</table>
<div class="row">
    <div class="col-sm-12">
        <div id="updatedesignations">
            <div class="modal fade col-sm-12" id="updateposts" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content" style="width:140%">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">
                                &times;
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="tile">
                                <h3 class="tile-title">UPDATE POST</h3>
                                <div class="tile-body">
                                    <form>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label class="control-label">Designation Category</label>
                                                    <input class="form-control" id="postdesignations" name="domain" value="" type="text" disabled="true">
                                                    <input class="form-control" id="postdesignationsid" name="domain" value="" type="hidden" disabled="true">
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="control-label">Post Name</label>
                                                    <input class="form-control" id="designationname" name="name" type="text" placeholder="Enter Post Name" value="">
                                                    <input class="form-control" id="designationid" type="hidden">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group" id="desigtext">
                                            <label class="control-label">Additional Information</label>
                                            <textarea class="form-control" id="postdescription" name="description" rows="3" placeholder="Enter Information About Post"></textarea>
                                        </div>
                                    </form>
                                </div>
                                <div class="tile-footer">
                                    <button class="btn btn-primary" id="saveUpdatePost" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Update Post</button>
                                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-sm-12">
        <div id="updatedesignations">
            <div class="modal fade col-sm-12" id="shiftmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content" style="width:140%">
                        <div class="modal-header">
                            <h3 class="tile-title">SHIFT POST</h3>
                            <button type="button" class="close" data-dismiss="modal">
                                &times;
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="tile">
                                <legend>Select Location to Transfer Post to </legend>
                                </br>
                                <div class="tile-body">
                                    <form>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label class="control-label">Post Name</label>
                                                    <input class="form-control" id="shiftdesignationname" name="name" type="text" value="">
                                                    <input class="form-control" id="shiftdesignationid" type="hidden" value="$()">
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="control-label">Select Designation Category </label>
                                                    <select class="form-control new_search" id="shiftpostdesignations_list">
                                                        <option value="0">--Select Designation Category--</option>

                                                        <c:forEach items="${model.Categories}" var="u">                                
                                                            <option value='${u.designationcategoryid}'> ${u.categoryname}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="tile-footer">
                                    <button class="btn btn-primary" id="shiftsaveUpdatePost" type="button"><i 
                                            class="fa fa-fw fa-lg fa-check-circle"></i>Shift Post</button>
                                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>        
<script>

    $('#sampleTables').DataTable();
	$('#designationCategoryTable').DataTable();
    function postShift(id) {
        var categoryname = $('#name').val();

        var tableData1 = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        document.getElementById('shiftdesignationid').value = tablerowid;
        document.getElementById('shiftdesignationname').value = tableData1[1];
        document.getElementById('shiftpostdesignations_list').value = categoryname;


        $('#shiftmodal').modal('show');
    }

    function updateUniversalPost(id) {
        var designationcategoryid = $('#desgId').val();
        var categoryname = $('#name').val();

        var tableData1 = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        document.getElementById('designationid').value = tablerowid;
        document.getElementById('designationname').value = tableData1[1];
        document.getElementById('postdescription').value = tableData1[2];
        document.getElementById('postdesignationsid').value = designationcategoryid;
        document.getElementById('postdesignations').value = categoryname;

        $('#updateposts').modal('show');
    }

    function deletedesignation(designationid, designationname, designationcategoryid, facilitydomainid) {

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
                            data: {designationid: designationid, designationcategoryid: designationcategoryid,
                                facilitydomainid: facilitydomainid},
                            url: "postsandactivities/deleteDesignation.htm",
                            success: function (data, textStatus, jqXHR) {
                                console.log("designationcategoryid:::::::::::::" + designationid);
                                if (data === 'success') {
//                                  ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'workpane', '', 'GET');

                                    $.confirm({
                                        title: 'Deleted/Discarded ' + designationname + 'Successfully',
                                        type: 'orange',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                $.confirm({
                                                    title: ' Would you like to Delete Another Post?',
                                                    type: 'purple',
                                                    typeAnimated: true,
                                                    buttons: {
                                                        tryAgain: {
                                                            text: 'YES',
                                                            btnClass: 'btn-red',
                                                            action: function () {                                                                
                                                                ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'content', 'act=a&uniCatId=' + designationcategoryid + '&uniFacId=' + facilitydomainid + '&uni', 'GET');
                                                            }
                                                        },
                                                        NO: function () {
                                                ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'workpane', '', 'GET');
                                            }
                                        }
                                    });
                                                //ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'workpane', '', 'GET');
                                            }
//                                           
                                        }
                                    });
//                                    

                                } else {
                                    $.alert({
                                        title: 'Alert!',
                                        content: 'Can Not Delete This Post Because Of <a href="#!">' + data + ' ' + ' Staff Attached</a> ',
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

    $('#saveUpdatePost').click(function () {
        var validdesigname = $("#designationname").val();
        if (validdesigname === '') {
            $('#designationname').addClass('error');
            $.alert({
                title: 'Alert!',
                content: ' Please Enter Designation Name'
            });
        } else {
            $.confirm({
                title: 'Message!',
                content: 'Are You Sure You Want Update this Designation?',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {

                            var designationcategoryid = $('#postdesignationsid').val();
                            var categoryname = $('#postdesignations').val();
                            var designationids = $('#designationid').val();
                            var designationnames = $('#designationname').val();
                            var description = $('#postdescription').val();

                            var data = {
                                designationcategoryid: designationcategoryid,
                                categoryname: categoryname,
                                designationid: designationids,
                                designationname: designationnames,
                                description: description

                            };

                            $.ajax({
                                type: 'POST',
                                dataType: 'text',
                                url: "postsandactivities/saveUpdatePosts.htm",
                                data: data,
                                success: function (data, textStatus, jqXHR) {
                                    document.getElementById('designationname').value = "";
                                    document.getElementById('description').value = "";
                                    $('.close').click();
                                    ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'workpane', '', 'GET');

                                }
                            });
                        }
                    },
                    NO: function () {
                        $('#updatedesigna').modal('hide');
                    }
                }
            });
        }
    });

    $('#shiftsaveUpdatePost').click(function () {
        var cat = $('#shiftdesignationid').val();

        var cat1 = $('#shiftpostdesignations_list').val();
        if (cat1 === null || cat1 === undefined) {
            $(shiftdesignationid).addClass('error');
            $.alert({
                title: 'Alert',
                content: 'Please Select Designation'
            });
        } else {
            $.confirm({
                title: 'Note:',
                content: 'Are sure you want to transfer this post?',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {

                            var data = {
                                designationcategoryid: cat1,
                                designationid: cat
                            };

                            $.ajax({
                                type: 'GET',
                                dataType: 'text',
                                url: "postsandactivities/postshifting.htm",
                                data: data,
                                success: function (data, textStatus, jqXHR) {
                                    document.getElementById('designationid').value = "";

                                    $('.close').click();
                                    ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'workpane', '', 'GET');

                                }
                            });
                        }
                    },
                    NO: function () {
                        $('#updatedesigna').modal('hide');
                    }
                }




            });
        }
    });
    
    function fetchDutiestable(designationid,designationname){
        var c = designationname;        
        $.ajax({
            type: 'GET',
            url: 'postsandactivities/fetchDuties.htm',
            data: {designationid: designationid},
            success: function(response, textStatus, jqXHR){

                $.confirm({
                    icon: '',
                    title: c +' Duties and Responsibilities',
                    content: ''+response,
                    type: 'purple',
                    typeAnimated: true,
                    boxWidth: '80%',
                    useBootstrap: false,
                    onContentReady: function () {

                    },
                    buttons: {
                        save: {
                            text: 'Close',
                            btnClass: 'btn btn-red',
                            action: function () {

                                    },

                        }
                    }
                });
            }
            
        });
    }


</script>