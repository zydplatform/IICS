<%-- 
    Document   : symptoms
    Created on : Oct 23, 2018, 8:30:12 AM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<div class="outputcontent">
    <ol class="custom-bullet custom-bullet--c">
        <c:choose>
            <c:when test="${not empty symptomsFound}">
                <c:forEach items="${symptomsFound}" var="a">
                    <li>&nbsp; <span id="symptoms${a.symptomid}">${a.symptom}</span><span onclick="deleteSymptom(${a.symptomid});" title="Delete Of Symptom."  class="badge badge-danger icon-custom pull-right" style="margin-right: 10px;"><i class="fa fa-times"></i></span></li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                <p class="center">No Patient Symptoms</p>
            </c:otherwise>
        </c:choose>
    </ol>
</div>