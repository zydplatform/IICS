<%-- 
    Document   : weight_for_heightboys
    Created on : Oct 25, 2018, 12:27:44 PM
    Author     : user
--%>

<%@include file="../../../include.jsp" %>
<fieldset>
    <div id="line-chartWFH">
    </div>

</fieldset>

<script>
    var data = ${z_scores};
    config = {
        element: 'line-chartWFH',
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
