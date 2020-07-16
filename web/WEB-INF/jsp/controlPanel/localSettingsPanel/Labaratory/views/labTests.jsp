<%-- 
    Document   : labTests
    Created on : Sep 6, 2018, 12:33:45 AM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>

<div class="row">
    <div class="col-md-12">
        <button onclick="addnewLaboratoryTests();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add New Test(s)</button>
    </div>
</div><br>
<table class="table table-hover table-bordered" id="LabTestsItemsTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Test Name</th>
            <th>Test Method</th>
            <th>Unit</th>
            <th>Range</th>
            <th>Update</th>
        </tr>
    </thead>
    <tbody >
        <% int p = 1;%>
        <c:forEach items="${laboratorytestsList}" var="b">
            <tr>
                <td><%=p++%></td>
                <td>${b.testname}</td>
                <td>${b.testmethod}</td>
                <td>${b.unitofmeasure}</td>
                <td>${b.testrange}</td>
                <td align="center">
                    <a href="#!" title="Update" onclick="updatelaboratorytests(${b.laboratorytestid},'${b.testname}','${b.unitofmeasure}','${b.testrange}');"><i class="fa fa-fw fa-lg fa-edit"></i></a>
                    |
                    <a href="#!" title="delete" onclick="" ><i class="fa fa-fw fa-lg fa-remove"></i></a>
                </td>                                                  
            </tr>
        </c:forEach>
    </tbody>
</table> 
<script>
    $('#LabTestsItemsTable').DataTable();
    function addnewLaboratoryTests() {
        var labSubCategoryid = $('#LabTestsclassificationSubCategoryid').val();
        $.ajax({
            type: 'GET',
            data: {labSubCategoryid:labSubCategoryid},
            url: "locallaboratorysetingmanagement/addnewLaboratoryTests.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'ADD LAB TESTS',
                    content: ''+data,
                    boxWidth:'70%',
                    closeIcon:false,
                    useBootstrap:false,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Finish',
                            btnClass: 'btn-purple',
                            action: function () {
                             ajaxSubmitData('locallaboratorysetingmanagement/laboratoryTests.htm', 'categoryLabTestsDivs', 'labtestclassificationid=' + labSubCategoryid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');   
                            }
                        },
                        close: function () {
                          ajaxSubmitData('locallaboratorysetingmanagement/laboratoryTests.htm', 'categoryLabTestsDivs', 'labtestclassificationid=' + labSubCategoryid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');     
                        }
                    }
                });
            }
        });
    }
</script>