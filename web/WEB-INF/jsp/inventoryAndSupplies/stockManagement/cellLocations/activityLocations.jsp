<%--
    Document   : cells
    Created on : 16-May-2018, 14:32:04
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty activities}">
    <div class="row">
        <div class="col-md-4 col-sm-4">
            <form action="" class="formName">
                <div class="form-group">
                    <select class="form-control" id="activity-select">
                        <c:forEach items="${activities}" var="activity">
                            <option value="${activity.id}">${activity.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </form>
        </div>
        <div class="col-md-7 col-sm-7 right">
            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                <div class="btn-group" role="group">
                    <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-sliders" aria-hidden="true"></i>
                    </button>
                    <div class="dropdown-menu dropdown-menu-left">
                        <a class="dropdown-item" href="#!" id="load-assigned-cells">Assigned</a><hr>
                        <a class="dropdown-item" href="#!" id="load-unassigned-cells">Unassigned</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12" id="cellPaneContent">

        </div>
    </div>
</c:if>
<c:if test="${empty activities}">
    <div class="row">
        <div class="col-md-12 text-center">
            <h5>
                No stock Taking Activities Set
            </h5>
        </div>
    </div>
</c:if>
<c:if test="${not empty activities}">
    <script type="text/javascript">
        var reload = false;
        var allCells = [];
        var activityid = 0;
        var selectedCells = new Set();
        $(document).ready(function () {
            $('#cellTable').DataTable();
            $('#activity-select').select2();
            $('.select2').css('width', '100%');
            activityid = $('#activity-select').val();
            ajaxSubmitData('stock/fetchActivityAssignedCells.htm', 'cellPaneContent', '&activityid=' + activityid, 'POST');
            $('#activity-select').change(function () {
                reloadStaffAllocations();
            });
            $('#load-unassigned-cells').click(function () {
                $('#cellPaneContent').html('');
                activityid = $('#activity-select').val();
                ajaxSubmitData('stock/fetchActivityUnassignedCells.htm', 'cellPaneContent', '&activityid=' + activityid, 'POST');
            });
            $('#load-assigned-cells').click(function () {
                $('#cellPaneContent').html('');
                activityid = $('#activity-select').val();
                ajaxSubmitData('stock/fetchActivityAssignedCells.htm', 'cellPaneContent', '&activityid=' + activityid, 'POST');
            });
        });

        function assignCell(cellId) {
            if (!selectedCells.has(cellId)) {
                selectedCells.add(cellId);
                $('#assignBtnDiv').show();
            } else {
                selectedCells.delete(cellId);
                if (selectedCells.size < 1) {
                    $('#assignBtnDiv').hide();
                }
            }
        }

        function assignSelectedCells() {
            if (selectedCells.size === 1) {
                $('#assignCellsTitle').html(selectedCells.size + ' Cell Selected.');
            } else {
                $('#assignCellsTitle').html(selectedCells.size + ' Cells Selected.');
            }
            ajaxSubmitData('stock/fetchUnitStaff.htm', 'searchResults2', 'activityid=' + activityid, 'POST');
            window.location = '#assignCellStaffDialog';
            initDialog('assignCellStaffDialog');
            var div = $('.assignCellStaffDialog > div').height();
            var divHead = $('.assignCellStaffDialog > div > #head').height();
            var searchForm = $('.search-form_3').height();
            $('#searchResults2').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.16) - parseInt(searchForm));
            $(window).resize(function () {
                div = $('.assignCellStaffDialog > div').height();
                divHead = $('.assignCellStaffDialog > div > #head').height();
                searchForm = $('.search-form_3').height();
                $('#searchResults2').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.16) - parseInt(searchForm));
            });
            $('#cellPreview').html('');
            var cells = Array.from(selectedCells);
            for (i in cells) {
                for (j in allCells) {
                    if (allCells[j].id === cells[i]) {
                        $('#cellPreview').append(
                                '<tr id="pre' + allCells[j].id + '">' +
                                '<td>' + allCells[j].zone + '</td>' +
                                '<td>' + allCells[j].bay + '</td>' +
                                '<td>' + allCells[j].row + '</td>' +
                                '<td>' + allCells[j].cell + '</td>' +
                                '<td class="center">' +
                                '<span class="badge badge-danger icon-custom" onclick="remove(' + allCells[j].id + ')">' +
                                '<i class="fa fa-close"></i></span></td>' +
                                '</tr>'
                                );
                    }
                }
            }
        }

        function remove(rowId) {
            $('#pre' + rowId).remove();
            selectedCells.delete(rowId);
        }

        function viewStaffCells(staffid, staffNames) {
            reload = false;
            $('#staffCells').html('');
            $('#countSheet').html('');
            $('#selected-staff').val(staffid);
            $('#staffCellTitle').html(staffNames);
            window.location = '#view-staff-cells';
            initDialog('view-staff-cells');
            ajaxSubmitData('stock/fetchStaffCells.htm', 'staffCells', 'activityid=' + activityid + '&staffid=' + staffid, 'POST');
            ajaxSubmitData('stock/fetchStaffCountSheet.htm', 'countSheet', 'activityid=' + activityid + '&staffid=' + staffid, 'POST');
        }

        function unassignActivityCell(cellid, cellLabel) {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Unassign ' + cellLabel + "!",
                content: 'Cell <strong>' + cellLabel + '</strong> will be unassigned from <strong>' + $('#staffCellTitle').html() + '</strong>.',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Remove Cell',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {id: cellid},
                                url: 'stock/unassignStaffCell.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        reload = true;
                                        var staffid = $('#selected-staff').val();
                                        ajaxSubmitData('stock/fetchStaffCells.htm', 'staffCells', 'activityid=' + activityid + '&staffid=' + staffid, 'POST');
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    }
                                }
                            });
                        }
                    },
                    close: {
                        text: 'Cancel',
                        action: function () {

                        }
                    }
                }
            });
        }

        function searchStaff() {
            var input, filter, ul, li, a, i, p;
            input = document.getElementById('staffSearch');
            filter = input.value.toUpperCase();
            ul = document.getElementById("foundItems");
            li = ul.getElementsByTagName('li');

            for (i = 0; i < li.length; i++) {
                a = li[i].getElementsByTagName("h5")[0];
                p = li[i].getElementsByTagName("p")[0];
                if (a.innerHTML.toUpperCase().indexOf(filter) > -1 || p.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                } else {
                    li[i].style.display = "none";
                }
            }
        }

        function reloadStaffAllocations() {
            $('#cellPaneContent').html('');
            activityid = $('#activity-select').val();
            ajaxSubmitData('stock/fetchActivityAssignedCells.htm', 'cellPaneContent', '&activityid=' + activityid, 'POST');
        }

        function printUserReport(fileName) {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Print User Report!',
                content: '<div id="printBox" class="center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>',
                type: 'purple',
                typeAnimated: true,
                boxWidth: '70%',
                useBootstrap: false,
                buttons: {
                    close: {
                        text: 'Close',
                        action: function () {

                        }
                    }
                },
                onContentReady: function () {
                    var printBox = this.$content.find('#printBox');
                    $.ajax({
                        type: 'GET',
                        data: {file: fileName},
                        url: 'stock/createUserStockReportPDF.htm',
                        success: function (res) {
                            if (res !== '') {
                                var objbuilder = '';
                                objbuilder += ('<object width="100%" height="500px" data="data:application/pdf;base64,');
                                objbuilder += (res);
                                objbuilder += ('" type="application/pdf" class="internal">');
                                objbuilder += ('<embed src="data:application/pdf;base64,');
                                objbuilder += (res);
                                objbuilder += ('" type="application/pdf"/>');
                                objbuilder += ('</object>');
                                printBox.html(objbuilder);
                            } else {
                                printBox.html('<div class="bs-component">' +
                                        '<div class="alert alert-dismissible alert-warning">' +
                                        '<h4>Warning!</h4>' +
                                        '<p>Error generating PDF. <strong>Close User Dialog and Open Again.</strong></p></div></div>'
                                        );
                            }
                        }
                    });
                }
            });
        }
    </script>
</c:if>