<%-- 
    Document   : locations
    Created on : Nov 29, 2017, 10:04:31 AM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:if test="${model.formActivity=='AssetReg-District'}">
    <c:if test="${model.b!='b'}">
        <select class="form-control" id="district" name="district" onChange="clearDiv('county-pane'); if(this.value==0){return false;} ajaxSubmitData('locationsLoader.htm', 'county-pane', 'act=b&i='+this.value+'&b=${model.b}&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <option value="0">--Select District--</option>
            <c:forEach items="${model.districts}" var="districts">                                
                <option value="${districts[0]}">${districts[1]}</option>
            </c:forEach>
        </select>
    </c:if>
    <c:if test="${model.b=='b'}">
        <select class="form-control" id="district" name="district" onChange="clearDiv('response'); if(this.value==0){return false;} ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act=b1&i='+this.value+'&b=a&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">
            <option value="0">--Select District--</option>
            <c:forEach items="${model.districts}" var="districts">                                
                <option value="${districts[0]}">${districts[1]}</option>
            </c:forEach>
        </select>
    </c:if>
</c:if>
<c:if test="${model.formActivity=='AssetReg-County'}">
    <c:if test="${model.b!='c'}">
        <select class="form-control" id="county" name="county" onChange="clearDiv('subcounty-pane'); if(this.value==0){return false;} ajaxSubmitData('locationsLoader.htm', 'subcounty-pane', 'act=c&i='+this.value+'&b=${model.b}&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <option value="0">--Select County--</option>
            <c:forEach items="${model.countys}" var="countys">                                
                <option value="${countys[0]}">${countys[1]}</option>
            </c:forEach>
        </select>
    </c:if>
    <c:if test="${model.b=='c'}">
        <select class="form-control" id="county" name="county" onChange="clearDiv('response'); if(this.value==0){return false;} ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act=c1&i='+this.value+'&b=a&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">
            <option value="0">--Select County--</option>
            <c:forEach items="${model.countys}" var="countys">                                
                <option value="${countys[0]}">${countys[1]}</option>
            </c:forEach>
        </select>
    </c:if>
</c:if>
<c:if test="${model.formActivity=='AssetReg-SubCounty'}">
    <c:if test="${model.b!='d'}">
        <select class="form-control" id="subcounty" name="subcounty" onChange="clearDiv('parish-pane'); if(this.value==0){return false;} ajaxSubmitData('locationsLoader.htm', 'parish-pane', 'act=d&i='+this.value+'&b=${model.b}&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <option value="0">--Select Sub-County--</option>
            <c:forEach items="${model.subcountys}" var="subcountys">                                
                <option value="${subcountys[0]}">${subcountys[1]}</option>
            </c:forEach>
        </select>
    </c:if>
    <c:if test="${model.b=='d'}">
        <select class="form-control" id="subcounty" name="subcounty" onChange="clearDiv('response'); if(this.value==0){return false;} ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act=d1&i='+this.value+'&b=a&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">
            <option value="0">--Select Sub-County--</option>
            <c:forEach items="${model.subcountys}" var="subcountys">                                
                <option value="${subcountys[0]}">${subcountys[1]}</option>
            </c:forEach>
        </select>
    </c:if>
</c:if>
<c:if test="${model.formActivity=='AssetReg-Parish'}">
    <c:if test="${model.b!='e'}">
        <select class="form-control" id="parish" name="parish" onChange="clearDiv('village-pane'); if(this.value==0){return false;} ajaxSubmitData('locationsLoader.htm', 'village-pane', 'act=e&i='+this.value+'&b=${model.b}&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <option value="0">--Select Parish--</option>
            <c:forEach items="${model.parish}" var="parish">                                
                <option value="${parish[0]}">${parish[1]}</option>
            </c:forEach>
        </select>
    </c:if>
    <c:if test="${model.b=='e'}">
        <select class="form-control" id="parish" name="parish" onChange="clearDiv('response'); if(this.value==0){return false;} ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act=e1&i='+this.value+'&b=a&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">
            <option value="0">--Select Parish--</option>
            <c:forEach items="${model.parish}" var="parish">                                
                <option value="${parish[0]}">${parish[1]}</option>
            </c:forEach>
        </select>
    </c:if>
</c:if>
<c:if test="${model.formActivity=='AssetReg-Village'}">
    <c:if test="${model.b!='f'}">
        <select class="form-control" id="fvillage" name="village" onChange="if(this.value==0){return false;}">
            <option value="0">--Select Village--</option>
            <c:forEach items="${model.villages}" var="villages">                                
                <option value="${villages[0]}">${villages[1]}</option>
            </c:forEach>
        </select>
    </c:if>
    <c:if test="${model.b=='f'}">
        <select class="form-control" id="village" name="village" onChange="clearDiv('response'); if(this.value==0){return false;} ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act=f1&i='+this.value+'&b=a&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">
            <option value="0">--Select Village--</option>
            <c:forEach items="${model.villages}" var="villages">                                
                <option value="${villages[0]}">${villages[1]}</option>
            </c:forEach>
        </select>
    </c:if>
</c:if>
<c:if test="${model.formActivity=='FacilitySearch'}">
    <c:if test="${model.act=='a'}">
        <select class="form-control" id="region" name="region" onChange="if(this.value==0){return false;} ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act=a1&i='+this.value+'&b=a&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">
            <option value="0">--Select Region--</option>
            <c:forEach items="${model.regions}" var="regions">                                
                <option value="${regions[0]}">${regions[1]}</option>
            </c:forEach>
        </select>
    </c:if>
    <c:if test="${model.act!='a'}">
        <select class="form-control" id="region" name="region" onChange="if(this.value==0){return false;} ajaxSubmitData('locationsLoader.htm', 'district-pane', 'act=a&i='+this.value+'&b=${model.b}&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <option value="0">--Select Region--</option>
            <c:forEach items="${model.regions}" var="regions">                                
                <option value="${regions[0]}">${regions[1]}</option>
            </c:forEach>
        </select>
        <div id="district-pane"></div><div id="county-pane"></div><div id="subcounty-pane"></div><div id="parish-pane"></div><div id="village-pane"></div>    
    </c:if>
    
</c:if>