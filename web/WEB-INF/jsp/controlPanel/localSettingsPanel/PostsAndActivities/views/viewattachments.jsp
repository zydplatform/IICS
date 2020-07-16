<%-- 
    Document   : viewattachments
    Created on : Jun 18, 2018, 2:44:09 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp"%>
<div class="col-md-12">
    <fieldset>
        <table class="table table-hover table-bordered col-md-12" id="transferTable">
            <thead>
                <tr>
                    <th class="center">No.</th>
                    <th class="center">Designation Name</th>
                    <th class="center">Previous Designation Category</th>
                    <th class="center">Transfer Date</th>
                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_RESTORELOCALRANSFEREDDESIGNATIONS')">
                        <th class="center">Manage Designations</th>
                        </security:authorize>
                </tr>
            </thead>
            <tbody class="col-md-12" id="domaindesignation">
                <% int u = 1;%>
                <% int y = 1;%>
                <c:forEach items="${TransferDesignationLists}" var="t">
                    <tr id="${t.designationid}">
                        <td class="center"><%=u++%></td>
                        <td class="center">${t.designationname}</td>
                        <td class="center">${t.categoryname}</td>
                        <td class="center hidedisplaycontent" id="desigCatid${t.designationid}">${t.designationcategoryid}</td>
                        <td class="center">${t.dateupdated}</td>
                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_RESTORELOCALRANSFEREDDESIGNATIONS')">
                            <td class="center">
                                <a class="btn btn-sm btn-success ${t.designationid}" id="${t.designationid}" data-name="${t.categoryname}" data-id="${t.designationname}"  data-ids="${t.designationid}" data-ided="${t.transferstatus}" data-status="Restore Designation" onclick="restore(${t.designationid}, this.id, $(this).attr('data-id'), $(this).attr('data-ided'), $(this).attr('data-name'))" href="#"><span id="schstatus${t.designationid}">Restore Designation</span></a>
                            </td>
                        </security:authorize>
                    </tr>
                </c:forEach>
            </tbody>
        </table>  
    </fieldset>
</div>
<script>
    $('#transferTable').DataTable();
    function restore(desigCatid, designationid, designationname, transferstatus, categoryname) {
        var value = document.getElementById('desigCatid' + desigCatid).innerHTML;

        $.confirm({
            title: 'Restore/Transfer Designations!',
            buttons: {
                Restore: {
                    text: 'Restore',
                    btnClass: 'btn-green',
                    action: function () {
                        var designationsCatid = parseInt(value);
                        console.log("designationid" + designationid);
                        console.log("designationname" + designationname);
                        console.log("designationsCatid" + designationsCatid);
                        $.ajax({
                            type: 'POST',
                            url: "localsettingspostsandactivities/restoredesigs.htm",
                            data: {designationcategoryid: designationsCatid, designationid: designationid, designationname: designationname},
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('localsettingspostsandactivities/viewtranferreddesignations.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }

                        });
                        $.alert('Successfully Restored' + '<strong>' + ' ' + designationname + ' ' + '</strong>' + 'To Previous Designation Category' + '<strong>' + ' ' + categoryname + ' ' + '</strong>' + '!');
                    }
                },
                Transfer: {
                    text: 'Transfer',
                    btnClass: 'btn-blue',
                    keys: ['enter', 'shift'],
                    action: function () {

                        $.ajax({
                            type: "GET",
                            cache: false,
                            url: "localsettingspostsandactivities/transferPosts.htm",
                            data: {designationname: designationname, designationid: designationid, designationcategoryid: value, categoryname: categoryname},
                            success: function (data) {
                                $.confirm({
                                    title: '<strong class="center">Transfer Posts' + '</strong>',
                                    content: '' + data,
                                    boxWidth: '40%',
                                    useBootstrap: false,
                                    type: 'purple',
                                    typeAnimated: true,
                                    closeIcon: true

                                });
                            }
                        });

//                        var jsoncategory = ${jsontransferdesigcategory}
//
//                        for (var x in jsoncategory) {
//                            var datashow = jsoncategory[x];
//                            $('#showOptions').append('<option value="' + datashow.designationcategoryid + '">' + datashow.categoryname + '</option>');
//                        }
//                        var showdialogcontent = $('#showOndialog').html();
//                        $.confirm({
//                            title: 'Transfer Designations!',
//                            content: '' +
//                                    '<form action="" class="formName">' +
//                                    '<div class="form-group">' +
//                                    '<label>Designation Name</label>' +
//                                    '<input type="text" id="designationname" value="' + designationname + '" class="type form-control" required readonly="true"/>' +
//                                    '</div>' +
//                                    '<div class="form-group">' +
//                                    '<label>Select Designation Category</label>' +
//                                    '<select class="form-control new_search" id="selectdesignationCat">' +
//                                    '<option>-----Select Designation Category-----</option>' +
//                                    '<div>' + showdialogcontent + '</div>' +
//                                    '</select>' +
//                                    '<input placeholder="Classification Name" id="designationid" value="' + designationid + '" class="name form-control" type="hidden" required />' +
//                                    '</div>' +
//                                    '</form>',
//                            buttons: {
//                                formSubmit: {
//                                    text: 'Save',
//                                    btnClass: 'btn-green',
//                                    action: function () {
//                                        
//                                    }
//                                },
//                                cancel: {
//                                    text: 'Cancel',
//                                    btnClass: 'btn-red',
//                                    action: function () {
//                                    }
//                                }
//                            },
//                            onContentReady: function () {
//                                // bind to events
//                                var jc = this;
//                                this.$content.find('form').on('submit', function (e) {
//                                    // if the user submits the form by pressing enter in the field.
//                                    e.preventDefault();
//                                    jc.$$formSubmit.trigger('click'); // reference the button and click it
//                                });
//                            }
//                        });
                    }
                },
                cancel: {
                    text: 'Cancel',
                    btnClass: 'btn-red',
                    action: function () {
                        $.alert('Restoration/Transfer Cancelled!');
                    }
                }
            }
        });


    }
</script>