<%-- 
    Document   : locationsLoader
    Created on : May 23, 2018, 10:44:53 AM
    Author     : Samsung
--%>
<%@include file="../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:if test="${model.mainActivity=='region'}">
    <h6 class="card-title">Change Work Location</h6>
    <select class="form-control" id="region" name="region" onChange="clearDiv('district-pane');
            if (this.value == 0) {
                return false;
            }
            ajaxSubmitData('changeUserLocation.htm', 'district-pane', 'act=b&i=' + this.value + '&b=b&c=a&d=0', 'GET');">
        <option value="0">--Select Region--</option>
        <c:forEach items="${model.regionList}" var="regions">                                
            <option value="${regions.regionid}">${regions.regionname}</option>
        </c:forEach>
    </select>
    <div id="district-pane"></div>
</c:if>    
<c:if test="${model.mainActivity=='district'}">
    <select class="form-control" id="district" name="district" onChange="clearDiv('facility-pane'); if (this.value == 0) {return false;}
            ajaxSubmitData('changeUserLocation.htm', 'facility-pane', 'act=b&i=' + this.value + '&b=c&c=a&d=0', 'GET');">
        <option value="0">--Select District--</option>
        <c:forEach items="${model.districtList}" var="districts">                                
            <option value="${districts.districtid}">${districts.districtname}</option>
        </c:forEach>
    </select>
    <div id="facility-pane"></div>   
</c:if>
<c:if test="${model.mainActivity=='facility'}">
    <select class="form-control" id="district" name="district" onChange="if (this.value == 0) {return false;}
            ajaxSubmitData('changeUserLocation.htm', 'changeUnitSession', 'act=b&i=' + this.value + '&b=d&c=a&d=0', 'GET');">
        <option value="0">--Select Facility--</option>
        <c:forEach items="${model.facilityList}" var="facility">                                
            <option value="${facility.facilityid}">${facility.facilityname} - ${facility.shortname}</option>
        </c:forEach>
    </select>
</c:if>        
<c:if test="${model.mainActivity=='resetSession' || model.mainActivity=='endSession' || model.mainActivity=='setUnitSession'}">
    <script>
        $(document).ready(function(){
            location.reload(true);
        });
    </script>
    Please Wait...
</c:if>    