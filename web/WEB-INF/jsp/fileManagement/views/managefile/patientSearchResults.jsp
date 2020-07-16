
<%@include file="../../../include.jsp"%>
<div class="row">
    
</div>
<c:if test="${not empty patients}">
    <ul class="items scrollbar" id="patientSearchScroll">
        <c:forEach items="${patients}" var="p">
            <li class="classItem" onclick='setPatientNumber("${p.patientid}","${p.firstname} ${p.lastname} ${p.othernames}" )'>
                <div>
                    <div class="partientsearchcard">
                        <div class="row">
                        <div class="firstinfo col-md-6">
                        <input type="hidden" value="${p.firstname} ${p.lastname} ${p.othernames}"/>
                           <img src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/48.jpg"/>&nbsp;&nbsp;&nbsp;
                            <div class="profileinfo">
                                <h7 style="font-weight: bolder">
                                    <span style="color: graytext">NAME:</span>
                                    <span style="color: blueviolet; text-transform: uppercase;">${p.firstname} ${p.lastname} ${p.othernames}</span>
                                </h7></div>
                        </div>
                    </div>
                     </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty patients}">
  <p class="center consentForm">
      <br>
        <span class="">Results For  <span style="color: black !important; text-decoration: underline">${name}</span> Not found.<br>
  </p>
</c:if>
  
    <script>
         $(document).ready(function () {
        
          });
function setPatientNumber(patientid,name) {
        $('#patientSearch').val(name);
        $('#patientNo').val(patientid);
        }
    </script>