<%-- 
    Document   : staffunits
    Created on : Sep 24, 2018, 8:20:18 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<!DOCTYPE html>
<div id="staffunitsection">
    <div class="row">
        <div class="col-md-7">
        </div>
        <div class="col-md-5" id="BldFac">
            <button class="btn btn-primary pull-right" onclick="addunits()" type="button"  id=""  href="#" style="float: right"><i class="fa fa-plus-circle"></i>Add Unit(s)</button>
        </div>
    </div>
    <input type="hidden" value="${staffid}" id="staffid">

    <fieldset>
        <div id="staffunitssection">
            <table class="table table-hover table-bordered col-md-12" id="unitstable">
                <thead class="col-md-12">
                    <tr>
                        <th>No</th>
                        <th>Facility Unit Name</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody class="col-md-12" id="tableFacilityOwner">
                    <% int m = 1;%>
                    <c:forEach items="${staffunits}" var="data">
                        <tr>
                            <td><%=m++%></td>
                            <td>${data.facilityunitname}</td>
                            <c:if test="${data.active  eq true}">
                                <td>
                                    <label class="switch">
                                        <input type="checkbox"  class="deactivateunit" value="true" onclick="deactivateunit(${data.stafffacilityunitid}, $(this).val())" checked>
                                        <span class="slider round"></span>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             round"></span>
                                    </label>
                                </td>
                            </c:if>
                            <c:if test="${data.active  eq false}">
                                <td>
                                    <label class="switch">
                                        <input type="checkbox"  class="activateunit" value="false" onclick="activateunit(${data.stafffacilityunitid}, $(this).val())" >
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </c:if>
                        </c:forEach>
                </tbody>
            </table>
        </div>
    </fieldset>
</div>

<script>
    $(document).ready(function () {
        $('#unitstable').DataTable();
        $('#activeunits input[type=checkbox]').attr('checked', true);
    });
    function addunits() {
        var staffid = $('#staffid').val();
        $.ajax({
            type: 'GET',
            data: {staffid: staffid},
            url: "usermanagement/facilityunits.htm",
            success: function (respose) {
                $.confirm({
                    title: '<strong class="center">Select Unit(s)' + '<font color="green"></font>' + '</strong>',
                    content: '' + respose,
                    boxWidth: '30%',
                    height: '100%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    draggable: true
                });
            }
        });

    }
    function deactivateunit(stafffacilityunitid, value) {
        if (value === 'true') {
            $.confirm({
                title: 'Message!',
                content: 'Your about to deactivate this Unit',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                cache: false,
                                dataType: 'text',
                                data: {stafffacilityunitid: stafffacilityunitid},
                                url: "usermanagement/deactivateunit.htm",
                                success: function (data) {
                                    ajaxSubmitData('usermanagement/userdetails', 'Userdetails', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    ajaxSubmitData('usermanagement/staffunits', 'staffunitsection', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                                }
                            });
                            $('.deactivateunit').val("false");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('usermanagement/staffunits', 'staffunitsection', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                    }
                }
            });
        } else if (value === 'false') {
            $.confirm({
                title: 'Message!',
                content: 'Your about to Activate this Unit',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                cache: false,
                                dataType: 'text',
                                data: {stafffacilityunitid: stafffacilityunitid},
                                url: "usermanagement/activateunit.htm",
                                success: function (data) {
                                    ajaxSubmitData('usermanagement/userdetails', 'Userdetails', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    ajaxSubmitData('usermanagement/staffunits', 'staffunitsection', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                                }
                            });
                            $('.deactivateunit').val("true");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('usermanagement/staffunits', 'staffunitsection', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });

        }
    }
    function activateunit(stafffacilityunitid, value) {

        if (value === 'false') {
            $.confirm({
                title: 'Message!',
                content: 'Your about to Activate this unit',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                cache: false,
                                dataType: 'text',
                                data: {stafffacilityunitid: stafffacilityunitid},
                                url: "usermanagement/activateunit.htm",
                                success: function (data) {
                                    ajaxSubmitData('usermanagement/userdetails', 'Userdetails', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    ajaxSubmitData('usermanagement/staffunits', 'staffunitsection', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                                }
                            });
                            $('.activateunit').val("true");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('usermanagement/staffunits', 'staffunitsection', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        } else if (value === 'true') {
            $.confirm({
                title: 'Message!',
                content: 'Your about to Deactivate this unit',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                cache: false,
                                dataType: 'text',
                                data: {stafffacilityunitid: stafffacilityunitid},
                                url: "usermanagement/deactivateunit.htm",
                                success: function (data) {
                                    ajaxSubmitData('usermanagement/userdetails', 'Userdetails', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    ajaxSubmitData('usermanagement/staffunits', 'staffunitsection', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                                }
                            });
                            $('.activateunit').val("false");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('usermanagement/staffunits', 'staffunitsection', 'staffid=${staffid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        }
    }
</script>

