<%-- 
    Document   : groupClassificationCategory
    Created on : Aug 7, 2018, 3:20:31 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-6"></div>
    <div class="col-md-6">
       <button onclick="askwhichtype();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Classification</button>  
    </div>
</div>
<table class="table table-hover table-bordered" id="groupclassificationcategorydtailsTable">
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
        <c:forEach items="${classificationFound}" var="b">
            <tr>
                <td><%=k++%></td>
                <td>${b.classificationname}</td>
                <td>${classificationdescription}</td>
                <td align="center">
                    <span  title="Edit Of This Classification." onclick="updateClassificationsDetails(${b.itemclassificationid},'${b.classificationname}','${classificationdescription}',${itemclassificationid});" class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                    |
                    <span onclick="deleteSectionClassifications(${b.itemclassificationid},${itemclassificationid});" title="Delete Of This Classification."  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#groupclassificationcategorydtailsTable').DataTable();
    function updateClassificationsDetails(itemclassificationid,classificationname,classificationdescription,parentid){
      $.confirm({
            title: 'UPDATE CLASSIFICATION',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Classification</label>' +
                    '<input type="text" value="' + classificationname + '" class="classifname2 form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>More Info</label>' +
                    '<textarea class="form-control classifnamedescrip2"  rows="3">'+classificationdescription+'</textarea>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var name = this.$content.find('.classifname2').val();
                        var descname = this.$content.find('.classifnamedescrip2').val();
                        if (!name) {
                            $.alert('provide a valid name');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {itemclassificationid:itemclassificationid,descname:descname,name:name},
                            url: "essentialmedicinesandsupplieslist/updateClassificationsundriesDetails.htm",
                            success: function (data) {
                                ajaxSubmitData('essentialmedicinesandsupplieslist/getgroupClassificationCategory.htm', 'categoryItemsDivs', 'itemclassificationid=' + parentid + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {
                    
                }
            }
        });   
    }
    function deleteSectionClassifications(itemclassificationid,parentid){
    $.ajax({
            type: 'POST',
            data: {itemclassificationid: itemclassificationid},
            url: "essentialmedicinesandsupplieslist/deleteSectionSundriesClassifications.htm",
            success: function (data) {
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
                    ajaxSubmitData('essentialmedicinesandsupplieslist/getgroupClassificationCategory.htm', 'categoryItemsDivs', 'itemclassificationid=' + parentid + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                }
            }
        });    
    }
</script>