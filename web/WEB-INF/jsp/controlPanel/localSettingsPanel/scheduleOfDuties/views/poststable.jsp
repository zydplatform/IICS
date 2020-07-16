<%-- 
    Document   : poststable
    Created on : Jul 25, 2019, 3:08:25 PM
    Author     : USER 1
--%>

<%@include file="../../../../include.jsp"%>

<div id="configuration_table">
    <table class="table table-hover table-bordered col-md-12" id="PostTables">
        <thead>
            <tr>
                <th>No.</th>
                <th>Designation</th>
                <th>Duties and Responsibilities</th>
                <th>Slots</th>
                <th>Filled</th>
                <!--<th>Pending</th>-->
            </tr>
        </thead>
        <tbody class="col-md-12" id="domaindesignation">
            <% int q = 1;%>
            <c:forEach items="${facilityPostslist}" var="ac">
                <tr id="">
                    <td><%=q++%></td>
                    <td id="${ac.designationid}">${ac.designationname}</td>
                     <td>
                            <button class="btn btn-sm btn-secondary" onclick="fetchDutiestable(${ac.designationid})">
                                <i class="fa fa-dedent"></i>
                            </button>
                    </td> 
                    <td>
                      <c:if test="${ac.requiredstaff == 0}">
                            <a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${ac.designationname} Has no Post(s) please add Post(s)" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red; color: white">
                                <span>${ac.requiredstaff}</span>
                            </a>
                           
                        </c:if>
                        <c:if test="${ac.requiredstaff > 0}">
                            <a><button class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: green;" id="editUniversalPosts" onclick="" ><span>${ac.requiredstaff}</span></button></a>
                           </c:if>
                    </td>
                    <td>
                      <c:if test="${ac.staffCount == 0}">
                            <a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${ac.designationname} Has no Post(s) please add Post(s)" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red; color: white">
                                <span>${ac.staffCount}</span>
                            </a>
                           </c:if>
                        <c:if test="${ac.staffCount > 0}">
                            <a><button class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: green;" id="editUniversalPosts" onclick="" ><span>${ac.staffCount}</span></button></a>
                            </c:if>
                    </td>
                    <!--<td>-->
                      <%--<c:if test="${ac.pending == 0}">--%>
                            <!--<a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${ac.designationname} Has no Post(s) please add Post(s)" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: green; color: white">-->
                                <!--<span/>${ac.pending}</span>-->
                            <!--</a>-->
                      <%--</c:if>--%>
                            <%--<c:if test="${ac.pending < 0}">--%>
                            <!--<a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${ac.designationname} Has no Post(s) please add Post(s)" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: orange; color: white">-->
                                <!--<span>${ac.pending}</span>-->
                            <!--</a>-->
                            <%--</c:if>--%>
                        <%--<c:if test="${ac.pending > 0}">--%>
                            <!--<a><button class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red;" id="editUniversalPosts" onclick="" ><span>${ac.pending}</span></button></a>-->
                        <%--</c:if>--%>
                    <!--</td>-->                 
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
            <script>
                    $('#PostTables').DataTable();
                    
                    
                    function fetchDutiestable(designationid){                        
                         $.ajax({
                               type: 'GET',
                               data: {designationid: designationid},
                               url: 'postsandactivities/fetchDutieslocal.htm',
                               success: function(data, textStatus, jqXHR){
                                    $.confirm({
                                        icon: '',
                                        title: 'Duties and Responsibilities',
                                        content: ''+data,
                                        type: 'purple',
                                        typeAnimated: true,
                                        boxWidth: '80%',
                                        useBootstrap: false,
                                        onContentReady: function () {

                                        },
                                        buttons: {
                                            save: {
                                                text: 'Close',
                                                btnClass: 'btn btn-red',
                                                action: function () {

                                                        },

                                            }
                                        }
                                    });
                               }
                            
                        });
                    }
            </script>