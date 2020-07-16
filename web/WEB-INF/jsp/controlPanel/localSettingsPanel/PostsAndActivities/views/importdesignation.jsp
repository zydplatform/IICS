<%-- 
    Document   : importdesignation
    Created on : Apr 4, 2018, 10:37:11 PM
    Author     : SAMINUNU
--%>

<%@include file="../../../../include.jsp"%>

<style>
    #loadupdateddesigCats {
        background: rgba(255,255,255,0.5);
        color: #000000;
        position: fixed;
        height: 100%;
        width: 100%;
        z-index: 5000;
        top: 0;
        left: 0;
        float: left;
        text-align: center;
        padding-top: 25%;
    }
</style>
<form name="formcheck">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="domainselects">Select Domain</label>
                        <select class="form-control" id="domainimportselect" >
                            <c:forEach items="${faclilitypostDomainList}" var="dms">
                                <option value="${dms.facilitydomainid}-${dms.domainname}">${dms.domainname}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            <div class="tile">
                <div class="row">
                    <div class="col-md-12">
                        <div id="loadupdateddesigCats" style="display: none;">
                            <img src="static/img2/loader.gif" alt="Loading"/><br/>
                            Importing Designation Categories Please Wait...
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-sm-4 left" id="importAllBtnDiv">
                                <button class="btn btn-sm btn-primary icon-btn" onclick="importAllSelectedDesignations()">
                                    <i class="fa fa-user-circle"></i>
                                    Import All Posts
                                </button>
                            </div>
                            <div class="col-md-4 col-sm-4 right" id="importBtnDiv">
                                <button class="btn btn-sm btn-primary icon-btn" onclick="importSelectedDesignations()">
                                    <i class="fa fa-user-circle"></i>
                                    Import Posts
                                </button>
                            </div>
                        </div>
                        <table class="table table-hover table-striped" id="importdesignationtable">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Post Name</th>
                                    <th class="center">Select <a class="selectall" id="check-all"><font color="#ADFF2F"> All</font></a> | <a id="uncheck-all"><font color="#FF4500">None</font></a></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int h = 1;%>
                                <c:forEach items="${designationimport}" var="ap">
                                    <tr id="${ap.designationid}">
                                        <td><%=h++%></td>
                                        <td>${ap.designationname}</td>
                                        <td class="center hidden-xs">
                                            <div class="checkbox-table">
                                                <label>
                                                    <input type="checkbox" class="desigimportcheckbox" name="checkedAll[]" onclick="assignDesignation(${ap.designationid})">
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div> 
                </div>
            </div>
        </div>
    </div>
</form>
<script>
    $('#importdesignationtable').DataTable();
    var jsonimportAll = [];

    var selectedDesignations = new Set();
    var allSelectedDesignations = new Set();
    $(document).ready(function () {
        $('#importBtnDiv').hide();
        $('#importAllBtnDiv').hide();

        $('#check-all').click(function () {
            $("input:checkbox").attr('checked', true);
            $('#importAllBtnDiv').show();
        });
        $('#uncheck-all').click(function () {
            $("input:checkbox").attr('checked', false);
            $('#importAllBtnDiv').hide();
        });
    });
    function assignDesignation(designationid) {
        if (!selectedDesignations.has(designationid)) {
            selectedDesignations.add(designationid);
            $('#importBtnDiv').show();
        } else {
            selectedDesignations.delete(designationid);
            if (selectedDesignations.size < 1) {
                $('#importBtnDiv').hide();
            }
        }
    }


    function importSelectedDesignations() {
        var domainimportselect = $('#domainimportselect').val();
        var fields = domainimportselect.split('-');
        if (selectedDesignations.size !== 0) {

            $.ajax({
                type: 'POST',
                data: {values: JSON.stringify(Array.from(selectedDesignations)), facilitydomainid: fields[0]},
                url: "localsettingspostsandactivities/importdesignationcategory.htm",
                success: function (data) {
                    console.log("----------------------import data" + data);
                    if (data === 'success') {
                        $.toast({
                            heading: 'Success',
                            text: 'Designation Category Imported Successfully.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'An unexpected error occured while trying to import Designation Category.',
                            icon: 'error'
                        });
                        window.location = '#close';
                    }
                }
            });
        }
    }

//    function importAllSelectedDesignations() {
//        var domainimportselect = $('#domainimportselect').val();
//        var fields = domainimportselect.split('-');
//        if (importset.size !== 0) {
//            $.ajax({
//                type: 'POST',
//                data: {values: JSON.stringify(Array.from(importset)), facilitydomainid: fields[0]},
//                url: "localsettingspostsandactivities/importdesignationcategory.htm",
//                success: function (data, textStatus, jqXHR) {
//                    $(this).removeData('modal');
//                    $('#importdesig').modal('hide');
//                    ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
//                }
//            });
//        } else {
//
//        }
//    }

    function importAllSelectedDesignations() {
        jsonimportAll = ${jsondesignationimports};
        document.getElementById('loadupdateddesigCats').style.display = 'block';
        $.ajax({
            type: 'POST',
            cache: false,
            dataType: 'text',
            data: {desigCatvalues: JSON.stringify(jsonimportAll)},
            url: "localsettingspostsandactivities/importAllDesignationCategories.htm",
            success: function (data) {
                if (data === "successly") {
                    $.toast({
                        heading: 'Success',
                        text: 'Designation Imported Successfully.',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    // ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                    window.location = '#close';
                } else {
                    $.toast({
                        heading: 'Error',
                        text: 'An unexpected error occured while trying to import Designation Categories.',
                        icon: 'error'
                    });
                    ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                    window.location = '#close';
                }
            }
        });
    }

</script>


