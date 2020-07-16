<%-- 
    Document   : donorStatistics
    Created on : Oct 1, 2018, 11:45:32 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="static/res/css/card/colors.css">
<link rel="stylesheet" type="text/css" href="static/res/css/card/morris.css">
<style>
    .tile-body-bg {
        background-color:whitesmoke
    }
    .card-counter{
        box-shadow: 2px 2px 10px #9f77a7;
        margin: 5px;
        padding: 20px 10px;
        background-color: #fff;
        height: 100px;
        border-radius: 5px;
        transition: .3s linear all;
    }

    .card-counter:hover{
        box-shadow: 4px 4px 20px #DADADA;
        transition: .3s linear all;
    }

    .card-counter i{
        font-size: 5em;
        opacity: 0.2;
    }

    .card-counter .count-numbers{
        position: absolute;
        right: 35px;
        top: 20px;
        font-size: 32px;
        display: block;
        font-weight: bolder;
    }

    .card-counter .count-name{
        position: absolute;
        right: 35px;
        top: 65px;
        font-style: normal;
        text-transform: capitalize;
        opacity: 0.5;
        display: block;
        font-size: 18px;
    }
    .startfont{
        font-size: 132%;
    }
</style>
<script>
    function collapseandExapand2(id) {
        if ($('#' + id).hasClass("activeselected2")) {
            $('#' + id).toggleClass('collapseselected activeselected2');
            $('#xxicon2').attr('class', 'fa fa-2x fa-angle-down');
            document.getElementById('collapsethistestcontentstats1').style.display = 'block';
            document.getElementById('collapsethistestcontentstats2').style.display = 'block';
            document.getElementById('contentstatsid').style.display = 'none';
            $('#piechartv').html('');
            $('#piechartv2').html('');
        } else if ($('#' + id).hasClass("collapseselected")) {
            $('#' + id).toggleClass('activeselected2 collapseselected');
            $('#xxicon2').attr('class', 'fa fa-2x fa-angle-up');
            document.getElementById('collapsethistestcontentstats1').style.display = 'none';
            document.getElementById('collapsethistestcontentstats2').style.display = 'none';
            document.getElementById('contentstatsid').style.display = 'block';

            //Pre-Primary
            var JsonPrepri = ${preprimarybar};
            piechartdatav = [];
            for (var x in JsonPrepri) {
                var claNum = JsonPrepri[x].className;
                var claNumcount = JsonPrepri[x].classStdCount;
                piechartdatav [x] = {label: claNum, value: claNumcount}
            }
            var piechartdata = {
                element: 'piechartv',
                backgroundColor: '#CCC',
                colors: ['#057366', '#FF0000', '#FFA500', '#0000A0', '#008000'],
                data: piechartdatav
            };
            Morris.Donut(piechartdata);

            //Primary Section
            var JsonPri = ${primarybar};
            piechartdatav2 = [];
            for (var x in JsonPri) {
                var claNum = JsonPri[x].className;
                var claNumcount = JsonPri[x].classStdCount;
                piechartdatav2 [x] = {label: claNum, value: claNumcount}
            }
            var piechartdata2 = {
                element: 'piechartv2',
                backgroundColor: '#CCC',
                colors: ['#057366', '#FF0000', '#FFA500', '#0000A0', '#00FF00', '#800000', '#808000', '#008000'],
                data: piechartdatav2
            };
            Morris.Donut(piechartdata2);

        }
    }
</script>
<div class="row">
    <div class="col-md-7">
        <div class="btn btn-sm btn-plum horizontalwithwordsleft activeselected2" id="collapsethistestmenu" onclick="collapseandExapand2(this.id);">
            <strong><i class="fa fa-bar-chart"></i> &nbsp;Donor Statistics &nbsp;<i id="xxicon2" class="fa fa-2x fa-angle-down"></i></strong>   
        </div>
        <div class="tile">
            <div class="col-12" id="collapsethistestcontentstats1">
                <div class="card">
                    <div class="card-content">
                        <div class="row">
                            <div class="col-lg-4 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                                <div class="p-1 text-center">
                                    <div>
                                        <h3 class="text-red darken-1">${totaldonors}</h3>
                                        <strong class="text-success darken-1">Number Of Donor(s)</strong>
                                    </div>
                                    <div class="card-content">
                                        <div id="morris-likes2" style="height:75px;"></div>
                                        <ul class="list-inline clearfix">
                                            <li style="padding: 1%" class="border-right-blue-grey border-right-lighten-2">
                                                <span class="primary text-bold-400"><strong class="startfont">0</strong></span></br>
                                                <span class="blue-grey darken-1"><i class="icon-like"></i>Individual</span>
                                            </li>
                                            <li class="">
                                                <span class="primary text-bold-400"><strong class="startfont">0</strong></span></br>
                                                <span class="blue-grey darken-1"><i class="icon-dislike"></i>Organisation</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                                <div class="p-1 text-center">
                                    <div>
                                        <h3 class="text-red  darken-1">0</h3>
                                        <strong class="text-success darken-1">Individual Donor(s)</strong>
                                    </div>
                                    <div class="card-content">
                                        <div id="morris-comments2" style="height:75px;"></div>
                                        <ul class="list-inline clearfix">
                                            <li style="padding: 1%" class="border-right-blue-grey border-right-lighten-2">
                                                <span class="danger text-bold-400"><strong class="startfont">0</strong></span></br>
                                                <span class="blue-grey darken-1"><i class="icon-like"></i>International</span>
                                            </li>
                                            <li class="">
                                                <span class="danger text-bold-400"><strong class="startfont">0</strong></span></br>
                                                <span class="blue-grey darken-1"><i class="icon-dislike"></i>Local</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                                <div class="p-1 text-center">
                                    <div>
                                        <h3 class="text-red  darken-1">0</h3>
                                        <strong class="text-success darken-1">Organisation Donor(s)</strong>
                                    </div>
                                    <div class="card-content">
                                        <div id="morris-views2" style="height:75px;"></div>
                                        <ul class="list-inline clearfix">
                                            <li style="padding: 1%" class="border-right-blue-grey border-right-lighten-2">
                                                <span class="warning text-bold-400"><strong class="startfont">0</strong></span></br>
                                                <span class="blue-grey darken-1"><i class="icon-like"></i>International</span>
                                            </li>
                                            <li class="">
                                                <span class="warning text-bold-400"><strong class="startfont">0</strong></span></br>
                                                <span class="blue-grey darken-1"><i class="icon-dislike"></i>Local</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <!--<div class="horizontalwithwordsleft"><span class="pat-form-heading">School Sections</span></div>-->
                <main>
                    <input class="tabs" id="tab1" type="radio" name="tabs" checked="checked">
                    <label class="paddings" for="tab1">Local Donors</label>

                    <input class="tabs" id="tab2" type="radio" name="tabs">
                    <label class="paddings"  for="tab2">International Donors</label>
                    <section id="content1">
                        <div class="col-md-12">                           
                            <div class="container">
                                <div id="monthlyconsumption" style="height:300px;"></div>                                                       
                            </div>
                        </div>
                    </section>
                    <section id="content2">
                        <div class="col-md-12">                           
                            <div class="container" id="primaryxx">
                                <div id="monthlyconsumption2" style="height:300px;"></div>                        
                            </div>
                        </div>
                    </section>
                </main>
            </div>
        </div>        
    </div>
<!--    <div class="col-md-5">
        <div class="tile" id="collapsethistestcontentstats2">
            <div class="horizontalwithwords"><span class="pat-form-heading">01-10-2018</span></div>
            <div id="calendar"></div>
        </div>
        <div class="tile hidedisplaycontent" id="contentstatsid">
            <div class="horizontalwithwords"><span class="pat-form-heading">Pie Chart</span></div>
            <div class="row">
                <div class="horizontalwithwordsleft"><span class="pat-form-heading">Pre-Primary</span></div>
                <div id="piechartv" style="min-height: 300px;"></div>
            </div>
            <div class="row">
                <div class="horizontalwithwordsleft"><span class="pat-form-heading">Primary</span></div>
                <div id="piechartv2" style="min-height: 300px;"></div>
            </div>
        </div>
    </div>    -->
</div>
<!--
<script src="static/res/js/card/vendors.min.js"></script>
<script src="static/res/js/card/jquery.knob.min.js"></script>
<script src="static/res/js/card/raphael-min.js"></script>
<script src="static/res/js/card/morris.min.js" ></script>
<script src="static/res/js/card/jquery.sparkline.min.js"></script>
<script src="../jquery/jquery-ui.custom.min.js" type="text/javascript"></script>
<script src="static/res/js/card/card-statistics.min.js"></script>
<script type="text/javascript" src="static/res/js/card/fullcalendar.min.js"></script>-->

<script type="text/javascript">
            $(document).ready(function () {
                $('#external-events .fc-event').each(function () {
                    // store data so the calendar knows to render an event upon drop
                    $(this).data('event', {
                        title: $.trim($(this).text()), // use the element's text as the event title
                        stick: true // maintain when user navigates (see docs on the renderEvent method)
                    });

                    // make the event draggable using jQuery UI
                    $(this).draggable({
                        zIndex: 999,
                        revert: true, // will cause the event to go back to its
                        revertDuration: 0  //  original position after the drag
                    });

                });

                $('#calendar').fullCalendar({
                    header: {
                        left: 'today',
                        center: '',
                        right: 'month'
                    },
                    editable: true,
                    droppable: true, // this allows things to be dropped onto the calendar
                    drop: function () {
                        // is the "remove after drop" checkbox checked?
                        if ($('#drop-remove').is(':checked')) {
                            // if so, remove the element from the "Draggable Events" list
                            $(this).remove();
                        }
                    }
                });


            });
            var JsonPrepri = ${preprimarybar};
            var barColorsArray = ['#0000A0', '#FFA500', '#FF0000', '#057366'];
            var colorIndex = 0;
            var barProperties = {
                element: "monthlyconsumption",
                data: JsonPrepri,
                xkey: ['className'],
                ykeys: ["classStdCount"],
                labels: ["No.of Students"],
                barGap: 4,
                barSizeRatio: .3,
                gridTextColor: "#010000",
                gridLineColor: "#dcdcdc",
                numLines: 5,
                gridtextSize: 14,
                resize: !0,
                barColors: function () {
                    if (colorIndex < 3) {
                        return barColorsArray[++colorIndex];
                    } else {
                        colorIndex = 0;
                        return barColorsArray[++colorIndex];
                    }
                },
                hideHover: "auto"
            };
            Morris.Bar(barProperties);
            $('#tab1').click(function () {
                // $('#primaryxx').html('');
            });
            $('#tab2').click(function () {
                var JsonPri = ${primarybar};
                // console.log(JsonPri);
                $('#monthlyconsumption2').html('');
                // var barColorsArray2 = ['#008000', '#808000','#800000', '#00FF00','#0000A0','#FFA500','#FF0000','#057366'];
                // var colorIndex2 = 0;
                var barProperties2 = {
                    element: "monthlyconsumption2",
                    data: JsonPri,
                    xkey: ['className'],
                    ykeys: ["classStdCount"],
                    labels: ["No.of Students"],
                    barGap: 4,
                    barSizeRatio: .3,
                    gridTextColor: "#010000",
                    gridLineColor: "#dcdcdc",
                    numLines: 5,
                    gridtextSize: 14,
                    resize: !0,
                    barColors: ['#057366'],
                    hideHover: "auto"
                };
                Morris.Bar(barProperties2);
            });

</script>
