<%-- 
    Document   : managespace
    Created on : Apr 10, 2018, 8:11:00 AM
    Author     : IICSRemote
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<div  id="contentminex">
<!--<div class="row">
    <div class="col-md-11 col-sm-11 right">
        <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
            <div class="btn-group" role="group">
                <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-sliders" aria-hidden="true"></i>
                </button>
                <div class="dropdown-menu dropdown-menu-left">
                    <a class="dropdown-item" href="#"  id="storespace">Storage Space</a>
                    <a class="dropdown-item" href="#" id="manageshelvingactivity">Manage Shelving Activity</a>
                </div>
            </div>
        </div>
    </div>
</div>-->
<div class="row"  id="user-timeline">
    <div class="col-md-12">
        <div class="tile">           
            <div id="showcontent1"> 
                <fieldset style="min-height:100px;">
                    <h3 class="tile-title">Storage Space</h3>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <div id="managebaydialog"></div>
                                    <table class="table table-hover table-bordered" id="manage_spaces">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>Zone</th>
                                                <th class="center">No. of Bays</th>
                                                <th class="center">No. of Rows</th>
                                                <th class="center">No. of Cells</th>
                                                <!--th class="center">Created By</th-->                                                       
                                                <th class="center">Activation</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tableFacilityOwner">
                                            <% int j = 1;%>
                                            <c:forEach items="${managezone}" var="a">
                                                <tr>
                                                    <td><%=j++%></td>
                                                    <td>${a.zoneName}</td>
                                                    <td align="center"><a onclick=" ajaxSubmitDataNoLoader('localsettigs/viewUnitZoneBay.htm', 'managebaydialog', 'act=a&selectedzoneid=' + ${a.zoneid} + ' &myid=1 &c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" href="#"><button class="btn btn-sm btn-secondary btn-circle">${a.bayscount}</button></a></td>
                                                    <td align="center"><a onclick=" ajaxSubmitDataNoLoader('localsettigs/viewUnitZoneBay.htm', 'managebaydialog', 'act=a&selectedzoneid=' + ${a.zoneid} + ' &myid=2 &c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" href="#"><button class="btn btn-sm btn-secondary btn-circle">${a.rowscount}</button></a></td>
                                                    <td align="center"><a onclick=" ajaxSubmitDataNoLoader('localsettigs/viewUnitZoneBay.htm', 'managebaydialog', 'act=a&selectedzoneid=' + ${a.zoneid} + ' &myid=3 &c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" href="#"><button class="btn btn-sm btn-secondary btn-circle">${a.cellscount}</button></a></td>  
                                                    <!--td>${a.addedby}</td-->
                                                    <c:if test="${a.zonestate == true}">
                                                        <td align="center">
                                                             <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_ACTIVATESTORAGESPACE')">
                                                              <label class="switch">
                                                                <input type="checkbox"  class="sliderxx" id="${a.zoneid}" value="true" onclick="sliderT(${a.zoneid}, $(this).val())" checked>
                                                                <span class="slider round"></span>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             round"></span>
                                                            </label>
                                                           </security:authorize>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${a.zonestate == false}">
                                                        <td align="center">
                                                             <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_ACTIVATESTORAGESPACE')">
                                                             <label class="switch">
                                                                <input type="checkbox"  class="sliderxx2" id="${a.zoneid}" value="false" onclick="sliderF(${a.zoneid}, $(this).val())" >
                                                                <span class="slider round"></span>
                                                            </label>
                                                           </security:authorize>
                                                        </td>
                                                    </c:if>    
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
            <div id="showcontent2" class="hidedisplaycontent">
                <h3 class="tile-title">Manage Shelving Activity</h3>
                <div id="manageshelvingx">
                    Loading Content Please wait-----------
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<script>
    $(document).ready(function () {
        $('#manage_spaces').DataTable();
        $('#manageshelvingactivity').click(function () {
            $('#showcontent1').hide();
            $('#showcontent2').show();
            ajaxSubmitDataNoLoader('localsettigs/manageshelveactivity.htm', 'manageshelvingx', 'act=a&&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        });
        $('#storespace').click(function () {
            $('#showcontent1').show();
            $('#showcontent2').hide();
            ajaxSubmitDataNoLoader('localsettigs/manageshelvingtab.htm', 'contentminex', 'act=a&&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        });
    });
    function sliderT(zoneidz, valuex) {
        console.log(zoneidz);
        console.log(valuex);
        if (valuex === 'true') {
            console.log('true--->>>> set to false----' + zoneidz);
            var zstate = 'false';//manageshelvingtab
            $.confirm({
                title: 'Message!',
                content: 'Your about to Deactivate this Zone',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {zonestate: zstate, zoneid: zoneidz},
                                url: "localsettigs/activateDeactivatezone.htm",
                                success: function (data) {}
                            });
                            $('.sliderxx').val("false");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('localsettigs/manageshelvingtab.htm', 'contentminex', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        } else if (valuex === 'false') {
            console.log('false--->>>> set to true-----' + zoneidz);
            var zstate = 'true';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Activate this Zone',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {zonestate: zstate, zoneid: zoneidz},
                                url: "localsettigs/activateDeactivatezone.htm",
                                success: function (data) {}
                            });
                            $('.sliderxx').val("true");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('localsettigs/manageshelvingtab.htm', 'contentminex', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });

        }
    }
    function sliderF(zoneidz, valuex) {
        console.log(zoneidz);
        console.log(valuex);
        if (valuex === 'false') {
            console.log('false--->>>> set to true-----' + zoneidz);
            var zstate = 'true';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Activate this Zone',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {zonestate: zstate, zoneid: zoneidz},
                                url: "localsettigs/activateDeactivatezone.htm",
                                success: function (data) {}
                            });
                            $('.sliderxx2').val("true");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('localsettigs/manageshelvingtab.htm', 'contentminex', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        } else if (valuex === 'true') {
            console.log('true--->>>> set to false----' + zoneidz);
            var zstate = 'false';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Deactivate this Zone',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {zonestate: zstate, zoneid: zoneidz},
                                url: "localsettigs/activateDeactivatezone.htm",
                                success: function (data) {}
                            });
                            $('.sliderxx2').val("false");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('localsettigs/manageshelvingtab.htm', 'contentminex', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        }
    }
</script>                                          