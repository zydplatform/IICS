<%-- 
    Document   : updateAudits
    Created on : August 1, 2018, 10:05:07 AM
    Author     : Uwera
  
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<fieldset style="width:120%"><legend>${model.dbaction} Action On Object: ${model.activity}</legend>
    <table class="table table-hover table-bordered" id="viewGrid1">
        <c:if test="${model.activity=='Village' && (model.dbaction=='Update' || model.dbaction=='Transfer')}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Time</th>
                    <th>Current ${model.activity}</th>
                    <th>Current Parish</th>
                    <th>Current District</th>
                    <th>Previous ${model.activity}</th>
                    <th>Previous Parish</th>
                    <th>Previous District</th>
                    <th>Manage${model.activity}</th>
                </tr>
            </thead>
            <tbody id="tableAudits">
                <c:forEach items="${model.audActivityList}"  var="list" varStatus="status" >
                    <c:choose>
                        <c:when test="${status.count % 2 != 0}">
                            <tr id="${list[0]}">
                            </c:when>
                            <c:otherwise>
                            <tr id="${list[0]}" bgcolor="white">
                            </c:otherwise>
                        </c:choose>

                        <td>${status.count}</td>
                        <td>${list[1]}</td>
                        <td>${list[5]}</td>
                        <td>${list[17]}</td>
                        <td>${list[20]}</td>
                        <td>${list[10]}</td>
                        <td>${list[11]}</td>
                        <td>${list[14]}</td>
                        <td class="center">
                            <a title="Manage" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=e&i=${list[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-align-justify"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if>
        <c:if test="${model.activity=='Village' && model.dbaction=='Delete'}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Time</th>
                    <th>${model.activity} Name</th>
                    <th>Parish</th>
                    <th>District</th>
                    <th>Region</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody id="tableAudits">
                <c:forEach items="${model.audActivityList}"  var="list" varStatus="status" >
                    <c:choose>
                        <c:when test="${status.count % 2 != 0}">
                            <tr id="${list[0]}">
                            </c:when>
                            <c:otherwise>
                            <tr id="${list[0]}" bgcolor="white">
                            </c:otherwise>
                        </c:choose>

                        <td>${status.count}</td>
                        <td>${list[1]}</td>
                        <td>${list[10]}</td>
                        <td>${list[11]}</td>
                        <td>${list[14]}</td>
                        <td>${list[15]}</td>
                        <td class="center">
                            <a title="View Details" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=e&i=${list[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-align-justify"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if>
        <c:if test="${model.activity=='Parish' && (model.dbaction=='Update' || model.dbaction=='Transfer')}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Time</th>
                    <th>Current ${model.activity}</th>
                    <th>Current District</th>
                    <th>Current Region</th>
                    <th>Previous ${model.activity}</th>
                    <th>Previous District</th>
                    <th>Previous Region</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody id="tableAudits">
                <c:forEach items="${model.audActivityList1}"  var="list" varStatus="status" >
                    <c:choose>
                        <c:when test="${status.count % 2 != 0}">
                            <tr id="${list[0]}">
                            </c:when>
                            <c:otherwise>
                            <tr id="${list[0]}" bgcolor="white">
                            </c:otherwise>
                        </c:choose>

                        <td>${status.count}</td>
                        <td>${list[1]}</td>
                        <td>${list[17]}</td>
                        <td>${list[20]}</td>
                        <td>${list[21]}</td>
                        <td>${list[11]}</td>
                        <td>${list[14]}</td>
                        <td>${list[15]}</td>
                        <td class="center">
                        <a title="Manage" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=e&i=${list[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-align-justify"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if>
        <c:if test="${model.activity=='Parish' && model.dbaction=='Delete'}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Time</th>
                    <th>${model.activity} Name</th>
                    <th>District</th>
                    <th>Region</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody id="tableAudits">
                <c:forEach items="${model.audActivityList1}"  var="list" varStatus="status" >
                    <c:choose>
                        <c:when test="${status.count % 2 != 0}">
                            <tr id="${list1[0]}">
                            </c:when>
                            <c:otherwise>
                            <tr id="${list1[0]}" bgcolor="white">
                            </c:otherwise>
                        </c:choose>

                        <td>${status.count}</td>
                        <td>${list[1]}</td>
                        <td>${list[11]}</td>
                        <td>${list[14]}</td>
                        <td>${list[15]}</td>
                        <td class="center">
                             <a title="View Details" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=e&i=${list[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-align-justify"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if> 
        <c:if test="${model.activity=='Subcounty' && (model.dbaction=='Update' || model.dbaction=='Transfer')}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Time</th>
                    <th>Current ${model.activity}</th>
                    <%--<th>Current County</th>--%>
                    <th>Current District</th>
                    <th>Current Region</th>
                    <th>Previous ${model.activity}</th>
                    <%--<th>Previous County</th>--%>
                    <th>Previous District</th>
                    <th>Previous Region</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody id="tableAudits">
                <c:forEach items="${model.audActivityList2}"  var="list" varStatus="status" >
                    <c:choose>
                        <c:when test="${status.count % 2 != 0}">
                            <tr id="${list[0]}">
                            </c:when>
                            <c:otherwise>
                            <tr id="${list[0]}" bgcolor="white">
                            </c:otherwise>
                        </c:choose>

                        <td>${status.count}</td>
                        <td>${list[1]}</td>
                        <td>${list[18]}</td>
                        <%--<td>${list[19]}</td>--%>
                        <td>${list[20]}</td>
                        <td>${list[21]}</td>
                        <td>${list[12]}</td>
                        <%--<td>${list[13]}</td>--%>
                        <td>${list[14]}</td>
                        <td>${list[15]}</td>
                        <td class="center">
                          <a title="Manage" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=e&i=${list[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-align-justify"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if>
        <c:if test="${model.activity=='Subcounty' && model.dbaction=='Delete'}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Time</th>
                    <th>${model.activity}</th>
                    <th>County</th>
                    <th>District</th>
                    <th>Region</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody id="tableAudits">
                <c:forEach items="${model.audActivityList2}"  var="list" varStatus="status" >
                    <c:choose>
                        <c:when test="${status.count % 2 != 0}">
                            <tr id="${list[0]}">
                            </c:when>
                            <c:otherwise>
                            <tr id="${list[0]}" bgcolor="white">
                            </c:otherwise>
                        </c:choose>

                        <td>${status.count}</td>
                        <td>${list[1]}</td>
                        <td>${list[12]}</td>
                        <td>${list[13]}</td>
                        <td>${list[14]}</td>
                        <td>${list[15]}</td>
                        <td class="center">
                            <a title="View Details" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=e&i=${list[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-align-justify"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if> 
        <c:if test="${model.activity=='County' && (model.dbaction=='Update' || model.dbaction=='Transfer')}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Time</th>
                    <th>Current ${model.activity}</th>
                    <th>Current District</th>
                    <th>Current Region</th>
                    <th>Previous ${model.activity}</th>
                    <th>Previous District</th>
                    <th>Previous Region</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody id="tableAudits">
                <c:forEach items="${model.audActivityList3}"  var="list" varStatus="status" >
                    <c:choose>
                        <c:when test="${status.count % 2 != 0}">
                            <tr id="${list[0]}">
                            </c:when>
                            <c:otherwise>
                            <tr id="${list[0]}" bgcolor="white">
                            </c:otherwise>
                        </c:choose>

                        <td>${status.count}</td>
                        <td>${list[1]}</td>
                        <td>${list[19]}</td>
                        <td>${list[20]}</td>
                        <td>${list[21]}</td>
                        <td>${list[13]}</td>
                        <td>${list[14]}</td>
                        <td>${list[15]}</td>
                        <td class="center">
                             <a title="Manage" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=e&i=${list[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-align-justify"></i></a>
                         </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if>
        <c:if test="${model.activity=='County' && model.dbaction=='Delete'}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Time</th>
                    <th>${model.activity}</th>
                    <th>District</th>
                    <th>Region</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody id="tableAudits">
                <c:forEach items="${model.audActivityList3}"  var="list" varStatus="status" >
                    <c:choose>
                        <c:when test="${status.count % 2 != 0}">
                            <tr id="${list[0]}">
                            </c:when>
                            <c:otherwise>
                            <tr id="${list[0]}" bgcolor="white">
                            </c:otherwise>
                        </c:choose>

                        <td>${status.count}</td>
                        <td>${list[1]}</td>
                        <td>${list[13]}</td>
                        <td>${list[14]}</td>
                        <td>${list[15]}</td>
                        <td class="center">
                              <a title="View Details" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=e&i=${list[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-align-justify"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
            <div class="row">
        <div class="col-md-12">
            <div id="activityPanel2"></div>
        </div>
    </div>
        </c:if> 

        <c:if test="${model.activity=='District' && (model.dbaction=='Update' || model.dbaction=='Transfer')}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Time</th>
                    <th>Current ${model.activity}</th>
                    <th>Current Region</th>
                    <th>Previous ${model.activity}</th>
                    <th>Previous Region</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody id="tableAudits">
                <c:forEach items="${model.audActivityList4}"  var="list" varStatus="status" >
                    <c:choose>
                        <c:when test="${status.count % 2 != 0}">
                            <tr id="${list[0]}">
                            </c:when>
                            <c:otherwise>
                            <tr id="${list[0]}" bgcolor="white">
                            </c:otherwise>
                        </c:choose>

                        <td>${status.count}</td>
                        <td>${list[1]}</td>
                        <td>${list[20]}</td>
                        <td>${list[21]}</td>
                        <td>${list[14]}</td>
                        <td>${list[15]}</td>
                        <td class="center">
                          <a title="Manage" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=e&i=${list[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-align-justify"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if>
        <c:if test="${model.activity=='District' && model.dbaction=='Delete'}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Time</th>
                    <th>${model.activity}</th>
                   <th>Region</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody id="tableAudits">
                <c:forEach items="${model.audActivityList4}"  var="list" varStatus="status" >
                    <c:choose>
                        <c:when test="${status.count % 2 != 0}">
                            <tr id="${list[0]}">
                            </c:when>
                            <c:otherwise>
                            <tr id="${list[0]}" bgcolor="white">
                            </c:otherwise>
                        </c:choose>

                        <td>${status.count}</td>
                        <td>${list[1]}</td>
                        <td>${list[14]}</td>
                        <td>${list[15]}</td>
                        <td class="center">
                            <a title="View Details" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=e&i=${list[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-align-justify"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if> 


        <c:if test="${model.activity=='Region' && (model.dbaction=='Update' || model.dbaction=='Transfer')}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Time</th>
                    <th>Current Region</th>
                     <th>Previous Region</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody id="tableAudits">
                <c:forEach items="${model.audActivityList5}"  var="list" varStatus="status" >
                    <c:choose>
                        <c:when test="${status.count % 2 != 0}">
                            <tr id="${list[0]}">
                            </c:when>
                            <c:otherwise>
                            <tr id="${list[0]}" bgcolor="white">
                            </c:otherwise>
                        </c:choose>

                        <td>${status.count}</td>
                        <td>${list[1]}</td>
                        <td>${list[21]}</td>
                        <td>${list[15]}</td>
                       <td class="center">
                            <a title="Manage" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=e&i=${list[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-align-justify"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if>
        <c:if test="${model.activity=='Region' && model.dbaction=='Delete'}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Time</th>
                   <th>Region Name</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody id="tableAudits">
                <c:forEach items="${model.audActivityList5}"  var="list" varStatus="status" >
                    <c:choose>
                        <c:when test="${status.count % 2 != 0}">
                            <tr id="${list[0]}">
                            </c:when>
                            <c:otherwise>
                            <tr id="${list[0]}" bgcolor="white">
                            </c:otherwise>
                        </c:choose>

                        <td>${status.count}</td>
                        <td>${list[1]}</td>
                          <td>${list[15]}</td>
                        <td class="center">
                              <a title="View Details" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'content', 'act=e&i=${list[0]}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=${model.dbaction}', 'GET');"><i class="fa fa-fw fa-lg fa-align-justify"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if> 
    </table>
</fieldset>
<script>
    $(document).ready(function () {
        $('#viewGrid1').DataTable();
    });
</script>


