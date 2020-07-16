<%-- 
    Document   : addNewItemPack
    Created on : Aug 22, 2018, 7:06:32 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<form action="" class="formName">
    <div class="form-group">
        <label>Select Description.</label>
        <select class="form-control selectItemPack">
            <option value="select">----select------</option>
            <c:forEach items="${PackagesFound}" var="a">
                 <option value="${a.packagesid}">${a.packagename}</option>
            </c:forEach>
        </select>
    </div>
    <div class="form-group">
        <label>Enter Size.</label>
        <input type="text" placeholder="Enter Size" class="itempacksizes form-control" required />
    </div>
<!--     <div class="form-group">
        <label>Select Unit Of Measure.</label>
        <select class="form-control selectUnitOfMeasure">
            <option value="select">----select------</option>
            <option value="Tablet">Tablet</option>
            <option value="Bottle">Bottle</option>
        </select>
    </div>-->
</form>
