<%-- 
    Document   : manageDistrict
    Created on : Aug 13, 2018, 3:58:55 PM
    Author     : Uwera
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<h4 class="tile-title">Manage ${model.dbaction} Action On : ${model.activity}</h4>

<c:if test="${model.dbaction=='Update' || model.dbaction=='Transfer'}">
    <div class="row" id="content2">
        <div class="col-md-6">
            <div class="tile">
                <h4 class="tile-title">Previous Information</h4>
                <div class="tile-body">
                        <div class="form-group">
                            <label class="control-label">Previous Region</label>
                            <input class="form-control" id="prevRegion" name="prevRegion" type="text" placeholder="Previous Region" readonly="readonly" value="${model.audObj[15]}">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Previous District</label>
                            <input class="form-control" id="prevDistrict" name="prevDistrict" type="text" placeholder="Previous District" readonly="readonly" value="${model.audObj[14]}">
                             <input type="hidden" name="prevLocation" value="${model.audObj[23]}"/>
                        </div>
                        
                        
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="tile">
                <h4 class="tile-title">Current Information</h4>
                    <div class="form-group">
                        <label class="control-label">Current Region</label>
                        <input class="form-control" id="curRegion" name="curRegion" type="text" placeholder="Current Region" readonly="readonly" value="${model.audObj[21]}">
                    </div>
                    <div class="form-group">
                        <label class="control-label">Current District</label>
                        <input class="form-control" id="curDistrict" name="curDistrict" type="text" placeholder="Current District" readonly="readonly" value="${model.audObj[20]}">
                         <input type="hidden" name="curLocation" value="${model.audObj[22]}"/>
                    </div>
                   
            </div>
        </div>
        <div class="col-md-12 right">
            <button class="btn btn-primary right" id="revertAction" type="button" onClick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=f&i=${model.audObj[0]}&b=a&c=a&d=${model.audObj[22]}&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');">
                <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                Revert ${model.dbaction}
            </button>
            
            <button class="btn btn-primary right" id="confirmAction" type="button" onClick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=g&i=${model.audObj[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');">
                <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                Confirm ${model.dbaction}
            </button>
        </div>
    </div>
</c:if>
<c:if test="${model.dbaction=='Delete'}">
    <div class="row" id="content2">
        <div class="col-md-6" left>
            <div class="tile">
                <h4 class="tile-title">Previous Information</h4>
                <div class="tile-body">
                        <div class="form-group">
                            <label class="control-label">Previous Region</label>
                            <input class="form-control" id="prevRegion" name="prevRegion" type="text" placeholder="Previous Region" readonly="readonly" value="${model.audObj[15]}">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Previous District</label>
                            <input class="form-control" id="prevDistrict" name="prevDistrict" type="text" placeholder="Previous District" readonly="readonly" value="${model.audObj[14]}">
                             <input type="hidden" name="prevLocation" value="${model.audObj[16]}"/>
                        </div>
                      </div>
            </div>
   </div>
         <div class="col-md-12 left">
            <button class="btn btn-primary right" id="revertAction" type="button" onClick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=f&i=${model.audObj[0]}&b=a&c=a&d=${model.audObj[16]}&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');">
                <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                Re instate ${model.dbaction}
            </button>
            <button class="btn btn-primary left" id="confirmAction" type="button" onClick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=g&i=${model.audObj[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');">
                <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                Confirm ${model.dbaction}
            </button>
        </div>
    </div>
     
    
</c:if>