<%-- 
    Document   : unassignedCells
    Created on : 23-May-2018, 18:12:37
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<div class="tile">
    <div class="row">
        <div class="col-md-7 col-sm-7">
            <h3 class="tile-title">Assigned locations</h3>
        </div>
    </div>
    <table class="table table-hover table-striped" id="assignedCellTable">
        <thead>
            <tr>
                <th>#</th>
                <th>Staff</th>
                <th>No. of Cells</th>
                <th class="center">Completion [%]</th>
                <th class="center">Details</th>
            </tr>
        </thead>
        <tbody>
            <% int l = 1;%>
            <c:forEach items="${assignedStaff}" var="staff">
                <tr>
                    <td><%=l++%></td>
                    <td>${staff.names}</td>
                    <td>${staff.cellCount}</td>
                    <td class="center">
                        <fmt:formatNumber var="progress" value="${staff.completion}" maxFractionDigits="0"/>
                        <c:if test="${staff.completion < 40}">
                            <span class="badge badge-pill span-size-15 badge-danger">${progress}</span>
                        </c:if>
                        <c:if test="${staff.completion >= 40 }">
                            <c:if test="${staff.completion < 60}">
                                <span class="badge badge-pill span-size-15 badge-warning">${progress}</span>
                            </c:if>
                            <c:if test="${staff.completion >= 60}">
                                <c:if test="${staff.completion < 100}">
                                    <span class="badge badge-pill span-size-15 badge-info">${progress}</span>
                                </c:if>
                                <c:if test="${staff.completion == 100}">
                                    <span class="badge badge-pill span-size-15 badge-success">${progress}</span>
                                </c:if>
                            </c:if>
                        </c:if>
                    </td>
                    <td class="center">
                        <button class="btn btn-sm btn-secondary" onclick="viewStaffCells(${staff.id}, '${staff.names}')">
                            <i class="fa fa-dedent"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="assignCellStaffDialog" class="modalDialog assignCellStaffDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="assignCellsTitle"></h2>
                    <hr/>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-4">
                        <div class="tile" id="searchTile">
                            <div class="tile-body">
                                <div id="search-form_3" class="search-form_3">
                                    <input id="staffSearch" type="text" oninput="searchStaff()" placeholder="Search Staff" class="search_3 dropbtn"/>
                                </div><br/>
                                <div id="searchResults2" class="scrollbar">

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <h4 class="tile-title">Selected Cells.</h4>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Zone</th>
                                                <th>Bay</th>
                                                <th>Row</th>
                                                <th>Cell</th>
                                                <th class="center">Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody id="cellPreview">

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="view-staff-cells" class="supplierCatalogDialog view-staff-cells">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2 closeStaffCells">X</a>
                    <h2 class="modalDialog-title" id="staffCellTitle"></h2>
                    <hr/>
                </div>
                <div class="row scrollbar" id="content">
                    <input id="selected-staff" type="hidden"/>
                    <div class="col-md-12">
                        <div class="tabset">
                            <!-- Tab 6 -->
                            <input type="radio" name="tabset" id="tab6" aria-controls="locations" checked/>
                            <label for="tab6">Assigned Cells</label>
                            <!-- Tab 7 -->
                            <input type="radio" name="tabset" id="tab7" aria-controls="transactions"/>
                            <label for="tab7">Count Sheet</label>

                            <div class="tab-panels">
                                <section id="locations" class="tab-panel">
                                    <div class="col-md-12" id="staffCells">

                                    </div>
                                </section>
                                <section id="transactions" class="tab-panel">
                                    <div class="col-md-12" id="countSheet">

                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $('#unassignBtnDiv').hide();
        $('#assignedCellTable').DataTable();
        $('.closeStaffCells').click(function () {
            if (reload === true) {
                reloadStaffAllocations();
            }
            reload = false;
            console.log(reload);
        });
    });
</script>