<%-- 
    Document   : usersearchresult
    Created on : Jun 1, 2018, 8:02:00 AM
    Author     : user
--%>

<%@include file="../../include.jsp" %>
<input type="hidden" value="${searchValue}" id="patientSearchValue"/>
<c:if test="${not empty user}">
    <ul class="items scrollbar" id="patientSearchScroll">
        <c:forEach items="${user}" var="u">
            <li class="classItem" onclick="Viewuserdetails(${u.staffid}, $(this).attr('data-id'), $(this).attr('data-id1'), $(this).attr('data-id2'))" data-id="${u.firstname}" data-id1="${u.lastname}" data-id2="${u.othernames}">
                <div>
                    <div class="partientsearchcard">
                        <div class="firstinfo">
                            <input type="hidden" value="${u.staffid}" id="staffid" />
                            <input type="hidden" value="${u.staffno}" id="staffno"/>
                            <input type="hidden" value="${u.firstname}" id="firstname"/>
                            <input type="hidden" value="${u.lastname}" id="lastname"/>
                            <input type="hidden" value="${u.othernames}" id="othernames"/>
                            <input type="hidden" value="${u.personid}" id="personid"/>
                            <img src="static/images/profile-picture-placeholder.jpg"/>&nbsp;&nbsp;&nbsp;
                            <div class="profileinfo">
                                <h7 style="font-weight: bolder"><span style="color: graytext">NAME: </span> <span style="color: blueviolet; text-transform: uppercase;">${u.firstname} ${u.lastname} ${u.othernames}</span></h7><br>
                                <span><span style="font-weight: bolder; color: graytext">Staff number:${u.staffno} </span></span><br>

                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty user}">
    <p class="center consentForm">
        <br>
        <span class="">Staff <span style="color: black !important; text-decoration: underline">${name}</span> Not found.<br>
            <i>Click <strong style="color: red !important; text-decoration: underline; cursor: pointer" onclick="Registeruser()">Here</strong> To Register New User</i></span>
    </p>
</c:if>
<script>
    function Viewuserdetails(id, firstname, lastname, othernames) {
        $.confirm({
            title: '' + firstname + ' ' + lastname + ' ' + othernames + 'is already registered!',
            content: 'Would you wish to view/Edit submitted details.',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {
                        $('#Newuserregform').html('');
                        ajaxSubmitData('staffmanager/userdetails.htm', 'Userdetails', 'staffid=' + id + '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                    }
                },
                No: function () {
                }
            }
        });

    }
</script>


