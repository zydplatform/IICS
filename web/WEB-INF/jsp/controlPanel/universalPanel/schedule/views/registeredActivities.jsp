<%-- 
    Document   : registeredActivities
    Created on : Jun 14, 2018, 2:55:25 PM
    Author     : IICS
--%>
<style>
    .focus {
        border-color:red !important;
    }
</style>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">
    <div class="col-md-12">
        <button onclick="addnewactivity();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>Add Activity</button>
    </div>
</div>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered" id="tableactivityFound">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Activity Name</th>
                                    <th>Bean Name</th>
                                    <th>More Info</th>
                                    <th>Created By</th>
                                    <th>Update | Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int j = 1;%>
                                <% int i = 1;%>
                                <c:forEach items="${activityFound}" var="a">
                                    <tr>
                                        <td><%=j++%></td>
                                        <td>${a.activityname}</td>
                                        <td>${a.beanname}</td>
                                        <td align="center">
                                            <a id="" data-container="body" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="${a.description}" data-original-title="${a.beanname}" href="#"> <i class="fa fa-fw fa-lg fa-dedent"></i></a>
                                        </td>
                                        <td>${a.personname}</td>
                                        <td align="center">
                                            <span  title="Edit Of This Activity." onclick="editordeleteactivity('edit',${a.autoactivityrunsettingid}, '${a.activityname}', '${a.beanname}', '${a.description}',${a.added});" class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                                            |
                                            <span title="Delete Of This Activity." onclick="editordeleteactivity('delete',${a.autoactivityrunsettingid}, '${a.activityname}', '${a.beanname}', '${a.description}',${a.added});" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span>
                                        </td>
                                    </tr>

                                </c:forEach>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div>

<script>
    $(function () {
        $('[data-toggle="popover"]').popover();
    });
    $('#tableactivityFound').DataTable();
    function addnewactivity() {
        $.confirm({
            title: 'Auto Running Activity!',
            typeAnimated: true,
            type: 'orange',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Bean Name here</label>' +
                    '<input type="text" id="checkforbeanname" placeholder="Your Bean Name" oninput="checkforexistingbeanname(this.value,this.id);" class="name form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Enter Activity here</label>' +
                    '<input type="text"  placeholder="Your Activity" class="activity form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Enter More Info here</label>' +
                    '<textarea placeholder="Your More Info" class="moreinfo form-control" rows="3" required></textarea>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Save',
                    btnClass: 'btn-blue',
                    action: function () {
                        var activity = this.$content.find('.activity').val();
                        var bean = this.$content.find('.name').val();
                        var moreinfo = this.$content.find('.moreinfo').val();
                        if (!activity) {
                            $.alert('provide a valid Activity');
                            return false;
                        }
                        if (!bean) {
                            $.alert('provide a valid Bean Name');
                            return false;
                        }
                        if (!moreinfo) {
                            $.alert('provide a valid More Info');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'save', beanname: bean, activity: activity, moreinfo: moreinfo},
                            url: "schedulerservicesmanagement/saveorupdatenewactivity.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'saved') {
                                    $.confirm({
                                        title: 'Activity!',
                                        content: 'Activity Saved SuccessFully !!',
                                        type: 'orange',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                ajaxSubmitData('schedulerservicesmanagement/schedulerservicesactivities.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            }
                                        }
                                    });
                                }
                                if (data === 'null') {
                                    $.confirm({
                                        title: 'Activity!',
                                        content: 'No Such Bean Name Found !!',
                                        type: 'red',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                            }
                                        }
                                    });
                                }
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                },
            }
        });
    }
    function checkforexistingbeanname(value, id) {
        $.ajax({
            type: 'POST',
            data: {beanname: value},
            url: "schedulerservicesmanagement/checkforexistingbeanname.htm",
            success: function (data, textStatus, jqXHR) {
                if (data !== 'null') {
                    console.log('vncnncvmcnvmnvmc');
                    $('#' + id).removeClass("focus");
                } else {
                    $('#' + id).addClass("focus");
                    console.log('pppppppppppppppp');
                }
            }
        });
    }
    function editordeleteactivity(type, autoactivityrunsettingid, activityname, beanname, description, added) {
        if (type === 'edit') {
            $.confirm({
                title: 'Update Auto Running Activity!',
                typeAnimated: true,
                type: 'orange',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label>Enter Bean Name here</label>' +
                        '<input type="text" id="updatecheckforbeanname" value="' + beanname + '" oninput="updatecheckforexistingbeanname(this.value,this.id);" class="updatename form-control" required />' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label>Enter Activity here</label>' +
                        '<input type="text"  value="' + activityname + '" class="updateactivity form-control" required />' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label>Enter More Info here</label>' +
                        '<textarea  class="udatemoreinfo form-control" rows="3" required>' + description + '</textarea>' +
                        '</div>' +
                        '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Update',
                        btnClass: 'btn-blue',
                        action: function () {
                            var activity = this.$content.find('.updateactivity').val();
                            var bean = this.$content.find('.updatename').val();
                            var moreinfo = this.$content.find('.udatemoreinfo').val();
                            if (!activity) {
                                $.alert('provide a valid Activity');
                                return false;
                            }
                            if (!bean) {
                                $.alert('provide a valid Bean Name');
                                return false;
                            }
                            if (!moreinfo) {
                                $.alert('provide a valid More Info');
                                return false;
                            }
                            if (activity === activityname && bean === beanname && moreinfo === description) {
                                $.confirm({
                                    title: 'Update Activity!',
                                    content: 'Nothing To Update !!',
                                    type: 'red',
                                    typeAnimated: true,
                                    buttons: {
                                        close: function () {

                                        }
                                    }
                                });
                                return false;
                            }
                            $.ajax({
                                type: 'POST',
                                data: {type: 'update', beanname: bean, activity: activity, moreinfo: moreinfo, autoactivityrunsettingid: autoactivityrunsettingid},
                                url: "schedulerservicesmanagement/saveorupdatenewactivity.htm",
                                success: function (data, textStatus, jqXHR) {
                                    if (data === 'saved') {
                                        $.confirm({
                                            title: 'Update Activity!',
                                            content: 'Activity Updated SuccessFully !!',
                                            type: 'orange',
                                            typeAnimated: true,
                                            buttons: {
                                                close: function () {
                                                    ajaxSubmitData('schedulerservicesmanagement/schedulerservicesactivities.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                }
                                            }
                                        });
                                    }
                                    if (data === 'null') {
                                        $.confirm({
                                            title: 'Update Activity!',
                                            content: 'No Such Bean Name Found !!',
                                            type: 'red',
                                            typeAnimated: true,
                                            buttons: {
                                                close: function () {
                                                }
                                            }
                                        });
                                    }
                                }
                            });
                        }
                    },
                    cancel: function () {
                        //close
                    },
                }
            });
        } else {
            if (added === true) {
                $.confirm({
                    title: 'Delete Activity!',
                    content: 'Cannot Be Deleted Because Of Service Attachments !!',
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        close: function () {

                        }
                    }
                });
            } else {
                $.confirm({
                    title: 'Delete Activity!',
                    content: 'Are You Sure You Want To Delete This Activity !!',
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Yes, Delete',
                            btnClass: 'btn-red',
                            action: function () {
                                $.ajax({
                                    type: 'POST',
                                    data: {type: 'delete', autoactivityrunsettingid: autoactivityrunsettingid,beanname:beanname},
                                    url: "schedulerservicesmanagement/saveorupdatenewactivity.htm",
                                    success: function (data, textStatus, jqXHR) {
                                        if (data === 'saved') {
                                             ajaxSubmitData('schedulerservicesmanagement/schedulerservicesactivities.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
        }
    }
     function updatecheckforexistingbeanname(value, id) {
        $.ajax({
            type: 'POST',
            data: {beanname: value},
            url: "schedulerservicesmanagement/checkforexistingbeanname.htm",
            success: function (data, textStatus, jqXHR) {
                if (data !== 'null') {
                    $('#' + id).removeClass("focus");
                } else {
                    $('#' + id).addClass("focus");
                }
            }
        });
    }
</script>