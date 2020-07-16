<%-- 
    Document   : response
    Created on : Mar 12, 2018, 10:28:04 AM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="panel-body">
    <div class="table-responsive">
        <c:if test="${model.resp==true}">
            <h2>${model.respMessage}</h2>
        </c:if>
        <c:if test="${model.resp==false}">
            <h2>Sorry, Save Failed  <br/> 
                ${model.respMessage}
            </h2>
        </c:if>
    </div>
</div>

<!-- 
<script>
    if(${model.mainActivity=='Device Registration'}){
        ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=a4&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>
-->
