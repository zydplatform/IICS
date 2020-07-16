<%-- 
    Document   : weight_for_heightgirls
    Created on : Oct 26, 2018, 9:07:59 AM
    Author     : user
--%>

<%@include file="../../../include.jsp" %>
<fieldset>
    <div id="line-chartWFHgirls">
    </div>

</fieldset>

<script>
    var data = ${z_scores};
    config = {
        element: 'line-chartWFHgirls',
        data: data,
        ymax: 30,
        ymin: 0,
        xkey: 'height',
        xLabels: ['height'],
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

