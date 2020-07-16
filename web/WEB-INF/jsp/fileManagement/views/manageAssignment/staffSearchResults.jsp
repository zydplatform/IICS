
<%@include file="../../../include.jsp"%>
<c:if test="${not empty staff}">
    <ul class="items scrollbar" id="patientSearchScroll">
        <c:forEach items="${staff}" var="p">
            <li class="classItem" onclick="viewStaffDetails('${p.staffid}')">
                <div>
                    <div class="partientsearchcard"><div class="row">
                            <div class="firstinfo col-md-6">
                                <img src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/48.jpg"/>&nbsp;&nbsp;&nbsp;
                                <div class="profileinfo">
                                    <h7 style="font-weight: bolder">
                                        <span style="color: graytext">NAME:</span>
                                        <span style="color: blueviolet; text-transform: uppercase;">${p.firstname} ${p.lastname}</span>
                                    </h7>
                                    <br>
                                </div>
                            </div></div>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty staff}">
    <p class="center consentForm">
        <br>
        <span class="">Results For <span style="color: black !important; text-decoration: underline">${name}</span> Not found.<br>
            </p>
        </c:if>
        <script>
            function viewStaffDetails(staffid) {
                $.ajax({
                    type: "GET",
                    cache: false,
                    url: "fileassignment/retrievestaffdetails.htm",
                    data: {staffid: staffid},
                    success: function (response) {
                        $('#staffDetails').html(response);
                    }
                });
            }
        </script>