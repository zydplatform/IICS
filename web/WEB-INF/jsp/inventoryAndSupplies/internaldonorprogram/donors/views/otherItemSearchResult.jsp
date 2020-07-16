<%-- 
    Document   : otherItemSearchResult
    Created on : Oct 17, 2018, 7:18:50 AM
    Author     : IICS
--%>

<%@include file="../../../../include.jsp" %>
<input type="hidden" value="${name}" id="otherItemSearchValue"/>
<c:if test="${not empty otherItems}">
    <ul class="items scrollbar" id="patientSearchScroll"> 
        <c:forEach items="${otherItems}" var="o">
            <li class="classItem" onclick="ViewOtherItemDetails(${o.donoritemsid}, '${o.donoritemname}')">
                <div>
                    <div class="">
                        <div class="firstinfo">
                            <input type="hidden" value="${o.donoritemsid}" id="donoritemsidX" />
                            <input type="hidden" value="${o.donoritemname}" id="donoritemnameX"/>
                            <div class="profileinfo">
                                <h7 style="font-weight: bolder"><span style="color: blueviolet; text-transform: uppercase;">${o.donoritemname}</span></h7><br>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty otherItems}">

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
    function ViewOtherItemDetails(donoritemsid, donoritemname) {
        document.getElementById("otheritemid").value = donoritemsid;
        document.getElementById("otheritemname").value = donoritemname;
     
    }

    function Registerdonor(name) {
        document.getElementById('donorinfos').style.display = "none";
        ajaxSubmitData('internaldonorprogram/registerNewDonor', 'donorinfo', 'donorname=' + name + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

    }
</script>
