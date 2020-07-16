<%-- 
    Document   : onlineUsers
    Created on : Mar 7, 2018, 7:23:37 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<fieldset>
    <legend>
        <a id="back" href="#"  onClick="ajaxSubmitData('onlineUsers.htm', 'panel_overview', 'act=b&i=${model.d}&b=${model.b}&c=${model.a}&d=0&ofst=1&maxR=100&sStr=${model.sStr}', 'GET');"> <i class="fa fa-backward"></i></a>
        &nbsp;&nbsp;
        Manage Online Users On The IICS Network In ${model.usersFacilityObj.facilityname}-${model.usersFacilityObj.facilitylevelid.facilitylevelname}</legend>
    <div id="addnew-pane"></div>
    <c:if test="${not empty  model.onLineUsers}">
        <form id="manageFormField" name="manageFormField">
            <table class="table table-hover table-bordered" id="dataGrid">
                <thead>
                    <tr>
                        <th>No</th>
                        <th class="hidden-xs">User - Full Name</th> 
                        <th class="hidden-xs">Last Login</th> 
                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEONLINEUSERS')">
                            <th>Force Log Off</th> 
                            </security:authorize>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="count" value="1"/>
                    <c:set var="No" value="0" />
                    <c:forEach items="${model.onLineUsers}" var="list" varStatus="status" begin="0" end="${model.size}">
                        <c:choose>
                            <c:when test="${status.count % 2 != 0}">
                                <tr>
                                </c:when>
                                <c:otherwise>
                                <tr bgcolor="white">
                                </c:otherwise>
                            </c:choose>
                            <td>${status.count}</td>
                            <td>${list.systemuser.personid.firstname} ${list.systemuser.personid.lastname}</td>
                            <td>${list.duration}</td>
                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEONLINEUSERS')">
                                <td align="center">
                                    <input type="checkbox" name="logOff${status.count}" id="logOff${status.count}" onChange="if(this.checked){ajaxSubmitData('onlineUsers.htm', 'panel_overview', 'act=d&i=${list.systemuser.personid.personid}&b=${model.b}&c=${model.a}&d=0&ofst=1&maxR=100&sStr=${model.sStr}', 'GET');}"/>
                                </td>
                            </security:authorize>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>

        </form>
    </c:if>
    <c:if test="${empty model.onLineUsers}">
        <div align="center"><h3>No System Users Found Online</h3></div>
    </c:if>
</fieldset>
<script>
    $(document).ready(function () {
        $('#dataGrid').DataTable();
    })
</script>
