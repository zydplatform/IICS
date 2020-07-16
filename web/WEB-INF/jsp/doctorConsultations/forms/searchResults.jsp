<%-- 
    Document   : searchResults
    Created on : Aug 19, 2018, 10:41:05 AM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${not empty labTestsList}">
    <ul class="items" id="foundLabTests">
        <c:forEach items="${labTestsList}" var="item">
            <li id="LabTest${item.laboratorytestid}" class="classItem border-groove" onclick="addPatientLabTest(${item.laboratorytestid}, '${item.testname}','${item.labtestclassificationname}');">
                <h5 class="itemTitle">
                    ${item.testname}
                </h5>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty labTestsList}">
    <p class="center">
        <br>
       <strong>No  Lab Tests </strong> Not Found.
    </p>
</c:if>
<script>
    var patientLabTest = new Set();
    function addPatientLabTest(laboratorytestid, testname,labtestclassificationname) {
        $.confirm({
            title: 'ADD ' + ' ' + testname,
            content: 'Do You Want To Add This Lab Test?',
            type: 'purple',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Add',
                    btnClass: 'btn-green',
                    action: function () {
                        patientLabTest.add(laboratorytestid);
                        $('#inputLabTestsenteredItemsBody').append('<tr><td>' + testname + '</td>' +
                                '<td>'+labtestclassificationname+'</td>'+
                                '<td><span  title="Delete Of This Item." onclick="deletecategoryItem();" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');
                        $('#LabTest' + laboratorytestid).remove();
                    }
                },
                Cancel: function () {

                }
            }
        });
    }
</script>