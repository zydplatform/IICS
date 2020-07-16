<%-- 
    Document   : saveDistrict
    Created on : Jun 5, 2018, 11:04:50 AM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>


<fieldset> 
    <div class="panel-body">
        <div class="table-responsive">
            <legend class="H5"> Details</legend>
            <c:if test="${model.saved}">
                <h3>Successfully Saved/Updated<br/></h3>
                </c:if>
                <c:if test="${model.saved==false}">
                <h3>Sorry, Save Failed<br/></h3>
                    ${model.successmessage}
                </c:if>
                <c:if test="${model.deleted==false && model.xxx==true}">
                <h3>Sorry, Deleting Failed<br/></h3>>
                    ${model.successmessage}
                </c:if> 
                <c:if test="${model.deleted && model.xxx==true}">
                <h3> Successfully Deleted<br/></h3>
                    ${model.successmessage}
                </c:if>
        </div>
    </div>

</fieldset>












