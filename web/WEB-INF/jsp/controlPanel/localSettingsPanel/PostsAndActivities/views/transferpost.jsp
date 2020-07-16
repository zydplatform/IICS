<%-- 
    Document   : transferpost
    Created on : Sep 3, 2018, 11:51:09 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <form id="desigentryforms">
                            <div class="form-group">
                                <label class="control-label">Previous Designation Category</label>
                                <input class="form-control myform" id="previousDesigCatId" value="${designationcategoryid}" type="hidden">
                                <input class="form-control myform" id="previousDesigCatName" value="${categoryname}" type="text" readonly="true">
                                
                                <input class="form-control myform" id="designationid" value="${designationid}" type="hidden">
                                <input class="form-control myform" id="designationname" value="${designationname}" type="hidden" readonly="true">
                            </div>
                            <div class="form-group">
                                <label class="control-label">Select New Designation Category</label>
                                <select class="form-control designationCat_search" id="selectdesignationCat">
                                    <option>------Select Designation Category To Transfer To------</option>
                                    <c:forEach items="${transferdesigcategory}" var="d">
                                        <option value="${d.designationcategoryid}">${d.categoryname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="transferDesignationCat" onclick="transferpost();" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Transfer Post 
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function transferpost() {
        var selectdesignationCat = document.getElementById('#selectdesignationCat');
        if (selectdesignationCat === ' ') {
            $.alert('please select a designation category');
            return false;
        }
        var designationid = $('#designationid').val();
        var designationname = $('#designationname').val();
        var designationsCatid = document.getElementById('selectdesignationCat').value;
        $.ajax({
            type: "POST",
            cache: false,
            url: "localsettingspostsandactivities/restoredesignation.htm",
            data: {designationcategoryid: designationsCatid, designationid: designationid, designationname: designationname},
            success: function (response) {
                ajaxSubmitData('localsettingspostsandactivities/viewtranferreddesignations.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            }

        });
        $.alert('<span><strong>Designation Name:' + ' ' + designationname + ' ' + 'Restored Successfully' + ' ' + '</strong></span>');
    }
</script>