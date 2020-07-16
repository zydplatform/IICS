<%-- 
    Document   : todayspatients
    Created on : Sep 26, 2018, 8:36:31 AM
    Author     : HP
--%>
<div class="row">
    <div class="col-md-12">
        <main id="main">
            <input id="tab1" class="tabCheck todayslabpatients" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab1">Patients</label>
            <input id="tab2" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab2">Patient Register</label>

            <section class="tabContent" id="content1">
                <div style="margin: 10px;">
                    <fieldset style="min-height:100px;">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="pull-right menu-icon" style="margin-right: 201px;" id="pickPatientForLaboratory">
                                                    <div class="icon-content">
                                                        <img src="static/img/queue-hover.png" class="laboratoryPatientsQueues pull-right" border="1" width="90" height="70">
                                                    </div><br>
                                                    <div class="icon-content center">
                                                        <h6>
                                                            <span class="badge badge-info" id="queuedLabPatients"></span>
                                                            <input id="nextLabPatient" type="hidden" value="0"/>
                                                        </h6>
                                                    </div>
                                                </div> 
                                            </div>
                                        </div><br>
                                        <div class="row" style="margin-top: 31px;">
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="card-counter primary">
                                                            <i class="fa fa-male"></i><i class="fa fa-female"></i><i class="fa fa-child"></i>
                                                            <span class="count-numbers">0</span>
                                                            <span class="count-name">Total Patient Serviced</span>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">

                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="card-counter info">
                                                            <i class="fa fa-clock-o"></i>
                                                            <span class="count-numbers">0</span>
                                                            <span class="count-name">Average Waiting Time</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </section>
            <section class="tabContent" id="content2">
                <div style="margin: 10px;">
                    <fieldset style="min-height:100px;">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-5 col-sm-6"></div>
                                    <div class="col-md-2 col-sm-4">
                                        <form>
                                            <div class="form-group">
                                                <label for="">Date</label>
                                                <input class="form-control" id="receivedDate" type="text" placeholder="DD-MM-YYYY">
                                            </div>
                                        </form>
                                    </div>
                                    <div class="col-md-2 col-sm-1" style="margin-top: 20px;">
                                        <button class="btn btn-primary" id="fetchlabPatients" type="button">
                                            <i class="fa fa-lg fa-fw fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12"  id="todayslabpatientsdiv"></div>
                        </div>  
                    </fieldset>
                </div>
            </section>
        </main>
    </div>
</div>
<script>
    $("#receivedDate").datetimepicker({
        pickTime: false,
        format: "DD-MM-YYYY",
        maxDate: new Date(),
        defaultDate: new Date()
    });
</script>