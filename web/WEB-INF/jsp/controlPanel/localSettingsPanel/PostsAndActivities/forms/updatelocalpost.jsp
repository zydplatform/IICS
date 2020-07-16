<%-- 
    Document   : updatelocalpost
    Created on : Apr 5, 2018, 3:03:53 PM
    Author     : SAMINUNU
--%>

<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <h3 class="tile-title">UPDATE POST</h3>
            <div class="tile-body">
                <form>
                    <div class="form-group">
                        <label class="control-label">Designation Category</label>
                        <input class="form-control" id="designationname" name="name" type="text" placeholder="Enter Designation Name" value="">
                        <input class="form-control" id="designationid" type="hidden">
                    </div>
                    
                    <div class="form-group">
                        <label class="control-label">Post</label>
                        <input class="form-control" id="postdesignations" name="domain" value="" type="text" disabled="true">
                    </div>
                    <div class="form-group" id="desigtext">
                        <label class="control-label">Additional Information</label>
                        <textarea class="form-control" id="postdescription" name="description" rows="3" placeholder="Enter Information About Designation"></textarea>
                    </div>
                    <div class="form-group">
                        <p><b>Status</b></p>
                        <div class="toggle-flip">
                            <label>
                                <input type="checkbox" id="checkpost"><span class="flip-indecator" data-toggle-on="ENABLE" data-toggle-off="DISABLE"></span>
                            </label>
                        </div>
                    </div>
                                    </form>
            </div>
            <div class="tile-footer">
                <button class="btn btn-primary" id="saveUpdatePost" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save Post</button>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        //$('#posttext').hide();
        //$('#domainselect').select2();
    });

//    $('#savedesignation').click(function () {
//        var name = $('#name').val();
//        var domain = $('#domain').val();
//        var description = $('#description').val();
//
//        console.log(name);
//        console.log(domain);
//        console.log(description);
//
//        $.ajax({
//            type: 'POST',
//            data: {categoryname: name, domain: domain, description: description},
//            dataType: 'text',
//            url: "postsandactivities/saveUpdateDesignations.htm",
//            success: function (data, textStatus, jqXHR) {
//
//            }
//        });
//    });

    function myFunction() {
        var x = document.getElementById("desigtext");
        if (x.style.display === "none") {
            x.style.display = "block";
        } else {
            x.style.display = "none";
        }
    }

</script>

