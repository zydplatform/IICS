<%-- 
    Document   : categoryTests
    Created on : Sep 5, 2018, 11:02:33 PM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-6">
        <c:if test="${act=='b' || act=='c'}">
            <button onclick="addLabTestsInClassifications(${labtestclassificationid});"  class="btn btn-primary pull-left" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>Add Tests</button> 
        </c:if>
    </div>
    <div class="col-md-6">
        <c:if test="${act=='a' || act=='c'}">
            <button onclick="addClassificationSubCategory(${labtestclassificationid});"  class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>Add Sub Category</button> 
        </c:if>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <c:if test="${act=='a' || act=='c'}">
            <table class="table table-hover table-bordered" id="CategoryItemsTable">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Category Name</th>
                        <td>Active</td>
                        <th>Update</th>
                    </tr>
                </thead>
                <tbody >
                    <% int j = 1;%>
                    <% int i = 1;%>
                    <c:forEach items="${laboratorytestclassificationsList}" var="a">
                        <tr>
                            <td><%=j++%></td>
                            <td>${a.labtestclassificationname}</td>
                            <td align="center">
                                <div class="toggle-flip">
                                    <label>
                                        <input id="<%=i++%>TST" type="checkbox"<c:if test="${a.isactive==true}">checked="checked"</c:if> onchange="if (this.checked) {

                                                } else {

                                                }"><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="YES" data-toggle-off="NO"></span>
                                        </label>
                                    </div>
                                </td>
                                <td align="center">
                                    <a href="#!" title="Update" onclick=""><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                    |
                                    <a href="#!" title="delete" onclick="" ><i class="fa fa-fw fa-lg fa-remove"></i></a>
                                </td>                                                  
                            </tr>
                    </c:forEach>
                </tbody>
            </table>   
        </c:if>

        <c:if test="${act=='b'}">
            <table class="table table-hover table-bordered" id="ItemsTable">
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
                    <c:forEach items="${laboratorytestclassificationsList}" var="b">
                        <tr>
                            <td><%=p++%></td>
                            <td>${b.testname}</td>
                            <td>${b.testmethod}</td>
                            <td>${b.unitofmeasure}</td>
                            <td>${b.testrange}</td>
                            <td align="center">
                                <a href="#!" title="Update" onclick=""><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                |
                                <a href="#!" title="delete" onclick="" ><i class="fa fa-fw fa-lg fa-remove"></i></a>
                            </td>                                                  
                        </tr>
                    </c:forEach>
                </tbody>
            </table>   
        </c:if>
    </div>
</div>

<script>
    $('#CategoryItemsTable').DataTable();
    $('#ItemsTable').DataTable();
    function addLabTestsInClassifications(labtestclassificationid) {
        $.ajax({
            type: 'GET',
            data: {labSubCategoryid: labtestclassificationid},
            url: "locallaboratorysetingmanagement/addnewLaboratoryTests.htm",
            success: function (data) {
                $.confirm({
                    title: 'ADD LAB TESTS',
                    content: '' + data,
                    boxWidth: '70%',
                    closeIcon: false,
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Finish',
                            btnClass: 'btn-purple',
                            action: function () {
                                ajaxSubmitData('locallaboratorysetingmanagement/laboratoryTests.htm', 'categoryLabTestsDivs', 'labtestclassificationid=' + labtestclassificationid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        },
                        close: function () {
                            ajaxSubmitData('locallaboratorysetingmanagement/laboratoryTests.htm', 'categoryLabTestsDivs', 'labtestclassificationid=' + labtestclassificationid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    }
                });
            }
        });
    }
    function addClassificationSubCategory(labtestclassificationid) {
        var classificationname=$('#LabTestsclassificationname').val();
        $.ajax({
            type: 'GET',
            data: {labtestclassificationid: labtestclassificationid},
            url: "locallaboratorysetingmanagement/addClassificationSubCategory.htm",
            success: function (data) {
                $.confirm({
                    title: 'ADD <a href="#!">'+classificationname+'</a> SUB CATEGORY',
                    content: ''+data,
                    type: 'purple',
                    boxWidth: '80%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Finish',
                            btnClass: 'btn-purple',
                            action: function () {
                                ajaxSubmitData('locallaboratorysetingmanagement/laboratoryCategoryTestshome.htm', 'categoryLabTestsDivs', 'labtestclassificationid=' + labtestclassificationid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                            }
                        },
                        close: function () {
                            ajaxSubmitData('locallaboratorysetingmanagement/laboratoryCategoryTestshome.htm', 'categoryLabTestsDivs', 'labtestclassificationid=' + labtestclassificationid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    }
                });
            }
        });
    }
</script>