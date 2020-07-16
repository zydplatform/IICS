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
            <legend style="font-weight: bold">Add Designation Categories</legend>
        </div>

        <!-- panel preview -->
        <div class="col-md-5">
            <h5>Attach Categories:</h5>
            <input type="hidden" id="domainid" value="${domainid}"/>
            <div class="panel panel-default">
                <fieldset style="min-height:100px">
                    <div class="panel-body form-horizontal payment-form">

                        <div class="col-md-12" style="padding: 0 ! important">
                            <label class="col-form-label col-form-label" for="">Domain Name</label>
                            <input type="text" class="form-control form-control" id="facilitydomainnamecat" type="text" readonly="" value="${domainname}">
                        </div>&nbsp;
                        
                        <input type="hidden" value="1" id="id-cat"/>
                        <div class="col-md-12" style="padding: 0 ! important">
                            <label class="control-label" for="categoryname">Category Name:<span class="symbol required"></label>
                            <div>
                                <input class="form-control" type="text" id="categoryname" name="categoryname" placeholder="Level Name">
                            </div>
                        </div>&nbsp;

                        <div class="col-md-12" style="padding: 0 ! important">
                            <label class="control-label" for="description">About Category:</label>
                            <div>
                                <textarea class="form-control" rows="2" id="descriptioncat" name="descriptioncat" placeholder="About Level"></textarea>
                            </div>
                        </div>&nbsp;

                        <div class="">
                            <button class="btn btn-primary pull-right" id="btnAddNewDomainCategory" type="button"><i class="fa fa-fw fa-lg fa-plus-circle"></i>Add</button>
                        </div>
                    </div>

                </fieldset>
            </div>
        </div>

        <!-- / panel preview -->
        <div class="col-md-7">
            <h5>Preview Domain Categories:</h5>
            <div class="row">
                <div class="col-md-12" style="padding: 0 ! important">
                    <div class="table-responsive row">
                        <table class="table preview-table" id="myTable">
                            <thead>
                                <tr>
                                    <th class="center">No</th>
                                    <th>Category Name</th>
                                    <th>Details</th>
                                    <th class="center"></th>
                                </tr>
                            </thead>
                            <tbody id="tableAttatchedDomainCategoty">

                            </tbody>
                        </table>
                        <div id="addnew-pane"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12" style="padding: 0 ! important">
                    <hr style="border:1px dashed #dddddd;">
                    <button type="button" id="submitDesiginationCategories" class="btn btn-info btn-block">Submit Domain Category</button>
                </div>
            </div>
            <div id="snackbar"></div>
        </div>
    </div>
</div>

<script>
    var domainCategoryObjectList = [];
    var categoryItemList = new Set();
    $('#btnAddNewDomainCategory').click(function () {
        var domainid = $('#domainid').val();
        var categoryname = document.getElementById('categoryname').value;
        var description = document.getElementById('descriptioncat').value;
        if (categoryname === null || categoryname === '' || description === null || description === '') {
            if (categoryname === null || categoryname === '') {
                document.getElementById('categoryname').focus();
            }
            if (description === null || description === '') {
                document.getElementById('descriptioncat').focus();
            }
        } else {
            var categoryname = $('#categoryname').val();
            var description = $('#descriptioncat').val();
            var idCat = $('#id-cat').val();

            categoryItemList.add(idCat);
            <% int m = 1;%>
            $('#tableAttatchedDomainCategoty').append(
                    '<tr><td class="center"><%=m++%></td>' +
                    '<td align = "">' + categoryname + '</td>' +
                    '<td align = "">' + description + '</td>' +
                    '<td class="center">' +
                    '<span class="badge badge-danger icon-custom" onclick="remove(\'' + id + '\')">' +
                    '<i class="fa fa-trash-o"></i></span></td></tr>'
                    );
            document.getElementById('categoryname').value = '';
            document.getElementById('descriptioncat').value = '';
            document.getElementById('id-cat').value = Number(document.getElementById('id-cat').value) + Number(1);

            var data = {
                domainid: domainid,
                categoryname: categoryname,
                idcat: idCat,
                description: description
            };
            console.log('DATA' + data);
            domainCategoryObjectList.push(data);
            console.log(domainCategoryObjectList);
        }
    });

//    $('#submitDesiginationCategories').click(function () {
//        if (categoryItemList.size > 0) {
//            var data = {
//                ids: JSON.stringify(Array.from(categoryItemList)),
//                items: JSON.stringify(domainCategoryObjectList)
//            };
//            $.ajax({
//                type: 'POST',
//                data: data,
//                url: 'facility/submitfacilitylevel.htm',
//                success: function (res) {
//                    if (res === 'Saved') {
//                        $('#tableAttatchedDomainCategoty').html('');
//                        levelsItemList = new Set();
//                        domainLevelsObjectList = [];
//                        $("#submitDomainLevels").hide();
//                    }
//                }
//            });
//        }
//    });

    function remove(id) {
        $('#row' + idCat).remove();
        levelsItemList.delete(id);
        console.log(levelsItemList);
    }
</script>
