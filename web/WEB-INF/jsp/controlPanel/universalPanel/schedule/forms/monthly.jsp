<%-- 
    Document   : monthly
    Created on : Jun 18, 2018, 3:15:58 PM
    Author     : IICS
--%>

<h3 style="display: none">Monthly</h3>
<hr/>
<div align="left" style="width: 700px; height: 30px;margin-left: 100px" class="form-group"> 
    <span style="width: 600px;">
        <table width="500px">
            <tr>
                <td style="width: 4%">
                    <input checked="" value="1" type="radio" name="MonthlyRadio" id="MonthlyRadio"/> 
                </td>
                <td style="width: 9%">
                    Every 
                </td>
                <td style="width: 9%;">
                    <input size="3" maxlength="2" data-toggle="tooltip" title="Day(s)" placeholder="" onkeyup="isEmptyField('DayOfMOnthInput');" style="width: 50px;float: left;" class="form-control input-sm" value="1" name="DayOfMOnthInput" id="DayOfMOnthInput" onKeyPress='return isNumberKey(event)' type="text"/>
                </td>
                <td style="width: 20%">
                    &nbsp;Day of every
                </td>
                <td style="width: 10%">
                    <input size="3" maxlength="2" data-toggle="tooltip" title="Month(s)" placeholder="" onkeyup="isEmptyField('MonthInput');" style="width: 50px;float: right;" class="form-control input-sm" value="1" name="MonthInput" id="MonthInput" onKeyPress='return isNumberKey(event)' type="text"/>
                </td>
                <td style="width: 5%">
                    &nbsp;Month(s)
                </td>
                <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
            </tr>
        </table>
    </span>
</div>
<hr/>
<div align="left" style="width: 700px; height: 30px;margin-left: 100px" class="form-group">   
    <span style="width: 600px;">
        <table width="500px">
            <tr>
                <td style="width: 4%">
                    <input value="2" type="radio" name="MonthlyRadio" id="MonthlyRadio2"/>
                </td>
                <td>&nbsp;The&nbsp;</td>
                <td>
                    <select class="form-control input-sm" style="width: 100px;" name="WeekDay" id="WeekDay">
                        <option value="1">First</option>
                        <option value="2">Second</option>
                        <option value="3">Third</option>
                        <option value="3">Fourth</option>
                    </select>
                </td>
                <td>
                    <select class="form-control input-sm" style="float: right; width: 120px;" name="DayInWeekOrder" id="DayInWeekOrder">
                        <option value="2">Monday</option>
                        <option value="3">Tuesday</option>
                        <option value="4">Wednesday</option>
                        <option value="5">Thursday</option>
                        <option value="6">Friday</option>
                        <option value="7">Saturday</option>
                        <option value="1">Sunday</option>
                    </select>
                </td>
                <td>
                    of every
                </td>
                <td>
                    <input size="3" maxlength="2" data-toggle="tooltip" title="Month(s)" placeholder="" onkeyup="isEmptyField('EveryMonthInput');" style="width: 60px;" class="form-control input-sm" value="1" name="EveryMonthInput" id="EveryMonthInput" onKeyPress='return isNumberKey(event)' type="text"/>
                </td>
                <td>
                    &nbsp;&nbsp;Month(s)
                </td>
            </tr>
        </table>                          
    </span>
</div>
<hr/>
<div align="left" style="width: 700px; height: 30px;margin-left: 100px" class="form-group">   
    <span style="float: left; width: 200px;">
        Start Time(24hr clock) 
    </span>
    <span style="width: 110px;">
        <select class="form-control input-sm" style="float: left; width: 70px;" id="MonthlyHours" name="MonthlyHours">
            <option value="0">00</option>
            <option value="1">01</option>
            <option value="2">02</option>
            <option value="3">03</option>
            <option value="4">04</option>
            <option value="5">05</option>
            <option value="6">06</option>
            <option value="7">07</option>
            <option value="8">08</option>
            <option value="9">09</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option selected="selected" value="12">12</option>
            <option value="13">13</option>
            <option value="14">14</option>
            <option value="15">15</option>
            <option value="16">16</option>
            <option value="17">17</option>
            <option value="18">18</option>
            <option value="19">19</option>
            <option value="20">20</option>
            <option value="21">21</option>
            <option value="22">22</option>
            <option value="23">23</option>
        </select>
        <select class="form-control input-sm" style="width: 70px;" id="MonthlyMinutes" name="MonthlyMinutes">
            <option selected="selected" value="0">00</option>
            <option value="1">01</option>
            <option value="2">02</option>
            <option value="3">03</option>
            <option value="4">04</option>
            <option value="5">05</option>
            <option value="6">06</option>
            <option value="7">07</option>
            <option value="8">08</option>
            <option value="9">09</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
            <option value="13">13</option>
            <option value="14">14</option>
            <option value="15">15</option>
            <option value="16">16</option>
            <option value="17">17</option>
            <option value="18">18</option>
            <option value="19">19</option>
            <option value="20">20</option>
            <option value="21">21</option>
            <option value="22">22</option>
            <option value="23">23</option>
            <option value="24">24</option>
            <option value="25">25</option>
            <option value="26">26</option>
            <option value="27">27</option>
            <option value="28">28</option>
            <option value="29">29</option>
            <option value="30">30</option>
            <option value="31">31</option>
            <option value="32">32</option>
            <option value="33">33</option>
            <option value="34">34</option>
            <option value="35">35</option>
            <option value="36">36</option>
            <option value="37">37</option>
            <option value="38">38</option>
            <option value="39">39</option>
            <option value="40">40</option>
            <option value="41">41</option>
            <option value="42">42</option>
            <option value="43">43</option>
            <option value="44">44</option>
            <option value="45">45</option>
            <option value="46">46</option>
            <option value="47">47</option>
            <option value="48">48</option>
            <option value="49">49</option>
            <option value="50">50</option>
            <option value="51">51</option>
            <option value="52">52</option>
            <option value="53">53</option>
            <option value="54">54</option>
            <option value="55">55</option>
            <option value="56">56</option>
            <option value="57">57</option>
            <option value="58">58</option>
            <option value="59">59</option>
        </select> 
    </span>
</div>