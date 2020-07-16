`
<%@include file="../../include.jsp"%>
<div class="col-md-12">
    <div class="col-md-12">
        <div id="horizontalwithwords"><span class="pat-form-heading">File Information</span></div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4 boldedlabels">
            File Number
        </div>
        <div class="col-md-8 boldedlabels">
            <input class="form-control form-control-sm" id="fileNo" type="text" value="${fileno}"readonly="true">
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4 boldedlabels">
            Patient Name
        </div>
        <div class="col-md-8 boldedlabels">
            <input class="form-control form-control-sm" id="patientNo" type="hidden" value=""/>
            <div id="search-form_3">
                <input id="patientSearch" type="text" value="${fileSearch}" oninput="searchPatient()" placeholder="Search Patient" onfocus="displayPatientSearchResults()" class="search_3 dropbtn"/>
            </div>
            <div id="myPatientDropdown" class="search-content">

            </div></div>
    </div>
    <br>
    <br>
    <div class="col-md-12">
        <div id="horizontalwithwords"><span class="pat-form-heading">Allocation Information</span></div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4 boldedlabels">
            Zone Label
        </div>
        <div class="col-md-8 boldedlabels">
            <select class="form-control form-control-sm" id="zoneid">
                <option value="" id="getzonelevelid">--Select Zone--</option>
                <c:forEach items="${zones}" var="zone">
                    <option value="${zone.zoneid}">${zone.zoneName}</option>
                </c:forEach>  
            </select>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4 boldedlabels">
            Bay Label
        </div>
        <div class="col-md-8 boldedlabels">
            <select class="form-control form-control-sm" id="bayid">
                <option value="" >--Select Bay--</option>
            </select>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4 boldedlabels">
            Bay Row Label
        </div>
        <div class="col-md-8 boldedlabels">
            <select class="form-control form-control-sm" id="bayrowid">
                <option value="" >--Select Bay Row--</option>
            </select>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-4 boldedlabels">
            Cell Label
        </div>
        <div class="col-md-8 boldedlabels">
            <select class="form-control form-control-sm" id="cellid">
                <option value="" >--Select Cell--</option>
            </select>
        </div>
    </div>
    <br>
</div>
<script>
    $(document).ready(function () {
        searchPatient();
        displayPatientSearchResults();
        $("#zoneid").change(function () {
            var zoneid = $('#zoneid').val();
            if (zoneid !== '') {
                var data = {zoneid: zoneid};
                fetchlocation('filelocation/fetchbays.htm', 'bayid', data, 'GET');
            }
        });
        $("#bayid").change(function () {
            var bayid = $('#bayid').val();
            if (bayid !== '') {
                var data = {bayid: bayid};
                fetchlocation('filelocation/fetchbayrows.htm', 'bayrowid', data, 'GET');
            }
        });
        $("#bayrowid").change(function () {
            var bayrowid = $('#bayrowid').val();
            if (bayrowid !== '') {
                var data = {bayrowid: bayrowid};
                fetchlocation('filelocation/fetchcells.htm', 'cellid', data, 'GET');
            }
        });
    });
    function fetchlocation(Url, respDiv, data, method) {
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            timeout: 98000,
            success: function (resp) {
                var obj = JSON.parse(resp);
                var options = "";
                if (respDiv === 'bayid') {
                    for (var k = 0; k < obj.length; k++) {
                        options += "<option value=" + obj[k].zonebayid + ">" + obj[k].baylabel + "</option>";
                    }
                    $('#' + respDiv).append(options);

                }
                if (respDiv === 'bayrowid') {
                    for (var k = 0; k < obj.length; k++) {

                        options += "<option value=" + obj[k].bayrowid + ">" + obj[k].rowlabel + "</option>";
                    }
                    $('#' + respDiv).append(options);
                }
                if (respDiv === 'cellid') {
                    for (var k = 0; k < obj.length; k++) {
                        options += "<option value=" + obj[k].bayrowcellid + ">" + obj[k].celllabel + "</option>";
                    }
                    $('#' + respDiv).append(options);
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
    /*******************************************************/
    function checkIfFileExist(Url, method, patientId, fileNo, fileStatus) {
        var data = {patientId: patientId, fileNo: fileNo};
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            timeout: 98000,
            success: function (resp) {
                if (resp === false)
                {
                    fileStatus = false;
                } else {
                    fileStatus = true;
                    alert('User Already Has A File!');
                }
            },
            error: function (jqXHR, error, errorThrown) {
                if (Url !== 'checkUserNotification.htm') {
                    if (error === "timeout") {
                        alert("Request timed out, contact admin");
                    }
                }
            }
        });
    }
    function ajaxSubmitNewFile(Url, method) {
        var patientId = $('#patientNo').val();
        var zoneid = $('#zoneid').val();
        var cellid = $('#cellid').val();
        var fileNo = $('#fileNo').val();
        if (patientId != '' && cellid != '' && cellid != null) {
            var data = {
                patientId: patientId, fileNo: fileNo, zoneid: zoneid,
                cellid: cellid};
            $.ajax({
                type: method,
                data: data,
                cache: false,
                url: Url,
                timeout: 98000,
                success: function (resp) {
                    if (resp === 'success') {
                        ajaxSubmitData('patients/list.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        window.location = '#close';
                        alert('Successfully Created New File');
                    } else {
                        alert('Failed To Create A file!');
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
    function displayPatientSearchResults() {

        document.getElementById("myPatientDropdown").classList.add("showSearch");
    }
    function searchPatient() {
        var patientSearch = trim($('#patientSearch').val());
        function trim(x) {
            return x.replace(/^\s+|\s+$/gm, '');
        }
        $.ajax({
            type: "POST",
            cache: false,
            url: "patients/searchpatient.htm",
            data: {searchValue: patientSearch},
            success: function (response) {
                $('#myPatientDropdown').html(response);
            }
        });
    }
    function clearSearchResult() {
        document.getElementById('searchResults').style.display = 'none';
    }

    window.onclick = function (event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("search-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('showSearch')) {
                    openDropdown.classList.remove('showSearch');
                }
            }
        }
    };
</script>