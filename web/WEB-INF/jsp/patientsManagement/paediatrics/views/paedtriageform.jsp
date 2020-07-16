<%-- 
    Document   : paedtriageform
    Created on : Oct 18, 2018, 10:34:05 AM
    Author     : user
--%>

<%@include file="../../../include.jsp" %>
<style>
    .user-row {
        margin-bottom: 14px;
    }

    .user-row:last-child {
        margin-bottom: 0;
    }
    .table-user-information > tbody > tr {
        border-top: 1px solid rgb(221, 221, 221);
    }

    .table-user-information > tbody > tr:first-child {
        border-top: 0;
    }


    .table-user-information > tbody > tr > td {
        border-top: 0;
    }
    .toppad
    {margin-top:20px;
    }
    #line-chartHFA{
        min-height: 520px;
        background-color: #ECF0F1 ;
    }
    #line-chartWFA{
        min-height: 520px;
        background-color: #ECF0F1 ;
    }
    .HFA{
        margin-top: 2.5em; 
    }
    #line-chartWFH{
        min-height: 520px;
        background-color: #ECF0F1 ;
    }
    #line-chartHFAgirls
    {
        min-height: 520px;
        background-color: #ECF0F1 ;
    }
    #line-chartWFAgirls
    {
        min-height: 520px;
        background-color: #ECF0F1 ;
    } 

    #line-chartWFHgirls{
        min-height: 520px;
        background-color: #ECF0F1 ;
    }
    .icon-color{
        color: purple;
    }
    #red{
        color: red;
    }
    #green{
        color: green;
    }
    #yellow{
        color: yellow;
    }
    .error
    {
        border:2px solid red;
    }

</style>
<div id="patientBasicInfoTriage">

</div>
<div id="zscoresForBoys" class="hidedisplaycontent">
    <div class="row">
        <div class="col-md-6 row">
            <div class="tile col-md-12">
                <div class="tile-body ">
                    <span id="monthsintotal" class="hidedisplaycontent"></span>
                    <div class="form-group row pull-right">
                        <button id="btnPreviousVitals" class="btn btn-primary btn-sm" type="button">Previous Vitals</button>
                    </div>
                    <div class="col-md-12 row" style="margin-top: -1%">
                        <div class="col-md-6">
                            <div class="form-group required">
                                <label class="control-label" for="patientWeight" required>Weight(kg):</label>
                                <input class="form-control"  oninput="functioncheckPatientweightb()" id="patientWeightb" type="number" name="" min="0">
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientHeight">Height/Length(cm):</label>
                                <input class="form-control" id="patientHeightb" oninput="functioncheckpatientHeightb()" type="number" name="patientHeight" min="20" max="300">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientpatientHeighterrormsgb"><font color="red">Height must be between 20 and 300.</font></medium>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientBMI">BMI <strong>(kg/m<sup>2</sup>):</strong></label>
                                <input class="form-control" id="patientBMIReportb" type="number" name="patientBMI" disabled="">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientBMInoHeighteerrormsgb"><font color="red">Enter Height to view BMI.</font></medium>
                                <medium class="form-text text-muted hidedisplaycontent" id="patientBMInoWeighteerrormsgb"><font color="red">Enter Weight to view BMI.</font></medium>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="muac">MUAC(cm):</label>
                                <input class="form-control" id="muac" type="number" min="0" oninput="inputmuac()">
                                <div id="muacerror"></div>
                            </div>
                            <table>
                                <tbody>
                                    <tr><label class="control-label" for="patientPressureSystolic">Blood Pressure(mmHg):</label></tr>
                                <tr>
                                    <td>
                                        <div class="form-group">
                                            <label class="col-form-label col-form-label-sm" for="patientPressureSystolic">Systolic:</label>
                                            <input class="form-control" id="patientPressureSystolicb" min="0" type="number" name="patientPressureSystolic">
                                        </div>
                                    </td>
                                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td>
                                        <div class="form-group">
                                            <label class="col-form-label col-form-label-sm" for="patientPressureDiastolic">Diastolic:</label>
                                            <input class="form-control" id="patientPressureDiastolicb" min="0" type="number" name="patientPressureDiastolic">
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="form-group">
                                    <label class="control-label" for="patientPulse">Pulse(B/min):</label>
                                    <input class="form-control" id="patientPulseb" oninput="functioncheckpatientPulse()" type="number" name="patientPulse" min="20" max="250">
                                    <medium class="form-text text-muted hidedisplaycontent" id="patientPulseerrormsg"><font color="red">Pulse must be between 20 and 250.</font></medium>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientBodySurfaceArea">Body Surface Area(cm):</label>
                                <input class="form-control" id="patientBodySurfaceAreab" type="number" name="patientBodySurfaceArea" min="0">
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientRespirationRate">Respiration Rate(B/min):</label>
                                <input class="form-control" id="patientRespirationRateb" oninput="functioncheckpatientRespirationRate()" type="number" name="patientRespirationRate" min="10">
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientTemperature">Temperature(Celc):</label>
                                <input class="form-control" id="patientTemperatureb" oninput="functioncheckPatientTemperature()" type="number" name="patientTemperature" min="30" max="45">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientTemperatureerrormsg"><font color="red">Temperature must be between 30 and 45.</font></medium>
                            </div>
                            <div class="form-group">
                                <label for="patientTriageNotes">Notes:</label>
                                <textarea class="form-control" id="patientTriageNotesb" rows="4"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="tile">
                <div class="tile-body">
                    <h4><font color="blue">Conclusions</font></h4><hr>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card-counter info">
                                <i class="fa fa-stumbleupon info icon-color"></i>
                                <span class="numbers text-info" id="weightageboys">_</span>
                                <span class="count-name" >Weight(kg) For Age</span>
                                <!--                                <button onclick="weightageboys()" class="btn btn-outline-info pull-right HFA" type="button">Weight(kg) For Age</button>-->
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card-counter primary">
                                <i class="fa fa-arrow-up success icon-color" ></i>
                                <i class="fa fa-arrow-right success icon-color"></i>
                                <span class="numbers text-info" id="heightlengthboys" >_</span>
                                <span class="count-name" >Height/Length(cm) For Age</span>
                                <!--                                <button onclick="heightlengthboys()" class="btn btn-outline-info pull-right HFA" type="button">Height/Length(cm) For Age</button>-->
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="card-counter info" id="fetchCanceled">
                                <i class="fa fa-compress danger icon-color"></i>
                                <span class="count-numbers text-info" id="weightheightboys">_</span>
                                <span class="count-name" >Weight For Height(kg/cm)</span>
                                <!--                                <button onclick="weightheightboys()" class="btn btn-outline-info pull-right HFA" type="button">Weight For Height(kg/cm)</button>-->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card-counter primary">
                                <i class="fa fa-arrows-h success icon-color"></i>
                                <span class="count-numbers text-danger" id="MUACred" style="display: none">Red</span>
                                <span class="count-numbers text-info" id="MUACgreen">_</span>
                                <span class="count-numbers text-warning" id="MUACyellow" style="display: none">Yellow</span>
                                <span class="count-name" >Mid Upper Arm Circumfrence(MUAC)</span>
                            </div> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-7"></div>
                        <div class="col-md-3">
                            <button class="btn btn-primary icon-btn pull-right" onclick="" id="nutritionbtn">
                                <i class="fa fa-plus"></i>Enroll to Nutrition
                            </button>
                        </div>

                        <div class="col-md-2">
                            <button class="btn btn-primary icon-btn pull-right" onclick="savepatienttriageboys()">
                                <i class="fa fa-save"></i>Save
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="zscoresForGirls" class="hidedisplaycontent">
    <div class="row">
        <div class="col-md-6 row">
            <div class="tile col-md-12">
                <div class="tile-body ">

                    <div class="form-group row pull-right">
                        <button id="btnPreviousVitals" class="btn btn-primary btn-sm" type="button">Previous Vitals</button>
                    </div>
                    <div class="col-md-12 row" style="margin-top: -1%">
                        <div class="col-md-6">
                            <div class="form-group required">
                                <label class="control-label" for="patientWeight" required>Weight(kg):</label>
                                <input class="form-control"  oninput="functioncheckPatientweightg()" id="patientWeightg" type="number" name="" min="0">
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientHeight">Height/Length(cm):</label>
                                <input class="form-control" id="patientHeightg" oninput="functioncheckpatientHeightg()" type="number" name="patientHeight" min="20" max="300">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientpatientHeighterrormsgg"><font color="red">Height must be between 20 and 300.</font></medium>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientBMI">BMI <strong>(kg/m<sup>2</sup>):</strong></label>
                                <input class="form-control" id="patientBMIReportg" type="number" name="patientBMI" disabled="">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientBMInoHeighteerrormsgg"><font color="red">Enter Height to view BMI.</font></medium>
                                <medium class="form-text text-muted hidedisplaycontent" id="patientBMInoWeighteerrormsgg"><font color="red">Enter Weight to view BMI.</font></medium>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientBodySurfaceArea">MUAC(cm):</label>
                                <input class="form-control" id="muacgirls" type="number" min="0" oninput="inputmuacgirls()">
                                <div id="muacerror"></div>
                            </div>
                            <table>
                                <tbody>
                                    <tr><label class="control-label" for="patientPressureSystolic">Blood Pressure(mmHg):</label></tr>
                                <tr>
                                    <td>
                                        <div class="form-group">
                                            <label class="col-form-label col-form-label-sm" for="patientPressureSystolic">Systolic:</label>
                                            <input class="form-control" id="patientPressureSystolicg" min="0" type="number" name="patientPressureSystolic">
                                        </div>
                                    </td>
                                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td>
                                        <div class="form-group">
                                            <label class="col-form-label col-form-label-sm" for="patientPressureDiastolic">Diastolic:</label>
                                            <input class="form-control" id="patientPressureDiastolicg" min="0" type="number" name="patientPressureDiastolic">
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="form-group">
                                    <label class="control-label" for="patientPulse">Pulse(B/min):</label>
                                    <input class="form-control" id="patientPulseg" oninput="functioncheckpatientPulse()" type="number" name="patientPulse" min="20" max="250">
                                    <medium class="form-text text-muted hidedisplaycontent" id="patientPulseerrormsg"><font color="red">Pulse must be between 20 and 250.</font></medium>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientBodySurfaceArea">Body Surface Area(cm):</label>
                                <input class="form-control" id="patientBodySurfaceAreag" type="number" name="patientBodySurfaceArea" min="0">
                            </div>

                            <div class="form-group">
                                <label class="control-label" for="patientRespirationRate">Respiration Rate(B/min):</label>
                                <input class="form-control" id="patientRespirationRateg" oninput="functioncheckpatientRespirationRate()" type="number" name="patientRespirationRate" min="10">
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientTemperature">Temperature(Celc):</label>
                                <input class="form-control" id="patientTemperatureg" oninput="functioncheckPatientTemperature()" type="number" name="patientTemperature" min="30" max="45">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientTemperatureerrormsg"><font color="red">Temperature must be between 30 and 45.</font></medium>
                            </div>
                            <div class="form-group">
                                <label for="patientTriageNotes">Notes:</label>
                                <textarea class="form-control" id="patientTriageNotesg" rows="4"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="tile">
                <div class="tile-body">
                    <h4 class="center"><font color="">Conclusions</font></h4><hr>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card-counter info">
                                <i class="fa fa-stumbleupon info icon-color"></i>
                                <span class="numbers text-info" id="weightagegirls">_</span>
                                <span class="count-name" >Weight(kg) For Age</span>
                                <!--                                <button onclick="weightagegirls()" class="btn btn-outline-info pull-right HFA" type="button">Weight(kg) For Age</button>-->
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card-counter primary">
                                <i class="fa fa-arrow-up success icon-color"></i>
                                <i class="fa fa-arrow-right success icon-color"></i>
                                <span class="numbers text-info" id="heightlengthgirls">_</span>
                                <span class="count-name" >Height/Length(cm) For Age</span>
                                <!--                                <button onclick="heightlengthgirls()" class="btn btn-outline-info pull-right HFA" type="button">Height/Length(cm) For Age</button>-->
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="card-counter info" id="fetchCanceled">
                                <i class="fa fa-compress danger icon-color"></i>
                                <span class="count-numbers text-info" id="weightheightgirls">_</span>
                                <span class="count-name" >Weight For Height(kg/cm)</span>
                                <!--                                <button onclick="weightheightgirls()" class="btn btn-outline-info pull-right HFA" type="button">Weight For Height(kg/cm)</button>-->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card-counter primary">
                                <i class="fa fa-arrows-h success icon-color"></i>
                                <span class="count-numbers text-danger" id="muacGirlsred" style="display: none">Red</span>
                                <span class="count-numbers text-info" id="muacGirlsgreen">_</span>
                                <span class="count-numbers text-warning" id="muacGirlsyellow" style="display: none">Yellow</span>
                                <span class="count-name" >Mid Upper Arm Circumfrence(MUAC)</span>
                            </div> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-7"></div>
                        <div class="col-md-3">
                            <button class="btn btn-primary icon-btn pull-right" onclick="" id="nutritionbtn1">
                                <i class="fa fa-plus"></i>Enroll to Nutrition
                            </button>
                        </div>

                        <div class="col-md-2">
                            <button class="btn btn-primary icon-btn pull-right" onclick="savepatientTriagegirls()">
                                <i class="fa fa-save"></i>Save
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="BMIboys" class="hidedisplaycontent">
    <div class="row">
        <div class="col-md-6 row">
            <div class="tile col-md-12">
                <div class="tile-body ">
                    <span id="monthsintotal" class="hidedisplaycontent"></span>
                    <div class="form-group row pull-right">
                        <button id="btnPreviousVitals" class="btn btn-primary btn-sm" type="button">Previous Vitals</button>
                    </div>
                    <div class="col-md-12 row" style="margin-top: -1%">
                        <div class="col-md-6">
                            <div class="form-group required">
                                <label class="control-label" for="patientWeight" required>Weight(kg):</label>
                                <input class="form-control"  oninput="functioncheckPatientweightbb()" id="patientWeightbb" type="number" name="" min="0">
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientHeight">Height/Length(cm):</label>
                                <input class="form-control" id="patientHeightbb" oninput="functioncheckpatientHeightbb()" type="number" name="patientHeight" min="20" max="300">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientpatientHeighterrormsgbb"><font color="red">Height must be between 20 and 300.</font></medium>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientBMI">BMI <strong>(kg/m<sup>2</sup>):</strong></label>
                                <input class="form-control" id="patientBMIReportbb" type="number" name="patientBMI" disabled="">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientBMInoHeighteerrormsgbb"><font color="red">Enter Height to view BMI.</font></medium>
                                <medium class="form-text text-muted hidedisplaycontent" id="patientBMInoWeighteerrormsgbb"><font color="red">Enter Weight to view BMI.</font></medium>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="muac">MUAC(cm):</label>
                                <input class="form-control" id="muacb" type="number" min="0" oninput="inputmuacb()">
                                <div id="muacerror"></div>
                            </div>
                            <table>
                                <tbody>
                                    <tr><label class="control-label" for="patientPressureSystolic">Blood Pressure(mmHg):</label></tr>
                                <tr>
                                    <td>
                                        <div class="form-group">
                                            <label class="col-form-label col-form-label-sm" for="patientPressureSystolic">Systolic:</label>
                                            <input class="form-control" id="patientPressureSystolicbb" min="0" type="number" name="patientPressureSystolic">
                                        </div>
                                    </td>
                                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td>
                                        <div class="form-group">
                                            <label class="col-form-label col-form-label-sm" for="patientPressureDiastolic">Diastolic:</label>
                                            <input class="form-control" id="patientPressureDiastolicbb" min="0" type="number" name="patientPressureDiastolic">
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="form-group">
                                    <label class="control-label" for="patientPulse">Pulse(B/min):</label>
                                    <input class="form-control" id="patientPulsebb" oninput="functioncheckpatientPulse()" type="number" name="patientPulse" min="20" max="250">
                                    <medium class="form-text text-muted hidedisplaycontent" id="patientPulseerrormsgb"><font color="red">Pulse must be between 20 and 250.</font></medium>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientBodySurfaceArea">Body Surface Area(cm):</label>
                                <input class="form-control" id="patientBodySurfaceAreabb" type="number" name="patientBodySurfaceArea" min="0">
                            </div>

                            <div class="form-group">
                                <label class="control-label" for="patientRespirationRate">Respiration Rate(B/min):</label>
                                <input class="form-control" id="patientRespirationRatebb" oninput="functioncheckpatientRespirationRate()" type="number" name="patientRespirationRate" min="10">
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientTemperature">Temperature(Celc):</label>
                                <input class="form-control" id="patientTemperaturebb" oninput="functioncheckPatientTemperature()" type="number" name="patientTemperature" min="30" max="45">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientTemperatureerrormsgb"><font color="red">Temperature must be between 30 and 45.</font></medium>
                            </div>
                            <div class="form-group">
                                <label for="patientTriageNotes">Notes:</label>
                                <textarea class="form-control" id="patientTriageNotesbb" rows="4"></textarea>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="tile">
                <div class="tile-body">
                    <h4><font color="blue">Conclusions</font></h4><hr>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card-counter info">
                                <i class="fa fa-stumbleupon info icon-color"></i>
                                <span class="numbers text-info" id="weightageboysb">_</span>
                                <span class="count-name" >Weight(kg) For Age</span>
                                <!--                                <button onclick="weightageboys()" class="btn btn-outline-info pull-right HFA" type="button">Weight(kg) For Age</button>-->
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card-counter primary">
                                <i class="fa fa-arrow-up success icon-color" ></i>
                                <i class="fa fa-arrow-right success icon-color"></i>
                                <span class="numbers text-info" id="heightlengthboysb" >_</span>
                                <span class="count-name" >Height/Length(cm) For Age</span>
                                <!--                                <button onclick="heightlengthboys()" class="btn btn-outline-info pull-right HFA" type="button">Height/Length(cm) For Age</button>-->
                            </div> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card-counter info" id="fetchCanceled">
                                <i class="fa fa-compress danger icon-color"></i>
                                <span class="count-numbers text-info" id="bmiboys">_</span>
                                <span class="count-name" >BMI for age(kg/m*)</span>
                                <!--                                <button onclick="weightheightboys()" class="btn btn-outline-info pull-right HFA" type="button">Weight For Height(kg/cm)</button>-->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card-counter primary">
                                <i class="fa fa-arrows-h success icon-color"></i>
                                <span class="count-numbers text-danger" id="MUACredb" style="display: none">Red</span>
                                <span class="count-numbers text-info" id="MUACgreenb">_</span>
                                <span class="count-numbers text-warning" id="MUACyellowb" style="display: none">Yellow</span>
                                <span class="count-name" >Mid Upper Arm Circumfrence(MUAC)</span>
                            </div> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-7"></div>
                        <div class="col-md-3">
                            <button class="btn btn-primary icon-btn pull-right" onclick="" id="nutritionbtn2">
                                <i class="fa fa-plus"></i>Enroll to Nutrition
                            </button>
                        </div>
                        <div class="col-md-2">
                            <button class="btn btn-primary icon-btn pull-right" onclick="savepatienttriageboysb()">
                                <i class="fa fa-save"></i>Save
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="BMIgirls" class="hidedisplaycontent">
    <div class="row">
        <div class="col-md-6 row">
            <div class="tile col-md-12">
                <div class="tile-body ">

                    <div class="form-group row pull-right">
                        <button id="btnPreviousVitals" class="btn btn-primary btn-sm" type="button">Previous Vitals</button>
                    </div>
                    <div class="col-md-12 row" style="margin-top: -1%">
                        <div class="col-md-6">
                            <div class="form-group required">
                                <label class="control-label" for="patientWeight" required>Weight(kg):</label>
                                <input class="form-control"  oninput="functioncheckPatientweightgg()" id="patientWeightgg" type="number" name="" min="0">
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientHeight">Height/Length(cm):</label>
                                <input class="form-control" id="patientHeightgg" oninput="functioncheckpatientHeightgg()" type="number" name="patientHeight" min="20" max="300">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientpatientHeighterrormsggg"><font color="red">Height must be between 20 and 300.</font></medium>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientBMI">BMI <strong>(kg/m<sup>2</sup>):</strong></label>
                                <input class="form-control" id="patientBMIReportgg" type="number" name="patientBMI" disabled="">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientBMInoHeighteerrormsggg"><font color="red">Enter Height to view BMI.</font></medium>
                                <medium class="form-text text-muted hidedisplaycontent" id="patientBMInoWeighteerrormsggg"><font color="red">Enter Weight to view BMI.</font></medium>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientBodySurfaceArea">MUAC(cm):</label>
                                <input class="form-control" id="muacgirlsg" type="number" min="0" oninput="inputmuacgirlsg()">
                                <div id="muacerror"></div>
                            </div>
                            <table>
                                <tbody>
                                    <tr><label class="control-label" for="patientPressureSystolic">Blood Pressure(mmHg):</label></tr>
                                <tr>
                                    <td>
                                        <div class="form-group">
                                            <label class="col-form-label col-form-label-sm" for="patientPressureSystolic">Systolic:</label>
                                            <input class="form-control" id="patientPressureSystolicgg" min="0" type="number" name="patientPressureSystolic">
                                        </div>
                                    </td>
                                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td>
                                        <div class="form-group">
                                            <label class="col-form-label col-form-label-sm" for="patientPressureDiastolic">Diastolic:</label>
                                            <input class="form-control" id="patientPressureDiastolicgg" min="0" type="number" name="patientPressureDiastolic">
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="form-group">
                                    <label class="control-label" for="patientPulse">Pulse(B/min):</label>
                                    <input class="form-control" id="patientPulsegg" oninput="functioncheckpatientPulse()" type="number" name="patientPulse" min="20" max="250">
                                    <medium class="form-text text-muted hidedisplaycontent" id="patientPulseerrormsggg"><font color="red">Pulse must be between 20 and 250.</font></medium>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientBodySurfaceArea">Body Surface Area(cm):</label>
                                <input class="form-control" id="patientBodySurfaceAreagg" type="number" name="patientBodySurfaceArea" min="0">
                            </div>

                            <div class="form-group">
                                <label class="control-label" for="patientRespirationRate">Respiration Rate(B/min):</label>
                                <input class="form-control" id="patientRespirationRategg" oninput="functioncheckpatientRespirationRate()" type="number" name="patientRespirationRate" min="10">
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="patientTemperature">Temperature(Celc):</label>
                                <input class="form-control" id="patientTemperaturegg" oninput="functioncheckPatientTemperature()" type="number" name="patientTemperature" min="30" max="45">
                                <medium class="form-text text-muted hidedisplaycontent" id="patientTemperatureerrormsggg"><font color="red">Temperature must be between 30 and 45.</font></medium>
                            </div>
                            <div class="form-group">
                                <label for="patientTriageNotes">Notes:</label>
                                <textarea class="form-control" id="patientTriageNotesgg" rows="4"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="tile">
                <div class="tile-body">
                    <h4 class="center"><font color="">Conclusions</font></h4><hr>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card-counter info">
                                <i class="fa fa-stumbleupon info icon-color"></i>
                                <span class="numbers text-info" id="weightagegirlsg">_</span>
                                <span class="count-name" >Weight(kg) For Age</span>
                                <!--                                <button onclick="weightagegirls()" class="btn btn-outline-info pull-right HFA" type="button">Weight(kg) For Age</button>-->
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card-counter primary">
                                <i class="fa fa-arrow-up success icon-color"></i>
                                <i class="fa fa-arrow-right success icon-color"></i>
                                <span class="numbers text-info" id="heightlengthgirlsg">_</span>
                                <span class="count-name" >Height/Length(cm) For Age</span>
                                <!--                                <button onclick="heightlengthgirls()" class="btn btn-outline-info pull-right HFA" type="button">Height/Length(cm) For Age</button>-->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card-counter info" id="fetchCanceled">
                                <i class="fa fa-compress danger icon-color"></i>
                                <span class="count-numbers text-info" id="BMIagegirls">_</span>
                                <span class="count-name" >BMI for age(kg/m*)</span>
                                <!--                                <button onclick="weightheightgirls()" class="btn btn-outline-info pull-right HFA" type="button">Weight For Height(kg/cm)</button>-->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card-counter primary">
                                <i class="fa fa-arrows-h success icon-color"></i>
                                <span class="count-numbers text-danger" id="muacGirlsredg" style="display: none">Red</span>
                                <span class="count-numbers text-info" id="muacGirlsgreeng">_</span>
                                <span class="count-numbers text-warning" id="muacGirlsyellowg" style="display: none">Yellow</span>
                                <span class="count-name" >Mid Upper Arm Circumfrence(MUAC)</span>
                            </div> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-7"></div>
                        <div class="col-md-3">
                            <button class="btn btn-primary icon-btn pull-right" onclick="" id="nutritionbtn3">
                                <i class="fa fa-plus"></i>Enroll to Nutrition
                            </button>
                        </div>
                        <div class="col-md-2">
                            <button class="btn btn-primary icon-btn pull-right" onclick="savepatientTriagegirlsBMI()">
                                <i class="fa fa-save"></i>Save
                            </button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<span id="visitid" class="hidedisplaycontent"></span>

<script>
    $(document).ready(function () {
         document.getElementById("nutritionbtn").disabled = true;
         document.getElementById("nutritionbtn1").disabled = true;
         document.getElementById("nutritionbtn2").disabled = true;
         document.getElementById("nutritionbtn3").disabled = true;
    });
    function inputmuac() {
        $('#MUACred').hide();
        $('#MUACyellow').hide();
        var muac = $("#muac").val();
        if (muac > 0 && muac < 11.5) {
            $('#MUACred').show();
        }
        if (muac === 0) {
            document.getElementById('MUACgreen').innerHTML = 'Invalid';
        }
        if (muac >= 11.5 && muac < 12.5) {
            $('#MUACyellow').show();
        }
        if (muac >= 12.5) {
            document.getElementById('MUACgreen').innerHTML = 'Green';
        }
        if (muac === '') {
            document.getElementById('MUACgreen').innerHTML = '_';

        }
    }
    function inputmuacb() {
        $('#MUACredb').hide();
        $('#MUACyellowb').hide();
        var muac = $("#muacb").val();
        if (muac > 0 && muac < 11.5) {
            $('#MUACredb').show();
        }
        if (muac === 0) {
            document.getElementById('MUACgreenb').innerHTML = 'Invalid';
        }
        if (muac >= 11.5 && muac < 12.5) {
            $('#MUACyellowb').show();
        }
        if (muac >= 12.5) {
            document.getElementById('MUACgreenb').innerHTML = 'Green';
        }
        if (muac === '') {
            document.getElementById('MUACgreenb').innerHTML = '_';

        }
    }
    function inputmuacgirls() {
        $('#muacGirlsred').hide();
        $('#muacGirlsyellow').hide();
        var muac = $("#muacgirls").val();
        if (muac > 0 && muac < 11.5) {
            $('#muacGirlsred').show();
        }
        if (muac === 0) {
            document.getElementById('muacGirls').innerHTML = 'Invalid';
        }
        if (muac >= 11.5 && muac < 12.5) {
            $('#muacGirlsyellow').show();
        }
        if (muac >= 12.5) {
            document.getElementById('muacGirlsgreen').innerHTML = 'Green';
        }
        if (muac === '') {
            document.getElementById('muacGirlsgreen').innerHTML = '_';
        }
    }
    function inputmuacgirlsg() {
        $('#muacGirlsredg').hide();
        $('#muacGirlsyellowg').hide();
        var muac = $("#muacgirlsg").val();
        if (muac > 0 && muac < 11.5) {
            $('#muacGirlsredg').show();
        }
        if (muac === 0) {
            document.getElementById('muacGirlsg').innerHTML = 'Invalid';
        }
        if (muac >= 11.5 && muac < 12.5) {
            $('#muacGirlsyellowg').show();
        }
        if (muac >= 12.5) {
            document.getElementById('muacGirlsgreeng').innerHTML = 'Green';
        }
        if (muac === '') {
            document.getElementById('muacGirlsgreeng').innerHTML = '_';
        }
    }

    function heightlengthboys() {
        var monthsintotal = $('#monthsintotal').val();
        var patientHeight = $('#patientHeight').val();
        if (patientHeight === '') {
            $.dialog({
                title: 'Encountered an error!',
                content: 'Please fill in the height of the patient to continue!! ',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Try again',
                        btnClass: 'btn-red',
                        action: function () {
                        }
                    },
                    close: function () {
                    }
                }
            });
        } else {
            $.ajax({
                type: 'GET',
                data: {monthsintotal: monthsintotal, patientHeight: patientHeight},
                url: "paediatrics/viewHFAboys.htm",
                dataType: 'text',
                success: function (data) {
                    $.dialog({
                        title: '<strong class="center">' + '<font color="green">' + '<font color=black>' + "Z-Score:" + '</font>' + "Height/length For Age" + '</font>' + '</strong>',
                        content: '' + data,
                        boxWidth: '80%',
                        useBootstrap: false,
                        type: 'purple',
                        typeAnimated: true,
                        closeIcon: true
                    });
                }
            });
        }
    }

    function weightageboys() {
        $.ajax({
            type: 'GET',
            url: "paediatrics/viewWFAboys.htm",
            dataType: 'text',
            success: function (data) {
                $.dialog({
                    title: '<strong class="center">' + '<font color="green">' + '<font color=black>' + "Z-Score:" + '</font>' + "Weight For Age" + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '80%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true
                });
            }
        });
    }
    function weightheightboys() {
        $.ajax({
            type: 'GET',
            url: "paediatrics/viewWFHboys.htm",
            dataType: 'text',
            success: function (data) {
                $.dialog({
                    title: '<strong class="center">' + '<font color="green">' + '<font color=black>' + "Z-Score:" + '</font>' + "Weight For Height" + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '80%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true
                });
            }
        });
    }
    function heightlengthgirls() {
        $.ajax({
            type: 'GET',
            url: "paediatrics/viewHFAgirls.htm",
            dataType: 'text',
            success: function (data) {

                $.dialog({
                    title: '<strong class="center">' + '<font color="green">' + '<font color=black>' + "Z-Score:" + '</font>' + "Height/length For Age" + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '80%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true
                });
            }
        });
    }
    function weightagegirls() {
        $.ajax({
            type: 'GET',
            url: "paediatrics/viewWFAgirls.htm",
            dataType: 'text',
            success: function (data) {

                $.dialog({
                    title: '<strong class="center">' + '<font color="green">' + '<font color=black>' + "Z-Score:" + '</font>' + "Weight For Age" + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '80%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true
                });
            }
        });
    }
    function weightheightgirls() {
        $.ajax({
            type: 'GET',
            url: "paediatrics/viewWFHgirls.htm",
            dataType: 'text',
            success: function (data) {
                $.dialog({
                    title: '<strong class="center">' + '<font color="green">' + '<font color=black>' + "Z-Score:" + '</font>' + "Weight For Age" + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '80%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true
                });
            }
        });
    }
    function functioncheckPatientweightg() {
        $('#patientBMIReportg').html('');
        $('#weightagegirls').html('');
        var patientWeight = $('#patientWeightg').val();
        var patientHeight2 = $('#patientHeightg').val();
        var monthsintotal = $('#monthsintotal').val();
        if (patientHeight2 === null || typeof patientHeight2 === 'undefined' || patientHeight2 === '') {
            $('#patientBMInoHeighteerrormsgg').show();
            $('#patientBMInoWeighteerrormsgg').hide();
        } else {
            if (patientWeight !== null || typeof patientWeight !== 'undefined' || patientWeight !== '') {
                $('#patientBMInoHeighteerrormsgg').hide();
                $('#patientBMInoWeighteerrormsgg').hide();
                patientWeight = parseFloat(patientWeight);
                patientHeight2cm = parseFloat(patientHeight2);

                $('#patientBMInoHeighteerrormsgg').hide();
                $('#patientBMInoWeighteerrormsgg').hide();
                patientHeight2cm = parseFloat(patientHeight2cm);
                patientWeight = parseFloat(patientWeight);
                var patientHeightinMetres = patientHeight2cm / 100;
                var patientHeightinMetressquared = patientHeightinMetres * patientHeightinMetres;

                var patientBIM = patientWeight / patientHeightinMetressquared;
                $('#patientBMIReportg').val(Math.round(patientBIM));
            }
        }
        $.ajax({
            type: 'POST',
            data: {patientWeight: patientWeight, monthsintotal: monthsintotal},
            url: "paediatrics/WFAobservationgirls.htm",
            success: function (respose) {

                if (respose === "Normal") {
                    document.getElementById('weightagegirls').innerHTML = "Normal";
                }
                if (respose === "Growth Problem") {
                    document.getElementById('weightagegirls').innerHTML = "Growth Problem";
                }
                if (respose === "Under Weight") {
                    document.getElementById('weightagegirls').innerHTML = "Under Weight";
                }
                if (respose === "Severely Underweight") {
                    document.getElementById('weightagegirls').innerHTML = "Severely Underweight";
                }
            }
        });

    }
    function functioncheckPatientweightgg() {
        $('#patientBMIReportgg').html('');
        $('#weightagegirlsg').html('');
        var patientWeight = $('#patientWeightgg').val();
        var patientHeight2 = $('#patientHeightgg').val();
        var monthsintotal = $('#monthsintotal').val();

        if (patientHeight2 === null || typeof patientHeight2 === 'undefined' || patientHeight2 === '') {
            $('#patientBMInoHeighteerrormsggg').show();
            $('#patientBMInoWeighteerrormsggg').hide();
        } else {
            if (patientWeight !== null || typeof patientWeight !== 'undefined' || patientWeight !== '') {
                $('#patientBMInoHeighteerrormsggg').hide();
                $('#patientBMInoWeighteerrormsggg').hide();
                patientWeight = parseFloat(patientWeight);
                patientHeight2cm = parseFloat(patientHeight2);

                $('#patientBMInoHeighteerrormsggg').hide();
                $('#patientBMInoWeighteerrormsggg').hide();
                patientHeight2cm = parseFloat(patientHeight2cm);
                patientWeight = parseFloat(patientWeight);
                var patientHeightinMetres = patientHeight2cm / 100;
                var patientHeightinMetressquared = patientHeightinMetres * patientHeightinMetres;

                var patientBIM = patientWeight / patientHeightinMetressquared;
                $('#patientBMIReportgg').val(Math.round(patientBIM));
            }
        }
        $.ajax({
            type: 'POST',
            data: {patientWeight: patientWeight, monthsintotal: monthsintotal},
            url: "paediatrics/WFAobservationgirls.htm",
            success: function (respose) {
                if (respose === '') {
                    document.getElementById('weightagegirlsg').innerHTML = "Patient is above 10 years.";
                }
                if (respose === "Normal") {
                    document.getElementById('weightagegirlsg').innerHTML = "Normal";
                }
                if (respose === "Growth Problem") {
                    document.getElementById('weightagegirlsg').innerHTML = "Growth Problem";
                }
                if (respose === "Under Weight") {
                    document.getElementById('weightagegirlsg').innerHTML = "Under Weight";
                }
                if (respose === "Severely Underweight") {
                    document.getElementById('weightagegirlsg').innerHTML = "Severely Underweight";
                }
            }
        });

    }
    function functioncheckpatientHeightg() {
        $('#heightlengthgirls').html('');
        $('#weightheightgirls').html('');
        var patientHeightcm = $('#patientHeightg').val();
        var patientWeight = $('#patientWeightg').val();
        var monthsintotal = $('#monthsintotal').val();
        if (parseInt(patientHeightcm) < 20 || parseInt(patientHeightcm) > 300) {
            $('#patientpatientHeighterrormsgg').show();
        } else {
            $('#patientpatientHeighterrormsgg').hide();
        }

        if (patientWeight === null || typeof patientWeight === 'undefined' || patientWeight === '') {
            $('#patientBMInoHeighteerrormsgg').hide();
            $('#patientBMInoWeighteerrormsgg').show();
        } else {
            if (patientHeightcm !== null || typeof patientHeightcm !== 'undefined' || patientHeightcm !== '') {
                $('#patientBMInoHeighteerrormsgg').hide();
                $('#patientBMInoWeighteerrormsgg').hide();
                patientHeightcm = parseFloat(patientHeightcm);
                patientWeight = parseFloat(patientWeight);
                var patientHeightinMetres = patientHeightcm / 100;
                var patientHeightinMetressquared = patientHeightinMetres * patientHeightinMetres;

                var patientBIM2 = patientWeight / patientHeightinMetressquared;

                $('#patientBMIReportg').val(Math.round(patientBIM2));
            }
        }
        $.ajax({
            type: 'POST',
            data: {patientHeightcm: patientHeightcm, monthsintotal: monthsintotal},
            url: "paediatrics/HFAobservationgirls.htm",
            success: function (respose) {
                if (respose === 'Normal') {
                    document.getElementById('heightlengthgirls').innerHTML = "Normal";
                } else if (respose === 'Stunted') {
                    document.getElementById('heightlengthgirls').innerHTML = "Stunted";
                } else if (respose === 'Severely Stunted') {
                    document.getElementById('heightlengthgirls').innerHTML = "Severely Stunted";
                } else if (respose === 'Very Tall') {
                    document.getElementById('heightlengthgirls').innerHTML = "Very Tall";
                } else if (respose === 'Tall') {
                    document.getElementById('heightlengthgirls').innerHTML = "Tall";
                } else {
                    document.getElementById('heightlengthgirls').innerHTML = "Invalid";
                }
            }
        });
        $.ajax({
            type: 'POST',
            data: {patientHeightcm: patientHeightcm, patientWeight: patientWeight},
            url: "paediatrics/WFHobservationgirls.htm",
            success: function (respose) {

                if (respose === 'Obese') {
                    document.getElementById('weightheightgirls').innerHTML = "Obese";

                } else if (respose === 'Over weight') {
                    document.getElementById('weightheightgirls').innerHTML = "Over weight";

                } else if (respose === 'Over Weight Risk') {
                    document.getElementById('weightheightgirls').innerHTML = "Over Weight Risk";

                } else if (respose === 'Normal') {
                    document.getElementById('weightheightgirls').innerHTML = "Normal";
                } else if (respose === 'Wasted') {
                    document.getElementById('weightheightgirls').innerHTML = "Wasted";

                } else if (respose === 'Severely Wasted') {
                    document.getElementById('weightheightgirls').innerHTML = "Severely Wasted";

                } else {
                    document.getElementById('weightheightgirls').innerHTML = "Invalid";
                }
            }
        });

    }
    function functioncheckpatientHeightgg() {
        $('#patientHeightgg').removeClass('error');
        $('#heightlengthgirlsg').html('');
        $('#BMIagegirls').html('');
        var patientHeightcm = $('#patientHeightgg').val();
        var patientWeight = $('#patientWeightgg').val();
        var monthsintotal = $('#monthsintotal').val();
        if (parseInt(patientHeightcm) < 20 || parseInt(patientHeightcm) > 300) {
            $('#patientpatientHeighterrormsggg').show();
        } else {
            $('#patientpatientHeighterrormsggg').hide();
        }

        if (patientWeight === null || typeof patientWeight === 'undefined' || patientWeight === '') {
            $('#patientBMInoHeighteerrormsggg').hide();
            $('#patientBMInoWeighteerrormsggg').show();
        } else {
            if (patientHeightcm !== null || typeof patientHeightcm !== 'undefined' || patientHeightcm !== '') {
                $('#patientBMInoHeighteerrormsggg').hide();
                $('#patientBMInoWeighteerrormsggg').hide();
                patientHeightcm = parseFloat(patientHeightcm);
                patientWeight = parseFloat(patientWeight);
                var patientHeightinMetres = patientHeightcm / 100;
                var patientHeightinMetressquared = patientHeightinMetres * patientHeightinMetres;

                var patientBIM2 = patientWeight / patientHeightinMetressquared;

                $('#patientBMIReportgg').val(Math.round(patientBIM2));
            }
        }

        $.ajax({
            type: 'POST',
            data: {patientHeightcm: patientHeightcm, monthsintotal: monthsintotal},
            url: "paediatrics/HFAobservationgirls.htm",
            success: function (respose) {
                if (respose === '') {
                    $('#patientHeightgg').addClass('error');
                }
                if (respose === 'Normal') {
                    document.getElementById('heightlengthgirlsg').innerHTML = "Normal";
                } else if (respose === 'Stunted') {
                    document.getElementById('heightlengthgirlsg').innerHTML = "Stunted";
                } else if (respose === 'Severely Stunted') {
                    document.getElementById('heightlengthgirlsg').innerHTML = "Severely Stunted";
                } else if (respose === 'Very Tall') {
                    document.getElementById('heightlengthgirlsg').innerHTML = "Very Tall";
                } else if (respose === 'Tall') {
                    document.getElementById('heightlengthgirlsg').innerHTML = "Tall";
                } else {
                    document.getElementById('heightlengthgirlsg').innerHTML = "Invalid";
                }
            }
        });
        $.ajax({
            type: 'POST',
            data: {patientbmi: patientBIM2, monthsintotal: monthsintotal},
            url: "paediatrics/BMIFAobservationgirls.htm",
            success: function (respose) {
                if (respose === 'Obese') {
                    document.getElementById('BMIagegirls').innerHTML = "Obese";

                } else if (respose === 'Over weight') {
                    document.getElementById('BMIagegirls').innerHTML = "Over weight";

                } else if (respose === 'Over Weight Risk') {
                    document.getElementById('BMIagegirls').innerHTML = "Over Weight Risk";

                } else if (respose === 'Normal') {
                    document.getElementById('BMIagegirls').innerHTML = "Normal";
                } else if (respose === 'Wasted') {
                    document.getElementById('BMIagegirls').innerHTML = "Wasted";

                } else if (respose === 'Severely Wasted') {
                    document.getElementById('BMIagegirls').innerHTML = "Severely Wasted";

                } else {
                    document.getElementById('BMIagegirls').innerHTML = "Invalid";
                }
            }
        });

    }
    function savepatienttriageboys() {
        var hfazscore = $('#heightlengthboys').html();
        var wfazscore = $('#weightageboys').html();
        var wfhzscore = $('#weightheightboys').html();
        var patientWeight = document.getElementById('patientWeightb').value;
        var patientTemperature = document.getElementById('patientTemperatureb').value;
        var muac = document.getElementById('muac').value;
        var patientHeight = document.getElementById('patientHeightb').value;
        var patientPressureSystolic = document.getElementById('patientPressureSystolicb').value;
        var patientPressureDiastolic = document.getElementById('patientPressureDiastolicb').value;
        var patientPulse = document.getElementById('patientPulseb').value;
        var patientBodySurfaceArea = document.getElementById('patientBodySurfaceAreab').value;
        var patientRespirationRate = document.getElementById('patientRespirationRateb').value;
        var patientTriageNotes = document.getElementById('patientTriageNotesb').value;
        if (patientWeight.toString().length < 1 && patientHeight.toString().length < 1 && patientTemperature.toString().length < 1 && patientPressureSystolic.toString().length < 1 && patientPressureDiastolic.toString().length < 1 && patientPulse.toString().length < 1 && patientBodySurfaceArea.toString().length < 1 && patientRespirationRate.toString().length < 1 && patientTriageNotes.toString().length < 1 && muac.toString().length < 1 && hfazscore.toString().length < 1 && wfazscore.toString().length < 1 && wfhzscore.toString().length < 1) {
            queuePatientToOtherService(patientVisitationId);
        } else {

            var data = {
                patientVisitationId: patientVisitationId,
                patientWeight: patientWeight,
                patientTemperature: patientTemperature,
                patientHeight: patientHeight,
                patientPressureSystolic: patientPressureSystolic,
                patientPressureDiastolic: patientPressureDiastolic,
                patientPulse: patientPulse,
                muac: muac,
                patientBodySurfaceArea: patientBodySurfaceArea,
                patientRespirationRate: patientRespirationRate,
                patientTriageNotes: patientTriageNotes,
                hfazscore: hfazscore,
                wfazscore: wfazscore,
                wfhzscore: wfhzscore
            };

            $.ajax({
                type: 'POST',
                cache: false,
                data: {value: JSON.stringify(data)},
                url: "paediatrics/savePatientTriageb.htm",
                success: function (resp) {
                    $('#patientWeightb').val("");
                    $('#patientTemperatureb').val("");
                    $('#patientHeightb').val("");
                    $('#patientPressureSystolicb').val("");
                    $('#patientPressureDiastolicb').val("");
                    $('#patientPulseb').val("");
                    $('#patientBodySurfaceAreab').val("");
                    $('#patientRespirationRateb').val("");
                    $('#patientTriageNotesb').val("");
                    $('#patientBMIReportb').val("");
                    $('#heightlengthboys').val("");
                    $('#weightageboys').val("");
                    $('#weightheightboys').val("");
                    $('#muac').val("");
                    queuePatientToOtherService(patientVisitationId);
                }
            });
        }
    }
    function savepatienttriageboysb() {
        var hfazscore = $('#heightlengthboysb').html();
        var wfazscore = $('#weightageboysb').html();
        var bmiboys = $('#bmiboys').html();
        var patientWeight = document.getElementById('patientWeightbb').value;
        var patientTemperature = document.getElementById('patientTemperaturebb').value;
        var muac = document.getElementById('muacb').value;
        var patientHeight = document.getElementById('patientHeightbb').value;
        var patientPressureSystolic = document.getElementById('patientPressureSystolicbb').value;
        var patientPressureDiastolic = document.getElementById('patientPressureDiastolicbb').value;
        var patientPulse = document.getElementById('patientPulsebb').value;
        var patientBodySurfaceArea = document.getElementById('patientBodySurfaceAreabb').value;
        var patientRespirationRate = document.getElementById('patientRespirationRatebb').value;
        var patientTriageNotes = document.getElementById('patientTriageNotesbb').value;
        if (patientWeight.toString().length < 1 && patientHeight.toString().length < 1 && patientTemperature.toString().length < 1 && patientPressureSystolic.toString().length < 1 && patientPressureDiastolic.toString().length < 1 && patientPulse.toString().length < 1 && patientBodySurfaceArea.toString().length < 1 && patientRespirationRate.toString().length < 1 && patientTriageNotes.toString().length < 1 && muac.toString().length < 1 && hfazscore.toString().length < 1 && wfazscore.toString().length < 1 && wfhzscore.toString().length < 1) {
            queuePatientToOtherService(patientVisitationId);
        } else {

            var data = {
                patientVisitationId: patientVisitationId,
                patientWeight: patientWeight,
                patientTemperature: patientTemperature,
                patientHeight: patientHeight,
                patientPressureSystolic: patientPressureSystolic,
                patientPressureDiastolic: patientPressureDiastolic,
                patientPulse: patientPulse,
                muac: muac,
                patientBodySurfaceArea: patientBodySurfaceArea,
                patientRespirationRate: patientRespirationRate,
                patientTriageNotes: patientTriageNotes,
                hfazscore: hfazscore,
                wfazscore: wfazscore,
                bmiboys: bmiboys
            };

            $.ajax({
                type: 'POST',
                cache: false,
                data: {value: JSON.stringify(data)},
                url: "paediatrics/savePatientTriagebb.htm",
                success: function (resp) {
                    $('#patientWeightbb').val("");
                    $('#patientTemperaturebb').val("");
                    $('#patientHeightbb').val("");
                    $('#patientPressureSystolicbb').val("");
                    $('#patientPressureDiastolicbb').val("");
                    $('#patientPulsebb').val("");
                    $('#patientBodySurfaceAreabb').val("");
                    $('#patientRespirationRatebb').val("");
                    $('#patientTriageNotesbb').val("");
                    $('#patientBMIReportbb').val("");
                    $('#heightlengthboysb').val("");
                    $('#weightageboysb').val("");
                    $('#bmiboys').val("");
                    $('#muacb').val("");
                    queuePatientToOtherService(patientVisitationId);
                }
            });
        }
    }
    function queuePatientToOtherService(patientVisitationId) {
        $.ajax({
            type: 'GET',
            data: {patientVisitationId: patientVisitationId},
            url: "doctorconsultation/queuepatienttootherservice.htm",
            success: function (data) {
                $.confirm({
                    title: 'SELECT SERVICE TO QUEUE PATIENT NEXT',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '50%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Queue',
                            btnClass: 'btn-purple',
                            action: function () {
                                var queueStaffid = $('#QueuingUnitServiceStaffid').val();
                                var serviceid = $('#queuingFacilityUnitServices').val();
                                var queueData = {
                                    type: 'ADD',
                                    visitid: parseInt(patientVisitationId),
                                    serviceid: serviceid,
                                    staffid: queueStaffid
                                };
                                var host = location.host;
                                var url = 'ws://' + host + '/IICS/queuingServer';
                                var ws = new WebSocket(url);
                                //
                                queueData.host = host;
                                //
                                ws.onopen = function (ev) {
                                    ws.send(JSON.stringify(queueData));
                                };
                                ws.onmessage = function (ev) {
                                    if (ev.data === 'ADDED') {
                                        window.location = '#close';
                                    }
                                };
                            }
                        },
                        close: {
                            text: 'Close',
                            btnClass: 'btn-red',
                            action: function () {

                            }
                        }
                    }
                });
            }
        });
    }
    function savepatientTriagegirls() {
        var hfazscore = $('#heightlengthgirls').html();
        var wfazscore = $('#weightagegirls').html();
        var wfhzscore = $('#weightheightgirls').html();
        var wfhzscore = $('#weightheightgirls').html();
        var patientWeight = document.getElementById('patientWeightg').value;
        var patientTemperature = document.getElementById('patientTemperatureg').value;
        var muac = document.getElementById('muacgirls').value;
        var patientHeight = document.getElementById('patientHeightg').value;
        var patientPressureSystolic = document.getElementById('patientPressureSystolicg').value;
        var patientPressureDiastolic = document.getElementById('patientPressureDiastolicg').value;
        var patientPulse = document.getElementById('patientPulseg').value;
        var patientBodySurfaceArea = document.getElementById('patientBodySurfaceAreag').value;
        var patientRespirationRate = document.getElementById('patientRespirationRateg').value;
        var patientTriageNotes = document.getElementById('patientTriageNotesg').value;
        if (patientWeight.toString().length < 1 && patientHeight.toString().length < 1 && patientTemperature.toString().length < 1 && patientPressureSystolic.toString().length < 1 && patientPressureDiastolic.toString().length < 1 && patientPulse.toString().length < 1 && patientBodySurfaceArea.toString().length < 1 && patientRespirationRate.toString().length < 1 && patientTriageNotes.toString().length < 1 && muac.toString().length < 1 && hfazscore.toString().length < 1 && wfazscore.toString().length < 1 && wfhzscore.toString().length < 1) {
            queuePatientToOtherService(patientVisitationId);
        } else {
            var data = {
                patientVisitationId: patientVisitationId,
                patientWeight: patientWeight,
                patientTemperature: patientTemperature,
                patientHeight: patientHeight,
                patientPressureSystolic: patientPressureSystolic,
                patientPressureDiastolic: patientPressureDiastolic,
                patientPulse: patientPulse,
                muac: muac,
                patientBodySurfaceArea: patientBodySurfaceArea,
                patientRespirationRate: patientRespirationRate,
                patientTriageNotes: patientTriageNotes,
                hfazscore: hfazscore,
                wfazscore: wfazscore,
                wfhzscore: wfhzscore
            };

            $.ajax({
                type: 'POST',
                cache: false,
                data: {value: JSON.stringify(data)},
                url: "paediatrics/savePatientTriageg.htm",
                success: function (resp) {
                    $('#patientWeightg').val("");
                    $('#patientTemperatureg').val("");
                    $('#patientHeightg').val("");
                    $('#patientPressureSystolicg').val("");
                    $('#patientPressureDiastolicg').val("");
                    $('#patientPulseg').val("");
                    $('#patientBodySurfaceAreag').val("");
                    $('#patientRespirationRateg').val("");
                    $('#patientTriageNotesg').val("");
                    $('#patientBMIReportg').val("");
                    $('#heightlengthgirls').val("");
                    $('#weightagegirls').val("");
                    $('#weightheightgirls').val("");
                    $('#muacgirls').val("");
                    queuePatientToOtherService(patientVisitationId);
                }
            });
        }
    }
    function savepatientTriagegirlsBMI() {
        var hfazscore = $('#heightlengthgirlsg').html();
        var wfazscore = $('#weightagegirlsg').html();
        var BMIagegirls = $('#BMIagegirls').html();
        var patientWeight = document.getElementById('patientWeightgg').value;
        var patientTemperature = document.getElementById('patientTemperaturegg').value;
        var muac = document.getElementById('muacgirlsg').value;
        var patientHeight = document.getElementById('patientHeightgg').value;
        var patientPressureSystolic = document.getElementById('patientPressureSystolicgg').value;
        var patientPressureDiastolic = document.getElementById('patientPressureDiastolicgg').value;
        var patientPulse = document.getElementById('patientPulsegg').value;
        var patientBodySurfaceArea = document.getElementById('patientBodySurfaceAreagg').value;
        var patientRespirationRate = document.getElementById('patientRespirationRategg').value;
        var patientTriageNotes = document.getElementById('patientTriageNotesgg').value;
        if (patientWeight.toString().length < 1 && patientHeight.toString().length < 1 && patientTemperature.toString().length < 1 && patientPressureSystolic.toString().length < 1 && patientPressureDiastolic.toString().length < 1 && patientPulse.toString().length < 1 && patientBodySurfaceArea.toString().length < 1 && patientRespirationRate.toString().length < 1 && patientTriageNotes.toString().length < 1 && muac.toString().length < 1 && hfazscore.toString().length < 1 && wfazscore.toString().length < 1 && wfhzscore.toString().length < 1) {
            queuePatientToOtherService(patientVisitationId);
        } else {
            var data = {
                patientVisitationId: patientVisitationId,
                patientWeight: patientWeight,
                patientTemperature: patientTemperature,
                patientHeight: patientHeight,
                patientPressureSystolic: patientPressureSystolic,
                patientPressureDiastolic: patientPressureDiastolic,
                patientPulse: patientPulse,
                muac: muac,
                patientBodySurfaceArea: patientBodySurfaceArea,
                patientRespirationRate: patientRespirationRate,
                patientTriageNotes: patientTriageNotes,
                hfazscore: hfazscore,
                wfazscore: wfazscore,
                BMIagegirls: BMIagegirls
            };

            $.ajax({
                type: 'POST',
                cache: false,
                data: {value: JSON.stringify(data)},
                url: "paediatrics/savePatientTriagegg.htm",
                success: function (resp) {
                    $('#patientWeightgg').val("");
                    $('#patientTemperaturegg').val("");
                    $('#patientHeightgg').val("");
                    $('#patientPressureSystolicgg').val("");
                    $('#patientPressureDiastolicgg').val("");
                    $('#patientPulsegg').val("");
                    $('#patientBodySurfaceAreagg').val("");
                    $('#patientRespirationRategg').val("");
                    $('#patientTriageNotesgg').val("");
                    $('#patientBMIReportgg').val("");
                    $('#heightlengthgirls').val("");
                    $('#weightagegirls').val("");
                    $('#weightheightgirls').val("");
                    $('#muacgirls').val("");
                    queuePatientToOtherService(patientVisitationId);
                }
            });
        }

    }

</script>