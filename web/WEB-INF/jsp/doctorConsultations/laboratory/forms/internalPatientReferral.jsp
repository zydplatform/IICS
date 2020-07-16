<%-- 
    Document   : internalPatientReferral
    Created on : Oct 7, 2018, 10:40:16 AM
    Author     : HP
--%>
<%@include file="../../../include.jsp" %>
<div class="row">
    <div class="col-md-1">

    </div> 
    <div class="col-md-5">
        <form>
            <div class="form-group row">
                <label for="referredtounit" class="col-sm-4 col-form-label">Select Unit</label>
                <div class="col-sm-8">
                    <select  class="form-control labreferredtounit" required >
                        <option value="select">---Select----</option>
                        <c:forEach items="${unitsFound}" var="a">
                            <option id="labfacunit${a.facilityunitid}" data-servicedid="${a.facilityunitserviceid}" value="${a.facilityunitid}">${a.facilityunitname}</option> 
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label for="referredtostaff" class="col-sm-4 col-form-label">Referred To</label>
                <div class="col-sm-8">
                    <select  class="form-control referredtostaff" required >
                        <option>----Select-----</option>
                    </select>
                </div>
            </div>

        </form> 
    </div>
    <div class="col-md-5">
        <form>
            <div class="form-group row">
                <label for="referredspecialty" class="col-sm-4 col-form-label">Referred To Specialty</label>
                <div class="col-sm-8">
                    <select  class="form-control referredspecialty" required >
                        <option>General</option>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label for="referralnotes" class="col-sm-4 col-form-label">Referral Notes</label>
                <div class="col-sm-8">
                    <textarea class="labreferralnotes form-control" placeholder="Enter Referral Notes" rows="4"></textarea>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-12 right" >
                    <button type="button" class="btn btn-secondary" onclick="sendlabinternalrefrral();">
                        <i class="fa fa-share"></i>  Send
                    </button>
                </div>
            </div>
        </form>
    </div>
    <div class="col-md-1">

    </div>
</div>
<script>
    var facilityId = ${facilityid};
    function sendlabinternalrefrral() {
        var facilityunit = $('.labreferredtounit').val();
        var referralnotes = $('.labreferralnotes').val();
        var serviceid = $('#labfacunit' + facilityunit).data('servicedid');
        var patientintervisitid = $('#facilityLabvisitPatientvisitid').val();

        if (facilityunit !== 'select' && referralnotes !== '') {
            $.ajax({
                type: 'POST',
                data: {facilityunit: facilityunit, referralnotes: referralnotes},
                url: "doctorconsultation/saveinternalreferredpatient.htm",
                success: function (data) {
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
//                                        var queueData = {
//                                            type: 'ADD',
//                                            visitid: parseInt(patientintervisitid),
//                                            serviceid: serviceid,
//                                            staffid: data
//                                        };
//                                        var host = location.host;
//                                        var url = 'ws://' + host + '/IICS/queuingServer';
//                                        var ws = new WebSocket(url);
//                                        ws.onopen = function (ev) {
//                                            ws.send(JSON.stringify(queueData));
//                                        };
//                                        ws.onmessage = function (ev) {
//                                            if (ev.data === 'ADDED') {
//                                                window.location = '#close';
//                                                $('.todayspatients').prop('checked', true);
//                                            }
//                                        };                                        
                                        $.ajax({
                                            type: 'GET',
                                            url: 'queuingSystem/pushPatient',
                                            data: { visitid: parseInt(patientintervisitid), serviceid: serviceid, staffid: data },
                                            success: function (result, textStatus, jqXHR) {
                                                stompClient.send('/app/patientqueuesize/' + facilityunit + '/' + facilityId + '/' + serviceid, {}, JSON.stringify({ unitserviceid: serviceid }));
                                                window.location = '#close';
                                                $('.todayspatients').prop('checked', true);
                                            },
                                            error: function (jqXHR, textStatus, errorThrown) {                                                        
                                                console.log(jqXHR);
                                                console.log(textStatus);
                                                console.log(errorThrown);
                                            }
                                        }); 
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
                }
            });
        }
    }
</script>
