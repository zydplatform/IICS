<%-- 
    Document   : supplierPane
    Created on : Mar 21, 2018, 9:47:11 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<main id="main">
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEEXTERNALSUPPLIERS')">
        <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
        <label class="tabLabels" for="tab1">Suppliers</label>
    </security:authorize>

    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGESUPPLIERCATALOGUE')">
        <input id="tab2" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab2">Suppliers Catalogue</label>
    </security:authorize>      

        <section class="tabContent" id="content1">
            <div>
            <%@include file="suppliers.jsp" %>
        </div>
    </section>
    <section class="tabContent" id="content2">
        <div>
            <%@include file="supplierCatalog.jsp" %>
        </div>
    </section>
</main>
<script>
    $('#${tab}').click();
</script>