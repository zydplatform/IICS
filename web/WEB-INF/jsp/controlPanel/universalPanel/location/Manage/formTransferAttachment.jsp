<%-- 
    Document   : formTransferAttachment
    Created on : June 29, 2018, 4:33:26 PM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>
<script>
    function clearLocSelect(act) {
        if (act == 'region') {
            document.getElementById('districtlist').value = 0;
            document.getElementById('countylist').value = 0;
            document.getElementById('subcountylist').value = 0;
            document.getElementById('parishlist').value = 0;
            document.getElementById('villagelist').value = 0;
        }
        if (act == 'district') {
            document.getElementById('countylist').value = 0;
            document.getElementById('subcountylist').value = 0;
            document.getElementById('parishlist').value = 0;
            document.getElementById('villagelist').value = 0;
        }
        if (act == 'county') {
            document.getElementById('subcountylist').value = 0;
            document.getElementById('parishlist').value = 0;
            document.getElementById('villagelist').value = 0;
        }
        if (act == 'subcounty') {
            document.getElementById('parishlist').value = 0;
            document.getElementById('villagelist').value = 0;
        }
        if (act == 'parish') {
            document.getElementById('villagelist').value = 0;
        }
    }
</script>
<c:if test="${model.activity=='r'}">

</c:if>
<c:if test="${model.activity=='d'}">
    <legend>
        Transfer Selected ${model.title} To New Location
    </legend>
    <div id="locationSearchTerms">
        <c:if test="${model.term=='county'}">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="control-label">
                            Region <span class="symbol required"></span>
                        </label>
                        <select class="form-control" id="region" name="region" id="regionidlist" name="regionid" 
                                onChange="clearLocSelect('region');
                                        if (this.value == 0) {
                                            return false;
                                        }
                                        ajaxSubmitData('locations/searchTransferLoc.htm', 'districtDivx', 'act=v1d&st=${model.term}&v1=' + this.value + '&v2=0', 'GET');">
                            <option value="0">--Select Region--</option>
                            <c:forEach items="${model.regionsList}" var="regions">                                
                                <option value="${regions[0]}">${regions[1]}</option>
                            </c:forEach>
                        </select> 
                    </div>  
                    <div class="form-group">
                        <label class="control-label">
                            District <span class="symbol required"></span>
                        </label>
                        <div id="districtDivx">
                            <select class="form-control" name="district" id="districtlist"  
                                    <option value="0">--Select District--</option>
                            </select> 
                        </div>    
                    </div>

                    <div class="form-group">
                        <label class="control-label">
                            County <span class="symbol required"></span>
                        </label>
                        <div id="countyDivx">
                            <select class="form-control" name="county" id="countylist"  
                                    <option value="0">--Select County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Sub-County <span class="symbol required"></span>
                        </label>
                        <div id="subcountyDivx">
                            <select class="form-control" name="subcounty" id="subcountylist"  
                                    <option value="0">--Select Sub-County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Parish <span class="symbol required"></span>
                        </label>
                        <div id="parishDivx">
                            <select class="form-control" name="parish" id="parishlist">  
                                <option value="0">--Select Parish--</option>
                            </select> 
                        </div>
                        <input type="hidden" id="villagelist"/>
                    </div>      
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-4">
                    <div class="form-group"><label class="control-label">Previous Region:</label> ${model.location[2]}</div>
                    <div class="form-group"><label class="control-label">Previous District:</label> ${model.location[1]}</div>

                </div>    
            </div>

        </c:if>
        <c:if test="${model.term!='county'}">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="control-label">
                            Region <span class="symbol required"></span>
                        </label>
                        <select class="form-control" id="region" name="region" id="regionidlist" name="regionid" 
                                onChange="clearLocSelect('region');
                                        if (this.value == 0) {
                                            return false;
                                        }
                                        ajaxSubmitData('locations/searchTransferLoc.htm', 'districtDivx', 'act=v1d&st=${model.term}&v1=' + this.value + '&v2=0', 'GET');">
                            <option value="0">--Select Region--</option>
                            <c:forEach items="${model.regionsList}" var="regions">                                
                                <option value="${regions[0]}">${regions[1]}</option>
                            </c:forEach>
                        </select> 
                    </div>  
                    <div class="form-group">
                        <label class="control-label">
                            District <span class="symbol required"></span>
                        </label>
                        <div id="districtDivx">
                            <select class="form-control" name="district" id="districtlist"  
                                    <option value="0">--Select District--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            County <span class="symbol required"></span>
                        </label>
                        <div id="countyDivx">
                            <select class="form-control" name="county" id="countylist"  
                                    <option value="0">--Select County--</option>
                            </select> 
                        </div>    
                    </div>

                    <div class="form-group">
                        <label class="control-label">
                            Sub-County <span class="symbol required"></span>
                        </label>
                        <div id="subcountyDivx">
                            <select class="form-control" name="subcounty" id="subcountylist"  
                                    <option value="0">--Select Sub-County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Parish <span class="symbol required"></span>
                        </label>
                        <div id="parishDivx">
                            <select class="form-control" name="parish" id="parishlist"  
                                    <option value="0">--Select Parish--</option>
                            </select> 
                        </div>
                    </div> 
                    <div class="form-group">
                        <label class="control-label">
                            Village <span class="symbol required"></span>
                        </label>
                        <div id="villageDivx">
                            <select class="form-control" name="village" id="villagelist"  
                                    <option value="0">--Select VIllage--</option>
                            </select> 
                        </div>    
                    </div>      
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-4">
                    <div class="form-group"><label class="control-label">Previous Region:</label> ${model.location[2]}</div>
                    <div class="form-group"><label class="control-label">Previous District:</label> ${model.location[1]}</div>

                </div>    
            </div>                
        </c:if>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <input type="button" value="${model.btn}" class='btn btn-primary' onClick="
                            if (${model.term!='county'} && document.getElementById('countylist').value == 0) {
                                alert('Select ${model.title} Transfer Destination!');
                                return false;
                            }
                            if (${model.term=='village'} && document.getElementById('districtlist').value == 0) {
                                alert('Select District For ${model.title} Transfer Destination!');
                                return false;
                            }
                            if (document.getElementById('districtlist').value ==${model.location[0]}) {
                                alert('Change District!');
                                return false;
                            }
                            var resp = confirm('Transfer Selected ${model.title}?');
                            if (resp == false) {
                                return false;
                            }
                            ajaxSubmitData('locations/searchDistictTransferLoc.htm', 'formDiv', $('#submitForm').serialize(), 'POST');"/>
                </div>
            </div>
        </div>

    </div>

</c:if>
<c:if test="${model.activity=='p'}">
    <legend>
        Transfer Selected ${model.title} To New Location
    </legend>
    <div id="locationSearchTerms">
        <c:if test="${model.term=='village'}">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="control-label">
                            Region <span class="symbol required"></span>
                        </label>
                        <select class="form-control" id="region" name="region" id="regionidlist" name="regionid" 
                                onChange="clearLocSelect('region');
                                        if (this.value == 0) {
                                            return false;
                                        }
                                        ajaxSubmitData('locations/searchTransferLoc.htm', 'districtDivx', 'act=v1d&st=${model.term}&v1=' + this.value + '&v2=0', 'GET');">
                            <option value="0">--Select Region--</option>
                            <c:forEach items="${model.regionsList}" var="regions">                                
                                <option value="${regions[0]}">${regions[1]}</option>
                            </c:forEach>
                        </select> 
                    </div>  
                    <div class="form-group">
                        <label class="control-label">
                            District <span class="symbol required"></span>
                        </label>
                        <div id="districtDivx">
                            <select class="form-control" name="district" id="districtlist"  
                                    <option value="0">--Select District--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            County <span class="symbol required"></span>
                        </label>
                        <div id="countyDivx">
                            <select class="form-control" name="county" id="countylist"  
                                    <option value="0">--Select County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Sub-County <span class="symbol required"></span>
                        </label>
                        <div id="subcountyDivx">
                            <select class="form-control" name="subcounty" id="subcountylist"  
                                    <option value="0">--Select Sub-County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Parish <span class="symbol required"></span>
                        </label>
                        <div id="parishDivx">
                            <select class="form-control" name="parish" id="parishlist">  
                                <option value="0">--Select Parish--</option>
                            </select> 
                        </div>
                        <input type="hidden" id="villagelist"/>
                    </div>        
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-4">
                    <div class="form-group"><label class="control-label">Previous Region:</label> ${model.location[5]}</div>
                    <div class="form-group"><label class="control-label">Previous District:</label> ${model.location[4]}</div>
                    <div class="form-group"><label class="control-label">Previous County:</label> ${model.location[3]}</div>
                    <div class="form-group"><label class="control-label">Previous Sub-County:</label> ${model.location[2]}</div>
                    <div class="form-group"><label class="control-label">Previous Parish:</label> ${model.location[1]}</div>
                </div>    
            </div>

        </c:if>
        <c:if test="${model.term!='village'}">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="control-label">
                            Region <span class="symbol required"></span>
                        </label>
                        <select class="form-control" id="region" name="region" id="regionidlist" name="regionid" 
                                onChange="clearLocSelect('region');
                                        if (this.value == 0) {
                                            return false;
                                        }
                                        ajaxSubmitData('locations/searchTransferLoc.htm', 'districtDivx', 'act=v1d&st=${model.term}&v1=' + this.value + '&v2=0', 'GET');">
                            <option value="0">--Select Region--</option>
                            <c:forEach items="${model.regionsList}" var="regions">                                
                                <option value="${regions[0]}">${regions[1]}</option>
                            </c:forEach>
                        </select> 
                    </div>  
                    <div class="form-group">
                        <label class="control-label">
                            District <span class="symbol required"></span>
                        </label>
                        <div id="districtDivx">
                            <select class="form-control" name="district" id="districtlist"  
                                    <option value="0">--Select District--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            County <span class="symbol required"></span>
                        </label>
                        <div id="countyDivx">
                            <select class="form-control" name="county" id="countylist"  
                                    <option value="0">--Select County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Sub-County <span class="symbol required"></span>
                        </label>
                        <div id="subcountyDivx">
                            <select class="form-control" name="subcounty" id="subcountylist"  
                                    <option value="0">--Select Sub-County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Parish <span class="symbol required"></span>
                        </label>
                        <div id="parishDivx">
                            <select class="form-control" name="parish" id="parishlist"  
                                    <option value="0">--Select Parish--</option>
                            </select> 
                        </div>
                    </div> 
                    <div class="form-group">
                        <label class="control-label">
                            Village <span class="symbol required"></span>
                        </label>
                        <div id="villageDivx">
                            <select class="form-control" name="village" id="villagelist"  
                                    <option value="0">--Select VIllage--</option>
                            </select> 
                        </div>    
                    </div>        
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-4">
                    <div class="form-group"><label class="control-label">Previous Region:</label> ${model.location[5]}</div>
                    <div class="form-group"><label class="control-label">Previous District:</label> ${model.location[4]}</div>
                    <div class="form-group"><label class="control-label">Previous County:</label> ${model.location[3]}</div>
                    <div class="form-group"><label class="control-label">Previous Sub-County:</label> ${model.location[2]}</div>
                    <div class="form-group"><label class="control-label">Previous Parish:</label> ${model.location[1]}</div>
                    <div class="form-group"><label class="control-label">Previous Parish:</label> ${model.location[1]}</div>
                </div>    
            </div>                
        </c:if>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <input type="button" value="${model.btn}" class='btn btn-primary' onClick="
                            if (${model.term!='village'} && document.getElementById('villagelist').value == 0) {
                                alert('Select ${model.title} Transfer Destination!');
                                return false;
                            }
                            if (${model.term=='village'} && document.getElementById('parishlist').value == 0) {
                                alert('Select Parish For ${model.title} Transfer Destination!');
                                return false;
                            }
                            if (document.getElementById('parishlist').value ==${model.location[0]}) {
                                alert('Change Parish!');
                                return false;
                            }
                            var resp = confirm('Transfer Selected ${model.title}?');
                            if (resp == false) {
                                return false;
                            }
                            ajaxSubmitData('locations/searchTransferLoc.htm', 'formDiv', $('#submitForm').serialize(), 'POST');"/>
                </div>
            </div>
        </div>

    </div>
</c:if>

<c:if test="${model.activity=='c'}">
    <legend>
        Transfer Selected ${model.title} To New Location
    </legend>
    <div id="locationSearchTerms">
        <c:if test="${model.term=='subcounty'}">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="control-label">
                            Region <span class="symbol required"></span>
                        </label>
                        <select class="form-control" id="region" name="region" id="regionidlist" name="regionid" 
                                onChange="clearLocSelect('region');
                                        if (this.value == 0) {
                                            return false;
                                        }
                                        ajaxSubmitData('locations/searchTransferLoc.htm', 'districtDivx', 'act=v1d&st=${model.term}&v1=' + this.value + '&v2=0', 'GET');">
                            <option value="0">--Select Region--</option>
                            <c:forEach items="${model.regionsList}" var="regions">                                
                                <option value="${regions[0]}">${regions[1]}</option>
                            </c:forEach>
                        </select> 
                    </div>  
                    <div class="form-group">
                        <label class="control-label">
                            District <span class="symbol required"></span>
                        </label>
                        <div id="districtDivx">
                            <select class="form-control" name="district" id="districtlist"  
                                    <option value="0">--Select District--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            County <span class="symbol required"></span>
                        </label>
                        <div id="countyDivx">
                            <select class="form-control" name="county" id="countylist"  
                                    <option value="0">--Select County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Sub-County <span class="symbol required"></span>
                        </label>
                        <div id="subcountyDivx">
                            <select class="form-control" name="subcounty" id="subcountylist"  
                                    <option value="0">--Select Sub-County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Parish <span class="symbol required"></span>
                        </label>
                        <div id="parishDivx">
                            <select class="form-control" name="parish" id="parishlist">  
                                <option value="0">--Select Parish--</option>
                            </select> 
                        </div>
                        <input type="hidden" id="villagelist"/>
                    </div>        
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-4">
                    <div class="form-group"><label class="control-label">Previous Region:</label> ${model.location[3]}</div>
                    <div class="form-group"><label class="control-label">Previous District:</label> ${model.location[2]}</div>
                    <div class="form-group"><label class="control-label">Previous County:</label> ${model.location[1]}</div>
                    
                </div>    
            </div>

        </c:if>
        <c:if test="${model.term!='subcounty'}">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="control-label">
                            Region <span class="symbol required"></span>
                        </label>
                        <select class="form-control" id="region" name="region" id="regionidlist" name="regionid" 
                                onChange="clearLocSelect('region');
                                        if (this.value == 0) {
                                            return false;
                                        }
                                        ajaxSubmitData('locations/searchTransferLoc.htm', 'districtDivx', 'act=v1d&st=${model.term}&v1=' + this.value + '&v2=0', 'GET');">
                            <option value="0">--Select Region--</option>
                            <c:forEach items="${model.regionsList}" var="regions">                                
                                <option value="${regions[0]}">${regions[1]}</option>
                            </c:forEach>
                        </select> 
                    </div>  
                    <div class="form-group">
                        <label class="control-label">
                            District <span class="symbol required"></span>
                        </label>
                        <div id="districtDivx">
                            <select class="form-control" name="district" id="districtlist"  
                                    <option value="0">--Select District--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            County <span class="symbol required"></span>
                        </label>
                        <div id="countyDivx">
                            <select class="form-control" name="county" id="countylist"  
                                    <option value="0">--Select County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Sub-County <span class="symbol required"></span>
                        </label>
                        <div id="subcountyDivx">
                            <select class="form-control" name="subcounty" id="subcountylist"  
                                    <option value="0">--Select Sub-County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Parish <span class="symbol required"></span>
                        </label>
                        <div id="parishDivx">
                            <select class="form-control" name="parish" id="parishlist"  
                                    <option value="0">--Select Parish--</option>
                            </select> 
                        </div>
                    </div> 
                    <div class="form-group">
                        <label class="control-label">
                            Village <span class="symbol required"></span>
                        </label>
                        <div id="villageDivx">
                            <select class="form-control" name="village" id="villagelist"  
                                    <option value="0">--Select VIllage--</option>
                            </select> 
                        </div>    
                    </div>        
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-4">
                    <div class="form-group"><label class="control-label">Previous Region:</label> ${model.location[3]}</div>
                    <div class="form-group"><label class="control-label">Previous District:</label> ${model.location[2]}</div>
                    <div class="form-group"><label class="control-label">Previous County:</label> ${model.location[1]}</div>
                    
                </div>    
            </div>                
        </c:if>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <input type="button" value="${model.btn}" class='btn btn-primary' onClick="
                            if (${model.term!='subcounty'} && document.getElementById('subcountylist').value == 0) {
                                alert('Select ${model.title} Transfer Destination!');
                                return false;
                            }
                            if (${model.term=='subcounty'} && document.getElementById('countylist').value == 0) {
                                alert('Select County For ${model.title} Transfer Destination!');
                                return false;
                            }
                            if (document.getElementById('countylist').value ==${model.location[0]}) {
                                alert('Change County!');
                                return false;
                            }
                            var resp = confirm('Transfer Selected ${model.title}?');
                            if (resp == false) {
                                return false;
                            }
                            ajaxSubmitData('locations/searchCountyTransfer.htm', 'formDiv', $('#submitForm').serialize(), 'POST');"/>
                </div>
            </div>
        </div>

    </div>
</c:if>




<c:if test="${model.activity=='sc'}">
    <legend>
        Transfer Selected :: ${model.title} To New Location
    </legend>
    <div id="locationSearchTerms">
        <c:if test="${model.term=='parish'}">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="control-label">
                            Region <span class="symbol required"></span>
                        </label>
                        <select class="form-control" id="region" name="region" id="regionidlist" name="regionid" 
                                onChange="clearLocSelect('region');
                                        if (this.value == 0) {
                                            return false;
                                        }
                                        ajaxSubmitData('locations/searchTransferLoc.htm', 'districtDivx', 'act=v1d&st=${model.term}&v1=' + this.value + '&v2=0', 'GET');">
                            <option value="0">--Select Region--</option>
                            <c:forEach items="${model.regionsList}" var="regions">                                
                                <option value="${regions[0]}">${regions[1]}</option>
                            </c:forEach>
                        </select> 
                    </div>  
                    <div class="form-group">
                        <label class="control-label">
                            District <span class="symbol required"></span>
                        </label>
                        <div id="districtDivx">
                            <select class="form-control" name="district" id="districtlist"  
                                    <option value="0">--Select District--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            County <span class="symbol required"></span>
                        </label>
                        <div id="countyDivx">
                            <select class="form-control" name="county" id="countylist"  
                                    <option value="0">--Select County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Sub-County <span class="symbol required"></span>
                        </label>
                        <div id="subcountyDivx">
                            <select class="form-control" name="subcounty" id="subcountylist"  
                                    <option value="0">--Select Sub-County--</option>
                            </select> 
                        </div>    
                    </div>

                    <div class="form-group">
                        <label class="control-label">
                            Parish <span class="symbol required"></span>
                        </label>
                        <div id="parishDivx">
                            <select class="form-control" name="parish" id="parishlist">  
                                <option value="0">--Select Parish--</option>
                            </select> 
                        </div>
                        <input type="hidden" id="villagelist"/>
                    </div>      
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-4">
                    <div class="form-group"><label class="control-label">Previous Region:</label> ${model.location[4]}</div>
                    <div class="form-group"><label class="control-label">Previous District:</label> ${model.location[3]}</div>
                    <div class="form-group"><label class="control-label">Previous County:</label> ${model.location[2]}</div>
                    <div class="form-group"><label class="control-label">Previous Sub-County:</label> ${model.location[1]}</div>


                </div>    
            </div>

        </c:if>
        <c:if test="${model.term!='parish'}">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="control-label">
                            Region <span class="symbol required"></span>
                        </label>
                        <select class="form-control" id="region" name="region" id="regionidlist" name="regionid" 
                                onChange="clearLocSelect('region');
                                        if (this.value == 0) {
                                            return false;
                                        }
                                        ajaxSubmitData('locations/searchTransferLoc.htm', 'districtDivx', 'act=v1d&st=${model.term}&v1=' + this.value + '&v2=0', 'GET');">
                            <option value="0">--Select Region--</option>
                            <c:forEach items="${model.regionsList}" var="regions">                                
                                <option value="${regions[0]}">${regions[1]}</option>
                            </c:forEach>
                        </select> 
                    </div>  
                    <div class="form-group">
                        <label class="control-label">
                            District <span class="symbol required"></span>
                        </label>
                        <div id="districtDivx">
                            <select class="form-control" name="district" id="districtlist"  
                                    <option value="0">--Select District--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            County <span class="symbol required"></span>
                        </label>
                        <div id="countyDivx">
                            <select class="form-control" name="county" id="countylist"  
                                    <option value="0">--Select County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Sub-County <span class="symbol required"></span>
                        </label>
                        <div id="subcountyDivx">
                            <select class="form-control" name="subcounty" id="subcountylist"  
                                    <option value="0">--Select Sub-County--</option>
                            </select> 
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="control-label">
                            Parish <span class="symbol required"></span>
                        </label>
                        <div id="parishDivx">
                            <select class="form-control" name="parish" id="parishlist"  
                                    <option value="0">--Select Parish--</option>
                            </select> 
                        </div>
                    </div> 

                    <div class="form-group">
                        <label class="control-label">
                            Village <span class="symbol required"></span>
                        </label>
                        <div id="villageDivx">
                            <select class="form-control" name="village" id="villagelist"  
                                    <option value="0">--Select VIllage--</option>
                            </select> 
                        </div>    
                    </div>      
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-4">
                    <div class="form-group"><label class="control-label">Previous Region:</label> ${model.location[4]}</div>
                    <div class="form-group"><label class="control-label">Previous District:</label> ${model.location[3]}</div>
                    <div class="form-group"><label class="control-label">Previous County:</label> ${model.location[2]}</div>
                    <div class="form-group"><label class="control-label">Previous Sub-County:</label> ${model.location[1]}</div>

                </div>    
            </div>                
        </c:if>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <input type="button" value="${model.btn}" class='btn btn-primary' onClick="
                            if (${model.term!='parish'} && document.getElementById('parishlist').value == 0) {
                                alert('Select ${model.title} Transfer Destination!');
                                return false;
                            }
                            if (${model.term=='parish'} && document.getElementById('subcountylist').value == 0) {
                                alert('Select Subcounty For ${model.title} Transfer Destination!');
                                return false;
                            }
                            if (document.getElementById('subcountylist').value ==${model.location[0]}) {
                                alert('Change Subcounty!');
                                return false;
                            }
                            var resp = confirm('Transfer Selected ${model.title}?');
                            if (resp == false) {
                                return false;
                            }
                            ajaxSubmitData('locations/searchSubcountyTransfer.htm', 'formDiv', $('#submitForm').serialize(), 'POST');"/>
                </div>
            </div>
        </div>

    </div>
</c:if>


<c:if test="${model.activity=='v1d'}">
    <select onchange="clearLocSelect('district');
            if (this.value == 0) {
                return false;
            }
            if (document.getElementById('activity').value == 'd' && this.value == document.getElementById('id').value) {
                alert('Transfer Requires Change Of District!');
                this.value = 0;
                return false;
            }
            ${model.link}" class="form-control" id="districtlist" name="districtid">
        <option value="0">--Select District--</option>
        <c:forEach items="${model.districtList}" var="par">
            <option value="${par[0]}">${par[1]}</option>
        </c:forEach>
    </select>
</c:if>
<c:if test="${model.activity=='v1c'}">
    <select onchange="clearLocSelect('county');
            if (this.value == 0) {
                return false;
            }
            if (document.getElementById('activity').value == 'c' && this.value == document.getElementById('id').value) {
                alert('Transfer Requires Change Of County!');
                this.value = 0;
                return false;
            }
            ${model.link}" class="form-control" id="countylist" name="countyid">
        <option value="0">--Select County--</option>
        <c:forEach items="${model.countyList}" var="par">
            <option value="${par[0]}">${par[1]}</option>
        </c:forEach>
    </select>
</c:if>
<c:if test="${model.activity=='v1sc'}">
    <select onchange="clearLocSelect('subcounty');
            if (this.value == 0) {
                return false;}
            if (document.getElementById('activity').value == 'sc' && this.value == document.getElementById('id').value) {
                alert('Transfer Requires Change Of Sub County!');
                this.value = 0;
                return false;
            }
            ${model.link}" class="form-control" id="subcountylist" name="subcountyid">
        <option value="0">--Select Sub-County--</option>
        <c:forEach items="${model.subcountyList}" var="par">
            <option value="${par[0]}">${par[1]}</option>
        </c:forEach>
    </select>
</c:if>
<c:if test="${model.activity=='v1p'}">
    <select onchange="clearLocSelect('parish');
            if (this.value == 0) {
                return false;
            }
            if (document.getElementById('activity').value == 'p' && this.value == document.getElementById('id').value) {
                alert('Transfer Requires Change Of Parish!');
                this.value = 0;
                return false;
            }
            ${model.link}" class="form-control" id="parishlist" name="parishid">
        <option value="0">--Select Parish--</option>
        <c:forEach items="${model.parishList}" var="par">
            <option value="${par[0]}">${par[1]}</option>
        </c:forEach>
    </select>
</c:if>
<c:if test="${model.activity=='v1v'}">
    <select onchange="if (this.value == 0) {
                return false;
            }
            if (document.getElementById('activity').value == 'v' && this.value == document.getElementById('id').value) {
                alert('Transfer Requires Change Of Location!');
                this.value = 0;
            }" class="form-control" id="villagelist" name="villageid">
        <option value="0">--Select Village--</option>
        <c:forEach items="${model.villageList}" var="par">
            <option value="${par[0]}">${par[1]}</option>
        </c:forEach>
    </select>
</c:if>