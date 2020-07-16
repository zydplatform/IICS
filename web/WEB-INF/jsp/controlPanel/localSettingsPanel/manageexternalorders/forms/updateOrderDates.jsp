<%-- 
    Document   : addfacilityexternalorder
    Created on : Aug 16, 2018, 12:37:46 PM
    Author     : RESEARCH
--%>


<style>
    .focus {
        border-color:red;
    }
</style>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <form id="entryformeditfinancialyrs">
                <input class="form-control startdateupdatez" value="${externalfacilityordersid}" id="externalfacilityordersid" type="hidden">
                <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">ORDERING DATES UPDATE</span></div>
                <div class="form-group required">
                    <label class="control-label">START DATE:</label>
                    <input class="form-control startdateupdatez" value="${orderingstart}" id="editorderingstartdates" type="text">
                </div>
                <div class="form-group required village">
                    <label class="control-label">END DATE:</label>
                    <input class="form-control enddateupdatez" value="${orderingenddate}" id="editorderingenddates" type="text">
                </div>
                <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">APPROVAL DATES UPDATE</span></div>
                <div class="form-group required">
                    <label class="control-label">START DATE:</label>
                    <input class="form-control startdateupdatez" value="${approvalstartdate}" id="editapprovalstartdates" type="text">
                </div>
                <div class="form-group required village">
                    <label class="control-label">END DATE:</label>
                    <input class="form-control enddateupdatez" value="${approvalenddate}" id="editapprovalenddates" type="text">
                </div>
                <br>
                <div class="tile-footer"></div>
            </form>
        </div>
    </div>
</div>
<script>
    $('#editorderingstartdates').datetimepicker({   
        pickTime: false,
        format: "DD/MM/YYYY",
        defaultDate: new Date('${orderingstart}')
    });
    $('#editapprovalstartdates').datetimepicker({
        pickTime: false,
        format: "DD/MM/YYYY",
        defaultDate: new Date('${approvalstartdate}')
    });
        $('#editorderingenddates').focus(function () {
        document.getElementById('editorderingenddates').value = '';
        var editorderstartdates = $('#editorderingstartdates').val();
        if (editorderstartdates === '') {
            $('#editorderingstartdates').addClass("focus");
        } else {
            $('#editorderingstartdates').removeClass("focus");
            var fields = editorderstartdates.split('/');
            var day = parseInt(fields[0]);
            var month = parseInt(fields[1]);
            var yr = parseInt(fields[2]);
            var setmaxend = 0;
            if (month <= 9) {
                setmaxend = '0' + month;
            } else {
                setmaxend = month;
            }
            if ('${types}' !== 'APPROVAL' || '${types}' !== 'PROCURING') {
                $('#editorderingenddates').datetimepicker({
                    pickTime: false,
                    format: "DD/MM/YYYY",
                    minDate: new Date(yr + 1, setmaxend, '02'),
                    maxDate: new Date(yr + 2, setmaxend, '01'),
                    defaultDate: new Date('${enddate}')
                });
            } else {
                $('#editorderingenddates').datetimepicker({
                    pickTime: false,
                    format: "DD/MM/YYYY",
                    maxDate: new Date(yr + 2, setmaxend, '01'),
                    defaultDate: new Date('${enddate}')
                });
            }
        }
    });
    $('#editapprovalenddates').focus(function () {
        document.getElementById('editapprovalenddates').value = '';
        var editapprovalstartdates = $('#editapprovalstartdates').val();
        if (editapprovalstartdates === '') {
            $('#editapprovalstartdates').addClass("focus");
        } else {
            $('#editapprovalstartdates').removeClass("focus");
            var fields = editapprovalstartdates.split('/');
            var day = parseInt(fields[0]);
            var month = parseInt(fields[1]);
            var yr = parseInt(fields[2]);
            var setmaxend = 0;
            if (month <= 9) {
                setmaxend = '0' + month;
            } else {
                setmaxend = month;
            }
            if ('${types}' !== 'APPROVAL' || '${types}' !== 'PROCURING') {
                $('#editapprovalenddates').datetimepicker({
                    pickTime: false,
                    format: "DD/MM/YYYY",
                    minDate: new Date(yr + 1, setmaxend, '02'),
                    maxDate: new Date(yr + 2, setmaxend, '01'),
                    defaultDate: new Date('${enddate}')
                });
            } else {
                $('#editapprovalenddates').datetimepicker({
                    pickTime: false,
                    format: "DD/MM/YYYY",
                    maxDate: new Date(yr + 2, setmaxend, '01'),
                    defaultDate: new Date('${enddate}')
                });
            }
        }
    });
</script>