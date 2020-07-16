<%-- 
    Document   : selects
    Created on : Apr 24, 2018, 8:44:49 PM
    Author     : SAMINUNU
--%>
<%@include file="../../../../include.jsp"%>
<style>
    .error
    {
        border:2px solid red;
    }

</style>
<div class="row">
    <div class="col-md-4">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Enter Post Details</h4>
                    <div class="tile-body">
                        <form id="desigentryforms">
                            <div class="form-group">
                                <label class="control-label">Current Designation Category</label>
                                <input class="form-control myform" id="localdesigId" value="${designationcategoryid}" type="hidden">
                                <input class="form-control myform" id="designationname" value="${desigCatName}" type="text" readonly="true">
                            </div>
                            <div class="form-group">
                                <label class="control-label">Select Post</label>
                                <select class="form-control designation_search" id="searchdesignation">
                                    <option>------Select Post------</option>
                                    <c:forEach items="${designations}" var="s">
                                        <option value="${s.designationid}-${s.designationname}">${s.designationname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <p><b>Additional Information</b></p>
                                <textarea class="form-control" id="descriptions" name="description" rows="3" placeholder="Enter Information About Post"></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="captureDesignation" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Add Post
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
                    <h4 class="tile-title">Entered Post(s).</h4>
                    <table class="table table-sm table-bordered">
                        <thead>
                            <tr>
                                <th>Designation Category</th>
                                <th>Post</th>
                                <th>Description</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredDesignationsBody">

                        </tbody>
                    </table>
                </div>
                <div class="form-group">
                    <div class="col-sm-12 text-right">
                        <button type="button" class="btn btn-primary" id="savedesignation">
                            Save Post
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
    var designationList = new Set();
    var designationObjectList = [];

    $(document).ready(function () {

        document.getElementById('savedesignation').disabled = true;
    });

    function checkpostname() {
        var designationid_designationname = document.getElementById('searchdesignation').value;
        var fields = designationid_designationname.split('-');
        var designationid = fields[0];
        var designationname = fields[1];

        console.log("MY designationname" + designationname);
        var designationcategoryid = document.getElementById('localdesigId').value;

        if (designationname.length > 0) {

            $.ajax({
                type: 'POST',
                data: {designationcategoryid: designationcategoryid, designationid: designationid, designationname: designationname},
                url: "localsettingspostsandactivities/checkdesignationname.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'existing') {
                        $('#add_post_select').addClass('error');
                        $.alert({
                            title: 'Alert!',
                            content: designationname + ' Already Exists'
                        });

                        document.getElementById('add_post_select').value = "";
                    } else {
                        $('#add_post_select').removeClass('error');
                        document.getElementById('savedesignation').disabled = false;
                    }
                }
            });
        }
    }

    var designationnames = [];
    var designationnamestestSet = new Set();
    $('#captureDesignation').click(function () {
        var designationcategoryid = $('#localdesigId').val();
        var categoryname = $('#designationname').val();
        var designationid_designationname = document.getElementById('searchdesignation').value;
        var fields = designationid_designationname.split('-');
        var designationid = fields[0];
        var designationname = fields[1];
        console.log("designationid" + designationid);
        console.log("designationname" + designationname);
        var description = $('#descriptions').val();
        var count = $('#incrementx').html();

        if (designationname !== '') {
            var designationNameUpper = designationname.toUpperCase();
            if (designationnamestestSet.has(designationNameUpper)) {
                $.alert({
                    title: '',
                    content: '<div class="center">' + '<font size="5">' + '<strong class="text-danger">' + designationNameUpper + '</strong> &nbsp;Already Exists!!</font></div>',
                    type: 'red',
                    typeAnimated: true,
                });
            } else {
                document.getElementById('savedesignation').disabled = false;
                var xcount = parseInt(count) + 1;
                ;
                $('#incrementx').html(xcount);
                $('#enteredDesignationsBody').append(
                        '<tr id="rowfg' + designationcategoryid + '">' +
                        '<td>' + categoryname + '</td>' +
                        '<td>' + '<a onclick="editbldname();">' + designationname + '</a>' + '</td>' +
                        '<td>' + '<a onclick="editbldname();">' + description + '</a>' + '</td>' +
                        '<td class="center">' +
                        '<span class="badge badge-danger icon-custom" onclick="remove(\'rowfg' + designationcategoryid + '\')">' +
                        '<i class="fa fa-trash-o"></i></span></td></tr>'
                        );
                document.getElementById("desigentryforms").reset();
                $('#designationname').css('border', '2px solid #6d0a70');
                $('#designationcategoryid').css('border', '2px solid #6d0a70');
                $('#categoryname').css('border', '2px solid #6d0a70');
                var data = {
                    designationname: designationname,
                    designationid: designationid,
                    description: description
                };
                designationnamestestSet.add(designationNameUpper);
                designationList.add(designationcategoryid);
                designationObjectList.push(data);
            }

        } else {

            $('#designationname').focus();
            $('#designationname').css('border', '2px solid #f50808c4');
        }
    });


    function remove(designationcategoryid) {
        $('#rowfg' + designationcategoryid).remove();
        designationnamestestSet.delete(designationcategoryid);
    }
    $('#savedesignation').click(function () {
        var designationcategoryid = $('#localdesigId').val();
        var categoryname = $('#designationname').val();
        $.confirm({
            title: 'Message!',
            content: 'Save Posts?',
            type: 'blue',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {
                        if (designationObjectList.length > 0) {
                            var data = {
                                designations: JSON.stringify(designationObjectList),
                                designationcategoryid: designationcategoryid,
                                categoryname: categoryname
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'localsettingspostsandactivities/saveLocalDesignation.htm',
                                success: function (res) {
                                    if (res === 'success') {
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Post Added Successfully.',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'bottom-center'
                                        });
                                        ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                                        window.location = '#close';
                                    } else {
                                        $.toast({
                                            heading: 'Error',
                                            text: 'An unexpected error occured while trying to add Post.',
                                            icon: 'error'
                                        });
                                        ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                                        window.location = '#close';
                                    }
                                }
                            });
                        }

                    }

                },
                NO: {
                    btnClass: 'btn-red',
                    function() {
                        $.toast({
                            heading: 'Save Cancelled',
                            text: 'Saving Post Cancelled.',
                            icon: 'error',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        window.location = '#close';
                    }
                }

            }
        });
    });


</script>