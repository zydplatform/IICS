<%-- 
    Document   : discardDesigCat
    Created on : Jun 11, 2018, 5:13:29 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp"%>
<style>
    #loadtransfers {
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
     .error
    {
        border:2px solid red;
    }
</style>
<div class="modal fade col-md-12" id="discardPane" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 170%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Manage Designation Categories</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="clearDiv('response-pane');">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container" id="transfer-pane">
                    <fieldset><legend>Discard Designation Category: ${checkObj[1]}</legend>
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile-body">
                                        <h3></h3>

                                        <div class="form-group row">
                                            <label class="control-label">
                                                Select Designation Category To Transfer To: <span class="symbol required">*</span>
                                            </label>
                                            <select class="form-control" id="selectdesignationCats" name="selectdesignationCats">
                                                <option value="0">--Select Designation Category--</option>
                                                <c:forEach items="${DesignationLists}" var="u">                                
                                                    <option value="${u.designationcategoryid}">${u.categoryname}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <table class="table table-hover table-bordered" id="sampleTablesd">
                                            <thead>
                                                <tr>
                                                    <td>No.</td>
                                                    <td>Designation Name</td>
                                                    <td>Select To Transfer Designation &nbsp;<a id="selectAllcheckboxs" onclick="selectallcheckboxs(this.id);" href="javascript:selectToggleCheckBox(true, 'selectObj', ${size});"><font color="yellow"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'selectObj', ${size});" onClick="unselectallcheckboxs(this.id)"><font color="yellow">None</font></a></td>
                                                </tr>
                                            </thead>
                                            <tbody class="col-md-12">
                                                <% int j = 1;%>

                                                <c:forEach items="${desigcategory}" var="t">
                                                    <tr id="${t.designationid}">
                                                        <td><%=j++%></td>
                                                        <td>${t.designationname}</td>
                                                        <td align="center">
                                                            <input type="checkbox" name="selectObj" id="selectObj" value="${t.designationid}" onchange="if (this.checked) {
                                                                        checkedoruncheckedtransfers(this.value, 'checked');
                                                                    } else {
                                                                        checkedoruncheckedtransfers(this.value, 'unchecked');
                                                                    }"/>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <div id="loadtransfers" style="display: none;">
                                            <img src="static/img2/loader.gif" alt="Loading"/><br/>
                                            Transferring Designations Please Wait...
                                        </div>
                                        <table align="center">

                                            <tr>
                                                <td colspan="2" align="center">
                                                    <div id="selectedObjBtn" style="display:none;">
                                                        <input type="button" style="background-color: purple; color: white" value="Transfer Designation Categories" class='btn btn-purple' onClick="transferdesignations();"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        </br>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    function selectallcheckboxs(id) {
        var $table = $('#sampleTablesd');
        var $tdCheckbox = $table.find('tbody input:checkbox');
        $tdCheckbox.prop('checked', true);
        showDiv('selectedObjBtn');
    }

    function unselectallcheckboxs(id) {
        var $table = $('#sampleTablesd');
        var $tdCheckbox = $table.find('tbody input:checkbox');
        $tdCheckbox.prop('checked', false);
        hideDiv('selectedObjBtn');
    }

    function transferdesignations() {        
//        var jsontransferAll = ${jsondesignations};
        var jsontransferAll = Array.from(transferdesigset);
        var designationsCatid = document.getElementById('selectdesignationCats').value;
        console.log("designationsCatid" + designationsCatid);
        var validpostname = $("#selectdesignationCats").val();

        if (validpostname === '0') {
            $('#selectdesignationCats').addClass('error');
            $.alert({
                title: 'Alert!',
                content: 'Please Enter Designation Name'
            });

        } else {
            $.ajax({
                type: 'POST',
                cache: false,
                dataType: 'text',
                data: { designationsvalues: JSON.stringify(jsontransferAll), designationcatid: designationsCatid },
                url: "postsandactivities/transferdesignations.htm",
                success: function (data) {
                    ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'workpane', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    document.getElementById('loadtransfers').style.display = 'none';
                    document.getElementById('loadtransfers').style.display = 'block';


                    $.alert({
                        title: 'Alert!',
                        content: 'Successfully Transfered Designations'
                    });
                    $('.close').click();
                    //ajaxSubmitData('currencysystemsettings/currencypane.htm', 'workpane', '', 'GET');
                }
            });
        }

    }

    var transferdesigset = new Set();
    function checkedoruncheckedtransfers(value, type) {
        if (transferdesigset !== 0) {
            console.log("transferdesigset" + transferdesigset);
            if (type === 'checked') {
                transferdesigset.add(value);

                showDiv('selectedObjBtn');

            } else {

                if (transferdesigset.has(value)) {
                    transferdesigset.delete(value);
                }
            }

        } else {
            hideDiv('selectObjBtn');
        }
    }
    $(document).ready(function () {
        $('#discardPane').modal('show');
//
//        $('#transferdesignations').click(function () {
//            if (transferdesigset.size !== 0) {
//                $.ajax({
//                    type: 'POST',
//                    data: {values: JSON.stringify(Array.from(transferdesigset)), facilitydomainid: fields[0]},
//                    url: "localsettingspostsandactivities/transferdesignationcategory.htm",
//                    success: function (data, textStatus, jqXHR) {
//                        $(this).removeData('modal');
//                        $('#importdesig').modal('hide');
//                        //ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
//
//                    }
//                });
//            } else {
//
//            }
//        });
    });
</script>
