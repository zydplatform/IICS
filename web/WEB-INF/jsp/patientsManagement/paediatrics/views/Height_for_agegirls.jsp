<%-- 
    Document   : Height_for_agegirls
    Created on : Oct 25, 2018, 5:40:24 PM
    Author     : user
--%>

<%@include file="../../../include.jsp" %>
<fieldset>
    <div class="bs-component" style="margin-top: -0.5em"><span class="badge badge-success">Normal</span><span class="badge badge-danger">Stunted</span><span class="badge badge-warning">Normal</span></div>

    <div id="line-chartHFAgirls">
    </div>

</fieldset>

<script>
    var data = ${z_scores};
    config = {
        element: 'line-chartHFAgirls',
        data: data,
        ymax: 120,
        ymin: 30,
        xkey: 'month',
        xLabels: ['month'],
        ykeys: ['neg_3sd', 'neg_2sd', 'neg_1sd', 'normalsd', 'pos_1sd', 'pos_2sd', 'pos_3sd'],
        labels: ['neg_3sd', 'neg_2sd', 'neg_1sd', 'normalsd', 'pos_1sd', 'pos_2sd', 'pos_3sd'],
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
        lineColors: ['black', 'red', 'yellow', 'green', 'yellow', 'red', 'black']
    };
    Morris.Line(config);

</script>