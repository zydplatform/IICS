<%-- 
    Document   : orderedit
    Created on : Aug 22, 2018, 10:15:53 PM
    Author     : SAMINUNU
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
                <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">${types} DATES UPDATE</span></div>

                <div class="form-group required">
                    <label class="control-label">START DATE:</label>
                    <input class="form-control startdateupdatez" value="${orderingstart}" id="editSTARTdates" type="text">
                </div>
                <div class="form-group required village">
                    <label class="control-label">END DATE:</label>
                    <input class="form-control enddateupdatez" value="${orderingenddate}" id="editenddates" type="text">
                </div>
                <br>
                <div class="tile-footer"></div>
            </form>
        </div>
    </div>
</div>
<script>
    $('#editSTARTdates').datetimepicker({
        pickTime: false,
        format: "DD/MM/YYYY",
        defaultDate: new Date('${startdate}')
    });
    $('#editenddates').focus(function () {
        document.getElementById('editenddates').value = '';
        var editstartdates = $('#editSTARTdates').val();
        if (editstartdates === '') {
            $('#editSTARTdates').addClass("focus");
            document.getElementById('endyear').value = '';
        } else {
            $('#editSTARTdates').removeClass("focus");
            var fields = editstartdates.split('/');
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
                $('#editenddates').datetimepicker({
                    pickTime: false,
                    format: "DD/MM/YYYY",
                    minDate: new Date(yr + 1, setmaxend, '02'),
                    maxDate: new Date(yr + 2, setmaxend, '01'),
                    defaultDate: new Date('${enddate}')
                });
            } else {
                $('#editenddates').datetimepicker({
                    pickTime: false,
                    format: "DD/MM/YYYY",
                    maxDate: new Date(yr + 2, setmaxend, '01'),
                    defaultDate: new Date('${enddate}')
                });
            }
        }
    });
</script>
