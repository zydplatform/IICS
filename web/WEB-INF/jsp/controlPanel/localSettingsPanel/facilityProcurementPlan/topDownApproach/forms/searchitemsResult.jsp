<%-- 
    Document   : searchitemsResult
    Created on : Jun 25, 2018, 11:20:51 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${not empty items}">
    <ul class="items" id="foundItems">
        <c:forEach items="${items}" var="item">
            <li id="procli${item.itemid}" class="classItem border-groove" onclick="addprocitemquantity('${item.itemname}',${item.itemid}, '${ordertype}',${orderperiodid});">
                <h5 class="itemTitle">
                    ${item.itemname}
                </h5>
                <p class="itemContent">
                    ${item.cat}
                </p>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty items}">
    <p class="center">
        <br>
        Item <strong>${itemname}</strong> Not Found.
    </p>
</c:if>
<script>
    var cntnumb = 0;
    function addprocitemquantity(itemname, itemid, ordertype, orderperiodid) {
        $.ajax({
            type: 'POST',
            data: {itemid: itemid, orderperiodid: orderperiodid},
            url: "facilityprocurementplanmanagement/getitemconsumptionaveragefrompreviouscount.htm",
            success: function (data, textStatus, jqXHR) {
                if (data === 'procured') {
                    $.ajax({
                        type: 'GET',
                        data: {itemid: itemid, ordertype: ordertype, orderperiodid: orderperiodid, act: 'a'},
                        url: "facilityprocurementplanmanagement/getitemconsumptionaveragefrompreviousfinancialyears.htm",
                        success: function (data, textStatus, jqXHR) {
                            $.confirm({
                                title: '<a style=" text-decoration: underline;color: blue;">' + itemname + '</a>',
                                content: '' + data,
                                boxWidth: '80%',
                                useBootstrap: false,
                                type: 'purple',
                                typeAnimated: true,
                                buttons: {
                                    tryAgain: {
                                        text: 'Add',
                                        btnClass: 'btn-purple',
                                        action: function () {
                                            var monthlyneed1 = this.$content.find('.monthprocurementSuggCont').val();
                                            var ordertype1 = $('#ordertypequarterorannuall').val();
                                            var ordertypeneed1 = this.$content.find('.averagetotalSuggprocurementCont').val();
                                            var orderperiod1 = $('#orderperiodidquarterorannuallid').val();
                                            if (!monthlyneed1 && !ordertypeneed1) {
                                                $.alert('provide a valid Quantiy');
                                                return false;
                                            }
                                            if (addedUnits.size > 0) {
                                                cntnumb++;
                                                $.ajax({
                                                    type: 'POST',
                                                    data: {monthlyneed: monthlyneed1, ordertypeneed: ordertypeneed1, ordertype: ordertype1, orderperiod: orderperiod1, itemid: itemid},
                                                    url: "facilityprocurementplanmanagement/saveprocurementplnitem.htm",
                                                    success: function (data, textStatus, jqXHR) {
                                                        $('#inputprocuremententeredItemsBody').append('<tr id="addedItM' + cntnumb + '"><td>' + itemname + '</td>' +
                                                                '<td>' + addedUnits.size + '</td>' +
                                                                '<td align="center" id="addedItEdtMT' + cntnumb + '">' + monthlyneed1 + '</td>' +
                                                                '<td align="center" id="addedItEdtAQ' + cntnumb + '">' + ordertypeneed1 + '</td>' +
                                                                '<td align="center"><span class="badge badge-secondary icon-custom" onclick="editprocuritem(' + itemid + ',' + orderperiod1 + ',' + cntnumb + ',\'' + ordertype + '\',\'' + itemname + '\')">' +
                                                                '<i class="fa fa-edit"></i></span>|<span class="badge badge-danger icon-custom" onclick="removeprocuritem(' + itemid + ',' + orderperiod1 + ',' + cntnumb + ')">' +
                                                                '<i class="fa fa-close"></i></span></td></tr>');

                                                        $('#procli' + itemid).remove();
                                                        if (cntnumb === 10) {
                                                            cntnumb = 0;
                                                            $('#inputprocuremententeredItemsBody').html('');
                                                            var itmesadded = document.getElementById('countingaddedorsaveditemsid').innerHTML;
                                                            document.getElementById('countingaddedorsaveditemsid').innerHTML = parseInt(itmesadded) + 3;
                                                        }
                                                    }
                                                });
                                            } else {
                                                $.confirm({
                                                    title: 'No Units Were Selected!',
                                                    content: 'Select Units And Their Respective Item Quantity',
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
                                    },
                                    close: function () {
                                    }
                                }
                            });
                        }
                    });
                } else {
                    $.ajax({
                        type: 'GET',
                        data: {itemid: itemid, ordertype: ordertype, orderperiodid: orderperiodid, act: 'b'},
                        url: "facilityprocurementplanmanagement/getitemconsumptionaveragefrompreviousfinancialyears.htm",
                        success: function (data, textStatus, jqXHR) {

                            $.confirm({
                                title: 'Enter Item Quantity <br><a style=" text-decoration: underline;color: blue;">' + itemname + '</a>',
                                content: '' + data,
                                type: 'purple',
                                boxWidth: '25%',
                                useBootstrap: false,
                                typeAnimated: true,
                                buttons: {
                                    tryAgain: {
                                        text: 'Add',
                                        btnClass: 'btn-purple',
                                        action: function () {
                                            var monthlyneed = this.$content.find('.monthlyneeded').val();
                                            var ordertypeneed = this.$content.find('.quarterorannualneeded').val();
                                            if (!monthlyneed && !ordertypeneed) {
                                                $.alert('provide a valid Quantiy');
                                                return false;
                                            }
                                            cntnumb++;
                                            $.ajax({
                                                type: 'POST',
                                                data: {monthlyneed: monthlyneed, ordertypeneed: ordertypeneed, ordertype: ordertype, orderperiod: orderperiodid, itemid: itemid},
                                                url: "facilityprocurementplanmanagement/saveprocurementplnitem.htm",
                                                success: function (data, textStatus, jqXHR) {
                                                    $('#inputprocuremententeredItemsBody').append('<tr id="addedItM' + cntnumb + '"><td>' + itemname + '</td>' +
                                                            '<td align="center" id="addedItEdtMT' + cntnumb + '">' + monthlyneed + '</td>' +
                                                            '<td align="center" id="addedItEdtAQ' + cntnumb + '">' + ordertypeneed + '</td>' +
                                                            '<td align="center"><span class="badge badge-secondary icon-custom" onclick="editprocuritem(' + itemid + ',' + orderperiodid + ',' + cntnumb + ',\'' + ordertype + '\',\'' + itemname + '\')">' +
                                                            '<i class="fa fa-edit"></i></span>|<span class="badge badge-danger icon-custom" onclick="removeprocuritem(' + itemid + ',' + orderperiodid + ',' + cntnumb + ')">' +
                                                            '<i class="fa fa-close"></i></span></td></tr>');

                                                    $('#procli' + itemid).remove();
                                                    if (cntnumb === 10) {
                                                        cntnumb = 0;
                                                        $('#inputprocuremententeredItemsBody').html('');
                                                        var itmesadded = document.getElementById('countingaddedorsaveditemsid').innerHTML;
                                                        document.getElementById('countingaddedorsaveditemsid').innerHTML = parseInt(itmesadded) + 3;
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
                    });
                }
            }
        });

    }
    function removeprocuritem(itemid, orderperiod, count) {
        $.ajax({
            type: 'POST',
            data: {itemid: itemid, orderperiodid: orderperiod, type: 'one'},
            url: "facilityprocurementplanmanagement/removetodaysprocurementaddeditems.htm",
            success: function (data, textStatus, jqXHR) {
                $('#addedItM' + count).remove();
            }
        });
    }
    function editprocuritem(itemid, orderperiod, count, ordertype, itemname) {
        var monthlyneed = $('#addedItEdtMT' + count).html();
        var ordertypeneed = $('#addedItEdtAQ' + count).html();

        $.confirm({
            title: 'Edit Item Quantity! <br><a style=" text-decoration: underline;color: blue;">' + itemname + '</a>',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Edit Monthly Need here</label>' +
                    '<input type="number" value="' + parseInt(monthlyneed) + '" oninput="editaffectentereditemvalue(' + 1 + ',this.value,\'' + ordertype + '\',' + count + ');" id="Editmonthlyid' + count + '" class="Editmonthly form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Edit ' + ordertype + ' Need here</label>' +
                    '<input type="number" value="' + parseInt(ordertypeneed) + '" oninput="editaffectentereditemvalue(' + 2 + ',this.value,\'' + ordertype + '\',' + count + ');" id="QtyOrAnnmonthlyid' + count + '" class="QtyOrAnnmonthly form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var editmonthlyneed = this.$content.find('.Editmonthly').val();
                        var editannuallneed = this.$content.find('.QtyOrAnnmonthly').val();
                        if (!editmonthlyneed && !editannuallneed) {
                            $.alert('provide a valid Quantity');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {editmonthlyneed: editmonthlyneed, editannuallneed: editannuallneed, itemid: itemid, orderperiodid: orderperiod, ordertype: ordertype, type: 'without'},
                            url: "facilityprocurementplanmanagement/updatetopdownprocurementaddeditems.htm",
                            success: function (data, textStatus, jqXHR) {
                                $('#addedItEdtMT' + count).html(editmonthlyneed);
                                $('#addedItEdtAQ' + count).html(editannuallneed);
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function editaffectentereditemvalue(type, value, ordertpe, count) {
        if (type === 1) {
            if (value !== 0 || value !== '') {
                if (ordertpe === 'Quarterly') {
                    document.getElementById('QtyOrAnnmonthlyid' + count).value = value * 3;
                } else {
                    document.getElementById('QtyOrAnnmonthlyid' + count).value = value * 12;
                }

            }
        } else {
            if (value !== 0 || value !== '') {
                if (ordertpe === 'Quarterly') {
                    document.getElementById('Editmonthlyid' + count).value = Math.round(value / 3);
                } else {
                    document.getElementById('Editmonthlyid' + count).value = Math.round(value / 12);
                }

            }
        }
    }
</script>