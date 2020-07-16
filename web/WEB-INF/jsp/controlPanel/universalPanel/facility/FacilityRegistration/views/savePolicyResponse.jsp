<%-- 
    Document   : savePolicyResponse
    Created on : Jul 12, 2018, 11:11:09 AM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

    <div class="table-responsive">
        <c:if test="${model.resp==true}">
            <h2>${model.respMessage}</h2>
        </c:if>
        <c:if test="${model.resp==false}">
            <h2>Sorry, Save Failed  <br/> 
                ${model.respMessage}
            </h2>
        </c:if>
        <c:if test="${model.mainActivity=='AddFacilityPolicy'}">
            <c:if test="${not empty model.addedPolicyList}">   
                <table class="table table-hover table-bordered" id="responseTable">
                    <thead>
                        <tr>
                            <th class="center"></th>
                            <th>Name</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${model.addPolicyList}" var="list" varStatus="status">
                            <tr>
                                <td align="left">&nbsp;</td>
                                <td align="left">${list.policyname}</td>
                                <td align="left">
                                    <ol>
                                        <c:forEach items="${list.facilityassignedpolicys}" var="list2" varStatus="status">
                                            <li>${list2.facilitypolicyoptions.name}</li>
                                            </c:forEach>
                                    </ol>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </c:if>
            <div class="form-group row" <c:if test="${model.activity=='Update'}">style="display:none"</c:if>>
            <div class="tile-footer" style="margin: auto;">
                <button type="button" class="btn btn-primary" id="viewFacilityDetailsBtn" onClick="ajaxSubmitData('orgFacilitySettings.htm', 'orgResponse-pane', 'act=c2&i=${model.facilityid}&b=b&c=c&d=0&ofst=1&maxR=100&sStr=${model.sStr}', 'GET');">View Added Facility Details</button> 
                &nbsp;&nbsp;&nbsp;
                <button type="button" class="btn btn-primary" id="addNewFacilityBtn" onClick="ajaxSubmitData('domainFacSetting.htm', 'facTabContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Add New Facility</button>
            </div>
        </div>    
</div>
<script>
    $(document).ready(function () {
       // ajaxSubmitData('orgFacilitySettings.htm', 'facility-pane', 'act=c1&i=${model.facilityid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');
    });
</script>