<%-- 
    Document   : itemStructure
    Created on : Aug 22, 2018, 12:18:42 PM
    Author     : IICS
--%>

<link rel="stylesheet" type="text/css" href="static/res/css/jquery.treefilter.css"/>
<style>
    .tf-tree .tf-child-true:before {
        display: block;
        position: absolute;
        top: -1px;
        left: 0;
        content: url("static/img2/menu-arrow-right.png");
        width: 20px;
        height: 20px;
        font-size: 11px;
        line-height: 20px;
        text-align: center;
        transition: .1s linear;
    }
    .tf-tree .tf-child-false:before {
        display: block;
        position: absolute;
        top: -1px;
        left: 0;
        content: url("static/img2/menu-dot.png");
        width: 20px;
        height: 20px;
        font-size: 11px;
        line-height: 20px;
        text-align: center;
    }
</style>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<ul id="item-tree">
    <c:forEach items="${itemsFound}" var="classif">
        <li>
            <div>${classif.classificationname}</div>
            <ul>
                <c:forEach items="${classif.SubCategory}" var="cat">
                    <li>
                        <div>${cat.categoryname}</div>
                        <c:if test="${cat.size > 0}">
                            <ul>
                                <c:forEach items="${cat.SubCategory}" var="cat1">
                                    <li>
                                        <div>${cat1.categoryname}</div>
                                        <c:if test="${cat1.size > 0}">
                                            <ul>
                                                <c:forEach items="${cat1.SubCategory}" var="cat2">
                                                    <li>
                                                        <div>${cat2.categoryname}</div> 
                                                        <c:if test="${cat2.size > 0}">
                                                            <ul>
                                                                <c:forEach items="${cat2.SubCategory}" var="cat3">
                                                                    <li>
                                                                        <div>${cat3.categoryname}</div> 
                                                                        <c:if test="${cat3.size > 0}">
                                                                            <ul>
                                                                                <c:forEach items="${cat3.SubCategory}" var="cat4">
                                                                                    <li>
                                                                                        <div>${cat4.categoryname}</div>  
                                                                                        <c:if test="${cat4.size > 0}">
                                                                                            <ul>
                                                                                                <c:forEach items="${cat4.SubCategory}" var="cat5">
                                                                                                    <li>
                                                                                                        <div>${cat5.categoryname}</div> 
                                                                                                        <c:if test="${cat5.size > 0}">
                                                                                                            <ul>
                                                                                                                <c:forEach items="${cat5.SubCategory}" var="cat6">
                                                                                                                    <li>
                                                                                                                        <div>${cat6.categoryname}</div>   
                                                                                                                    </li> 
                                                                                                                </c:forEach>
                                                                                                            </ul> 
                                                                                                        </c:if>
                                                                                                    </li> 
                                                                                                </c:forEach>
                                                                                            </ul> 
                                                                                        </c:if>
                                                                                    </li> 
                                                                                </c:forEach>
                                                                            </ul> 
                                                                        </c:if>
                                                                    </li>
                                                                </c:forEach>
                                                            </ul>   
                                                        </c:if>
                                                    </li>
                                                </c:forEach>
                                            </ul>  
                                        </c:if>
                                    </li>  

                                </c:forEach>
                            </ul> 
                        </c:if>
                    </li> 
                </c:forEach>
            </ul>
        </li>  
    </c:forEach>

</ul>
<script src="static/res/js/jquery.treefilter.js"></script>
<script>
    document.getElementById('SuppliesspanClassificationClassNameSp').innerHTML = '${classificationname}';
    $(function () {
        var tree = new treefilter($("#item-tree"), {
            searcher: $("input#my-search"),
            multiselect: false
        });
    });
    ajaxSubmitData('essentialmedicinesandsupplieslist/getitemsundriestreeclassification.htm', 'SuppliescategoryItemsDivs', 'act=b&itemid=' +${itemid} + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
</script>