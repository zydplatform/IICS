
<%@include file="../../include.jsp"%>
<div class="row justify-content-center">
    <input type="hidden" value="${fileno}" id="filenoValue"/>
    <div class="col-md-10">
        <div class="tile-body">
            <div id="search-form_3">
                <input id="staffSearch" type="text" oninput="searchStaff()" placeholder="Search Staff" onfocus="displaySearchResults2()" class="search_3 dropbtn"/>
            </div>

        </div>
        <div id="myStaffDropdown" class="search-content">

        </div><br>
    </div>
</div>
  <br>  
<div class="row justify-content-center">
   <div class="col-md-10" id="staffDetails">
   
   </div>
     
</div> 
<script>
    breadCrumb();
    function displaySearchResults2() {
        document.getElementById("myStaffDropdown").classList.add("showSearch");
    }
    function searchStaff() {
        var staff = trim($('#staffSearch').val());
       function trim(x) {
            return x.replace(/^\s+|\s+$/gm, '');
        }
        var size = staff.length;
        $.ajax({
            type: "POST",
            cache: false,
            url: "fileassignment/searchstaffs.htm",
            data: {searchValue: staff},
            success: function (response) {
                $('#myStaffDropdown').html(response);
            }
        });
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
                }
            }
        }
    };
</script>