<%-- 
    Document   : serviceMain
    Created on : Jul 17, 2018, 6:53:03 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset>
    <legend>Setup/Manage Facility Unit Services</legend>

    <div class="row" id="service-content">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <c:if test="${not empty  model.serviceList}">
                        <form id="manageGridView" name="manageGridView">

                            <!-- start: DYNAMIC TABLE PANEL -->
                            <table class="table table-hover table-bordered" id="serviceGridView">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Service Name</th> 
                                        <th>Description</th>
                                        <th>Units Assigned</th> 
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="count" value="1"/>
                                    <c:set var="No" value="0" />
                                    <c:forEach items="${model.serviceList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                        <c:choose>
                                            <c:when test="${status.count % 2 != 0}">
                                                <tr>
                                                </c:when>
                                                <c:otherwise>
                                                <tr bgcolor="white">
                                                </c:otherwise>
                                            </c:choose>
                                            <td>${status.count}</td>
                                            <td>${list.servicename}</td>
                                            <td>${list.description}</td>
                                            <td align="center">
                                                <!-- 
                                                <c:if test="${list.units == 0}">
                                                    <span data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${list.servicename} Has no units assigned. Please add a service" href="#!" class="btn btn-secondary btn-small center" style="float:left; border-radius: 50%; background-color: red; color: white">
                                                        <span>${list.units}</span>
                                                    </span>
                                                    <button class="btn btn-secondary btn-small center" onclick="ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'service-content', 'act=e&i=${list.serviceid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" id="add${status.count}" style="float: right; background-color: purple; color: white; font-size: 12px; border-radius: 50%;">Add</button>
                                                </c:if>
                                                <c:if test="${list.units > 0}">
                                                    <button class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: green;" data-serviceid="${list.serviceid}" data-servicename="${list.servicename}" id="view${status.count}" onclick="ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'service-content', 'act=f&i=${list.serviceid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">${list.units}</button>
                                                    <button class="btn btn-secondary btn-small center" onclick="ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'service-content', 'act=e&i=${list.serviceid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" id="add${status.count}" style="float: right; background-color: purple; color: white; font-size: 12px; border-radius: 50%;">Add</button>
                                                </c:if>
                                                -->
                                                <span style="float:left">
                                                    <c:if test="${list.units==0}">${list.units}</c:if>
                                                    <c:if test="${list.units>0}"><a href="#" onClick="ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'service-content', 'act=f&i=${list.serviceid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">${list.units}</a></c:if>
                                                </span>
                                                <span style="float:right"><a href="#" onClick="ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'service-content', 'act=e&i=${list.serviceid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Add</a></span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </form>
                    </c:if>
                    <c:if test="${empty model.serviceList}">
                        <div align="center"><h3>No Released Facility Services!</h3></div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<div id="assignedUnits"></div>


<script>
    $(document).ready(function () {
        $('#serviceGridView').DataTable();
    })
</script>