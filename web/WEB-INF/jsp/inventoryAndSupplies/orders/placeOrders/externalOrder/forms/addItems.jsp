<%-- 
    Document   : addItems
    Created on : May 28, 2018, 4:29:00 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .cl{color: #465cba;}
</style>
<style>
    #overlayexternalOrd {
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
<div>
    <fieldset>
        <legend>An External Order</legend>
        <div class="container" id="firstexterdiv">
            <div class="row">
                <div class="col-md-1"></div>   
                <div class="col-md-4">
                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Order Number:</strong></span>&nbsp;
                        <strong >
                            <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${ordernumber}</strong></span>
                        </strong>
                    </div> 
                </div>
                <div class="col-md-4">
                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Supplier:</strong></span>&nbsp;
                        <strong >
                            <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${facilityordersuppliername}</strong></span>
                        </strong>
                    </div> 
                </div>   
                <div class="col-md-1"></div>       
            </div>
        </div>
    </fieldset>
</div>
<br>
<fieldset>
    <legend>Add Items</legend>
    <div class="row">
        <div class="col-md-4">
            <div class="tile" id="searchTile">
                <div class="tile-body">
                    <div id="search-form_3exter">
                        <input id="inputexternitemSearch" type="text" oninput="inputexternitemSearch(this.value,${supplierid})" placeholder="Search Item" class="search_3 dropbtn"/>
                    </div><br>
                    <div id="inputexternalsearchResults" class="scrollbar">


                    </div>
                </div>
            </div>
        </div>
        <div id="overlayexternalOrd" style="display: none;">
            <img src="static/img2/loader.gif" alt="Loading" /><br/>
            Please Wait...
        </div>
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h4 class="tile-title">Selected Items.</h4>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Quantity</th>
                                    <th>Remove</th>
                                </tr>
                            </thead>
                            <tbody id="externalenteredItemsBody">

                            </tbody>
                        </table>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button"  onclick="savepausedorsubmittedexternalorder('pause',${externalfacilityordersid});"class="btn btn-primary btn-block">Pause</button>
                            </div>
                            <div class="col-md-6">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button"  onclick="savepausedorsubmittedexternalorder('submit',${externalfacilityordersid});"class="btn btn-primary btn-block">Submit For Approval</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<script>
    var td = 0;
    var externalOrderItems = [];
    var externalOrderItemList = new Set();
    function inputexternitemSearch(searchValue, supplierid) {
        setSizeofSearchResults();
        ajaxSubmitData('extordersmanagement/searchitems.htm', 'inputexternalsearchResults', 'searchValue=' + searchValue + '&supplierid=' + supplierid + '&itemSet=' + JSON.stringify(Array.from(externalOrderItemList)) + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function setSizeofSearchResults() {
        var divext = $('.supplierCatalogDialog > div').height();
        var divHeadext = $('.supplierCatalogDialog > div > #head').height();
        var searchFormext = $('#search-form_3exter').height();
        var detailsext = $('#firstexterdiv').height();
        $('#inputexternalsearchResults').height(parseInt(parseInt(divext) - parseInt(divHeadext)) - parseInt(divext * 0.14) - parseInt(searchFormext) - parseInt(detailsext));
        $(window).resize(function () {
            divext = $('.supplierCatalogDialog > div').height();
            divHeadext = $('.supplierCatalogDialog > div > #head').height();
            searchFormext = $('#search-form_3exter').height();
            detailsext = $('#firstexterdiv').height();
            $('#inputexternalsearchResults').height(parseInt(parseInt(divext) - parseInt(divHeadext)) - parseInt(divext * 0.14) - parseInt(searchFormext) - parseInt(detailsext));
        });
    }
    function addexternalitemquantity(genericname, itemid) {
        $.confirm({
            title: 'ADD ITEMS',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Quantity</label>' +
                    '<input type="text" placeholder="Enter Quantity" maxlength="9"  onkeypress="return isNumberextKey(event)" class="orderingquantity form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'ADD',
                    btnClass: 'btn-purple',
                    action: function () {
                        var qty = this.$content.find('.orderingquantity').val();
                        if (!qty) {
                            $.alert('provide a valid Quantity');
                            return false;
                        }
                        externalOrderItems.push({
                            itemid: itemid,
                            qty: qty
                        });
                        externalOrderItemList.add(itemid);

                        $('#externalenteredItemsBody').append('<tr id="OrderRow' + itemid + '"><td>' + genericname + '</td>' +
                                '<td>' + qty + '</td>' +
                                '<td align="center"><span class="badge badge-danger icon-custom" onclick="removeOrderItems(' + itemid + ')"><i class="fa fa-close"></i></span></td></tr>');

                        $('#liext' + itemid).remove();
                    }
                },
                close: function () {
                }
            }
        });
    }
    function isNumberextKey(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }
    function removeOrderItems(itemid) {
        $('#OrderRow' + itemid).remove();
        externalOrderItemList.delete(itemid);
        for (i in externalOrderItems) {
            if (externalOrderItems[i].itemid === itemid) {
                externalOrderItems.splice(i, 1);
                break;
            }
        }
    }
    function savepausedorsubmittedexternalorder(type, externalfacilityordersid) {
        if (externalOrderItemList.size > 0) {

            if (type === 'pause') {
                $.confirm({
                    title: 'External Order',
                    content: 'Are You Sure You Want To Pause This Order?',
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Yes',
                            btnClass: 'btn-purple',
                            action: function () {
                                document.getElementById('overlayexternalOrd').style.display = 'block';
                                $.ajax({
                                    type: 'POST',
                                    data: {items: JSON.stringify(externalOrderItems), externalfacilityordersid: externalfacilityordersid, type: 'pause'},
                                    url: "extordersmanagement/submitorpauseexternalorder.htm",
                                    success: function (data, textStatus, jqXHR) {
                                        $.confirm({
                                            title: 'External Order',
                                            content: 'Paused Successfully',
                                            type: 'purple',
                                            typeAnimated: true,
                                            buttons: {
                                                close: function () {
                                                    document.getElementById('overlayexternalOrd').style.display = 'none';
                                                    ajaxSubmitData('extordersmanagement/placeexternalordershome.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
            } else {
                $.confirm({
                    title: 'External Order',
                    content: 'Are You Sure You Want To Submit This Order For Approval?',
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Yes',
                            btnClass: 'btn-purple',
                            action: function () {
                                document.getElementById('overlayexternalOrd').style.display = 'block';
                                $.ajax({
                                    type: 'POST',
                                    data: {items: JSON.stringify(externalOrderItems), externalfacilityordersid: externalfacilityordersid, type: 'submit'},
                                    url: "extordersmanagement/submitorpauseexternalorder.htm",
                                    success: function (data, textStatus, jqXHR) {
                                        $.confirm({
                                            title: 'External Order',
                                            content: 'Submitted Successfully',
                                            type: 'purple',
                                            typeAnimated: true,
                                            buttons: {
                                                close: function () {
                                                    document.getElementById('overlayexternalOrd').style.display = 'none';
                                                    ajaxSubmitData('extordersmanagement/placeexternalordershome.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
            }
        } else {
            $.confirm({
                title: 'External Order',
                content: 'Add Items First Before Submitting',
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
</script>