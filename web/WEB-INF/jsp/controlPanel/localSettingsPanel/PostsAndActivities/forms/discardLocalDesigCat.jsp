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
</style>
<div class="col-md-12" id="discardPane">
    <div class="container" id="transfer-pane">
        <fieldset><legend>Discard Designation Category: ${previousdesigCatName}${checkObj[1]}</legend>
            <div class="row">
                <div class="col-md-12">
                    <div>
                        <div class="tile-body">
                            <input class="form-group" type="hidden" value="${designationcategoryid}" id="designationcategoryid">
                            <input class="form-group" type="hidden" value="${categoryname}" id="categoryname">
                            <table class="table table-hover table-bordered" id="sampleTablesd">
                                <thead>
                                    <tr>
                                        <td class="center">No.</td>
                                        <td class="center">Post</td>
                                        <td class="center">Select To Transfer Designation &nbsp;<a id="selectAllcheckboxs" onclick="selectallcheckboxs(this.id);" href="javascript:selectToggleCheckBox(true, 'selectObj', ${size});"><font color="yellow"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'selectObj', ${size});" onClick="unselectallcheckboxs(this.id)"><font color="yellow">None</font></a></td>
                                    </tr>
                                </thead>
                                <tbody class="col-md-12">
                                    <% int j = 1;%>
                                    <c:forEach items="${TransferPostsList}" var="t">
                                        <tr id="${t.designationid}">
                                            <td class="center"><%=j++%></td>
                                            <td class="center">${t.designationname}</td>
                                            <td class="center">
                                                <input type="checkbox" name="selectObj" id="selectObj" value="${t.designationid}" onchange="if (this.checked) {
                                                                        checkedoruncheckeddesignations(this.value, 'checked');
                                                                    } else {
                                                                        checkedoruncheckeddesignations(this.value, 'unchecked');
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
                                            <input type="button" style="background-color: purple; color: white" value="Transfer Posts" class='btn btn-purple' onClick="transferdesignations();"/>
                                        </div>
                                    </td>
                                    <td colspan="2" align="center">
                                        <div id="selectedObjBtn" style="display:none;">
                                            <input type="button" style="background-color: purple; color: white" value="Transfer Posts" class='btn btn-purple' onClick="transfersomedesignations();"/>
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
        var jsontransferAll = ${jsondesignations};
        var designationsCatid = document.getElementById('designationcategoryid').value;
        console.log("designationsCatid" + designationsCatid);
        document.getElementById('loadtransfers').style.display = 'block';
        $.ajax({
            type: 'POST',
            cache: false,
            dataType: 'text',
            data: {designationsvalues: JSON.stringify(jsontransferAll), designationcatid: designationsCatid},
            url: "localsettingspostsandactivities/transferlocaldesignations.htm",
            success: function (data) {
                document.getElementById('loadtransfers').style.display = 'none';
                $.alert({
                    title: 'Alert!',
                    content: 'Successfully Transfered Posts'
                });
                window.location = '#close';
                ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
            }
        });
    }

    var transferdesigset = new Set();
    function checkedoruncheckeddesignations(value, type) {
        if (transferdesigset !== 0) {
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

    function transfersomedesignations() {
        var designationsCatid = document.getElementById('designationcategoryid').value;
        $.ajax({
            type: 'GET',
            data: {desigvalues: JSON.stringify(Array.from(transferdesigset)), designationcatid: designationsCatid},
            url: "localsettingspostsandactivities/transfersomelocaldesignations.htm",
            success: function (data, textStatus, jqXHR) {

                $.alert({
                    title: 'Alert!',
                    content: 'Successfully Transferred Post',
                });

                window.location = '#close';
                ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
            }
        });

    }

</script>
