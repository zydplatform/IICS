<%--
    Document   : registerNewPatient
    Created on : Apr 10, 2018, 5:57:46 PM
    Author     : Grace-K
--%>
<%@include file="../../include.jsp"%>
<link rel="stylesheet" type="text/css" href="static/res/css/jqueryNewDatePicker.css">

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="patient-visit-create">
    <div class="app-title" >
        <div class="col-md-5">
            <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
            <p>Together We Save Lives...!</p>
        </div>

        <div>
            <div class="mmmains">
                <div class="wrapper">
                    <ul class="breadcrumbs">
                        <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                        <li><a href="#" onclick="ajaxSubmitData('patient/patientmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Patient Management</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('patient/patientvisits.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Patient Visit</a></li>
                        <li class="last active"><a href="#">Register</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="row tile">
        <div class="col-md-4">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <div id="entryform">
                                <div id="horizontalwithwords"><span class="pat-form-heading">BASIC DETAILS</span></div>

                                <label class="control-label" for="pin">Patient Number(PIN):</label>
                                <input style="display: unset !important" class="form-control col-md-10" id="pin" name="pin" value="${currentid}" readonly="readonly"><span><a id="editPatientPin"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span><br>&nbsp;&nbsp;

                                <div class="form-group required">
                                    <label class="control-label" for="firstname">First Name:</label>
                                    <input class="form-control" value="${patientFirstName}" id="firstname" type="text" name="firstname" placeholder="First Name">
                                </div>

                                <div class="form-group required">
                                    <label class="control-label" for="lastname">Last Name:</label>
                                    <input class="form-control" value="${patientLastName}" id="lastname" type="text" name="lastname" placeholder="Last Name">
                                </div>

                                <div class="form-group">
                                    <label class="control-label" for="othername">Other Name:</label>
                                    <input class="form-control" value="${patientOtherName}" id="othername" type="text" name="othername" placeholder="Other Name">
                                </div>

                                <div class="form-group required" id="">
                                    <label class="control-label"><a id="">D.O.B:  <font color="#9e8aa8">(Enter D.O.B or Age)</font></a></label><input style="display: unset !important; " class="form-control col-md-12" id="dateOfBirth" name="" placeholder="DD-MM-YYYY"><br>
                                    <!--                                    <label class="control-label"><a id="">Age (Years):</a></label>&nbsp;<input type="number" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="patient-age" max="130" min="0" size="3" oninput="functionComputeDateOfBirth()">                                    -->
                                    <label class="control-label"><a id="">Age (Years):</a></label>&nbsp;<input type="number" style="display: unset !important; margin-top: 7px" class="form-control col-md-2" id="patient-age" max="130" min="0" size="3" oninput="functionComputeDateOfBirth()">                                                                        
                                    <!--                                    <label class="control-label"><a id="">Or Age (Days):</a></label>&nbsp;<input type="number" style="display: unset !important; margin-top: 7px" class="form-control col-md-3" id="patient-age-days" min="0" size="3" />-->
                                    <label class="control-label"><a id="">Or Age (Days):</a></label>&nbsp;<input type="number" style="display: unset !important; margin-top: 7px" class="form-control col-md-2" id="patient-age-days" min="0" size="3" />
                                    <i id="age-error" class="fa fa-times-circle"  style="font-size: 1.15em; display: none; color: #ff0000;"></i>
                                </div>

                                <div class="form-group required">
                                    <label class="control-label">Nationality:</label>
                                    <div>
                                        <div class="form-group">
                                            <select class="form-control"  id="nationality" name="country" >
                                                <option class="textbolder" value="Ugandan">Ugandan</option>
                                                <option class="textbolder" value="Afghan">Afghan</option>
                                                <option class="textbolder" value="Albanian">Albanian</option>
                                                <option class="textbolder" value="Algerian">Algerian</option>
                                                <option class="textbolder" value="American">American</option>
                                                <option class="textbolder" value="Andorran">Andorran</option>
                                                <option class="textbolder" value="Angolan">Angolan</option>
                                                <option class="textbolder" value="Antiguans">Antiguans</option>
                                                <option class="textbolder" value="Argentinean">Argentinean</option>
                                                <option class="textbolder" value="Armenian">Armenian</option>
                                                <option class="textbolder" value="Australian">Australian</option>
                                                <option class="textbolder" value="Austrian">Austrian</option>
                                                <option class="textbolder" value="Azerbaijani">Azerbaijani</option>
                                                <option class="textbolder" value="Bahamian">Bahamian</option>
                                                <option class="textbolder" value="Bahraini">Bahraini</option>
                                                <option class="textbolder" value="Bangladeshi">Bangladeshi</option>
                                                <option class="textbolder" value="Barbadian">Barbadian</option>
                                                <option class="textbolder" value="Barbudans">Barbudans</option>
                                                <option class="textbolder" value="Batswana">Batswana</option>
                                                <option class="textbolder" value="Belarusian">Belarusian</option>
                                                <option class="textbolder" value="Belgian">Belgian</option>
                                                <option class="textbolder" value="Belizean">Belizean</option>
                                                <option class="textbolder" value="Beninese">Beninese</option>
                                                <option class="textbolder" value="Bhutanese">Bhutanese</option>
                                                <option class="textbolder" value="Bolivian">Bolivian</option>
                                                <option class="textbolder" value="Bosnian">Bosnian</option>
                                                <option class="textbolder" value="Brazilian">Brazilian</option>
                                                <option class="textbolder" value="British">British</option>
                                                <option class="textbolder" value="Bruneian">Bruneian</option>
                                                <option class="textbolder" value="Bulgarian">Bulgarian</option>
                                                <option class="textbolder" value="Burkinabe">Burkinabe</option>
                                                <option class="textbolder" value="Burmese">Burmese</option>
                                                <option class="textbolder" value="Burundian">Burundian</option>
                                                <option class="textbolder" value="Cambodian">Cambodian</option>
                                                <option class="textbolder" value="Cameroonian">Cameroonian</option>
                                                <option class="textbolder" value="Canadian">Canadian</option>
                                                <option class="textbolder" value="Cape verdean">Cape Verdean</option>
                                                <option class="textbolder" value="Central african">Central African</option>
                                                <option class="textbolder" value="Chadian">Chadian</option>
                                                <option class="textbolder" value="Chilean">Chilean</option>
                                                <option class="textbolder" value="Chinese">Chinese</option>
                                                <option class="textbolder" value="Colombian">Colombian</option>
                                                <option class="textbolder" value="Comoran">Comoran</option>
                                                <option class="textbolder" value="Congolese">Congolese</option>
                                                <option class="textbolder" value="Costa rican">Costa Rican</option>
                                                <option class="textbolder" value="Croatian">Croatian</option>
                                                <option class="textbolder" value="Cuban">Cuban</option>
                                                <option class="textbolder" value="Cypriot">Cypriot</option>
                                                <option class="textbolder" value="Czech">Czech</option>
                                                <option class="textbolder" value="Danish">Danish</option>
                                                <option class="textbolder" value="Djibouti">Djibouti</option>
                                                <option class="textbolder" value="Dominican">Dominican</option>
                                                <option class="textbolder" value="Dutch">Dutch</option>
                                                <option class="textbolder" value="East timorese">East Timorese</option>
                                                <option class="textbolder" value="Ecuadorean">Ecuadorean</option>
                                                <option class="textbolder" value="Egyptian">Egyptian</option>
                                                <option class="textbolder" value="Emirian">Emirian</option>
                                                <option class="textbolder" value="Equatorial guinean">Equatorial Guinean</option>
                                                <option class="textbolder" value="Eritrean">Eritrean</option>
                                                <option class="textbolder" value="Estonian">Estonian</option>
                                                <option class="textbolder" value="Ethiopian">Ethiopian</option>
                                                <option class="textbolder" value="fijian">Fijian</option>
                                                <option class="textbolder" value="filipino">Filipino</option>
                                                <option class="textbolder" value="finnish">Finnish</option>
                                                <option class="textbolder" value="french">French</option>
                                                <option class="textbolder" value="gabonese">Gabonese</option>
                                                <option class="textbolder" value="gambian">Gambian</option>
                                                <option class="textbolder" value="georgian">Georgian</option>
                                                <option class="textbolder" value="german">German</option>
                                                <option class="textbolder" value="ghanaian">Ghanaian</option>
                                                <option class="textbolder" value="greek">Greek</option>
                                                <option class="textbolder" value="grenadian">Grenadian</option>
                                                <option class="textbolder" value="guatemalan">Guatemalan</option>
                                                <option class="textbolder" value="guinea-bissauan">Guinea-Bissauan</option>
                                                <option class="textbolder" value="guinean">Guinean</option>
                                                <option class="textbolder" value="guyanese">Guyanese</option>
                                                <option class="textbolder" value="haitian">Haitian</option>
                                                <option class="textbolder" value="herzegovinian">Herzegovinian</option>
                                                <option class="textbolder" value="honduran">Honduran</option>
                                                <option class="textbolder" value="hungarian">Hungarian</option>
                                                <option class="textbolder" value="icelander">Icelander</option>
                                                <option class="textbolder" value="indian">Indian</option>
                                                <option class="textbolder" value="indonesian">Indonesian</option>
                                                <option class="textbolder" value="iranian">Iranian</option>
                                                <option class="textbolder" value="iraqi">Iraqi</option>
                                                <option class="textbolder" value="irish">Irish</option>
                                                <option class="textbolder" value="israeli">Israeli</option>
                                                <option class="textbolder" value="italian">Italian</option>
                                                <option class="textbolder" value="ivorian">Ivorian</option>
                                                <option class="textbolder" value="jamaican">Jamaican</option>
                                                <option class="textbolder" value="japanese">Japanese</option>
                                                <option class="textbolder" value="jordanian">Jordanian</option>
                                                <option class="textbolder" value="kazakhstani">Kazakhstani</option>
                                                <option class="textbolder" value="kenyan">Kenyan</option>
                                                <option class="textbolder" value="kittian and nevisian">Kittian and Nevisian</option>
                                                <option class="textbolder" value="kuwaiti">Kuwaiti</option>
                                                <option class="textbolder" value="kyrgyz">Kyrgyz</option>
                                                <option class="textbolder" value="laotian">Laotian</option>
                                                <option class="textbolder" value="latvian">Latvian</option>
                                                <option class="textbolder" value="lebanese">Lebanese</option>
                                                <option class="textbolder" value="liberian">Liberian</option>
                                                <option class="textbolder" value="libyan">Libyan</option>
                                                <option class="textbolder" value="liechtensteiner">Liechtensteiner</option>
                                                <option class="textbolder"value="lithuanian">Lithuanian</option>
                                                <option class="textbolder" value="luxembourger">Luxembourger</option>
                                                <option class="textbolder" value="macedonian">Macedonian</option>
                                                <option class="textbolder" value="malagasy">Malagasy</option>
                                                <option class="textbolder" value="malawian">Malawian</option>
                                                <option class="textbolder" value="malaysian">Malaysian</option>
                                                <option class="textbolder" value="maldivan">Maldivan</option>
                                                <option class="textbolder" value="malian">Malian</option>
                                                <option class="textbolder" value="maltese">Maltese</option>
                                                <option class="textbolder" value="marshallese">Marshallese</option>
                                                <option class="textbolder" value="mauritanian">Mauritanian</option>
                                                <option class="textbolder" value="mauritian">Mauritian</option>
                                                <option class="textbolder" value="mexican">Mexican</option>
                                                <option class="textbolder" value="micronesian">Micronesian</option>
                                                <option class="textbolder" value="moldovan">Moldovan</option>
                                                <option class="textbolder" value="monacan">Monacan</option>
                                                <option class="textbolder" value="mongolian">Mongolian</option>
                                                <option class="textbolder" value="moroccan">Moroccan</option>
                                                <option class="textbolder" value="mosotho">Mosotho</option>
                                                <option class="textbolder" value="motswana">Motswana</option>
                                                <option class="textbolder" value="mozambican">Mozambican</option>
                                                <option class="textbolder" value="namibian">Namibian</option>
                                                <option class="textbolder" value="nauruan">Nauruan</option>
                                                <option class="textbolder" value="nepalese">Nepalese</option>
                                                <option class="textbolder" value="new zealander">New Zealander</option>
                                                <option class="textbolder" value="ni-vanuatu">Ni-Vanuatu</option>
                                                <option class="textbolder" value="nicaraguan">Nicaraguan</option>
                                                <option class="textbolder" value="nigerien">Nigerien</option>
                                                <option class="textbolder" value="north korean">North Korean</option>
                                                <option class="textbolder" value="northern irish">Northern Irish</option>
                                                <option class="textbolder" value="norwegian">Norwegian</option>
                                                <option class="textbolder" value="omani">Omani</option>
                                                <option class="textbolder" value="pakistani">Pakistani</option>
                                                <option class="textbolder" value="palauan">Palauan</option>
                                                <option class="textbolder" value="panamanian">Panamanian</option>
                                                <option class="textbolder" value="papua new guinean">Papua New Guinean</option>
                                                <option class="textbolder" value="paraguayan">Paraguayan</option>
                                                <option class="textbolder" value="peruvian">Peruvian</option>
                                                <option class="textbolder" value="polish">Polish</option>
                                                <option class="textbolder" value="portuguese">Portuguese</option>
                                                <option class="textbolder" value="qatari">Qatari</option>
                                                <option class="textbolder" value="romanian">Romanian</option>
                                                <option class="textbolder" value="russian">Russian</option>
                                                <option class="textbolder" value="rwandan">Rwandan</option>
                                                <option class="textbolder" value="saint lucian">Saint Lucian</option>
                                                <option class="textbolder" value="salvadoran">Salvadoran</option>
                                                <option class="textbolder" value="samoan">Samoan</option>
                                                <option class="textbolder" value="san marinese">San Marinese</option>
                                                <option class="textbolder" value="sao tomean">Sao Tomean</option>
                                                <option class="textbolder" value="saudi">Saudi</option>
                                                <option class="textbolder" value="scottish">Scottish</option>
                                                <option class="textbolder" value="senegalese">Senegalese</option>
                                                <option class="textbolder" value="serbian">Serbian</option>
                                                <option class="textbolder" value="seychellois">Seychellois</option>
                                                <option class="textbolder" value="sierra leonean">Sierra Leonean</option>
                                                <option class="textbolder" value="singaporean">Singaporean</option>
                                                <option class="textbolder" value="slovakian">Slovakian</option>
                                                <option class="textbolder" value="slovenian">Slovenian</option>
                                                <option class="textbolder" value="solomon islander">Solomon Islander</option>
                                                <option class="textbolder" value="somali">Somali</option>
                                                <option class="textbolder" value="south african">South African</option>
                                                <option class="textbolder" value="south korean">South Korean</option>
                                                <option class="textbolder" value="spanish">Spanish</option>
                                                <option class="textbolder" value="sri lankan">Sri Lankan</option>
                                                <option class="textbolder" value="sudanese">Sudanese</option>
                                                <option class="textbolder" value="surinamer">Surinamer</option>
                                                <option class="textbolder" value="swazi">Swazi</option>
                                                <option class="textbolder" value="swedish">Swedish</option>
                                                <option class="textbolder" value="swiss">Swiss</option>
                                                <option class="textbolder" value="syrian">Syrian</option>
                                                <option class="textbolder" value="taiwanese">Taiwanese</option>
                                                <option class="textbolder" value="tajik">Tajik</option>
                                                <option class="textbolder" value="tanzanian">Tanzanian</option>
                                                <option class="textbolder" value="thai">Thai</option>
                                                <option class="textbolder" value="togolese">Togolese</option>
                                                <option class="textbolder" value="tongan">Tongan</option>
                                                <option class="textbolder" value="trinidadian or tobagonian">Trinidadian or Tobagonian</option>
                                                <option class="textbolder" value="tunisian">Tunisian</option>
                                                <option class="textbolder" value="turkish">Turkish</option>
                                                <option class="textbolder" value="tuvaluan">Tuvaluan</option>
                                                <option class="textbolder" value="ukrainian">Ukrainian</option>
                                                <option class="textbolder" value="uruguayan">Uruguayan</option>
                                                <option class="textbolder" value="uzbekistani">Uzbekistani</option>
                                                <option class="textbolder" value="venezuelan">Venezuelan</option>
                                                <option class="textbolder" value="vietnamese">Vietnamese</option>
                                                <option class="textbolder" value="welsh">Welsh</option>
                                                <option class="textbolder" value="yemenite">Yemenite</option>
                                                <option class="textbolder" value="zambian">Zambian</option>
                                                <option class="textbolder" value="zimbabwean">Zimbabwean</option>

                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="tile-footer">
                                    <div class="form-group">
                                        <div class="btn-group">
                                            <a class="btn btn-select btn-outline-primary dropdown-toggle" data-toggle="dropdown" href="#"><i class="fa fa-picture-o"></i>Add Photo<span class="caret"></span></a>
                                            <div class="dropdown-menu myselect">
                                                <a class="dropdown-item" href="#" id="addpatientphoto1" data-toggle="modal">From WebCam</a>
                                                <a class="dropdown-item" href="#"  id="scannedpics" data-toggle="modal">From Scanner</a>
                                            </div>
                                        </div>

                                        <button class ="btn btn-outline-primary float-right" type="button">
                                            <i class="fa fa-hand-paper-o"></i>
                                            <span style="font-weight: bold">Enroll Finger Print</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div id="entryform">

                            <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">OTHER DETAILS</span></div>

                            <div class="form-group">
                                <div class="control-label required">
                                    <label >Gender:</label>
                                </div>
                                <div class="form-check" id="genderdiv">
                                    <label class="form-check-label">
                                        <input id="malegender" value="Male" class="form-check-input" type="radio" name="gender"><span class="label-text">Male</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </label>

                                    <label class="form-check-label">
                                        <input id="femalegender" value="Female" class="form-check-input" type="radio" name="gender"><span class="label-text">Female</span>
                                    </label>
                                </div>
                            </div>

                            <div class="form-group required">
                                <label class="control-label">District</label>
                                <select class="form-control select-district" id="district">

                                </select>
                            </div>

                            <div class="form-group required village">
                                <label class="control-label">Village</label>
                                <select class="form-control select-village" id="village">

                                </select>
                            </div>

                            <div class="form-group">
                                <label class="control-label" for="phoneno">Phone No.</label>
                                <input class="form-control" id="phoneno" name="phoneno" type="text" placeholder=""/>
                            </div>

                            <div class="form-group" id="nin-div-content">
                                <label class="control-label">NIN:</label>
                                <input class="form-control" name="nin" id="nin" type="text" placeholder="NIN">
                            </div>

                            <div class="form-group" style="display: none" id="passport-div-content">
                                <label class="control-label">Passport/Refugee No:</label>
                                <input class="form-control" name="" id="passportno" type="text">
                            </div>

                            <div class="form-group">
                                <label class="control-label">Spoken Language:</label>
                                <!--                                <select class="form-control" id="spokenlaguage" multiple="">
                                                                    <optgroup label="--Select languages--">
                                                                        <option class="textbolder">Luganda</option>
                                                                        <option class="textbolder">English</option>
                                                                        <option class="textbolder">Lusoga</option>
                                                                        <option class="textbolder">Lunyankole</option>
                                                                    </optgroup>
                                                                </select>-->
                                <select class="form-control" id="spokenlanguage" multiple="">
                                    <c:forEach items="${languagelist}" var="r">               
                                        <option value="${r.languageid}">${r.languagename}</option>         
                                    </c:forEach> 
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="control-label" for="maritalstatus">Marital Status</label>
                                <select class="form-control" id="maritalstatus">
                                    <option selected disabled>- Select marital  status-</option>
                                    <option class="textbolder">Annulled</option>
                                    <option class="textbolder">Divorced</option>
                                    <option class="textbolder">Interlocutory</option>
                                    <option class="textbolder">Legally Separated</option>
                                    <option class="textbolder">Married</option>
                                    <option class="textbolder">Polygamous</option>
                                    <option class="textbolder">Never Married</option>
                                    <option class="textbolder">Domestic Partner</option>
                                    <option class="textbolder">Widowed</option>
                                </select>
                            </div>
                            <div class="tile-footer"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <form id="patientregistrationform">

                            <div id="horizontalwithwords"><span class="pat-form-heading">NEXT OF KIN DETAILS</span></div>

                            <div class="form-group">
                                <label class="control-label" for="nextofkinname">Next Of Kin: Full Name</label>
                                <input class="form-control" name="nextofkinname" id="nextofkinname" type="text" placeholder="Name">
                            </div>

                            <div class="form-group">
                                <label for="relationship">Relationship</label>
                                <select class="form-control" id="nextofkinrelationship">
                                    <option selected disabled>-- Select --</option>
                                    <option>Mother</option>
                                    <option>Father</option>
                                    <option>Sister</option>
                                    <option>Brother</option>
                                    <option>Aunt</option>
                                    <option>Uncle</option>
                                    <option>Friend</option>
                                    <option>Son</option>
                                    <option>Daughter</option>
                                    <option>Cousin</option>
                                    <option>Grand Mother</option>
                                    <option>Grand Father</option>
                                    <option>Girlfriend</option>
                                    <option>Boyfriend</option>
                                    <option>Husband</option>
                                    <option>Wife</option>
                                    <option>Nephew</option>
                                    <option>Niece</option>
                                    <option>Twin Brother</option>
                                    <option>Twin Sister</option>
                                    <option>Stepbrother</option>
                                    <option>Stepsister</option>
                                    <option>Twin Brother</option>
                                    <option>Mother-in-law</option>
                                    <option>Father-in-law</option>
                                    <option>Half-brother</option>
                                    <option>Half-sister</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="control-label">Next Of Kin: Phone No.</label>
                                <input class="form-control next-of-kin-phone-contact" name="nextofkinphone" id="nextofkinphone" type="text" placeholder=""/>
                            </div>&nbsp;
                            <div id="horizontalwithwords"><span class="pat-form-heading">PAYMENT MODES</span></div>

                            <div class="form-group">
                                <label for="relationship">Bill Mode</label>
                                <select onchange="doSelectBillMode(event);" class="form-control" id="billmode">
                                    <option>NON PAYING</option>
                                    <option>CASH</option>
                                    <option  data-insurance>INSURANCE</option>
                                    <option data-otherbilloptions>OTHER</option>
                                </select>
                            </div>

                        </form>
                    </div>
                </div>
                <div class="col-md-12">
                    <button class="btn btn-primary icon-btn pull-right" id="confirmNewPatientDetails">
                        <i class="fa fa-plus"></i>
                        Confirm Details
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!--model Insurance Details-->
<div class="modal fade" id="modelInsuranceDetails" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="" id="dialogs">Enter Insurance Details</h3>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <form class="form-group">
                            <div class="form-group">
                                <label for="">Insurance Name</label>
                                <select onchange="doSelectOtherInsuranceCo(event);" class="form-control" id="relationship">
                                    <option>Aon Uganda Limited</option>
                                    <option>JUBILEE</option>
                                    <option>AAR Health Services</option>
                                    <option data-otherInsuranceCo>OTHER</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="control-label">Card No.</label>
                                <input class="form-control" id="gpseasting" type="text" placeholder="">
                            </div>

                            <div class="form-group required">
                                <label class="control-label" for="">Holder Status</label>
                                <div class="">
                                    <input class="" name="male" type="radio" id="" data-id=""/>
                                    <span class="label-text">Owner</span>&nbsp;&nbsp;

                                    <input class="" name="female" type="radio" id="" data-id=""/>
                                    <span class="label-text">Dependant</span>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button id="" type="button" class="btn btn-primary" >Save</button>
            </div>
        </div>
    </div>
</div><!-- /.modal-content -->

<!--model Capture Scanned Image-->
<div class="modal fade" id="modelscannedpics" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="" id="dialogs">Upload Patient Scanned Photo</h3>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <form class="form-group">
                            <div class="form-group">
                                <label class="control-label">Reference Number</label>
                                <input class="form-control" id="" type="text" placeholder="Enter Reference Number">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" >Save</button>
            </div>
        </div>
    </div>
</div><!-- /.modal-content -->

<!--model Add New Insurance Company-->
<div class="modal fade" id="addNewInsuranceCo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="" id="dialogs">Add New Insurance Company</h3>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <form class="form-group">
                            <div class="form-group">
                                <label class="control-label">Insurance Company Name</label>
                                <input class="form-control" id="gpseasting" type="text" placeholder="Enter Name">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" >Save</button>
            </div>
        </div>
    </div>
</div><!-- /.modal-content -->

<!--model Add Bill Mode-->
<div class="modal fade" id="addNewBillMode" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="" id="dialogs">Add New Bill Mode</h3>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <form class="form-group">
                            <div class="form-group">
                                <label class="control-label">Bill Mode</label>
                                <input class="form-control" id="gpseasting" type="text" placeholder="Bill Mode Name">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" >Save</button>
            </div>
        </div>
    </div>
</div><!-- /.modal-content -->

<!--model Confirm Patient Details-->
<div class="">
    <div id="confirmPatientDetails" class="confirmPatient">
        <div>
            <div id="head">
                <a href="#close" title="Close" class="close2">X</a>
                <h5 class="modalDialog-title">Confirm Patient Details</h5>
            </div>
            <div class="scrollbar" id="content">
                <%@include file="../../patientsManagement/forms/confirmPatientDatails.jsp"%>
            </div>
        </div>
    </div>
</div>

<script>
    var serverDate = '${serverdate}';
    var languageIds = [];
    var languagenames = [];
    $(document).ready(function () {
        breadCrumb();
        $('#nationality').change(function () {
            var patientnationality = $('#nationality').val();
            if (patientnationality === 'ugandan') {
                $("#nin-div-content").show();
                $("#passport-div-content").hide();
            } else {
                $("#nin-div-content").hide();
                $("#passport-div-content").show();
            }
        });

        $('#dateOfBirth').datepicker({
            format: "dd/mm/yyyy",
            autoclose: true
        });

        $('#phoneno').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });

        $('.next-of-kin-phone-contact').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });

        $('#spokenlanguage').select2();
        $('.select2').css('width', '100%');

        $('#district').click(function () {
            $.ajax({
                type: 'POST',
                url: 'locations/fetchDistricts.htm',
                success: function (data) {
                    var res = JSON.parse(data);
                    if (res !== '' && res.length > 0) {
                        for (i in res) {
                            $('#district').append('<option class="textbolder" id="' + res[i].id + '" data-districtname="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                        }
                        var districtid = parseInt($('#district').val());
                        $.ajax({
                            type: 'POST',
                            url: 'locations/fetchDistrictVillages.htm',
                            data: {districtid: districtid},
                            success: function (data) {
                                var res = JSON.parse(data);
                                if (res !== '' && res.length > 0) {
                                    for (i in res) {
//                                        $('#village').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename="' + res[i].village + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                        $('#village').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename="' + res[i].village + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                    }
                                }
                            }
                        });
                    }
                }
            });
            $('.select-district').select2();
            $('.select-village').select2();
            $('.select2').css('width', '100%');

            $('#district').change(function () {
                $('#village').val(null).trigger('change');
                var districtid = parseInt($('#district').val());
                $.ajax({
                    type: 'POST',
                    url: 'locations/fetchDistrictVillages.htm',
                    data: {districtid: districtid},
                    success: function (data) {
                        var res = JSON.parse(data);
                        if (res !== '' && res.length > 0) {
                            $('#village').html('');
                            for (i in res) {
//                                $('#village').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename="' + res[i].village + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                $('#village').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename="' + res[i].village + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                            }
                        }
                    }
                });
            });
        });


        $('#confirmNewPatientDetails').click(function () {
            $('#appendlanguages').html('');
            languageIds = [];
            var success = collectlanguageids();
            if(success === false){
                return false;
            }
            var fname = document.getElementById('firstname').value;
            var lname = document.getElementById('lastname').value;
            var phoneno = document.getElementById('phoneno').value;
            var dateOfBirth = document.getElementById('dateOfBirth').value;

            var nextofkinname = document.getElementById('nextofkinname').value;
            var nextofkinrelationship = document.getElementById('nextofkinrelationship').value;
            var nextofkinphone = document.getElementById('nextofkinphone').value;
            $('#phoneno').css({"border": '2px solid #ced4da'});
            $('#nextofkinname').css({"border": '2px solid #ced4da'});
            $('#nextofkinrelationship').css({"border": '2px solid #ced4da'});
            $('#nextofkinphone').css({"border": '2px solid #ced4da'});

            $('#village').css({"border": '2px solid #ced4da'});
            $('#district').css({"border": '2px solid #ced4da'});
            if (fname === null || fname === '' || lname === null || lname === '' || dateOfBirth === null || dateOfBirth === '' || !($('#district').has('option').length > 0) || !($('#village').has('option').length > 0) || !$("input[name='gender']:checked").val()) {
                if (fname === null || fname === '') {
                    document.getElementById('firstname').focus();
                }
                if (lname === null || lname === '') {
                    document.getElementById('lastname').focus();
                }

                if (dateOfBirth === null || dateOfBirth === '') {
                    document.getElementById('dateOfBirth').focus();
                }

                if (!($('#village').has('option').length > 0)) {
                    $('#village').css({"border": '2px solid #00635a'});
                }

                if (!($('#district').has('option').length > 0)) {
                    $('#district').css({"border": '2px solid #00635a'});
                }

                if (!$("input[name='gender']:checked").val()) {
                    $('#genderdiv').css({"border": '2px solid #00635a'});
                }
            } else {
//                $('#spokenlaguage :selected').each(function (i, sel) {
//                    alert($(sel).val());
//
//                });
                var village = document.getElementById('village').value;
                var vill = $("#" + village).data("villagename");
                var district = document.getElementById('district').value;
                var dist = $("#" + district).data("districtname");
                $('#district').css({"border": '2px solid #ced4da'});
                $('#village').css({"border": '2px solid #ced4da'});
                $('#genderdiv').css({"border": '2px solid #ffffff'});
                if (phoneno === '' || phoneno === null) {
                    if (nextofkinname === '' || nextofkinrelationship === '') {
                        $.confirm({
                            icon: 'fa fa-warning',
                            title: 'Alert',
                            content: '<h5> Patient must provide either His/Her&nbsp;<strong style="font-size: 15px; text-transform: uppercase; color: blue;">Phone Number</strong> or <strong style="font-size: 15px; text-transform: uppercase; color: blue;">Next of kin details</strong></h5>',
                            boxWidth: '38%',
                            useBootstrap: false,
                            type: 'red',
                            typeAnimated: true,
                            buttons: {
                                ok: {
                                    text: 'OK',
                                    btnClass: 'btn-purple',
                                    action: function () {
                                        $('#phoneno').css({"border": '2px solid #f50808c4'});
                                        $('#nextofkinname').css({"border": '2px solid #f50808c4'});
                                        $('#nextofkinrelationship').css({"border": '2px solid #f50808c4'});
                                    }
                                }
                            }

                        });
                    } else {
                        $('#phoneno').css({"border": '2px solid #ced4da'});
                        $('#nextofkinname').css({"border": '2px solid #ced4da'});
                        $('#nextofkinrelationship').css({"border": '2px solid #ced4da'});

                        var patientEstAge = $('#patient-age').val();
                        var firstname = $('#firstname').val();
                        var lastname = $('#lastname').val();
                        var othername = $('#othername').val();
                        var pin = $('#pin').val();
                        var phoneno = $('#phoneno').val();
                        var nin = $('#nin').val();
                        var patientGender = $("input:radio[name=gender]:checked").val();
                        var nationality = document.getElementById('nationality').value;
                        var nextofkinname = $('#nextofkinname').val();
                        var nextofkinrelationship = $('#nextofkinrelationship').val();
                        var dateOfBirth = $('#dateOfBirth').val();
                        var nextofkinphone = $('#nextofkinphone').val();
                        var maritalstatus = $('#maritalstatus').val();

                        $("#nin2").text(nin);
                        $("#firstname2").text(firstname);
                        $("#lastname2").text(lastname);
                        $("#othername2").text(othername);
                        $("#pin2").text(pin);
                        $("#phoneno2").text(phoneno);
                        $("#dateOfBirth2").text(dateOfBirth);
                        $("#nextofkinphone2").text(nextofkinphone);
                        $("#gender2").text(patientGender);
                        $("#nationality2").text(nationality);
                        $("#nextofkinrelationship2").text(nextofkinrelationship);
                        $("#village3").text(dist + " : " + vill);
                        $("#villlageidhiddn").val(village);
                        $("#maritalstatus2").text(maritalstatus);
                        $("#inputestimatedage").val(patientEstAge);
                        $("#nextofkinname2").text(nextofkinname);

                        window.location = '#confirmPatientDetails';
                        initDialog('confirmPatient');
                    }

                } else {
                    $('#phoneno').css({"border": '2px solid #ced4da'});
                    $('#nextofkinname').css({"border": '2px solid #ced4da'});
                    $('#nextofkinrelationship').css({"border": '2px solid #ced4da'});

                    var patientEstAge = $('#patient-age').val();
                    var firstname = $('#firstname').val();
                    var lastname = $('#lastname').val();
                    var othername = $('#othername').val();
                    var pin = $('#pin').val();
                    var phoneno = $('#phoneno').val();
                    var nin = $('#nin').val();
                    var patientGender = $("input:radio[name=gender]:checked").val();
                    var nationality = document.getElementById('nationality').value;
                    var village = $('#village').val();
                    var nextofkinname = $('#nextofkinname').val();
                    var nextofkinrelationship = $('#nextofkinrelationship').val();
                    var dateOfBirth = $('#dateOfBirth').val();
                    var nextofkinphone = $('#nextofkinphone').val();
                    var maritalstatus = $('#maritalstatus').val();

                    $("#nin2").text(nin);
                    $("#firstname2").text(firstname);
                    $("#lastname2").text(lastname);
                    $("#othername2").text(othername);
                    $("#pin2").text(pin);
                    $("#phoneno2").text(phoneno);
                    $("#dateOfBirth2").text(dateOfBirth);
                    $("#nextofkinphone2").text(nextofkinphone);
                    $("#gender2").text(patientGender);
                    $("#nationality2").text(nationality);
                    $("#nextofkinrelationship2").text(nextofkinrelationship);
                    $("#village3").text(dist + " : " + vill);
                    $("#villlageidhiddn").val(village);
                    $("#maritalstatus2").text(maritalstatus);
                    $("#inputestimatedage").val(patientEstAge);
                    $("#nextofkinname2").text(nextofkinname);

                    window.location = '#confirmPatientDetails';
                    initDialog('confirmPatient');
                }
            }
        });

        $('#addpatientphoto1').click(function () {
            $('#modeladdpatientphoto').modal('show');
        });

        $('#saveCapturedPhoto').click(function () {
            $('#modeladdpatientphoto').modal('hide');
        });

        $('#scannedpics').click(function () {
            $('#modelscannedpics').modal('show');
        });

        $(".myselect a").click(function () {
            var selText = $(this).text();
            $(this).parents('.btn-group').find('.dropdown-toggle').html(selText + ' <span class="caret"></span>');
        });

        $('#editPatientPin').click(function () {
            document.getElementById("pin").readOnly = false;
            document.getElementById('pin').focus();
        });
        //
        $('#patient-age-days').on('input', function (e) {
            $("#dateOfBirth").datepicker("update", getDateOfBirthFromDays(e.target.value));
            $('i#age-error').css('display', 'none');
        });
    });
    function doSelectBillMode(event) {
        var option = event.srcElement.children[event.srcElement.selectedIndex];
        if (option.dataset.insurance !== undefined) {
            $('#modelInsuranceDetails').modal('show');
        }

        if (option.dataset.otherbilloptions !== undefined) {
            $('#addNewBillMode').modal('show');
        }
    }

    function doSelectOtherInsuranceCo(event) {
        var option = event.srcElement.children[event.srcElement.selectedIndex];
        if (option.dataset.otherInsuranceCo !== undefined) {
            $('#otherInsuranceCo').modal('show');
        }
    }

    function resetPatientForm() {
        document.getElementById("patientregistrationform").reset();
    }

    function functionComputeDateOfBirth() {
        var today = new Date(serverDate);
        var currentYear = today.getFullYear();
        var age = parseInt(document.getElementById('patient-age').value, 10);
        if (validateAge(age) !== false) {
            var patientdob = parseInt(currentYear) - age;
            $("#dateOfBirth").datepicker("update", '01/01/' + patientdob);
            $('i#age-error').css('display', 'none');
        } else {
            $('i#age-error').html(' Age must be between 1 and 130.');
            $('i#age-error').css('display', 'block');
            $('i#age-error').css('color', '#ff0000');
        }
    }
    var getDateOfBirthFromDays = function (days) {
        String.prototype.replaceAll = function (search, replacement) {
            var target = this;
            return target.replace(new RegExp(search, 'g'), replacement);
        };
        var today = new Date(serverDate);
        var age = parseInt(days, 10);
        // return(today.Date() - age).toString();
        var date = new Date(serverDate);
        date.setDate(today.getDate() - age);
        return convertDate(date.toISOString().slice(0, date.toISOString().lastIndexOf("T")).replaceAll("-", "/"));
    };
    function convertDate(inputFormat) {
        function pad(s) {
            return (s < 10) ? '0' + s : s;
        }
        var d = new Date(inputFormat);
        return [pad(d.getDate()), pad(d.getMonth() + 1), d.getFullYear()].join('/');
    }
    function validateAge(age) {
        return ((age <= 0) || (age > 130)) ? false : true;
    }

    //edit language
    function editlanguages() {
        debugger
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="">' +
                    '<div class="form-group">' +
                    '<label>Select languages:</label>' +
                    ' <select class="form-control" id="selectlanguageupdate" multiple="">' +
                    '<c:forEach items="${languagelist}" var="r">' +
                    '<option value="${r.languageid}">${r.languagename}</option>' +
                    '</c:forEach>' +
                    '</select>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        debugger
                        languageIds = [];
                        languagenames = [];
                        var data = this.$content.find('#spokenlanguageupdate').select2('data');
                        for (var i in data) {
                            languageIds.push(data[i].id);
                            languagenames.push(data[i].text);
                        }
                        var languagetext = languagenames.join(',');

                        $("#languages").text(languagetext);
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events                
                this.$content.find('#selectlanguageupdate').select2();
                this.$content.find('#selectlanguageupdate').find('select2-container').css('z-index', '999999999 !important');
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }


    function collectlanguageids() {    
        var result = false;
        var data = $('#spokenlanguage').select2('data');
        $('#appendlanguages').html('');
        for (var i in data) {
            languageIds.push(data[i].id);
            languagenames.push(data[i].text);
        }
        if (languageIds.length > 0) {
            var languagetext = languagenames.join(',');
            $('#appendlanguages').append(
                    '<div style="margin-left: -19px" class="col-md-9">' +
                    '<span class="control-label pat-form-heading patientConfirmFont" for="languages">' +
                    '<strong>Spoken Languages:</strong>' +
                    '</span>&nbsp;' +
                    '<span class="badge badge-primary" id="languages"><strong>' + languagetext + '</strong></span>' +
                    '<span><a onclick="editlanguages()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>' +
                    '</div>'

                    );
            result = true;
        } else {
            $.toast({
                heading: 'Error',
                text: "Please select atleast one spoken language.",
                icon: 'error',
                hideAfter: 4000,
                position: 'mid-center'
            });
            $('.select2-selection--multiple').css('border-color','#ff0000');
            result = false;
        }
        return result;
    }
</script>