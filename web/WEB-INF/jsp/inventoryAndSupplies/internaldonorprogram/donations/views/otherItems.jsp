<%-- 
    Document   : otherItems
    Created on : Oct 7, 2018, 3:09:39 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div class="col-md-12">
    <fieldset>
        <div class="tile">
            <div class="row">
                <div class="col-md-12 col-sm-12 right" id="handOverOtherItemBtnDiv">
                    <button class="btn btn-sm btn-primary icon-btn" onclick="handOverOtherDonatedItems()">
                        <i class="fa fa-fw fa-lg fa-handshake-o"></i>
                        Hand Over
                    </button>
                </div>
            </div>
            <div class="tile-body">
                <table class="table table-hover table-bordered col-md-12" id="transferOtherDonationsTable">
                    <thead class="col-md-12">
                        <tr>
                            <th class="center">No</th>
                            <th class="left">Item Name</th>
                            <th class="left">Item Specifications</th>
                            <th class="right">Quantity Donated</th>
                            <th class="center">Hand Over</th>
                        </tr>
                    </thead>
                    <tbody class="col-md-12">
                        <% int ot = 1;%>
                        <c:forEach items="${otherDonorList}" var="others">
                            <tr id="${others.facilityassetsid}">
                                <td class="center"><%=ot++%></td>
                                <td class="left">${others.assetsname}</td>
                                <td class="left">${others.itemspecification}</td> 
                                <td class="right">${others.assetqty}</td>  
                                <td class="center">
                                    <input class="form-check-input" type="checkbox" onclick="transferOtherItems(${others.facilityassetsid})">
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </fieldset>
</div>

<div class="row">
    <div class="col-md-12">
        <div id="modalDonatedOtherItems" class="shelveItemDialog" style="margin-top: 70px!important">
            <div>
                <div id="divSection3">
                    <div id="head">
                        <h3 class="modalDialog-title"><font color="purple">Donation Transfer Processing...</font></h3>
                        <a href="#close" title="Close" class="close2">X</a>
                    </div>
                    <div class="row scrollbar" id="content" style="height: 561px;">
                        <%@include file="handOverOtherItems.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $('#transferOtherDonationsTable').DataTable();
    var selectedOtherItems = new Set();
    var allDonatedOtherItems = [];
    $('#handOverOtherItemBtnDiv').hide();
    
     $('.close2').click(function () {
        //  selectedItems.clear();
        $('#otheritemhandoverTableContent').html('');
    });


    function transferOtherItems(facilityassetsid) {
        if (!selectedOtherItems.has(facilityassetsid)) {
            selectedOtherItems.add(facilityassetsid);
            console.log(selectedOtherItems);
            $('#handOverOtherItemBtnDiv').show();
        } else {
            selectedOtherItems.delete(facilityassetsid);
            if (selectedOtherItems.size < 1) {
                $('#handOverOtherItemBtnDiv').hide();
            }
            console.log(selectedOtherItems);
        }
    }

    function handOverOtherDonatedItems() {
        window.location = '#modalDonatedOtherItems';
        initDialog('shelveItemDialog');
        allDonatedOtherItems = ${donatedOtherItemsJSON};
        console.log(allDonatedOtherItems);

        var donatedOtherItems = Array.from(selectedOtherItems);
        for (k in donatedOtherItems) {
            for (b in allDonatedOtherItems) {
                if (allDonatedOtherItems[b].facilityassetsid === donatedOtherItems[k]) {
                    $('#otheritemhandoverTableContent').append(
                            '<tr id="pre' + allDonatedOtherItems[b].facilityassetsid + '">' +
                            '<td style="display: none">' + allDonatedOtherItems[b].assetsid + '</td>' +
                            '<td>' + allDonatedOtherItems[b].assetsname + '</td>' +
                            '<td>' + allDonatedOtherItems[b].itemspecification + '</td>' +
                            '<td class="left"><input type="hidden" id="itmpicked2DD" value="DD"/><font color="blue" class=""><b>' + allDonatedOtherItems[b].assetqty + '</b></font></td>' +
                            '<td class="center"><input  oninput="compareOtherEnteredToOtherDonatedItems(' + allDonatedOtherItems[b].facilityassetsid + ',' + allDonatedOtherItems[b].assetqtynocommas + ')" id="otritmqtydonated2' + allDonatedOtherItems[b].facilityassetsid + '" data-id="' + allDonatedOtherItems[b].facilityassetsid + '" data-assetqtynocommas="' + allDonatedOtherItems[b].assetqtynocommas + '" name="' + allDonatedOtherItems[b].assetsid + '" data-itemspecification="' + allDonatedOtherItems[b].itemspecification + '" class="form-control form-control-sm otheritemdonatedquantities" value="" type="number" min="0" max=""/><medium id="donatedotheritmerrormessage' + allDonatedOtherItems[b].facilityassetsid + '" class="form-text hidedisplaycontent"><font color="red"><b>' + "Can't Transfer More Than What Was Donated" + '</b></medium></td>' +
                            '<td class="right"><input type="number" class="form-control-sm" id="otherdiscrepancy' + allDonatedOtherItems[b].facilityassetsid + '" value="0" disabled=""/></td>' +
                            '</tr>'
                            );

                    console.log(allDonatedOtherItems);
                }
            }
        }
        console.log(donatedOtherItems);
    }

    //CHECKING THE QTY ENTERED VIAS QTY DONATED 
    var errorOtherItems = new Set();
    var checkemptyhandoverinputsset = new Set();
    function compareOtherEnteredToOtherDonatedItems(facilityassetsid, assetqty) {
        var takenitem = $('#otritmqtydonated2' + facilityassetsid).val();

        if (parseInt(takenitem) > parseInt(assetqty)) {
            $('#otherdiscrepancy' + facilityassetsid).val(parseInt(assetqty) - parseInt(takenitem));
            $('#otherdiscrepancy' + facilityassetsid).css("color", "red");
            $("#donatedotheritmerrormessage" + facilityassetsid).show();

            if (!errorOtherItems.has(facilityassetsid)) {
                errorOtherItems.add(facilityassetsid);
                document.getElementById("btnhandoverotherdonoritems").disabled = true;
            }
        } else {
            $('#otherdiscrepancy' + facilityassetsid).val(parseInt(assetqty) - parseInt(takenitem));
            $('#otherdiscrepancy' + facilityassetsid).css("color", "blue");
            $("#donatedotheritmerrormessage" + facilityassetsid).hide();

            if (errorOtherItems.has(facilityassetsid)) {
                errorOtherItems.delete(facilityassetsid);
            }
            if (errorOtherItems.size < 1) {
                document.getElementById("btnhandoverotherdonoritems").disabled = false;
            }
        }

        if (takenitem === null || takenitem === '' || typeof takenitem === 'undefined') {
            if (checkemptyhandoverinputsset.has(facilityassetsid)) {
                checkemptyhandoverinputsset.delete(facilityassetsid);
            }
        } else {
            if (!checkemptyhandoverinputsset.has(facilityassetsid)) {
                checkemptyhandoverinputsset.add(facilityassetsid);
            }
        }
    }


    $('#btnhandoverotherdonoritems').click(function () {
        var qtyOtherDonatedValues = [];
        var facilityassetsid;
        $('.otheritemdonatedquantities').each(function () {
            facilityassetsid = $(this).data('id');

            var discrepancy = $('#otherdiscrepancy' + facilityassetsid).val();
            var assetqtynocommas = $(this).data('assetqtynocommas');

            console.log("assetqtynocommas" + assetqtynocommas);
            var itemspecification = $(this).data('itemspecification');
            qtyOtherDonatedValues.push({name: this.name, value: this.value, qtydonated: assetqtynocommas, facilityassetsid: facilityassetsid, discrepancy: discrepancy, itemspecification: itemspecification});

            console.log(qtyOtherDonatedValues);
            console.log("~~~~~~~~~~~~~~~~discrepancy" + discrepancy);
        });

        if (checkemptyhandoverinputsset.size !== 0) {
            $.confirm({
                icon: 'fa fa-warning',
                title: '<strong>Please Verify Items Collector!</strong>',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label for="itemUnitSelect">Select Destination</label>' +
                        '<select class="form-control" id="unitx">' +
                        '<option>Select Facility Unit</option>' +
                        '<c:forEach items="${FacUnits}" var="unit">' +
                        '<option data-name="${unit.name}" value="${unit.id}">${unit.name}</option>' +
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
                            var unit = this.$content.find('#unitx').val();
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
                            } else {
                                courierpassword = md5(courierpassword);
                                var data = {
                                    facilityunitid: unit,
                                    username: courierusername,
                                    password: courierpassword,
                                    qtyOtherDonatedValues: JSON.stringify(qtyOtherDonatedValues)
                                };
                                $.ajax({
                                    type: "GET",
                                    cache: false,
                                    url: "internaldonorprogram/saveOtherItemDonorStock.htm",
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
                                            ajaxSubmitData('internaldonorprogram/transferOtherItems.htm', 'transferOtherItems', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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

</script>
