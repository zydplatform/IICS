<%-- 
    Document   : manageDiseases
    Created on : Aug 6, 2018, 11:03:27 PM
    Author     : IICS-GRACE
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="pull-right col-md-3">
    <button onclick="functionAddNewDisease('${categoryid}', '${categoryname}')" class="btn btn-info" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Disease</button> 
</div>
<table class="table table-hover table-bordered" id="diseasesTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Disease</th>
            <th>Code</th>
            <th class="center">Description</th>
            <th class="center">Activation</th>
            <th class="center">Update | Remove</th>
        </tr>
    </thead>
    <tbody>
        <% int q = 1;%>
        <% int e = 1;%>
        <c:forEach items="${diseaseDiseaseList}" var="a">
            <tr>
                <td><%=q++%></td>
                <td id="diseasename${a.diseaseid}">${a.diseasename}</td>
                <td id="diseasecode${a.diseaseid}">${a.diseasecode}</td>
                <td class="center"><a id="" data-container="body" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="${a.description}" data-original-title="${a.diseasename}" href="#!"> <i class="fa fa-fw fa-lg fa-dedent"></i></a></td>
        <input type="hidden" id="diseasedescription${a.diseaseid}" value="${a.description}"/>
        <td align="center">
            <div class="toggle-flip">
                <label>
                    <input id="actdeactcat<%=e++%>" type="checkbox"<c:if test="${a.isactive==true}">checked="checked"</c:if> onchange="if (this.checked) {
                                activateOrDactivatedisease('activate', ${a.diseaseid}, this.id);
                            } else {
                                activateOrDactivatedisease('diactivate', ${a.diseaseid}, this.id);
                            }"><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Active" data-toggle-off="Disabled"></span>
                </label>
            </div>
        </td>
        <td align="center">
            <span onclick="updateDiseaseDetails('${a.diseaseid}', '${a.diseasecode}', '${a.description}', '${categoryid}', '${categoryname}')" title="Edit Of Disease."  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span> | <span onclick="deleteDiseaseDetails('${a.diseaseid}', '${categoryid}', '${categoryname}')" title="Delete Of Disease."  class="badge badge-danger icon-custom"><i class="fa fa-times"></i></span>
        </td>
    </tr>
</c:forEach>

</tbody>
</table> 

<script>
    $(document).ready(function () {
        $('[data-toggle="popover"]').popover();
        $('#diseasesTable').DataTable();
    });

    function functionAddNewDisease(categoryid, categoryname) {
        $.confirm({
            title: 'Add New Disease!',
            content: '' +
                    '<div class="form-group">' +
                    '<label>Category</label>' +
                    '<input type="text" class="form-control" value="' + categoryname + '" disabled=""/>' +
                    '</div>' +
                    '<div class="form-group" required>' +
                    '<label>Disease Name</label>' +
                    '<input type="text" class="form-control" id="diseasename"/>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Disease Code</label>' +
                    '<input type="text" class="form-control" id="diseasecode"/>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Description</label>' +
                    '<textarea rows="9" type="text" class="form-control" id="diseasediscription"></textarea>' +
                    '</div>',
            boxWidth: '40%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-purple',
                    action: function () {
                        var diseasename = this.$content.find('#diseasename').val();
                        var diseasecode = this.$content.find('#diseasecode').val();
                        var diseasediscription = this.$content.find('#diseasediscription').val();
                        if (!diseasename) {
                            $.alert('Please Enter Disease Name!');
                            return false;

                        } else {
                            //SUBMIT Disease
                            var data = {
                                diseasename: diseasename,
                                categoryid: categoryid,
                                diseasecode: diseasecode,
                                diseasediscription: diseasediscription
                            };

                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "consultation/submitNewDisease.htm",
                                data: data,
                                success: function (diseaseid) {
                                    console.log('c'+ diseaseid);
                                    $('#diseaselistdata' + categoryid +' ').append('<li id="diseaselist' + diseaseid + '">' +
                                            '<div><span id="diseaseiid ' + diseaseid + '" onclick="functionDiseaseComponents(\'' + diseasename + '\', \'' + diseaseid+ '\', \'' + diseasecode + '\', \'' + categoryid + '\')" ><span style="padding-left:6%">.</span>' + diseasename + '</span></div></li>');
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

    function activateOrDactivatedisease(type, value, id) {
        if (type === 'activate') {
            $.confirm({
                title: 'Activate Item!',
                content: 'Are You Sure You Want To Activate This Disease?',
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
                                data: {diseaseid: value, type: 'activate'},
                                url: "consultation/activatedOrDeactivatedDiseaseStatus.htm",
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
                content: 'Are You Sure You Want To De-Activate This Disease?',
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
                                data: {diseaseid: value, type: 'deactivate'},
                                url: "consultation/activatedOrDeactivatedDiseaseStatus.htm",
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

    function updateDiseaseDetails(diseaseid, diseasecode, diseasediscription, categoryid, categoryname) {
        var diseasename = $('#diseasename' + diseaseid).text();
        $.confirm({
            title: 'Update Disease!',
            typeAnimated: true,
            type: 'purple',
            content: '' +
                    '<div class="form-group">' +
                    '<label>Disease Name</label>' +
                    '<input type="text" id="diaseaseUpdatename" value="' + diseasename + '" class="categoryUpdatename form-control" required/>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Disease Code</label>' +
                    '<input type="text" class="form-control" id="diseasecode2"  value="' + diseasecode + '"/>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Description</label>' +
                    '<textarea type="text" rows="9" class="form-control" id="diseasediscription2">' + diseasediscription + '</textarea>' +
                    '</div>',
            boxWidth: '40%',
            useBootstrap: false,
            buttons: {
                formSubmit: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var name = this.$content.find('#diaseaseUpdatename').val();
                        var diseasecode = this.$content.find('#diseasecode2').val();
                        var diseasediscription = this.$content.find('#diseasediscription2').val();
                        if (!name) {
                            $.alert('Please provide a valid name');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {diseaseid: diseaseid, diseasename: name, diseasecode: diseasecode, diseasediscription: diseasediscription},
                            url: "consultation/updateDiseaseDetails.htm",
                            success: function (response) {
                                if (response === 'success') {
                                    $('#diseaseiid' + diseaseid).text(name);
                                    $('#diseasename' + diseaseid).text(name);
                                    $('#diseasecode' + diseaseid).text(diseasecode);
                                    $('#diseasedescription' + diseaseid).text(diseasediscription);
                                    ajaxSubmitData('consultation/manageDiseaseCategories.htm', 'diseasecategoryItemsDivs', 'categoryid=' + categoryid + '&categoryname=' + categoryname + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                },
                close: function () {
                    //close
                },
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

    function deleteDiseaseDetails(diseaseid, categoryid, categoryname) {
        var diseasename = $('#diseasename' + diseaseid).text();
        $.confirm({
            title: 'Delete Disease!',
            typeAnimated: true,
            type: 'purple',
            content: diseasename,
            buttons: {
                formSubmit: {
                    text: 'Delete',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {diseaseid: diseaseid},
                            url: "consultation/deleteDisease.htm",
                            success: function (response) {
                                if (response === 'deleted') {
                                    $('#diseaselist' + diseaseid).hide();
                                    ajaxSubmitData('consultation/manageDiseaseCategories.htm', 'diseasecategoryItemsDivs', 'categoryid=' + categoryid + '&categoryname=' + categoryname + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                                if (response === 'hassymptoms') {
                                    $.confirm({
                                        title: 'Delete Disease!',
                                        typeAnimated: true,
                                        type: 'purple',
                                        content: 'Disease <strong>' + diseasename + '</strong> has attached symptoms',
                                        buttons: {
                                            formSubmit: {
                                                text: 'Confirm Delete',
                                                btnClass: 'btn-purple',
                                                action: function () {
                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {diseaseid: diseaseid},
                                                        url: "consultation/deleteDiseaseWithSymptoms.htm",
                                                        success: function (response) {
                                                            if (response === 'deleted2') {
                                                                $('#diseaselist' + diseaseid).hide();
                                                                ajaxSubmitData('consultation/consultationhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
