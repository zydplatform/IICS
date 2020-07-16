
<%@include file="../../../include.jsp"%>
<div>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <div class="tile-body">
                <div id="search-form_3">
                    <input id="fileSearch" type="text" oninput="searchFile()" placeholder="Search Patient File" onfocus="displaySearchResults()" class="search_3 dropbtn"/>
                </div>
                <div id="myDropdown" class="search-content">

                </div><br>
            </div>

        </div>
        <div class="col-md-1"></div>
    </div>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10" id="filedetailspane">
        </div> 
        <div class="col-md-1"></div>
    </div>  
    <!--model Manage Order Items-->
    <div class="">
        <div id="newFileForm" class="newPatientFileForm">
            <div class="scrollbar">
                <div id="head">
                    <h3 class="modal-title" id="title"><font color="purple">New Patient File Form</font></h3>
                    <a href="#close" title="Close" class="close2">X</a>
                    <hr>
                </div>
                <div class="">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="row" id="newFileContent">
                                    
                                </div>
                                <div class="tile-footer row">
                                    <div class="col-lg-2 offset-lg-10">
                                     <input type="button" value="Create" class="btn btn-primary" onClick="ajaxSubmitNewFile('patients/newfile.htm', 'POST');"/>
                                 </div>
                                  </div>
                            </div>
                        </div>
                    </div>
                     </div>
                </div>
           
        </div>
    </div>
    
    
    