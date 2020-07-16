<%-- 
    Document   : packageitemsearch
    Created on : Sep 14, 2018, 11:13:20 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
        <div class="tile-body">
            <div id="search-form_3">
                <input id="searchitem" autofocus type="text" oninput="searchItem()" placeholder="Search Item" onfocus="displaySearchResults()" class="search_3 dropbtn"/>
            </div>
            <div id="myDropdown" class="search-content">

            </div><br>
        </div>
    </div>
    <div class="col-md-2"></div>
</div>
<div class="" id="ItemsearchResults">

</div>
<input id="User-searched-items" type="hidden" />
<script>
      breadCrumb();
      $('#searchitem').on('input', function () {
        $('#ItemsearchResults').html('');
    });
    
    function displaySearchResults() {
        document.getElementById("myDropdown").classList.add("showSearch");
    }
    
    function trim(x) {
        return x.replace(/^\s+|\s+$/gm, '');
    }
    
    function searchItem() {
        var itemname= trim($('#searchitem').val());
        var size = itemname.length;
        if (size > 2) {
            $.ajax({
                type: "POST",
                cache: false,
                url: "packaging/searchitem.htm",
                data: {searchValue: itemname},
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
</script>

