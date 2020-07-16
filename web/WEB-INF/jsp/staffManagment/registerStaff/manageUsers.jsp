<%-- 
    Document   : manageUsers
    Created on : May 31, 2018, 3:26:38 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../../include.jsp" %>
<style>
    .padding{
        margin-top: 3%;
    }
</style>
<div class="app-title">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>
    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                    <li><a href="#" onclick="ajaxSubmitData('staffmanager/staffmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Staff Management</a></li>
                    <!--<li><a href="#" onclick="ajaxSubmitData('staffmanager', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Manage and register</a></li>-->
                    <li class="last active"><a href="#">Register staff</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
        <div class="tile-body">
            <div id="search-form_3">
                <input id="Usersearch" autofocus maxlength="50" type="text" oninput="searchPatient()" placeholder="Search Staff" onfocus="displaySearchResults()" class="search_3 dropbtn"/>
            </div>
            <div id="myDropdown" class="search-content">

            </div><br>
        </div>
    </div>
    <div class="col-md-2"></div>
</div>

<div class="" id="Userdetails">

</div>
<div class="" id="Newuserregform">

</div>
<input id="User-searched-names" type="hidden" />
<script>
    breadCrumb();
    $('#Usersearch').on('input', function () {
        $('#Userdetails').html('');
        $('#Newuserregform').html('');
    });
    function displaySearchResults() {
        document.getElementById("myDropdown").classList.add("showSearch");
    }
    function trim(x) {
        return x.replace(/^\s+|\s+$/gm, '');
    }
    function searchPatient() {
        var student = trim($('#Usersearch').val());
        var size = student.length;
        if (size > 0) {
            $.ajax({
                type: "POST",
                cache: false,
                url: "staffmanager/searchuser.htm",
                data: {searchValue: student},
                success: function (response) {
                    $('#myDropdown').html(response);
                }
            });
        }else{
            
        }
    }
    function clearSearchResult() {
        document.getElementById('searchResults').style.display = 'none';
    }

    window.onclick = function (event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("search-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('showSearch')) {
                    openDropdown.classList.remove('showSearch');
                    $('#myDropdown').html('');
                }
            }
        }
    };
    
    function Registeruser() {
        var usersearchValue = $('#Usersearch').val();
        $("#User-searched-names").val(usersearchValue);
        document.getElementById("Usersearch").value = '';
        var usersearchValue = $("#User-searched-names").val();
        $('#Userdetails').html('');
        ajaxSubmitData('staffmanager/registernewstaff.htm', 'Newuserregform', 'usersname=' + usersearchValue + '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>