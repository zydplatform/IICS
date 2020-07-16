<%-- 
    Document   : searchdonor
    Created on : Sep 10, 2018, 12:41:42 PM
    Author     : RESEARCH
--%>
<div class="container-fluid">
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
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Local Setting</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('localsettigs/manage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Manage</a></li>
                        <li class="last active"><a href="#">Donor Program</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div class="tile-body">
                    <div id="search-form_3">
                        <input id="Donorsearch" autofocus maxlength="50" type="text" oninput="searchDonor();" placeholder="Search Donor" onfocus="displaySearchResults()" class="search_3 dropbtn"/>
                    </div>
                    <div id="myDropdown" class="search-content">

                    </div><br>
                </div>
            </div>
            <div class="col-md-2"></div>
        </div><br>
        <div class="row">
            <input id="User-searched-names" type="hidden" />
            <div class="col-md-12">
                <div class="studentinfo" id="donorinfo">

                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group"  id="donorinfos">

                </div>
            </div>
        </div>
    </div>
</div>
<script>
    breadCrumb();
    ajaxSubmitData('internaldonorprogram/viewDonorStats', 'donorinfos', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    function trim(x) {
        return x.replace(/^\s+|\s+$/gm, '');
    }
    function displaySearchResults() {
        document.getElementById("myDropdown").classList.add("showSearch");
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

    function searchDonor() {
        var donor = $('#Donorsearch').val();
        console.log("-----------donor" + donor);
        var size = donor.length;
        if (size >= 1) {
            $.ajax({
                type: "POST",
                cache: false,
                url: "internaldonorprogram/searchFacilityDonors.htm",
                data: {searchValue: donor},
                success: function (response) {
                    $('#myDropdown').html(response);
                }
            });
        } else {

        }
    }

    function clearSearchResult() {
        document.getElementById('searchResults').style.display = 'none';
    }
</script>
