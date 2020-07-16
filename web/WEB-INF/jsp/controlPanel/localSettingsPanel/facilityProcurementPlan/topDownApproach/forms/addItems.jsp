<%-- 
    Document   : addItems
    Created on : Jun 25, 2018, 11:13:18 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<input id="ordertypequarterorannuall" value="${ordertype}" type="hidden">
<input id="orderperiodidquarterorannuallid" value="${orderperiodid}" type="hidden">
<fieldset>
    <div class="form-group row">
        <div class="col-md-8">

        </div>
        <div class="col-md-4">
            <h4> Items In Cart:<span class="badge badge-secondary" onclick="viewProcItemsInCart('${ordertype}',${orderperiodid});" style="cursor: pointer;"><strong id="countingaddedorsaveditemsid">${financialyprocurementplansItemsRowcount}</strong> &nbsp;Item(s)</span></h4>  
        </div>
    </div>

    <legend>Add Items</legend>
    <div class="row">
        <div class="col-md-4">
            <div class="tile" id="searchTile">
                <div class="tile-body">
                    <div id="search-form_3p">
                        <input id="inputprocurementitemSearch" type="text" oninput="inputsearchprocItem(${orderperiodid},'${ordertype}')" onfocus="setSearchPaneIn();" placeholder="Search Item" class="search_3 dropbtn"/>
                    </div><br>
                    <div id="inputprocurementsearchResults" class="scrollbar">

                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile" >
                        <h4 class="tile-title">Selected Items.</h4>
                        <div id="procmentaddedItems">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Item</th>
                                        <th class="right">Monthly Need</th>
                                        <th class="center">
                                            ${ordertype} Need  
                                        </th>
                                        <th class="center">
                                            Edit|Remove  
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="inputprocuremententeredItemsBody">

                                </tbody>
                            </table> 
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button"  onclick="savebeforeconsolidateproc();"class="btn btn-primary btn-block">Save</button>
                            </div>
                            <div class="col-md-4">
                                
                            </div>
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" onclick="canceladdingitemsprocdialog(${orderperiodid});" class="btn btn-secondary btn-block">Cancel</button>
                            </div>   
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<script>

    function inputsearchprocItem(orderperiodid, ordertype) {
        var searchvalue = $('#inputprocurementitemSearch').val();
        ajaxSubmitData('facilityprocurementplanmanagement/additemsprocurementform.htm', 'inputprocurementsearchResults', 'act=b&searchvalue=' + searchvalue + '&orderperiodid=' + orderperiodid + '&ordertype=' + ordertype + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function setSearchPaneIn() {
        var div = $('.additemsTOprocurementplns > div').height();
        var divHead = $('.additemsTOprocurementplns > div > #head').height();
        var searchForm = $('#search-form_3p').height();
        $('#inputprocurementsearchResults').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.14) - parseInt(searchForm));
        $(window).resize(function () {
            div = $('.additemsTOprocurementplns > div').height();
            divHead = $('.additemsTOprocurementplns > div > #head').height();
            searchForm = $('#search-form_3p').height();
            $('#inputprocurementsearchResults').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.14) - parseInt(searchForm));
        });
    }
    function canceladdingitemsprocdialog(orderperiodid) {
        ajaxSubmitData('facilityprocurementplanmanagement/topdowncomposeprocurementplan.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//        $.confirm({
//            title: 'Cancel Adding Items!',
//            content: 'Are You Sure You Want To Cancel Adding Items ?',
//            type: 'red',
//            typeAnimated: true,
//            icon: 'fa fa-warning',
//            buttons: {
//                tryAgain: {
//                    text: 'Yes,Cancel',
//                    btnClass: 'btn-red',
//                    action: function () {
//                        $.ajax({
//                            type: 'POST',
//                            data: {orderperiodid: orderperiodid, type: 'all'},
//                            url: "facilityprocurementplanmanagement/removetodaysprocurementaddeditems.htm",
//                            success: function (data, textStatus, jqXHR) {
//                                if (data === 'close') {
//                                    window.location = '#close';
//                                } else {
//                                    
//                                }
//                            }
//                        });
//                    }
//                },
//                close: function () {
//                }
//            }
//        });
    }
    function viewProcItemsInCart(orderperiodtype,orderperiodid){
        $('#viewTheProcurementPlnItems').modal('show');
        ajaxSubmitData('facilityprocurementplanmanagement/topdowncomposedprocurementplanitem.htm', 'TopDownItemsViewDiv', 'act=a&orderperiodtype='+orderperiodtype+'&orderperiodid='+orderperiodid+'&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function savebeforeconsolidateproc(){
     ajaxSubmitData('facilityprocurementplanmanagement/topdowncomposeprocurementplan.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');   
    }
</script>