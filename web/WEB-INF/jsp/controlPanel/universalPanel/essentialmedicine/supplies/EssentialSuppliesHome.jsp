<%-- 
    Document   : EssentialSuppliesHome
    Created on : Jul 19, 2018, 8:49:06 AM
    Author     : IICS
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .thumbnail {
        margin: 0;
        padding: 0px 5px;
    }
    .thumbnail3 {
        margin: 0;
        padding: 40px 5px;
    }
    h3 {
        margin: 0;
    }

    .ui-resizable-handle {
        position: absolute;
        font-size: 0.1px;
        display: block;
        touch-action: none;
        width: 30px;
        right: -15px;
    }
    .ui-resizable-handle:after {
        content: "";
        display: block;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        margin-top: -10px;
        width: 4px;
        height: 4px;
        border-radius: 50%;
        background: #ddd;
        box-shadow: 0 10px 0 #ddd, 0 20px 0 #ddd;
    }

    .layout-button-left {
        background: url('static/img2/layout_arrows.png') no-repeat 0 0;
    }
    .layout-button-right {
        background: url('static/img2/layout_arrows.png') no-repeat 0 -16px;
    }
    .icon-ok{
        background:url('static/img2/ok.png') no-repeat center center;
    }
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
<div style="margin: 10px;">

    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <fieldset style="min-height:100px;">
                        <div class="row">
                            <div class="col-md-2">
                                <button onclick="ajaxSubmitData('essentialmedicinesandsupplieslist/essentialsupplieslist.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" class="btn btn-secondary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Back</button> 
                            </div>
                            <div class="col-md-6">
                                <div id="search-form_3">
                                    <input id="SuppliesclassificationitemsSearch" type="text" oninput="suppliessearchclassificationItems()" placeholder="Search Item" onfocus="suppliessearchclassificationItems()" class="search_3 dropbtn"/>
                                </div>
                                <div id="SuppliesmyclassificationDropdowns" class="search-content">

                                </div>
                            </div>
                            <div class="col-md-4">
                                <button onclick="newgroupessentialsuppliesclassification();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add New Section</button>
                                <!--<button onclick="newessentialsuppliesclassification();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Classification</button>-->
                            </div>
                        </div>
                        <div style="margin:20px 0;"></div>
                        <div class="easyui-layout" style="width:auto;height:400px;">
                            <div data-options="region:'west',split:true" title="Items" style="width:300px;"><br>
                                <c:if test="${not empty classificationsFound}">
                                    <div class="container" id="SuppliessearchedItemClassificationDiv">
                                        <input type="search" id="my-Suppliessearch" placeholder="search Category" class="form-control form-control-sm"><br>
                                        <ul id="my-Supplies">
                                            <c:forEach items="${classificationsFound}" var="group">
                                                <li>
                                                    <div><span onclick="getSuppliesgroupClassificationCategory(${group.itemclassificationid}, '${group.classificationname}');">${group.classificationname}</span></div>
                                                        <c:if test="${group.size > 0}">
                                                        <ul>
                                                            <c:forEach items="${group.categoryclassFound}" var="classif">
                                                                <li>
                                                                    <div><span onclick="getSuppliesClassificationCategory(${classif.itemclassificationid}, '${classif.classificationname}');">${classif.classificationname}</span></div>
                                                                        <c:if test="${classif.size > 0}">
                                                                        <ul>
                                                                            <c:forEach items="${classif.categorysFound}" var="cat">
                                                                                <li>
                                                                                    <div><span  onclick="getSuppliescategorysubcategory(${cat.itemcategoryid}, '${cat.categoryname}');">${cat.categoryname}</span></div>
                                                                                        <c:if test="${cat.size > 0}">
                                                                                        <ul>
                                                                                            <c:forEach items="${cat.subCategory}" var="cat1">
                                                                                                <li>
                                                                                                    <div><span onclick="getSuppliescategorysubcategory(${cat1.itemcategoryid}, '${cat1.categoryname}');" >${cat1.categoryname}</span></div>
                                                                                                        <c:if test="${cat1.size > 0}">
                                                                                                        <ul>
                                                                                                            <c:forEach items="${cat1.subCategory}" var="cat2">
                                                                                                                <li>
                                                                                                                    <div><span onclick="getSuppliescategorysubcategory(${cat2.itemcategoryid}, '${cat2.categoryname}');">${cat2.categoryname}</span></div> 
                                                                                                                        <c:if test="${cat2.size > 0}">
                                                                                                                        <ul>
                                                                                                                            <c:forEach items="${cat2.subCategory}" var="cat3">
                                                                                                                                <li>
                                                                                                                                    <div><span onclick="getSuppliescategorysubcategory(${cat3.itemcategoryid}, '${cat3.categoryname}');">${cat3.categoryname}</span></div> 
                                                                                                                                        <c:if test="${cat3.size > 0}">
                                                                                                                                        <ul>
                                                                                                                                            <c:forEach items="${cat3.subCategory}" var="cat4">
                                                                                                                                                <li>
                                                                                                                                                    <div><span onclick="getSuppliescategorysubcategory(${cat4.itemcategoryid}, '${cat4.categoryname}');">${cat4.categoryname}</span></div>  
                                                                                                                                                        <c:if test="${cat4.size > 0}">
                                                                                                                                                        <ul>
                                                                                                                                                            <c:forEach items="${cat4.subCategory}" var="cat5">
                                                                                                                                                                <li>
                                                                                                                                                                    <div><span onclick="getSuppliescategorysubcategory(${cat5.itemcategoryid}, '${cat5.categoryname}');">${cat5.categoryname}</span></div> 
                                                                                                                                                                        <c:if test="${cat5.size > 0}">
                                                                                                                                                                        <ul>
                                                                                                                                                                            <c:forEach items="${cat5.subCategory}" var="cat6">
                                                                                                                                                                                <li>
                                                                                                                                                                                    <div><span onclick="getSuppliescategorysubcategory(${cat6.itemcategoryid}, '${cat6.categoryname}');">${cat6.categoryname}</span></div>   
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
                                                                    </c:if>
                                                                </li>  
                                                            </c:forEach>
                                                        </ul>
                                                    </c:if>
                                                </li> 
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>
                                <c:if test="${empty classificationsFound}">
                                    <h5 style="display: block"><span class="badge badge-danger"><strong>No Any Supplies Classification</strong></span></h5> 
                                </c:if>
                            </div>
                            <div data-options="region:'center',title:'Title',iconCls:'icon-ok'" style="width:985px;left: 163px !important;"><br>
                                <div id="suppliesnavigationtab">
                                    <input type="hidden" id="SuppliesItemclassificationid" class="form-control form-control-sm" style="width: 50%;">
                                    <input type="hidden" id="SuppliesItemclassificationname" class="form-control form-control-sm" style="width: 50%;">
                                    <input type="hidden" id="SuppliesItemclassificationcategoryid" class="form-control form-control-sm" style="width: 50%;">
                                    <input type="hidden" id="SuppliesItemclassificationcategoryname" class="form-control form-control-sm" style="width: 50%;">

                                    <div class="row">
                                        <div class="col-md-6">
                                            <span style="display: none" id="SuppliesspanClassificationHeading"><b>Section/Classification:&nbsp;<span  title="Edit Of This Classification." onclick="updateSuppliesClassificationDetails();" class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                                                    |
                                                    <span onclick="deleteSuppliesClassification();" title="Delete Of This Classification."  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></b></span> <h5 style="display: none" id="SuppliesspanClassificationBadgeSpn"><span class="badge badge-secondary"><strong id="SuppliesspanClassificationClassNameSp"></strong></span></h5> 
                                        </div>
                                        <div class="col-md-6">
                                            <span style="display: none" id="SuppliesspanCategoryHeading"><b>Sub category:</b> </span>  <h5 style="display: none" id="SuppliesspanCategoryHBadgeSpan"><span class="badge badge-secondary"><strong id="suppliesPDthenavigationheadCategory">Category</strong></span></h5> 
                                        </div>
                                    </div>
                                </div>
                                <div id="SuppliescategoryItemsDivs"><br><br>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="tile">
                                                <h3 class="tile-title">Classification</h3>
                                                <div class="tile-body">Classifications contain categories then sub categories and finally items.<br>
                                                    Create A classification then categories and finally add items under classification categories.</div>
                                                <div class="tile-footer"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="tile">
                                                <h3 class="tile-title"> Item Categories</h3>
                                                <div class="tile-body">Categories May contain Sub categories then Items or Items.<br>
                                                    Specialist Medicines under category Items are highlighted with green color.</div>
                                                <div class="tile-footer"></div>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div> 
                    </fieldset>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="static/res/js/jquery.easyui.min.js"></script>
<script>
                                                        $(function () {
                                                            var tree = new treefilter($("#my-Supplies"), {
                                                                searcher: $("input#my-Suppliessearch"),
                                                                multiselect: false
                                                            });
                                                        });
                                                        function addfromExistingClass() {
                                                            $.confirm({
                                                                title: 'Add Classification',
                                                                icon: 'fa fa-warning',
                                                                content: 'From Existing Classifications?',
                                                                type: 'purple',
                                                                typeAnimated: true,
                                                                buttons: {
                                                                    tryAgain: {
                                                                        text: 'Yes',
                                                                        btnClass: 'btn-purple',
                                                                        action: function () {
                                                                            $.ajax({
                                                                                type: 'GET',
                                                                                data: {data: 'data'},
                                                                                url: "essentialmedicinesandsupplieslist/getexistingsuppliesclassification.htm",
                                                                                success: function (data, textStatus, jqXHR) {
                                                                                    $.confirm({
                                                                                        title: 'Select Classification',
                                                                                        content: '' + data,
                                                                                        type: 'purple',
                                                                                        boxWidth: '70%',
                                                                                        useBootstrap: false,
                                                                                        typeAnimated: true,
                                                                                        buttons: {
                                                                                            tryAgain: {
                                                                                                text: 'Save',
                                                                                                btnClass: 'btn-red',
                                                                                                action: function () {
                                                                                                    var Itemclassificationid = $('#SuppliesItemclassificationid').val();
                                                                                                    if (suppliesClassifications.size > 0) {
                                                                                                        $.confirm({
                                                                                                            title: 'Add Classifications!',
                                                                                                            content: 'Are You Sure You Want To Add ' + suppliesClassifications.size + ' ' + 'Classifications?',
                                                                                                            type: 'purple',
                                                                                                            typeAnimated: true,
                                                                                                            buttons: {
                                                                                                                tryAgain: {
                                                                                                                    text: 'Yes',
                                                                                                                    btnClass: 'btn-purple',
                                                                                                                    action: function () {
                                                                                                                        $.ajax({
                                                                                                                            type: 'POST',
                                                                                                                            data: {values: JSON.stringify(Array.from(suppliesClassifications)), Itemclassificationid: Itemclassificationid},
                                                                                                                            url: "essentialmedicinesandsupplieslist/addexistinggroupclassificationselected.htm",
                                                                                                                            success: function (data, textStatus, jqXHR) {
                                                                                                                                ajaxSubmitData('essentialmedicinesandsupplieslist/essentialsupplieslist.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                                                                            }
                                                                                                                        });
                                                                                                                    }
                                                                                                                },
                                                                                                                close: function () {
                                                                                                                }
                                                                                                            }
                                                                                                        });
                                                                                                    } else {
                                                                                                        $.confirm({
                                                                                                            title: 'Encountered an error!',
                                                                                                            content: 'Nothing Selected',
                                                                                                            type: 'red',
                                                                                                            typeAnimated: true,
                                                                                                            buttons: {
                                                                                                                close: function () {

                                                                                                                }
                                                                                                            }
                                                                                                        });
                                                                                                    }
                                                                                                }
                                                                                            },
                                                                                            close: function () {
                                                                                            }
                                                                                        }
                                                                                    });
                                                                                }
                                                                            });
                                                                        }
                                                                    },
                                                                    No: function () {
                                                                        newessentialsuppliesclassification();
                                                                    }
                                                                }
                                                            });
                                                        }
                                                        function newessentialsuppliesclassification() {
                                                            $.confirm({
                                                                title: 'Add Classification!',
                                                                type: 'purple',
                                                                typeAnimated: true,
                                                                content: '' +
                                                                        '<form action="" class="formName">' +
                                                                        '<div class="form-group">' +
                                                                        '<label>Enter Classification here</label>' +
                                                                        '<input type="text" placeholder="Your Classification" class="suppliesclassificationname form-control" required />' +
                                                                        '</div>' +
                                                                        '<div class="form-group">' +
                                                                        '<label>Enter Description here</label>' +
                                                                        '<textarea class="suppliesclassificationdesc form-control" rows="5"></textarea>' +
                                                                        '</div>' +
                                                                        '</form>',
                                                                buttons: {
                                                                    formSubmit: {
                                                                        text: 'Save',
                                                                        btnClass: 'btn-purple',
                                                                        action: function () {
                                                                            var parentid = $('#SuppliesItemclassificationid').val();
                                                                            var classificationname = this.$content.find('.suppliesclassificationname').val();
                                                                            var classificationdesc = this.$content.find('.suppliesclassificationdesc').val();
                                                                            if (!classificationname) {
                                                                                $.alert('provide a valid classification Name');
                                                                                return false;
                                                                            }
                                                                            if (!classificationdesc) {
                                                                                $.alert('provide a valid classification Description');
                                                                                return false;
                                                                            }
                                                                            $.ajax({
                                                                                type: 'POST',
                                                                                data: {classificationname: classificationname.toUpperCase(), classificationdesc: classificationdesc, parentid: parentid, type: 'classification'},
                                                                                url: "essentialmedicinesandsupplieslist/savenewsuppliesclassification.htm",
                                                                                success: function (data, textStatus, jqXHR) {
                                                                                    $.confirm({
                                                                                        title: 'Add Classification!',
                                                                                        content: 'Do You Want To Add Another Classification?',
                                                                                        type: 'purple',
                                                                                        icon: 'fa fa-warning',
                                                                                        theme: 'material',
                                                                                        typeAnimated: true,
                                                                                        buttons: {
                                                                                            tryAgain: {
                                                                                                text: 'yes',
                                                                                                btnClass: 'btn-purple',
                                                                                                action: function () {
                                                                                                    newessentialsuppliesclassification();
                                                                                                }
                                                                                            },
                                                                                            close: function () {
                                                                                                ajaxSubmitData('essentialmedicinesandsupplieslist/essentialsupplieslist.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                                            }
                                                                                        }
                                                                                    });
                                                                                }
                                                                            });
                                                                        }
                                                                    },
                                                                    cancel: function () {
                                                                        ajaxSubmitData('essentialmedicinesandsupplieslist/essentialsupplieslist.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    },
                                                                }
                                                            });
                                                        }
                                                        function getSuppliesClassificationCategory(itemclassificationid, classificationname) {
                                                            document.getElementById('SuppliesspanClassificationHeading').style.display = 'block';
                                                            document.getElementById('SuppliesspanClassificationBadgeSpn').style.display = 'block';
                                                            document.getElementById('SuppliesspanCategoryHeading').style.display = 'none';
                                                            document.getElementById('SuppliesspanCategoryHBadgeSpan').style.display = 'none';

                                                            document.getElementById('SuppliesItemclassificationid').value = itemclassificationid;
                                                            document.getElementById('SuppliesItemclassificationname').value = classificationname;
                                                            document.getElementById('SuppliesspanClassificationClassNameSp').innerHTML = classificationname;
                                                            ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliesclassificationcategories.htm', 'SuppliescategoryItemsDivs', 'itemclassificationid=' + itemclassificationid + '&act=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                                                        }
                                                        function getSuppliescategorysubcategory(itemcategoryid, categoryname) {
                                                            document.getElementById('SuppliesItemclassificationcategoryid').value = itemcategoryid;
                                                            document.getElementById('SuppliesItemclassificationcategoryname').value = categoryname;

                                                            document.getElementById('SuppliesspanCategoryHeading').style.display = 'block';
                                                            document.getElementById('SuppliesspanCategoryHBadgeSpan').style.display = 'block';
                                                            document.getElementById('suppliesPDthenavigationheadCategory').innerHTML = categoryname;
                                                            $.ajax({
                                                                type: 'POST',
                                                                data: {itemcategoryid: itemcategoryid},
                                                                url: "essentialmedicinesandsupplieslist/getcategorysubcategory.htm",
                                                                success: function (data, textStatus, jqXHR) {
                                                                    var results = data.split('~');
                                                                    if (results[0] === 'allnull') {
                                                                        ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliesclassificationcategories.htm', 'SuppliescategoryItemsDivs', 'itemcategoryid=' + itemcategoryid + '&act=b&type=items&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    } else {
                                                                        if (results[1] === 'category') {
                                                                            ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliescategoriessubcategorylist.htm', 'SuppliescategoryItemsDivs', 'itemcategoryid=' + itemcategoryid + '&act=b&type=categoery&ofst=1&maxR=100&sStr=', 'GET');
                                                                        } else if(results[1]==='items'){
                                                                            ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliesclassificationcategories.htm', 'SuppliescategoryItemsDivs', 'itemcategoryid=' + itemcategoryid + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                                                                        }else {
                                                                            ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliescategoriessubcategorylist.htm', 'SuppliescategoryItemsDivs', 'itemcategoryid=' + itemcategoryid + '&act=f&type=catanditems&ofst=1&maxR=100&sStr=', 'GET'); 
                                                                        }
                                                                    }
                                                                }
                                                            });
                                                        }
                                                        function updateSuppliesClassificationDetails() {
                                                            var classificationid = $('#SuppliesItemclassificationid').val();
                                                            var classificationname = $('#SuppliesItemclassificationname').val();
                                                            $.confirm({
                                                                title: 'Update Classification!',
                                                                content: '' +
                                                                        '<form action="" class="formName">' +
                                                                        '<div class="form-group">' +
                                                                        '<label>Enter something here</label>' +
                                                                        '<input type="text"  class="SuppliesItemname form-control" value="' + classificationname + '" required />' +
                                                                        '</div>' +
                                                                        '</form>',
                                                                type: 'purple',
                                                                typeAnimated: true,
                                                                buttons: {
                                                                    tryAgain: {
                                                                        text: 'Update',
                                                                        btnClass: 'btn-purple',
                                                                        action: function () {
                                                                            var name = this.$content.find('.SuppliesItemname').val();
                                                                            if (!name) {
                                                                                $.alert('provide a valid name');
                                                                                return false;
                                                                            }
                                                                            $.ajax({
                                                                                type: 'POST',
                                                                                data: {classificationid: classificationid,name:name},
                                                                                url: "essentialmedicinesandsupplieslist/updateSuppliesClassificationDetails.htm",
                                                                                success: function (data, textStatus, jqXHR) {
                                                                                    ajaxSubmitData('essentialmedicinesandsupplieslist/essentialsupplieslist.htm', 'content2', 'act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                                                                                }
                                                                            });
                                                                        }
                                                                    },
                                                                    close: function () {
                                                                    }
                                                                }
                                                            });
                                                        }
                                                        function deleteSuppliesClassification() {
                                                            var classificationid = $('#SuppliesItemclassificationid').val();
                                                            if (classificationid !== '') {
                                                                $.confirm({
                                                                    title: 'Delete Classification!',
                                                                    content: 'Are You Sure You Want To Delete This Classification?',
                                                                    type: 'purple',
                                                                    typeAnimated: true,
                                                                    buttons: {
                                                                        tryAgain: {
                                                                            text: 'Yes',
                                                                            btnClass: 'btn-purple',
                                                                            action: function () {
                                                                                $.ajax({
                                                                                    type: 'POST',
                                                                                    data: {classificationid: classificationid},
                                                                                    url: "essentialmedicinesandsupplieslist/deleteSuppliesgroupClassification.htm",
                                                                                    success: function (data, textStatus, jqXHR) {
                                                                                        if (data === 'comps') {
                                                                                            $.confirm({
                                                                                                title: 'Encountered an error!',
                                                                                                content: 'Can Not Be Deleted Because Of Attachments.',
                                                                                                type: 'red',
                                                                                                typeAnimated: true,
                                                                                                buttons: {
                                                                                                    close: function () {

                                                                                                    }
                                                                                                }
                                                                                            });
                                                                                        } else {
                                                                                            ajaxSubmitData('essentialmedicinesandsupplieslist/essentialsupplieslist.htm', 'content2', 'act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');

                                                                                        }

                                                                                    }
                                                                                });
                                                                            }
                                                                        },
                                                                        close: function () {
                                                                        }
                                                                    }
                                                                });
                                                            }
                                                        }
                                                        function getSuppliesgroupClassificationCategory(itemclassificationid, classificationname) {
                                                            document.getElementById('SuppliesspanClassificationHeading').style.display = 'block';
                                                            document.getElementById('SuppliesspanClassificationBadgeSpn').style.display = 'block';
                                                            document.getElementById('SuppliesspanCategoryHeading').style.display = 'none';
                                                            document.getElementById('SuppliesspanCategoryHBadgeSpan').style.display = 'none';

                                                            document.getElementById('SuppliesItemclassificationid').value = itemclassificationid;
                                                            document.getElementById('SuppliesItemclassificationname').value = classificationname;
                                                            document.getElementById('SuppliesspanClassificationClassNameSp').innerHTML = classificationname;
                                                            ajaxSubmitData('essentialmedicinesandsupplieslist/getsuppliesgroupsclassificationcategories.htm', 'SuppliescategoryItemsDivs', 'itemclassificationid=' + itemclassificationid + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                                                        }
                                                        function newgroupessentialsuppliesclassification() {
                                                            $.confirm({
                                                                title: 'ADD NEW SECTION',
                                                                content: '' +
                                                                        '<form action="" class="formName">' +
                                                                        '<div class="form-group">' +
                                                                        '<label>Enter Section</label>' +
                                                                        '<input type="text" placeholder="Your Section name" class="groupclassificationsundsname form-control" required />' +
                                                                        '</div>' +
                                                                        '<div class="form-group">' +
                                                                        '<label>Enter Section More Info</label>' +
                                                                        '<textarea class="groupclassificationsmoreinfoundsname form-control" rows="5"></textarea>' +
                                                                        '</div>' +
                                                                        '</form>',
                                                                type: 'purple',
                                                                typeAnimated: true,
                                                                buttons: {
                                                                    tryAgain: {
                                                                        text: 'Save',
                                                                        btnClass: 'btn-purple',
                                                                        action: function () {
                                                                            var name = this.$content.find('.groupclassificationsundsname').val();
                                                                            var moreinfo = this.$content.find('.groupclassificationsmoreinfoundsname').val();
                                                                            if (!name || !moreinfo) {
                                                                                $.alert('provide a valid name');
                                                                                return false;
                                                                            }
                                                                            $.ajax({
                                                                                type: 'POST',
                                                                                data: {name: name, moreinfo: moreinfo},
                                                                                url: "essentialmedicinesandsupplieslist/savesundriesgroupsclassifications.htm",
                                                                                success: function (data, textStatus, jqXHR) {
                                                                                    $.confirm({
                                                                                        title: 'ADD SECTION',
                                                                                        content: 'Do You Want To Add Another One?',
                                                                                        type: 'red',
                                                                                        typeAnimated: true,
                                                                                        buttons: {
                                                                                            tryAgain: {
                                                                                                text: 'Yes',
                                                                                                btnClass: 'btn-red',
                                                                                                action: function () {
                                                                                                    newgroupessentialsuppliesclassification();
                                                                                                }
                                                                                            },
                                                                                            No: function () {
                                                                                                ajaxSubmitData('essentialmedicinesandsupplieslist/essentialsupplieslist.htm', 'content2', 'act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                                                                                            }
                                                                                        }
                                                                                    });
                                                                                }
                                                                            });
                                                                        }
                                                                    },
                                                                    close: function () {

                                                                    }
                                                                }
                                                            });
                                                        }
                                                        function displaysundriesclassificationSearchResults() {
                                                            document.getElementById("SuppliesmyclassificationDropdowns").classList.add("showSearch");
                                                        }
                                                        function suppliessearchclassificationItems() {
                                                            displaysundriesclassificationSearchResults();
                                                            var name = $('#SuppliesclassificationitemsSearch').val();
                                                            if (name.length >= 3) {
                                                                ajaxSubmitData('essentialmedicinesandsupplieslist/searchsundriesitem.htm', 'SuppliesmyclassificationDropdowns', 'name=' + name + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                                                            } else {
                                                                $('#SuppliesmyclassificationDropdowns').html('');
                                                            }
                                                        }
                                                        window.onclick = function (event) {
                                                            if (!event.target.matches('.dropbtn')) {
                                                                var dropdowns = document.getElementsByClassName("search-content");
                                                                var i;
                                                                for (i = 0; i < dropdowns.length; i++) {
                                                                    var openDropdown = dropdowns[i];
                                                                    if (openDropdown.classList.contains('showSearch')) {
                                                                        openDropdown.classList.remove('showSearch');
                                                                    }
                                                                }
                                                            }
                                                        };
</script>