<%-- 
    Document   : allschedulesDisplay
    Created on : May 15, 2018, 4:09:51 PM
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
                        <a class="dropdown-item" href="#"  id="staffschedule1">Staff Schedules</a>
                        <a class="dropdown-item" href="#" id="servicesschedule1">Services Schedules</a>
                    </div>
                </div>
            </div>
        </div>
    </div><br>
    <div class="row"  id="user-timeline">
        <div class="col-md-12">
            <div class="tile">
                <div id="showcontent1">
                    <fieldset>
                        <h5 class="tile-title">Staff Schedules</h5>
                        <div class="tile-body" id="changetableview">
                            <table class="table table-hover table-bordered" id="schedulexxtype">
                                <thead>
                                    <tr>
                                        <th>No:</th>
                                        <th class="center">Staff Name</th>
                                        <th class="center">Schedules</th>
                                        <th class="center">Schedule Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${activeStaffList != null}">
                                        <% int j = 1;%>
                                        <c:forEach items="${activeStaffList}" var="a">
                                            <tr>
                                                <td data-label="No:"><%=j++%></td>
                                                <td data-label="Staff Name">${a.StaffName}</td>
                                                <td data-label="Schedules" class="center" id="${a.staffid}" onclick="showActivestaffschedules(this.id);"><button class="btn btn-sm btn-primary"><i class="fa fa-fw fa-lg fa-dedent"></i></button></td>                                              </button></td>
                                                <td data-label="Schedule Status" class="center"><button class="btn btn-sm btn-secondary">${a.schedulestate}</button></td>                                           
                                            </tr> 
                                        </c:forEach> 
                                    </c:if>                                                                                   
                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                </div>
                <div id="showcontent2" class="hidedisplaycontent">
                    <fieldset>
                        <h5 class="tile-title">Services Schedules</h5>
                        <div class="tile-body">
                            <table class="table table-hover table-bordered" id="schedulexxtype1a">
                                <thead>
                                    <tr>
                                        <th>No:</th>
                                        <th class="center">Service</th>
                                        <th class="center">Start Date</th>
                                        <th class="center">End Date</th>
                                        <th class="center">Schedule Days</th>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEACTIVESERVICESCHEDULE')"> 
                                            <th class="center"> Manage </th>
                                            </security:authorize>
                                    </tr>
                                </thead>
                                <tbody>                                           
                                    <tr>
                                        <td>1</td>
                                        <td>Server maintenance</td>
                                        <td>22/09/2018 </td>
                                        <td>22/10/2018</td>
                                        <td class="center"><a id="" data-container="body" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="view details" data-original-title="Schedule details" href="#"> <i class="fa fa-fw fa-lg fa-dedent"></i></a></td>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEACTIVESERVICESCHEDULE')"> 
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
        <div id="staffschedulingz" class="manageCellDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Staff Schedules</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">                        
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div id="show1">
                                        <p>Loading content please wait..................</p>
                                    </div>                                     
                                </div>                                                               
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
        $('#schedulexxtype').DataTable();
        $('#schedulexxtype1a').DataTable();
        $('[data-toggle="popover"]').popover();
        $('#staffschedule1').click(function () {
            $('#showcontent1').show();
            $('#showcontent2').hide();
        });
        $('#servicesschedule1').click(function () {
            $('#showcontent1').hide();
            $('#showcontent2').show();

        });

    });
    function showActivestaffschedules(staffid) {
        //console.log(staffid);      
        window.location = '#staffschedulingz';
        initDialog('manageCellDialog');
        ajaxSubmitDataNoLoader('appointmentandSchedules/activeuserschedulelist.htm', 'show1', 'staffid=' + staffid + '&act=a&&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>