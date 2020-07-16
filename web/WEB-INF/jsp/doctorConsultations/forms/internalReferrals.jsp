<%-- 
    Document   : internalReferrals
    Created on : Oct 8, 2018, 7:03:39 AM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<fieldset>
    <div class="row">
        <div class="col-md-1">

        </div> 
        <div class="col-md-5">
            <form>
                <div class="form-group row">
                    <!---->
<!--                    <label for="referredtounit" class="col-sm-4 col-form-label">Select Unit</label>-->
                    <label for="referredtounit" class="col-sm-4 col-form-label">Referral Unit</label>
                    <div class="col-sm-8">
                        <select  class="form-control referredtounit" required>
                            <option value="select">---Select----</option>
                            <c:forEach items="${unitsFound}" var="a">
                                <option id="facunit${a.facilityunitid}" data-servicedid="${a.facilityunitserviceid}" value="${a.facilityunitid}">${a.facilityunitname}</option> 
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="referredspecialty" class="col-sm-4 col-form-label">Referred To Specialty</label>
                    <div class="col-sm-8">
                        <select  class="form-control referredspecialty" required >
                            <option>General</option>
                        </select>
                    </div>
                </div>
                <!---->
<!--                <div class="form-group row">
                    <label for="referredtostaff" class="col-sm-4 col-form-label">Referred To</label>
                    <div class="col-sm-8">
                        <select  class="form-control referredtostaff" required >
                            <option>General</option>
                        </select>
                    </div>
                </div>-->

            </form> 
        </div>
        <div class="col-md-5">
            <form>
<!--                <div class="form-group row">
                    <label for="referredspecialty" class="col-sm-4 col-form-label">Referred To Specialty</label>
                    <div class="col-sm-8">
                        <select  class="form-control referredspecialty" required >
                            <option>General</option>
                        </select>
                    </div>
                </div>-->
                <div class="form-group row">
                    <label for="referralnotes" class="col-sm-4 col-form-label">Referral Notes</label>
                    <div class="col-sm-8">
                        <textarea class="referralnotes form-control" placeholder="Enter Referral Notes" rows="4"></textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-md-12 right" >
                        <button type="button" class="btn btn-secondary" onclick="sendinternalrefrral();">
                            <i class="fa fa-share"></i>  Send
                        </button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-1">

        </div>
    </div>   
</fieldset>
<script>
    var facilityId = ${facilityid};
    function sendinternalrefrral() {
        var facilityunit = $('.referredtounit').val();
        var referralnotes = $('.referralnotes').val();
        var serviceid = $('#facunit' + facilityunit).data('servicedid');
        var patientintervisitid = $('#facilityvisitPatientvisitid').val();
         toggleCloseButton(patientintervisitid); // 

        if (facilityunit === 'select') {
            $('.referredtounit').addClass("focus");
        } else {
            $('.referredtounit').removeClass("focus");
        }
        if (referralnotes === '') {
            $('.referralnotes').addClass("focus");
        } else {
            $('.referralnotes').removeClass("focus");
        }
        if (facilityunit !== 'select' && referralnotes !== '') {
            $.ajax({
                type: 'POST',
                data: { facilityunit: facilityunit, referralnotes: referralnotes, patientvisitid: patientintervisitid }, // 
                url: "doctorconsultation/saveinternalreferredpatient.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data !== '') {
                        $.confirm({
                            title: 'INTERNAL REFERRAL',
                            content: 'Patient Referred Successfully',
                            type: 'green',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Ok',
                                    btnClass: 'btn-green',
                                    action: function () {
										// 
                                        // var queueData = {
                                           // type: 'ADD',
                                           // visitid: parseInt(patientintervisitid),
                                           // serviceid: serviceid,
                                           // staffid: data
                                        // };
                                        // var host = location.host;
                                        // var url = 'ws://' + host + '/IICS/queuingServer';
                                        // var ws = new WebSocket(url);
                                        // ws.onopen = function (ev) {
                                           // ws.send(JSON.stringify(queueData));
                                        // };
                                        // ws.onmessage = function (ev) {
                                           // if (ev.data === 'ADDED') {
                                               // window.location = '#close';
                                               // $('.todayspatients').prop('checked', true);
                                           // }
                                        // };
//                                        $.ajax({
//                                            type: 'POST',
//                                            data: {patientvisitid: parseInt(patientintervisitid)},
//                                            url: "doctorconsultation/closepausedpatient.htm",
//                                            success: function (res) {
//                                                var queueData = {
//                                                    type: 'ADD',
//                                                    visitid: parseInt(patientintervisitid),
//                                                    serviceid: serviceid,
//                                                    staffid: data
//                                                };
//                                                var host = location.host;
//                                                var url = 'ws://' + host + '/IICS/queuingServer';
//                                                var ws = new WebSocket(url);
//                                                ws.onopen = function (ev) {
//                                                    ws.send(JSON.stringify(queueData));
//                                                };
//                                                ws.onmessage = function (ev) {
//                                                    if (ev.data === 'ADDED') {
//                                                        window.location = '#close';
//                                                        $('.todayspatients').prop('checked', true);
//                                                    }
//                                                };                                                
                                        $.ajax({
                                                    type: 'GET',
                                                    url: 'queuingSystem/pushPatient',
                                                    data: { visitid: parseInt(patientintervisitid), serviceid: serviceid, staffid: data },
                                                    success: function (result, textStatus, jqXHR) {                                                                                                                
                                                        stompClient.send('/app/patientqueuesize/' + facilityunit + '/' + facilityId + '/' + serviceid, {}, JSON.stringify({ unitserviceid: serviceid }));
                                                window.location = '#close';
                                                        closeactivatepatienttab2();
                                                $('.todayspatients').prop('checked', true);
                                                    },
                                                    error: function (jqXHR, textStatus, errorThrown) {                                                        
                                                        console.log(jqXHR);
                                                        console.log(textStatus);
                                                        console.log(errorThrown);
                                            }
                                        });
//                                            }
//                                        });                                        
                                        //////////////////////
                                    }
                                }
                            }
                        });
                    } else {
                        $.confirm({
                            title: 'Encountered an error!',
                            content: 'Something went Wrong!!!',
                            type: 'red',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Ok',
                                    btnClass: 'btn-red',
                                    action: function () {
                                    }
                                },
                                close: function () {
                                }
                            }
                        });
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) { 
                    console.log(jqXHR);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });
        }
    }
</script>
