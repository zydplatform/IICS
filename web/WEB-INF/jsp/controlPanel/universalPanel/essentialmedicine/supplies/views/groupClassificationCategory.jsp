<%-- 
    Document   : groupClassificationCategory
    Created on : Aug 10, 2018, 9:17:41 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<div class="row">
    <div class="col-md-6"></div>
    <div class="col-md-6">
        <button onclick="addfromExistingClass();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Classification</button>  
    </div>
</div>
<table class="table table-hover table-bordered" id="groupclassificationsuppliescategorydtailsTable">

    <thead>
        <tr>
            <th>No</th>
            <th>Classification Name</th>
            <th>More Info</th>
            <th>Update</th>
        </tr>
    </thead>
    <tbody>
        <% int k = 1;%>
        <% int p = 1;%>
        <c:forEach items="${classificationFound}" var="b">
            <tr>
                <td><%=k++%></td>
                <td>${b.classificationname}</td>
                <td></td>
                <td align="center">
                    <span  title="Edit Of This Category." onclick="updateClassificationsundriesDetails(${b.itemclassificationid}, '${b.classificationname}', '${b.classificationdescription}',${itemclassificationid});" class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                    |
                    <span onclick="deleteSectionSundriesClassifications(${b.itemclassificationid},${itemclassificationid});" title="Delete Of This Category."  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<script>
    $('#groupclassificationsuppliescategorydtailsTable').DataTable();
    function deleteSectionSundriesClassifications(itemclassificationid, parentid) {
        $.ajax({
            type: 'POST',
            data: {itemclassificationid: itemclassificationid},
            url: "essentialmedicinesandsupplieslist/deleteSectionSundriesClassifications.htm",
            success: function (data, textStatus, jqXHR) {
                if (data === 'comps') {
                    $.confirm({
                        title: 'Encountered an error!',
                        content: 'Can Not Be Deleted Because Of Attachments',
                        type: 'red',
                        icon: 'fa fa-warning',
                        typeAnimated: true,
                        buttons: {
                            close: function () {

                            }
                        }
                    });
                } else if (data === 'deleted') {
                    ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliesgroupsclassificationcategories.htm', 'SuppliescategoryItemsDivs', 'itemclassificationid=' + parentid + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                }
            }
        });
    }
    function updateClassificationsundriesDetails(itemclassificationid, classificationname, desc, parentid) {
        $.confirm({
            title: 'UPDATE CLASSIFICATION',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Classification</label>' +
                    '<input type="text" value="' + classificationname + '" class="classifname form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>More Info</label>' +
                    '<textarea class="form-control classifnamedescrip" rows="3">'+desc+'</textarea>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var name = this.$content.find('.classifname').val();
                        var descname = this.$content.find('.classifnamedescrip').val();
                        if (!name) {
                            $.alert('provide a valid name');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {itemclassificationid:itemclassificationid,descname:descname,name:name},
                            url: "essentialmedicinesandsupplieslist/updateClassificationsundriesDetails.htm",
                            success: function (data) {
                                ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliesgroupsclassificationcategories.htm', 'SuppliescategoryItemsDivs', 'itemclassificationid=' + parentid + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {
                    
                }
            }
        });
    }
</script>