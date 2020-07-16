<%-- 
    Document   : unassignedCells
    Created on : 23-May-2018, 18:12:37
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<div class="tile">
    <div class="row">
        <div class="col-md-7 col-sm-7">
            <h3 class="tile-title">Unassigned locations</h3>
        </div>
        <div class="col-md-4 col-sm-4 right" id="assignBtnDiv">
            <button class="btn btn-sm btn-primary icon-btn" onclick="assignSelectedCells()">
                <i class="fa fa-user-circle"></i>
                Assign To User
            </button>
        </div>
    </div>
    <table class="table table-hover table-striped" id="cellTable">
        <thead>
            <tr>
                <th>#</th>
                <th>Zone</th>
                <th>Bay</th>
                <th>Row</th>
                <th>Cell</th>
                <th class="center">Assign</th>
            </tr>
        </thead>
        <tbody>
            <% int m = 1;%>
            <c:forEach items="${unassignedCells}" var="cell">
                <tr>
                    <td><%=m++%></td>
                    <td>${cell.zone}</td>
                    <td>${cell.bay}</td>
                    <td>${cell.row}</td>
                    <td>${cell.cell}</td>
                    <td class="center">
                        <input class="form-check-input" type="checkbox" onclick="assignCell(${cell.id})">
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
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-4">
                        <div class="tile" id="searchTile">
                            <div class="tile-body">
                                <div id="search-form_3" class="search-form_3">
                                    <input id="staffSearch" type="text" oninput="searchStaff()" placeholder="Search Staff" class="search_3 dropbtn"/>
                                </div><br>
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
<script type="text/javascript">
    allCells = ${unassignedCellsJSON};
    $('#assignBtnDiv').hide();
    $('#cellTable').DataTable();
</script>