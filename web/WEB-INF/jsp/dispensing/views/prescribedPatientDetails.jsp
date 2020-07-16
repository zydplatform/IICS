<%-- 
    Document   : prescribedPatientDetails
    Created on : Apr 15, 2019, 2:45:56 PM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-body">
                <fieldset>
                    <div>
                        <label class="text-muted">Name:</label> 
                        <label><strong><div>${patientname}</div></strong></label>                                                
                    </div>
<!--                    <div>
                        <label class="text-muted">Visit Number:</label> 
                        <label><strong><div>${visitnumber}</div></strong></label>                                                
                    </div>
                    <div>
                        <label class="text-muted">Patient Number:</label> 
                        <label><strong><div>${patientno}</div></strong></label>                                                
                    </div>-->
                    <div>
                        <label class="text-muted">Phone Number:</label> 
                        <label><strong><div>${contactno}</div></strong></label>                                                
                    </div> 
                    <div>
                        <label class="text-muted">E-Mail:</label> 
                        <label><strong><div>${email}</div></strong></label>                                                
                    </div> 
                    <div>
                        <label class="text-muted">Date Prescribed:</label> 
                        <label><strong><div>${dateprescribed}</div></strong></label>                                                
                    </div>   
                    <div>
                        <label class="text-muted">Prescriber:</label> 
                        <label><strong><div>${addedby}</div></strong></label>                                                
                    </div>
                    <div>
                        <label class="text-muted">Date Approved:</label> 
                        <label><strong><div>${dateapproved}</div></strong></label>                                                
                    </div>
                    <div>
                        <label class="text-muted">Approved By:</label> 
                        <label><strong><div>${approvedby}</div></strong></label>                                                
                    </div>  
                    <div>
                        <label class="text-muted">Prescribing Unit:</label> 
                        <label><strong><div>${originunit}</div></strong></label>                                                
                    </div> 
                    <div>
                        <label class="text-muted">Dispensing Unit:</label> 
                        <label><strong><div>${destinationunit}</div></strong></label>                                                
                    </div> 
                </fieldset>
            </div>
        </div>
    </div>
</div>