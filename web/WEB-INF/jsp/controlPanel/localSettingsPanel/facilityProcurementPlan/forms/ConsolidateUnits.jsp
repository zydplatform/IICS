<%-- 
    Document   : ConsolidateUnits
    Created on : Jun 5, 2018, 5:32:24 PM
    Author     : IICS
--%>
<style>
    #overlaycons {
        background: rgba(0,0,0,0.5);
        color: #FFFFFF;
        position: fixed;
        height: 100%;
        width: 100%;
        z-index: 5000;
        top: 0;
        left: 0;
        float: left;
        text-align: center;
        padding-top: 25%;
    }
</style>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<input id="consolidateorderperiodid" value="${orderperiodid}" type="hidden">
<input id="consolidateorderperiodtype" value="${orderperiodtype}" type="hidden">
<table class="table table-hover table-bordered" id="tableConsolidate">
    <thead>
        <tr>
            <th>No</th>
            <th>Unit Name</th>
            <th>Short Name</th>
            <th>Procurement Plan Items</th>
            <th>Select</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <% int i = 1;%>
        <% int a = 1;%>
        <% int b = 1;%>
        <% int c = 1;%>
        <c:forEach items="${unitsFound}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.facilityunitname}</td>
                <td>${a.shortname}</td>
                <td align="center"><button onclick="viewunitsconsolidatedunititems(${a.facilityunitfinancialyearid},'${orderperiodtype}');"  title="View ${a.facilityunitname} Procurement Plan Items." class="btn btn-primary btn-sm add-to-shelf">
                        ${a.facilityprocurementitemsCount} &nbsp;Item(s)
                    </button>
                    </td>

                <td align="center">
                    <c:if test="${a.consolidated==true}">
                        <div class="toggle-flip">
                            <label>
                                <input type="checkbox" checked="checked"  onchange="if (this.checked) {
                                            activateodiactivate('activate', this.id);
                                        } else {
                                            activateodiactivate('diactivate', this.id);
                                        }"><span class="flip-indecator" style="height: 10px !important; width: 94px !important; "  data-toggle-on="Consolidated" data-toggle-off="Remove"></span>
                                </label>
                            </div>
                    </c:if>
                    <c:if test="${a.consolidated==false}">
                        <input type="checkbox" value="${a.facilityunitfinancialyearid}" onchange="if (this.checked) {
                                    consolidatedUnits('checked', this.value);
                                } else {
                                    consolidatedUnits('unchecked', this.value);
                                }">   
                    </c:if>

                </td>
            </tr>

        </c:forEach>

    </tbody>
</table>
<div id="overlaycons" style="display: none;">
    <img src="static/img2/loader.gif" alt="Loading" /><br/>
    Consolidating Unit's procurement Plans Please Wait...
</div>
<div class="form-group">
    <div class="row">
        <div class="col-md-4">
        </div>
        <div class="col-md-4">
            <div id="ConsolidateBtn" style="display: none;">
                <hr style="border:1px dashed #dddddd;">
                <button type="button" onclick="consolidateunitsprocurementplan();" class="btn btn-primary btn-block">Consolidate</button> 
            </div>
        </div>
        <div class="col-md-4">
            <hr style="border:1px dashed #dddddd;">
            <button type="button" onclick="cancelunitsdialog();" class="btn btn-secondary btn-block">Cancel</button>
        </div>   
    </div>
</div>
<script>
    $('#tableConsolidate').DataTable();
    function cancelunitsdialog() {
        window.location = '#close';
    }
    var unitsConsolidate = new Set();
    function consolidatedUnits(type, value) {
        if (type === 'checked') {
            unitsConsolidate.add(value);
        } else {
            unitsConsolidate.delete(value);
        }
        if (unitsConsolidate.size > 0) {
            document.getElementById('ConsolidateBtn').style.display = 'block';
        } else {
            document.getElementById('ConsolidateBtn').style.display = 'none';
        }
    }
    function consolidateunitsprocurementplan() {
        var consolidateorderperiodid = $('#consolidateorderperiodid').val();
        var consolidateorderperiodtype = $('#consolidateorderperiodtype').val();
        $.confirm({
            title: 'Consolidate Procurement Plans!',
            content: 'Are You Sure You Want To Consolidate Procurement Plans For Select Units?',
            type: 'red',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        document.getElementById('overlaycons').style.display = 'block';
                        $.ajax({
                            type: 'POST',
                            data: {unitsConsolidate: JSON.stringify(Array.from(unitsConsolidate)), orderperiodid: consolidateorderperiodid, orderperiodtype: consolidateorderperiodtype},
                            url: "facilityprocurementplanmanagement/consolidate.htm",
                            success: function (data, textStatus, jqXHR) {
                                document.getElementById('overlaycons').style.display = 'none';
                                window.location = '#close';
                                ajaxSubmitData('facilityprocurementplanmanagement/composedfacilityprocurementplan.htm', 'content3', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                document.getElementById('overlaycons').style.display = 'none';
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function viewunitsconsolidatedunititems(facilityunitfinancialyearid,orderperiodtype){
        $('#consolidatedItemsUnits').modal('show');
     ajaxSubmitData('facilityprocurementplanmanagement/consolidatedfacilityunitsprocurementplanitems.htm', 'consolidatedItemsUnitsDiv', 'facilityunitfinancialyearid='+facilityunitfinancialyearid+'&orderperiodtype='+orderperiodtype+'&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');   
    }
</script>