<%-- 
    Document   : internalReferrals
    Created on : Oct 26, 2018, 11:56:36 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<fieldset>
    <div class="row">
        <div class="col-md-1">

        </div> 
        <div class="col-md-5">
            <form>
                <div class="form-group row">
                    <label for="referredtounit" class="col-sm-4 col-form-label">Select Unit</label>
                    <div class="col-sm-8">
                        <select  class="form-control referredtounit" required>
                            <option value="select">---Select----</option>
                            <c:forEach items="${unitsFound}" var="a">
                                <option id="facunit${a.facilityunitid}" data-servicedid="${a.facilityunitserviceid}" value="${a.facilityunitid}">${a.facilityunitname}</option> 
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="referredtostaff" class="col-sm-4 col-form-label">Referred To</label>
                    <div class="col-sm-8">
                        <select  class="form-control referredtostaff" required >
                            <option>General</option>
                        </select>
                    </div>
                </div>

            </form> 
        </div>
        <div class="col-md-5">
            <form>
                <div class="form-group row">
                    <label for="referredspecialty" class="col-sm-4 col-form-label">Referred To Specialty</label>
                    <div class="col-sm-8">
                        <select  class="form-control referredspecialty" required >
                            <option>General</option>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="referralnotes" class="col-sm-4 col-form-label">Referral Notes</label>
                    <div class="col-sm-8">
                        <textarea class="referralnotes form-control" placeholder="Enter Referral Notes" rows="4"></textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-md-12 right" >
                        <button type="button" class="btn btn-secondary" onclick="sendinternalrefrral();">
                            <i class="fa fa-share"></i>  Send
                        </button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-1">

        </div>
    </div>   
</fieldset>