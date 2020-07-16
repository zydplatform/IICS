`
<%@include file="../../include.jsp"%>
<form class="form-horizontal">
    <div class="col-md-12">
        <div id="horizontalwithwords"><span class="pat-form-heading">File Information</span></div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4 boldedlabels">
            File Number:
        </div>
        <div class="col-md-8 boldedlabels"id="updateFileNo">
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4 boldedlabels">
            Patient Name:
        </div>
        <div class="col-md-8 boldedlabels"id="updatePatientName">
        </div>
    </div>
    <br>
    <div class="col-md-12">
        <div id="horizontalwithwords"><span class="pat-form-heading">Update Location</span></div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4 boldedlabels">
            Zone Label:
        </div>
        <div class="col-md-8 boldedlabels">
            <select class="form-control form-control-sm" id="updatezoneid">
                <option value="">Update Zones</option>
                <c:forEach items="${zones}" var="zone">
                    <option value="${zone.zoneid}">${zone.zoneName}</option>
                </c:forEach>  
            </select>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4 boldedlabels">
            Bay Label:
        </div>
        <div class="col-md-8 boldedlabels">
            <select class="form-control form-control-sm" id="updatebayid">
                <option value="">Update Bays</option>
            </select>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4 boldedlabels">
            Bay Row Label:
        </div>
        <div class="col-md-8 boldedlabels">
            <select class="form-control form-control-sm" id="updatebayrowid">
                <option value="">update Bay Rows</option>
            </select>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4 boldedlabels">
            Cell Label:
        </div>
        <div class="col-md-8 boldedlabels">
            <select class="form-control form-control-sm" id="updatecellid">
                <option value="">Update Cells</option>
            </select>
        </div>
    </div>
    <br>
</form>


<script>
    $(document).ready(function () {
        var zoneid=$('#zonelevellidvalue').val();
        var bayid=$('#baylevelidvalue').val();
        var bayrowid= $('#bayrowlevelidvalue').val();
        $('#updatePatientName').html($('#pnamelabel').val());
        $('#updateFileNo').html($('#filenovalue').val());
        /* $('#updatezoneid').append("<option value=" + $('#zonelevellidvalue').val() + ">" + $('#zonelevellid').html() + "</option>");
        $('#updatebayid').append("<option value=" + $('#baylevelidvalue').val() + ">" + $('#baylevelid').html() + "</option>");
         $('#updatebayrowid').append("<option value=" + $('#bayrowlevelidvalue').val() + ">" + $('#bayrowlabelvalue').val() + "</option>");
         $('#updatecellid').append("<option value=" + $('#celllevelidvalue').val() + ">" + $('#celllevelid').html() + "</option>");
         */
        var data = {zoneid:zoneid};
         fetchlocation('filelocation/fetchbays.htm', 'updatebayid', data, 'GET', 'initial');
         var data = {bayid:bayid};
         fetchlocation('filelocation/fetchbayrows.htm', 'updatebayrowid', data, 'GET', 'initial');
         var data = {bayrowid:bayrowid};
         fetchlocation('filelocation/fetchcells.htm', 'updatecellid', data, 'GET', 'initial');
        

        $("#updatezoneid").change(function () {
            zoneid = $('#updatezoneid').val();
            var data = {zoneid: zoneid};
            fetchlocation('filelocation/fetchbays.htm', 'updatebayid', data, 'GET', 'update');
     $('#updatebayrowid').html("");   
     $('#updatecellid').html("");  
    });
        $("#updatebayid").change(function () {
            bayid = $('#updatebayid').val();
            var data = {bayid: bayid};
            fetchlocation('filelocation/fetchbayrows.htm', 'updatebayrowid', data, 'GET', 'update');
        });
        $("#updatebayrowid").change(function () {
            bayrowid = $('#updatebayrowid').val();
            var data = {bayrowid: bayrowid};
            fetchlocation('filelocation/fetchcells.htm', 'updatecellid', data, 'GET', 'update');
        });
    });
    function fetchlocation(Url, respDiv, data, method, status) {
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            timeout: 98000,
            success: function (resp) {
                var obj = JSON.parse(resp);
                var options = "";
                if (respDiv === 'updatebayid') {
                    for (var k = 0; k < obj.length; k++) {
                        options += "<option value=" + obj[k].zonebayid + ">" + obj[k].baylabel + "</option>";
                    }
                    if (status === 'initial') {
                        $('#' + respDiv).append(options);
                    } else {
                        $('#' + respDiv).html(options);
                    }


                }
                if (respDiv === 'updatebayrowid') {
                    for (var k = 0; k < obj.length; k++) {

                        options += "<option value=" + obj[k].bayrowid + ">" + obj[k].rowlabel + "</option>";
                    }
                    if (status === 'initial') {
                        $('#' + respDiv).append(options);
                    } else {
                        $('#' + respDiv).html(options);
                    }
                }
                if (respDiv === 'updatecellid') {
                    for (var k = 0; k < obj.length; k++) {
                        options += "<option value=" + obj[k].bayrowcellid + ">" + obj[k].celllabel + "</option>";
                    }
                    if (status === 'initial') {
                        $('#' + respDiv).append(options);
                    } else {
                        $('#' + respDiv).html(options);
                    }
                }

            },
            error: function (jqXHR, error, errorThrown) {
                if (Url !== 'checkUserNotification.htm') {
                    if (jqXHR.status && jqXHR.status === 400) {
                        alert('Server returned an Error, contact admin');
                    } else if (error === "timeout") {
                        alert("Request timed out, contact admin");
                    } else {
                        alert("Something went wrong, contact system admin");
                    }
                }
            }
        });
    }

    function ajaxSubmitUpdateLocation(Url, method) {
        var fileno = $('#filenovalue').val();
        var locationid = $('#locationidvalue').val();
        var zoneid = $('#updatezoneid').val();
        var cellid = $('#updatecellid').val();
        if (cellid != '' && cellid != null) {
            var data = {locationid: locationid, zoneid: zoneid, cellid: cellid, fileno: fileno};
            $.ajax({
                type: method,
                data: data,
                cache: false,
                url: Url,
                timeout: 98000,
                success: function (resp) {
                    if (resp !== 'failed') {
                        $.alert({
                            title: 'Feed Back!',
                            content: 'Succcessfully Updated File Location',
                        });
                        var obj = JSON.parse(resp);
                        for (var k = 0; k < obj.length; k++) {
                            $('#locationidvalue').val(obj[k].locationid);
                            $('#celllevelid').html(obj[k].celllabel);
                            $('#zonelevellid').html(obj[k].zonelabel);
                            $('#baylevelid').html(obj[k].baylabel);
                            $('#bayrowlevelid').html(obj[k].rowlabel);
                            $('#bayrowlevelidvalue').html(obj[k].bayrowid);
                            $('#zonelevellidvalue').val(obj[k].zoneid);
                            $('#baylevelidvalue').val(obj[k].zonebayid);
                            $('#celllevelidvalue').val(obj[k].bayrowcellid);
                        }
                        window.location = '#locationORassignment';
                        initDialog('fileStorageDetails');
                    } else {
                        $.alert({
                            title: 'Feed Back!',
                            content: 'Failed To Update File Location',
                        });
                    }
                },
                error: function (jqXHR, error, errorThrown) {
                    if (Url !== 'checkUserNotification.htm') {
                        if (jqXHR.status && jqXHR.status === 400) {
                            alert('Server returned an Error, contact admin');
                        } else if (error === "timeout") {
                            alert("Request timed out, contact admin");
                        } else {
                            //                    alert("Something went wrong, contact system admin");
                        }
                    }
                }
            });
        } else {
            alert('Please Fill All Empty Fields');
        }
    }
</script>