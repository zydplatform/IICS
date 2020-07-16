<%-- 
    Document   : response
    Created on : Jan 29, 2018, 9:25:19 PM
    Author     : samuelwam
--%>

<%@include file="../../../../../../include.jsp" %>

<c:set var="respDiv" value="funderDiv-resp" />
<c:if test="${model.desc=='addSupervisor'}"><c:set var="respDiv" value="supervisorDiv-resp" /></c:if>
    <c:if test="${model.desc=='addGender'}"><c:set var="respDiv" value="genderDiv-resp" /></c:if>
<c:if test="${model.desc=='addPaymentMode'}"><c:set var="respDiv" value="paymentModeDiv-resp" /></c:if>
<c:if test="${model.desc=='addCatchmentArea'}"><c:set var="respDiv" value="catchmentAreaDiv-resp" /></c:if>
<c:if test="${model.desc=='receiveAdverts'}"><c:set var="respDiv" value="receiveAdvertsDiv-resp" /></c:if>

<c:if test="${model.activity=='a' || model.activity=='b'}">
    <label class="col-sm-5 control-label" for="orgname">${model.respMessage}</label>
    <c:if test="${model.resp==true}">
        <a href="#" onClick="ajaxSubmitData('regEntityDesc.htm', '${respDiv}', 'act=b&i=${model.id}&b=${model.desc}', 'GET');">Remove</a>
    </c:if>
</c:if>
<c:if test="${model.activity=='c'}">
    <label class="col-sm-5 control-label" for="orgname">${model.respMessage}</label>
    <script>
        if (${model.resp==true}) {
            alert('Successfully Deleted Description!');
            ajaxSubmitData('entityDescSetting.htm', 'descContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        } else {
            alert('Description Not Deleted!');
        }
    </script>
</c:if>