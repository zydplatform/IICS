<%-- 
    Document   : readyToIssuePrescriptions
    Created on : Oct 3, 2018, 8:35:42 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp" %>
<div class="tile">
    <div class="tile-body">
        <table class="table table-hover table-bordered " id="tablereadyissues">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Patient Name</th>
                    <th>Patient No</th>
                    <th>Patient Visitno.</th>
                    <th>Prescription Items</th>
                    <th>Origin</th>
                    <th>Approved By</th>
                    <th class="right">Issue</th>
                </tr>
            </thead>
            <tbody id="">
                <% int o = 1;%>
                <c:forEach items="${readyToIssuePrescription}" var="iss">
                    <tr id="">
                        <td><%=o++%></td>
                        <td>${iss.patientname}</td>
                        <td>${iss.patientno}</td>
                        <td>${iss.visitnumber}</td>
                        <td class="center"><span class="badge badge-pill badge-success"><a onclick="functionViewPrescriptionItems(${iss.prescriptionid})" style="color: #fff" href="#">${iss.prescriptionItemsNo}</a></span></td>
                        <td>${iss.facilityunitname}</td>
                        <td>${iss.approvedby}</td>
                        <td class="center">
                            <button onclick="functionManageDispensingApprovedItems(${iss.prescriptionid})" title="Issue Prescription" class="btn btn-primary btn-sm">
                                <i class="fa fa-share"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="">
    <div id="modalPatientDrugDispensingIssue" class="manageCellDialog">
        <div class="">
            <div id="head">
                <h5 class="modal-title names" id="title"> Issuing Drugs</h5>
                <a href="#close" title="Close" class="close2">X</a>
                <hr>
            </div>
            <div class="row scrollbar" id="content">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body" id="issue-drugs-content">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#tablereadyissues').DataTable();
    });

    function functionViewPrescriptionItems(prescriptionid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "dispensing/viewfacilityunitprescriptionitems.htm",
            data: {prescriptionid: prescriptionid},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">APPROVED ITEMS.</strong>',
                    content: '' + jsonorderitemslist,
                    boxWidth: '50%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    buttons: {
                        somethingElse: {
                            text: 'OK',
                            btnClass: 'btn-purple',
                            action: function () {
                                
                            }
                        }
                    }
                });
            }
        });
    }

    function functionManageDispensingApprovedItems(prescriptionid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "dispensing/manageDispeingApprovedItems.htm",
            data: {prescriptionid: prescriptionid},
            success: function (data) {
                window.location = '#modalPatientDrugDispensingIssue';
                $('#issue-drugs-content').html(data);
                initDialog('manageCellDialog');
            }
        });
    }
</script>