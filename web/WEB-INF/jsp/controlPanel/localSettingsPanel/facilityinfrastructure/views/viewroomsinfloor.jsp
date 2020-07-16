<%-- 
    Document   : viewroomsinfloor
    Created on : Aug 21, 2019, 3:00:10 PM
    Author     : USER 1
--%>

<%@include file = "../../../../include.jsp" %>

<div class="row">
    <div class="col-md-12">
        <div class="form-group">
            <input class="form-control" id="floorid" type="hidden" value="${floorid}">
            <input class="form-control" id="floorname" type="hidden" value="${floorname}">
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <span><b>FLOOR:&nbsp;
            </b></span> <h5><span class="badge badge-secondary"><strong>${floorname}</strong></span></h5> 
    </div>

</div>
<div class="tile">
    <div class="tile-body">
        <fieldset>
            <table class="table table-hover table-bordered col-md-12" id="blockTablesx">
                <thead>
                    <tr>
                        <th class="center">No</th>
                        <th class="center">Room Name</th>
                    </tr>
                </thead>
                <tbody class="col-md-12" id="viewblocktable">
                    <% int i = 1;%>                 
                    <c:forEach items="${viewRoomsList}" var="a">
                        <tr id="${a.roomid}">
                            <td><%=i++%></td>
                            <td class="center">${a.roomname}</td>
                            
                        </tr>
                    </c:forEach>
                </tbody>
            </table> 
        </fieldset>
    </div>
</div>

<script>
    $('#floorid').val();
    $('[data-toggle="popover"]').popover();
    $('#blockTablesx').DataTable();


   

</script>