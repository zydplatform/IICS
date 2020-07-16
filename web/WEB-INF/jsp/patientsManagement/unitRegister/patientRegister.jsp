<%-- 
    Document   : patientRegister
    Created on : Sep 6, 2018, 2:54:48 PM
    Author     : IICS
--%>
<!--Dashboard Cards-->
<link rel="stylesheet" type="text/css" href="static/res/css/card/bootstrap-extended.css">
<link rel="stylesheet" type="text/css" href="static/res/css/card/colors.css">
<link rel="stylesheet" type="text/css" href="static/res/css/card/components.css">
<link rel="stylesheet" type="text/css" href="static/res/css/card/vendors.min.css">
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
                    <li><a href="#" onclick="ajaxSubmitData('patient/patientmenu.htm', 'workpane', '', 'GET');">Patient Management</a></li>
                    <li class="last active"><a href="#">Unit Register</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-5 col-sm-6"></div>
            <div class="col-md-2 col-sm-4">
                <form>
                    <div class="form-group">
                        <label for="">Registration Date</label>
                        <input class="form-control" id="reportDate" type="text" placeholder="DD-MM-YYYY">
                    </div>
                </form>
            </div>
            <div class="col-md-2 col-sm-1">
                <button class="btn btn-primary" id="fetchPatients" type="button">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12"  id="dayReport"></div>
</div>
<script>
    breadCrumb();
    var reportDate;
    var serverDate = '${serverdate}';
    $(document).ready(function () {
        $("#reportDate").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });
        reportDate = $('#reportDate').val();
        $.ajax({
            type: 'POST',
            data: {date: reportDate},
            url: 'patient/fetchUnitPatientRegister.htm',
            success: function (report) {
                $('#dayReport').html(report);
            }
        });

        $('#fetchPatients').click(function () {
            $('#dayReport').html('');
            reportDate = $('#reportDate').val();
            $.ajax({
                type: 'POST',
                data: {date: reportDate},
                url: 'patient/fetchUnitPatientRegister.htm',
                success: function (report) {
                    $('#dayReport').html(report);
                }
            });
        });

        $('#printRegister').click(function () {
            printUnitRegister();
        });
    });

    function printUnitRegister() {
        reportDate = $('#reportDate').val();
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Print Patient Register.',
            content: '<div id="printBox" class="center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>',
            type: 'purple',
            typeAnimated: true,
            boxWidth: '70%',
            useBootstrap: false,
            buttons: {
                close: {
                    text: 'Close',
                    action: function () {

                    }
                }
            },
            onContentReady: function () {
                var printBox = this.$content.find('#printBox');
                $.ajax({
                    type: 'GET',
                    data: {date: reportDate},
                    url: 'patient/printUnitRegister.htm',
                    success: function (res) {
                        if (res !== '') {
                            var objbuilder = '';
                            objbuilder += ('<object width="100%" height="500px" data="data:application/pdf;base64,');
                            objbuilder += (res);
                            objbuilder += ('" type="application/pdf" class="internal">');
                            objbuilder += ('<embed src="data:application/pdf;base64,');
                            objbuilder += (res);
                            objbuilder += ('" type="application/pdf"/>');
                            objbuilder += ('</object>');
                            printBox.html(objbuilder);
                        } else {
                            printBox.html('<div class="bs-component">' +
                                    '<div class="alert alert-dismissible alert-warning">' +
                                    '<h4>Warning!</h4>' +
                                    '<p>Error generating PDF. Please <strong>Refresh</strong> & Try Again.</p></div></div>'
                                    );
                        }
                    }
                });
            }
        });
    }
</script>