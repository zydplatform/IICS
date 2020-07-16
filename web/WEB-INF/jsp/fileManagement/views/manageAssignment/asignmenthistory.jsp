<%-- 
    Document   : patientfilePages
    Created on : May 25, 2018, 3:49:17 PM
    Author     : IICS
--%>

<%@include file="../../../include.jsp"%>
 <fieldset>
       <table class="table table-hover" id="assignmentHistoryActivities">
                    <thead>
                       <tr><th class="center">No</th>
                            <th class="center">File Activity</th>
                            <th class="center"> Date</th>
                            <th class="center">Staff Name</th>
                            <th class="center">Contact</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <% int h = 1;%>
                        <c:forEach items="${assignmentHistory}" var="history">
                            <tr>
                               <td><%=h++%></td>
                              <td class="center">${history.assignmentaction}</td>
                              <td class="center">${history.actionDate}</td>
                               <td class="center">${history.ContactDetails.firstname} ${history.ContactDetails.othernames} ${history.ContactDetails.lastname} 
                                </td>
                                <td class="center">${history.ContactDetails.contactvalue} ${history.ContactDetails.contacttype} 
                                </td>
                             </tr>
                        </c:forEach>
                   </tbody>
                </table>
    </fieldset> 
        
   <script>
   $('#assignmentHistoryActivities').DataTable();
   function showOtherApprovedDetails(IssueDate, datereturned) {
        $.alert({
            title: 'Asignment Details',
            content: '' +
                    '<form action="" class="formName"><hr/>'
                    +
                    '<div class="form-group row">' +
                    '<label class="col-md-6">Current User: </label>' +
                    '<label class="col-md-6">' + IssueDate+ '</label>' +
                    '</div>' +
                    '<div class="form-group row">' +
                    '<label class="col-md-6">Current Location: </label>' +
                    '<label class="col-md-6">' + datereturned + '</label>' +
                    '</div>' +
                    '</form>',
            buttons: {
                
               
                Cancel: function () {

                }
            }
        });
    }
    </script>