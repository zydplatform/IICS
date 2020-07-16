<%-- 
    Document   : dposts
    Created on : Mar 23, 2018, 12:44:29 PM
    Author     : SAMINUNU
--%>
<style>
    .error
    {
        border:2px solid red;
    }
</style>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <h3 class="tile-title">UPDATE POST</h3>
            <div class="tile-body">
                <form>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="control-label">Designation Category</label>
                                <input class="form-control" id="postdesignations" name="domain" value="" type="text" disabled="true">
                                <input class="form-control" id="postdesignationsid" name="domain" value="" type="text" disabled="true">
                            </div>
                            <div class="col-md-6">
                                <label class="control-label">Name</label>
                                <input class="form-control" id="designationname" name="name" type="text" placeholder="Enter Post Name" value="">
                                <input class="form-control" id="designationid" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="form-group" id="desigtext">
                        <label class="control-label">Additional Information</label>
                        <textarea class="form-control" id="postdescription" name="description" rows="3" placeholder="Enter Information About Post"></textarea>
                    </div>
<!--                    <div class="form-group">
                        <p><b>Status</b></p>
                        <div class="toggle-flip">
                            <label>
                                <input type="checkbox" id="checkpost"><span class="flip-indecator" data-toggle-on="ENABLE" data-toggle-off="DISABLE"></span>
                            </label>
                        </div>
                    </div>-->
                </form>
            </div>
            <div class="tile-footer">
                <button class="btn btn-primary" id="saveUpdatePost" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Update Post</button>
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
       
    });

    function myFunction() {
        var x = document.getElementById("desigtext");
        if (x.style.display === "none") {
            x.style.display = "block";
        } else {
            x.style.display = "none";
        }
    }

</script>

