<%-- 
    Document   : itemDetails
    Created on : Aug 22, 2018, 12:24:44 PM
    Author     : IICS
--%>

<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">
    <div class="col-md-4"></div>
    <div class="col-md-4">
        <span><b>Item Name:</b></span> <h5 style="" id="displaysundsthenavigationspanItem"><span class="badge badge-secondary"><strong id="dispthenavigationspanItem">${name}</strong></span></h5> 
    </div>
    <div class="col-md-4"></div>
</div>
<table class="table table-hover table-bordered" id="searchedsundriesitemcategorydtailsTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Specification</th>
            <th>Level</th>
            <th>Class</th>
            <th>Activation</th>
            <th>Description</th>
            <th>Update</th>
        </tr>
    </thead>
    <tbody id="searchitemcategorydtailTb">
        <% int k = 1;%>
        <% int p = 1;%>
        <c:forEach items="${itemsFound}" var="b">
            <tr <c:if test="${b.isspecial==true}">style="color:  green;" </c:if>>
                <td><%=k++%></td>
                <td>${b.specification}</td>
                <td>${b.levelofuse}</td>
                <td>${b.itemusage}</td>
                <td align="center">
                    <div class="toggle-flip">
                        <label>
                            <input id="SundsactdeactItm<%=p++%>" type="checkbox"<c:if test="${b.isactive==true}">checked="checked"</c:if> onchange="if (this.checked) {
                                        activateSundsodiactivatItMs('activate', ${itemid}, this.id);
                                    } else {
                                        activateSundsodiactivatItMs('diactivate', ${itemid}, this.id);
                                    }"><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Active" data-toggle-off="Disabled"></span>
                        </label>
                    </div>
                </td>
                <td align="center"> <span  title="Item packages." onclick="viewSundadditemspacking(${itemid});" class="badge badge-danger icon-custom">${b.itempackages}</span></td>
                <td align="center">
                    <span  title="Edit Of This Item." onclick="editSundsSearchedItemDetails(${itemid});"  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                    |
                    <span  title="Delete Of This Item." onclick="deleteSundsSearchedItemDetails(${itemid});"  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span>
                </td>
            </tr>
        </c:forEach>

    </tbody>
</table> 
<script>
    $('#searchedsundriesitemcategorydtailsTable').DataTable();
    function viewSundadditemspacking(itemid) {
        $.ajax({
            type: 'GET',
            data: {itemid: itemid},
            url: "essentialmedicinesandsupplieslist/itempackages.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'Item Description',
                    content: '' + data,
                    boxWidth: '50%',
                    closeIcon: true,
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                             ajaxSubmitData('essentialmedicinesandsupplieslist/getitemsundriestreeclassification.htm', 'SuppliescategoryItemsDivs', 'act=b&itemid=' + itemid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    }
                });
            }
        });
    }
</script> 
