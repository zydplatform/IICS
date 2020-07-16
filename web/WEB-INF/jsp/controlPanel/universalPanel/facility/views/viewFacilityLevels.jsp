<%-- 
    Document   : updateFacilityLevels
    Created on : Mar 25, 2018, 1:04:47 AM
    Author     : Grace-K
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<fieldset style="min-height:100px;">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <table class="table table-hover table-bordered " id="facilityLevelsViewTables">
                        <thead>
                            <tr>
                                <th class="center">No</th>
                                <th>Level Name</th>
                                <th>Short Name</th>
                                <th class="">More Info</th>
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_DELETEOREDITFACILITYLEVELDETAILS')">
                                    <th class="center">Update</th>
                                </security:authorize>                                
                            </tr>
                        </thead>
                        <tbody>
                            <% int w = 1;%>
                            <c:forEach items="${faclilityLevelList}" var="a">
                                <tr id="${a.facilitylevelid}">
                                    <td><%=w++%></td>
                                    <td contenteditable="false" class="levelnamefield">${a.facilitylevelname}</td>
                                    <td contenteditable="false">${a.shortname}</td>
                                    <td align="center"><a onclick="facilitylevelmoreinfo('${a.description}', '${a.shortname}');" href="#!"> <i class="fa fa-fw fa-lg fa-dedent"></i></a></td>
                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_DELETEOREDITFACILITYLEVELDETAILS')">
                                    <td align="center">
                                        <div style="float:center">
                                            <span  title="Edit Of This Level." onclick="editFacilityLevelDetails(${a.facilitylevelid}, '${a.facilitylevelname}', '${a.shortname}', '${a.description}');"  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                                            |
                                            <span  title="Delete Of This Level." onclick="deleteFacilityLevelDetails(${a.facilitylevelid});"  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span>
                                                                     
                                        </div>
                                    </td>
                                    </security:authorize>   
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</fieldset>


<script>
    $('#facilityLevelsViewTables').DataTable();
    $(function () {
        $('[data-toggle="popover"]').popover();
    });
    function editFacilityLevelDetails(facilitylevelid, facilitylevelname, shortname, description) {
        $.confirm({
            title: 'Update Facility Level!',
            type: 'purple',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Facility Level Name</label>' +
                    '<input type="text" value="' + facilitylevelname + '" class="facilitylevelname form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Short Name</label>' +
                    '<input type="text" value="' + shortname + '" class="levelshortname form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>More Information</label>' +
                    '<textarea class="leveldescription form-control" rows="4">' + description + '</textarea>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var name = this.$content.find('.facilitylevelname').val();
                        var shortname = this.$content.find('.levelshortname').val();
                        var description = this.$content.find('.leveldescription').val();
                        if (!name) {
                            $.alert('provide a valid name');
                            return false;
                        }
                        if (!shortname) {
                            $.alert('provide a valid Short Name');
                            return false;
                        }
                        if (!description) {
                            $.alert('provide a valid Description');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {facilitylevelid: facilitylevelid, name: name, shortname: shortname, description: description},
                            url: "facilitylevelmanagement/updatefacilitylevel.htm",
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('facilitylevelmanagement/facilitylevels.htm', 'facliltyLevelContent', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                            }
                        });
                    }
                },
                cancel: function () {
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
    function facilitylevelmoreinfo(description, shortname) {
        $.confirm({
            title: 'Short Name:' + ' ' + shortname,
            content: '<b>More Info:</b>' + ' ' + description,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                close: function () {
                }
            }
        });
    }
    function deleteFacilityLevelDetails(facilitylevelid) {
        $.confirm({
            title: 'Delete Facility Level!',
            content: 'Are You Sure You Want To Delete This Facility Level?',
            type: 'purple',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes,Delete',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilitylevelid: facilitylevelid},
                            url: "facilitylevelmanagement/deletefacilitylevel.htm",
                            success: function (data, textStatus, jqXHR) {
                                var fields = data.split('-');
                                var name = fields[0];
                                var size = fields[1];
                                if (name === 'deleted') {
                                    ajaxSubmitData('facilitylevelmanagement/facilitylevels.htm', 'facliltyLevelContent', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                } else if (name === 'hasitems') {
                                    $.confirm({
                                        title: 'Delete Facility Level!',
                                        content: 'Can Not Be Delete Because Of ' + size + ' Items Attached!!!',
                                        type: 'red',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'View / Transfer Item(s)',
                                                btnClass: 'btn-red',
                                                action: function () {
                                                     $.ajax({
                                                        type: 'GET',
                                                        data: {facilitylevelid: facilitylevelid,type:'first'},
                                                        url: "facilitylevelmanagement/gettransferfacilitylevelitems.htm",
                                                        success: function (data, textStatus, jqXHR) {
                                                            $.confirm({
                                                                title: 'Attached Item(s)!',
                                                                content: '<div id="attachededfacilitylevel1ItemsTotrans">'+data+'</div>',
                                                                type: 'purple',
                                                                typeAnimated: true,
                                                                buttons: {
                                                                    close: function () {
                                                                    }
                                                                }
                                                            });
                                                        }
                                                    });
                                                }
                                            },
                                            close: function () {
                                            }
                                        }
                                    });
                                } else if (name === 'hasfacilities') {
                                    $.confirm({
                                        title: 'Delete Facility Level!',
                                        content: 'Can Not Be Delete Because Of <a class="btn btn-default" href="#!">' + size + ' Facility(ies)</a>  Attached!!!',
                                        type: 'red',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'View / Transfer',
                                                btnClass: 'btn-red',
                                                action: function () {
                                                    viewAttachedFacility(facilitylevelid);
                                                }
                                            },
                                            close: function () {

                                            }
                                        }
                                    });
                                } else {

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
    function viewAttachedFacility(facilitylevelid) {
        $.ajax({
            type: 'GET',
            data: {facilitylevelid: facilitylevelid},
            url: "facilitylevelmanagement/getfacilityieslist.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'Attached Facility!',
                    content: '<div id="remaindTransferedFacilityDiv">' + data + '</div>',
                    boxWidth: '70%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                        }
                    }
                });
            }
        });

    }
</script>