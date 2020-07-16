<%-- 
    Document   : designationstable
    Created on : Apr 6, 2018, 8:18:03 AM
    Author     : SAMINUNU
--%>
<%@include file="../../../../include.jsp"%>

<div class="col-md-12">
    <div id="showcontentresponse"></div>
    <table class="table table-hover table-bordered col-md-12" id="sampleTable">
        <thead>
            <tr>
                <th>No.</th>
                <th>Designation Category Name</th>
                <th>More Info About Designation Categories</th>
                <th>No. Of Posts</th>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_UNIVERSALMANAGEDESIGNATIONCATERGORIESUPDATEORDELETE')">
                <th>Manage Designation Categories</th>
                </security:authorize>
            </tr>
        </thead>
        <tbody class="col-md-12" id="domaindesignation">
            <% int s = 1;%>
            <% int a = 1;%>
            <% int j = 1;%>
            <% int q = 1;%>
            <c:forEach items="${model.facilitydomainidtable}" var="ac">
                <tr id="${ac.designationcategoryid}">
                    <td><%=q++%></td>
                    <td id="${ac.designationcategoryid}-${ac.categoryname}">${ac.categoryname}</td>
                    <td>${ac.description}</td>
                    <td>
                        <c:if test="${ac.rolessize == 0}">
                            <a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${ac.categoryname} Has no Post(s) please add Post(s)" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red; color: white">
                                <span>${ac.rolessize}</span>
                            </a>
                            <a style="float: right"><button class="btn btn-secondary btn-small center" href="#" onclick="addUniversalPost(this.id);" id="up9<%=a++%>" style="background-color: purple; color: white; font-size: 13px; border-radius: 50%;">Add</button></a>
                        </c:if>
                        <c:if test="${ac.rolessize > 0}">
                            <a><button class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: green;" id="editUniversalPosts" onclick="viewuniversalposts(${ac.designationcategoryid}, '${ac.categoryname}', ${ac.facilitydomainid})" data-designationcategoryid="${ac.designationcategoryid}" data-categoryname="${ac.categoryname}" data-facilitydomainid="${ac.facilitydomainid}"><span>${ac.rolessize}</span></button></a>
                            <a style="float: right"><button class="btn btn-secondary btn-small center" href="#" onclick="addUniversalPost(this.id);" id="up9<%=a++%>" style="background-color: purple; color: white; font-size: 13px; border-radius: 50%;" onclick="viewlocalposts()">Add</button></a>
                        </c:if>
                    </td>
                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_UNIVERSALMANAGEDESIGNATIONCATERGORIESUPDATEORDELETE')">
                        <td class="center"><a href="#" onclick="updateFacilityDomain(this.id);" id="up9<%=s++%>" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit"><i class="fa fa-edit"></i></a>
                            <a href="#" onclick="deletedesignationcategory(${ac.designationcategoryid}, '${ac.categoryname}');" id="up<%=j++%>"><i class="fa fa-fw fa-lg fa-times"></i></a>
                        </td>
                    </security:authorize>                    
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<div class="col-sm-12">
    <div id="addposts">
        <div class="modal fade col-sm-12" id="addpost" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width: 140%">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;
                        </button>
                    </div>
                    <div class="modal-body">
                        <%@include file="../form/addpost.jsp" %>
                    </div>
                    <div class="modal-footer">
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div id="Editposts" class="supplierCatalogDialog">
                <div>
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h4 class="modalDialog-title">VIEW AND MANAGE POSTS UNDER &nbsp;<span style="text-transform: uppercase;" id="name2"></span></h4>
                        <hr>
                        <input id="name" type="hidden">
                        <input id="desgId" type="hidden">
                    </div>
                    <div class="row scrollbar" id="content">
                        <div class="col-md-12">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
                    
    <div class="row">
        <div class="col-sm-12">
            <div id="updatedesignations">
                <div class="modal fade col-sm-12" id="updatedesigna" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content" style="width:140%">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">
                                    &times;
                                </button>
                            </div>
                            <div class="modal-body">
                                <%@include file="../form/updatedesignations.jsp" %>
                            </div>
                            <div class="modal-footer">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#sampleTable').DataTable();
    $('[data-toggle="popover"]').popover();
    $(document).ready(function () {
        $('#addnewpost').click(function () {
            $('#addpost').modal('show');
        });
        $('#updatedesignation').click(function () {
            $.confirm({
                title: 'Message!',
                content: 'Are You Sure You Want Update this Designation Category?',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $('#updatedesigna').modal('hide');
                            var designationcategoryid = $('#designationcategoryids').val();
                            var categoryname = $('#designationcategoryname').val();
                            var facilitydomainid = $('#domain_id').val();
                            var description = $('#designationcategorydesc').val();

                            var data = {
                                designationcategoryid: designationcategoryid,
                                facilitydomainid: facilitydomainid,
                                categoryname: categoryname,
                                description: description

                            };

                            $.ajax({
                                type: 'POST',
                                dataType: 'text',
                                url: "postsandactivities/saveUpdateDesignations.htm",
                                data: data,
                                success: function (data, textStatus, jqXHR) {
                                    //$('#updatedesigna').modal('hide');
                                    $('.close').click();
                                    document.getElementById('description').value = "";
                                    ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'workpane', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    },
                    NO: function () {
                        $('#updatedesigna').modal('hide');
                    }
                }
            });
        });
    });

    function viewuniversalposts(designationcategoryid, name, facilitydomainid) {
        window.location = '#Editposts';
        initDialog('supplierCatalogDialog');
        document.getElementById('name').value = name;
        document.getElementById('name2').innerHTML = name;
        document.getElementById('desgId').value = designationcategoryid;
        //var designationcategoryid = designationcategoryid;
        var facilitydomainid = facilitydomainid;

        ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'content', 'act=a&uniCatId=' + designationcategoryid + '&uniFacId=' + facilitydomainid + '&uni', 'GET');

    }

    function updateFacilityDomain(id) {

        var facilitydomainid = $("#facilitydomainids").val();
        var facilitydomainname = $("#domainnames").val();

        var tableData1 = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        document.getElementById('designationcategoryids').value = tablerowid;
        document.getElementById('designationcategoryname').value = tableData1[1];
        document.getElementById('designationcategorydesc').value = tableData1[2];
        document.getElementById('domain_id').value = facilitydomainid;
        document.getElementById('domain_name').value = facilitydomainname;
        $('#updatedesigna').modal('show');
    }

    function deletedesignationcategory(designationcategoryid, categoryname) {
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
                            url: "postsandactivities/deleteDesignationCategory.htm",
                            success: function (data, textStatus, jqXHR) {
                                console.log("designationcategoryid:::::::::::::" + designationcategoryid);
                                if (data === 'success') {
                                          ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'workpane', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                 
                                    $.confirm({
                                        title: 'Deleted/Discarded ' + categoryname + 'Successfully',
                                        type: 'orange',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {

                                            }
                                        }
                                    });
                                } else {
                                    $.confirm({
                                        title: 'Delete/Discard ' + categoryname,
                                        content: 'Can Not Delete This Designation Category Because Of <a href="#!">' + data + ' ' + 'Attachments</a> ',
                                        type: 'red',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'OK',
                                                btnClass: 'btn-red',
                                                action: function () {
                                                    ajaxSubmitData('postsandactivities/deletedesignationcategorylist.htm', 'showcontentresponse', 'designationcategoryid=' + designationcategoryid + '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                }
                                            },
                                            NO: function () {
                                                ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'content', '&uni', 'GET');
                                            }
                                        }
                                    });

                                }
                            }
                        });

                    }
                },
                NO: function () {
                    ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'content', '&uni', 'GET');
                }
            }
        });

    }
</script>

