<%-- 
    Document   : prescriberDetails
    Created on : Apr 12, 2019, 9:53:43 AM
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
                        <label><strong><div>${prescriber}</div></strong></label>                                                
                    </div>
                    <div>
                        <label class="text-muted">E-mail Address:</label> 
                        <label><strong><div>${email}</div></strong></label>                                                
                    </div>
                    <div>
                        <label class="text-muted">Phone Contacts:</label> 
                        <label><strong><div>${contactno}</div></strong></label>                                                
                    </div>
                    <div>
                        <label class="text-muted">Unit:</label> 
                        <label><strong><div>${facilityunitname}</div></strong></label>                                                
                    </div>                                       
                </fieldset>
            </div>
        </div>
    </div>
</div>