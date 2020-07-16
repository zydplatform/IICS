<%-- 
    Document   : searchResults
    Created on : Jul 6, 2018, 9:43:07 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:if test="${not empty itemsFound}">
    <ul class="items scrollbar" id="classificationitemSearchScroll">
        <c:forEach items="${itemsFound}" var="item">
            <li class="classItem border-groove" onclick="classificationSearchItemsClick(${item.itemid}, '${item.genericname}','${item.classificationname}',${item.itemclassificationid},${item.itemcategoryid},'${item.categoryname}')">
                <h5 class="itemTitle">
                    ${item.genericname}
                </h5>
                <p class="itemContent">
                    ${item.classificationname}>${item.categoryname}
                </p>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty itemsFound}">
    <p class="center">
        <br>
        Item <strong>${name}</strong> Not Found.
    </p>
</c:if>
<script>
    function classificationSearchItemsClick(itemid, genericname,classificationname,itemclassificationid,itemcategoryid,categoryname) {
        ajaxSubmitData('essentialmedicinesandsupplieslist/getitemtreeclassification.htm', 'searchedItemClassificationDiv', 'act=a&itemid='+itemid+'&classificationname='+classificationname+'&itemclassificationid='+itemclassificationid+'&itemcategoryid='+itemcategoryid+'&categoryname='+categoryname+'&maxR=100&sStr=', 'GET');
    }
</script>