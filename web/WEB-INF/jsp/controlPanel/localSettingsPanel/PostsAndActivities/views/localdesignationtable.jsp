<%-- 
    Document   : localdesignationtable
    Created on : Apr 8, 2018, 10:31:19 PM
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
<div id="showlocalcontentresponse"></div>
<table class="table table-hover table-bordered col-md-12" id="designationCategoryTables">
    <thead>
        <tr>
            <th>No.</th>
            <th>Designation Category Name</th>
            <th>No. Of Posts</th>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGELOCALDESIGNATIONCATEGORY')">
                <th>Manage Designation Categories</th>
                </security:authorize>
        </tr>
    </thead>
    <tbody class="col-md-12" id="domaindesignation">
        <% int p = 1;%>
        <% int b = 1;%>
        <% int k = 1;%>
        <% int v = 1;%>
        <% int g = 1;%>
        <c:forEach items="${designations}" var="a">

            <tr id="${a.designationcategoryid}">
                <td><%=k++%></td>
                <td>${a.categoryname}</td>
                <td class="center">
                    <c:if test="${a.rolessize == 0}">
                        <span class="badge badge-pill badge-danger"><a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${a.categoryname} Has no designation(s) please add designation(s)" style="color: #fff" href="#">${a.rolessize}</a></span>
                        </c:if>
                        <c:if test="${a.rolessize > 0}">
                        <span class="badge badge-pill badge-success"><a  onclick="viewlocalposts(${a.designationcategoryid}, '${a.categoryname}');" style="cursor: pointer;color: #fff">${a.rolessize}</a></span>
                        </c:if>
                </td>
                <td class="center">
                    <div class="btn-group" role="group">
                        <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-sliders" aria-hidden="true"></i>
                        </button>
                        <div class="dropdown-menu dropdown-menu-left">
                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGELOCALDESIGNATIONCATEGORY')">       
                                <a class="dropdown-item" href="#!" onclick="updateFacilityLocalDomain(this.id);" id="up10<%=b++%>">Edit Designation Category</a>
                            </security:authorize>      
                            <span class="dropdown-item" style="cursor: pointer;" onclick="deletelocaldesignationcategory(${a.designationcategoryid}, '${a.categoryname}');" id="up<%=g++%>">Delete Designation Category</span>
                            <span class="dropdown-item" style="cursor: pointer;" onclick="addnewlocalposts(this.id);" id="editview<%=p++%>">Add Designations(s)</span>
                        </div>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<div class="row">
    <div class="col-md-12">
        <div id="adddesignations" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h4 class="modalDialog-title">ADD DESIGNATIONS &nbsp;</h4>
                    <hr>
                </div>
                <div class="row scrollbar" id="addcontents">
                    <div class="col-md-12">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div id="EditLocalposts" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h4 class="modalDialog-title">VIEW AND MANAGE POSTS UNDER &nbsp; <span style="text-transform: uppercase;" id="localname2"></span></h4>
                    <hr>
                    <input id="localname" type="hidden">
                    <input id="localdesgId" type="hidden">
                </div>
                <div class="row scrollbar" id="contents">
                    <div class="col-md-12">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="assignme" role="dialog">
    <%@include file="viewattachments.jsp" %>
</div>
<div id="showOndialogz" class="hidedisplaycontent">
    <div id="showOptionz"></div>
</div>
<script>
    $('[data-toggle="popover"]').popover();
    $('.auto_search_posts').select2();
    $('.select2').css('width', '100%');

    $('.new_search').select2();
    $('.select2').css('width', '100%');

    $(document).ready(function () {

        $('#addlocalpostsid').click(function () {
            $('#addlocalposts').modal('show');

            refresh: true;
        });

        $('#sampleTable').DataTable();
        $('#importposttable').DataTable();
        $('#designationCategoryTables').DataTable();

    });

    function viewlocalposts(designationcategoryid, categoryname) {

        $.ajax({
            type: "GET",
            cache: false,
            url: "localsettingspostsandactivities/viewlocalposts.htm",
            data: {designationcategoryid: designationcategoryid, categoryname: categoryname},
            success: function (data) {
                $.dialog({
                    title: '<strong class="center">VIEW/MANAGE POSTS UNDER' + ' ' + '<font color="green">' + categoryname + '</font>' + '</strong>',
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

    function addnewlocalposts(id) {
        var tableData = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');

        $.ajax({
            type: "GET",
            cache: false,
            url: "localsettingspostsandactivities/adddesignations.htm",
            data: {desigCatId: tablerowid, desigCatName: tableData[1]},
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">ADD POSTS UNDER' + ' ' + '<font color="green">' + tableData[1] + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '80%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
    }

//SAVING LOCAL SETTINGS POSTS
    $('#demosavepost').click(function () {

        $.confirm({
            title: 'Message!',
            content: 'Save Designation',
            type: 'blue',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {

                        var designationid_designationname = document.getElementById('add_post_select').value;
                        var fields = designationid_designationname.split('-');
                        var designationid = fields[0];
                        var designationname = fields[1];
                        var designationcategoryid = $('#localdesigId').val();
                        var description = $('#descriptions').val();

                        $.ajax({
                            type: "POST",
                            data: {designationname: designationname, description: description, designationid: designationid, designationcategoryid: designationcategoryid},
                            dataType: 'text',
                            url: "localsettingspostsandactivities/savelocalPosts.htm",
                            success: function (response) {

                                document.getElementById('descriptions').value = "";
                                window.location = '#close';
                                ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                            }
                        });

                    }
                },
                NO: function () {
                    document.getElementById('descriptions').value = "";
                    window.location = '#close';
                    ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                }
            }
        });

    });


    function updateFacilityLocalDomain(value) {
        var facilitynames = $("#facilityname").val();
        var facilityids = $("#facilityid").val();
        var tableData = $('#' + value).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + value).closest('tr').attr('id');

        document.getElementById('localdesignationcategoryname').value = tablerowid;
        document.getElementById('loacldesignationcategoryid').value = tableData[1];
//        document.getElementById('localdesignationcategorydesc').value = tableData[2];
        document.getElementById('facilityupdatename').value = facilitynames;
        document.getElementById('facilityupdateid').value = facilityids;

        $('#updatelocaldesigna').modal('show');
    }

    function deletelocaldesignationcategory(designationcategoryid, categoryname) {
        console.log("designationcategoryidhuhuhu:::::::::::::" + designationcategoryid);

        $.confirm({
            title: 'Delete/Discard ' + categoryname,
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {designationcategoryid: designationcategoryid},
                            url: "localsettingspostsandactivities/deletelocaldesigcat.htm",
                            success: function (results) {
                                console.log(results);
                                if (results === '') {
                                    $.confirm({
                                        title: 'Deleted/Discarded ' + categoryname + 'Successfully',
                                        type: 'orange',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                                            }
                                        }
                                    });
                                } else {
                                    $.confirm({
                                        title: 'Can Not Delete' + ' ' + categoryname + ' ' + 'Because It Has' + ' ' + results + ' ' + 'Attachments',
                                        content: 'Would You Like To Delete?',
                                        type: 'red',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'OK',
                                                btnClass: 'btn-red',
                                                action: function () {
                                                    $.ajax({
                                                        type: "GET",
                                                        cache: false,
                                                        url: "localsettingspostsandactivities/viewDesigCatAttachments.htm",
                                                        data: {designationcategoryid: designationcategoryid, categoryname: categoryname},
                                                        success: function (data) {
                                                            $.confirm({
                                                                title: '<strong class="center">TRANSFER POSTS UNDER' + ' ' + '<font color="green">' + categoryname + '</font>' + '</strong>',
                                                                content: '' + data,
                                                                boxWidth: '60%',
                                                                useBootstrap: false,
                                                                type: 'purple',
                                                                typeAnimated: true,
                                                                closeIcon: true

                                                            });
                                                        }
                                                    });
                                                    //ajaxSubmitData('localsettingspostsandactivities/viewDesigCatAttachments.htm', '', 'designationcategoryid=' + designationcategoryid + '&categoryname=' + categoryname + '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'POST');
                                                }
                                            },
                                            NO: function () {
                                            }
                                        }
                                    });
                                }
                            }
                        });

                    }
                },
                NO: function () {
                    ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                }
            }
        });

    }

</script>

