<%-- 
    Document   : viewassets
    Created on : Jun 7, 2018, 2:19:15 PM
    Author     : RESEARCH
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
    <div class="col-md-6" id="enterFac">
        <font size="3">
        <div class="form-group">
            <label for="exampleInputEmail1">Current Asset Classification:</label>
            <b>${classificationname}</b>
            <input class="form-control" id="classificationid" type="hidden" value="${classificationid}">
            <input class="form-control" id="classificationname" type="hidden" value="${classificationname}">
        </div>
        </font>
    </div>
    <div class="row">
        <div class="col-md-2" id="BldFac">
            <button class="btn btn-primary pull-left" type="button" onclick=" ajaxSubmitData('assetsmanagement/assetmanagementPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"  id="addfr"  href="#"><i class="fa fa-backward"></i>BACK</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <button onclick="addnewassets();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>Add Asset(s)</button>
        </div>
    </div>
    <div style="margin: 10px;">
        <fieldset style="min-height:100px;">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <table class="table table-hover table-bordered" id="assetsTable">
                                <thead>
                                    <tr>
                                        <th class="center">No.</th>
                                        <th class="center">Asset Name</th>
                                        <th class="center">Asset Unique Identifier</th>
                                         <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEASSETS')">   
                                         <th class="center">Manage Assets</th>
                                        </security:authorize></tr>
                                </thead>
                                <tbody>
                                    <% int f = 1;%>
                                    <% int a = 1;%>
                                    <c:forEach items="${viewAssetsInClassification}" var="g">
                                        <tr id="${g.assetsid}">
                                            <td class="center"><%=f++%></td>
                                            <td class="center">${g.assetsname}</td>
                                            <td class="center">${g.assetidentifier}</td>
                                       <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEASSETS')">   
                                            <td class="center">
                                                <div class="btn-group" role="group">
                                                    <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="fa fa-sliders" aria-hidden="true"></i>
                                                    </button>
                                                    <div class="dropdown-menu dropdown-menu-left">
                                                        <a class="dropdown-item" href="#!" onclick="editAsset(this.id);" id="editasset<%=a++%>">Edit Asset</a>
                                                    </div>
                                                </div>
                                            </td>
                                     </security:authorize>
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
    <div class="row">
        <div class="col-md-12" id="addasset">
            <div id="addassets" class="supplierCatalogDialog">
                <div>
                    <div id="divSection1">
                        <div id="head">
                            <a href="#close" title="Close" class="close2">X</a>
                            <h2 class="modalDialog-title">Add Asset(s) To A Classification</h2>
                            <hr>
                        </div>
                        <div class="row scrollbar" id="assetcontent">

                        </div>                                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#assetsTable').DataTable();
    $('[data-toggle="popover"]').popover();


    function addnewassets() {
        window.location = '#addassets';
        initDialog('supplierCatalogDialog');
        var classificationid = $('#classificationid').val();
        var classificationname = $('#classificationname').val();

        ajaxSubmitData('assetsmanagement/addasset.htm', 'assetcontent', 'tablerowid=' + classificationid + '&tableData=' + classificationname + '&nvb=0', 'GET');

    }

    function editAsset(value) {
        var tablerowid = $('#' + value).closest('tr').attr('id');
        var tableData = $('#' + tablerowid).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();

        $.confirm({
            title: 'Edit Asset!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Asset Name</label>' +
                    '<input type="text" id="editedassetname" value="' + tableData[1] + '" class="name form-control" required />' +
                    '<input placeholder="Classification Name" id="editedasseetid" value="' + tablerowid + '" class="name form-control" type="hidden" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Enter Asset Unique Identifier</label>' +
                    '<input type="text"id="editedassetuniqueid" value="' + tableData[2] + '" class="type form-control" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Save',
                    btnClass: 'btn-blue',
                    action: function () {
                        var name = this.$content.find('.name').val();
                        var type = this.$content.find('.type').val();
                        if (!name) {
                            $.alert('provide a valid name');
                            return false;
                        }
                        if (!type) {
                            $.alert('provide a valid Identifier');
                            return false;
                        }
                        var assetclassificationid = $('#classificationid').val();
                        var assetid = $('#editedasseetid').val();
                        var assetname = $('#editedassetname').val();
                        var assetuniqueid = $('#editedassetuniqueid').val();

                        var data = {
                            assetclassificationid: assetclassificationid,
                            assetid: assetid,
                            assetname: assetname,
                            assetuniqueid: assetuniqueid

                        };

                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "assetsmanagement/Updateasset.htm",
                            data: data,
                            success: function (response) {
                                var classificationId = $('#classificationid').val();
                                var classificationName = $('#classificationname').val();
                                ajaxSubmitData('assetsmanagement/viewassets.htm', 'viewall', 'classificationId=' + classificationId + '&classificationName=' + classificationName + '&nvb=0', 'GET');

                            }

                        });
                        $.alert('<span><strong>Asset name:' + ' ' + name + '<br><br>Asset Unique Id:' + ' ' + type + '</strong></span>');
                    }
                },
                cancel: function () {
                    //close
                },
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
</script>