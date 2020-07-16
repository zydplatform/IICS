<%-- 
    Document   : addSubComponents
    Created on : Jun 1, 2018, 9:04:58 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form class="form-horizontal" id="sub_comp">
    <input  type="hidden" value="${savetype}" id="savetype" name="numberofsub">
    <input  type="hidden" value="${numberofsubcomponents}" id="numberofsub" name="numberofsub">
    <div id="sections">
        <div class="section">
            <fieldset>
                <legend style="font-size: 15px;">Add Sub-Component(s) &nbsp;<strong id="Component">To this</strong>  Under Update</legend>
                <div class="form-group row">
                    <label class="control-label col-md-4">Sub Component Name:</label>
                    <div class="col-md-8">
                        <input class="form-control col-md-8" type="text" id="subcomponentname" placeholder="Enter Sub Component Name">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="control-label col-md-4">More Info</label>
                    <div class="col-md-8">
                        <textarea class="form-control col-md-8" rows="2" id="subcomponentdescription" placeholder="Enter More Info"></textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="control-label col-md-4">Item Type:</label>
                    <div class="col-md-8">
                        <select class="form-control col-md-8" id="subcomponenttype">                                                                
                            <option value="Component">Module Sub Component</option>
                            <option value="Activity">Module Activity</option>
                        </select>                                            
                    </div>
                </div>
                <div class="form-group row">
                    <label class="control-label col-md-4">Status:</label>
                    <div class="col-md-8">
                        <select class="form-control col-md-8" id="subcomponentstatus">                                                                
                            <option value="Active">Active</option>
                            <option value="Disable">Disabled</option>
                        </select>                                            
                    </div>
                </div>
            </fieldset>
        </div>
    </div><br>
    <div class="row">
        <div class="col-md-4">
        </div>
        <div class="col-md-4">
        </div>
        <div class="col-md-4">
            <button onclick="savesub_components_details();" class="btn btn-primary"  type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save</button>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary" href="#" data-dismiss="modal"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
        </div>
    </div>
</form>
<script>
    var numberofsubcomponents=$('#numberofsub').val();
    for (i = 1; i < numberofsubcomponents; i++) {
        clone();
    }
    //define template
    var template = $('#sections .section:first').clone();
    //define counter
    var sectionsCount = 0;
    var textvar = 1;
    function clone() {
        //increment
        sectionsCount++;
        //loop through each input
        var section = template.clone().find(':input').each(function () {

            //set id to store the updated section number
            var newId = this.id + sectionsCount;
            //update for label
            $(this).prev().attr('for', newId);
            //update id
            this.id = newId;
        }).end()

                //inject new section
                .appendTo('#sections');
        return false;
    }

</script>