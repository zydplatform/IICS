<%-- 
    Document   : transferStaff
    Created on : Apr 10, 2019, 4:07:22 PM
    Author     : user
--%>

<%@include file="../../../../include.jsp"%>
<fieldset><legend>Select Location to Transfer Staff too </legend>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group row">
                <label class="control-label col-md-4">Select Designation Category</label>
                <div class="col-md-6">
                    <select class="form-control" id="selectdesignationCats" name="selectdesignationCats">
                        <option value="0">--Select Designation Category--</option>
                        <c:forEach items="${desigcategoryz}" var="u">                                
                            <option value="${u.designationcategoryid}">${u.categoryname}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group row">
                <label class="control-label col-md-4">Select Post</label>
                <div class="col-md-6">
                    <select class="form-control" id="selectdesignationCats" name="selectdesignationCats">
                        <option value="0">--Select Post--</option>
                        <c:forEach items="${DesignationLists}" var="u">                                
                            <option value="${u.designationcategoryid}">${u.categoryname}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
    </div>
    
    

<table class="table table-hover table-bordered" id="stafftable">
    <thead>
        <tr>
            <th>No</th>
            <th>Staff Name</th>
            <th>Select</th>
        </tr>
    </thead>
    <tbody id="deletedTableDatadiv">
        <% int k = 1;%>
        <c:forEach items="${stafflists}" var="m">
            <tr>
                <td><%=k++%></td>
                <td><a onclick="viewstaffdetails(${m.staffid},${m.personid})"><font color="blue">${m.firstname}&nbsp;${m.lastname}&nbsp;${m.othernames}</font></a></td>
                <td align="center">
                    <input type="checkbox" value="${m.staffid}" onchange="if (this.checked) {
                                checkedorUncheckedStaffTransfer(this.value, 'checked');
                            } else {
                                checkedorUncheckedStaffTransfer(this.value, 'unchecked');
                            }">
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
        <br>
 <div class="row">
    <div class="col-md-10"></div>
    <div class="col-md-2">
        <button style="display: none;" onclick="transferStaffSel(${staffid});" id="transfertableRowdiv" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i><strong id="tranfertextnumber">Transfer</strong></button>
    </div>
</div>        
                            
      </fieldset>                            
                            
                            
    <script>
    $('#stafftable').DataTable();
    var transferset = new Set();
    // $('#facilitylevelfacilitydtailsTable').DataTable();
    function checkedorUncheckedStaffTransfer(staffid, type) {
        if (type === 'checked') {
            transferset.add(staffid);
        } else {
            transferset.delete(staffid);
        }
        if (transferset.size > 0) {
            document.getElementById('tranfertextnumber').innerHTML = 'Transfer(' + transferset.size + ')';
            document.getElementById('transfertableRowdiv').style.display = 'block';
        } else {
            document.getElementById('transfertableRowdiv').style.display = 'none';
        }
    }
    
    function viewstaffdetails(staffid,personid) {
        $.ajax({
            type: 'GET',
            data: {staffid: staffid,personid: personid},
            url: "viewstaffdetails.htm",
            success: function (respose) {
                $.confirm({
                    title: '<strong class="center">More Info' + '<font color="green"></font>' + '</strong>',
                    content: '' + respose,
                    boxWidth: '30%',
                    height: '100%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    draggable: true
                });
            }
        });
    }
    
  function transferStaffSel(staffid) {
        var destinationid = $('#selectdestinationstaff').val();
        var destinationname = $('#Staffdesigntrans' + destinationid).data('name');
        
        $.confirm({
            title: 'Transfer <a href="#!">' + transferset.size + 'Staff(s)</a> ?',
            content: 'Are You Sure You Want To Transfer Staff to <a href="#!">' + destinationname + ' ' + '' + ' ' + '</a> ?',
            type: 'purple',
            typeAnimated: true,
            buttons: {
             tryAgain: {
                    text: 'Yes,Transfer',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {destinationid: destinationid, facilityids: JSON.stringify(Array.from(transferset)), staffid: staffid},
                            url: "postsandactivities/transferStaffD.htm",
                            success: function (data, textStatus, jqXHR) {
                                var fields = data.split('-');
                                var name = fields[0];
                                var size = fields[1];
                                if (name === 'hasstaff') {
                                    $.confirm({
                                        title: 'Transfered!',
                                        content: 'Transfered Success Fully',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                               ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'content', '&uni', 'GET');
                                            }
                                        }
                                    });

                                }
                             else if (name === 'delete') {
                                    $.confirm({
                                        title: 'Delete Designation!',
                                        content: 'Now Designation Has No Attached Staff, Do You Still Want To Delete Designation?',
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
                                                        url: "postsandactivities/deleteDesignation.htm",
                                                        success: function (data, textStatus, jqXHR) {
                                                            var fields = data.split('-');
                                                            var names = fields[0];
                                                            var size = fields[1];
                                                            if (names === 'deleted') {
                                                                document.getElementById('deletedTableDatadiv').innerHTML = '';
                                                                document.getElementById('transfertableRowdiv').style.display = 'none';
                                                               ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'content', '&uni', 'GET');
                                                            } else {
                                                                $.confirm({
                                                                    title: 'Encountered an error!',
                                                                    content: 'Something went Wrong, Try Again!!!',
                                                                    type: 'red',
                                                                    icon: 'fa fa-warning',
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
                                            close: function () {
                                            }
                                        }
                                    });
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
    
      $('#searchdesignationCat').click(function () {
            $.ajax({
                type: 'POST',
                url: 'localsettingspostsandactivities/fetchDesigCats.htm',
                success: function (data) {
                    var res = JSON.parse(data);
                    if (res !== '' && res.length > 0) {
                        for (i in res) {
                            $('#searchdesignationCat').append('<option class="textbolder" id="' + res[i].designationcategoryid + '" data-categoryname="' + res[i].categoryname + '" value="' + res[i].designationcategoryid + '">' + res[i].categoryname + '</option>');
                        }
                        var designationcategoryid = parseInt($('#searchdesignationCat').val());
                        $.ajax({
                            type: 'POST',
                            url: 'localsettingspostsandactivities/fetchDesigCatPosts.htm',
                            data: {designationcategoryid: designationcategoryid},
                            success: function (data) {
                                var res = JSON.parse(data);
                                if (res !== '' && res.length > 0) {
                                    for (i in res) {
                                        $('#searchdesignations').append('<option class="classpost" id="' + res[i].designationid + '" value="' + res[i].designationid + '" data-designationname="' + res[i].designationname + ' ">' + res[i].designationname + '</option>');
                                    }
                                }
                            }
                        });
                    }
                }
            });

            $('#searchdesignationCat').change(function () {
                $('#searchdesignations').val(null).trigger('change');
                var designationcategoryid = parseInt($('#searchdesignationCat').val());
                $.ajax({
                    type: 'POST',
                    url: 'localsettingspostsandactivities/fetchDesigCatPosts.htm',
                    data: {designationcategoryid: designationcategoryid},
                    success: function (data) {
                        var res = JSON.parse(data);
                        if (res !== '' && res.length > 0) {
                            $('#searchdesignations').html('');
                            for (i in res) {
                                $('#searchdesignations').append('<option class="classpost" id="' + res[i].designationid + '" value="' + res[i].designationid + '" data-designationname="' + res[i].designationname + ' ">' + res[i].designationname + '</option>');
                            }
                        }
                    }
                });
            });
        });
</script>