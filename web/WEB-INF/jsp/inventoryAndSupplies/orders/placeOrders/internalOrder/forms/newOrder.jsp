<%-- 
    Document   : newOrder
    Created on : Apr 16, 2018, 5:41:35 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .error
    {
        border:1px solid red;
    }
    .label2 {
        height: 25px;
        margin:0 0 .5em;
    }
    .label2 {
        margin-right: .5em;
    }
</style>

<table style="margin: 0px; width: 90%;">
    <tbody>
        <tr>
            <td align="center">
                <fieldset style="margin: 10px; width:80%;">
                    <legend>Create An Internal Order</legend>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <form class="form-horizontal">
                                        <div class="form-group row">
                                            <label class="control-label col-md-3">Order Type</label>
                                            <div class="col-md-8">
                                                <h6>Internal Order</h6>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-3">Order Origin</label>
                                            <div class="col-md-8">
                                                <input class="form-control col-md-8" type="text" placeholder="Logged In Unit" value="${loggedinfacilityunitname}" disabled="true">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-3">Select Supplier</label>
                                            <div class="col-md-8">
                                                <select class="form-control col-md-8" id="selectordersupplier"> 
                                                    <option value="select">--------select--------</option>
                                                    <c:forEach items="${orderlist}" var="item">
                                                        <option  value="${item.facilityunitsupplierid}~${item.facilityunitname}">${item.facilityunitname}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-3">Emergency Order</label>
                                            <div class="col-md-8">
                                                <select class="form-control col-md-8" id="ordercriteria" onchange="checkdateselected(this.value);"> 
                                                    <option value="No">No</option>
                                                    <option value="Yes">Yes</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div id="dateOrderneeded">
                                            <div class="form-group row">
                                                <label class="control-label col-md-3">Date Needed</label>
                                                <div class="col-md-8">
                                                    <input class="form-control col-md-8" type="text" placeholder="dd/mm/yyyy" id="dateneeded" onchange="dateorderinput()">
                                                </div>
                                            </div> 
                                        </div>

                                        <div id="yourscheduleddatediv" style="display: none;">
                                            <div class="form-group row">
                                                <label class="control-label col-md-3" id="yourschednum">Your Schedule:</label>
                                                <div class="col-md-8">
                                                    <div id="yourscheduleddate">

                                                    </div>
                                                </div>
                                            </div> 
                                        </div>
                                    </form>

                                </div>
                                <div class="tile-footer">
                                    <div class="row">
                                        <div class="col-md-8 col-md-offset-3">
                                            <button class="btn btn-primary" onclick="additemstofacilityunitorder();" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>Add Items To Order</button>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary" onclick="ajaxSubmitData('ordersmanagement/placeordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Refresh</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </td>
        </tr>
    </tbody>
</table>
<div class="row">
    <div class="col-md-12">
        <div id="additemsordersdialog" class="modalDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleoralreadyheading">Create & Add Items To Order</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="additemstoorderdiv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Getting Items Please Wait...........</h3>
                                        </div>
                                    </div>
                                </div>
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
    if ('${zone}' === 'nozone') {
        $.confirm({
            title: 'NO Storage Space',
            content: 'There Is No Created Storage Space First Create Storage Space!',
            type: 'red',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Ok',
                    btnClass: 'btn-red',
                    action: function () {
                        ajaxSubmitData('ordersmanagement/ordershomemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                },
                close: function () {
                    ajaxSubmitData('ordersmanagement/ordershomemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            }
        });
    } else if ('${catalogue}' === 'nounitcatalogue') {
//        $.confirm({
//            title: 'NO Facility Unit Catalogue',
//            content: 'Your Unit Has No Verified Unit Catalogue',
//            type: 'red',
//            icon: 'fa fa-warning',
//            typeAnimated: true,
//            buttons: {
//                tryAgain: {
//                    text: 'Ok',
//                    btnClass: 'btn-red',
//                    action: function () {
//                        ajaxSubmitData('ordersmanagement/ordershomemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                    }
//                },
//                close: function () {
//                    ajaxSubmitData('ordersmanagement/ordershomemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                }
//            }
//        });
    }
    $('#dateneeded').datetimepicker({
        pickTime: false,
        format: "DD/MM/YYYY",
        minDate: new Date(serverDate)
    });
    function additemstofacilityunitorder() {
        var criteria = $('#ordercriteria').val();
        var selectordersupplier = $('#selectordersupplier').val();
        var dateneeded = $('#dateneeded').val();
        if (selectordersupplier === 'select') {
            $('#selectordersupplier').addClass('error');
        } else if (dateneeded === '' && criteria === 'No') {
            $('#dateneeded').addClass('error');
            $('#selectordersupplier').removeClass('error');
        } else {
            $('#selectordersupplier').removeClass('error');
            $('#dateneeded').removeClass('error');

            var fields = selectordersupplier.split('~');
            var facilitysupplierid = fields[0];
            var facilityunitname = fields[1];

            ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilitysupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname, 'GET');
            window.location = '#additemsordersdialog';
            initDialog('modalDialog');
        }

    }
    $('#selectordersupplier').change(function () {

        var criteria = $('#ordercriteria').val();
        var selectordersupplier = $('#selectordersupplier').val();
        var dateneeded = $('#dateneeded').val();

        document.getElementById('dateneeded').value = '';
        document.getElementById('ordercriteria').value = 'No';
        document.getElementById('yourscheduleddatediv').style.display = 'none';
        var selectordersupplier = $('#selectordersupplier').val();
        if (selectordersupplier === 'select') {
            $('#selectordersupplier').addClass('error');
        } else {
            var fields = selectordersupplier.split('~');
            var facilitysupplierid = fields[0];
            var facilityunitname = fields[1];
            $('#selectordersupplier').removeClass('error');
            $.ajax({
                type: 'POST',
                data: {supplier: facilitysupplierid},
                url: "ordersmanagement/checkforexistingiternalorder.htm",
                success: function (data) {
                    if (data === 'existing') {
                        ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilitysupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname, 'GET');
                        window.location = '#additemsordersdialog';
                        initDialog('modalDialog');
                    }
                }
            });
        }
    });
    function dateorderinput() {
        var dateneeded = $('#dateneeded').val();
        var selectordersupplier = $('#selectordersupplier').val();
        var fields = selectordersupplier.split('~');
        var facilitysupplierid = fields[0];
        if (dateneeded.length === 0) {
            $('#dateneeded').addClass('error');
        } else {
            if (selectordersupplier === 'select') {
                $('#selectordersupplier').addClass('error');
                document.getElementById('dateneeded').value = '';
            } else {
                $('#selectordersupplier').removeClass('error');
                if (dateneeded.length >= 10 && facilitysupplierid !== 'select') {
                    $.ajax({
                        type: 'POST',
                        data: {date: dateneeded, ordersupplier: facilitysupplierid},
                        url: "ordersmanagement/getsuppliersupliesday.htm",
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            if (data !== 'no') {
                                document.getElementById('yourscheduleddatediv').style.display = 'block';
                                var fields = data.split('~');
                                var name = fields[0];
                                var street = fields[1];
                                var number = fields[2];
                                $('#yourschednum').html('Schedule' + '( ' + '<a href="#!" onclick="getunitscheduledays(' + facilitysupplierid + ');">' + number + ' ' + 'Day(s)</a> ' + ')');
                                $('#yourscheduleddate').html('<a href="#!" onclick="setunitscheduledays(\'' + street + '\');">' + name + '<span class=" col-md-6 badge badge-secondary"><strong>' + street + '</strong></span></a>');
                            } else if (data === '') {
                                document.getElementById('yourscheduleddatediv').style.display = 'none';
                            }
                        }
                    });
                }
            }
            $('#dateneeded').removeClass('error');
        }
    }
    function canceladditemsdialog() {
        window.location = '#close';
        ajaxSubmitData('ordersmanagement/placeordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    var selecteddayofsupply = new Set();
    function getunitscheduledays(facilitysupplierid) {
        $.ajax({
            type: 'GET',
            data: {facilitysupplierid: facilitysupplierid},
            url: "ordersmanagement/scheduledays.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'Choose From Your Schedules!',
                    typeAnimated: true,
                    draggable: true,
                    type: 'orange',
                    content: '' +
                            '<form action="" class="formName">' +
                            data
                            +
                            '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Set',
                            btnClass: 'btn-orange',
                            action: function () {
                                getselectedday();
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
        });

    }
    function setunitscheduledays(date) {
        document.getElementById('dateneeded').value = date;
    }
    function checkdateselected(value) {
        if (value === 'Yes') {
            document.getElementById('dateOrderneeded').style.display = 'none';
            document.getElementById('yourscheduleddatediv').style.display = 'none';
        } else {
            document.getElementById('dateOrderneeded').style.display = 'block';
        }
    }
</script>

