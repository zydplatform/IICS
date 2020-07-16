<%-- 
    Document   : minutes
    Created on : Jun 18, 2018, 3:19:28 PM
    Author     : IICS
--%>

<h3 style="display: none">Minutes</h3>
<hr/>
<div align="left" style="width: 60%; height: 30px" class="form-group">   
    <span style="float: left; width: 40px;">
        Every 
    </span>
    <span style="float: right; width: 360px;">
        <input size="3" maxlength="2" data-toggle="tooltip" title="Minutes" placeholder="" onkeyup="makeCron();
                isEmptyField('MinutesInput');" style="width: 90px;float: left;" class="form-control input-sm" value="1" name="MinutesInput" id="MinutesInput" onKeyPress='return isNumberKey(event)' type="text"/>&nbsp;&nbsp;Minute(s)&nbsp; 
        <span class="alert alert-info">Default - <strong>1Min</strong></span>                        
    </span>
</div>
