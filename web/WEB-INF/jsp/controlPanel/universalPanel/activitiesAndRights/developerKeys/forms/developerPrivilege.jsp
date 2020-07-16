<%-- 
    Document   : developerPrivilege
    Created on : Apr 24, 2018, 3:44:56 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table class="table table-hover table-bordered" id="devkys2">
    <thead>
        <tr>
            <th>No</th>
            <th>Privilege</th>
            <th>Privilege Key</th>
            <th>Tagged Privilege</th>
            <th>Assign</th>
        </tr>
    </thead>
    <tbody id="tableFacilityOwner">
        <% int j = 1;%>
        <% int p = 1;%>
        <c:forEach items="${privilegelist}" var="a">
            <tr id="${a.privilegeid}">
                <td><%=j++%></td>
                <td>${a.privilege}</td>
                <td align="center"><a data-container="body" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="${a.privilegekey}" data-original-title="${a.privilege}" href="#"> <i class="fa fa-fw fa-lg fa-dedent"></i></a></td>
                <td align="center"><a data-container="body" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="${a.description}" data-original-title="${a.privilege}" href="#"> <i class="fa fa-fw fa-lg fa-dedent"></i></a></td>               
                <td  align="center"> <input id="priv<%=p++%>" type="checkbox" value="${a.privilegeid}" onchange="if(this.checked){
                    addorassignprivilege(this.value,'checked',this.id);
                }else{
                    addorassignprivilege(this.value,'unchecked',this.id);
                }"></td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#devkys2').DataTable();
     $(function () {
        $('[data-toggle="popover"]').popover();
    });
</script>