<%-- 
    Document   : manageDiseaseCategories
    Created on : Aug 6, 2018, 6:32:13 PM
    Author     : IICS-GRACE
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<div id="disease-category-content">
    <div class="col-md-5">
        <big ><strong>Classification:&nbsp; </strong></big><span id="diseaseclassificationname" style="font-size: 100%" title="Edit Of This Classification." class="badge badge-secondary icon-custom">${diseaseclassificationname}</span>&nbsp;<span onclick="updateDiseaseClassificationName002('${diseaseclassificationid}');" title="Edit Classification."  class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span>
    </div>

    <div class="pull-right col-md-3">
        <button onclick="functionAddNewClassfnCategory('${diseaseclassificationid}', '${diseaseclassificationname}')" class="btn btn-info" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Category</button> 
    </div>

    <table class="table table-hover table-bordered" id="diseasecategorydtailsTable">
        <thead>
            <tr>
                <th>No</th>
                <th>Category</th>
                <th class="center">Activation</th>
                <th class="center">Update</th>
            </tr>
        </thead>
        <tbody>
            <% int i = 1;%>
            <% int de = 1;%>
            <c:forEach items="${diseaseCategoryList}" var="a">
                <tr>
                    <td><%=i++%></td>
                    <td id="category${a.diseasecategoryid}">${a.diseasecategoryname}</td>
                    <td align="center">
                        <div class="toggle-flip">
                            <label>
                                <input id="actdeactcat<%=de++%>" type="checkbox"<c:if test="${a.isactive==true}">checked="checked"</c:if> onchange="if (this.checked) {
                                            activateOrDactivatediseaseCategory('activate', ${a.diseasecategoryid}, this.id);
                                        } else {
                                            activateOrDactivatediseaseCategory('diactivate', ${a.diseasecategoryid}, this.id);
                                        }"><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Active" data-toggle-off="Disabled"></span>
                            </label>
                        </div>
                    </td>
                    <td align="center">
                        <span onclick="updateDiseadeCategoryDetails(${a.diseasecategoryid});" title="Edit Of Disease Category."  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table> 
</div>

<script>
    $('#diseasecategorydtailsTable').DataTable();

    function updateDiseaseClassificationName002(classissificationid) {
        var classificationname = $('#diseaseclassificationname').text();

        $.confirm({
            title: 'Update Classification: ' + classificationname,
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Classification Name</label>' +
                    '<input type="text" value="' + classificationname + '" class="updateclassificationsname form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'save',
                    btnClass: 'btn-purple',
                    action: function () {
                        var name = this.$content.find('.updateclassificationsname').val();
                        if (!name) {
                            $.alert('provide a valid name');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {name: name, classissificationid: classissificationid},
                            url: "consultation/updateDiseaseClassificationName.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $('#diseaseclassificationname').text(name);
                                    $('#class' + classissificationid).text(name);
                                }
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }

    function functionAddNewClassfnCategory(diseaseClassificationId, classificationname) {
        $.confirm({
            title: 'Add New Category!',
            content: '' +
                    '<div class="form-group">' +
                    '<label>Classification</label>' +
                    '<input type="text" class="form-control" value="' + classificationname + '" disabled=""/>' +
                    '</div>' +
                    '<div class="form-group" required>' +
                    '<label>Category Name</label>' +
                    '<input type="text" class="form-control" id="diseasecategory"/>' +
                    '</div>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-purple',
                    action: function () {
                        var diseasecategory = this.$content.find('#diseasecategory').val();
                        if (!diseasecategory) {
                            $.alert('Please Enter Category Name!');
                            return false;

                        } else {
                            //SUBMIT Category
                            var data = {
                                diseasecategoryname: diseasecategory,
                                diseaseClassificationId: diseaseClassificationId
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "consultation/submitDiseaseCategory.htm",
                                data: data,
                                success: function (rep) {
                                    ajaxSubmitData('consultation/consultationhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    }
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function activateOrDactivatediseaseCategory(type, value, id) {
        if (type === 'activate') {
            $.confirm({
                title: 'Activate Item!',
                content: 'Are You Sure You Want To Activate This Category?',
                type: 'red',
                icon: 'fa fa-warning',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {diseasecategoryid: value, type: 'activate'},
                                url: "consultation/activatedOrDeactivatedDiseaseCategory.htm",
                                success: function (data, textStatus, jqXHR) {

                                }
                            });
                        }
                    },
                    close: function () {
                        $('#' + id).prop('checked', false);
                    }
                }
            });
        } else {
            $.confirm({
                title: 'De-Activate Item!',
                content: 'Are You Sure You Want To De-Activate This Category?',
                type: 'red',
                icon: 'fa fa-warning',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {diseasecategoryid: value, type: 'deactivate'},
                                url: "consultation/activatedOrDeactivatedDiseaseCategory.htm",
                                success: function (data, textStatus, jqXHR) {

                                }
                            });
                        }
                    },
                    close: function () {
                        $('#' + id).prop('checked', true);
                    }
                }
            });
        }
    }

    function updateDiseadeCategoryDetails(diseasecategoryid) {
        var diseasecategoryname = $('#category' + diseasecategoryid).text();
        $.confirm({
            title: 'Update Disease Category!',
            typeAnimated: true,
            type: 'purple',
            content: '' +
                    '<div class="form-group">' +
                    '<label>Category Name</label>' +
                    '<input type="text" id="categoryUpdatename" value="' + diseasecategoryname + '" class="categoryUpdatename form-control" required/>' +
                    '</div>',
            buttons: {
                formSubmit: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var name = this.$content.find('#categoryUpdatename').val();
                        if (!name) {
                            $.alert('Please provide a valid name');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {diseasecategoryid: diseasecategoryid, diseasecategoryname: name},
                            url: "consultation/updateDiseaseCategory.htm",
                            success: function (response) {
                                if (response === 'success') {
                                    $('#category' + diseasecategoryid).text(name);
                                    $('#categoryid' + diseasecategoryid).text(name);
                                }
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
</script>