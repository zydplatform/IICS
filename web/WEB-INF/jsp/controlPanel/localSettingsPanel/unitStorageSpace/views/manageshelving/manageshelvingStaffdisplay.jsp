<%-- 
    Document   : manageshelvingStaffdisplay
    Created on : Apr 12, 2018, 8:07:00 AM
    Author     : IICSRemote
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <div id="manageshelvedialogxxx" class="modalDialogShelve">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h5 class="modalDialog-title">Manage Staff Activity in Zone &nbsp;<strong style="color:green;">${staffvmember.Zonelabel}</strong></h5>
                    <hr>
                </div>
                <div class="scrollbar" id="content">                        
                    <div class="container" id="staffList">
                        <div class="">                                   
                            <h5>List of Staff </h5>
                        </div><br>
                        <input class="form-control col-md-4 col-ms-4" id="searchstaff" type="text" placeholder="search Staff.........."><br>                    
                        <div>
                            <div class="col-md-12">                        
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="list-group"  style="max-height: 350px;overflow-y: scroll;" id="staffnames">
                                            <% int j = 1;%>
                                            <c:forEach items="${staffmembers}" var="a">
                                                <button class="list-group-item list-group-item-action" id="${staffvmember.zoneid},${a.StaffName},${a.staffid},${staffvmember.Zonelabel}" onclick="selectedStaff(this.id)"><%=j++%>.&nbsp; <i class="fa fa-fw fa-lg fa-user"></i> &nbsp;${a.StaffName}</button>
                                            </c:forEach>
                                        </div>
                                    </div>                                
                                </div>
                            </div>                        
                        </div>                        
                        <!--  <div class="modal-footer">
                               <button type="submit" class="btn btn-default btn-default" data-number="1"><span class="glyphicon glyphicon-remove"></span> Close</button>
                           </div>  -->                  
                    </div>
                    <div class="container">
                        <div id="showStaffUnitsx" class="hidedisplaycontent">
                            <button class="btn btn-secondary" onclick="back2staffList()"><i class="fa fa-arrow-left"></i>&nbsp;Back</button>
                            <div id="staffmanageunits">
                                Loading content please wait................
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
        window.location = '#manageshelvedialogxxx';
        initDialog('modalDialogShelve');
        $("#searchstaff").keyup(function () {
            var value = $(this).val().toLowerCase();
            $("#staffnames a").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
    });
    function back2staffList() {
        $('#staffList').show();
        $('#showStaffUnitsx').hide();
    }
    function selectedStaff(id) {       
        var p = new Array();
        p = id.split(",");
        var zoneid = p[0];
        var staffname = p[1];
        var staffid = p[2];
        var zonelabel = p[3];
        ajaxSubmitDataNoLoader('localsettigs/staffstoreunit.htm', 'staffmanageunits', 'selectedzoneid=' + zoneid + '&staffnames=' + staffname + '&staffid=' + staffid + '&zonelabel=' + zonelabel + '&act=a&0&ofst=1&maxR=100&sStr=', 'GET');
        $('#staffList').hide();
        $('#showStaffUnitsx').show();
    }
</script> 