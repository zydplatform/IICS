<%-- 
    Document   : printlabelz
    Created on : Jul 11, 2018, 9:14:00 AM
    Author     : user
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-body" id="changetableview">
                <table class="table table-hover table-bordered" id="celltypingx">
                    <thead>
                        <tr>
                            <th>No:</th>
                            <th class="center">Zone</th>
                            <th class="center">No. of Cells</th>
                            <th class="center">Manage Printing</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int j = 1;%>
                        <c:forEach items="${managezone}" var="a">
                            <tr>
                                <td data-label="No:"><%=j++%></td>
                                <td data-label="Zone">${a.zoneName}</td>
                                <td data-label="No. of Cells" align="center"><button class="btn btn-sm btn-success">${a.cellscount}</button></td> 
                                <td data-label="Manage Printing" align="center">
                                  <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_PRINTZONECELLLABELS')">
                                   <button id="${a.zoneid}" data-name="${a.zoneName}" onclick="showzonecelllabels(this.id, $(this).attr('data-name'))"class="btn btn-sm btn-primary"><i class="fa fa-dedent"></i></button>
                                 </security:authorize> 
                                  </td> 
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!------CELL LABEL PRINTING SECTION----------->
<div class="row">
    <div id="cellLabelshowvv" class="modalDialogcelldisplay">
        <div>
            <div id="head">
                <a href="#close" title="Close" class="close2">X</a>
                <h2 class="modalDialog-title">Cell Labels for Zone &nbsp;<span id="zname"></span></h2>
                <hr>
            </div>
            <div class="scrollbar" id="content">
                <div class="tile">
                    <div class="tile-body">                      
                        <div id="showcells"> </div>
                    </div>                                        
                </div>                       
            </div>
        </div>

    </div>
</div>
<script>
    $('#celltypingx').DataTable();
    function showzonecelllabels(id, name) {
        window.location = '#cellLabelshowvv';
        initDialog('modalDialogcelldisplay');
        $('#zname').html(name);
        ajaxSubmitDataNoLoader('localsettigs/viewUnitZonecells.htm', 'showcells', 'act=a&selectedzoneid=' + id + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>