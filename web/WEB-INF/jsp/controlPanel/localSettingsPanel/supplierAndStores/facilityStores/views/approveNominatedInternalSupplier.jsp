<%-- 
    Document   : approveNominatedInternalSupplier
    Created on : Apr 23, 2018, 5:21:10 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <legend></legend>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <div class="form-group row">
                            <label class="control-label col-md-3">Select:</label>
                            <div class="col-md-8">
                                <select class="form-control col-md-8" id="approvedorunapproved"> 
                                    <option value="unapproved">Un Approved Nominated Internal Suppliers</option> 
                                    <option value="approved">Approved Nominated Internal Suppliers</option> 
                                </select>
                            </div>
                        </div><br>
                        <table class="table table-hover table-bordered" id="approveinternalsupplierstable">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Client Unit Name</th>
                                    <th>Client Short Name</th>
                                    <th>Supplier Unit Name</th>
                                    <th>Supplier Short Name</th>
                                    <th>Approve | Reject</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int j = 1;%>
                                <c:forEach items="${unapprovedinternalsupplier}" var="a">
                                    <tr id="">
                                        <td><%=j++%></td>
                                        <td>${a.facilityunitname_client}</td>
                                        <td>${a.shortname_client}</td>
                                        <td>${a.facilityunitname_supplier}</td>
                                        <td>${a.shortname_supplier}</td>
                                        <td align="center" style="width: 20%;"><div class="visible-md visible-lg hidden-sm hidden-xs">
                                                <a href="#" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Approve" onclick="approvenominatedinternalsupplier(${a.facilityunitsupplierid});"><i class="fa fa-save"></i></a>
                                                | <a href="#" class="btn btn-xs btn-green tooltips" data-placement="top" data-original-title="Reject"  onclick="rejectnominatedinternalfacilitysupplier(${a.facilityunitsupplierid});"><i class="fa fa-ban"></i></a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table><br>

                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
$('#approveinternalsupplierstable').DataTable();
function approvenominatedinternalsupplier(id) {
        $.confirm({
        title: 'Are you sure?',
        content: 'Your Approving The Request',
        type: 'purple',
        typeAnimated: true,
        buttons: {
            tryAgain: {
                text: 'Yes',
                btnClass: 'btn-purple',
                action: function(){
                  $.ajax({
                        type: 'POST',
                        data: {facilityunitsupplierid: id, type: 'approve'},
                        url: "nominateinternalfacilitySupplier/approvenominatedinternalfacilitysupplier.htm",
                        success: function (data, textStatus, jqXHR) {
                            ajaxSubmitData('nominateinternalfacilitySupplier/approvedorunapprovednominatedinternalsuppliers.htm', 'content2', 'type=unapproved&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    });   
                }
            },
            close: function () {
            }
        }
    });
}
function rejectnominatedinternalfacilitysupplier(id) {
    swal("Write Reason here:", {
        content: "input",
    })
            .then((value) => {
                if (value.length !== 0) {
                    $.ajax({
                        type: 'POST',
                        data: {facilityunitsupplierid: id, type: 'reject', reason: value},
                        url: "nominateinternalfacilitySupplier/approvenominatedinternalfacilitysupplier.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                swal("Rejected! Success Fully.!", {
                                    icon: "success",
                                });
                                ajaxSubmitData('nominateinternalfacilitySupplier/approvedorunapprovednominatedinternalsuppliers.htm', 'content2', 'type=unapproved&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        }
                    });
                }
            });
}
$('#approvedorunapproved').change(function () {
    var approvedorunapproved = $('#approvedorunapproved').val();
    if (approvedorunapproved === 'approved') {
        ajaxSubmitData('nominateinternalfacilitySupplier/approvedorunapprovednominatedinternalsuppliers.htm', 'content2', 'type=approved&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
});
</script>