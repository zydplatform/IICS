<%-- 
    Document   : nominateInternalFacilitySupplier
    Created on : Apr 23, 2018, 2:26:07 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <legend>Nominate Internal Facility Supplier</legend>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h4>Un-Nominated Facility Units</h4>
                                <p style="color: blue;">Tick Units to Nominate</p>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="tile">
                                            <div class="tile-body">
                                                <table class="table table-sm" id="unnomtable">
                                                    <thead>
                                                        <tr>
                                                            <th>No</th>
                                                            <th>Facility Unit Name</th>
                                                            <th>Abbreviation</th>
                                                             <th>Nominate</th></tr>
                                                    </thead>
                                                    <tbody id="">
                                                        <% int j = 1;%>
                                                        <c:forEach items="${unnominatedlist}" var="a">
                                                            <tr>
                                                                <td><%=j++%></td>
                                                                <td>${a.facilityunitname}</td>
                                                                <td>${a.shortname}</td>
                                                               <td align="center"><input value="${a.facilityunitid}" type="checkbox" onchange="if (this.checked) {
                                                                            nominateunnominatedunits('checked', this.value);
                                                                        } else {
                                                                            nominateunnominatedunits('unchecked', this.value);
                                                                        }"></td>
                                                              
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                                <div class="tile-footer" style="display: none;" id="nonnominatedunits">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <button class="btn btn-primary pull-right" type="button" onclick="savefacilityunitsnominations();"><i class="fa fa-fw fa-lg fa-check-circle"></i>Nominate Supplier</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <h4>Nominated Internal Suppliers:</h4>
                                <p style="color: blue;">Tick default supplier(s) to be removed</p>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="tile">
                                            <table class="table table-sm" id="nomtable">
                                                <thead>
                                                    <tr>
                                                        <th>No</th>
                                                        <th>Facility Unit Name</th>
                                                        <th>Abbreviation</th>
                                                        <th>Remove</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="">
                                                    <% int i = 1;%>
                                                    <c:forEach items="${nominatedlist}" var="b">
                                                        <tr>
                                                            <td><%=i++%></td>
                                                            <td>${b.facilityunitname}</td>
                                                            <td>${b.shortname}</td>
                                                            <td align="center"><input value="${b.facilityunitsupplierid}" type="checkbox" onchange="if (this.checked) {
                                                                        denominateunits('checked', this.value);
                                                                    } else {
                                                                        denominateunits('unchecked', this.value);
                                                                    }"></td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                            <div class="tile-footer" style="display: none;" id="denominatefacilityunits">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <button class="btn btn-primary pull-right" type="button" onclick="savefacilityunitsdenominations();"><i class="fa fa-fw fa-lg fa-check-circle"></i>Remove Internal Supplier</button>
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
            </div>
        </div>
    </fieldset>
</div>
<script>
    $('#unnomtable').DataTable();
    $('#nomtable').DataTable();
    var nominateunites = new Set();
    var denominateunites = new Set();
    function nominateunnominatedunits(type, value) {
        if (type === 'checked') {
            nominateunites.add(value);
        } else {
            nominateunites.delete(value);
        }
        if (nominateunites.size === 0) {
            document.getElementById('nonnominatedunits').style.display = 'none';
        } else {
            document.getElementById('nonnominatedunits').style.display = 'block';
        }
    }
    function denominateunits(type, value) {
        if (type === 'checked') {
            denominateunites.add(value);
        } else {
            denominateunites.delete(value);
        }
        if (denominateunites.size === 0) {
            document.getElementById('denominatefacilityunits').style.display = 'none';
        } else {
            document.getElementById('denominatefacilityunits').style.display = 'block';
        }
    }
    function savefacilityunitsnominations() {
        if (nominateunites.size !== 0) {
            $.ajax({
                type: 'POST',
                data: {values: JSON.stringify(Array.from(nominateunites)), type: 'nominate'},
                url: "nominateinternalfacilitySupplier/saveorupdatefacilityunitsnominations.htm",
                success: function (data, textStatus, jqXHR) {
                    $.toast({
                        heading: 'Success',
                        text: 'Saved Success fully !!!.',
                        icon: 'success',
                        hideAfter: 3000,
                        position: 'bottom-center'
                    });
                   ajaxSubmitData('nominateinternalfacilitySupplier/nominateinternalfacilitysupplierhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        }
    }
    function savefacilityunitsdenominations() {
        if(denominateunites.size !==0){
            $.ajax({
                type: 'POST',
                data: {values: JSON.stringify(Array.from(denominateunites)), type: 'remove'},
                url: "nominateinternalfacilitySupplier/saveorupdatefacilityunitsnominations.htm",
                success: function (data, textStatus, jqXHR) {
                    $.toast({
                        heading: 'Success',
                        text: 'Saved Success fully !!!.',
                        icon: 'success',
                        hideAfter: 3000,
                        position: 'bottom-center'
                    });
                   ajaxSubmitData('nominateinternalfacilitySupplier/nominateinternalfacilitysupplierhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            }); 
        }
    }
</script>