<%-- 
    Document   : response
    Created on : May 15, 2018, 12:22:39 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="panel-body">
    <div class="table-responsive">
        <c:if test="${model.resp==true}">
            <h2>${model.successMessage}</h2>
        </c:if>
        <c:if test="${model.resp==false}">
            <h2>Sorry, Save Failed  <br/> 
                ${model.errorMessage}
            </h2>
        </c:if>

        <c:if test="${model.mainActivity=='Hierarchy'}">
            <c:if test="${not empty model.orgList}">   
                <table class="table table-bordered table-hover" id="sample-table-1">
                    <thead>
                        <tr>
                            <th class="center"></th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${model.hyrchList}" var="list" varStatus="status" begin="0" end="${model.size}">
                            <tr>
                                <td align="left">&nbsp;</td>
                                <td align="left">${list.hierachylabel}</td>
                                <td align="left">${list.description}</td>                                            
                                <td align="center"><c:if test="${list.active==true}">Active</c:if><c:if test="${list.active==false}">Disabled</c:if></td>
                                </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </c:if>
        <c:if test="${model.mainActivity=='Discard Nodes'}">
            <fieldset style="width:95%; margin: 0 auto;" >
                <legend> 
                    <div style="float:left" align="left"><a id="back" href="#"  onClick="ajaxSubmitData('facilityUnitSetUp.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a></div>
                    &nbsp;&nbsp;&nbsp;
                    Details For Hierarchy Node Under: ${model.facObj.facilityname}
                </legend>
                <c:if test="${not empty model.structureList}">   
                    <table class="table table-bordered table-hover" id="sample-table-1">
                        <thead>
                            <tr>
                                <th class="center"></th>
                                <th>Name</th>
                                <th>Description</th>
                                    <c:if test="${model.deletedObjState==false}">
                                    <th>Attached Nodes</th>
                                    </c:if>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${model.structureList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                <tr>
                                    <td align="left">&nbsp;</td>
                                    <td align="left">${list.hierachylabel}</td>
                                    <td align="left">${list.description}</td>
                                    <c:if test="${model.deletedObjState==false}">
                                        <td align="left">${list.units}</td>
                                    </c:if>
                                    <td align="center"><c:if test="${list.active==true}">Active</c:if><c:if test="${list.active==false}">Disabled</c:if></td>
                                    </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </fieldset>
        </c:if>
        
    </div>
</div>