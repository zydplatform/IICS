<%-- 
    Document   : newFileLocationForm
    Created on : Jun 1, 2018, 2:50:14 PM
    Author     : IICS
--%>
<%@include file="../../include.jsp"%>
<div>
    <div id="head">
        <a href="#close" title="Close" class="close2">X</a>
        <h2 class="modalDialog-title">MANAGE STORAGE ASSIGNMENT</h2>
        <hr>
    </div>
    <div class="row scrollbar" id="content">
        <div class="col-md-12">                        
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <form class="form-horizontal">
                                <div id="horizontalwithwords"><span class="pat-form-heading">ASSIGN FILE LOCATION DETAILS</span></div>
                                <div class="form-group row">
                                    <label class="control-label col-md-3" for="storageZones"> Zone Label:</label>
                                    <select class="form-contro col-md-8" id="zoneid">
                                        <option value="" id="getzonelevelid">--Choose ZOne--</option>
                                        <c:forEach items="${zones}" var="zone">
                                            <option value="${zone.zoneid}">${zone.zoneName}</option>
                                        </c:forEach>  
                                    </select>
                                </div>
                                <div class="form-group row">
                                    <label  class="col-md-3"for="cellid">Cell Label</label>
                                    <select class="form-control col-md-8 " id="cellid">
                                    </select>
                                </div>  <div class=" row form-group">
                                    <label class="control-label col-md-8" for=""></label>
                                    <input type="button" value="Add" class="btn  btn-purple " onClick="ajaxSubmitNewLocation('filelocation/newlocation.htm', 'POST');"/>
                                </div>
                            </form>
                        </div>                                        
                    </div>                                                               
                </div>                                
            </div>
        </div>                        
    </div>
</div>