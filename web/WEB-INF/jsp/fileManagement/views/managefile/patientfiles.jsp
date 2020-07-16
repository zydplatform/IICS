<%@include file="../../../include.jsp"%>
<div id="mainxxx">
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
                    <li><a href="#" onclick="ajaxSubmitData('patients/filemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Patient Files</a></li>
                    <li class="last active"><a href="#">Manage Files</a></li>
                </ul>
            </div>
        </div>
        </div>
    </div>
    <main  class="col-md-12 col-sm-12">
        <div>
            <%@include file="fileDetails.jsp" %>
            </div>
    </main>
</div>
<script>
    breadCrumb();
    function displaySearchResults() {
        document.getElementById("myDropdown").classList.add("showSearch");
    }  
    function searchFile() {
       var fileSearch = trim($('#fileSearch').val());
    function trim(x) {
        return x.replace(/^\s+|\s+$/gm, '');
       }
            $.ajax({
                type: "POST",
                cache: false,
                url: "patients/searchfile.htm",
                data: {searchValue: fileSearch},
                success: function (response) {
                    $('#myDropdown').html(response);
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
function viewPatientFileDetails(fileid,fileno,pname,datecreatedId,statusId,staffid) {
      $.ajax({
                type: "GET",
                cache: false,
                url: "patients/patientfiledetails.htm",
                data: {staffid:staffid,pname:pname,fileid:fileid,fileno:fileno,statusId:statusId,datecreatedId:datecreatedId},
                success: function (response) {
                    $('#filedetailspane').html(response);
                }
            });
        }
    /***************Fetching  new patient file Form ***************/
   function ajaxShowNewFormDialog(){
        var fileSearch = $('#fileSearch').val();
      $.ajax({
                type: "GET",
                cache: false,
                url: 'patients/newfile.htm',
                data: {fileSearch:fileSearch},
                success: function (response) {
                    $('#newFileContent').html(response);
                }
            });
        window.location = '#newFileForm';
        initDialog('newPatientFileForm');
        }
            </script>
