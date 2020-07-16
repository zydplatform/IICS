<%-- 
    Document   : manageshelvingactivity
    Created on : Apr 11, 2018, 8:25:34 PM
    Author     : IICSRemote
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../../include.jsp" %>
<div class="col-md-12">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered" id="manageshelves">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Zone</th>
                                    <th>Staff Locations</th>
                                </tr>
                            </thead>
                            <tbody id="tablex">                            
                                <%int i = 1;%>
                                <c:forEach items="${ZoneShelveManage}" var="a">
                                        <tr>
                                            <td><%=i++%></td>
                                            <td>${a.zoneName}</td>
                                            <td align="center"><a href="#" onclick="ajaxSubmitDataNoLoader('localsettigs/displayfacilitystaffunit.htm', 'manageshelvedialog', 'selectedzoneid=${a.zoneid}&selectedname=${a.zoneName}&act=a&0&ofst=1&maxR=100&sStr=', 'GET');"><i class="fa fa-2x fa-list"></i></a></td>
                                        </tr>                                   
                                </c:forEach>  
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div> 
<div id="manageshelvedialog"></div>                               
<script>
    $(document).ready(function () {
        $('#manageshelves').DataTable();        
    });
</script>    