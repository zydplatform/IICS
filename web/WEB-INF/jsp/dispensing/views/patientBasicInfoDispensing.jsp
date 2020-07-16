<%--
    Document   : patientBasicInfoTriage
    Created on : Aug 31, 2018, 4:14:48 AM
    Author     : HP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="card">
    <header class="card-header">
        <a href="#" data-toggle="collapse" data-target="#collapse${action}" aria-expanded="true" class="">
            <i class="icon-action fa fa-chevron-down"></i>
            <span class="title badge badge-patientinfo patientConfirmFont">${name}  [ <strong> AGE:${estimatedage}</strong> ]</span>
        </a>
    </header>
    <div class="collapse colapse" id="collapse${action}" style="">
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
                                    <label class="col-form-label col-form-label-sm">Gender:</label>
                                    <input class="form-control form-control-sm" value="${gender}" name="" disabled="">
                                </div>
                            </td>
                            
                            <td class="col-md-2">
                                <div class="form-group">
                                    <!--
                                    <label class="col-form-label col-form-label-sm" for="">Weight:</label>
                                    <input class="form-control form-control-sm" value="${weight}" type="text" disabled="">
                                    -->
                                    <label class="col-form-label col-form-label-sm" for="">BMI <strong>(kg/m<sup>2</sup>):</strong></label>
                                    <input class="form-control form-control-sm" value="${patientBMI}" type="text" disabled="">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">TEL:</label>
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
                <div class="row" <c:if test="${observations == null || observations.size() == 0}">style="display: none;"</c:if>>
                    <div class="col-md-12">
                        <hr />
                            <h6>Observations/Diagnosis</h6>
                        <hr />
                    </div>
                    <div class="col-md-4">                        
                        <c:forEach items="${observations}" var="observation">
                            <span class="form-control disabled">${observation}</span>
                        </c:forEach>
                    </div>
                </div>
                <br />
            </fieldset>
        </article>
    </div>
</div>