<%-- 
    Document   : loadSelectedLocations
    Created on : Jun 13, 2018, 5:07:08 PM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>

<c:if test="${model.locationActivity==1}">
    <select class="form-control" name="regionid" id="regionidlist" onChange="ajaxSubmitData('locations/getSearchedLocation.htm', 'countyPane', 'act=a&i=' + this.value + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
        <option value="0">--Select District--</option>
        <c:forEach items="${model.districtList}" var="distr">
            <option <c:if test="${model.districtid==distr.districtid}">selected</c:if> value="${distr.districtid}">${distr.districtname} </option>
        </c:forEach>
    </select>
</c:if>


<c:if test="${model.locationActivity==2}">
    <select class="form-control" name="regionid" id="regionidlist" onChange="ajaxSubmitData('locations/loadLocationVals.htm', 'countyPane', {locID: $(this).val(), act: 3}, 'GET');">                                                         
        <option value="0">--Select District--</option>
        <c:forEach items="${model.districtList}" var="distr">
            <option <c:if test="${model.districtid==distr.districtid}">selected</c:if> value="${distr.districtid}">${distr.districtname} </option>
        </c:forEach>
    </select>
</c:if>
<c:if test="${model.locationActivity==3}">
    <select class="form-control" name="countylist" id="countylist" onChange="ajaxSubmitData('locations/getSearchedLocation.htm', 'subcountyPane', 'act=h&i=' + this.value + '&b=h&c=h&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
        <option value="0">--Select County--</option>
        <c:forEach items="${model.countyList}" var="count">
            <option <c:if test="${model.countyid==count.countyid}">selected</c:if> value="${count.countyid}">${count.countyname} </option>
        </c:forEach>
    </select>
</c:if>