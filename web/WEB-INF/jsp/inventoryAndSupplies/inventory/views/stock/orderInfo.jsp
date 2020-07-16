<%-- 
    Document   : orderInfo
    Created on : Jul 12, 2019, 3:42:37 PM
    Author     : IICS TECHS
--%>

<%@include file="../../../../include.jsp"%>

<div class="row">
    <div class="col-md-12">
        <span><b>Servicing Unit:</b></span>
        <span class="form-control"><c:if test="${servicingunit == ''}">Not Available</c:if> <c:if test="${servicingunit != ''}">${servicingunit}</c:if></span>
        <hr />
        <span><b>Received By:</b></span>
        <span class="form-control"><c:if test="${receivername == ''}">Not Available</c:if> <c:if test="${receivername != ''}">${receivername}</c:if></span>
    </div>
</div>