<%-- 
    Document   : updateDuty
    Created on : Aug 5, 2019, 12:41:23 PM
    Author     : USER 1
--%>

<%@include file="../../../../include.jsp"%>

<div class="container">

    <div class="form-group bs-component">
        <label class="control-label" for="patientTemperature">Edit Duty
                          <!--<textarea  class="form-control"  id="editDuty" cols="100" rows="20"></textarea>-->
                          <input type="text" class="form-control"  id="dutyids" hidden="true">
            <form>
                <input id="editDuty" value="Editor content goes here" type="hidden" name="content">
                <trix-editor input="editDuty"></trix-editor>
            </form>
    </div>
</div>