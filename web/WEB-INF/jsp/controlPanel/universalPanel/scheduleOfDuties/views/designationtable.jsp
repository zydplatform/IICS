<%-- 
    Document   : designationtable
    Created on : Jul 24, 2019, 11:50:17 AM
    Author     : USER 1
--%>
<%@include file="../../../../include.jsp"%>
<div id="configuration_table">
    <div style="align:left">
        <button class="btn btn-primary icon-btn pull-left" id="saveConfiguration" onclick="savenewConfig();" data-caller="">
            <i class="fa fa-save"></i>Add New Configuration
        </button>
        <br>

    </div>
    <div >
        <table class="table table-hover table-bordered col-md-12" id="sampleTables">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Designation</th>
                    <th>Slots</th>
                    <th>Edit Configuration</th>
                </tr>
            </thead>
            <tbody class="col-md-12" id="domaindesignation">
                <% int q = 1;%>
                <c:forEach items="${designationList}" var="ac">
                    <tr id="">
                        <td><%=q++%></td>
                        <td id="${ac.designationid}">${ac.designationname}</td>
                        <td>
                            <c:if test="${ac.requiredstaff == 0}">
                                <a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${ac.categoryname} Has no Post(s) please add Post(s)" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red; color: white">
                                    <span>${ac.requiredstaff}</span>
                                </a>
                            </c:if>
                            <c:if test="${ac.requiredstaff > 0}">
                                <a><button class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: green;" id="editUniversalPosts" onclick="" ><span>${ac.requiredstaff}</span></button></a>
                            </c:if>
                            </td>   
                            <td class="center"><a href="#" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit" onclick="updatedesignationconfig(${ac.designationid}, '${ac.designationname}',${ac.requiredstaff})"><i class="fa fa-edit"></i></a>
                            <span class="btn btn-xs" style="background-color: red; color: white;" onclick="deletedesignationconfig(${ac.designationid}, '${ac.designationname}',${ac.requiredstaff});"><i class="fa fa-fw fa-lg fa-times"></i></span>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $('#sampleTables').DataTable();    
    var facilitylevlid = ${facilitylevelid};

    function savenewConfig() {
        $.ajax({
            type: 'GET',
            url: "postsandactivities/fetchconfiguredesignation.htm",
            success: function (data) {
                $.confirm({
                    icon: '',
                    title: 'Designation Configuration',
                    content: '' + data,
                    type: 'purple',
                    typeAnimated: true,
                    boxWidth: '40%',
                    useBootstrap: false,
                    onContentReady: function () {

                    },
                    buttons: {
                        save: {
                            text: 'Save',
                            btnClass: 'btn btn-success',
                            action: function () {                                
                                var designationid = this.$content.find("#designation_list").val().trim();
                                var requiredstaff = this.$content.find('#requiredPosts').val().trim();
                                var facilitylevelid = ${facilitylevelid};


                                if (designationid === '') {
                                    this.$content.find("#designation_list").css('border-color', '#ff0000');
                                    return false;
                                }
                                if (requiredstaff === '') {
                                    this.$content.find('#requiredPosts').css('border-color', '#ff0000');
                                    return false;
                                }

                                if (requiredstaff < 1 || requiredstaff > 75) {
                                    $.confirm({
                                        icon: '',
                                        title: 'Invalid Value! Try again',
                                        content: '',
                                        type: 'purple',
                                        typeAnimated: true,
                                        boxWidth: '40%',
                                        useBootstrap: false,
                                        onContentReady: function () {

                                        },
                                        buttons: {
                                            save: {
                                                text: 'OK',
                                                btnClass: 'btn btn-danger',
                                                action: function () {

                                                }

                                            }
                                        }
                                    });
                                    this.$content.find('#requiredPosts').css('border-color', '#ff0000');
                                    return false;
                                }

                                data = {
                                    designationid: designationid,
                                    requiredstaff: requiredstaff,
                                    facilitylevelid: facilitylevelid
                                };
                                $.ajax({
                                    type: 'GET',
                                    data: data,
                                    url: 'postsandactivities/saveNewDesignationConfiguration.htm',
                                    success: function () {
                                        ajaxSubmitData('postsandactivities/fetchdesignationTable.htm', 'configuration_table', 'facilitylevelid=' + facilitylevelid, 'GET');
                                    }
                                });

                            },

                        },
                        cancel: {
                            text: 'Cancel',
                            btnClass: 'btn-purple',
                            action: function () {
                                $(this).prop('checked', false);
                            }
                        }
                    }
                });
            }
        });
    }

    function updatedesignationconfig(designationid, designationname, requiredStaff) {
        $.ajax({
            type: 'GET',
            url: "postsandactivities/fetchupdatedesignation.htm",
            success: function (data) {
                $.confirm({
                    icon: '',
                    title: 'Update Configuration',
                    content: '' + data,
                    type: 'purple',
                    typeAnimated: true,
                    boxWidth: '40%',
                    useBootstrap: false,
                    onContentReady: function () {
                        var designation = this.$content.find("#designation").val(designationname);
                        var requiredstaff = this.$content.find('#requiredPosts').val(requiredStaff);
                    },
                    buttons: {
                        save: {
                            text: 'Save',
                            btnClass: 'btn btn-success',
                            action: function () {                                
                                var requiredstaff = this.$content.find('#requiredPosts').val().trim();
                                var facilitylevelid = ${facilitylevelid};

                                if (requiredstaff === '') {
                                    this.$content.find('#requiredPosts').css('border-color', '#ff0000');
                                    return false;
                                }
                                if (requiredstaff < 0 || requiredstaff > 75) {
                                    this.$content.find('#requiredPosts').css('border-color', '#ff0000');
                                    return false;
                                }


                                data = {
                                    designationid: designationid,
                                    requiredstaff: requiredstaff,
                                    facilitylevelid: facilitylevelid
                                };
                                $.ajax({
                                    type: 'GET',
                                    url: 'postsandactivities/updateDesignationConfiguration.htm',
                                    data: data,
                                    success: function () {
                                        ajaxSubmitData('postsandactivities/fetchdesignationTable.htm', 'configuration_table', 'facilitylevelid=' + facilitylevelid, 'GET');
                                    }
                                });
                            }

                        },
                        cancel: {
                            text: 'Cancel',
                            btnClass: 'btn-purple',
                            action: function () {
                                $(this).prop('checked', false);
                            }
                        }
                    }
                });
            }
        });

//                    $.ajax({
//                        type: 'GET',
//                        url: 'postsandactivities/updateDesignationConfiguration.htm',
//                        data: data,
//                        success: function(){
//                            ajaxSubmitData('postsandactivities/fetchdesignationTable.htm', 'configuration_table', 'facilitylevelid='+facilitylevelid, 'GET');
//                        }
//                    });

    }

    function deletedesignationconfig(designationid, designationname, requiredstaff) {
        var facilitylevelid = ${facilitylevelid};
        $.confirm({
            icon: '',
            title: 'Are you sure you want ot delete ' + designationname + ' ?',
            content: '',
            type: 'purple',
            typeAnimated: true,
            boxWidth: '40%',
            useBootstrap: false,
            onContentReady: function () {

            },
            buttons: {
                save: {
                    text: 'Yes',
                    btnClass: 'btn btn-success',
                    action: function () {                        
                        $.ajax({
                            type: 'POST',
                            url: 'postsandactivities/deletedesignationconfig.htm',
                            data: {designationid: designationid, designationname: designationname, requiredstaff: requiredstaff, facilitylevelid: facilitylevelid},
                            success: function () {                                
                                ajaxSubmitData('postsandactivities/fetchdesignationTable.htm', 'configuration_table', 'facilitylevelid=' + facilitylevelid, 'GET');
                            }
                        });
                    }

                },
                cancel: {
                    text: 'No',
                    btnClass: 'btn-purple',
                    action: function () {
                        $(this).prop('checked', false);
                    }
                }
            }
        });


    }
</script>