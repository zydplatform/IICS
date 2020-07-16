<%-- 
    Document   : packageitems
    Created on : Aug 27, 2018, 3:59:36 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<div class="col-md-12">
    <fieldset>
        <table class="table table-hover scol-md-12 table-bordered" id="picktopackets">
            <thead>
                <tr>
                    <td>No</td>
                    <th>Item Name</th>
                    <th>Packet Size</th>
                    <th>No of Packets</th>
                    <td>Date Created</td>
                    <th>Created by</th>
                    <th class="center">Delete</th>
                </tr>
            </thead>
            <tbody>
                <% int j = 1;%>
                <c:forEach items="${packageditems}" var="c">
                    <tr>
                        <td><%=j++%></td>
                        <td><a href="#"><span onclick="picklist(${c.stockid},${c.packageno},${c.packagesize},'${c.fullname}',${c.packageid})"><font color="blue">${c.fullname}</font></span></a></td>
                        <td>${c.packageno}</td>
                        <td>${c.packagesize}</td>
                        <td>${c.datepackaged}</td>
                        <td>${c.firstname}&nbsp;${c.lastname}&nbsp;${c.othernames}</td>
                        <td align="center">
                            <span  title="Delete Of This Group." onclick="deletePackageInstance(${c.packageid}, '${c.fullname}');"  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </fieldset>
</div>
<div class="row">
    
</div>
<div class="">
    <div id="pickpackageditems" class="picklistdialog">
        <div>
            <div id="head">
                <a href="#close" title="Close" class="close2">X</a>
                <font color="green"><h4 class="modalDialog-title"></h4></font>
                <hr>
            </div>
            <div class="row scrollbar" id="packagepicklist">

            </div>
        </div>
    </div>
</div>
<div id="genericname"></div>
<script>
    $('#picktopackets').DataTable();
    function deletePackageInstance(packageid, fullname) {
        $.confirm({
            title: '<h5>Delete Package For:<font color="red">' + fullname + '</font></h5>',
            content: 'Do you wish to continue?',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {packageid: packageid},
                            url: "packaging/deletepackage.htm",
                            success: function (data) {
                                ajaxSubmitData('packaging/picktopackets.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                No: function () {
                }
            }
        });
    }
    function editpackagedetails(packageid, fullname, stockid) {
        $.ajax({
            type: 'GET',
            data: {packageid: packageid, stockid: stockid},
            url: "packaging/editpackagedetails.htm",
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">Edit:' + '<font color="green">' + fullname + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '30%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Save',
                            btnClass: 'btn-green',
                            action: function () {
                                var eachpacket = $('#eachpacket').val();
                                var noofpackets = $('#noofpackets').val();
                                var itemmid = $('#itemmid').val();
                                if (eachpacket === '') {
                                    document.getElementById('eachpacket').style.borderColor = "red";
                                } else if (noofpackets === '') {
                                    document.getElementById('noofpackets').style.borderColor = "red";
                                } else if (eachpacket === '' && noofpackets === '') {
                                    document.getElementById('eachpacket').style.borderColor = "red";
                                } else {
                                    $.ajax({
                                        type: 'POST',
                                        data: {eachpacket: eachpacket, noofpackets: noofpackets, packageid: packageid, stockid: stockid},
                                        url: "packaging/updatepackages.htm",
                                        success: function (respose) {
                                            ajaxSubmitData('packaging/picktopackets.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                        }
                                    });
                                }
                            }
                        },
                        Close: function () {
                        }
                    }

                });
            }
        });
    }
    function picklist(stockid,packageno,packagesize,fullname,packageid) {
        var pickedstock=packageno*packagesize;
        $.ajax({
            type: 'GET',
            data: {stockid: stockid,pickedstock :pickedstock,packageno :packageno,packagesize: packagesize,packageid: packageid},
            url: "packaging/packagingpicklist.htm",
            success: function (respose) {
                $.confirm({
                    title: '<strong class="center">Pick Items For:' + '<font color="green">' + fullname + '</font>' + '</strong>',
                    content: '' + respose,
                    boxWidth: '90%',
                    height: '100%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    draggable: true
                });
            }
        });
    }
</script>