<%--
    Document   : patientBasicInfoTriage
    Created on : Aug 31, 2018, 4:14:48 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<!DOCTYPE html>
<div class="card">
    <header class="card-header">
        <a href="#" data-toggle="collapse" data-target="#collapse11" aria-expanded="true" class="">
            <i class="icon-action fa fa-chevron-down"></i>
            <span class="title badge badge-patientinfo patientConfirmFont">${name}</span>
        </a>
		<!---->
        <c:if test="${referralDetails != null}">
            <a href="#" data-toggle="collapse" data-target="#referralInfo" aria-expanded="true"> 
                <i class="icon-action fa fa-chevron-down"></i>
                <span class="title badge badge-success patientConfirmFont">Internal Referral</span>                
            </a>
        </c:if>
    </header>
    <div class="collapse hide" id="collapse11" style="">
        <article class="card-body">
            <fieldset>
                <table class="col-md-12">
                    <tbody>
                        <tr class="row">
                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">Patient No:</label>
                                    <input class="form-control form-control-sm" value="${patientno}" type="text" disabled="">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">Visit No:</label>
                                    <input class="form-control form-control-sm col-md-12" type="text" id="newpatientvisitnumber" value="${visitnumber}" disabled="">
                                </div>
                            </td>
                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">Years:</label>
                                    <input class="form-control form-control-sm" value="${estimatedage}" type="text" name="" disabled="" id="estimated-age">
                                </div>
                            </td>
                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm">Gender:</label>
                                    <input class="form-control form-control-sm" value="${gender}" name="" disabled="">
                                </div>
                            </td>
                            
                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">Tel:</label>
                                    <input class="form-control form-control-sm" value="${telephone}" type="text" name="" disabled="">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">Current Address:</label>
                                    <input class="form-control form-control-sm" value="${village}" type="text" disabled="">
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </fieldset>
        </article>
    </div>
	<!---->
    <c:if test="${referralDetails != null}">
        <div class="collapse" id="referralInfo">
            <article class="card-body">
                    <fieldset>
                        <div>
                            <label for="referringUnit" class="control-label"> Referring Unit:
                                <span class="form-control" id="referringUnit" name="referringUnit">${referralDetails.referringUnit}</span>
                            </label>
                        </div>
                        <div>
                            <label for="addedby" class="control-label"> Referred By:
                                <span class="form-control" id="addedby" name="addedby">${referralDetails.addedby}</span>
                            </label>
                        </div>
                        <div>
                            <label for="referralnotes" class="control-label"> Referral Notes:
                                <span type="text" class="form-control" id="referralnotes" name="referralnotes">
                                    ${referralDetails.referralnotes}
                                </span>
                            </label>
                        </div>
                    </fieldset>
            </article>
        </div>
    </c:if>
</div>