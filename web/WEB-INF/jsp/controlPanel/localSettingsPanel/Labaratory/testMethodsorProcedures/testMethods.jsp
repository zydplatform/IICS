<%-- 
    Document   : testMethods
    Created on : Sep 6, 2018, 12:58:36 AM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table class="table table-hover table-bordered" id="LabTestsMethodsTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Test Method</th>
            <th>Active</th>
            <th>Update</th>
        </tr>
    </thead>
    <tbody >
        <% int p = 1;%>
        <c:forEach items="${laboratorytestMethodsList}" var="b">
            <tr>
                <td><%=p++%></td>
                <td>${b.testmethodname}</td>
                <td>${b.isactive}</td>
                <td align="center">
                    <a href="#!" title="Update" onclick="updatetestmethod(${b.testmethodid}, '${b.testmethodname}');"><i class="fa fa-fw fa-lg fa-edit"></i></a>
                    |
                    <a href="#!" title="delete" onclick="deletetestmethod(${b.testmethodid});" ><i class="fa fa-fw fa-lg fa-remove"></i></a>
                </td>                                                  
            </tr>
        </c:forEach>
    </tbody>
</table> 
<script>
    $('#LabTestsMethodsTable').DataTable();
    function updatetestmethod(testmethodid, testmethodname) {

    }
    function deletetestmethod(testmethodid) {
        $.confirm({
            title: 'DELETE TEST METHOD',
            content: 'Are You Sure You Want To Delete Test Method',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {testmethodid: testmethodid},
                            url: "locallaboratorysetingmanagement/deletetestmethod.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'not') {
                                    $.confirm({
                                        title: 'Encountered an error!',
                                        content: 'Can Not Be Deleted Because Of Attachments',
                                        type: 'red',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                
                                            }
                                        }
                                    });
                                } else {
                                    ajaxSubmitData('locallaboratorysetingmanagement/addmethodTestProcedure.htm', 'addmethodTestProcedurediv', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
</script>
