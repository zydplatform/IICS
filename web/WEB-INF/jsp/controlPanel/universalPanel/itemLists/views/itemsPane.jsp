<%-- 
    Document   : itemsPane
    Created on : Mar 21, 2018, 9:45:32 PM
    Author     : IICS
--%>

<%@include file="../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<main id="main">
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEITEMCATEGORISATION')"> </security:authorize>
    <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
    <label class="tabLabels" for="tab1">Item Categorization</label>
  <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEITEMDOSAGE')"></security:authorize>
        <input id="tab2" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab2">Dosage Form</label>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEITEMDOSAGEADMINISTRATION')"> </security:authorize>
        <input id="tab3" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab3">Drug Administration Route</label>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_ADDCATALOGUEITEM')"></security:authorize>
        <input id="tab4" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab4">Items</label>
        <section class="tabContent" id="content1">
            <div>
            <%@include file="categorisation.jsp" %>
        </div>
    </section>
    <section class="tabContent" id="content2">
        <div>
            <%@include file="itemDosage.jsp" %>
        </div>
    </section>
    <section class="tabContent" id="content3">
        <div>
            <div>
                <%@include file="admintypes.jsp" %>
            </div>
        </div>
    </section>
    <section class="tabContent" id="content4">
        <div>
            <%@include file="items.jsp" %>
        </div>
    </section>
</main>