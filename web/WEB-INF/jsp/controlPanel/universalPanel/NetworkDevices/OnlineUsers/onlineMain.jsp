<%-- 
    Document   : onlineMain
    Created on : Jun 18, 2018, 3:37:00 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset>
    <legend>Manage Online Users On The IICS Network</legend>
    <div id="addnew-pane"></div>
    <c:if test="${not empty  model.onlineUserRegion}">
        <form id="manageFormField" name="manageFormField">
            <table class="table table-hover table-bordered" id="rDataGrid">
                <thead>
                    <tr>
                        <th>No</th>
                        <th class="hidden-xs">Location [Region Name]</th> 
                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEONLINEUSERS')">
                            <th>Users Online Today</th> 
                            </security:authorize>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="count" value="1"/>
                    <c:set var="No" value="0" />
                    <c:forEach items="${model.onlineUserRegion}" var="list" varStatus="status" begin="0" end="${model.size}">
                        <c:choose>
                            <c:when test="${status.count % 2 != 0}">
                                <tr>
                                </c:when>
                                <c:otherwise>
                                <tr bgcolor="white">
                                </c:otherwise>
                            </c:choose>
                            <td>${status.count}</td>
                            <td>${list.region.regionname}</td>
                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEONLINEUSERS')">
                                <td align="center">
                                    <c:if test="${list.count==1}">
                                        <a href="#" onClick="ajaxSubmitData('onlineUsers.htm', 'panel_overview', 'act=b&i=${list.region.regionid}&b=b&c=c&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                            ${list.count} User
                                        </a>
                                    </c:if>
                                    <c:if test="${list.count>1}">
                                        <a href="#" onClick="ajaxSubmitData('onlineUsers.htm', 'panel_overview', 'act=b&i=${list.region.regionid}&b=${model.b}&c=${model.a}&d=0&ofst=1&maxR=100&sStr=${model.sStr}', 'GET');">
                                            ${list.count} Users
                                        </a>
                                    </c:if>
                                </td>
                            </security:authorize>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>

        </form>
    </c:if>
    <c:if test="${empty model.onlineUserRegion}">
        <div align="center"><h3>No System Users Found Online</h3></div>
    </c:if>
</fieldset>
<script>
    $(document).ready(function () {
        $('#rDataGrid').DataTable();
    })
</script>