<%-- 
    Document   : seviceroomassignment
    Created on : Jul 28, 2018, 2:45:21 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<div id="assigningservices">
    <input id="serviceid" class="hidedisplaycontent" value="${serviceid}">
    <input id="facilityunitserviceid" class="hidedisplaycontent" value="${facilityunitserviceid}">
    <div class="col-md-4 col-sm-4" style="margin-top: 2em">
        <form action="" class="formName">
            <div class="form-group">
                <label>Select Building</label>
                <select class="form-control" id="activity-select">
                    <c:forEach items="${buildings}" var="building">
                        <option value="${building.buildingid}">${building.buildingname}</option>
                    </c:forEach>
                </select>
            </div>
        </form>
    </div>
    <input class="hidedisplaycontent" id="buildingid" value="${buildingid}">
    <fieldset>
        <table class="table table-hover table-bordered" id="datatable">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Block</th>
                    <th>Floor</th>
                    <th>Room</th>
                    <th class="center">Assign Service|<a style="color: white" id="checkb" onclick="checkal()">Select All</a></th>
                </tr>
            </thead>
            <tbody>
                <% int m = 1;%>
                <c:forEach items="${blockroomlist}" var="details">
                    <c:if test="${ empty details.facilityunitserviceid}">
                        <tr>
                            <td><%=m++%></td>
                            <td>${details.blockname}</td>
                            <td>${details.floorname}</td>
                            <td>${details.roomname}</td>
                            <td class="center">
                                <input class="form-check-input" data-id="${details.facilityunitroomid}" data-id1="${details.facilityunitserviceid}" data-id2="${details.facilityunitroomserviceid}" type="checkbox" name="type" onChange="if (this.checked) {
                                            checkeditem('checked', $(this).attr('data-id'), $(this).attr('data-id1'), $(this).attr('data-id2'));
                                        } else {
                                            checkeditem('unchecked', $(this).attr('data-id'), $(this).attr('data-id1'), $(this).attr('data-id2'));
                                        }">
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty details.facilityunitserviceid}">
                        <tr style="background-color: yellow">
                            <td><%=m++%></td>
                            <td>${details.blockname}</td>
                            <td>${details.floorname}</td>
                            <td>${details.roomname}</td>
                            <td class="center">
                                <form id="checkform">
                                    <input class="form-check-input" id="checkedbox" data-id="${details.facilityunitroomid}" data-id1="${details.facilityunitserviceid}" data-id2="${details.facilityunitroomserviceid}" type="checkbox" name="type" onChange="if (this.checked) {
                                                checkeditem('checked', $(this).attr('data-id'), $(this).attr('data-id1'), $(this).attr('data-id2'));
                                            } else {
                                                checkeditem('unchecked', $(this).attr('data-id'), $(this).attr('data-id1'), $(this).attr('data-id2'));
                                            }">

                                </form>

                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </fieldset>

</div>

<script>
    $(document).ready(function () {
        $('#datatable').DataTable();
        $('#checkform input[type=checkbox]').attr('checked', true);
        $("input[type='checkbox']").change(function (e) {
            if ($(this).is(":checked")) {
                $(this).closest('tr').addClass("highlight");
            } else {
                $(this).closest('tr').removeClass("highlight");
            }
        });
        var buildingid = $('#activity-select').val();
        console.log("---------buildingid----------"+buildingid);
        ajaxSubmitData('serviceallocation/unassignedservices.htm', 'assigningservices', '&buildingid=' + buildingid + '&serviceid=' + serviceid + '', 'GET');
    });
    
    
//    $('#activity-select').change(function () {
//        var buildingid = $(this).val();
//        var serviceid = $('#serviceid').val();
//        if (buildingid === null) {
//            $.confirm({
//                title: 'Encountered an error!',
//                content: 'Please add locations to units before assigning them services',
//                type: 'red',
//                typeAnimated: true,
//                buttons: {
//                    Ok: {
//                        text: 'Try again',
//                        btnClass: 'btn-red',
//                        action: function () {
//                        }
//                    },
//                    close: function () {
//                    }
//                }
//            });
//        } else {
//            ajaxSubmitData('serviceallocation/unassignedservices.htm', 'assigningservices', '&buildingid=' + buildingid + '&serviceid=' + serviceid + '', 'GET');
//        }
//    });
    function checkeditem(type, facilityunitroomid, facilityunitroomserviceid, facilityunitroomserviceid) {
        var facilityunitserviceid = $('#facilityunitserviceid').val();
        var buildingid = $('#buildingid').val();
        var serviceid = $('#serviceid').val();
        if (type === 'checked') {
            $.confirm({
                title: 'Alert!!',
                content: 'You are about to activate a service to a location.',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Continue',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {facilityunitserviceid: facilityunitserviceid, facilityunitroomid: facilityunitroomid},
                                url: 'serviceallocation/savecheckedroomservice.htm',
                                success: function (res) {
                                    ajaxSubmitData('serviceallocation/unassignedservices.htm', 'assigningservices', '&facilityunitserviceid=' + facilityunitserviceid + '&serviceid=' + serviceid + '', 'GET');
                                    ajaxSubmitData('serviceallocation/servicelocationmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    },
                    close: function () {

                    }
                }
            });

        } else if (type === 'unchecked') {
            $.confirm({
                title: 'Alert!!',
                content: 'You are about to deactivate a service from a location.',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Continue.',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {facilityunitroomserviceid: facilityunitroomserviceid},
                                url: 'serviceallocation/uncheckedroomservice.htm',
                                success: function (res) {
                                    ajaxSubmitData('serviceallocation/unassignedservices.htm', 'assigningservices', '&facilityunitserviceid=' + facilityunitserviceid + '&serviceid=' + serviceid + '', 'GET');
                                    ajaxSubmitData('serviceallocation/servicelocationmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    $.notify({
                                        title: "Unassignment complete : ",
                                        message: "This service has been unassigned to the listed room(s)",
                                        icon: 'fa fa-close'
                                    }, {
                                        type: "info"
                                    });
                                }
                            });
                        }
                    },
                    close: function () {
                    }
                }
            });

        } else {
        }
    }
</script>