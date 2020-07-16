<%-- 
    Document   : essentialMedicinesList
    Created on : Jul 3, 2018, 5:02:14 PM
    Author     : IICS
--%>
<link rel="stylesheet" type="text/css" href="static/res/css/easyui.css"/>

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
<%@include file="../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div style="margin: 10px;">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <fieldset style="min-height:100px;">
                        <div class="row">
                            <div class="col-md-2">
                                <button onclick="ajaxSubmitData('essentialmedicinesandsupplieslist/essentialmedicinesandsupplieslisthome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" class="btn btn-secondary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Back</button> 
                            </div>
                            <div class="col-md-4">
                                <div id="search-form_3">
                                    <input id="classificationitemsSearch" type="text" oninput="searchclassificationItems()" placeholder="Search Item" onfocus="searchclassificationItems()" class="search_3 dropbtn"/>
                                </div>
                                <div id="myclassificationDropdowns" class="search-content">

                                </div>
                            </div>
                            <div class="col-md-3">
                                <button onclick="itemsDescriptions();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Descriptions(${descriptionsize})</button>
                            </div>
                            <div class="col-md-3">
                                <button onclick="newgroupclassification();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Section</button>
                                <!--<button onclick="newclassification();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Classification</button>-->
                            </div>
                        </div>
                        <div style="margin:20px 0;"></div>
                        <div class="easyui-layout" style="width:auto;height:400px;">
                            <div data-options="region:'west',split:true" title="Items" style="width:300px;"><br>
                                <div class="container" id="searchedItemClassificationDiv">
                                    <input type="search" id="my-search" placeholder="search Category" class="form-control form-control-sm"><br>
                                    <ul id="my-tree">
                                        <c:if test="${not empty groupClassificationsFound}">
                                            <c:forEach items="${groupClassificationsFound}" var="group">
                                                <li>
                                                    <div><span onclick="getgroupClassificationCategory(${group.itemclassificationid}, '${group.classificationname}');">${group.classificationname}</span></div>
                                                        <c:if test="${group.size > 0}">
                                                        <ul>
                                                            <c:forEach items="${group.classificationsFound}" var="classif">
                                                                <li>
                                                                    <div><span onclick="getClassificationCategory(${classif.itemclassificationid}, '${classif.classificationname}', '${classif.classificationname}');">${classif.classificationname}</span></div>
                                                                        <c:if test="${classif.size > 0}">
                                                                        <ul>
                                                                            <c:forEach items="${classif.categorysFound}" var="cat">
                                                                                <li>
                                                                                    <div><span  onclick="getcategorysubcategory(${cat.itemcategoryid}, '${cat.categoryname}');">${cat.categoryname}</span></div>
                                                                                        <c:if test="${cat.size > 0}">
                                                                                        <ul>
                                                                                            <c:forEach items="${cat.subCategory}" var="cat1">
                                                                                                <li>
                                                                                                    <div><span onclick="getcategorysubcategory(${cat1.itemcategoryid}, '${cat1.categoryname}');" >${cat1.categoryname}</span></div>
                                                                                                        <c:if test="${cat1.size > 0}">
                                                                                                        <ul>
                                                                                                            <c:forEach items="${cat1.subCategory}" var="cat2">
                                                                                                                <li>
                                                                                                                    <div><span onclick="getcategorysubcategory(${cat2.itemcategoryid}, '${cat2.categoryname}');">${cat2.categoryname}</span></div> 
                                                                                                                        <c:if test="${cat2.size > 0}">
                                                                                                                        <ul>
                                                                                                                            <c:forEach items="${cat2.subCategory}" var="cat3">
                                                                                                                                <li>
                                                                                                                                    <div><span onclick="getcategorysubcategory(${cat3.itemcategoryid}, '${cat3.categoryname}');">${cat3.categoryname}</span></div> 
                                                                                                                                        <c:if test="${cat3.size > 0}">
                                                                                                                                        <ul>
                                                                                                                                            <c:forEach items="${cat3.subCategory}" var="cat4">
                                                                                                                                                <li>
                                                                                                                                                    <div><span onclick="getcategorysubcategory(${cat4.itemcategoryid}, '${cat4.categoryname}');">${cat4.categoryname}</span></div>  
                                                                                                                                                        <c:if test="${cat4.size > 0}">
                                                                                                                                                        <ul>
                                                                                                                                                            <c:forEach items="${cat4.subCategory}" var="cat5">
                                                                                                                                                                <li>
                                                                                                                                                                    <div><span onclick="getcategorysubcategory(${cat5.itemcategoryid}, '${cat5.categoryname}');">${cat5.categoryname}</span></div> 
                                                                                                                                                                        <c:if test="${cat5.size > 0}">
                                                                                                                                                                        <ul>
                                                                                                                                                                            <c:forEach items="${cat5.subCategory}" var="cat6">
                                                                                                                                                                                <li>
                                                                                                                                                                                    <div><span onclick="getcategorysubcategory(${cat6.itemcategoryid}, '${cat6.categoryname}');">${cat6.categoryname}</span></div>   
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
                                        </c:if>
                                        <c:if test="${empty groupClassificationsFound}">
                                            <h5 style="display: block"><span class="badge badge-danger"><strong>No Any Medicines Classification</strong></span></h5> 
                                        </c:if>
                                    </ul>
                                </div>

                            </div>
                            <div data-options="region:'center',title:'Title',iconCls:'icon-ok'" style="width:985px;"><br>
                                <div id="navigationtab">
                                    <input type="hidden" id="Itemclassificationid" class="form-control form-control-sm" style="width: 50%;">
                                    <input type="hidden" id="Itemclassificationname" class="form-control form-control-sm" style="width: 50%;">
                                    <input type="hidden" id="Itemclassificationcategoryid" class="form-control form-control-sm" style="width: 50%;">
                                    <input type="hidden" id="Itemclassificationcategoryname" class="form-control form-control-sm" style="width: 50%;">

                                    <div class="row">
                                        <div class="col-md-6">
                                            <span style="display: none" id="spanClassificationHeading"><b>Section/Classification:&nbsp;<span  title="Edit Of This Classification." onclick="updateClassificationDetails();" class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                                                    |
                                                    <span onclick="deleteClassification();" title="Delete Of This Classification."  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></b></span> <h5 style="display: none" id="displaythenavigationspan"><span class="badge badge-secondary"><strong id="thenavigationheadfdfgjgdff"></strong></span></h5> 
                                        </div>
                                        <div class="col-md-6">
                                            <span style="display: none" id="spanCategoryHeading"><b>Sub category:</b> </span>  <h5 style="display: none" id="displaythenavigationspanCat"><span class="badge badge-secondary"><strong id="thenavigationheadCategory">Category</strong></span></h5> 
                                        </div>
                                    </div>
                                </div>
                                <div id="categoryItemsDivs"><br><br>
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
<div class="row">
    <div class="col-md-12">
        <div id="additemsessentialListItemsdialog" class="supplierCatalogDialog essentialListItemsdialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleoralreadyheading">Add Items</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="additemstoessentiallistdiv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Getting Items Please Wait...........</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="static/res/js/jquery.easyui.min.js"></script>
<script>

                                                        $(function () {
                                                            var tree = new treefilter($("#my-tree"), {
                                                                searcher: $("input#my-search"),
                                                                multiselect: false
                                                            });
                                                        });
                                                        function askwhichtype() {
                                                            $.confirm({
                                                                title: 'Add Classification!',
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
                                                                                url: "essentialmedicinesandsupplieslist/addexistinggroupclassifications.htm",
                                                                                success: function (data, textStatus, jqXHR) {
                                                                                    $.confirm({
                                                                                        title: 'Select Classifications!',
                                                                                        content: '' + data,
                                                                                        type: 'purple',
                                                                                        closeIcon: true,
                                                                                        boxWidth: '70%',
                                                                                        useBootstrap: false,
                                                                                        typeAnimated: true,
                                                                                        buttons: {
                                                                                            tryAgain: {
                                                                                                text: 'Save',
                                                                                                btnClass: 'btn-purple',
                                                                                                action: function () {
                                                                                                    var Itemclassificationid = $('#Itemclassificationid').val();
                                                                                                    if (selecteditemclassificationid.size > 0 && Itemclassificationid !== '') {
                                                                                                        $.confirm({
                                                                                                            title: 'Add Classification!',
                                                                                                            content: 'Are You Sure You Want To Add ' + selecteditemclassificationid.size + ' ' + 'Classification(s).',
                                                                                                            type: 'purple',
                                                                                                            typeAnimated: true,
                                                                                                            buttons: {
                                                                                                                tryAgain: {
                                                                                                                    text: 'Yes',
                                                                                                                    btnClass: 'btn-purple',
                                                                                                                    action: function () {
                                                                                                                        $.ajax({
                                                                                                                            type: 'POST',
                                                                                                                            data: {values: JSON.stringify(Array.from(selecteditemclassificationid)), Itemclassificationid: Itemclassificationid},
                                                                                                                            url: "essentialmedicinesandsupplieslist/addexistinggroupclassificationselected.htm",
                                                                                                                            success: function (data, textStatus, jqXHR) {
                                                                                                                                ajaxSubmitData('essentialmedicinesandsupplieslist/essentialmedicinesandsupplieslisthome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
                                                                                                            content: 'Nothing Selected Try Again!!',
                                                                                                            icon: 'fa fa-warning',
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
                                                                        newclassification();
                                                                    }
                                                                }
                                                            });
                                                        }
                                                        function newclassification() {
                                                            $.confirm({
                                                                title: 'Add Classification!',
                                                                type: 'purple',
                                                                typeAnimated: true,
                                                                content: '' +
                                                                        '<form action="" class="formName">' +
                                                                        '<div class="form-group">' +
                                                                        '<label>Enter Classification here</label>' +
                                                                        '<input type="text" placeholder="Your Classification" class="classificationname form-control" required />' +
                                                                        '</div>' +
                                                                        '<div class="form-group">' +
                                                                        '<label>Enter Description here</label>' +
                                                                        '<textarea class="classificationdesc form-control" rows="5"></textarea>' +
                                                                        '</div>' +
                                                                        '</form>',
                                                                buttons: {
                                                                    formSubmit: {
                                                                        text: 'Save',
                                                                        btnClass: 'btn-purple',
                                                                        action: function () {
                                                                            var Itemclassificationid = $('#Itemclassificationid').val();
                                                                            var classificationname = this.$content.find('.classificationname').val();
                                                                            var classificationdesc = this.$content.find('.classificationdesc').val();
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
                                                                                data: {classificationname: classificationname.toUpperCase(), classificationdesc: classificationdesc, Itemclassificationid: Itemclassificationid, type: 'classification'},
                                                                                url: "essentialmedicinesandsupplieslist/savenewitemclassification.htm",
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
                                                                                                    newclassification();
                                                                                                }
                                                                                            },
                                                                                            close: function () {
                                                                                                ajaxSubmitData('essentialmedicinesandsupplieslist/essentialmedicinesandsupplieslisthome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                                            }
                                                                                        }
                                                                                    });
                                                                                }
                                                                            });
                                                                        }
                                                                    },
                                                                    cancel: function () {
                                                                        ajaxSubmitData('essentialmedicinesandsupplieslist/essentialmedicinesandsupplieslisthome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    },
                                                                }
                                                            });
                                                        }
                                                        function getClassificationCategory(itemclassificationid, classificationname, link) {
                                                            document.getElementById('displaythenavigationspan').style.display = 'block';
                                                            document.getElementById('spanClassificationHeading').style.display = 'block';
                                                            document.getElementById('displaythenavigationspanCat').style.display = 'none';
                                                            document.getElementById('spanCategoryHeading').style.display = 'none';
                                                            document.getElementById('Itemclassificationid').value = itemclassificationid;
                                                            document.getElementById('Itemclassificationname').value = classificationname;
                                                            document.getElementById('thenavigationheadfdfgjgdff').innerHTML = link;
                                                            ajaxSubmitData('essentialmedicinesandsupplieslist/getclassificationcategories.htm', 'categoryItemsDivs', 'itemclassificationid=' + itemclassificationid + '&act=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                        }
                                                        function getcategorysubcategory(itemcategoryid, categoryname) {
                                                            document.getElementById('Itemclassificationcategoryid').value = itemcategoryid;
                                                            document.getElementById('Itemclassificationcategoryname').value = categoryname;

                                                            document.getElementById('displaythenavigationspanCat').style.display = 'block';
                                                            document.getElementById('spanCategoryHeading').style.display = 'block';
                                                            document.getElementById('thenavigationheadCategory').innerHTML = categoryname;
                                                            $.ajax({
                                                                type: 'POST',
                                                                data: {itemcategoryid: itemcategoryid},
                                                                url: "essentialmedicinesandsupplieslist/getcategorysubcategory.htm",
                                                                success: function (data, textStatus, jqXHR) {
                                                                    var results = data.split('~');
                                                                    console.log(data);
                                                                    if (results[0] === 'allnull') {
                                                                        ajaxSubmitData('essentialmedicinesandsupplieslist/getclassificationcategories.htm', 'categoryItemsDivs', 'itemcategoryid=' + itemcategoryid + '&act=b&type=items&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    } else {
                                                                        if (results[1] === 'category') {
                                                                            ajaxSubmitData('essentialmedicinesandsupplieslist/getcategoriessubcategorylist.htm', 'categoryItemsDivs', 'itemcategoryid=' + itemcategoryid + '&act=b&type=categoery&ofst=1&maxR=100&sStr=', 'GET');
                                                                        } else {
                                                                            ajaxSubmitData('essentialmedicinesandsupplieslist/getclassificationcategories.htm', 'categoryItemsDivs', 'itemcategoryid=' + itemcategoryid + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                                                                        }
                                                                    }
                                                                }
                                                            });
                                                        }
                                                        function displayclassificationSearchResults() {
                                                            document.getElementById("myclassificationDropdowns").classList.add("showSearch");
                                                        }
                                                        function searchclassificationItems() {
                                                            displayclassificationSearchResults();
                                                            var name = $('#classificationitemsSearch').val();
                                                            if (name.length >= 3) {
                                                                ajaxSubmitData('essentialmedicinesandsupplieslist/searchitem.htm', 'myclassificationDropdowns', 'name=' + name + '&act=c&type=items&ofst=1&maxR=100&sStr=', 'GET');
                                                            } else {
                                                                $('#myclassificationDropdowns').html('');
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
                                                        function updateClassificationDetails() {
                                                            var classissificationid = $('#Itemclassificationid').val();
                                                            var classificationname = $('#Itemclassificationname').val();

                                                            $.confirm({
                                                                title: 'Update Classification: ' + classificationname,
                                                                content: '' +
                                                                        '<form action="" class="formName">' +
                                                                        '<div class="form-group">' +
                                                                        '<label>Classification Name</label>' +
                                                                        '<input type="text" value="' + classificationname + '" class="updateclassificationsname form-control" required />' +
                                                                        '</div>' +
                                                                        '</form>',
                                                                type: 'purple',
                                                                typeAnimated: true,
                                                                buttons: {
                                                                    tryAgain: {
                                                                        text: 'save',
                                                                        btnClass: 'btn-purple',
                                                                        action: function () {
                                                                            var name = this.$content.find('.updateclassificationsname').val();
                                                                            if (!name) {
                                                                                $.alert('provide a valid name');
                                                                                return false;
                                                                            }
                                                                            $.ajax({
                                                                                type: 'POST',
                                                                                data: {name: name, classissificationid: classissificationid},
                                                                                url: "essentialmedicinesandsupplieslist/updateClassificationDetails.htm",
                                                                                success: function (data, textStatus, jqXHR) {
                                                                                    if (data === 'success') {
                                                                                        ajaxSubmitData('essentialmedicinesandsupplieslist/essentialmedicinesandsupplieslisthome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                                    } else {
                                                                                        $.confirm({
                                                                                            title: 'Encountered an error!',
                                                                                            content: 'Something went Wrong While Trying To Update Classification Name',
                                                                                            type: 'red',
                                                                                            typeAnimated: true,
                                                                                            buttons: {
                                                                                                tryAgain: {
                                                                                                    text: 'Try again',
                                                                                                    btnClass: 'btn-red',
                                                                                                    action: function () {

                                                                                                    }
                                                                                                },
                                                                                                close: function () {

                                                                                                }
                                                                                            }
                                                                                        });
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
                                                        function deleteClassification() {
                                                            var classissificationid = $('#Itemclassificationid').val();
                                                            $.ajax({
                                                                type: 'POST',
                                                                data: {classissificationid: classissificationid},
                                                                url: "essentialmedicinesandsupplieslist/deleteClassification.htm",
                                                                success: function (data, textStatus, jqXHR) {
                                                                    if (data === 'deleted') {
                                                                        ajaxSubmitData('essentialmedicinesandsupplieslist/essentialmedicinesandsupplieslisthome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    } else {
                                                                        $.confirm({
                                                                            title: 'Encountered an error!',
                                                                            content: 'Cannot Delete Classification Because Of <a href="#!">' + data + '</a> attachments?',
                                                                            type: 'red',
                                                                            typeAnimated: true,
                                                                            buttons: {
                                                                                tryAgain: {
                                                                                    text: 'Transfer',
                                                                                    btnClass: 'btn-red',
                                                                                    action: function () {
                                                                                        $.ajax({
                                                                                            type: 'GET',
                                                                                            data: {classissificationid: classissificationid},
                                                                                            url: "essentialmedicinesandsupplieslist/transferclassificationcategories.htm",
                                                                                            success: function (response) {
                                                                                                $.confirm({
                                                                                                    title: 'Select Category(ies) To Transfer',
                                                                                                    content: '' + response,
                                                                                                    boxWidth: '60%',
                                                                                                    useBootstrap: false,
                                                                                                    type: 'purple',
                                                                                                    typeAnimated: true,
                                                                                                    buttons: {
                                                                                                        tryAgain: {
                                                                                                            text: 'Transfer',
                                                                                                            btnClass: 'btn-purple',
                                                                                                            action: function () {

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
                                                                                close: function () {
                                                                                }
                                                                            }
                                                                        });
                                                                    }
                                                                }
                                                            });
                                                        }
                                                        function newgroupclassification() {
                                                            $.confirm({
                                                                title: 'SECTION',
                                                                content: '' +
                                                                        '<form action="" class="formName">' +
                                                                        '<div class="form-group">' +
                                                                        '<label>Section Name</label>' +
                                                                        '<input type="text" placeholder="Section name" class="groupclassificationsname form-control" required />' +
                                                                        '</div>' +
                                                                        '<div class="form-group">' +
                                                                        '<label>Section More Info</label>' +
                                                                        '<textarea class="groupclassificationsmoreinfo form-control" id="exampleFormControlTextarea1" rows="2"></textarea>' +
                                                                        '</div>' +
                                                                        '</form>',
                                                                type: 'purple',
                                                                closeIcon: true,
                                                                buttons: {
                                                                    formSubmit: {
                                                                        text: 'Save',
                                                                        btnClass: 'btn-purple',
                                                                        action: function () {
                                                                            var name = this.$content.find('.groupclassificationsname').val();
                                                                            var moreinfo = this.$content.find('.groupclassificationsmoreinfo').val();
                                                                            if (!name) {
                                                                                $.alert('provide a valid name');
                                                                                return false;
                                                                            }
                                                                            if (!moreinfo) {
                                                                                $.alert('provide a valid More Info');
                                                                                return false;
                                                                            }
                                                                            $.ajax({
                                                                                type: 'POST',
                                                                                data: {name: name, moreinfo: moreinfo},
                                                                                url: "essentialmedicinesandsupplieslist/newgroupclassification.htm",
                                                                                success: function (data, textStatus, jqXHR) {
                                                                                    $.confirm({
                                                                                        title: 'ADD SECTION',
                                                                                        content: 'Do You Want To Add Another Classification?',
                                                                                        type: 'purple',
                                                                                        typeAnimated: true,
                                                                                        buttons: {
                                                                                            tryAgain: {
                                                                                                text: 'Yes',
                                                                                                btnClass: 'btn-purple',
                                                                                                action: function () {
                                                                                                    newgroupclassification();
                                                                                                }
                                                                                            },
                                                                                            No: function () {
                                                                                                ajaxSubmitData('essentialmedicinesandsupplieslist/essentialmedicinesandsupplieslisthome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                                            }
                                                                                        }
                                                                                    });
                                                                                }
                                                                            });

                                                                        }
                                                                    },
                                                                    cancel: function () {
                                                                        //close
                                                                    },
                                                                }
                                                            });
                                                        }
                                                        function getgroupClassificationCategory(itemclassificationid, classificationname) {
                                                            document.getElementById('displaythenavigationspan').style.display = 'block';
                                                            document.getElementById('spanClassificationHeading').style.display = 'block';
                                                            document.getElementById('displaythenavigationspanCat').style.display = 'none';
                                                            document.getElementById('spanCategoryHeading').style.display = 'none';
                                                            document.getElementById('Itemclassificationid').value = itemclassificationid;
                                                            document.getElementById('Itemclassificationname').value = classificationname;
                                                            document.getElementById('thenavigationheadfdfgjgdff').innerHTML = classificationname;
                                                            ajaxSubmitData('essentialmedicinesandsupplieslist/getgroupClassificationCategory.htm', 'categoryItemsDivs', 'itemclassificationid=' + itemclassificationid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                        }
                                                        function itemsDescriptions() {
                                                            $.ajax({
                                                                type: 'GET',
                                                                data: {},
                                                                url: "essentialmedicinesandsupplieslist/getitemsdescriptionspacks.htm",
                                                                success: function (data, textStatus, jqXHR) {
                                                                    $.confirm({
                                                                        title: 'ITEMS DESCRIPTIONS',
                                                                        content: ''+data,
                                                                        type: 'purple',
                                                                        boxWidth:'60%',
                                                                        useBootstrap:false,
                                                                        typeAnimated: true,
                                                                        buttons: {
                                                                            close: function () {
                                                                             ajaxSubmitData('essentialmedicinesandsupplieslist/essentialmedicinesandsupplieslisthome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');   
                                                                            }
                                                                        }
                                                                    });
                                                                }
                                                            });
                                                        }
</script>
