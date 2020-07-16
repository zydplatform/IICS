<%-- 
    Document   : itemSearchResults
    Created on : Apr 10, 2018, 5:41:41 PM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty items}">
    <ul class="items" id="foundItems">
        <c:forEach items="${items}" var="item">
            <li id="li${cell.id}" class="classItem border-groove" onclick="selectStaff(${item.id}, '${item.name}')">
                <h5 class="itemTitle">
                    ${item.name}
                </h5>
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
    function selectStaff(itemid, genericName) {
        $.confirm({
            title: '<h3>' + genericName + '</h3>',
            content: '<div class="form-group">' +
                    '<label>Batch Number</label>' +
                    '<input type="text" id="batch" value="" placeholder="Batch Number" class="form-control"/></div>' +
                    '<div class="form-group">' +
                    '<label for="pack">Expiry Date</label>' +
                    '<input type="text" id="expiry" value="" placeholder="Expiry Date" class="form-control"/></div>' +
                    '<div class="form-group">' +
                    '<label for="cost">Quantity</label>' +
                    '<input type="number" min="0" id="quantity" value="" placeholder="Quantity" class="form-control"/></div>' +
                    '<div class="form-group"></div>',
            boxWidth: '45%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                formSubmit: {
                    text: 'Add Item',
                    btnClass: 'btn-purple',
                    action: function () {
                        var batch = this.$content.find('#batch');
                        var expiry = this.$content.find('#expiry');
                        var quantity = this.$content.find('#quantity');
                        var activityCellid = parseInt($('#count-Activity-Cell').val());
                        if (activityCellid > 0 && quantity.val() !== '') {
                            var data = {
                                activitycell: activityCellid,
                                batch: batch.val(),
                                expiry: expiry.val(),
                                quantity: quantity.val(),
                                itemid: itemid,
                                count: count
                            };
                            $('#enteredItemsBody').append(
                                    '<tr id="count' + count + '">' +
                                    '<td>' + genericName + '</td>' +
                                    '<td class="right">' + data.batch + '</td>' +
                                    '<td class="right no-wrap">' + data.expiry + '</td>' +
                                    '<td class="right">' + data.quantity + '</td>' +
                                    '<td class="center">' +
                                    '<span class="badge badge-danger icon-custom" onclick="remove(' + count + ')">' +
                                    '<i class="fa fa-close"></i></span></td>' +
                                    '</tr>'
                                    );
                            counted.push(data);
                            count = count + 1;
                        } else {
                            $.alert('Please Enter Quantity');
                            return false;
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
                var batch = this.$content.find('#batch');
                var expiry = this.$content.find('#expiry');
                batch.on('input', function () {
                    var batchNo = batch.val();
                    batch.val(batchNo.toString().toUpperCase());
                });
                expiry.datepicker({
                    format: "dd-mm-yyyy",
                    autoclose: true,
                    todayHighlight: true
                });
            }
        });
    }
</script>
