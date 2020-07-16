<%-- 
    Document   : response
    Created on : Nov 29, 2017, 10:50:21 PM
    Author     : samuelWam
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<c:if test="${model.updated==true}">
    <fieldset><legend>
            <div style="float:left" align="left"><a id="back" href="#"  onClick="ajaxSubmitData('orgFacilitySettings.htm', 'summaryPane', 'act=c1&i=${model.facilityid}&b=a&c=&d=0&ofst=-99&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a></div>
        </legend>
    </c:if>
    <div class="panel-body">
        <div class="table-responsive">
            <c:if test="${model.resp==true}">
                <h2>${model.successMessage}</h2>
            </c:if>
            <c:if test="${model.resp==false}">
                <h2>Sorry, Save Failed  <br/> 
                    ${model.errorMessage}
                </h2>

            </c:if>
            <c:if test="${model.mainActivity=='Facility'}">
                <c:if test="${not empty model.facilityList}">   
                    <table class="table table-hover table-bordered" id="responseTable">
                        <thead>
                            <tr>
                                <th class="center"></th>
                                <th>Name</th>
                                <th>Code</th>
                                <th>Description</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${model.facilityList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                <tr>
                                    <td align="left">&nbsp;</td>
                                    <td align="left">${list.facilityname}</td>
                                    <td align="left">${list.facilitycode}</td>
                                    <td align="left">${list.description}</td>                                            
                                    <td align="center"><c:if test="${list.active==true}">Active</c:if><c:if test="${list.active==false}">Disabled</c:if></td>
                                    </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </c:if>
        </div>
    </div>
    <c:if test="${model.updated==true}">
    </fieldset>
</c:if>
