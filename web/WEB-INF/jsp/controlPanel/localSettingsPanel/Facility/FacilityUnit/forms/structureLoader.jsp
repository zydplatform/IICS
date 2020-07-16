<%-- 
    Document   : structureLoader
    Created on : May 18, 2018, 1:16:10 PM
    Author     : samuelwam
--%>
<%@include file="../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:if test="${model.formActivity=='UnitStructure'}">

    <c:if test="${not empty model.unitList}">

        <select class="form-control" id="sselect${model.d}" name="sselect${model.d}" onChange="clearDiv('structureSelect${model.d}');
                if (this.value === '0') {
                    return false;
                }
                $('#parentId').val(this.value);
                ajaxSubmitData('facStructureLoader.htm', 'structureSelect${model.d}', 'act=a&i=' + this.value + '&b=${model.b}&c=a&d=${model.d}&e=${model.e}', 'GET');">
            <c:forEach items="${model.unitList}" var="unit">         
                <option value="0">--Select ${unit.facilitystructure.hierachylabel}--</option>
                <option value="${unit.facilityunitid}">${unit.facilityunitname}</option>
            </c:forEach>
        </select>
        <div id="structureSelect${model.d}"></div>
    </c:if>
</c:if>
<c:if test="${model.formActivity=='UnitTransfer'}">
    <c:if test="${not empty model.facilityUnitList}">
        <select class="form-control" id="selectLeve${model.d}" name="selectLeve${model.d}" <c:if test="${empty model.facilityUnitList}">disabled="disabled"</c:if> onChange="clearDiv('structureSelect${model.d}');
                if (this.value === '0') {
                    $('#parentId').val(0);
                    return false;
                }
                $('#parentId').val(this.value);
                ajaxSubmitData('facStructureLoader.htm', 'structureSelect${model.d}', 'act=b&i=' + this.value + '&b=${model.b}&c=${model.c}&d=${model.d}&e=${model.e}', 'GET');">

            <c:if test="${not empty model.facilityUnitList}">
                <option value="0">--Select Sub Level--</option>
            </c:if>        
            <c:forEach items="${model.facilityUnitList}" var="unit">                                
                <option value="${unit.facilityunitid}">${unit.facilitystructure.hierachylabel}: ${unit.facilityunitname}</option>
            </c:forEach>
        </select>
        <div id="structureSelect${model.d}"></div>
    </c:if>
</c:if>
<c:if test="${model.formActivity=='UnitRegistration'}">
    <c:if test="${not empty model.facilityUnitList}">
        <select class="form-control" id="selectLeve${model.d}" name="selectLeve${model.d}" <c:if test="${empty model.facilityUnitList}">disabled="disabled"</c:if> onChange="clearDiv('structureSelect${model.d}');
                if (this.value === '0') {
                    $('#parentId').val(0);
                    return false;
                }
                ajaxSubmitData('facStructureLoader.htm', 'structureSelect${model.d}', 'act=c&i=' + this.value + '&b=${model.b}&c=${model.c}&d=${model.d}&e=${model.e}', 'GET');">

            <c:if test="${not empty model.facilityUnitList}">
                <option value="0">--Select Sub Level--</option>
            </c:if>        
            <c:forEach items="${model.facilityUnitList}" var="unit">                                
                <option value="${unit.facilityunitid}">${unit.facilitystructure.hierachylabel}: ${unit.facilityunitname}</option>
            </c:forEach>
        </select>
        <div id="structureSelect${model.d}"></div>
    </c:if>
    <c:if test="${empty model.facilityUnitList}">   
        <c:if test="${model.isParentObj==true}">
            <b><span style="color:red">Error:</span> Invalid/Incomplete Structure</b>
        </c:if>
        <c:if test="${model.isParentObj==false}">   
            <script>
                $('#parentId').val(${model.i});
            </script>
        </c:if> 
    </c:if>
</c:if>        
<c:if test="${model.formActivity=='UnitSelectByStructure'}">
    <!-------${model.returnUnits}----->
    <c:if test="${not empty model.hyrchList}">
        <div class="col-md-3">
            <div class="form-group">
                <select class="form-control" id="sselect" name="sselect" onChange="if (this.value === '0') {
                            return false;
                        }
                        <c:if test="${model.returnUnits==true}">
                        clearDiv('unitSearchResponse');
                        clearDiv('structureSelect1');
                        ajaxSubmitData('facStructureLoader.htm', 'unitSearchResponse', 'act=d&i=' + this.value + '&b=${model.b}&c=${model.returnUnits}&d=1&e=${model.levelHyrchObj.structureid}', 'GET');
                        </c:if>
                        <c:if test="${model.returnUnits==false}">
                        clearDiv('unitSearchResponse');
                        ajaxSubmitData('facStructureLoader.htm', 'structureSelect1', 'act=d&i=' + this.value + '&b=${model.b}&c=${model.returnUnits}&d=1&e=${model.levelHyrchObj.structureid}', 'GET');
                        </c:if>">
                    <option value="0">-Search Scope: Select Search Level-</option>
                    <c:forEach items="${model.hyrchList}" var="list" varStatus="status">
                        <option value="${list.facilityunitid}">${model.levelHyrchObj.hierachylabel}: ${list.facilityunitname}</option>
                    </c:forEach>
                </select>
                <div id="structureSelect1"></div> 

            </div>
        </div>
    </c:if> 
</c:if>
<c:if test="${model.formActivity=='UnitSelection'}">
    <!-------${model.returnUnits}----->
    <c:if test="${not empty model.facilityUnitList}">
        <select class="form-control" id="selectLeve${model.d}" name="selectLeve${model.d}" onChange="if (this.value === '0') {
                            return false;}
                <c:if test="${model.returnUnits==true}">
                        clearDiv('unitSearchResponse');
                        clearDiv('structureSelect${model.d}');
                        ajaxSubmitData('facStructureLoader.htm', 'unitSearchResponse', 'act=d&i=' + this.value + '&b=${model.b}&c=${model.returnUnits}&d=1&e=${model.levelHyrchObj.structureid}', 'GET');
                </c:if>
                <c:if test="${model.returnUnits==false}">
                        clearDiv('unitSearchResponse');
                        ajaxSubmitData('facStructureLoader.htm', 'structureSelect${model.d}', 'act=d&i=' + this.value + '&b=${model.b}&c=${model.returnUnits}&d=1&e=${model.levelHyrchObj.structureid}', 'GET');
                </c:if>">
            <option value="0">-Search Scope: Select Search Level-</option>
            <c:forEach items="${model.facilityUnitList}" var="unit">                                
                <option value="${unit.facilityunitid}">${unit.facilitystructure.hierachylabel}: ${unit.facilityunitname}</option>
            </c:forEach>
        </select>
        <div id="structureSelect${model.d}"></div>
    </c:if>
    <c:if test="${empty model.facilityUnitList}">   
        <c:if test="${model.isParentObj==true}">
            <b><span style="color:red">Error:</span> Invalid/Incomplete Structure</b>
        </c:if>
        <c:if test="${model.isParentObj==false}">   
            <b><span style="color:red">Error:</span> No Node Details Found</b>
        </c:if> 
    </c:if>
</c:if>     
