<%-- 
    Document   : donationsPane
    Created on : Sep 1, 2018, 11:44:44 PM
    Author     : SAMINUNU
--%>

<%@include file="../../../../include.jsp" %>
<!--<div class="tabsSec">
    <div class="tabsnew row" style="background: #ffffffe6 !important;">
        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-1" checked class="tab-switch">
            <label for="tab-1" class="tab-label">Medicines & Supplies</label>
            <div class="tab-content">-->
<fieldset>
    <div class="tile">
        <div class="row">
            <div class="col-md-12 col-sm-12 right" id="handOverBtnDiv">
                <button class="btn btn-sm btn-primary icon-btn" onclick="handOverDonatedItems()">
                    <i class="fa fa-fw fa-lg fa-handshake-o"></i>
                    Hand Over
                </button>
            </div>
        </div>
        <div class="tile-body row">
            <table class="table table-hover table-bordered col-md-12" id="transferDonationsTable">
                <thead class="col-md-12">
                    <tr>
                        <th class="center">No</th>
                        <th class="">Donor Name</th>
                        <th>Item Name</th>
                        <th class="">Batch No.</th>
                        <th class="">Expiry Date</th>
                        <th class="right">Quantity</th>
                        <th class="center">Hand Over</th>
                    </tr>
                </thead>
                <tbody class="col-md-12">
                    <% int y = 1;%>
                    <c:forEach items="${donorList}" var="d">
                        <c:if test="${d.qtydonatednocommas > 0}">
                            <tr id="${d.donationsitemsid}">
                                <td class="center"><%=y++%></td>
                                <td class="">${d.donorname}</td>
                                <td class="">${d.packagename}</td>
                                <td class="">${d.batchno}</td>
                                <td class="">${d.expirydate}</td>
                                <td class="right">${d.qtydonated}</td> 
                                <td class="center">
                                    <input class="form-check-input" type="checkbox" onclick="transferMedicines(${d.donationsitemsid})">
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</fieldset>
<!--            </div>-->
<!--        </div>-->
<!--        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-2" class="tab-switch">
            <label for="tab-2" class="tab-label">Others </label>
            <div class="tab-content" id="transferOtherItems" style="margin-left: -15%">

            </div>
        </div>
    </div>
</div>-->
<!--model Manage Order Items-->
<!--<div class="">
    <div id="modalDonateditems" class="shelveItemDialog">
        <div class="">
            <div id="head">
                <h3 class="modal-title" id="title"><font color="purple">Donation Transfer Processing...</font></h3>
                <a href="#close" title="Close" class="close2">X</a>
                <hr>
            </div>
            <div class="scrollbar row" id="content">
                
            </div>
        </div>
    </div>
</div>-->
<div class="row">
    <div class="col-md-12">
        <div id="modalDonateditems" class="shelveItemDialog">
            <div>
                <div id="divSection3">
                    <div id="head">
                        <h3 class="modalDialog-title"><font color="purple">Donation Transfer Processing...</font></h3>
                        <a href="#close" title="Close" class="close2">X</a>
                    </div>
                    <div class="row scrollbar" id="content" style="height: 561px;">
                        <%@include file="handOver.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#transferDonationsTable').DataTable();
    var selectedItems = new Set();
    var allDonatedItems = [];
    $('#handOverBtnDiv').hide();

    $('.close2').click(function () {
        //  selectedItems.clear();
        $('#handoverTableContent').html('');
    });

    function transferMedicines(donationsitemsid) {
        if (!selectedItems.has(donationsitemsid)) {
            selectedItems.add(donationsitemsid);
            $('#handOverBtnDiv').show();
        } else {
            selectedItems.delete(donationsitemsid);

            if (selectedItems.size < 1) {
                $('#handOverBtnDiv').hide();
            }
        }
    }

    function handOverDonatedItems() {
        window.location = '#modalDonateditems';
        initDialog('shelveItemDialog');
        allDonatedItems = ${donatedItemsJSON};
        console.log(allDonatedItems);

        var donatedItems = Array.from(selectedItems);
        for (i in donatedItems) {
            for (j in allDonatedItems) {
                if (allDonatedItems[j].donationsitemsid === donatedItems[i]) {
                    $('#handoverTableContent').append(
                            '<tr id="pre' + allDonatedItems[j].donationsitemsid + '">' +
                            '<td style="display: none">' + allDonatedItems[j].itemid + '</td>' +
                            '<td>' + allDonatedItems[j].packagename + '</td>' +
                            '<td>' + allDonatedItems[j].batchno + '</td>' +
                            '<td>' + allDonatedItems[j].expirydate + '</td>' +
                            '<td style="display:none">' + allDonatedItems[j].donorrefno + '</td>' +
                            '<td style="display:none">' + allDonatedItems[j].donorprogramid + '</td>' +
                            '<td class="left"><input type="hidden" id="itmpicked2DD" value="DD"/><font color="blue" class=""><b>' + allDonatedItems[j].qtydonated + '</b></font></td>' +
                            '<td class="center"><input  oninput="compareEnteredToDonatedItems(' + allDonatedItems[j].donationsitemsid + ',' + allDonatedItems[j].qtydonatednocommas + ')" id="itmqtydonated2' + allDonatedItems[j].donationsitemsid + '" data-id="' + allDonatedItems[j].donationsitemsid + '" data-qtydonatednocommas="' + allDonatedItems[j].qtydonatednocommas + '"data-donorprogramid="' + allDonatedItems[j].donorprogramid + '"data-donorrefno="' + allDonatedItems[j].donorrefno + '" name="' + allDonatedItems[j].itemid + '" data-expiry="' + allDonatedItems[j].expirydate + '" data-batchno="' + allDonatedItems[j].batchno + '" class="form-control form-control-sm itemdonatedquantities" value="" type="number" min="0" max=""/><medium id="donateditmerrormessage' + allDonatedItems[j].donationsitemsid + '" class="form-text hidedisplaycontent"><font color="red"><b>' + "Can't Transfer More Than What Was Donated" + '</b></medium></td>' +
                            '<td class="right"><input type="number" class="form-control-sm" id="discrepancy' + allDonatedItems[j].donationsitemsid + '" value="0" disabled=""/></td>' +
                            '</tr>'
                            );
                }
            }
        }
    }

    //CHECKING THE QTY ENTERED VIAS QTY DONATED 
    var errorItems = new Set();
    var checkemptyhandoverinputsset = new Set();
    function compareEnteredToDonatedItems(donationsitemsid, qtydonated) {

        var takenitem = $('#itmqtydonated2' + donationsitemsid).val();
        if (parseInt(takenitem) > parseInt(qtydonated)) {
            $('#discrepancy' + donationsitemsid).val(parseInt(qtydonated) - parseInt(takenitem));
            $('#discrepancy' + donationsitemsid).css("color", "red");
            $("#donateditmerrormessage" + donationsitemsid).show();

            if (!errorItems.has(donationsitemsid)) {
                errorItems.add(donationsitemsid);
                document.getElementById("btnhandoverdonoritems").disabled = true;
            }
        } else {
            $('#discrepancy' + donationsitemsid).val(parseInt(qtydonated) - parseInt(takenitem));
            $('#discrepancy' + donationsitemsid).css("color", "blue");
            $("#donateditmerrormessage" + donationsitemsid).hide();

            if (errorItems.has(donationsitemsid)) {
                errorItems.delete(donationsitemsid);
            }
            if (errorItems.size < 1) {
                document.getElementById("btnhandoverdonoritems").disabled = false;
            }
        }

        if (takenitem === null || takenitem === '' || typeof takenitem === 'undefined') {
            if (checkemptyhandoverinputsset.has(donationsitemsid)) {
                checkemptyhandoverinputsset.delete(donationsitemsid);
            }
        } else {
            if (!checkemptyhandoverinputsset.has(donationsitemsid)) {
                checkemptyhandoverinputsset.add(donationsitemsid);
            }
        }
    }
    var handovertablesize = ${donatedItemsJSONSize};
    $('#btnhandoverdonoritems').click(function () {
        var qtyDonatedValues = [];
        var donationsitemsid;
        $('.itemdonatedquantities').each(function () {
            donationsitemsid = $(this).data('id');

            var discrepancy = $('#discrepancy' + donationsitemsid).val();
            var expirydate = $(this).data('expiry');
            var qtydonatednocommas = $(this).data('qtydonatednocommas');
            var batchno = $(this).data('batchno');
            var donorprogramid = $(this).data('donorprogramid');
            var donorrefno = $(this).data('donorrefno');
            qtyDonatedValues.push({name: this.name, value: this.value, qtydonated: qtydonatednocommas, donationsitemsid: donationsitemsid, expirydate: expirydate, discrepancy: discrepancy, batchno: batchno, donorprogramid: donorprogramid, donorrefno: donorrefno});

        });

        if (handovertablesize > checkemptyhandoverinputsset.size && checkemptyhandoverinputsset.size !== 0) {
//            $.confirm({
//                icon: 'fa fa-warning',
//                title: '<strong><font color="red">Warning!</font></strong>',
//                content: '' + '<strong style="font-size: 18px;"><font color="">Some Donated Items to hand over have no values.<br> <span style="color:red; font-size: 22px"> Are you sure you want to Continue?</span></font></strong>',
//                boxWidth: '30%',
//                useBootstrap: false,
//                type: 'red',
//                typeAnimated: true,
//                closeIcon: true,
//                buttons: {
//                    somethingElse: {
//                        text: 'Yes',
//                        btnClass: 'btn-purple',
//                        action: function () {
            $.confirm({
                icon: 'fa fa-warning',
                title: '<strong>Please Verify Items Collector!</strong>',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label for="itemUnitSelect">Select Destination</label>' +
                        '<select class="form-control" id="unitx">' +
                        '<option>Select Facility Unit</option>' +
                        '<c:forEach items="${FacUnit}" var="unit">' +
                        '<option data-name="${unit.facilityunitname}" value="${unit.id}">${unit.facilityunitname}</option>' +
                        '</c:forEach></select></div>' +
                        '<div class="form-group required">' +
                        '<label>USERNAME:</label>' +
                        '<input type="text" class="form-control" id="courierusername" placeholder="username"/>' +
                        '</div>' +
                        '<div class="form-group required">' +
                        '<label>PASSWORD:</label>' +
                        '<input type="password" class="form-control" id="courierpassword" placeholder="password"/>' +
                        '</div>' +
                        '</form>',
                boxWidth: '30%',
                useBootstrap: false,
                type: 'red',
                typeAnimated: true,
                closeIcon: true,
                buttons: {
                    formSubmit: {
                        text: 'Hand Over Items',
                        btnClass: 'btn-purple',
                        action: function () {
                            document.getElementById("btnhandoverdonoritems").disabled = true;
                            var unit = this.$content.find('#unitx').val();
                            var courierusername = this.$content.find('#courierusername').val();
                            var courierpassword = this.$content.find('#courierpassword').val();
                            if (!courierusername || !courierpassword || !unit) {
                                if (!courierusername) {
                                    $.alert('Please Enter User Name!');
                                    return false;
                                }
                                if (!courierpassword) {
                                    $.alert('Please Enter the Password!');
                                    return false;
                                }
                                if (!unit) {
                                    $.alert('Please Select Facility Unit!');
                                    return false;
                                }
                            } else {
                                courierpassword = md5(courierpassword);
                                var data = {
                                    facilityunitid: unit,
                                    username: courierusername,
                                    password: courierpassword,
                                    qtydonatedvalues: JSON.stringify(qtyDonatedValues)
                                };
                                $.ajax({
                                    type: "GET",
                                    cache: false,
                                    url: "internaldonorprogram/saveDonorStock.htm",
                                    data: data,
                                    success: function (result) {
                                        if (result === 'success') {
                                            $.confirm({
                                                boxWidth: '30%',
                                                useBootstrap: false,
                                                title: '<strong><font color="green">Success!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-success">' +
                                                        '<b><i class="fa fa-check" style="font-size:25px;green;"></i><span style="color: black; font-weight: bolder">  ITEMS SUCCESSFULLY TRANSFERRED!</span></b></div>',
                                                type: 'green',
                                                typeAnimated: true,
                                                icon: 'fa fa-check-circle',
                                                closeIcon: true,
                                                buttons: {
                                                    OK: function () {

                                                    }
                                                }
                                            });

                                            ajaxSubmitData('internaldonorprogram/viewDonationsToTransfer.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                        } else if (result === 'sameuser') {
                                            $.confirm({
                                                boxWidth: '30%',
                                                useBootstrap: false,
                                                title: '<strong><font color="red">Warning!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-error">' +
                                                        '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  CAN NOT HANDOVER TO YOUR SELF!</span></b></div>',
                                                type: 'red',
                                                typeAnimated: true,
                                                icon: 'fa fa-warning',
                                                closeIcon: true,
                                                buttons: {
                                                    OK: function () {

                                                    }
                                                }
                                            });
                                        } else if (result === 'error') {

                                            $.confirm({
                                                boxWidth: '30%',
                                                useBootstrap: false,
                                                title: '<strong><font color="red">Alert!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-error">' +
                                                        '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  PLEASE PROVIDE VALID USERNAME AND PASSWORD!</span></b></div>',
                                                type: 'red',
                                                typeAnimated: true,
                                                icon: 'fa fa-warning',
                                                closeIcon: true,
                                                buttons: {
                                                    OK: function () {

                                                    }
                                                }
                                            });
                                        } else {

                                            $.confirm({
                                                boxWidth: '30%',
                                                useBootstrap: false,
                                                title: '<strong><font color="#BEF">Alert!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-error">' +
                                                        '<b><i class="fa fa-info-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  USER IS NOT ATTACHED TO THIS UNIT!</span></b></div>',
                                                type: 'red',
                                                typeAnimated: true,
                                                icon: 'fa fa-warning',
                                                closeIcon: true,
                                                buttons: {
                                                    OK: function () {

                                                    }
                                                }
                                            });
                                        }
                                    }
                                });
                            }
                        }
                    },
                    cancel: function () {
                        //close
                    }
                }
            });
//                        }
//                    },
//                    No: {
//                        text: 'NO',
//                        btnClass: 'btn-red',
//                        action: function () {
//
//                        }
//                    }
//                }
//            });
        }
        if (handovertablesize === checkemptyhandoverinputsset.size) {
            $.confirm({
                icon: 'fa fa-warning',
                title: '<strong>Please Verify Items Collector!</strong>',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label for="itemUnitSelect">Select Destination</label>' +
                        '<select class="form-control" id="unit">' +
                        '<option>Select Facility Unit</option>' +
                        '<c:forEach items="${FacUnit}" var="unit">' +
                        '<option id="class${unit.id}" data-name="${unit.facilityunitname}" value="${unit.id}">${unit.facilityunitname}</option>' +
                        '</c:forEach></select></div>' +
                        '<div class="form-group required">' +
                        '<label>USERNAME:</label>' +
                        '<input type="text" class="form-control" id="courierusername" placeholder="username"/>' +
                        '</div>' +
                        '<div class="form-group required">' +
                        '<label>PASSWORD:</label>' +
                        '<input type="password" class="form-control" id="courierpassword" placeholder="password"/>' +
                        '</div>' +
                        '</form>',
                boxWidth: '30%',
                useBootstrap: false,
                type: 'red',
                typeAnimated: true,
                closeIcon: true,
                buttons: {
                    formSubmit: {
                        text: 'Hand Over Items',
                        btnClass: 'btn-purple',
                        action: function () {
                            document.getElementById("btnhandoverdonoritems").disabled = true;
                            var unit = this.$content.find('#unit').val();
                            var courierusername = this.$content.find('#courierusername').val();
                            var courierpassword = this.$content.find('#courierpassword').val();
                            if (!courierusername || !courierpassword) {
                                if (!courierusername) {
                                    $.alert('Please Enter User Name!');
                                    return false;
                                }
                                if (!courierpassword) {
                                    $.alert('Please Enter the Password!');
                                    return false;
                                }
                                if (!unit) {
                                    $.alert('Please Select Facility Unit!');
                                    return false;
                                }
                            } else {
                                courierpassword = md5(courierpassword);
                                var data = {
                                    facilityunitid: unit,
                                    username: courierusername,
                                    password: courierpassword,
                                    qtydonatedvalues: JSON.stringify(qtyDonatedValues)
                                };
                                $.ajax({
                                    type: "GET",
                                    cache: false,
                                    url: "internaldonorprogram/saveDonorStock.htm",
                                    data: data,
                                    success: function (result) {
                                        if (result === 'success') {
                                            $.confirm({
                                                boxWidth: '30%',
                                                useBootstrap: false,
                                                title: '<strong><font color="green">Success!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-success">' +
                                                        '<b><i class="fa fa-check" style="font-size:25px;green;"></i><span style="color: black; font-weight: bolder">  ORDER SUCCESSFULLY DELIVERED!</span></b></div>',
                                                type: 'green',
                                                typeAnimated: true,
                                                icon: 'fa fa-check-circle',
                                                closeIcon: true,
                                                buttons: {
                                                    OK: function () {

                                                    }
                                                }
                                            });
                                            ajaxSubmitData('internaldonorprogram/viewDonationsToTransfer.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                        } else if (result === 'sameuser') {

                                            $.confirm({
                                                boxWidth: '30%',
                                                useBootstrap: false,
                                                title: '<strong><font color="red">Warning!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-error">' +
                                                        '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  CAN NOT HANDOVER TO YOUR SELF!</span></b></div>',
                                                type: 'red',
                                                typeAnimated: true,
                                                icon: 'fa fa-warning',
                                                closeIcon: true,
                                                buttons: {
                                                    OK: function () {

                                                    }
                                                }
                                            });
                                        } else if (result === 'error') {

                                            $.confirm({
                                                boxWidth: '37%',
                                                useBootstrap: false,
                                                title: '<strong><font color="red">Alert!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-error">' +
                                                        '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  PLEASE PROVIDE VALID USERNAME AND PASSWORD!</span></b></div>',
                                                type: 'red',
                                                typeAnimated: true,
                                                icon: 'fa fa-warning',
                                                closeIcon: true,
                                                buttons: {
                                                    OK: function () {

                                                    }
                                                }
                                            });
                                        } else {
                                            $.confirm({
                                                boxWidth: '30%',
                                                useBootstrap: false,
                                                title: '<strong><font color="#BEF">Alert!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-error">' +
                                                        '<b><i class="fa fa-info-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  USER IS NOT ATTACHED TO THIS UNIT!</span></b></div>',
                                                type: 'red',
                                                typeAnimated: true,
                                                icon: 'fa fa-warning',
                                                closeIcon: true,
                                                buttons: {
                                                    OK: function () {

                                                    }
                                                }
                                            });
                                        }
                                    }
                                });
                            }
                        }
                    },
                    cancel: function () {
                        //close
                    }
                }
            });
        }

        if (checkemptyhandoverinputsset.size === 0) {

            $.confirm({
                icon: 'fa fa-warning',
                title: '<strong>Alert: <font color="red">Can not proceed!</font></strong>',
                content: '' + '<strong style="font-size: 18px;"><font color="red">Please Fill in Item Quantities To Transfer.</font></strong>',
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

    });

    $('#tab-2').click(function () {
        ajaxSubmitData('internaldonorprogram/transferOtherItems.htm', 'transferOtherItems', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
</script>