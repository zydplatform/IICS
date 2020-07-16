<%-- 
    Document   : addnewdesignations
    Created on : Aug 1, 2018, 3:36:00 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp"%>
<style>
    .error
    {
        border:2px solid red;
    }

</style>
<div class="col-md-4">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Enter Post Details</h4>
                <div class="tile-body">
                    <form id="desigentryforms">
                        <div class="form-group">
                            <label class="control-label">Select Designation Category</label> 
                            <select class="form-control" id="searchdesignationCats" onchange="changedesignationid()">
                                <c:forEach items="${DesignationCatLists}" var="t">
                                    <option value="${t.designationcategoryid}-${t.categoryname}">${t.categoryname} ${t.designationcategoryid}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Select Post</label>
                            <select class="form-control newdesignation_search" id="searchdesignation">
                                <option>------Select Post------</option>
                                <c:forEach items="${newDesignations}" var="n">
                                    <option value="${n.designationid}-${n.designationname}">${n.designationname}${n.designationid}</option>
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
                    <button class="btn btn-primary" id="captureDesignation" onclick="captureDesignations()" type="button">
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
                    <button type="button" class="btn btn-primary" id="savedesignation" onclick="saveDesignation()">
                        Save Post
                    </button>
                </div>
            </div>
            <span id="incrementx" class="hidedisplaycontent">0</span>
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

        var designationCatid_designationCatname = document.getElementById('searchdesignationCats').value;
        var field = designationCatid_designationCatname.split('-');
        var designationcategoryid = field[0];
        var categoryname = field[1];
        ajaxSubmitData('localsettingspostsandactivities/returndesignations.htm', '',  'designationcategoryid=' + designationcategoryid +'&i=0&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });

    function changedesignationid() {
       var designationCatid_designationCatname =  $('#searchdesignationCats').val()//document.getElementById('searchdesignationCats').value;
        var field = designationCatid_designationCatname.split('-');
        var designationcategoryid = field[0];
        var categoryname = field[1];
        ajaxSubmitData('localsettingspostsandactivities/returndesignations.htm', '',  'designationcategoryid=' + designationcategoryid +'&i=0&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    var designationnames = [];
    var designationnamestestSet = new Set();

    function captureDesignations() {
        var designationCatid_designationCatname = document.getElementById('searchdesignationCats').value;
        var field = designationCatid_designationCatname.split('-');
        var designationcategoryid = field[0];
        var categoryname = field[1];

        var designationid_designationname = document.getElementById('searchdesignation').value;
        var fields = designationid_designationname.split('-');
        var designationid = fields[0];
        var designationname = fields[1];

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
    }


    function remove(designationcategoryid) {
//        $("#rowfg" + designationcategoryid).remove();
        designationnamestestSet.delete(designationcategoryid);
    }
    function saveDesignation() {
        var designationCatid_designationCatname = document.getElementById('searchdesignationCats').value;
        var field = designationCatid_designationCatname.split('-');
        var designationcategoryid = field[0];
        var categoryname = field[1];
        $.confirm({
            title: 'Message!',
            content: 'Save Designations?',
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
//                                    $('#enteredDesignationsBody').html('');
//                                    designationObjectList = [];
                                    if (res === 'success') {
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Post Added Successfully.',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'bottom-center'
                                        });
                                        ajaxSubmitData('localsettingspostsandactivities/adddesignations.htm', 'addcontents', 'desigCatId=' + designationcategoryid + '&desigCatName=' + categoryname + '', 'GET');
                                        window.location = '#close';
                                    } else {
                                        $.toast({
                                            heading: 'Error',
                                            text: 'An unexpected error occured while trying to add Posts.',
                                            icon: 'error'
                                        });
                                        ajaxSubmitData('localsettingspostsandactivities/adddesignations.htm', 'addcontents', 'desigCatId=' + designationcategoryid + '&desigCatName=' + categoryname + '', 'GET');
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
    }


</script>
