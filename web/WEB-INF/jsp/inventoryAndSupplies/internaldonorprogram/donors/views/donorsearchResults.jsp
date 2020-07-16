<%-- 
    Document   : donorsearchResults
    Created on : Sep 10, 2018, 1:18:08 PM
    Author     : RESEARCH
--%>

<%@include file="../../../../include.jsp" %>
<input type="hidden" value="${searchValue}" id="donorSearchValue"/>
<c:if test="${not empty donorProgramList}">
    <ul class="items scrollbar" id="patientSearchScroll"> 
        <c:forEach items="${donorProgramList}" var="u">
            <li class="classItem" onclick="Viewdonordetails(${u.donorprogramid}, '${u.donorname}', '${u.emial}', '${u.telno}', '${u.fax}', '${u.donortype}', '${u.origincountry}')">
                <div>
                    <div class="">
                        <div class="firstinfo">
                            <input type="hidden" value="${u.donorprogramid}" id="donorprogramidX" />
                            <input type="hidden" value="${u.donorname}" id="donornameX"/>
                            <input type="hidden" value="${u.emial}" id="emialX"/>
                            <input type="hidden" value="${u.telno}" id="telnoX"/>
                            <input type="hidden" value="${u.fax}" id="faxX"/>
                            <input type="hidden" value="${u.donortype}" id="donortypeX"/>
                            <input type="hidden" value="${u.origincountry}" id="origincountryX"/>
                            <div class="profileinfo">
                                <h7 style="font-weight: bolder"><span style="color: blueviolet; text-transform: uppercase;">${u.donorname}</span></h7><br>
                                <span>${u.emial}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty donorProgramList}">

</c:if>

<div class="row">
    <div class="col-md-12" id="makedonation">
        <div id="makedonations" class="supplierCatalogDialog">
            <div>
                <div id="divSection1">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">MAKE DONATION</h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="makedonationcontent">

                    </div>                                        
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function Viewdonordetails(id, donorname, email, telno, fax, donortype, origincountry) {
        document.getElementById("donorid").value = id;
        document.getElementById("donorprogramname").value = donorname;
        document.getElementById("email").value = email;
        document.getElementById("telno").value = telno;
        document.getElementById("fax").value = fax;
        document.getElementById("originCountry").value = origincountry;

        if (donortype === "Organisation") {
            // Check #x
            $("#organisation").prop("checked", true);
            $("#individual").prop("checked", false);
        }else{
            $("#organisation").prop("checked", false);
            $("#individual").prop("checked", true);
        }
    }

    function Registerdonor(name) {
        document.getElementById('donorinfos').style.display = "none";
        ajaxSubmitData('internaldonorprogram/registerNewDonor', 'donorinfo', 'donorname=' + name + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//        $.ajax({
//            type: "GET",
//            cache: false,
//            url: "internaldonorprogram/registerNewDonor.htm",
//            data: {donorname: name},
//            success: function (data) {
//                $.dialog({
//                    title: '<font color="green">' + '<strong class="center">Register Donor' + '</font>' + '</strong>',
//                    content: '' + data,
//                    boxWidth: '95%',
//                    useBootstrap: false,
//                    type: 'purple',
//                    typeAnimated: true,
//                    closeIcon: true
//
//                });
//            }
//        });
    }
</script>



