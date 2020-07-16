<%-- 
    Document   : startics
    Created on : Sep 11, 2018, 6:24:27 AM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<link rel="stylesheet" type="text/css" href="static/res/css/card/bootstrap-extendendfull.css">
<link rel="stylesheet" type="text/css" href="static/res/css/card/colors.css">
<style>
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

<div class="">
    <div class="row">
        <div class="col-md-1">

        </div>
        <div class="col-md-12">

            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-content">
                            <div class="row">
                                <div class="col-lg-4 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                                    <div class="p-1 text-center">
                                        <div>
                                            <h3 class="blue-grey darken-1">${totalpatientvisit}</h3>
                                            <span class="blue-grey darken-1">TOTAL PATIENTS</span>
                                        </div>
                                        <div class="card-content">
                                            <div id="morris-likes" style="height:75px;"></div>
                                            <ul class="list-inline clearfix">
                                                <li class="border-right-blue-grey border-right-lighten-2 pr-2">
                                                    <span class="primary text-bold-400"><strong class="startfont">${totalPatientsNew}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-like"></i> New Visits</span>
                                                </li>
                                                <li class="pl-2">
                                                    <span class="primary text-bold-400"><strong class="startfont">${totalPatientsOld}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-dislike"></i> Re-visits</span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                                    <div class="p-1 text-center">
                                        <div>
                                            <h3 class="blue-grey darken-1">${totalpatientsMale}</h3>
                                            <span class="blue-grey darken-1">MALE</span>
                                        </div>
                                        <div class="card-content">
                                            <div id="morris-comments" style="height:75px;"></div>
                                            <ul class="list-inline clearfix">
                                                <li class="border-right-blue-grey border-right-lighten-2 pr-2">
                                                    <span class="danger text-bold-400"><strong class="startfont">${totalMaleNew}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-like"></i> New Visits</span>
                                                </li>
                                                <li class="pl-2">
                                                    <span class="danger text-bold-400"><strong class="startfont">${totalMaleOld}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-dislike"></i> Re-visits</span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                                    <div class="p-1 text-center">
                                        <div>
                                            <h3 class="blue-grey darken-1">${totalpatientsFemale}</h3>
                                            <span class="blue-grey darken-1">FEMALE</span>
                                        </div>
                                        <div class="card-content">
                                            <div id="morris-views" style="height:75px;"></div>
                                            <ul class="list-inline clearfix">
                                                <li class="border-right-blue-grey border-right-lighten-2 pr-2">
                                                    <span class="warning text-bold-400"><strong class="startfont">${totalFemaleNew}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-like"></i> New Visits</span>
                                                </li>
                                                <li class="pl-2">
                                                    <span class="warning text-bold-400"><strong class="startfont">${totalFemaleOld}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-dislike"></i> Re-visits</span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--                                        

            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-content">
                            <div class="row">
                                <div class="col-lg-4 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                                    <div class="p-1 text-center">
                                        <div>
                                            <h3 class="blue-grey darken-1">${totalpatientvisitbelow5}</h3>
                                            <span class="blue-grey darken-1">0 - 4 YEARS</span>
                                        </div>
                                        <div class="card-content">
                                            <div id="morris-likes2" style="height:75px;"></div>
                                            <ul class="list-inline clearfix">
                                                <li style="padding: 1%" class="border-right-blue-grey border-right-lighten-2">
                                                    <span class="primary text-bold-400"><strong class="startfont">${zeroTo4YearsNew}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-like"></i> New Visits</span></br>
                                                     <span>Male </span><span class="badge badge-primary">${zeroTo4YearsNewMale}</span>
                                                    <span>Female </span><span class="badge badge-primary">${zeroTo4YearsNewFemale}</span>
                                                </li>
                                                <li class="">
                                                    <span class="primary text-bold-400"><strong class="startfont">${zerotO4yearsOld}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-dislike"></i> Re-visits</span></br>
                                                     <span>Male </span><span class="badge badge-primary">${zerotO4yearsOldMale}</span>
                                                    <span>Female </span><span class="badge badge-primary">${zerotO4yearsOldFemale}</span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                                    <div class="p-1 text-center">
                                        <div>
                                            <h3 class="blue-grey darken-1">${totalpatientvisit5to12}</h3>
                                            <span class="blue-grey darken-1">5 - 12 YEARS</span>
                                        </div>
                                        <div class="card-content">
                                            <div id="morris-comments2" style="height:75px;"></div>
                                            <ul class="list-inline clearfix">
                                                <li style="padding: 1%" class="border-right-blue-grey border-right-lighten-2">
                                                    <span class="danger text-bold-400"><strong class="startfont">${fiveTo12YearsNew}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-like"></i> New Visits</span></br>
                                                     <span>Male </span><span class="badge badge-primary">${fiveTo12YearsNewMale}</span>
                                                    <span>Female </span><span class="badge badge-primary">${fiveTo12YearsNewFemale}</span>
                                                </li>
                                                <li class="">
                                                    <span class="danger text-bold-400"><strong class="startfont">${fiveTo12YearsOld}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-dislike"></i> Re-visits</span></br>
                                                     <span>Male </span><span class="badge badge-primary">${fiveTo12YearsOldMale}</span>
                                                    <span>Female </span><span class="badge badge-primary">${fiveTo12YearsOldFemale}</span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                                    <div class="p-1 text-center">
                                        <div>
                                            <h3 class="blue-grey darken-1">${totalpatientvisit13andabove}</h3>
                                            <span class="blue-grey darken-1">13 AND ABOVE</span>
                                        </div>
                                        <div class="card-content">
                                            <div id="morris-views2" style="height:75px;"></div>
                                            <ul class="list-inline clearfix">
                                                <li style="padding: 1%" class="border-right-blue-grey border-right-lighten-2">
                                                    <span class="warning text-bold-400"><strong class="startfont">${above13YearsNew}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-like"></i> New Visits</span></br>
                                                    <span>Male </span><span class="badge badge-primary">${above13YearsNewMale}</span>
                                                    <span>Female </span><span class="badge badge-primary">${above13YearsNewFemale}</span>
                                                </li>
                                                <li class="">
                                                    <span class="warning text-bold-400"><strong class="startfont">${above13YearsOld}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-dislike"></i> Re-visits</span></br>
                                                     <span>Male </span><span class="badge badge-primary">${above13YearsOldMale}</span>
                                                    <span>Female </span><span class="badge badge-primary">${above13YearsOldFemale}</span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> -->  
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-content">
                                <div class="row">
                                    <div class="col-lg-3 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                                        <div class="p-1 text-center">
                                            <div>
                                                <h3 class="blue-grey darken-1">${totalPatientVisitBelow29Days}</h3>
                                                <span class="blue-grey darken-1">0 - 28 DAYS</span>
                                            </div>
                                            <div class="card-content">
                                                <div id="morris-likes2" style="height:75px;"></div>
                                                <ul class="list-inline clearfix">
                                                    <li style="padding: 1%" class="border-right-blue-grey border-right-lighten-2">
                                                        <span class="primary text-bold-400"><strong class="startfont">${zeroTo28DaysNew}</strong></span></br>
                                                        <span class="blue-grey darken-1"><i class="icon-like"></i> New Visits</span></br>
                                                         <span>Male </span><span class="badge badge-primary">${zeroTo28DaysNewMale}</span>
                                                        <span>Female </span><span class="badge badge-primary">${zeroTo28DaysNewFemale}</span>
                                                    </li>
                                                    <li class="">
                                                        <span class="primary text-bold-400"><strong class="startfont">${zeroTo28DaysOld}</strong></span></br>
                                                        <span class="blue-grey darken-1"><i class="icon-dislike"></i> Re-visits</span></br>
                                                         <span>Male </span><span class="badge badge-primary">${zeroTo28DaysOldMale}</span>
                                                        <span>Female </span><span class="badge badge-primary">${zeroTo28DaysOldFemale}</span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                            <div class="col-lg-3 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                                <div class="p-1 text-center">
                                    <div>
                                        <h3 class="blue-grey darken-1">${totalPatientVisit29DaysTo4Yrs}</h3>
                                        <span class="blue-grey darken-1">29 DAYS - 4 YRS</span>
                                    </div>
                                    <div class="card-content">
                                        <div id="morris-comments2" style="height:75px;"></div>
                                        <ul class="list-inline clearfix">
                                            <li style="padding: 1%" class="border-right-blue-grey border-right-lighten-2">
                                                <span class="danger text-bold-400"><strong class="startfont">${days29To4YrsNew}</strong></span></br>
                                                <span class="blue-grey darken-1"><i class="icon-like"></i> New Visits</span></br>
                                                 <span>Male </span><span class="badge badge-primary">${days29To4YrsNewMale}</span>
                                                <span>Female </span><span class="badge badge-primary">${days29To4YrsNewFemale}</span>
                                            </li>
                                            <li class="">
                                                <span class="danger text-bold-400"><strong class="startfont">${days29To4YrsOld}</strong></span></br>
                                                <span class="blue-grey darken-1"><i class="icon-dislike"></i> Re-visits</span></br>
                                                 <span>Male </span><span class="badge badge-primary">${days29To4YrsOldMale}</span>
                                                <span>Female </span><span class="badge badge-primary">${days29To4YrsOldFemale}</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        <div class="col-lg-3 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                            <div class="p-1 text-center">
                                <div>
                                    <h3 class="blue-grey darken-1">${totalPatientVisit5YrsTo59Yrs}</h3>
                                    <span class="blue-grey darken-1">5 - 59 YRS</span>
                                </div>
                                <div class="card-content">
                                    <div id="morris-views2" style="height:75px;"></div>
                                        <ul class="list-inline clearfix">
                                            <li style="padding: 1%" class="border-right-blue-grey border-right-lighten-2">
                                                <span class="warning text-bold-400"><strong class="startfont">${yrs5TO59New}</strong></span></br>
                                                <span class="blue-grey darken-1"><i class="icon-like"></i> New Visits</span></br>
                                                <span>Male </span><span class="badge badge-primary">${yrs5TO59NewMale}</span>
                                                <span>Female </span><span class="badge badge-primary">${yrs5TO59NewFemale}</span>
                                            </li>
                                            <li class="">
                                                <span class="warning text-bold-400"><strong class="startfont">${yrs5TO59Old}</strong></span></br>
                                                <span class="blue-grey darken-1"><i class="icon-dislike"></i> Re-visits</span></br>
                                                <span>Male </span><span class="badge badge-primary">${yrs5TO59OldMale}</span>
                                                <span>Female </span><span class="badge badge-primary">${yrs5TO59OldFemale}</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                                <div class="p-1 text-center">
                                    <div>
                                        <h3 class="blue-grey darken-1">${totalPatientVisit60AndAbove}</h3>
                                        <span class="blue-grey darken-1">60 YRS AND ABOVE</span>
                                    </div>
                                    <div class="card-content">
                                        <div id="morris-views3" style="height:75px;"></div>
                                            <ul class="list-inline clearfix">
                                                <li style="padding: 1%" class="border-right-blue-grey border-right-lighten-2">
                                                    <span class="warning text-bold-400"><strong class="startfont">${yrs60AndAboveNew}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-like"></i> New Visits</span></br>
                                                    <span>Male </span><span class="badge badge-primary">${yrs60AndAboveNewMale}</span>
                                                    <span>Female </span><span class="badge badge-primary">${yrs60AndAboveNewFemale}</span>
                                                </li>
                                                <li class="">
                                                    <span class="warning text-bold-400"><strong class="startfont">${yrs60AndAboveOld}</strong></span></br>
                                                    <span class="blue-grey darken-1"><i class="icon-dislike"></i> Re-visits</span></br>
                                                    <span>Male </span><span class="badge badge-primary">${yrs60AndAboveOldMale}</span>
                                                    <span>Female </span><span class="badge badge-primary">${yrs60AndAboveOldFemale }</span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-1">

        </div>
    </div>
</div>

<script src="static/res/js/card/vendors.min.js"></script>
<script src="static/res/js/card/jquery.knob.min.js"></script>
<script src="static/res/js/card/raphael-min.js"></script>
<script src="static/res/js/card/morris.min.js" ></script>
<script src="static/res/js/card/jquery.sparkline.min.js"></script>
<script src="static/res/js/card/card-statistics.min.js"></script>
