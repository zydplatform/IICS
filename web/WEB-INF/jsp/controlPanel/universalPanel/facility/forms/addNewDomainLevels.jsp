<%--
    Document   : addNewDomainLevels
    Created on : Mar 24, 2018, 3:31:14 PM
    Author     : Grace-K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp"%>
<div class="">
    <div class="row">

        <div class="col-md-12">
            <legend style="font-weight: bold">Add New Levels</legend>
        </div>

        <!-- panel preview -->
        <div class="col-md-5">
            <h5>Attach Levels:</h5>
            <input type="hidden" id="domainid" value="${domainid}"/>
            <div class="panel panel-default">
                <fieldset style="min-height:100px">
                    <div class="panel-body form-horizontal payment-form">

                        <div class="col-md-12" style="padding: 0 ! important">
                            <label class="col-form-label col-form-label" for="">Domain Name</label>
                            <input type="text" class="form-control form-control" id="facilitydomainname" type="text" readonly="" value="${domainname}">
                        </div>&nbsp;

                        <div class="col-md-12" style="padding: 0 ! important">
                            <label class="control-label" for="facilitylevelname">Facility Level Name:<span class="symbol required"></label>
                            <div>
                                <input class="form-control" type="text" id="facilitylevelname" name="facilitylevelname" placeholder="Level Name">
                            </div>
                        </div>&nbsp;

                        <div class="col-md-12" style="padding: 0 ! important">
                            <label class="control-label" for="shortname">Short Name:</label>
                            <div >
                                <input class="form-control" type="text" id="shortname" name="shortname" placeholder="Short Name">
                            </div>
                        </div>&nbsp;

                        <div class="col-md-12" style="padding: 0 ! important">
                            <label class="control-label" for="description">About Level:</label>
                            <div>
                                <textarea class="form-control" rows="2" id="description" name="description" placeholder="About Level"></textarea>
                            </div>
                        </div>&nbsp;

                        <div class="">
                            <button class="btn btn-primary pull-right" id="btnAddNewDomainLevel" type="button"><i class="fa fa-fw fa-lg fa-plus-circle"></i>Add</button>
                        </div>
                    </div>

                </fieldset>
            </div>
        </div>

        <!-- / panel preview -->
        <div class="col-md-7">
            <h5>Preview Facility Domain:</h5>
            <div class="row">
                <div class="col-md-12" style="padding: 0 ! important">
                    <div class="table-responsive row">
                        <table class="table preview-table" id="myTable">
                            <thead>
                                <tr>
                                    <th class="center">No</th>
                                    <th>Level Name</th>
                                    <th>Short Name</th>
                                    <th>Details</th>
                                    <th class="center"></th>
                                </tr>
                            </thead>
                            <tbody id="tableAttatchedFacilityLevels">

                            </tbody>
                        </table>
                        <div id="addnew-pane"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12" style="padding: 0 ! important">
                    <hr style="border:1px dashed #dddddd;">
                    <button type="button" id="submitDomainLevels" class="btn btn-info btn-block">Submit Facility Levels</button>
                </div>
            </div>
            <div id="snackbar"></div>
        </div>
    </div>
</div>

<script>
    var domainLevelsObjectList = [];
    var levelsItemList = new Set();
    $('#btnAddNewDomainLevel').click(function () {
        var domainid = $('#domainid').val();
        var facilitylevelname = document.getElementById('facilitylevelname').value;
        var shortname = document.getElementById('shortname').value;
        var description = document.getElementById('description').value;
        if (facilitylevelname === null || facilitylevelname === '' || description === null || description === '') {
            if (facilitylevelname === null || facilitylevelname === '') {
                document.getElementById('facilitylevelname').focus();
            }
            if (description === null || description === '') {
                document.getElementById('description').focus();
            }
        } else {
            var facilitylevelname = $('#facilitylevelname').val();
            var shortname = $('#shortname').val();
            var description = $('#description').val();

            levelsItemList.add(shortname);
    <% int q = 1;%>
            $('#tableAttatchedFacilityLevels').append(
                    '<tr><td class="center"><%=q++%></td>' +
                    '<td align = "">' + facilitylevelname + '</td>' +
                    '<td align = "">' + shortname + '</td>' +
                    '<td align = "">' + description + '</td>' +
                    '<td class="center">' +
                    '<span class="badge badge-danger icon-custom" onclick="remove(\'' + shortname + '\')">' +
                    '<i class="fa fa-trash-o"></i></span></td></tr>'
                    );
            document.getElementById('facilitylevelname').value = '';
            document.getElementById('shortname').value = '';
            document.getElementById('description').value = '';

            var data = {
                domainid: domainid,
                facilitylevelname: facilitylevelname,
                shortname: shortname,
                description: description
            };
            console.log('DATA'+data);
            domainLevelsObjectList.push(data);
            console.log(domainLevelsObjectList);
        }
    });

    $('#submitDomainLevels').click(function () {
        if (levelsItemList.size > 0) {
            var data = {
                ids: JSON.stringify(Array.from(levelsItemList)),
                items: JSON.stringify(domainLevelsObjectList)
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'facility/submitfacilitylevel.htm',
                success: function (res) {
                    if (res === 'Saved') {
                        $('#tableAttatchedFacilityLevels').html('');
                        levelsItemList = new Set();
                        domainLevelsObjectList = [];
                         $("#submitDomainLevels").hide();
                    }
                }
            });
        }
    });

    function remove(shortname) {
        $('#row' + shortname).remove();
        levelsItemList.delete(shortname);
        console.log(levelsItemList);
    }
</script>
