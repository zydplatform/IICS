<%-- 
    Document   : itemstatisticshome
    Created on : Sep 11, 2019, 4:38:14 PM
    Author     : IICS TECHS
--%>
<%@include file="../../../include.jsp"%>
<style>
    .small-padding-top {
        padding-top: 1%;
    }
    .chart-legend > span {
        display: inline-block;
        margin-right: 25px;
        margin-bottom: 10px;
        font-size: 13px;
    }
    .chart-legend > span:last-child {
        margin-right: 0;
    }
    .chart-legend > span > i {
        display: inline-block;
        width: 15px;
        height: 15px;
        margin-right: 7px;
        margin-top: -3px;
        vertical-align: middle;
        border-radius: 1px;
    }
</style>
<div class="app-title" id="">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>
    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', '', 'GET');"></a></li>
                    <li><a href="#!" onclick="ajaxSubmitData('dashboard/loadDashboardMenu.htm', 'workpane', '', 'GET');">Dashboard & Reports</a></li>
                    <li class="last active"><a href="#">Item Statistics</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="row small-padding-top">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-1 col-sm-2 text-right"  style="line-height: 2.50em;">                
                <label class="control-label" for="items-select">Item: </label>  
            </div>
            <div class="col-md-3 col-sm-4">
                <div class="form-group">
                    <select class="form-control" id="items-select" name="items-select" width="100%" multiple="multiple">
                        <c:forEach items="${items}" var="item">
                            <option value="${item.itemid}">${item.itemname}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="col-md-1 col-sm-12 text-right"  style="line-height: 2.50em;">                
                <label for="start-year">Start Date</label>
            </div>
            <div class="col-md-2">                
                <div class="input-group">
                    <input style=" margin-bottom: 2%" class="form-control col-md-10" id="start-year" type="text" placeholder="YYYY"/>
                </div>
            </div>
            <div class="col-md-1 col-sm-2 text-right"  style="line-height: 2.50em;">                
                <label for="end-year">End Date</label>
            </div>
            <div class="col-md-2">

                <div class="input-group">
                    <input style=" margin-bottom: 2%" class="form-control col-md-10" id="end-year" type="text" placeholder="YYYY"/>
                </div>
            </div>
            <div class="col-md-2 col-sm-1">
                <button class="btn btn-primary" id="search-item-stats" type="button" style="margin-top: auto; margin-bottom: auto;">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div> 

<!--<div class="row">-->
<!--<div id="item-stats"></div>-->
<%--    <div class="col-md-3">
        <div class="tile">
            <div class="tile-body">
                <hr />
                <div><b>Stock Received:</b> <span class="badge badge-info" style="font-size: small;">${item.received}</span></div>                              
                <hr />
                <div><b>Current Stock:</b> <span class="badge badge-info" style="font-size: small;">${item.currentstock}</span></div>                
            </div>
            <div class="tile-footer"></div>
        </div>  
    </div>--%>
<!--    <div class="col-md-6">
        <div class="line-chart" id="item-stats-chart"></div>
        <div class="line-chart-ct"></div>
    </div>-->
<!--</div>-->
<div class="row">
    <div class="col-md-12">
        <div id="legend" class="chart-legend"></div>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="tile">
            <div class="tile-title text-center">Received Item(s)</div>
            <div class="tile-body">
                <div id="chart-received"></div>
            </div>
            <div class="tile-footer">
                <div id="chart-received-legend" class="chart-legend"></div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="tile">
            <div class="tile-title text-center">Issued Item(s)</div>
            <div class="tile-body">
                <div id="chart-issued"></div>
            </div>
            <div class="tile-footer">
                <div id="chart-issued-legend" class="chart-legend"></div>
            </div>
        </div>        
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="items-table"></div>
    </div>
</div>
<script>
    var serverDate = '${serverdate}';
    var serverYear = '${serveryear}';
    var labels = [];
    var graphItems = [];
    $(function () {
        $('#items-select').select2();
        $("#start-year").datetimepicker({
            pickTime: false,
            format: "YYYY",
            maxDate: new Date(serverDate),
            viewMode: "years",
            minViewMode: "years"
        });
        $("#end-year").datetimepicker({
            pickTime: false,
            format: "YYYY",
            maxDate: new Date(serverDate),
            viewMode: "years",
            minViewMode: "years"
        });
        $('#start-year').val(serverYear);
        $('#end-year').val(serverYear);        
        var startYear = $('#start-year').val();
        var endYear = $('#end-year').val();
        var data = $('#items-select').select2('data');
        var itemIds = [], items = [];
        for (var i in data) {
            itemIds.push(data[i].id);
            items.push({itemid: data[i].id, itemname: data[i].text});
        }
        $('#chart-received-legend').html('');
        $('#chart-issued-legend').html('');
        $("#chart-received").empty();
        $("#chart-issued").empty();
        showChart('dashboard/recieveditemstatistics.htm', items, startYear, endYear, 'chart-received', 'Received');
        showChart('dashboard/issueditemstatistics.htm', items, startYear, endYear, 'chart-issued', 'Issued');
        showTable('dashboard/itemstatisticstable.htm', items, startYear, endYear);
    });
    $('#search-item-stats').on('click', function () {        
        $(this).prop('disabled', true);
        $('#chart-received-legend').html('');
        $('#chart-issued-legend').html('');
        $("#chart-received").empty();
        $("#chart-issued").empty();
        var startYear = $('#start-year').val();
        var endYear = $('#end-year').val();
        var data = $('#items-select').select2('data');
        var itemIds = [], items = [];
        for (var i in data) {
            itemIds.push(data[i].id);
            items.push({itemid: data[i].id, itemname: data[i].text});
        }
        if (items.length > 0) {
            showChart('dashboard/recieveditemstatistics.htm', items, startYear, endYear, 'chart-received', 'Received');
            showChart('dashboard/issueditemstatistics.htm', items, startYear, endYear, 'chart-issued', 'Issued');
            showTable('dashboard/itemstatisticstable.htm', items, startYear, endYear);
        } else {
            $.toast({
                heading: 'Error',
                text: "You have to select an item.",
                icon: 'error',
                hideAfter: 4000,
                position: 'mid-center'
            });
        }
    });
    function showChart(url, items, startYear, endYear, chart, extra) {        
        $.ajax({
            type: 'GET',
            url: url,
            data: {items: JSON.stringify(items), startyear: startYear, endyear: endYear},
            success: function (response, textStatus, jqXHR) {                
                var lineColors = [];
                var data = JSON.parse(response);
                var labels = data.labels;
                var yValues = Object.keys(data.statistics[0]).filter(i => i !== 'month');
                for (i in yValues) {
                    var randomColor = getRandomColor();
                    lineColors.push(randomColor);
                    var legendItem = $('<span></span>').text(labels[yValues[i]] + " " + extra).prepend('<i>&nbsp;</i>');
                    legendItem.find('i').css('backgroundColor', randomColor);
                    $('#' + chart +'-legend').prepend(legendItem);
                }
                displayChart(data.statistics, yValues, lineColors, labels, extra, chart);
                $('#search-item-stats').prop('disabled', false);
            }
        });
    }
    function customizeLabels(row, labels, yValues, extra) {
        var content = "<div class='morris-hover-row-label'>" + row.month + "</div>";
        for (i in yValues) {
            content += "<div class='morris-hover-point' style='color: #0b62a4'>" +
                    labels[yValues[i]] + " " + extra + ": " + row[yValues[i]] +
                    "</div>";
        }
        return content;
    }
    function getRandomColor() {
        var letters = '0123456789ABCDEF';
        var color = '#';
        for (var i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }
    function displayChart(data, yValues, lineColors, labels, extra, chart) {
        $("#" + chart).empty();
        var config = {
            data: data,
            xkey: 'month',
            ykeys: yValues,
            ymax: 'auto',
            ymin: 'auto',
            hideHover: 'auto',
            behaveLikeLine: true,
            resize: true,
            pointFillColors: ['#ffffff'],
            pointStrokeColors: ['black'],
            parseTime: false,
            smooth: true,
            element: chart,
            pointSize: 3,
            gridTextSize: 14,
            labels: yValues,
            lineColors: lineColors,
            hoverCallback: function (index, options, content, row) {
                return customizeLabels(row, labels, yValues, extra);
            }
        };
        Morris.Line(config);
    }
    function showTable(url, items, startYear, endYear){
        $('#items-table').html('');
        $.ajax({
            type: 'GET',
            url: url,
            data: {items: JSON.stringify(items), startyear: startYear, endyear: endYear},
            success: function (response, textStatus, jqXHR) {                
                $('#items-table').html(response);
                $('#search-item-stats').prop('disabled', false);
            }
        });
    }
</script>