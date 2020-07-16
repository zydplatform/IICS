<%-- 
    Document   : expiredscheduleDisplay
    Created on : May 15, 2018, 5:39:28 PM
    Author     : user
--%>
<%@include file="../../../../../../include.jsp" %>
<div id="">
    <div class="row">
        <div class="col-md-11 col-sm-11 right">
            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                <div class="btn-group" role="group">
                    <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-sliders" aria-hidden="true"></i>
                    </button>
                    <div class="dropdown-menu dropdown-menu-left">
                        <a class="dropdown-item" href="#"  id="staffschedule3">Staff Schedules</a>
                        <a class="dropdown-item" href="#" id="servicesschedule3">Services Schedules</a>
                    </div>
                </div>
            </div>
        </div>
    </div><br>
    <div class="row"  id="user-timeline">
        <div class="col-md-12">
            <div class="tile">
                <div id="showcontent1b">
                    <fieldset>
                        <h5 class="tile-title">Staff Schedules</h5>
                        <div class="tile-body" id="changetableview">
                            <table class="table table-hover table-bordered" id="schedulexxtype3">
                                <thead>
                                    <tr>
                                        <th>No:</th>
                                        <th class="center">Staff Name</th>
                                        <th class="center">Schedules</th>
                                        <th class="center">Schedule Status</th>
                                    </tr>
                                </thead>
                                <tbody>                                      
                                    <c:if test="${expiredStaffList != null}">
                                        <% int q = 1;%>
                                        <c:forEach items="${expiredStaffList}" var="c">
                                            <tr>
                                                <td data-label="No:"><%=q++%></td>
                                                <td data-label="Staff Name">${c.StaffName}</td>
                                                <td data-label="Schedules" class="center" id="${c.staffid}" onclick="showexpiredstaffschedules(this.id);"><button class="btn btn-sm btn-primary"><i class="fa fa-fw fa-lg fa-dedent"></i></button></td>
                                                <td data-label="Schedule Status" class="center"><button class="btn btn-sm btn-danger">${c.schedulestate}</button></td>                                            
                                            </tr> 
                                        </c:forEach>           
                                    </c:if>                      
                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                </div>
                <div id="showcontent2b" class="hidedisplaycontent">
                    <fieldset>
                        <h5 class="tile-title">Services Schedules</h5>
                        <div class="tile-body">
                            <table class="table table-hover table-bordered" id="schedulexxtype3a">
                                <thead>
                                    <tr>
                                        <th>No:</th>
                                        <th class="center">Service</th>
                                        <th class="center">Start Date</th>
                                        <th class="center">End Date</th>
                                        <th class="center">Schedule Days</th>
                                        <th class="center"> Manage </th>
                                    </tr>
                                </thead>
                                <tbody>                                           
                                    <tr>
                                        <td>1</td>
                                        <td>Consultancy</td>
                                        <td>22/09/2018 </td>
                                        <td>22/10/2018</td>
                                        <td class="center"><a id="" data-container="body" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="view details" data-original-title="Schedule details" href="#"> <i class="fa fa-fw fa-lg fa-dedent"></i></a></td>
                                        <td><a href="#"><i class="fa fa-fw  fa-lg fa-edit"></i></a> | <a href="#"><i class="fa fa-fw  fa-lg fa-trash"></i></a></td> 
                                    </tr>                     
                                </tbody>
                            </table>
                        </div>   
                    </fieldset> 
                </div>
            </div>            
        </div>        
    </div>  
</div>
<!----Dialogs for Staff Schedules-------->
<div class="row">
    <div class="col-md-12">
        <div id="staffexpiredschedulingz" class="modalDialogShelve">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Staff Schedules</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">                        
                        <div class="tile">
                            <div id="show3">
                                <p>Loading content please wait..................</p>
                            </div>                                     
                        </div> 
                    </div>                        
                </div>
            </div>

        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#schedulexxtype3').DataTable();
        $('#schedulexxtype3a').DataTable();
        $('[data-toggle="popover"]').popover();
        $('#staffschedule3').click(function () {
            $('#showcontent1b').show();
            $('#showcontent2b').hide();            
        });
        $('#servicesschedule3').click(function () {
            $('#showcontent1b').hide();
            $('#showcontent2b').show();
          
        });
    });
    function showexpiredstaffschedules(staffid) {
        //console.log(staffid);//activeuserschedulelistz        
        window.location = '#staffexpiredschedulingz';
        initDialog('modalDialogShelve');
        ajaxSubmitDataNoLoader('appointmentandSchedules/expireduserschedulelist.htm', 'show3', 'staffid=' + staffid + '&act=a&&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>