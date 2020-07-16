<%-- 
    Document   : items
    Created on : Jun 26, 2018, 11:05:34 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table class="table table-hover table-bordered" id="viewTheProcurementPlnItemsTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Item Name</th>
            <th>Monthly Need</th>
            <th>${orderperiodtype} Need</th>
            <c:if test="${act=='a'}">
            <th>Edit|Remove</th>
            </c:if>
            
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <% int i = 1;%>
        <% int p = 1;%>
        <% int k = 1;%>
        <c:forEach items="${ItemsFound}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.genericname}</td>
                <td id="EDTMnThQty<%=i++%>">${a.averagemonthconsumption}</td>
                <td id="EDTqorannulQty<%=p++%>">${a.averagequarterorAnnuallyconsumption}</td>
                <c:if test="${act=='a'}">
                  <td align="center" id="">
                    <span class="badge badge-secondary icon-custom" onclick="edittopdwnItemValues('${a.genericname}',${a.facilityprocurementplanid}, '${orderperiodtype}',<%=k++%>);">
                        <i class="fa fa-edit"></i></span>
                    |
                    <span class="badge badge-danger icon-custom" onclick="removetopdownprocuremntaddedritem(${a.facilityprocurementplanid}, '${orderperiodtype}',${orderperiodid},${a.itemid});">
                        <i class="fa fa-close"></i></span>
                </td>  
                </c:if>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#viewTheProcurementPlnItemsTable').DataTable();
    function removetopdownprocuremntaddedritem(facilityprocurementplanid, orderperiodtype, orderperiodid,itemid) {
        $.confirm({
            title: 'Delete Item!',
            content: 'Are You Sure You Want To Delete This Item?',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes, Delete',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityprocurementplanid: facilityprocurementplanid,orderperiodid:orderperiodid,itemid:itemid, type: 'removewithpk'},
                            url: "facilityprocurementplanmanagement/removetodaysprocurementaddeditems.htm",
                            success: function (data, textStatus, jqXHR) {
                                var counts = document.getElementById('countingaddedorsaveditemsid').innerHTML;
                                document.getElementById('countingaddedorsaveditemsid').innerHTML = parseInt(counts) - 1;
                                ajaxSubmitData('facilityprocurementplanmanagement/topdowncomposedprocurementplanitem.htm', 'TopDownItemsViewDiv', 'act=a&orderperiodtype=' + orderperiodtype + '&orderperiodid=' + orderperiodid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function edittopdwnItemValues(itemname,facilityprocurementplanid, orderperiodtype, count) {
        var monthlyneed = document.getElementById('EDTMnThQty' + count).innerHTML;
        var quarterorannual = document.getElementById('EDTqorannulQty' + count).innerHTML;

        $.confirm({
            title: 'Edit Item Quantity! <br><a style=" text-decoration: underline;color: blue;">' + itemname + '</a>',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Edit Monthly Need here</label>' +
                    '<input type="number" value="' + parseInt(monthlyneed) + '" oninput="updtedaffectentereditemvalue('+1+',this.value,\''+orderperiodtype+'\','+count+');" id="EDTmonthndid'+count+'" class="EDTmonthnd form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Edit ' + orderperiodtype + ' Need here</label>' +
                    '<input type="number" value="' + parseInt(quarterorannual) + '" oninput="updtedaffectentereditemvalue('+2+',this.value,\''+orderperiodtype+'\','+count+');" id="EDTQtOrAnnndid'+count+'" class="EDTQtOrAnnnd form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var editmontlyneed = this.$content.find('.EDTmonthnd').val();
                        var edittedquarterorannual = this.$content.find('.EDTQtOrAnnnd').val();
                        if (!editmontlyneed && !edittedquarterorannual) {
                            $.alert('provide a valid Quantity');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {editmonthlyneed: editmontlyneed, editannuallneed: edittedquarterorannual, orderperiodtype: orderperiodtype,facilityprocurementplanid:facilityprocurementplanid,type:'withid'},
                            url: "facilityprocurementplanmanagement/updatetopdownprocurementaddeditems.htm",
                            success: function (data, textStatus, jqXHR) {
                                $('#EDTMnThQty' + count).html(editmontlyneed);
                                $('#EDTqorannulQty' + count).html(edittedquarterorannual);
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function updtedaffectentereditemvalue(type,value,ordertpe,count){
           if (type === 1) {
            if (value !== 0 || value !== '') {
                if (ordertpe === 'Quarterly') {
                    document.getElementById('EDTQtOrAnnndid'+count).value = value * 3;
                } else {
                    document.getElementById('EDTQtOrAnnndid'+count).value = value * 12;
                }

            }
        } else {
            if (value !== 0 || value !== '') {
                if (ordertpe === 'Quarterly') {
                    document.getElementById('EDTmonthndid'+count).value = Math.round(value/3);
                } else {
                    document.getElementById('EDTmonthndid'+count).value = Math.round(value/12);
                }

            }
        } 
    }
</script>