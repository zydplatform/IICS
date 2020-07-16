<%-- 
    Document   : adddonorprogram
    Created on : Sep 4, 2018, 3:06:14 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>
<style>
    .autocomplete-suggestions { border: 1px solid #2E8B57; width: 26.5% !important; background: #fff; margin-top: -16px; cursor: default; overflow: auto; z-index: 99999999 !important; }
    .autocomplete-suggestion { padding: 10px 5px; width: 100% !important; font-size: 1.2em; white-space: nowrap; overflow: hidden; z-index: 99999999 !important;}
    .autocomplete-selected { background: #f0f0f0; }
    .autocomplete-suggestions strong { font-weight: normal; color: #3399ff; }

    .error
    {
        border:2px solid red;
    }
    .myform{
        width: 100% !important;
    }

    * {
        box-sizing: border-box;
    }

    body {
        font: 16px Arial;  
    }

    #searchfield { display: block; width: 100%; text-align: center; margin-bottom: 35px; }

    #searchfield form {
        display: inline-block;
        background: #eeefed;
        padding: 0;
        margin: 0;
        padding: 5px;
        border-radius: 3px;
        margin: 5px 0 0 0;
    }
    #searchfield form .biginput {
        width: 600px;
        height: 40px;
        background-color: #fff;
        border: 1px solid #c8c8c8;
        border-radius: 3px;
        color: #aeaeae;
        font-weight:normal;
        font-size: 1.5em;
        -webkit-transition: all 0.2s linear;
        -moz-transition: all 0.2s linear;
        transition: all 0.2s linear;
    }
    #searchfield form .biginput:focus {
        color: #858585;
    }

</style>
<div class="col-md-12">
    <div class="row" id="organisationDonorContent">
        <div class="col-md-6">
            <div class="tile">
                <div class="tile-body">
                    <div id="horizontalwithwords"><span class="pat-form-heading">DONOR BASIC DETAILS</span></div>
                    <form id="donorentryform">
                        <div class="form-group">
                            <div class="control-label required">
                                <label id="donorTypeLabel">Donor Type:</label>
                            </div>
                            <div class="form-check" id="donortypediv">
                                <label class="form-check-label">
                                    <input id="organisation" value="Organisation" class="form-check-input donortype" type="radio" name="donortype"><span class="label-text">Organisation</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </label>

                                <label class="form-check-label">
                                    <input id="individual" value="Individual" class="form-check-input donortype collapsible" type="radio" name="donortype"><span class="label-text">Individual</span>
                                </label>
                            </div>
                        </div>
                        <div id="organisationReg">
                            <div class="form-group required">
                                <label class="control-label">Donor Name:</label>
                                <input class="form-control" value="" type="hidden" id="donorid">
                                <div id="searchfield">
                                    <form>
                                        <input type="text" oninput="checkDonorName()" name="currency" class="form-control biginput" id="autocomplete" placeholder="Enter Donor Name">
                                    </form>
                                </div>
                                <div id="outputbox">
                                    <p id="outputcontent" style="display: none;"></p>
                                </div>
                                <h6 id='donorerr'></h6>
                            </div>

                            <div class="form-group required">
                                <label class="control-label">Country Of Origin:</label>
                                <div>
                                    <div class="form-group">
                                        <select class="form-control"  id="originCountry" name="country">
                                            <option class="textbolder" value="Uganda">Uganda</option>
                                            <option class="textbolder" value="Afghanistan">Afghanistan</option>    
                                            <option class="textbolder" value="Albania">Albania</option>
                                            <option class="textbolder" value="Algeria">Algeria</option>
                                            <option class="textbolder" value="Andorra">Andorra</option>
                                            <option class="textbolder" value="Angola">Angola</option>
                                            <option class="textbolder" value="Antigua and Barbuda">Antigua and Barbuda</option>
                                            <option class="textbolder" value="Argentina">Argentina</option>
                                            <option class="textbolder" value="Armenia">Armenia</option>
                                            <option class="textbolder" value="Australia">Australia</option>
                                            <option class="textbolder" value="Austria">Austria</option>
                                            <option class="textbolder" value="Azerbaijan">Azerbaijan</option>
                                            <option class="textbolder" value="Bahamas">Bahamas</option>
                                            <option class="textbolder" value="Bahrain">Bahrain</option>
                                            <option class="textbolder" value="Bangladesh">Bangladesh</option>
                                            <option class="textbolder" value="Barbados">Barbados</option>
                                            <option class="textbolder" value="Belarus">Belarus</option>
                                            <option class="textbolder" value="Belgium">Belgium</option>
                                            <option class="textbolder" value="Benin">Benin</option>
                                            <option class="textbolder" value="Bhutan">Bhutan</option>
                                            <option class="textbolder" value="Bolivia">Bolivia</option>
                                            <option class="textbolder" value="Bosnia and Herzegovina">Bosnia and Herzegovina</option>
                                            <option class="textbolder" value="Botswana">Botswana</option>
                                            <option class="textbolder" value="Brazil">Brazil</option>
                                            <option class="textbolder" value="Brunei">Brunei</option>
                                            <option class="textbolder" value="Bulgaria">Bulgaria</option>
                                            <option class="textbolder" value="Burkina Faso">Burkina Faso</option>
                                            <option class="textbolder" value="Burundi">Burundi</option>
                                            <option class="textbolder" value="Belize">Belize</option>
                                            <option class="textbolder" value="Cabo Verde">Cabo Verde</option>
                                            <option class="textbolder" value="Cambodia">Cambodia</option>
                                            <option class="textbolder" value="Cameroon">Cameroon</option>
                                            <option class="textbolder" value="Canada">Canada</option>
                                            <option class="textbolder" value="Central African Republic (CAR)">Central African Republic (CAR)</option>
                                            <option class="textbolder" value="Chad">Chad</option>
                                            <option class="textbolder" value="Chile">Chile</option>
                                            <option class="textbolder" value="China">China</option>
                                            <option class="textbolder" value="Colombia">Colombia</option>
                                            <option class="textbolder" value="Comoros">Comoros</option>
                                            <option class="textbolder" value="Costa Rica">Costa Rica</option>
                                            <option class="textbolder" value="Cote d'Ivoire">Cote d'Ivoire</option>
                                            <option class="textbolder" value="Croatia">Croatia</option>
                                            <option class="textbolder" value="Cuba">Cuba</option>
                                            <option class="textbolder" value="Cyprus">Cyprus</option>
                                            <option class="textbolder" value="Czech Republic">Czech Republic</option>
                                            <option class="textbolder" value="Democratic Republic of the Congo">Democratic Republic of the Congo</option>
                                            <option class="textbolder" value="Denmark">Denmark</option>
                                            <option class="textbolder" value="Djibouti">Djibouti</option>
                                            <option class="textbolder" value="Dominica">Dominica</option>
                                            <option class="textbolder" value="Dominican Republic">Dominican Republic</option>
                                            <option class="textbolder" value="Ecuador">Ecuador</option>
                                            <option class="textbolder" value="Egypt">Egypt</option>
                                            <option class="textbolder" value="El Salvador">El Salvador</option>
                                            <option class="textbolder" value="Equatorial Guinea">Equatorial Guinea</option>
                                            <option class="textbolder" value="Eritrea">Eritrea</option>
                                            <option class="textbolder" value="Estonia">Estonia</option>
                                            <option class="textbolder" value="Eswatini (formerly Swaziland)">Eswatini (formerly Swaziland)</option>
                                            <option class="textbolder" value="Ethiopia">Ethiopia</option>
                                            <option class="textbolder" value="Fiji">Fiji</option>
                                            <option class="textbolder" value="Finland">Finland</option>
                                            <option class="textbolder" value="France">France</option>
                                            <option class="textbolder" value="Gabon">Gabon</option>
                                            <option class="textbolder" value="Gambia">Gambia</option>
                                            <option class="textbolder" value="Georgia">Georgia</option>
                                            <option class="textbolder" value="Germany">Germany</option>
                                            <option class="textbolder" value="Ghana">Ghana</option>
                                            <option class="textbolder" value="Greece">Greece</option>
                                            <option class="textbolder" value="Grenada">Grenada</option>
                                            <option class="textbolder" value="Guatemala">Guatemala</option>
                                            <option class="textbolder" value="Guinea">Guinea</option>
                                            <option class="textbolder" value="Guinea-Bissau">Guinea-Bissau</option>
                                            <option class="textbolder" value="Guyana">Guyana</option>
                                            <option class="textbolder" value="Haiti">Haiti</option>
                                            <option class="textbolder" value="Honduras">Honduras</option>
                                            <option class="textbolder" value="Hungary">Hungary</option>
                                            <option class="textbolder" value="Iceland">Iceland</option>
                                            <option class="textbolder" value="India">India</option>
                                            <option class="textbolder" value="Indonesia">Indonesia</option>
                                            <option class="textbolder" value="Iran">Iran</option>
                                            <option class="textbolder" value="Iraq">Iraq</option>
                                            <option class="textbolder" value="Ireland">Ireland</option>
                                            <option class="textbolder" value="Israel">Israel</option>
                                            <option class="textbolder" value="Italy">Italy</option>
                                            <option class="textbolder" value="Jamaica">Jamaica</option>
                                            <option class="textbolder" value="Japan">Japan</option>
                                            <option class="textbolder" value="Jordan">Jordan</option>
                                            <option class="textbolder" value="Kazakhstan">Kazakhstan</option>
                                            <option class="textbolder" value="Kenya">Kenya</option>
                                            <option class="textbolder" value="Kiribati">Kiribati</option>
                                            <option class="textbolder" value="Kosovo">Kosovo</option>
                                            <option class="textbolder" value="Kuwait">Kuwait</option>
                                            <option class="textbolder" value="Kyrgyzstan">Kyrgyzstan</option>
                                            <option class="textbolder" value="Laos">Laos</option>
                                            <option class="textbolder" value="Latvia">Latvia</option>
                                            <option class="textbolder" value="Lebanon">Lebanon</option>
                                            <option class="textbolder" value="Lesotho">Lesotho</option>
                                            <option class="textbolder" value="Liberia">Liberia</option>
                                            <option class="textbolder" value="Libya">Libya</option>
                                            <option class="textbolder" value="Liechtenstein">Liechtenstein</option>
                                            <option class="textbolder" value="Lithuania">Lithuania</option>
                                            <option class="textbolder" value="Luxembourg">Luxembourg</option>
                                            <option class="textbolder" value="Macedonia (FYROM)">Macedonia (FYROM)</option>
                                            <option class="textbolder" value="Madagascar">Madagascar</option>
                                            <option class="textbolder" value="Malawi">Malawi</option>
                                            <option class="textbolder" value="Malaysia">Malaysia</option>
                                            <option class="textbolder" value="Maldives">Maldives</option>
                                            <option class="textbolder" value="Mali">Mali</option>
                                            <option class="textbolder" value="Malta">Malta</option>
                                            <option class="textbolder" value="Marshall Islands">Marshall Islands</option>
                                            <option class="textbolder" value="Mauritania">Mauritania</option>
                                            <option class="textbolder" value="Mauritius">Mauritius</option>
                                            <option class="textbolder" value="Mexico">Mexico</option>
                                            <option class="textbolder" value="Micronesia">Micronesia</option>
                                            <option class="textbolder" value="Moldova">Moldova</option>
                                            <option class="textbolder" value="Monaco">Monaco</option>
                                            <option class="textbolder" value="Mongolia">Mongolia</option>
                                            <option class="textbolder" value="Montenegro">Montenegro</option>
                                            <option class="textbolder" value="Morocco">Morocco</option>
                                            <option class="textbolder" value="Mozambique">Mozambique</option>
                                            <option class="textbolder" value="Myanmar (formerly Burma)">Myanmar (formerly Burma)</option>
                                            <option class="textbolder" value="Namibia">Namibia</option>
                                            <option class="textbolder" value="Nauru">Nauru</option>
                                            <option class="textbolder" value="Nepal">Nepal</option>
                                            <option class="textbolder" value="Netherlands">Netherlands</option>
                                            <option class="textbolder" value="New Zealand">New Zealand</option>
                                            <option class="textbolder" value="Nicaragua">Nicaragua</option>
                                            <option class="textbolder" value="Niger">Niger</option>
                                            <option class="textbolder" value="Nigeria">Nigeria</option>
                                            <option class="textbolder" value="North Korea">North Korea</option>
                                            <option class="textbolder" value="Norway">Norway</option>
                                            <option class="textbolder" value="Oman">Oman</option>
                                            <option class="textbolder" value="Pakistan">Pakistan</option>
                                            <option class="textbolder" value="Palau">Palau</option>
                                            <option class="textbolder" value="Palestine">Palestine</option>
                                            <option class="textbolder" value="Panama">Panama</option>
                                            <option class="textbolder" value="Papua New Guinea">Papua New Guinea</option>
                                            <option class="textbolder" value="Paraguay">Paraguay</option>
                                            <option class="textbolder" value="Peru">Peru</option>
                                            <option class="textbolder" value="Philippines">Philippines</option>
                                            <option class="textbolder" value="Poland">Poland</option>
                                            <option class="textbolder" value="Portugal">Portugal</option>
                                            <option class="textbolder" value="Qatar">Qatar</option>
                                            <option class="textbolder" value="Romania">Romania</option>
                                            <option class="textbolder" value="Russia">Russia</option>
                                            <option class="textbolder" value="Rwanda">Rwanda</option>
                                            <option class="textbolder" value="Saint Kitts and Nevis">Saint Kitts and Nevis</option>
                                            <option class="textbolder" value="Saint Lucia">Saint Lucia</option>
                                            <option class="textbolder" value="Saint Vincent and the Grenadines">Saint Vincent and the Grenadines</option>
                                            <option class="textbolder" value="Samoa">Samoa</option>
                                            <option class="textbolder" value="San Marino">San Marino</option>
                                            <option class="textbolder" value="Sao Tome and Principe">Sao Tome and Principe</option>
                                            <option class="textbolder" value="Saudi Arabia">Saudi Arabia</option>
                                            <option class="textbolder" value="Senegal">Senegal</option>
                                            <option class="textbolder" value="Serbia">Serbia</option>
                                            <option class="textbolder" value="Seychelles">Seychelles</option>
                                            <option class="textbolder" value="Sierra Leone">Sierra Leone</option>
                                            <option class="textbolder" value="Singapore">Singapore</option>
                                            <option class="textbolder" value="Slovakia">Slovakia</option>
                                            <option class="textbolder" value="Slovenia">Slovenia</option>
                                            <option class="textbolder" value="Solomon Islands">Solomon Islands</option>
                                            <option class="textbolder" value="Somalia">Somalia</option>
                                            <option class="textbolder" value="South Africa">South Africa</option>
                                            <option class="textbolder" value="South Korea">South Korea</option>
                                            <option class="textbolder" value="South Sudan">South Sudan</option>
                                            <option class="textbolder" value="Spain">Spain</option>
                                            <option class="textbolder" value="Sri Lanka">Sri Lanka</option>
                                            <option class="textbolder" value="Sudan">Sudan</option>
                                            <option class="textbolder" value="Suriname">Suriname</option>
                                            <option class="textbolder" value="Sweden">Sweden</option>
                                            <option class="textbolder" value="Switzerland">Switzerland</option>
                                            <option class="textbolder" value="Syria">Syria</option>
                                            <option class="textbolder" value="Taiwan">Taiwan</option>
                                            <option class="textbolder" value="Tajikistan">Tajikistan</option>
                                            <option class="textbolder" value="Tanzania">Tanzania</option>
                                            <option class="textbolder" value="Thailand">Thailand</option>
                                            <option class="textbolder" value="Timor-Leste">Timor-Leste</option>
                                            <option class="textbolder" value="Togo">Togo</option>
                                            <option class="textbolder" value="Tonga">Tonga</option>
                                            <option class="textbolder" value="Trinidad and Tobago">Trinidad and Tobago</option>
                                            <option class="textbolder" value="Tunisia">Tunisia</option>
                                            <option class="textbolder" value="Turkey">Turkey</option>
                                            <option class="textbolder" value="Turkmenistan">Turkmenistan</option>
                                            <option class="textbolder" value="Tuvalu">Tuvalu</option>
                                            <option class="textbolder" value="Ukraine">Ukraine</option>
                                            <option class="textbolder" value="United Arab Emirates (UAE)">United Arab Emirates (UAE)</option>
                                            <option class="textbolder" value="United Kingdom (UK)">United Kingdom (UK)</option>
                                            <option class="textbolder" value="United States of America (USA)">United States of America (USA)</option>
                                            <option class="textbolder" value="Uruguay">Uruguay</option>
                                            <option class="textbolder" value="Uzbekistan">Uzbekistan</option>
                                            <option class="textbolder" value="Vanuatu">Vanuatu</option>
                                            <option class="textbolder" value="Vatican City (Holy See)">Vatican City (Holy See)</option>
                                            <option class="textbolder" value="Venezuela">Venezuela</option>
                                            <option class="textbolder" value="Vietnam">Vietnam</option>
                                            <option class="textbolder" value="Yemen">Yemen</option>
                                            <option class="textbolder" value="Zambia">Zambia</option>
                                            <option class="textbolder" value="Zimbabwe">Zimbabwe</option>
                                        </select>
                                    </div>
                                </div>
                            </div>    
                            <div class="form-group required">
                                <label class="control-label">Tel No.:</label>
                                <input class="form-control myform" autofocus="autofocus" id="telno" type="text" oninput="telnosss()" value="" placeholder="Enter Telephone Number">
                                <h6 id='telnoresult'></h6>
                            </div>
                            <div class="form-group required">
                                <label class="control-label">Email:</label>
                                <input class="form-control myform" autofocus="autofocus" id="email" oninput="checkEmail();" type="text" value="" placeholder="Enter Email Address">
                                <h6 id='result'></h6>
                            </div>
                            <div class="form-group">
                                <label class="control-label">Fax:</label>
                                <input class="form-control myform" autofocus="autofocus" id="fax" type="number" oninput="checkFax()" placeholder="Enter Fax">
                                <label class="control-label wrongfaxNo" style="color:red;"></label>
                            </div>
                        </div>
                        <div id="individualReg">
                            <div class="form-group required">
                                <label class="control-label">First Name:</label>
                                <!--                        <input class="form-control myform" id="frstname" type="text"  placeholder="Enter First Name">-->
                                <input class="form-control myform" id="indpersonid" type="hidden"  placeholder="Enter First Name">
                                <div id="individualDonorsearchfield">
                                    <form><input type="text" name="currency" class="form-control biginput" oninput="individualDonorAutocompletesss()" id="individualDonorAutocomplete"></form>
                                </div>
                                <div id="individualdonoroutputbox">
                                    <p id="individualdonoroutputcontent" style="display: none;"></p>
                                </div>
                                <h6 id='Indresult'></h6> 
                            </div>
                            <div class="form-group required">
                                <label class="control-label">Last Name:</label>
                                <input class="form-control myform" id="indScndname" oninput="indScndnamesss()" type="text" placeholder="Enter Second Name">
                                <h6 id='indLresult'></h6>
                            </div>
                            <div class="form-group">                        
                                <label class="control-label">Other Name:</label>
                                <input class="form-control myform" id="indOthername" type="text" placeholder="Enter Other Name">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="tile col-md-12">
                <div  id="contactPrsnDetails">
                    <div id="horizontalwithwords"><span class="pat-form-heading">CONTACT PERSON DETAILS</span></div>
                    <form id="buildingentryform">
                        <div class="form-group required">
                            <label class="control-label">First Name:</label>
                            <input class="form-control myform" id="personid" type="hidden"  placeholder="Enter First Name">
                            <div id="contactPrsnsearchfield">
                                <form><input type="text" name="currency" class="form-control biginput" oninput="contactPersonAutocompletess()" id="contactPersonAutocomplete"></form>
                            </div>
                            <div id="contactPrsnoutputbox">
                                <p id="contactPrsnoutputcontent" style="display: none;"></p>
                            </div>
                            <h6 id='Fnameresult'></h6>
                        </div>
                        <div class="form-group required">
                            <label class="control-label">Last Name:</label>
                            <input class="form-control myform" id="scndname" oninput="scndnameSS()" type="text" placeholder="Enter Second Name">
                            <h6 id='Lnameresult'></h6>
                        </div>
                        <div class="form-group">                        
                            <label class="control-label">Other Name:</label>
                            <input class="form-control myform" id="othername" type="text" placeholder="Enter Other Name">
                        </div>
                        <div class="form-group required">
                            <label class="control-label">Primary Contact:</label>
                            <input class="form-control myform" autofocus="autofocus" id="primaryContact" oninput="primaryContactss()" type="text" value="" placeholder="Enter Primary Contact">
                            <h6 id='priresult'></h6>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Secondary Contact:</label>
                            <input class="form-control myform" autofocus="autofocus" id="secondaryContact" type="text" value="" placeholder="Enter Secondary Contact">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Email:</label>
                            <input class="form-control myform" autofocus="autofocus" id="personEmail" oninput="checkContactPersonEmail();" type="text" value="" placeholder="Enter Email Address">
                            <h6 id='Emailresult'></h6>
                        </div>
                    </form>
                </div>
                <div id="individualContactDets">
                    <div class="form-group required">
                        <label class="control-label">Country Of Origin:</label>
                        <div>
                            <div class="form-group">
                                <select class="form-control"  id="indOriginCountry" name="country" >
                                    <option class="textbolder" value="Uganda">Uganda</option>
                                    <option class="textbolder" value="Afghanistan">Afghanistan</option>    
                                    <option class="textbolder" value="Albania">Albania</option>
                                    <option class="textbolder" value="Algeria">Algeria</option>
                                    <option class="textbolder" value="Andorra">Andorra</option>
                                    <option class="textbolder" value="Angola">Angola</option>
                                    <option class="textbolder" value="Antigua and Barbuda">Antigua and Barbuda</option>
                                    <option class="textbolder" value="Argentina">Argentina</option>
                                    <option class="textbolder" value="Armenia">Armenia</option>
                                    <option class="textbolder" value="Australia">Australia</option>
                                    <option class="textbolder" value="Austria">Austria</option>
                                    <option class="textbolder" value="Azerbaijan">Azerbaijan</option>
                                    <option class="textbolder" value="Bahamas">Bahamas</option>
                                    <option class="textbolder" value="Bahrain">Bahrain</option>
                                    <option class="textbolder" value="Bangladesh">Bangladesh</option>
                                    <option class="textbolder" value="Barbados">Barbados</option>
                                    <option class="textbolder" value="Belarus">Belarus</option>
                                    <option class="textbolder" value="Belgium">Belgium</option>
                                    <option class="textbolder" value="Benin">Benin</option>
                                    <option class="textbolder" value="Bhutan">Bhutan</option>
                                    <option class="textbolder" value="Bolivia">Bolivia</option>
                                    <option class="textbolder" value="Bosnia and Herzegovina">Bosnia and Herzegovina</option>
                                    <option class="textbolder" value="Botswana">Botswana</option>
                                    <option class="textbolder" value="Brazil">Brazil</option>
                                    <option class="textbolder" value="Brunei">Brunei</option>
                                    <option class="textbolder" value="Bulgaria">Bulgaria</option>
                                    <option class="textbolder" value="Burkina Faso">Burkina Faso</option>
                                    <option class="textbolder" value="Burundi">Burundi</option>
                                    <option class="textbolder" value="Belize">Belize</option>
                                    <option class="textbolder" value="Cabo Verde">Cabo Verde</option>
                                    <option class="textbolder" value="Cambodia">Cambodia</option>
                                    <option class="textbolder" value="Cameroon">Cameroon</option>
                                    <option class="textbolder" value="Canada">Canada</option>
                                    <option class="textbolder" value="Central African Republic (CAR)">Central African Republic (CAR)</option>
                                    <option class="textbolder" value="Chad">Chad</option>
                                    <option class="textbolder" value="Chile">Chile</option>
                                    <option class="textbolder" value="China">China</option>
                                    <option class="textbolder" value="Colombia">Colombia</option>
                                    <option class="textbolder" value="Comoros">Comoros</option>
                                    <option class="textbolder" value="Costa Rica">Costa Rica</option>
                                    <option class="textbolder" value="Cote d'Ivoire">Cote d'Ivoire</option>
                                    <option class="textbolder" value="Croatia">Croatia</option>
                                    <option class="textbolder" value="Cuba">Cuba</option>
                                    <option class="textbolder" value="Cyprus">Cyprus</option>
                                    <option class="textbolder" value="Czech Republic">Czech Republic</option>
                                    <option class="textbolder" value="Democratic Republic of the Congo">Democratic Republic of the Congo</option>
                                    <option class="textbolder" value="Denmark">Denmark</option>
                                    <option class="textbolder" value="Djibouti">Djibouti</option>
                                    <option class="textbolder" value="Dominica">Dominica</option>
                                    <option class="textbolder" value="Dominican Republic">Dominican Republic</option>
                                    <option class="textbolder" value="Ecuador">Ecuador</option>
                                    <option class="textbolder" value="Egypt">Egypt</option>
                                    <option class="textbolder" value="El Salvador">El Salvador</option>
                                    <option class="textbolder" value="Equatorial Guinea">Equatorial Guinea</option>
                                    <option class="textbolder" value="Eritrea">Eritrea</option>
                                    <option class="textbolder" value="Estonia">Estonia</option>
                                    <option class="textbolder" value="Eswatini (formerly Swaziland)">Eswatini (formerly Swaziland)</option>
                                    <option class="textbolder" value="Ethiopia">Ethiopia</option>
                                    <option class="textbolder" value="Fiji">Fiji</option>
                                    <option class="textbolder" value="Finland">Finland</option>
                                    <option class="textbolder" value="France">France</option>
                                    <option class="textbolder" value="Gabon">Gabon</option>
                                    <option class="textbolder" value="Gambia">Gambia</option>
                                    <option class="textbolder" value="Georgia">Georgia</option>
                                    <option class="textbolder" value="Germany">Germany</option>
                                    <option class="textbolder" value="Ghana">Ghana</option>
                                    <option class="textbolder" value="Greece">Greece</option>
                                    <option class="textbolder" value="Grenada">Grenada</option>
                                    <option class="textbolder" value="Guatemala">Guatemala</option>
                                    <option class="textbolder" value="Guinea">Guinea</option>
                                    <option class="textbolder" value="Guinea-Bissau">Guinea-Bissau</option>
                                    <option class="textbolder" value="Guyana">Guyana</option>
                                    <option class="textbolder" value="Haiti">Haiti</option>
                                    <option class="textbolder" value="Honduras">Honduras</option>
                                    <option class="textbolder" value="Hungary">Hungary</option>
                                    <option class="textbolder" value="Iceland">Iceland</option>
                                    <option class="textbolder" value="India">India</option>
                                    <option class="textbolder" value="Indonesia">Indonesia</option>
                                    <option class="textbolder" value="Iran">Iran</option>
                                    <option class="textbolder" value="Iraq">Iraq</option>
                                    <option class="textbolder" value="Ireland">Ireland</option>
                                    <option class="textbolder" value="Israel">Israel</option>
                                    <option class="textbolder" value="Italy">Italy</option>
                                    <option class="textbolder" value="Jamaica">Jamaica</option>
                                    <option class="textbolder" value="Japan">Japan</option>
                                    <option class="textbolder" value="Jordan">Jordan</option>
                                    <option class="textbolder" value="Kazakhstan">Kazakhstan</option>
                                    <option class="textbolder" value="Kenya">Kenya</option>
                                    <option class="textbolder" value="Kiribati">Kiribati</option>
                                    <option class="textbolder" value="Kosovo">Kosovo</option>
                                    <option class="textbolder" value="Kuwait">Kuwait</option>
                                    <option class="textbolder" value="Kyrgyzstan">Kyrgyzstan</option>
                                    <option class="textbolder" value="Laos">Laos</option>
                                    <option class="textbolder" value="Latvia">Latvia</option>
                                    <option class="textbolder" value="Lebanon">Lebanon</option>
                                    <option class="textbolder" value="Lesotho">Lesotho</option>
                                    <option class="textbolder" value="Liberia">Liberia</option>
                                    <option class="textbolder" value="Libya">Libya</option>
                                    <option class="textbolder" value="Liechtenstein">Liechtenstein</option>
                                    <option class="textbolder" value="Lithuania">Lithuania</option>
                                    <option class="textbolder" value="Luxembourg">Luxembourg</option>
                                    <option class="textbolder" value="Macedonia (FYROM)">Macedonia (FYROM)</option>
                                    <option class="textbolder" value="Madagascar">Madagascar</option>
                                    <option class="textbolder" value="Malawi">Malawi</option>
                                    <option class="textbolder" value="Malaysia">Malaysia</option>
                                    <option class="textbolder" value="Maldives">Maldives</option>
                                    <option class="textbolder" value="Mali">Mali</option>
                                    <option class="textbolder" value="Malta">Malta</option>
                                    <option class="textbolder" value="Marshall Islands">Marshall Islands</option>
                                    <option class="textbolder" value="Mauritania">Mauritania</option>
                                    <option class="textbolder" value="Mauritius">Mauritius</option>
                                    <option class="textbolder" value="Mexico">Mexico</option>
                                    <option class="textbolder" value="Micronesia">Micronesia</option>
                                    <option class="textbolder" value="Moldova">Moldova</option>
                                    <option class="textbolder" value="Monaco">Monaco</option>
                                    <option class="textbolder" value="Mongolia">Mongolia</option>
                                    <option class="textbolder" value="Montenegro">Montenegro</option>
                                    <option class="textbolder" value="Morocco">Morocco</option>
                                    <option class="textbolder" value="Mozambique">Mozambique</option>
                                    <option class="textbolder" value="Myanmar (formerly Burma)">Myanmar (formerly Burma)</option>
                                    <option class="textbolder" value="Namibia">Namibia</option>
                                    <option class="textbolder" value="Nauru">Nauru</option>
                                    <option class="textbolder" value="Nepal">Nepal</option>
                                    <option class="textbolder" value="Netherlands">Netherlands</option>
                                    <option class="textbolder" value="New Zealand">New Zealand</option>
                                    <option class="textbolder" value="Nicaragua">Nicaragua</option>
                                    <option class="textbolder" value="Niger">Niger</option>
                                    <option class="textbolder" value="Nigeria">Nigeria</option>
                                    <option class="textbolder" value="North Korea">North Korea</option>
                                    <option class="textbolder" value="Norway">Norway</option>
                                    <option class="textbolder" value="Oman">Oman</option>
                                    <option class="textbolder" value="Pakistan">Pakistan</option>
                                    <option class="textbolder" value="Palau">Palau</option>
                                    <option class="textbolder" value="Palestine">Palestine</option>
                                    <option class="textbolder" value="Panama">Panama</option>
                                    <option class="textbolder" value="Papua New Guinea">Papua New Guinea</option>
                                    <option class="textbolder" value="Paraguay">Paraguay</option>
                                    <option class="textbolder" value="Peru">Peru</option>
                                    <option class="textbolder" value="Philippines">Philippines</option>
                                    <option class="textbolder" value="Poland">Poland</option>
                                    <option class="textbolder" value="Portugal">Portugal</option>
                                    <option class="textbolder" value="Qatar">Qatar</option>
                                    <option class="textbolder" value="Romania">Romania</option>
                                    <option class="textbolder" value="Russia">Russia</option>
                                    <option class="textbolder" value="Rwanda">Rwanda</option>
                                    <option class="textbolder" value="Saint Kitts and Nevis">Saint Kitts and Nevis</option>
                                    <option class="textbolder" value="Saint Lucia">Saint Lucia</option>
                                    <option class="textbolder" value="Saint Vincent and the Grenadines">Saint Vincent and the Grenadines</option>
                                    <option class="textbolder" value="Samoa">Samoa</option>
                                    <option class="textbolder" value="San Marino">San Marino</option>
                                    <option class="textbolder" value="Sao Tome and Principe">Sao Tome and Principe</option>
                                    <option class="textbolder" value="Saudi Arabia">Saudi Arabia</option>
                                    <option class="textbolder" value="Senegal">Senegal</option>
                                    <option class="textbolder" value="Serbia">Serbia</option>
                                    <option class="textbolder" value="Seychelles">Seychelles</option>
                                    <option class="textbolder" value="Sierra Leone">Sierra Leone</option>
                                    <option class="textbolder" value="Singapore">Singapore</option>
                                    <option class="textbolder" value="Slovakia">Slovakia</option>
                                    <option class="textbolder" value="Slovenia">Slovenia</option>
                                    <option class="textbolder" value="Solomon Islands">Solomon Islands</option>
                                    <option class="textbolder" value="Somalia">Somalia</option>
                                    <option class="textbolder" value="South Africa">South Africa</option>
                                    <option class="textbolder" value="South Korea">South Korea</option>
                                    <option class="textbolder" value="South Sudan">South Sudan</option>
                                    <option class="textbolder" value="Spain">Spain</option>
                                    <option class="textbolder" value="Sri Lanka">Sri Lanka</option>
                                    <option class="textbolder" value="Sudan">Sudan</option>
                                    <option class="textbolder" value="Suriname">Suriname</option>
                                    <option class="textbolder" value="Sweden">Sweden</option>
                                    <option class="textbolder" value="Switzerland">Switzerland</option>
                                    <option class="textbolder" value="Syria">Syria</option>
                                    <option class="textbolder" value="Taiwan">Taiwan</option>
                                    <option class="textbolder" value="Tajikistan">Tajikistan</option>
                                    <option class="textbolder" value="Tanzania">Tanzania</option>
                                    <option class="textbolder" value="Thailand">Thailand</option>
                                    <option class="textbolder" value="Timor-Leste">Timor-Leste</option>
                                    <option class="textbolder" value="Togo">Togo</option>
                                    <option class="textbolder" value="Tonga">Tonga</option>
                                    <option class="textbolder" value="Trinidad and Tobago">Trinidad and Tobago</option>
                                    <option class="textbolder" value="Tunisia">Tunisia</option>
                                    <option class="textbolder" value="Turkey">Turkey</option>
                                    <option class="textbolder" value="Turkmenistan">Turkmenistan</option>
                                    <option class="textbolder" value="Tuvalu">Tuvalu</option>
                                    <option class="textbolder" value="Ukraine">Ukraine</option>
                                    <option class="textbolder" value="United Arab Emirates (UAE)">United Arab Emirates (UAE)</option>
                                    <option class="textbolder" value="United Kingdom (UK)">United Kingdom (UK)</option>
                                    <option class="textbolder" value="United States of America (USA)">United States of America (USA)</option>
                                    <option class="textbolder" value="Uruguay">Uruguay</option>
                                    <option class="textbolder" value="Uzbekistan">Uzbekistan</option>
                                    <option class="textbolder" value="Vanuatu">Vanuatu</option>
                                    <option class="textbolder" value="Vatican City (Holy See)">Vatican City (Holy See)</option>
                                    <option class="textbolder" value="Venezuela">Venezuela</option>
                                    <option class="textbolder" value="Vietnam">Vietnam</option>
                                    <option class="textbolder" value="Yemen">Yemen</option>
                                    <option class="textbolder" value="Zambia">Zambia</option>
                                    <option class="textbolder" value="Zimbabwe">Zimbabwe</option>
                                </select>
                            </div>
                        </div>
                    </div> 
                    <div class="form-group required">
                        <label class="control-label">Primary Contact:</label> 
                        <input class="form-control myform" autofocus="autofocus" id="indPrimaryContact" oninput="indPrimaryContactsss()" type="text" value="" placeholder="Enter Primary Contact">
                        <h6 id='IndPridonorerr'></h6>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Secondary Contact:</label>
                        <input class="form-control myform" autofocus="autofocus" id="indSecondaryContact" type="text" value="" placeholder="Enter Secondary Contact">
                    </div>
                    <div class="form-group">
                        <label class="control-label">Email:</label>
                        <input class="form-control myform" autofocus="autofocus" id="indEmail"  oninput="checkIndividualDonorEmail();" type="text" value="" placeholder="Enter Email Address">
                        <h6 id='indResult'></h6>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row" id="saveOrganisationDonor" style="float:right">
        <div class="col-md-12">
            <button class="btn btn-primary" id="confirmdonorprograms" type="button">
                <i class="fa fa-save"></i>
                Save Donor
            </button>
        </div>
    </div>
    <div class="row" id="saveIndividualDonor">
        <div class="col-md-12" align="right">
            <button class="btn btn-primary" id="saveIndividualDonorDetails" type="button">
                <i class="fa fa-save"></i>
                Save Donor
            </button>
        </div>
    </div>
</div>
<script>
    var donorprogList = new Set();
    var max = 15;
    var donorprogObjectList = [];
    $(document).ready(function () {
        hideDiv('individualContactDets');
        hideDiv('individualReg');
        hideDiv('saveIndividualDonor');
        $("#wrongfaxNo").hide();

        $("#fax").on("input", function (evt) {
            //
            if (parseInt($(this).val().length) > parseInt(max)) {
                $(".wrongfaxNo").html('Fax Must Not Exceed 15 Characters');
                $(".wrongfaxNo").show();
            } else {
                $(".wrongfaxNo").html('');
                $(".wrongfaxNo").hide();
            }
            var self = $(this);
            self.val(self.val().replace(/[^0-9\.]/g, ''));
            if ((evt.which !== 46 || self.val().indexOf('.') !== -1) && (evt.which < 48 || evt.which > 57))
            {
                evt.preventDefault();
            }
        });

        $('[data-toggle="popover"]').popover();
        $('#telno').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });

        $('#primaryContact').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });

        $('#secondaryContact').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });

        $('#indPrimaryContact').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });

        $('#indSecondaryContact').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });

        var donor = $('#autocomplete').val();
        var facDonors = [];
        $.ajax({
            type: "POST",
            cache: false,
            url: "internaldonorprogram/searchFacilityDonors.htm",
            data: {searchValue: donor},
            success: function (data) {

//   donorerr                             $('#myDropdown').html(response);
//                                document.getElementById('confirmdonorprograms').disabled = false;

                var response = JSON.parse(data);
                for (index in response) {
                    var results = response[index];
                    facDonors.push({
                        value: results["value"],
                        data: results["data"],
                        telno: results["telno"],
                        emial: results["emial"],
                        fax: results["fax"],
                        origincountry: results["origincountry"]
                    });
                }
                console.log(facDonors);
            }
        });

        $('#autocomplete').autocomplete({
            lookup: facDonors,
            onSelect: function (suggestion) {
                $('#organisationReg *').prop('disabled', true);
                document.getElementById("donorid").value = suggestion.data;
                document.getElementById("telno").value = suggestion.telno;
                document.getElementById("email").value = suggestion.emial;
                document.getElementById("fax").value = suggestion.fax;
                document.getElementById("originCountry").value = suggestion.origincountry;
            }
        });

        //search contact person

        var contactPerson = $('#contactPersonAutocomplete').val();
        var facContactPerson = [];
        $.ajax({
            type: "POST",
            cache: false,
            url: "internaldonorprogram/searchFacilityContactPerson.htm",
            data: {searchValue: contactPerson},
            success: function (data) {
//
//                                $('#myDropdown').html(response);
//                                document.getElementById('confirmdonorprograms').disabled = false;

                var response = JSON.parse(data);
                for (index in response) {
                    var results = response[index];
                    facContactPerson.push({
                        value: results["value"],
                        data: results["data"],
                        primarycontact: results["primarycontact"],
                        secondarycontact: results["secondarycontact"],
                        firstname: results["firstname"],
                        lastname: results["lastname"],
                        othernames: results["othernames"],
                        email: results["email"]
                    });
                }
                console.log(facContactPerson);
            }
        });

        $('#contactPersonAutocomplete').autocomplete({
            lookup: facContactPerson,
            onSelect: function (suggestion) {

                console.log(suggestion);

                document.getElementById("personid").value = suggestion.data;
                document.getElementById("primaryContact").value = suggestion.primarycontact;
                document.getElementById("secondaryContact").value = suggestion.secondarycontact;
                document.getElementById("personEmail").value = suggestion.email;
                document.getElementById("contactPersonAutocomplete").value = suggestion.firstname;
                document.getElementById("scndname").value = suggestion.lastname;
                document.getElementById("othername").value = suggestion.othernames;

            }
        });

    });

    $('.donortype').click(function () {
        if (($(this).val()) === "") {
            $('#donortypediv').addClass('error');
        } else {
            $('#donortypediv').removeClass('error');
            if (($(this).val()) === "Individual") {
                hideDiv('contactPrsnDetails');
                hideDiv('organisationReg');
                hideDiv('saveOrganisationDonor');
                showDiv('saveIndividualDonor');
                showDiv('individualContactDets');
                showDiv('individualReg');

                //search individual facility donors
                var indDonor = $('#individualDonorAutocomplete').val();
                var facIndDonors = [];
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "internaldonorprogram/searchIndividualFacilityDonors.htm",
                    data: {searchValue: indDonor},
                    success: function (data) {
                        var response = JSON.parse(data);
                        for (index in response) {
                            var results = response[index];
                            facIndDonors.push({
                                value: results["value"],
                                data: results["data"],
                                primarycontact: results["primarycontact"],
                                secondarycontact: results["secondarycontact"],
                                email: results["email"],
                                origincountry: results["origincountry"],
                            });
                        }
                    }
                });

                $('#individualDonorAutocomplete').autocomplete({
                    lookup: facIndDonors,
                    onSelect: function (suggestion) {
                        $('#individualReg *').prop('disabled', true);
                        $('#individualContactDets *').prop('disabled', true);
                        document.getElementById("indpersonid").value = suggestion.data;
                        document.getElementById("indPrimaryContact").value = suggestion.primarycontact;
                        document.getElementById("indSecondaryContact").value = suggestion.secondarycontact;
                        document.getElementById("indEmail").value = suggestion.email;
                        document.getElementById("indOriginCountry").value = suggestion.origincountry;
                        var fullname = suggestion.value;
                        var splitednames = fullname.split(" ");
                        document.getElementById("individualDonorAutocomplete").value = splitednames[0];
                        document.getElementById("indScndname").value = splitednames[1];
                        if (splitednames.length > 2) {
                            document.getElementById("indOthername").value = splitednames[2];
                        }
                    }
                });
                $('#individualContactDets *').prop('disabled', false);
                $('#individualReg *').prop('disabled', false);
            } else {
                showDiv('contactPrsnDetails');
                showDiv('organisationReg');
                showDiv('saveOrganisationDonor');
                hideDiv('saveIndividualDonor');
                hideDiv('individualContactDets');
                hideDiv('individualReg');
            }
        }

    });
    function telnosss() {
        var telno = $('#telno').val();
        if (telno === "") {
            $('#telno').addClass('error');
        } else {
            $('#telno').removeClass('error');
        }
    }

    function contactPersonAutocompletess() {
        var contactPersonAutocomplete = $('#contactPersonAutocomplete').val();
        if (contactPersonAutocomplete === "") {
            $('#contactPersonAutocomplete').addClass('error');
        } else {
            $('#contactPersonAutocomplete').removeClass('error');
        }
    }

    function scndnameSS() {
        var scndname = $('#scndname').val();
        if (scndname === "") {
            $('#scndname').addClass('error');
        } else {
            $('#scndname').removeClass('error');
        }
    }

    function primaryContactss() {
        var primaryContact = $('#primaryContact').val();
        if (primaryContact === "") {
            $('#primaryContact').addClass('error');
        } else {
            $('#primaryContact').removeClass('error');
        }
    }

    function individualDonorAutocompletesss() {
        var individualDonorAutocompleteddd = $('#individualDonorAutocomplete').val();
        if (individualDonorAutocompleteddd === "") {
            $('#individualDonorAutocomplete').addClass('error');
        } else {
            $('#individualDonorAutocomplete').removeClass('error');
        }
    }

    function indScndnamesss() {
        var indScndname = $('#indScndname').val();
        if (indScndname === "") {
            $('#indScndname').addClass('error');
        } else {
            $('#indScndname').removeClass('error');
        }
    }

    function indPrimaryContactsss() {
        var indPrimaryContact = $('#indPrimaryContact').val();
        if (indPrimaryContact === "") {
            $('#indPrimaryContact').addClass('error');
        } else {
            $('#indPrimaryContact').removeClass('error');
        }
    }

    function checkDonorName() {
        var donor = $('#autocomplete').val();
        var $result = $("#donorerr");
        $result.text("");
        $.ajax({
            type: "POST",
            cache: false,
            url: "internaldonorprogram/checkFacilityDonors.htm",
            data: {searchValue: donor},
            success: function (data) {
                if (data === "existing") {
                    $('#autocomplete').addClass('error');
                    $result.text(donor + " already exists");
                    $result.css("color", "red");
                    document.getElementById('confirmdonorprograms').disabled = true;
                } else {
                    $('#autocomplete').removeClass('error');
                    document.getElementById('confirmdonorprograms').disabled = false;
                }

            }
        });
    }

    function validateFax(checkField) {
        if (checkField.value.length > 0) {
            var faxRegEx = /^\+?[0-9]{7,15}$/;
            if (!checkField.value.match(faxRegEx)) {
                return false;
            }
        }
        return true;
    }

    function checkFax() {
        var fax = $("#fax").val();
        if (validateFax(fax)) {
            $('#fax').removeClass('error');
        } else {
            $('#fax').addClass('error');
        }
        return false;
    }

    function validateEmail(email) {
        var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    }

    function checkEmail() {
        var $result = $("#result");
        var email = $("#email").val();
        $result.text("");

        if (validateEmail(email)) {
            $result.css("color", "green");
            $('#email').removeClass('error');


        } else {
            $('#email').addClass('error');
            $result.css("color", "red");
            $result.text(email + " is not a valid email");
        }
        return false;
    }

    function checkIndividualDonorEmail() {
        var $result = $("#indResult");
        var email = $("#indEmail").val();
        $result.text("");

        if (validateEmail(email)) {
            $result.css("color", "green");
            $('#indEmail').removeClass('error');
        } else {
            $('#indEmail').addClass('error');
            $result.css("color", "red");
            $result.text(email + " is not a valid email");
        }
        return false;
    }

    function checkContactPersonEmail() {
        var $result = $("#Emailresult");
        var email = $("#personEmail").val();
        $result.text("");

        if (validateEmail(email)) {
            $result.css("color", "green");
            $('#personEmail').removeClass('error');
        } else {
            $('#personEmail').addClass('error');
            $result.css("color", "red");
            $result.text(email + " is not a valid email");
        }
        return false;
    }

    var donornames = [];
    var donornamestestSet = new Set();

    $('#confirmdonorprograms').click(function () {
        var donorid = document.getElementById('donorid').value;
        var country = document.getElementById('originCountry').value;
        var telno = $('#telno').val();
        var email = $('#email').val();
        var fax = $('#fax').val();
        var personid = $('#personid').val();
        var frstName = $('#contactPersonAutocomplete').val();
        var scndName = $('#scndname').val();
        var otherName = $('#othername').val();
        var donorProgramName = $('#autocomplete').val();
        var donorType = $("input:radio[name=donortype]:checked").val();
        var primaryContact = $('#primaryContact').val();
        var secondaryContact = $('#secondaryContact').val();
        var contactPrsnEmail = $('#personEmail').val();

        if (donorProgramName === "") {
            $('#autocomplete').addClass('error');
        } else {
            $('#autocomplete').removeClass('error');
        }
        if (telno === "") {
            $('#telno').addClass('error');
        } else {
            $('#telno').removeClass('error');
        }
        if (email === "") {
            $('#email').addClass('error');
        } else {
            $('#email').removeClass('error');
        }
        if (frstName === "") {
            $('#contactPersonAutocomplete').addClass('error');
        } else {
            $('#contactPersonAutocomplete').removeClass('error');
        }
        if (scndName === "") {
            $('#scndname').addClass('error');
        } else {
            $('#scndname').removeClass('error');
        }
        if (primaryContact === "") {
            $('#primaryContact').addClass('error');
        } else {
            $('#primaryContact').removeClass('error');
        }
        if (contactPrsnEmail === "") {
            $('#personEmail').addClass('error');
        } else {
            $('#personEmail').removeClass('error');
        }
        if (!$("input[name='donortype']:checked").val()) {
            $('#donortypediv').addClass('error');
        } else {
            $('#donortypediv').removeClass('error');
        }
        if ($("input[name='donortype']:checked").val() && donorProgramName !== "" && telno !== "" && email !== "" && frstName !== "" && scndName !== "" && primaryContact !== "" && contactPrsnEmail !== "") {
            if (donorid !== "") {
                var data = {
                    donorid2: donorid,
                    personid: personid,
                    firstname: frstName,
                    lastname: scndName,
                    othername: otherName,
                    primaryContact: primaryContact,
                    secondaryContact: secondaryContact,
                    contactPrsnEmail: contactPrsnEmail
                };

                $.ajax({
                    type: 'POST',
                    data: data,
                    url: 'internaldonorprogram/saveFacilityDonor.htm',
                    success: function (data) {
                        console.log("-----------my data" + data);
                        if (data === 'saved') {

                            $.toast({
                                heading: 'Success',
                                text: 'Donor(s) Successfully Registered.',
                                icon: 'success',
                                hideAfter: 2000,
                                position: 'bottom-center'
                            });
                            ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            window.location = '#close';
                        } else {
                            $.toast({
                                heading: 'Error',
                                text: 'An unexpected error occured while trying to register Donor Program(s).',
                                icon: 'error'
                            });
                            ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            window.location = '#close';
                        }
                    }
                });
            } else {
                console.log("---------------else" + donorid);
                console.log("---------------personidelse" + personid);
                var data = {
                    donorname2: donorProgramName,
                    country2: country,
                    donortype2: donorType,
                    personid: personid,
                    firstname2: frstName,
                    lastname2: scndName,
                    othername2: otherName,
                    telno2: telno,
                    email2: email,
                    fax2: fax,
                    primaryContact: primaryContact,
                    secondaryContact: secondaryContact,
                    contactPrsnEmail: contactPrsnEmail
                };

                $.ajax({
                    type: 'POST',
                    data: data,
                    url: 'internaldonorprogram/saveDonorProgram.htm',
                    success: function (data) {
                        console.log(data);
                        if (data === 'saved') {

                            $.toast({
                                heading: 'Success',
                                text: 'Donor(s) Successfully Registered.',
                                icon: 'success',
                                hideAfter: 2000,
                                position: 'bottom-center'
                            });
                            ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            window.location = '#close';
                        } else {
                            $.toast({
                                heading: 'Error',
                                text: 'An unexpected error occured while trying to register Donor Program(s).',
                                icon: 'error'
                            });
                            ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            window.location = '#close';
                        }
                    }
                });
            }
        }
    });


    $('#saveIndividualDonorDetails').click(function () {
        var donorid = document.getElementById('indpersonid').value;
        var country = document.getElementById('indOriginCountry').value;
        var frstName = $('#individualDonorAutocomplete').val();
        var scndName = $('#indScndname').val();
        var otherName = $('#indOthername').val();
        var donorType = $("input:radio[name=donortype]:checked").val();
        var primaryContact = $('#indPrimaryContact').val();
        var secondaryContact = $('#indSecondaryContact').val();
        var contactPrsnEmail = $('#indEmail').val();
        console.log("this");
        if (frstName === "") {
            $('#individualDonorAutocomplete').addClass('error');
            $('#donorerr').css("color", "red");
        }
        if (scndName === "") {
            $('#indScndname').addClass('error');
            $('#telnoresult').css("color", "red");
        }
        if (primaryContact === "") {
            $('#indPrimaryContact').addClass('error');
            $('#result').css("color", "red");
        }
        if (contactPrsnEmail === "") {
            $('#indEmail').addClass('error');
            $('#Fnameresult').css("color", "red");
        }
        if (donorType !== "" && frstName !== "" && primaryContact !== "" && contactPrsnEmail !== "") {
            if (donorid !== "") {
                var data = {
                    donorid2: donorid,
                    primaryContact: primaryContact,
                    secondaryContact: secondaryContact,
                    contactPrsnEmail: contactPrsnEmail
                };

                $.ajax({
                    type: 'POST',
                    data: data,
                    url: 'internaldonorprogram/saveFacilityIndividualDonor.htm',
                    success: function (data) {
                        console.log("-----------my data" + data);
                        if (data === 'saved') {
                            document.getElementById('saveIndividualDonorDetails').disabled = true;
                            document.getElementById('indOriginCountry').value = " ";
                            document.getElementById('individualDonorAutocomplete').value = " ";
                            document.getElementById('indScndname').value = " ";
                            document.getElementById('indOthername').value = " ";
                            document.getElementById('indpersonid').value = " ";
                            document.getElementById('indPrimaryContact').value = " ";
                            document.getElementById('indSecondaryContact').value = " ";
                            document.getElementById('indEmail').value = " ";

                            $.toast({
                                heading: 'Success',
                                text: 'Donor(s) Successfully Registered.',
                                icon: 'success',
                                hideAfter: 2000,
                                position: 'bottom-center'
                            });
                            ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            window.location = '#close';
                        } else {
                            $.toast({
                                heading: 'Error',
                                text: 'An unexpected error occured while trying to register Donor Program(s).',
                                icon: 'error'
                            });
                            ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            window.location = '#close';
                        }
                    }
                });
            } else {
                var data = {
                    country2: country,
                    donortype2: donorType,
                    firstname2: frstName,
                    lastname2: scndName,
                    othername2: otherName,
                    primaryContact: primaryContact,
                    secondaryContact: secondaryContact,
                    contactPrsnEmail: contactPrsnEmail
                };

                $.ajax({
                    type: 'POST',
                    data: data,
                    url: 'internaldonorprogram/saveIndividualDonorProgram.htm',
                    success: function (data) {
                        console.log(data);
                        if (data === 'saved') {
                            document.getElementById('saveIndividualDonorDetails').disabled = true;
                            document.getElementById('indOriginCountry').value = " ";
                            document.getElementById('individualDonorAutocomplete').value = " ";
                            document.getElementById('indScndname').value = " ";
                            document.getElementById('indOthername').value = " ";
                            document.getElementById('indpersonid').value = " ";
                            document.getElementById('indPrimaryContact').value = " ";
                            document.getElementById('indSecondaryContact').value = " ";
                            document.getElementById('indEmail').value = " ";
                            $.toast({
                                heading: 'Success',
                                text: 'Donor(s) Successfully Registered.',
                                icon: 'success',
                                hideAfter: 2000,
                                position: 'bottom-center'
                            });
                            ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            window.location = '#close';
                        } else {
                            $.toast({
                                heading: 'Error',
                                text: 'An unexpected error occured while trying to register Donor Program(s).',
                                icon: 'error'
                            });
                            ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            window.location = '#close';
                        }
                    }
                });
            }
        }

    });
</script>
