<%-- 
    Document   : searchResults
    Created on : Aug 22, 2018, 12:11:04 PM
    Author     : IICS
--%>

<%@include file="../../../../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:if test="${not empty itemsFound}">
    <ul class="items scrollbar" id="classificationsunitemSearchScroll">
        <c:forEach items="${itemsFound}" var="item">
            <li class="classItem border-groove" onclick="classificationsundSearchItemsClick(${item.itemid}, '${item.genericname}','${item.classificationname}',${item.itemclassificationid},${item.itemcategoryid},'${item.categoryname}')">
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
    function classificationsundSearchItemsClick(itemid, genericname,classificationname,itemclassificationid,itemcategoryid,categoryname) {
        ajaxSubmitData('essentialmedicinesandsupplieslist/getitemsundriestreeclassification.htm', 'SuppliessearchedItemClassificationDiv', 'act=a&itemid='+itemid+'&classificationname='+classificationname+'&itemclassificationid='+itemclassificationid+'&itemcategoryid='+itemcategoryid+'&categoryname='+categoryname+'&maxR=100&sStr=', 'GET');
    }
</script>
