<%-- 
    Document   : Height_for_ageboys
    Created on : Oct 24, 2018, 4:06:10 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../include.jsp" %>
<fieldset>
    <div class="bs-component" style="margin-top: -0.5em"><span class="badge badge-success">Normal</span><span class="badge badge-danger">Stunted</span><span class="badge badge-warning">Normal</span></div>

    <div id="line-chartHFA">
    </div>

</fieldset>

<script>
    var data = ${z_scores};
    var othersv =${othersv};
    config = {
        element: 'line-chartHFA',
        data: data,
        ymax: 120,
        xLabelMargin: 10,
        ymin: 30,
        xkey: ['month'],
        xLabels: ['month'],
        ykeys: ['neg_3sd', 'neg_2sd', 'neg_1sd', 'normalsd', 'pos_1sd', 'pos_2sd', 'pos_3sd','patientHeight'],
        labels: ['neg_3sd', 'neg_2sd', 'neg_1sd', 'normalsd', 'pos_1sd', 'pos_2sd', 'pos_3sd','patientHeight'],
        fillOpacity: 0.1,
        hideHover: 'always',
        behaveLikeLine: false,
        resize: true,
        pointSize: 0.1,
        parseDate: false,
        backgroundColor: '#ccc',
        smooth: true,
        parseTime: false,
        labelFontColor: "red",
        pointFillColors: ['transparent'],
        pointStrokeColors: ['transparent'],
        lineColors: ['black', 'red', 'yellow', 'green', 'yellow', 'red', 'black', 'blue']
    };
    
    Morris.Line(config);

</script>