<%-- 
    Document   : itemSearchResults
    Created on : Apr 10, 2018, 5:41:41 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<c:if test="${not empty items}">
    <ul class="items" id="foundItems">
        <c:forEach items="${items}" var="item">
            <li id="li${item.id}" class="classItem border-groove" onclick="addCatalogueItem(${item.id}, '${item.name}', '${item.form}', '${item.code}')">
                <h5 class="itemTitle">
                    ${item.name}
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
        Item <strong>${name}</strong> Not Found.
    </p>
</c:if>
<script>
    $(document).ready(function () {
        var items = Array.from(itemList);
        for (i in items) {
            $('#li' + items[i]).remove();
        }
    });
    function addCatalogueItem(itemid, itemName) {
        var validCode = true;
        var supplierid = $('#supplierList').val();
        $.confirm({
            title: '<h3>Add Selected Item</h3>',
            content: '<h4 class="itemTitle">' + itemName + '</h4>' +
                    '<div class="form-group">' +
                    '<label>Item Code</label>' +
                    '<input type="text" id="code" value="" placeholder="Item Code" class="form-control"/>' +
                    '<small><font color="red" id="codeError"></font></small></div>' +
                    '<div class="form-group">' +
                    '<label for="pack">Pack Size</label>' +
                    '<input type="number" min="1" id="pack" value="" placeholder="Pack Size" class="form-control"/></div>' +
                    '<div class="form-group">' +
                    '<label for="cost">Unit Cost</label>' +
                    '<input type="number" min="1" id="cost" value="" placeholder="Unit Cost" class="form-control"/></div>' +
                    '<div class="form-group">' +
                    '<div class="control-label required"><label>Restricted:</label></div>' +
                    '<div class="form-check"><label class="form-check-label">' +
                    '<input id="yes" value="Yes" class="form-check-input" type="radio" name="res"><span class="label-text">Yes</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
                    '</label>' +
                    '<label class="form-check-label">' +
                    '<input id="no" value="No" class="form-check-input" type="radio" name="res" checked><span class="label-text">No</span>' +
                    '</label></div></div>',
            boxWidth: '40%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                formSubmit: {
                    text: 'Add Item',
                    btnClass: 'btn-purple submit',
                    action: function () {
                        var itemcode = this.$content.find('#code');
                        var packsize = this.$content.find('#pack');
                        var unitcost = this.$content.find('#cost');
                        var res = this.$content.find('input:radio[name=res]:checked');
                        if (!itemList.has(itemid) && itemcode.val() !== '' && packsize.val() !== '' && unitcost.val() !== '' && validCode === true) {
                            $('#enteredItemsBody').append(
                                    '<tr id="row' + itemid + '">' +
                                    '<td>' + itemName + '</td>' +
                                    '<td>' + res.val() + '</td>' +
                                    '<td class="right">' + itemcode.val() + '</td>' +
                                    '<td class="right">' + packsize.val() + '</td>' +
                                    '<td class="right">' + unitcost.val() + '</td>' +
                                    '<td class="center">' +
                                    '<span class="badge badge-danger icon-custom" onclick="remove(' + itemid + ')">' +
                                    '<i class="fa fa-close"></i></span></td>' +
                                    '</tr>'
                                    );
                            $('#li' + itemid).remove();
                            
                            var data = {
                                id: itemid,
                                code: itemcode.val(),
                                pack: packsize.val(),
                                cost: unitcost.val(),
                                res: (res.val() === 'Yes')
                            };
                            itemList.add(itemid);
                            items.push(data);
                        } else {
                            if (unitcost.val() === '') {
                                unitcost.focus();
                            }
                            if (packsize.val() === '') {
                                packsize.focus();
                            }
                            if (itemcode.val() === '') {
                                itemcode.focus();
                            }
                        }
                    }
                },
                close: {
                    text: 'Cancel',
                    btnClass: 'btn-red'
                }
            },
            onContentReady: function () {
                // bind to events
                var oldPack = '';
                var pack = this.$content.find('#pack');
                var code = this.$content.find('#code');
                var codeError = this.$content.find('#codeError');
                code.on('input', function () {
                    var itemCode = code.val();
                    if (itemCode.length > 0) {
                        $.ajax({
                            type: 'POST',
                            data: {supplierid: supplierid, itemCode: itemCode},
                            url: 'externalsuppliers/filterItemCode.htm',
                            success: function (res) {
                                if (res !== 'none') {
                                    validCode = false;
                                    codeError.html('Code used on <strong>' + res + '</strong>');
                                } else {
                                    validCode = true;
                                    codeError.html('');
                                }
                            }
                        });
                    } else {
                        codeError.html('');
                    }
                });
                pack.on('input', function () {
                    var temp = (pack.val()).toString();
                    if (temp.length <= 10) {
                        oldPack = temp;
                    } else {
                        pack.val(oldPack);
                    }
                });
            }
        });
    }
</script>
