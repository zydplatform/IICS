<%--
    Document   : placeOrders
    Created on : Oct 19, 2018, 8:25:31 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../include.jsp" %>
<div class="row">
    <div class="col-md-4">
        <div class="tile" id="searchTile">
            <div class="tile-body">
                <div class="form-group">
                    <label class="control-label" for="patientHeight">Order No:</label>
                    <input class="form-control" id="unitordernumber" type="" name="" value="${ordernumber}">
                </div>

                <div class="form-group">
                    <label for="">Select Requester:</label>
                    <select class="form-control" id="orderrequester">
                        <option value="aaa" selected disabled>---Select Requester---</option>
                        <c:forEach items="${unitStaffList}" var="s">
                            <option value="${s.staffid}">${s.staffname}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label class="control-label" for="patientHeight">Added By:</label>
                    <input class="form-control" id="unitordernumber" type="" name="" value="${activestaff}" readonly="">
                </div>

            </div>
        </div>
    </div>
    <div class="col-md-8">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Enter Items.</h4>
                    <div id="" class="form-group">
                        <input id="inputitemSearch4" type="text" oninput="inputsearchItems004();" onfocus="displaySuppliesResults();" placeholder="Search Item" class="form-control dropbtn"/>
                    </div>
                    <div id="myDropdown" class="search-content">

                    </div>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Item</th>
                                <th class="right">Quantity</th>
                                <th class="center">Remove</th>
                            </tr>
                        </thead>
                        <tbody id="inputenteredItemsBody">

                        </tbody>
                    </table>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-6">
                            <hr style="border:1px dashed #dddddd;">
                            <button type="button" onclick="ajaxSubmitData('sandriesreq/suppliesRequisitionsHome.htm', 'workpane', '', 'GET');" class="btn btn-secondary btn-block">Cancel</button>
                        </div> 

                        <div class="col-md-4">
                            <hr style="border:1px dashed #dddddd;">
                            <button type="button" id="btnsubmitSuppliesRequest"   onclick="submitSuppliesRequest();"class="btn btn-primary btn-block">Submit For Approval</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var searcheditemslist = [];
    var searcheditemsSet = new Set();
    var updatedsearcheditemslist = [];

    window.onclick = function (event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("search-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('showSearch')) {
                    openDropdown.classList.remove('showSearch');
                }
            }
        }
    };

    function displaySuppliesResults() {
        document.getElementById("myDropdown").classList.add("showSearch");
    }

    function inputsearchItems004() {
        var searchValue = $('#inputitemSearch4').val();
        if (searchValue !== '') {
            ajaxSubmitData('sandriesreq/searchItemPackageList.htm', 'myDropdown', 'searchValue=' + searchValue, 'GET');
        } else {
            $('#myDropdown').html('');
        }
    }

    var numb = 0;
    function addseacheditemquantityb(name, itemid) {
        $.confirm({
            title: name + ' ' + 'Quantity',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Quantity</label>' +
                    '<input type="text" placeholder="Enter Quantity" maxlength="7"  onkeypress="return isNumberKey0003b(event)" class="name form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            buttons: {
                formSubmit: {
                    text: 'Add',
                    btnClass: 'btn-purple',
                    action: function () {
                        var qty = this.$content.find('.name').val();
                        if (!qty) {
                            $.alert('provide a valid Quantity');
                            return false;
                        }
                        searcheditemslist.push({
                            itemid: itemid,
                            qty: qty
                        });
                        searcheditemsSet.add(parseInt(itemid));
                        numb++;
                        $('#inputenteredItemsBody').append(
                                '<tr id="rows' + itemid + '">' +
                                '<td>' + numb + '</td>' +
                                '<td>' + name + '</td>' +
                                '<td class="right">' + qty + '</td>' +
                                '<td class="center">' +
                                '<span class="badge badge-danger icon-custom" onclick="removeorderitem002b(' + itemid + ')">' +
                                '<i class="fa fa-close"></i></span></td>' +
                                '</tr>'
                                );
                        $('#li' + itemid).remove();
                        $('#inputitemSearch4').html('');
                    }
                },
                cancel: function () {
                    //close
                },
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function removeorderitem002b(itemid) {
        $.confirm({
            title: 'Remove Item',
            icon: 'fa fa-warning',
            content: 'Remove Item From Order List!',
            type: 'orange',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Remove',
                    btnClass: 'btn-orange',
                    action: function () {
                        searcheditemsSet.delete(parseInt(itemid));
                        for (index in searcheditemslist) {
                            var res = searcheditemslist[index];
                            if (res["itemid"] === itemid) {
                            } else {
                                updatedsearcheditemslist.push({
                                    itemid: res["itemid"],
                                    qty: res["qty"]
                                });
                            }
                        }
                        searcheditemslist = [];
                        for (indexs in updatedsearcheditemslist) {
                            var ress = updatedsearcheditemslist[indexs];
                            searcheditemslist.push({
                                itemid: ress["itemid"],
                                qty: ress["qty"]
                            });
                        }
                        $('#rows' + itemid).remove();
                        updatedsearcheditemslist = [];
                    }
                },
                close: function () {

                }
            }
        });
    }

    function submitSuppliesRequest() {
        var ordernumber = $('#unitordernumber').val();
        var requester = $('#orderrequester').val();
        if (requester === 'aaa' || requester === null || requester === '') {
            document.getElementById('orderrequester').focus();
        } else {
            if (searcheditemslist.length > 0) {
                document.getElementById('btnsubmitSuppliesRequest').disabled = true;
                $.ajax({
                    type: 'POST',
                    data: {ordernumber: ordernumber, values: JSON.stringify(searcheditemslist), requester: requester},
                    url: "sandriesreq/saveUnitSupplyRequistion.htm",
                    success: function (data) {
                        $.confirm({
                            title: 'Save!',
                            content: 'Submitted For Approval!',
                            type: 'orange',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Ok',
                                    btnClass: 'btn-orange',
                                    action: function () {
                                        ajaxSubmitData('sandriesreq/suppliesRequisitionsHome.htm', 'workpane', '', 'GET');
                                    }
                                },
                                close: function () {

                                }
                            }
                        });
                    }
                });
            } else {
                $.confirm({
                    title: 'Alert!',
                    content: 'Please Add Items To Order!',
                    buttons: {
                        ok: function () {

                        }
                    }
                });
            }
        }
    }

    function isNumberKey0003b(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
    }
</script>