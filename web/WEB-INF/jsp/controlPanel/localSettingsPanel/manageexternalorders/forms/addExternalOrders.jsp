<%-- 
    Document   : addExternalOrders
    Created on : Aug 26, 2018, 11:22:56 PM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-12">
                <form class="form-horizontal" id="add_comp">
                    <div class="form-group row">
                        <label class="control-label col-md-4">Facility Order No.:</label>
                        <div class="col-md-8">
                            <input class="form-control col-md-8 facilityordernum" type="text" value="${facilityNumber}" id="facorderno" disabled="true">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-4">Supplier:</label>
                        <div class="col-md-8">
                            <select class="form-control col-md-8 sExternalSupplier" id="selectExternalSupplier">
                                <option>--------Select-------</option>
                                <c:forEach items="${externalSuppliers}" var="suppliers">
                                    <option value="${suppliers.supplierid}">${suppliers.suppliername}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>       
                    <div class="form-group row">
                        <label class="control-label col-md-4 required">Ordering Start Date:</label>
                        <div class="col-md-8">
                            <input class="form-control col-md-8 orderingsstartDate" id="orderingstartDate" type="text" placeholder="Ordering Start Date">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-4 required">Ordering End Date:</label>
                        <div class="col-md-8">
                            <input class="form-control col-md-8 orderingsendDate" id="orderingendDate" type="text" placeholder="Ordering End Date">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-4 required">Approval Start Date:</label>
                        <div class="col-md-8">
                            <input class="form-control col-md-8 approvalsstartdate" id="approvalstartdate" type="text" placeholder="Approval Start Date">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-4 required">Approval End Date:</label>
                        <div class="col-md-8">
                            <input class="form-control col-md-8 approvalsenddate" id="approvalenddate" type="text" placeholder="Approval End Date">
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12" align="right">
                <button class="btn btn-primary" onclick="savenewfacexternalorder('${facilityNumber}');" >
                    <i class="fa fa-check-circle"></i>
                    Save
                </button>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary" href="#" data-dismiss="modal" ><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
            </div>
        </div>
    </div>
</div>
<script>
    var serverDate = '${serverdate}';
    /*--------Works on Ordering Start Date and End Date Begins------------*/
    $('#orderingstartDate').datetimepicker({
        pickTime: false,
        format: "DD/MM/YYYY",
        minDate: new Date(serverDate)
                // defaultDate: new Date()
    });

    var orderingstartDate = $('#orderingstartDate').val();
    var newdate = new Date(serverDate);
    var v = new Array();
    v = orderingstartDate.split('/');
    var dayx = v[0];
    var monthx = v[1];
    var yearx = v[2];
    var dd = newdate.setDate(dayx);
    var mm = newdate.setMonth(monthx);
    var y = newdate.setFullYear(yearx);
    var someFormattedDate = newdate.getDate() + '/' + newdate.getMonth() + '/' + newdate.getFullYear();

    $('#orderingendDate').click(function () {
        var checkorderingstartDate = $('#orderingstartDate').val();
        if (checkorderingstartDate === '') {
            $('#errorshowstart').html('<span style="color:red;">* Error Ordering Start Date Required</span>');
            $('#orderingstartDate').css('border-color', 'red');
            $("#orderingendDate").prop('disabled', true);
        } else {
            $('#errorshowstart').html('');
            $('#orderingstartDate').css('border-color', '');
            $('#orderingendDate').datetimepicker({
                pickTime: false,
                format: "DD/MM/YYYY",
                minDate: someFormattedDate
            });
        }
    });
    $('#orderingstartDate').on('change', function () {
        $('#orderingendDate').val('');
        $('#orderingendDate').css('border-color', '');
        $('#errorshow').html('');
        $("#orderingendDate").prop('disabled', false);
        $('#disablethisScheduleTable input[type=checkbox]').prop("disabled", true);
    });

    $('#orderingendDate').on('change', function () {
        var endx = $(this).val().split("/");
        var startx = $('#orderingstartDate').val().split("/");
        var datestart = new Date(startx[2], startx[1] - 1, startx[0]);
        var dateEnd = new Date(endx[2], endx[1] - 1, endx[0]);
        if (datestart.getTime() > dateEnd.getTime()) {
            //console.log(datestart.getTime() + ' greater than ' + dateEnd.getTime());
            $('#errorshow').html('<span style="color:red;">* Error Ordering End Date must be greater or Equal to Ordering Start Date</span>');
            $(this).css('border-color', 'red');
        } else if (datestart.getTime() <= dateEnd.getTime()) {
            var start = datestart,
                    end = dateEnd,
                    currentDate = new Date(start),
                    between = [];
            while (currentDate <= end) {
                between.push(new Date(currentDate).getDay());
                currentDate.setDate(currentDate.getDate() + 1);
            }
            var selectedrangedays = between;
            var uniqueselectedrangedays = [];
            $.each(selectedrangedays, function (i, item) {
                if ($.inArray(item, uniqueselectedrangedays) === -1)
                    uniqueselectedrangedays.push(item);

            });
            $(this).css('border-color', '');
            $('#errorshow').html('');
        } else {
            $('#errorshow').html('');
        }
    });

    /*--------Works on Approving Start Date and End Date Begins------------*/
    $('#approvalstartdate').datetimepicker({
        pickTime: false,
        format: "DD/MM/YYYY",
        minDate: new Date(serverDate)
                // defaultDate: new Date()approvalenddate 

    });
    var approvalstartdate = $('#approvalstartdate').val();
    var newapprovingdate = new Date(serverDate);
    var x = new Array();
    x = approvalstartdate.split('/');
    var dayx = x[0];
    var monthx = x[1];
    var yearx = x[2];
    var dds = newapprovingdate.setDate(dayx);
    var mms = newapprovingdate.setMonth(monthx);
    var ys = newapprovingdate.setFullYear(yearx);
    var someFormattedDate = newapprovingdate.getDate() + '/' + newapprovingdate.getMonth() + '/' + newapprovingdate.getFullYear();

    $('#approvalenddate').click(function () {
        var checkorderingstartDate = $('#approvalstartdate').val();
        if (checkorderingstartDate === '') {
            $('#errorshowstart').html('<span style="color:red;">* Error Approving Start Date Required</span>');
            $('#approvalstartdate').css('border-color', 'red');
            $("#approvalenddate").prop('disabled', true);
        } else {
            $('#errorshowstart').html('');
            $('#approvalstartdate').css('border-color', '');
            $('#approvalenddate').datetimepicker({
                pickTime: false,
                format: "DD/MM/YYYY",
                minDate: someFormattedDate
            });
        }
    });
    $('#approvalstartdate').on('change', function () {
        $('#approvalenddate').val('');
        $('#approvalenddate').css('border-color', '');
        $('#errorshow').html('');
        $("#approvalenddate").prop('disabled', false);
        $('#disablethisScheduleTable input[type=checkbox]').prop("disabled", true);
    });

    $('#approvalenddate').on('change', function () {
        var endx = $(this).val().split("/");
        var startx = $('#approvalstartdate').val().split("/");
        var datestart = new Date(startx[2], startx[1] - 1, startx[0]);
        var dateEnd = new Date(endx[2], endx[1] - 1, endx[0]);
        if (datestart.getTime() > dateEnd.getTime()) {
            //console.log(datestart.getTime() + ' greater than ' + dateEnd.getTime());
            $('#errorshow').html('<span style="color:red;">* Error Ordering End Date must be greater or Equal to Ordering Start Date</span>');
            $(this).css('border-color', 'red');
        } else if (datestart.getTime() <= dateEnd.getTime()) {
            var start = datestart,
                    end = dateEnd,
                    currentDate = new Date(start),
                    between = [];
            while (currentDate <= end) {
                between.push(new Date(currentDate).getDay());
                currentDate.setDate(currentDate.getDate() + 1);
            }
            var selectedrangedays = between;
            var uniqueselectedrangedays = [];
            $.each(selectedrangedays, function (i, item) {
                if ($.inArray(item, uniqueselectedrangedays) === -1)
                    uniqueselectedrangedays.push(item);
            });
            $(this).css('border-color', '');
            $('#errorshow').html('');
        } else {
            $('#errorshow').html('');
        }
    });

    function validateNumber(event) {
        var key = window.event ? event.keyCode : event.which;
        if (event.keyCode === 8 || event.keyCode === 46) {
            return true;
        } else if (key < 48 || key > 57) {
            return false;
        } else {
            return true;
        }
    }

    function savenewfacexternalorder(facilityNumber) {
        var supplierid = document.getElementById('selectExternalSupplier').value;
        var orderingstartdate = $('#orderingstartDate').val();
        var orderingenddate = $('#orderingendDate').val();
        var approvalstartdate = $('#approvalstartdate').val();
        var approvalenddate = $('#approvalenddate').val();
        
        console.log("----------------orderingstartdate----------------"+orderingstartdate);
        console.log("----------------orderingenddate----------------"+orderingenddate);
        console.log("----------------approvalstartdate----------------"+approvalstartdate);
        console.log("----------------approvalenddate----------------"+approvalenddate);
        console.log("----------------supplierid----------------"+supplierid);
        
        if (facilityNumber !== '' && orderingstartdate !== '' && orderingenddate !== '' && approvalstartdate !== '' & approvalenddate !== '') {
            $.ajax({
                type: 'POST',
                data: {newfacilityorderno: facilityNumber, orderingstartdate: orderingstartdate, orderingenddate: orderingenddate, approvalstartdate: approvalstartdate, approvalenddate: approvalenddate, supplier: supplierid},
                url: "extordersmanagement/savenewfacilityorder.htm",
                success: function (data) {
                    console.log("third");
                    console.log("----------------------data" + data);
                    if (data === "saved") {
                        window.location = '#close';
                        $.toast({
                            heading: 'Success',
                            text: 'Successfully Save !!!.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        ajaxSubmitData('extordersmanagement/manageFacilityExternalOrders', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    } else {
                    }
                    console.log("fourth");
                }, error: function (jqXHR, textStatus, errorThrown) {
                }

            });

        }
    }
</script>