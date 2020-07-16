<%--
    Document   : approvePrescription
    Created on : Sep 19, 2018, 2:37:36 AM
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp" %>
<div class="row">
    <div class="col-sm-12 col-md-12">
        <table class="table table-hover table-bordered " id="tableRegisteredPatients">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Item Name</th>
                    <th>Dosage</th>
                    <th>Duration</th>
                    <th>Active Dosage</th>
                    <th class="center">Qty To Issue</th>
                    <th class="center">Include</th>
                </tr>
            </thead>
            <tbody id="">
                <% int x = 1;%>
                <c:forEach items="${patientPrescriptionList}" var="des">
                    <tr id="">
                        <td><%=x++%></td>
                        <td>${des.itemname}</td>
                        <td>${des.dosage}</td>
                        <td>${des.days}</td>
                        <td>${des.dose}</td>
                        <td class="center" ><strong id="quantityApprovedToIssue${des.itemid}">NOT SET</strong></td>
                        <td class="center"><input id="itemcheckbox${des.itemid}" onclick="functionManagePrescriptionItem(${des.itemid}, ${des.prescriptionitemsid})" class="form-check-input" type="checkbox" name="prescriptioncheckboxname" value="" data-prescriptionitemid="${des.prescriptionitemsid}" data-itemid="${des.itemid}"></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="col-md-12 right" style="font-size: 110%;">
    <span class="text-bold-500">
        <i class="">Prescribed By: </i>
        <span class="badge badge-patientinfo">${prescriber}</span>
    </span>&nbsp;&nbsp;&nbsp;
    <span class="text-bold-500">
        <i class="">Prescription Unit: </i>
        <span class="badge badge-patientinfo">${facilityunitname}</span>
    </span>
</div>
<div class="col-md-12 right"><hr/>
    <button id="btnSaveApprovedPrescriptions" class="btn btn-primary" type="button"><i class="fa fa-floppy-o"></i>Approve Qty To Issue</button>
</div>

<script>
    var qtyapprovedtoissueList = [];
    var tableNumberItems = ${patientPrescriptionListsize};
    var patientprescriptionid = ${prescriptionid};

    $(document).ready(function () {
        breadCrumb();
        $('#btnSaveApprovedPrescriptions').click(function () {
            var qtyapprovedtoissueList = [];
            var checkedBoxNumber = $("input:checkbox:checked").length;

            if (parseInt(checkedBoxNumber) === 0) {
                $.confirm({
                    icon: 'fa fa-warning',
                    title: '<strong>Alert: <font color="red">Can not proceed!</font></strong>',
                    content: '' + '<strong style="font-size: 18px;"><font color="red">Please tick and approve quantities to issue.</font></strong>',
                    boxWidth: '30%',
                    useBootstrap: false,
                    type: 'red',
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

            if (parseInt(checkedBoxNumber) === parseInt(tableNumberItems)) {
                document.getElementById("btnSaveApprovedPrescriptions").disabled = true;
                $.each($("input[name='prescriptioncheckboxname']:checked"), function () {
                    var itempackageid = $(this).val();
                    var prescriptionitemidd = $(this).data('prescriptionitemid');
                    var itemid = $(this).data('itemid');
                    var qtyapprovetoissuee = $('#quantityApprovedToIssue' + itemid).text();

                    qtyapprovedtoissueList.push({itempackageid: itempackageid, prescriptionitemid: prescriptionitemidd, qtyapprovetoissuee: qtyapprovetoissuee});
                });

                $.ajax({
                    type: 'GET',
                    data: {patientprescriptionid: patientprescriptionid, qtyapprovedtoissueList: JSON.stringify(qtyapprovedtoissueList)},
                    url: 'dispensing/submitApprovedPrescriptions.htm',
                    success: function (item) {
                        ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                });
            }

            if (parseInt(checkedBoxNumber) < parseInt(tableNumberItems) && parseInt(checkedBoxNumber) !== 0) {
                //some items not included
                $.confirm({
                    icon: 'fa fa-warning',
                    title: '<strong><font color="red">Warning!</font></strong>',
                    content: '' + '<strong style="font-size: 18px;"><font color="">Some Prescribed Items have not been included.<br> <span style="color:red; font-size: 22px"> Are you sure you want to Continue?</span></font></strong>',
                    boxWidth: '30%',
                    useBootstrap: false,
                    type: 'red',
                    typeAnimated: true,
                    closeIcon: true,
                    buttons: {
                        somethingElse: {
                            text: 'Yes',
                            btnClass: 'btn-purple',
                            action: function () {
                                document.getElementById("btnSaveApprovedPrescriptions").disabled = true;
                                $.each($("input[name='prescriptioncheckboxname']:checked"), function () {
                                    var itempackageid = $(this).val();
                                    var prescriptionitemidd = $(this).data('prescriptionitemid');
                                    var itemid = $(this).data('itemid');
                                    var qtyapprovetoissuee = $('#quantityApprovedToIssue' + itemid).text();

                                    qtyapprovedtoissueList.push({itempackageid: itempackageid, prescriptionitemid: prescriptionitemidd, qtyapprovetoissuee: qtyapprovetoissuee});
                                });

                                $.ajax({
                                    type: 'GET',
                                    data: {patientprescriptionid: patientprescriptionid, qtyapprovedtoissueList: JSON.stringify(qtyapprovedtoissueList)},
                                    url: 'dispensing/submitApprovedPrescriptions.htm',
                                    success: function (item) {
                                        ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
                                });
                            }
                        },
                        No: {
                            text: 'NO',
                            btnClass: 'btn-red',
                            action: function () {

                            }
                        }
                    }
                });
            }
        });
    });

    function functionApprovePrescriptions(itempackageid, itemid) {
        $('#itemcheckbox' + itemid).prop('checked', false);
        $('.hiddenPrescInputs').hide();
        $('#approveInputfield' + itempackageid).val('');
        $('#approvePrescription' + itempackageid).show();
    }

    function functionManagePrescriptionItem(itemid, prescriptionitemsid) {
        var checkBox = document.getElementById("itemcheckbox" + itemid);
        if (checkBox.checked === true) {
            $('#itemcheckbox' + itemid).prop('checked', false);
            $.ajax({
                type: 'GET',
                data: {itemid: itemid, prescriptionitemsid: prescriptionitemsid},
                url: 'dispensing/managePrescribedDrug.htm',
                success: function (report) {
                    $.confirm({
                        title: 'Approve Drugs',
                        content: '' + report,
                        type: 'purple',
                        boxWidth: '90%',
                        useBootstrap: false,
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Submit',
                                btnClass: 'btn-purple',
                                action: function () {
                                   
                                }
                            },
                            close: function () {
                                $('#itemcheckbox' + itemid).prop('checked', false);
                            }
                        }
                    });
                }
            });
        } else {
            $('#quantityApprovedToIssue' + itemid).text('NOT SET');
        }
    }

    function functionvalidatedenteredqtys(itemPackageId, itemid) {
        var approvdqty2 = parseInt($('#approveInputfield' + itemPackageId).val());
        if (!$("input[name='packageitemsoptions']:checked").val()) {
            $('#itemcheckbox' + itemid).prop('checked', false);
            $('#errorwronginput' + itemPackageId).hide();
            $('#erroremptyfield' + itemPackageId).show();
            return false;
        } else {
            var itemPackageId = $("input[name='packageitemsoptions']:checked").val();
            var approveInput = $('#approveInputfield' + itemPackageId).val();
            $('#approveInputfield' + itemPackageId).css({"border": '2px solid #ced4da'});
            $('#erroremptyfield' + itemPackageId).hide();

            if (approveInput === null || approveInput === '' || typeof approveInput === 'undefined') {
                $('#itemcheckbox' + itemid).prop('checked', false);
                $('#approveInputfield' + itemPackageId).css({"border": '2px solid #ba0713'});
                $('#errorwronginput' + itemPackageId).hide();
                $('#erroremptyfield' + itemPackageId).show();
                $('#shelvedstock' + itemPackageId).css("color", "black");
                return false;
            } else {
                $('#erroremptyfield' + itemPackageId).hide();
                var shelvedstock = $('#shelvedstockvalue' + itemPackageId).val();
                $('#approveInputfield' + itemPackageId).css({"border": '2px solid #ced4da'});
                if (parseInt($('#approveInputfield' + itemPackageId).val()) > shelvedstock) {
                    $('#erroremptyfield' + itemPackageId).hide();

                    //reduce shelved stock
                    $('#shelvedstock' + itemPackageId).text((shelvedstock - approvdqty2).toLocaleString());
                    $('#shelvedstock' + itemPackageId).css("color", "red");
                    $('#errorwronginput' + itemPackageId).show();
                    $('#itemcheckbox' + itemid).prop('checked', false);
                    return false;
                } else {
                    $('#shelvedstock' + itemPackageId).text((shelvedstock - approvdqty2).toLocaleString());
                    $('#shelvedstock' + itemPackageId).css("color", "blue");
                    $('#quantityApprovedToIssue' + itemid).text($('#approveInputfield' + itemPackageId).val());
                    $('#itemcheckbox' + itemid).prop('checked', true);
                    $('#itemcheckbox' + itemid).val($("input[name='packageitemsoptions']:checked").val());
                }
            }
        }
    }
</script>
