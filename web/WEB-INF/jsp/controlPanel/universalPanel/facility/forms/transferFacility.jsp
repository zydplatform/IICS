<%-- 
    Document   : transferFacility
    Created on : Jul 13, 2018, 11:44:30 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="row">
    <div class="col-md-12">
        <div class="form-group row">
            <label class="control-label col-md-4">Destination Facility Level</label>
            <div class="col-md-6">
                <select class="form-control" id="selectdestinationfacilitylevel">
                    <% int p = 1;%>
                    <c:forEach items="${faclilityLevelsList}" var="a">
                        <option id="Facleveltransf${a.facilitylevelid}" data-name="${a.facilitylevelname}" data-short="${a.shortname}" value="${a.facilitylevelid}"><%=p++%>.&nbsp; ${a.facilitylevelname} &nbsp;(${a.shortname})</option>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>
</div>
<table class="table table-hover table-bordered" id="facilitylevelfacilitydtailsTable">
    <thead>
        <tr>
            <th>No</th>
            <th>facility Name</th>
            <th>Select</th>
        </tr>
    </thead>
    <tbody id="deletedTableDatadiv">
        <% int k = 1;%>
        <c:forEach items="${faclilityList}" var="b">
            <tr>
                <td><%=k++%></td>
                <td>${b.facilityname}</td>
                <td align="center">
                    <input type="checkbox" value="${b.facilityid}" onchange="if (this.checked) {
                                checkedorUncheckedFacilityTransfer(this.value, 'checked');
                            } else {
                                checkedorUncheckedFacilityTransfer(this.value, 'unchecked');
                            }">
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table><br>
<div class="row">
    <div class="col-md-10"></div>
    <div class="col-md-2">
        <button style="display: none;" onclick="transferfacilitylevelfacilitySel(${facilitylevelid});" id="transfertableRowdiv" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i><strong id="tranfertextnumber">Transfer</strong></button>
    </div>
</div>  

<script>
    var transferset = new Set();
    // $('#facilitylevelfacilitydtailsTable').DataTable();
    function checkedorUncheckedFacilityTransfer(facilityid, type) {
        if (type === 'checked') {
            transferset.add(facilityid);
        } else {
            transferset.delete(facilityid);
        }
        if (transferset.size > 0) {
            document.getElementById('tranfertextnumber').innerHTML = 'Transfer(' + transferset.size + ')';
            document.getElementById('transfertableRowdiv').style.display = 'block';
        } else {
            document.getElementById('transfertableRowdiv').style.display = 'none';
        }
    }
    function transferfacilitylevelfacilitySel(facilitylevelid) {
        var destinationid = $('#selectdestinationfacilitylevel').val();
        var destinationname = $('#Facleveltransf' + destinationid).data('name');
        var destinationshort = $('#Facleveltransf' + destinationid).data('short');
        $.confirm({
            title: 'Transfer <a href="#!">' + transferset.size + ' Facility(ies)</a> ?',
            content: 'Are You Sure You Want To Transfer Them To <a href="#!">' + destinationname + ' ' + '(' + destinationshort + ')' + ' ' + '</a> ?',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes,Transfer',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {destinationid: destinationid, facilityids: JSON.stringify(Array.from(transferset)), facilitylevelid: facilitylevelid},
                            url: "facilitylevelmanagement/transferfacilitylevelfacility.htm",
                            success: function (data, textStatus, jqXHR) {
                                var fields = data.split('-');
                                var name = fields[0];
                                var size = fields[1];
                                if (name === 'hasfacility') {
                                    $.confirm({
                                        title: 'Transfered!',
                                        content: 'Transfered Success Fully',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                ajaxSubmitData('facilitylevelmanagement/getfacilityieslist.htm', 'remaindTransferedFacilityDiv', 'facilitylevelid=' + facilitylevelid + '&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                            }
                                        }
                                    });

                                } else if (name === 'hasitems') {
                                    document.getElementById('deletedTableDatadiv').innerHTML = '';
                                    document.getElementById('transfertableRowdiv').style.display = 'none';
                                    $.confirm({
                                        title: 'Delete Facility Level!',
                                        content: 'Can Not Be Deleted Because Of <a href="#!">' + size + ' ' + 'Items Atached!!' + '</a>',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'View / Transfer Item(S)',
                                                btnClass: 'btn-purple',
                                                action: function () {
                                                    $.ajax({
                                                        type: 'GET',
                                                        data: {facilitylevelid: facilitylevelid, type: 'second'},
                                                        url: "facilitylevelmanagement/gettransferfacilitylevelitems.htm",
                                                        success: function (data, textStatus, jqXHR) {
                                                            $.confirm({
                                                                title: 'Attached Item(s)!',
                                                                content: '<div id="attachedfacilitylevelItemsTotrans">' + data + '</div>',
                                                                type: 'purple',
                                                                boxWidth: '70%',
                                                                typeAnimated: true,
                                                                buttons: {
                                                                    close: function () {
                                                                    }
                                                                }
                                                            });
                                                        }
                                                    });
                                                }
                                            },
                                            close: function () {
                                            }
                                        }
                                    });
                                } else if (name === 'delete') {
                                    $.confirm({
                                        title: 'Delete Facility Level!',
                                        content: 'Now Facility Level Has No Attached Facilities, Do You Still Want To Delete Facility Level?',
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
                                                        url: "facilitylevelmanagement/deletefacilitylevel.htm",
                                                        success: function (data, textStatus, jqXHR) {
                                                            var fields = data.split('-');
                                                            var names = fields[0];
                                                            var size = fields[1];
                                                            if (names === 'deleted') {
                                                                document.getElementById('deletedTableDatadiv').innerHTML = '';
                                                                document.getElementById('transfertableRowdiv').style.display = 'none';
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
