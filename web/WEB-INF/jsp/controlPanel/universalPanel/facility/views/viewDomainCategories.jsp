<%-- 
    Document   : viewDoaminCategories
    Created on : Mar 29, 2018, 10:45:17 PM
    Author     : Grace-K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<fieldset style="min-height:100px;">
    <legend>Domain Categories</legend>
    <div class="row" id="level-content">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <table class="table table-hover table-bordered" id="designationCategoryTable">
                        <thead>
                            <tr>
                                <th class="center">No</th>
                                <th>Category Name</th>
                                <th class="">More Info</th>
                                <th class="center">Update</th>
                            </tr>
                        </thead>
                        <tbody class="col-md-12" id="tableExistingFacilityLevels">
                            <% int c = 1;%>
                            <c:forEach items="${domainCategoryList}" var="a">
                                <tr id="${a.designationcategoryid}">
                                    <td><%=c++%></td>
                                    <td contenteditable="false" class="levelnamefield">${a.categoryname}</td>
                                    <td contenteditable="false">${a.description}</td>
                                    <td align="center">
                                        <div style="float:center">
                                            <a href="#" onClick="" id="" class="btn btn-xs btn-teal tooltips editDomainLevels" data-placement="top" data-original-title="Edit/Update">Edit</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</fieldset>

<script>
    $(document).ready(function () {
        $('#designationCategoryTable').DataTable();
    });
</script>