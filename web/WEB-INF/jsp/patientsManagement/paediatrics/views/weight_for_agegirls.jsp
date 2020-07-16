<%-- 
    Document   : weight_for_agegirls
    Created on : Oct 26, 2018, 8:40:45 AM
    Author     : user
--%>

<%@include file="../../../include.jsp" %>
<fieldset>
<!--    <div class="bs-component" style="margin-top: -0.5em"><span class="badge badge-success">Normal</span><span class="badge badge-danger">Stunted</span><span class="badge badge-warning">Normal</span></div>-->

    <div id="line-chartWFAgirls">
    </div>

</fieldset>

<script>
    var data = ${z_scores};
    config = {
        element: 'line-chartWFAgirls',
        data: data,
        ymax: 30,
        ymin: 0,
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