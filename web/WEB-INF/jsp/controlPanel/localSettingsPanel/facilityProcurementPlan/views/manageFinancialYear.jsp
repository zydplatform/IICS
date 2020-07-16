<%-- 
    Document   : manageFinancialYear
    Created on : Sep 28, 2018, 4:24:33 PM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<div id="updatingFacilityFinancilYearsDid">
    <div style="margin: 10px;">
        <fieldset style="min-height:100px;">
            <div class="row">
                <div class="col-md-6">
                    <div class="tile">
                        <div class="tile-body">
                            <form >
                                <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">START & END DATE</span></div><br>
                                <div class="form-group bs-component">
                                    <span class="control-label pat-form-heading patientConfirmFont" for=""><strong style="font-size: 14px; margin-left: 10px;">START DATE:</strong></span>&nbsp;
                                    <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-fname">${financialyearstartdate}</strong></span>

                                </div>
                                <div class="form-group bs-component">
                                    <span class="control-label pat-form-heading patientConfirmFont" for=""><strong style="font-size: 14px; margin-left: 10px;">END DATE:</strong></span>&nbsp;
                                    <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-lname">${financialyearenddate}</strong></span>

                                </div><br>
                                <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">PROCURING DATES</span></div><br>

                                <div class="form-group bs-component">
                                    <span class="control-label pat-form-heading patientConfirmFont" for=""><strong style="font-size: 14px; margin-left: 10px;">OPEN DATE:</strong></span>&nbsp;
                                    <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-fname">${procuringopendate}</strong></span>
                                    <span><a href="#" onclick="functionEditOpen('${procuringopendate}',${facilityfinancialyearid}, '${financialyearstartdate}')"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                                </div>
                                <div class="form-group bs-component">
                                    <span class="control-label pat-form-heading patientConfirmFont" for=""><strong style="font-size: 14px; margin-left: 10px;">CLOSE DATE:</strong></span>&nbsp;
                                    <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-fname">${procuringclosedate}</strong></span>
                                    <span><a href="#" onclick="functionEditClose('${procuringclosedate}',${facilityfinancialyearid}, '${financialyearstartdate}', '${procuringopendate}')"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                                </div>
                                <div class="tile-footer"></div>
                            </form>  
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="tile">
                        <div class="tile-body">
                            <form >
                                <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">APPROVAL DATES</span></div><br>

                                <div class="form-group bs-component">
                                    <span class="control-label pat-form-heading patientConfirmFont" for=""><strong style="font-size: 14px; margin-left: 10px;">START DATE:</strong></span>&nbsp;
                                    <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-fname">${approvalopendate}</strong></span>
                                    <span><a href="#" onclick="functionEditAStart('${approvalopendate}',${facilityfinancialyearid}, '${procuringclosedate}', '${financialyearstartdate}')"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                                </div>
                                <div class="form-group bs-component">
                                    <span class="control-label pat-form-heading patientConfirmFont" for=""><strong style="font-size: 14px; margin-left: 10px;">END DATE:</strong></span>&nbsp;
                                    <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-fname">${approvalclosedate}</strong></span>
                                    <span><a href="#" onclick="functionEditAEnd('${approvalclosedate}',${facilityfinancialyearid}, '${approvalopendate}', '${financialyearstartdate}')"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                                </div><br>

                                <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">APPROACH</span></div><br>

                                <div class="form-group bs-component">
                                    <span class="control-label pat-form-heading patientConfirmFont" for=""><strong style="font-size: 14px; margin-left: 10px;">APPROACH:</strong></span>&nbsp;
                                    <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-fname">${istopdownapproach}</strong></span>
                                    <span><a href="#" onclick="functionEditA(${facilityfinancialyearid}, '${istopdownapproachs}')"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                                </div>
                                <div class="tile-footer"></div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
    </div>   
</div>
<script>
    function functionEditOpen(procuringopendate, facilityfinancialyearid, financialyearstartdate) {
        $.confirm({
            title: 'UPDATE PROCURING START DATE',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>START DATE</label>' +
                    '<input type="text"  onfocus="updatefinancialyrStartDate(this.value,\'' + financialyearstartdate + '\');" class="updatestartdate form-control" value="' + procuringopendate + '" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var procuringdate = this.$content.find('.updatestartdate').val();
                        if (!procuringdate) {
                            $.alert('provide a valid Date');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'procuringopen', startdate: procuringdate, facilityfinancialyearid: facilityfinancialyearid},
                            url: "facilityprocurementplanmanagement/updatefacilityfinancialyeardates.htm",
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('facilityprocurementplanmanagement/managefacilityfinancialyear.htm', 'updatingFacilityFinancilYearsDid', 'facilityfinancialyearid=' + facilityfinancialyearid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {

                }
            }
        });
    }
    function updatefinancialyrStartDate(procuringopendate, financialyearstartdate) {
        $('.updatestartdate').datetimepicker({
            pickTime: false,
            format: "DD/MM/YYYY",
            maxDate: new Date(financialyearstartdate),
            defaultDate: new Date(procuringopendate)
        });
    }
    function functionEditClose(procuringclosedate, facilityfinancialyearid, financialyearstartdate, procuringopendate) {
        $.confirm({
            title: 'UPDATE PROCURING END DATE',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>END DATE</label>' +
                    '<input type="text"  onfocus="updatefinancialyrEndDate(\'' + procuringopendate + '\',this.value,\'' + financialyearstartdate + '\');" class="updateenddate form-control" value="' + procuringclosedate + '" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var procuringenddate = this.$content.find('.updateenddate').val();
                        if (!procuringenddate) {
                            $.alert('provide a valid Date');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'procuringclose', closedate: procuringenddate, facilityfinancialyearid: facilityfinancialyearid},
                            url: "facilityprocurementplanmanagement/updatefacilityfinancialyeardates.htm",
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('facilityprocurementplanmanagement/managefacilityfinancialyear.htm', 'updatingFacilityFinancilYearsDid', 'facilityfinancialyearid=' + facilityfinancialyearid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {

                }
            }
        });
    }
    function updatefinancialyrEndDate(procuringopendate, value, financialyearstartdate) {
        $('.updateenddate').datetimepicker({
            pickTime: false,
            format: "DD/MM/YYYY",
            maxDate: new Date(financialyearstartdate),
            minDate: new Date(procuringopendate),
            defaultDate: new Date(value)
        });
    }
    function functionEditAStart(approvalopendate, facilityfinancialyearid, procuringclosedate, financialyearstartdate) {
        $.confirm({
            title: 'UPDATE APPROVAL START DATE',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>START DATE</label>' +
                    '<input type="text"  onfocus="updatefinancialyrApprovalStartDate(\'' + procuringclosedate + '\',this.value,\'' + financialyearstartdate + '\');" class="updateapprovalstartdate form-control" value="' + approvalopendate + '" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var approvalstartdate = this.$content.find('.updateapprovalstartdate').val();
                        if (!approvalstartdate) {
                            $.alert('provide a valid Date');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'approvalstartdate', startdate: approvalstartdate, facilityfinancialyearid: facilityfinancialyearid},
                            url: "facilityprocurementplanmanagement/updatefacilityfinancialyeardates.htm",
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('facilityprocurementplanmanagement/managefacilityfinancialyear.htm', 'updatingFacilityFinancilYearsDid', 'facilityfinancialyearid=' + facilityfinancialyearid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {

                }
            }
        });
    }
    function updatefinancialyrApprovalStartDate(procuringclosedate, value, financialyearstartdate) {
        $('.updateapprovalstartdate').datetimepicker({
            pickTime: false,
            format: "DD/MM/YYYY",
            maxDate: new Date(financialyearstartdate),
            minDate: new Date(procuringclosedate),
            defaultDate: new Date(value)
        });
    }
    function functionEditAEnd(approvalclosedate, facilityfinancialyearid, approvalopendate, financialyearstartdate) {
        $.confirm({
            title: 'UPDATE APPROVAL END DATE',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>END DATE</label>' +
                    '<input type="text"  onfocus="updatefinancialyrApprovalEndDate(\'' + approvalopendate + '\',this.value,\'' + financialyearstartdate + '\');" class="updateapprovalenddate form-control" value="' + approvalclosedate + '" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var approvalenddate = this.$content.find('.updateapprovalenddate').val();
                        if (!approvalenddate) {
                            $.alert('provide a valid Date');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'approvalenddate', enddate: approvalenddate, facilityfinancialyearid: facilityfinancialyearid},
                            url: "facilityprocurementplanmanagement/updatefacilityfinancialyeardates.htm",
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('facilityprocurementplanmanagement/managefacilityfinancialyear.htm', 'updatingFacilityFinancilYearsDid', 'facilityfinancialyearid=' + facilityfinancialyearid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {

                }
            }
        });
    }
    function updatefinancialyrApprovalEndDate(approvalopendate, value, financialyearstartdate) {
        $('.updateapprovalenddate').datetimepicker({
            pickTime: false,
            format: "DD/MM/YYYY",
            maxDate: new Date(financialyearstartdate),
            minDate: new Date(approvalopendate),
            defaultDate: new Date(value)
        });
    }
    function functionEditA(facilityfinancialyearid, istopdownapproachs) {
        $.confirm({
            title: 'UPDATE APPROACH',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '<label class="control-label">APPROACH</label>' +
                    '<select class="form-control" id="selectapproachproc">' +
                    '<option value="top">Top Down</option>' +
                    '<option value="bottom">Bottom Up</option>' +
                    '</select>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                      var approach = $('#selectapproachproc').val();
                        if (!approach) {
                            $.alert('provide a valid Approach');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'approach', approach: approach, facilityfinancialyearid: facilityfinancialyearid},
                            url: "facilityprocurementplanmanagement/updatefacilityfinancialyeardates.htm",
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('facilityprocurementplanmanagement/managefacilityfinancialyear.htm', 'updatingFacilityFinancilYearsDid', 'facilityfinancialyearid=' + facilityfinancialyearid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });   
                    }
                },
                close: function () {

                }
            }
        });
    }
</script>