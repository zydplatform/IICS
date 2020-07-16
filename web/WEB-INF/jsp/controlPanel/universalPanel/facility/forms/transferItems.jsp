<%-- 
    Document   : transferItems
    Created on : Jul 13, 2018, 3:21:01 PM
    Author     : IICS
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="row">
    <div class="col-md-12">
        <div class="form-group row">
            <label class="control-label col-md-4">Destination Facility Level</label>
            <div class="col-md-6">
                <select class="form-control" id="selectdestinationfacilitylevelItems">
                    <% int p = 1;%>
                    <c:forEach items="${facilitylevelsList}" var="a">
                        <option id="FacItemleveltransf${a.facilitylevelid}" data-name="${a.facilitylevelname}" data-short="${a.shortname}" value="${a.facilitylevelid}"><%=p++%>.&nbsp; ${a.facilitylevelname} &nbsp;(${a.shortname})</option>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>
</div>
<table class="table table-hover table-bordered" id="facilitylevelfacilitydetailsItemsTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Item Name</th>
            <th>Select</th>
        </tr>
    </thead>
    <tbody id="deletedItemsTableDatadiv">
        <% int k = 1;%>
        <c:forEach items="${itemsList}" var="b">
            <tr>
                <td><%=k++%></td>
                <td>${b.genericname}</td>
                <td align="center">
                    <input type="checkbox" value="${b.itemid}" onchange="if (this.checked) {
                                checkedorUncheckedItemsTransfer(this.value, 'checked');
                            } else {
                                checkedorUncheckedItemsTransfer(this.value, 'unchecked');
                            }">
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table><br>
<div class="row">
    <div class="col-md-10"></div>
    <div class="col-md-2">
        <button style="display: none;" onclick="transferfacilitylevelItemsSel(${facilitylevelid}, '${type}');" id="transferItemstableRowdiv" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i><strong id="tranferItemstextnumber">Transfer</strong></button>
    </div>
</div>  
<script>
    var addedtransferItems = new Set();
    function checkedorUncheckedItemsTransfer(itemid, type) {
        if (type === 'checked') {
            addedtransferItems.add(itemid);
        } else {
            addedtransferItems.delete(itemid);
        }
        if (addedtransferItems.size > 0) {
            document.getElementById('tranferItemstextnumber').innerHTML = 'Transfer(' + addedtransferItems.size + ')';
            document.getElementById('transferItemstableRowdiv').style.display = 'block';
        } else {
            document.getElementById('transferItemstableRowdiv').style.display = 'none';
        }
    }
    function transferfacilitylevelItemsSel(facilitylevelid, type) {
        var destinationid = $('#selectdestinationfacilitylevelItems').val();
        var destinationname = $('#FacItemleveltransf' + destinationid).data('name');
        var destinationshort = $('#FacItemleveltransf' + destinationid).data('short');

        $.confirm({
            title: 'Transfer <a href="#!">' + addedtransferItems.size + ' ' + 'Item(S)' + '</a>',
            content: 'Are You Sure You Want To Transfer To <a href="#!">' + destinationname + ' ' + '(' + destinationshort + ')' + ' ' + '?' + '</a>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes, Transfer',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {destinationid: destinationid, itemids: JSON.stringify(Array.from(addedtransferItems)), facilitylevelid: facilitylevelid},
                            url: "facilitylevelmanagement/transferfacilitylevelitems.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'delete') {
                                    $.confirm({
                                        title: 'Delete Facility Level!',
                                        content: 'Now Facility Level Has No Attached Items, Do You Still Want To Delete Facility Level?',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'Yes,Delete',
                                                btnClass: 'btn-purple',
                                                action: function () {
                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {facilitylevelid: facilitylevelid},
                                                        url: "facilitylevelmanagement/deletefacilitylevel.htm",
                                                        success: function (data, textStatus, jqXHR) {
                                                            var fields = data.split('-');
                                                            var names = fields[0];
                                                            var size = fields[1];
                                                            if (names === 'deleted') {
                                                                document.getElementById('deletedItemsTableDatadiv').innerHTML = '';
                                                                document.getElementById('transferItemstableRowdiv').style.display = 'none';
                                                                ajaxSubmitData('facilitylevelmanagement/facilitylevels.htm', 'facliltyLevelContent', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
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
                                } else {
                                    $.confirm({
                                        title: 'Transfered!',
                                        content: 'Transfered Success Fully',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                if (type === 'first') {
                                                    ajaxSubmitData('facilitylevelmanagement/gettransferfacilitylevelitems.htm', 'attachededfacilitylevel1ItemsTotrans', 'facilitylevelid=' + facilitylevelid + '&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                } else {
                                                    ajaxSubmitData('facilitylevelmanagement/gettransferfacilitylevelitems.htm', 'attachedfacilitylevelItemsTotrans', 'facilitylevelid=' + facilitylevelid + '&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                }
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
</script>