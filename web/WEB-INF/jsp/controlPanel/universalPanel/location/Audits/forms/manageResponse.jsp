<%-- 
    Document   : manageResponse
     Created on : Aug 13, 2018,1:30:45 AM
    Author     : Uwera
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:if test="${model.success==true}">
    <c:if test="${(model.dbaction=='Update' || model.dbaction=='Transfer') && model.activity=='Village'}">
        <h2 align="center" style="color: #512da8">
            Confirmed ${model.dbaction} on ${model.activity} :${model.audObj[16]}  
           
                   In ${model.audObj[17]} Parish
        </h2>
    </c:if>
    <c:if test="${model.dbaction=='Delete' && model.activity=='Village'}">
         <h2 align="center" style="color: #512da8">
           ${model.activity}:${model.audObj[10]} was Successfully Reverted!
         
         In ${model.audObj[11]} Parish
        </h2>
    </c:if>
    
    
    <c:if test="${(model.dbaction=='Update' || model.dbaction=='Transfer') && model.activity=='Parish'}">
        <h2 align="center" style="color: #512da8">
            
            Confirmed  ${model.dbaction}  on ${model.activity} : ${model.audObj[11]}
            
          In ${model.audObj[18]} Sub county
        </h2>
    </c:if>
    <c:if test="${model.dbaction=='Delete' && model.activity=='Parish'}">
       <h2 align="center" style="color: #512da8">
              ${model.activity}:${model.audObj[11]} Successfully Reverted!
       
              In ${model.audObj[12]} Sub county
        </h2>
    </c:if>
    <c:if test="${(model.dbaction=='Update' || model.dbaction=='Transfer') && model.activity=='Subcounty'}">
     <h2 align="center" style="color: #512da8">
             Confirmed  ${model.dbaction}  on ${model.activity}:${model.audObj[18]}
         
           In ${model.audObj[19]} County
        </h2>
    </c:if>
      <c:if test="${model.dbaction=='Delete' && model.activity=='Subcounty'}">
        <h2 align="center" style="color: #512da8">
             ${model.activity}: ${model.audObj[12]} Successfully Reverted!
           
              In ${model.audObj[13]} County
        </h2>
    </c:if>
    
     <c:if test="${(model.dbaction=='Update' || model.dbaction=='Transfer') && model.activity=='County'}">
        <h2 align="center" style="color: #512da8">
             Confirmed  ${model.dbaction}  on ${model.activity}:${model.audObj[19]}
         
            In ${model.audObj[20]} District
        </h2>
    </c:if>
    <c:if test="${model.dbaction=='Delete' && model.activity=='County'}">
     <h2 align="center" style="color: #512da8">
            ${model.activity}:${model.audObj[13]} Successfully Reverted! 
            
              In  ${model.audObj[14]} District
        </h2>
    </c:if>
    <c:if test="${(model.dbaction=='Update' || model.dbaction=='Transfer') && model.activity=='District'}">
        <h1>
            Confirmed  ${model.dbaction} on ${model.activity} : ${model.audObj[20]}
            
             In ${model.audObj[21]} Region
        </h1>
    </c:if>
    <c:if test="${model.dbaction=='Delete' && model.activity=='District'}">
       <h2 align="center" style="color: #512da8">
            Successfully Reverted! ${model.activity}  : ${model.audObj[14]}
           
              In ${model.audObj[15]} Region
        </h2>
    </c:if>
    <c:if test="${(model.dbaction=='Update' || model.dbaction=='Transfer') && model.activity=='Region'}">
  <h2 align="center" style="color: #512da8">
            Confirmed ${model.dbaction} on ${model.activity} : ${model.audObj[21]} 
           
  </h2>
    </c:if>
     <c:if test="${model.dbaction=='Delete' && model.activity=='Region'}">
        <h2 align="center" style="color: #512da8">
            Successfully Reverted !! ${model.activity} :${model.audObj[15]}
           
      </h2>
    </c:if>
</c:if>
<c:if test="${model.success==false}">
    <h1>
        Action Failed!
    </h1>
</c:if>

</fieldset>