<%-- 
    Document   : facilityleveltable
    Created on : Jul 23, 2019, 3:39:46 PM
    Author     : USER 1
--%>
<%@include file="../../../../include.jsp"%>

<div>
    <table class="table table-hover table-bordered col-md-12" id="sampleTable">
        <thead>
            <tr>
                <th>No.</th>
                <th>Facility Level</th>
                <th>Staffing Configurations</th>
            </tr>
        </thead>
        <tbody class="col-md-12" id="domaindesignation">
            <% int q = 1;%>
            <c:forEach items="${facilityleveltable}" var="ac">
                <tr id="">
                    <td><%=q++%></td>
                    <td id="${ac.facilitylevelid}">${ac.facilitylevelname}</td>
                    <td>
                            <button class="btn btn-sm btn-secondary" onclick="getdesignation(${ac.facilitylevelid},'${ac.facilitylevelname}')">
                                <i class="fa fa-dedent"></i>
                            </button>
                    </td>                
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
                
 <script>
    $('#sampleTable').DataTable();
                      
    
    function getdesignation(facilitylevelid,facilitylevelname){
        var c = facilitylevelname;
        $.ajax({
           type: 'GET',
           data: {facilitylevelid: facilitylevelid},
           url: 'postsandactivities/fetchdesignationTable.htm',
           success: function(data, textStatus, jqXHR){
                $.confirm({
                    icon: '',
                    title: c +' Designation Configurations',
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