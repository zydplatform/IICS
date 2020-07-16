<%-- 
    Document   : manageStock
    Created on : Apr 24, 2018, 11:54:50 AM
    Author     : IICS
--%>
<div class="row">
    <div class="col-md-3 col-sm-6">
        <form>
            <div class="form-group">
                <label for="sDate">Start Date</label>
                <input class="form-control" id="sDate" type="text" placeholder="dd-mm-yyyy">
            </div>
        </form>
    </div>
    <div class="col-md-3 col-sm-5">
        <form>
            <div class="form-group">
                <label for="eDate">End Date</label>
                <input class="form-control" id="eDate" type="text"  placeholder="dd-mm-yyyy">
            </div>
        </form>
    </div>
    <div class="col-md-3 col-sm-1">
        <button class="btn btn-primary" id="fetchStock" type="button">
            <i class="fa fa-lg fa-fw fa-search"></i>
        </button>
    </div>
</div>
<div id="stock">
    <div class="row" id="TotalLoad">

    </div>
    <div class="loader-container row">
        <div class="loader"></div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="stockItemDetails" class="stockDetailsModal">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="itemName"></h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="tabset">
                            <!-- Tab 1 -->
                            <input type="radio" name="tabset" id="tab4" aria-controls="itemBatches" checked>
                            <label for="tab4">Item Consumption</label>
                            <!-- Tab 2 -->
                            <input type="radio" name="tabset" id="tab5" aria-controls="transactions">
                            <label for="tab5">Transactions</label>
                            <!-- Tab 3 -->
                            <input type="radio" name="tabset" id="tab6" aria-controls="storage">
                            <label for="tab6">Current Locations</label>

                            <div class="tab-panels">
                                <section id="itemBatches" class="tab-panel">
                                    <div class="loader-container row">
                                        <div class="loader"></div>
                                    </div>
                                </section>
                                <section id="transactions" class="tab-panel">
                                    <div class="loader-container row">
                                        <div class="loader"></div>
                                    </div>
                                </section>
                                <section id="storage" class="tab-panel">
                                    <div class="loader-container row">
                                        <div class="loader"></div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var serverDate = '${serverdate}';
    var startDate, endDate;
    var months = {
        January: '01',
        February: '02',
        March: '03',
        April: '04',
        May: '05',
        June: '06',
        July: '07',
        August: '08',
        September: '09',
        October: '10',
        November: '11',
        December: '12'
    };

    var monthIndex = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
    ];

    var monthEnd = {
        January: '31',
        February: '28',
        March: '31',
        April: '30',
        May: '31',
        June: '30',
        July: '31',
        August: '31',
        September: '30',
        October: '31',
        November: '30',
        December: '31'
    };
    $(document).ready(function () {
        $('#stockTable').DataTable();
        $("#sDate").datepicker({
            minViewMode: 'months',
            autoclose: true,
            format: 'MM yyyy'
        });
        $('#eDate').datepicker({
            minViewMode: 'months',
            autoclose: true,
            format: 'MM yyyy'
        });
        var end = new Date(serverDate);
        <%-- $("#sDate").val('July ' + end.getFullYear()); --%>
        $("#sDate").val('January ' +  end.getFullYear());
        $("#eDate").val(monthIndex[end.getMonth()] + ' ' + end.getFullYear());
        fetchStock();
        $('#fetchStock').click(function () {
            $('#stock').html('');
            $("#sDate").removeClass('error-field');
            $("#eDate").removeClass('error-field');
            var end = ($('#eDate').val()).toString().split(' ');
            var start = ($('#sDate').val()).toString().split(' ');
            if ((parseInt(end[1]) > parseInt(start[1]) || parseInt(end[1]) === parseInt(start[1])) && (parseInt(months[end[0]]) > parseInt(months[start[0]]) || parseInt(months[end[0]]) === parseInt(months[start[0]]))) {
                fetchStock();
            } else {
                if ((parseInt(end[1]) < parseInt(start[1])) || (parseInt(months[end[0]]) < parseInt(months[start[0]]))) {
                    if (!((parseInt(start[1]) * parseInt(months[start[0]]) * 0) === 0)) {
                        $("#sDate").addClass('error-field');
                    } else if (!((parseInt(end[1]) * parseInt(months[end[0]]) * 0) === 0)) {
                        $("#eDate").addClass('error-field');
                    } else {
                        $("#sDate").addClass('error-field');
                        $("#eDate").addClass('error-field');
                    }
                }
            }
        });
    });

    function fetchStock() {
        $('#stock').html('<div class="loader-container row"><div class="loader"></div></div>');
        var end = ($('#eDate').val()).toString().split(' ');
        var start = ($('#sDate').val()).toString().split(' ');
        endDate = end[1] + '-' + months[end[0]] + '-' + monthEnd[end[0]];
        startDate = start[1] + '-' + months[start[0]] + '-01';
        var data = {
            end: endDate,
            start: startDate
        };
        $.ajax({
            type: 'POST',
            data: data,
            url: 'store/fetchStock.htm',
            success: function (response) {
                $('#stock').html(response);
            }
        });
    }

    function viewItemTransactions(itemid, itemName) {
        $('#itemName').html(itemName);
        $('#storage').html('<div class="loader-container row"><div class="loader"></div></div>');
        $('#itemBatches').html('<div class="loader-container row"><div class="loader"></div></div>');
        $('#transactions').html('<div class="loader-container row"><div class="loader"></div></div>');
        window.location = '#stockItemDetails';
        initDialog('stockDetailsModal');
        $.ajax({
            type: 'POST',
            data: {itemid: itemid, start: startDate, end: endDate},
            url: 'store/fetchStockItemBatches.htm',
            success: function (response) {
                $('#itemBatches').html(response);
            }
        });
        $.ajax({
            type: 'POST',
            data: {itemid: itemid, start: startDate, end: endDate},
            url: 'store/generateStockCard.htm',
            success: function (response) {
                $('#transactions').html(response);
            }
        });
        $.ajax({
            type: 'POST',
            data: {itemid: itemid, start: startDate, end: endDate},
            url: 'store/fetchStockItemLocations.htm',
            success: function (response) {
                $('#storage').html(response);
            }
        });
    }

</script>
