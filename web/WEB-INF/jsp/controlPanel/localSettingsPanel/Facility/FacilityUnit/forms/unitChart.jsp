<%-- 
    Document   : unitChart
    Created on : Jun 13, 2018, 5:48:07 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:if test="${not empty model.unitList}">
    <div class="tree">
        <c:forEach items="${model.unitList}" var="list" varStatus="status" begin="0" end="${model.size}">
            <ul>
                <li>${model.facUnitObj.facilityunitname} Unit Chart
                    <ul>
                        <li>
                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=b&i=${list.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${list.facilityunitname}</a>
                            <c:if test="${not empty list.facilityunitList}">
                                <ul>
                                    <c:forEach items="${list.facilityunitList}" var="level2">
                                        <li>
                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=b&i=${level2.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level2.facilityunitname}</a>
                                            <c:if test="${not empty level2.facilityunitList}">    
                                                <ul>
                                                    <c:forEach items="${level2.facilityunitList}" var="level3">
                                                        <li>
                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=b&i=${level3.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level3.facilityunitname}</a>
                                                            <c:if test="${not empty level3.facilityunitList}">    
                                                                <ul>
                                                                    <c:forEach items="${level3.facilityunitList}" var="level4">
                                                                        <li>
                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=b&i=${level4.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level4.facilityunitname}</a>
                                                                            <c:if test="${not empty level4.facilityunitList}">    
                                                                                <ul>
                                                                                    <c:forEach items="${level4.facilityunitList}" var="level5">
                                                                                        <li>
                                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=b&i=${level5.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level5.facilityunitname}</a>
                                                                                            <c:if test="${not empty level5.facilityunitList}">    
                                                                                                <ul>
                                                                                                    <c:forEach items="${level5.facilityunitList}" var="level6">
                                                                                                        <li>
                                                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=b&i=${level6.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level6.facilityunitname}</a>
                                                                                                            <c:if test="${not empty level6.facilityunitList}">    
                                                                                                                <ul>
                                                                                                                    <c:forEach items="${level6.facilityunitList}" var="level7">
                                                                                                                        <li>
                                                                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=b&i=${level7.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level7.facilityunitname}</a>
                                                                                                                            <c:if test="${not empty level7.facilityunitList}">    
                                                                                                                                <ul>
                                                                                                                                    <c:forEach items="${level7.facilityunitList}" var="level8">
                                                                                                                                        <li>
                                                                                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=b&i=${level8.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level8.facilityunitname}</a>
                                                                                                                                            <c:if test="${not empty level8.facilityunitList}">    
                                                                                                                                                <ul>
                                                                                                                                                    <c:forEach items="${level8.facilityunitList}" var="level9">
                                                                                                                                                        <li>
                                                                                                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=b&i=${level9.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level9.facilityunitname}</a>
                                                                                                                                                            <c:if test="${not empty level9.facilityunitList}">  
                                                                                                                                                                <ul>
                                                                                                                                                                    <c:forEach items="${level9.facilityunitList}" var="level10">
                                                                                                                                                                        <li>
                                                                                                                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=b&i=${level10.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level10.facilityunitname}</a>
                                                                                                                                                                        </li>
                                                                                                                                                                    </c:forEach>
                                                                                                                                                                </ul>
                                                                                                                                                            </c:if>
                                                                                                                                                        </li>
                                                                                                                                                    </c:forEach>
                                                                                                                                                </ul>
                                                                                                                                            </c:if>
                                                                                                                                        </li>
                                                                                                                                    </c:forEach>
                                                                                                                                </ul>
                                                                                                                            </c:if>
                                                                                                                        </li>
                                                                                                                    </c:forEach>
                                                                                                                </ul>
                                                                                                            </c:if>
                                                                                                        </li>
                                                                                                    </c:forEach>
                                                                                                </ul>
                                                                                            </c:if>
                                                                                        </li>
                                                                                    </c:forEach>
                                                                                </ul>
                                                                            </c:if>
                                                                        </li>
                                                                    </c:forEach>
                                                                </ul>
                                                            </c:if>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </c:if>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </li>
                    </ul>
                </li>
            </ul>
        </c:forEach>
    </div>
</c:if>
<c:if test="${empty model.unitList}">
    <div align="center"><h3>No Registered Facility Unit Organogram! Please Set Up Structure</h3></div>
</c:if>