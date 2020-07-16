<%-- 
    Document   : addDesignationCategory
    Created on : Aug 1, 2018, 1:25:17 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-4">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Enter Designation Category</h4>
                    <div class="tile-body">
                        <form id="desigentryforms">
                            <div class="form-group">
                                <label class="control-label">Current Facility</label>
                                <input class="form-control myform" id="facilityid" value="${facilityid}" type="hidden">
                                <input class="form-control myform" id="facilityname" value="${facilityname}" type="text" readonly="true">
                            </div>
                            <div class="form-group">
                                <label class="control-label">Designation Category</label>
                                <select class="form-control designationCat_search" id="searchdesignationCat">

                                </select>
                            </div>
                            <div class="form-group">
                                <label class="control-label">Select Post</label>
                                <select class="form-control designation_search" id="searchdesignations">

                                </select>
                            </div>
                            <div class="form-group">
                                <p><b>Additional Information</b></p>
                                <textarea class="form-control" id="descriptions" name="description" rows="3" placeholder="Enter Information About Designation"></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="captureDesignationCat" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Add Designation Category
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-8">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Entered Designation(s).</h4>
                    <table class="table table-sm table-bordered">
                        <thead>
                            <tr>
                                <th>Facility</th>
                                <th>Designation Category Name</th>
                                <th>Post Name</th>
                                <th>Description</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredDesignationsCatBody">

                        </tbody>
                    </table>
                </div>
                <div class="form-group">
                    <div class="col-sm-12 text-right">
                        <button type="button" class="btn btn-primary" id="savedesignationCat">
                            Save Designation Category
                        </button>
                    </div>
                </div>
                <span id="incrementx" class="hidedisplaycontent">0</span>
            </div>
        </div>
    </div>
</div>
<c:if test="${model.activity=='postResponse'}">
    <h2>${model.responseMsg}</h2>
</c:if>

<script type="text/javascript">
    var designationCatList = new Set();
    var designationCatObjectList = [];
    $(document).ready(function () {
        document.getElementById('savedesignationCat').disabled = true;
//        $('#searchdesignationCat').change(function () {
//            var designationCatid_designationCatname = document.getElementById('searchdesignationCat').value;
//            var fields = designationCatid_designationCatname.split('-');
//            var designationcategoryid = fields[0];
//            var categoryname = fields[1];
//            
//            var type = "postsavailable";
//            
//            console.log("--------------type"+type);
//            
//            $.ajax({
//            type: 'GET',
//            data: {type: type, designationcategoryid: designationcategoryid},
//            url: "localsettingspostsandactivities/addDesignationCategory.htm",
//            success: function (data, textStatus, jqXHR) {
//                
//            }
//        });
//        
        $('#searchdesignationCat').click(function () {
            $.ajax({
                type: 'POST',
                url: 'localsettingspostsandactivities/fetchDesigCats.htm',
                success: function (data) {
                    var res = JSON.parse(data);
                    if (res !== '' && res.length > 0) {
                        for (i in res) {
                            $('#searchdesignationCat').append('<option class="textbolder" id="' + res[i].designationcategoryid + '" data-categoryname="' + res[i].categoryname + '" value="' + res[i].designationcategoryid + '">' + res[i].categoryname + '</option>');
                        }
                        var designationcategoryid = parseInt($('#searchdesignationCat').val());
                        $.ajax({
                            type: 'POST',
                            url: 'localsettingspostsandactivities/fetchDesigCatPosts.htm',
                            data: {designationcategoryid: designationcategoryid},
                            success: function (data) {
                                var res = JSON.parse(data);
                                if (res !== '' && res.length > 0) {
                                    for (i in res) {
                                        $('#searchdesignations').append('<option class="classpost" id="' + res[i].designationid + '" value="' + res[i].designationid + '" data-designationname="' + res[i].designationname + ' ">' + res[i].designationname + '</option>');
                                    }
                                }
                            }
                        });
                    }
                }
            });

            $('#searchdesignationCat').change(function () {
                $('#searchdesignations').val(null).trigger('change');
                var designationcategoryid = parseInt($('#searchdesignationCat').val());
                $.ajax({
                    type: 'POST',
                    url: 'localsettingspostsandactivities/fetchDesigCatPosts.htm',
                    data: {designationcategoryid: designationcategoryid},
                    success: function (data) {
                        var res = JSON.parse(data);
                        if (res !== '' && res.length > 0) {
                            $('#searchdesignations').html('');
                            for (i in res) {
                                $('#searchdesignations').append('<option class="classpost" id="' + res[i].designationid + '" value="' + res[i].designationid + '" data-designationname="' + res[i].designationname + ' ">' + res[i].designationname + '</option>');
                            }
                        }
                    }
                });
            });
        });

//            
//            console.log("designationcategoryid" + designationcategoryid);
//            console.log("categoryname" + categoryname);
//            ajaxSubmitData('localsettingspostsandactivities/addDesignationCategory.htm', 'searchdesignations', 'act=a&designationcategoryid=' + designationcategoryid, 'GET');


        var designationCatnames = [];
        var designationCatnamestestSet = new Set();
        $('#captureDesignationCat').click(function () {
            var facilityid = $('#facilityid').val();
            var facilityname = $('#facilityname').val();

            var designationCat = document.getElementById('searchdesignationCat').value;
            var designation = document.getElementById('searchdesignations').value;
            var designationcategoryid = parseInt($('#searchdesignationCat').val());
            var designationid = parseInt($('#searchdesignations').val());
            var categoryname = $("#" + designationCat).data("categoryname");
            var designationname = $("#" + designation).data("designationname");//$("#" + ).data("designationname");

            console.log("designationcategoryid" + designationcategoryid);
            console.log("designationid" + designationid);
            console.log("categoryname" + categoryname);
            console.log("postname" + designationname);

            var description = $('#descriptions').val();
            var count = $('#incrementx').html();

            if (designationname !== '') {
                var designationCatNameUpper = designationname.toUpperCase();
                if (designationCatnamestestSet.has(designationCatNameUpper)) {
                    $.alert({
                        title: '',
                        content: '<div class="center">' + '<font size="5">' + '<strong class="text-danger">' + designationCatNameUpper + '</strong> &nbsp;Already Exists!!</font></div>',
                        type: 'red',
                        typeAnimated: true,
                    });
                } else {
                    document.getElementById('savedesignationCat').disabled = false;
                    var xcount = parseInt(count) + 1;
                    ;
                    $('#incrementx').html(xcount);
                    $('#enteredDesignationsCatBody').append(
                            '<tr id="rowt' + facilityid + '">' +
                            '<td>' + facilityname + '</td>' +
                            '<td>' + '<a onclick="editbldname();">' + categoryname + '</a>' + '</td>' +
                            '<td>' + '<a onclick="editbldname();">' + designationname + '</a>' + '</td>' +
                            '<td>' + '<a onclick="editbldname();">' + description + '</a>' + '</td>' +
                            '<td class="center">' +
                            '<span class="badge badge-danger icon-custom" onclick="remove(\'rowt' + facilityid + '\')">' +
                            '<i class="fa fa-trash-o"></i></span></td></tr>'
                            );
                    document.getElementById("desigentryforms").reset();
                    $('#categoryname').css('border', '2px solid #6d0a70');
                    $('#facilityid').css('border', '2px solid #6d0a70');
                    $('#facilityname').css('border', '2px solid #6d0a70');
                    var data = {
                        categoryname: categoryname,
                        designationcategoryid: designationcategoryid,
                        designationname: designationname,
                        designationid: designationid,
                        description: description
                    };
                    designationCatnamestestSet.add(designationCatNameUpper);
                    designationCatList.add(facilityid);
                    designationCatObjectList.push(data);
                }

            } else {

                $('#categoryname').focus();
                $('#categoryname').css('border', '2px solid #f50808c4');
            }
        });

    });
    function remove(facilityid) {
        $('#rowt' + facilityid).remove();
        designationCatnamestestSet.delete(facilityid);
    }

    $('#savedesignationCat').click(function () {
        var facilityid = $('#facilityid').val();
        var facilityname = $('#facilityname').val();
        if (designationCatObjectList.length > 0) {
            var data = {
                designationCats: JSON.stringify(designationCatObjectList),
                facilityid: facilityid,
                facilityname: facilityname
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'localsettingspostsandactivities/saveDesignationCategories.htm',
                success: function (data) {
                    console.log("=---------------------res" + data);
                    if (data === 'success') {
                        $.toast({
                            heading: 'Success',
                            text: 'Designation Category Added Successfully.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                        window.location = '#close';
                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'An unexpected error occured while trying to add Designation Category.',
                            icon: 'error'
                        });
                        ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                        window.location = '#close';
                    }
                }
            });
        }
    });


</script>