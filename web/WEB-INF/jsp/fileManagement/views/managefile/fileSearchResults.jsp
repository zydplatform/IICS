
<%@include file="../../../include.jsp"%>
<c:if test="${not empty files}">
    <ul class="items scrollbar" id="patientSearchScroll">
        <c:forEach items="${files}" var="p">
            <li class="classItem" onclick='viewPatientFileDetails("${p.fileid}","${p.fileno}","${p.firstname} ${p.lastname} ${p.othernames}","${p.datecreated}","${p.status}","${p.staffid}")'>
                <div>
                    <div class="partientsearchcard">
                        <div class="row">
                        <div class="firstinfo col-md-6">
                        <img src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/48.jpg"/>&nbsp;&nbsp;&nbsp;
                            <div class="profileinfo">
                                <h7 style="font-weight: bolder">
                                    <span style="color: graytext">NAME:<span style="color: blueviolet; text-transform: uppercase;">${p.firstname} ${p.lastname} ${p.othernames}</span>
                                </span>
                               </h7>
                                <br>
                            <span><span style="font-weight: bolder; color: graytext">FILE NO: </span>00${p.fileno}</span><br>
                                </div>
                        </div>
                        </div>
                     </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty files}">
  <p class="center consentForm">
      <br>
        <span class="">Results For  <span style="color: black !important; text-decoration: underline">${name}</span> Not found.<br>
    <i>Click <strong style="color: red !important; text-decoration: underline; cursor: pointer" onclick="ajaxShowNewFormDialog()">Here</strong>To Create A New Patient File</i></span>
  </p>
</c:if>
  