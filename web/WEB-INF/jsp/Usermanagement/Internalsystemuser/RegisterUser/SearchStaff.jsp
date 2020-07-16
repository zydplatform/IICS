<%-- 
    Document   : SearchStaff
    Created on : Apr 4, 2018, 9:55:48 PM
    Author     : IICS PROJECT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@include file="../../../include.jsp" %>
<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
        <div class="tile-body">
            <div id="search-form_3">
                <input id="Usersearch" autofocus maxlength="50" type="text" oninput="searchstaff()" placeholder="Search Staff" onfocus="displaySearchResults()" class="search_3 dropbtn"/>
            </div>
            <div id="myDropdown" class="search-content">

            </div><br>

        </div>
    </div>
    <div class="col-md-2"></div>
</div><br><br><br><br>
<div clas="row">
    <input id="User-searched-names" type="hidden" />
    <div class="studentinfo" id="staffinfo"></div>
</div>
<script type="text/javascript" src="static/res/js/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="static/res/js/plugins/dataTables.bootstrap.min.js"></script>
<script src="static/mainpane/js/table-data.js"></script>

<script>
                    function trim(x) {
                        return x.replace(/^\s+|\s+$/gm, '');
                    }
                    function displaySearchResults() {
                        document.getElementById("myDropdown").classList.add("showSearch");
                    }
                    function searchstaff() {
                        var student = trim($('#Usersearch').val());
                        var size = student.length;
                        if (size > 0) {
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "searchstaffs1.htm",
                                data: {searchValue: student},
                                success: function (response) {
                                    $('#myDropdown').html(response);
                                }
                            });
                        } else {

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
                                    $('#myDropdown').html('');
                                }
                            }
                        }
                    };
                    function clearSearchResult() {
                        document.getElementById('searchResults').style.display = 'none';
                    }
</script>
