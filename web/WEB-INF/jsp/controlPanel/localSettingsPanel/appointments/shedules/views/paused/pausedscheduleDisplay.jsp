<%-- 
    Document   : pausedscheduleDisplay
    Created on : May 15, 2018, 5:38:18 PM
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
                        <a class="dropdown-item" href="#"  id="staffschedule2">Staff Schedules</a>
                        <a class="dropdown-item" href="#" id="servicesschedule2">Services Schedules</a>
                    </div>
                </div>
            </div>
        </div>
    </div><br>
    <div class="row"  id="user-timeline">
        <div class="col-md-12">
            <div class="tile">
                <div id="showcontent1a">
                    <fieldset>
                        <h5 class="tile-title">Staff Schedules</h5>
                        <div class="tile-body" id="changetableview">
                            <table class="table table-hover table-bordered" id="schedulexxtype2">
                                <thead>
                                    <tr>
                                        <th>No:</th>
                                        <th class="center">Staff Name</th>
                                        <th class="center">Schedules</th>
                                        <th class="center">Schedule Status</th>
                                    </tr>
                                </thead>
                                <tbody> 
                                    <c:if test="${pausedStaffList != null}">
                                        <% int k = 1;%>
                                        <c:forEach items="${pausedStaffList}" var="b">
                                            <tr>
                                                <td data-label="No:"><%=k++%></td>
                                                <td data-label="Staff Name">${b.StaffName}</td>
                                                <td data-label="Schedules" class="center" id="${b.staffid}" onclick="showpausedstaffschedules(this.id);"><button class="btn btn-sm btn-primary"><i class="fa fa-fw fa-lg fa-dedent"></i></button></td>
                                                <td data-label="Schedule Status" class="center"><button class="btn btn-sm btn-success">${b.schedulestate}</button></td>                                            
                                            </tr> 
                                        </c:forEach>           
                                    </c:if>                                                  
                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                </div>
                <div id="showcontent2a" class="hidedisplaycontent">
                    <fieldset>
                        <h5 class="tile-title">Services Schedules</h5>
                        <div class="tile-body">
                            <table class="table table-hover table-bordered" id="schedulexxtype2a">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th class="center">Service</th>
                                        <th class="center">Start Date</th>
                                        <th class="center">End Date</th>
                                        <th class="center">Schedule Days</th>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEPAUSEDSERVICESCHEDULE')"> 
                                        <th class="center"> Manage </th>
                                         </security:authorize>
                                    </tr>
                                </thead>
                                <tbody>                                           
                                    <tr>
                                        <td>1</td>
                                        <td>Computer Repair</td>
                                        <td>22/09/2018 </td>
                                        <td>22/10/2018</td>
                                      <td class="center"><a id="" data-container="body" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="view details" data-original-title="Schedule details" href="#"> <i class="fa fa-fw fa-lg fa-dedent"></i></a></td>
                                      <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEPAUSEDSERVICESCHEDULE')">  
                                      <td><a href="#"><i class="fa fa-fw  fa-lg fa-edit"></i></a> | <a href="#"><i class="fa fa-fw  fa-lg fa-trash"></i></a></td>
                                      </security:authorize>
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
        <div id="staffpausedschedulingz" class="registerSupplier">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Staff Schedules</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">                        
                        <div class="tile">
                            <div id="show2">
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
        $('#schedulexxtype2').DataTable();
        $('#schedulexxtype2a').DataTable();
        $('[data-toggle="popover"]').popover();
        $('#staffschedule2').click(function () {
            $('#showcontent1a').show();
            $('#showcontent2a').hide();           
        });
        $('#servicesschedule2').click(function () {
            $('#showcontent1a').hide();
            $('#showcontent2a').show();           
        });
    });
    function showpausedstaffschedules(staffid) {
        console.log(staffid);//activeuserschedulelistz        
        window.location = '#staffpausedschedulingz';
        initDialog('registerSupplier');
        ajaxSubmitDataNoLoader('appointmentandSchedules/pauseduserschedulelist.htm', 'show2', 'staffid=' + staffid + '&act=a&&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>