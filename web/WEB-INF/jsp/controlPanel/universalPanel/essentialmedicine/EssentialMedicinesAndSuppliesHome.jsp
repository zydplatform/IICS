<%-- 
    Document   : EssentialMedicinesAndSuppliesHome
    Created on : Jul 19, 2018, 8:25:23 AM
    Author     : IICS
--%>
<link rel="stylesheet" type="text/css" href="static/res/css/jquery.treefilter.css"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="app-title" id="">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>
    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li> 
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                    <li class="last active"><a href="#">Essential Medicines Lists</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <main id="main">
            <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab1">Essential Medicines</label>

            <input id="tab2" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab2">Essential Supplies</label>
            
            <input id="tab3" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab3">Deleted Items</label>
            
            <input id="tab4" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('bothermedicines/brotherMedicinesHome.htm', 'brotherMedicinesItemsDiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <label class="tabLabels" for="tab4">Essential Medicines</label>

            <section class="tabContent" id="content1">
                <%@include file="essentialMedicinesList.jsp" %>
            </section>
            <section class="tabContent" id="content2">

            </section>
            <section class="tabContent" id="content3">
                <div id="deletedItemsDiv">
                    
                </div>
            </section>
            
            <section class="tabContent" id="content4">
                <div id="brotherMedicinesItemsDiv">
                    
                </div>
            </section>
        </main>
    </div>
</div>

<script src="static/res/js/jquery.treefilter.js"></script>
<script>

                        $('#tab2').click(function () {
                            $.ajax({
                                type: 'GET',
                                data: {supplies: 'supplies'},
                                url: "essentialmedicinesandsupplieslist/essentialsupplieslist.htm",
                                success: function (data) {
                                    $('#content2').html(data);
                                }
                            });
                        });
                        $('#tab1').click(function () {
                            $('#content1').html('');
                            ajaxSubmitData('essentialmedicinesandsupplieslist/essentialmedicinesandsupplieslisthome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        });
                         $('#tab3').click(function () {
                            $.ajax({
                                type: 'GET',
                                data: {deleted: 'deleted'},
                                url: "essentialmedicinesandsupplieslist/deletedessentiallistmedicines.htm",
                                success: function (data, textStatus, jqXHR) {
                                    $('#deletedItemsDiv').html(data);
                                }
                            });
                        });
</script>