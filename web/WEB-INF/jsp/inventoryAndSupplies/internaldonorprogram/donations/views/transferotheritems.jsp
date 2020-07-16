<%-- 
    Document   : transferotheritems
    Created on : Oct 7, 2018, 3:26:28 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <form>
             <div class="form-group">
                <label class="control-label">Select Destination Unit:</label>
                <select class="form-control myform" id="selectedbuildings">
                    <c:forEach items="${facUnit}" var="U">
                        <option value="${U.facilityunitid}">${U.facilityunitname}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group row">
                <label for="itemclass" id="packsLabel">Quantity</label>
                <input class="form-control" id="quantity" type="number"  placeholder="Enter Item Quantity">
            </div>
            <div class="form-group row">
                <button class="btn btn-primary" id="transferOtherDonatedItems" type="button">
                    <i class="fa fa-fw fa-lg fa-plus"></i>
                    Save
                </button>
            </div>
        </form>
    </div>
</div>
<script>
    $('#transferOtherDonatedItems').click(function () {
//        var itemid = $('#itemid').val();
//        var donationsitemsid = $('#donationsitemsid').val();
//        var batchno = $('#batchno').val();
//        var exiprydate = $('#exiprydate').val();
//        var quantityTransferred = $('#quantityTransferred').val();
//
//        var data = {
//            itemid: itemid,
//            donationsitemsid: donationsitemsid,
//            batchno: batchno,
//            exiprydate: exiprydate,
//            quantityTransferred: quantityTransferred
//        };
//        $.ajax({
//            type: 'POST',
//            data: data,
//            url: 'internaldonorprogram/saveDonorStock.htm',
//            success: function (res) {
//                if (res === 'Saved') {
//                    $('#transferDonatedItems').prop('disabled', true);
//                    $.toast({
//                        heading: 'Success',
//                        text: 'Donation Successfully Made.',
//                        icon: 'success',
//                        hideAfter: 2000,
//                        position: 'bottom-center'
//                    });
//                    //ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                    window.location = '#close';
//                } else {
//                    $.toast({
//                        heading: 'Error',
//                        text: 'An unexpected error occured while trying to make donation.',
//                        icon: 'error'
//                    });
//                    // ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                    window.location = '#close';
//                }
//            }
//        });
    });
</script>