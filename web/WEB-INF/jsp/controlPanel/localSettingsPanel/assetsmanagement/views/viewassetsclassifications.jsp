<%-- 
    Document   : viewassetsclassifications
    Created on : Jun 7, 2018, 1:12:00 PM
    Author     : RESEARCH
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<input class="form-control myform" id="facilityidz" value="${FacilityList.facilityid}" type="hidden">
<input class="form-control myform" id="facilitynamez" value="${FacilityList.facilityname}" type="hidden" readonly="true">
<table class="table table-hover table-bordered" id="assetclassificationTable">
    <thead>
        <tr>
            <th class="center">No.</th>
            <th class="center">Classification Name</th>
            <th class="center">Allocation Type</th>
            <th class="center">No. Of Assets</th>
            <th class="center">Manage Asset Classification</th>
        </tr>
    </thead>
    <tbody>
        <% int i = 1;%>
        <% int x = 1;%>
        <% int j = 1;%>
        <c:forEach items="${viewClassificationList}" var="c">
            <tr id="${c.assetclassificationid}">
                <td class="center"><%=i++%></td>
                <td class="center">${c.classificationname}</td>
                <td class="center">${c.allocationtype}</td>
                <td class="center">
                    <c:if test="${c.assetsnumber == 0}">
                        <a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${c.classificationname} Has NO Assets please click manage button to Register Assets" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red; color: white" data-assetclassificationid="${c.assetclassificationid}" data-classificationname="${c.classificationname}">
                            <span id="blocksz">${c.assetsnumber}</span>
                        </a>
                    </c:if>
                    <c:if test="${c.assetsnumber > 0}">
                        <a><button id="viewrmz" class="btn btn-secondary btn-small center" style="border-radius: 50%;"  data-assetclassificationid="${c.assetclassificationid}" data-classificationname="${c.classificationname}" onclick="viewassetsinclassification(${c.assetclassificationid}, '${c.classificationname}');"><span id="classfy">${c.assetsnumber}</span></button></a>
                            </c:if>
                </td>
                <td class="center">
                    <div class="btn-group" role="group">
                        <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-sliders" aria-hidden="true"></i>
                        </button>
                        <div class="dropdown-menu dropdown-menu-left">
                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EDITASSETCLASSIFICATION')">   
                          <a class="dropdown-item" href="#!" onclick="editClassifications(this.id)" id="editbld<%=j++%>">Edit Asset Classification</a>
                           </security:authorize>
                            <a class="dropdown-item" style="cursor: pointer;" id="addassets<%=x++%>" onclick="addnewassets(this.id);">Add Asset</a>
                        </div>
                    </div>
                </td>

            </tr>

        </c:forEach>

    </tbody>
</table>

<div class="row">
    <div class="col-md-12" id="addasset">
        <div id="addassets" class="supplierCatalogDialog">
            <div>
                <div id="divSection">
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
<script>
    $('#assetclassificationTable').DataTable();
    $('[data-toggle="popover"]').popover();

    function editClassifications(value) {
        var tablerowid = $('#' + value).closest('tr').attr('id');
        var tableData = $('#' + tablerowid).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();

        $.confirm({
            title: 'Edit Asset Classification!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Classification Name</label>' +
                    '<input type="text" placeholder="Classification Name" id="editedclassname" value="' + tableData[1] + '" class="name form-control" required />' +
                    '<input placeholder="Classification Name" id="editedclassid" value="' + tablerowid + '" class="name form-control" type="hidden" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Enter Allocation Type</label>' +
                    '<input type="text" placeholder="Allocation Type" id="editedclasstype" value="' + tableData[2] + '" class="type form-control" required />' +
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
                            $.alert('provide a valid type');
                            return false;
                        }
                        if (!type) {
                            $.alert('provide a valid type');
                            return false;
                        }
                        var facilityid = $('#facilityidz').val();
                        var assetclassificationid = $('#editedclassid').val();
                        var classificationname = $('#editedclassname').val();
                        var allocationtype = $('#editedclasstype').val();

                        var data = {
                            facilityid: facilityid,
                            assetclassificationid: assetclassificationid,
                            classificationname: classificationname,
                            allocationtype: allocationtype

                        };

                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "assetsmanagement/UpdateassetClassification.htm",
                            data: data,
                            success: function (response) {
                                ajaxSubmitData('assetsmanagement/assetmanagementPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }

                        });
                        $.alert('<span><strong>Classification name:' + ' ' + name + '<br><br>Allocation type:' + ' ' + type + '</strong></span>');
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

    function addnewassets(value) {
        window.location = '#addassets';
        initDialog('supplierCatalogDialog');

        var tableData = $('#' + value).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + value).closest('tr').attr('id');

        ajaxSubmitData('assetsmanagement/addasset.htm', 'assetcontent', 'tablerowid=' + tablerowid + '&tableData=' + tableData[1] + '&nvb=0', 'GET');

    }
    
       function viewassetsinclassification(classificationId, classificationName) {
        ajaxSubmitData('assetsmanagement/viewassets.htm', 'viewall', 'classificationId=' + classificationId + '&classificationName=' + classificationName + '&nvb=0', 'GET');
    }
</script>