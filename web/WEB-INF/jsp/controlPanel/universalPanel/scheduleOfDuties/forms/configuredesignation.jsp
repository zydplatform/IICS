<%-- 
    Document   : configuredesignation
    Created on : Jul 24, 2019, 3:40:07 PM
    Author     : USER 1
--%>
<%@include file="../../../../include.jsp"%>

<div class="container">

        <div class="form-group">
            <label class="control-label" for="patientTemperature">Designation:
            </label>
                <div id="selectPosts">
                    <select class="form-control new_search" id="designation_list">
                            <c:forEach items="${designationList}" var="ac">
                               <option value="${ac.designationid}">${ac.designationname}</option>
                            </c:forEach>
                    </select>
                </div> 
        </div>

        <div class="form-group bs-component">
          <label class="control-label" for="patientTemperature">Number of Slots required:
              <input type="number" class="form-control"  id="requiredPosts" max="75" min="1">
        </div>
</div>
                    

  