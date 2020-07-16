<%-- 
    Document   : designations
    Created on : Mar 22, 2018, 9:33:48 AM
    Author     : SAMINUNU
--%>
<%@include file="../../../../include.jsp"%>

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
                    <li class="last active"><a href="#">Designation Categories & Posts</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="tab-pane active" id="classifications">
            <div class="tile user-settings">
                <div class="col-md-6">
                    <div class="form-group">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Facility Domain:</label>
                            <b>${model.faclilityDomainList.domainname}</b>
                            <input class="form-control" id="facilitydomainids" type="hidden" value="${model.faclilityDomainList.facilitydomainid}">
                            <input class="form-control" id="domainnames" type="hidden" value="${model.faclilityDomainList.domainname}">
                        </div>
                    </div>
                </div>

                <div class="row" style="margin: 10px;" id="thetable">
                    <div class="col-md-6 left">
                        <% int d = 1;%>
                        <a class="btn btn-primary icon-btn" href="#"  onclick="addUniversalFacilityDomain(this.id);" id="up2<%=d++%>" style="padding-left: 20px;">
                            <i class="fa fa-plus"></i>
                            ADD NEW DESIGNATION CATEGORY
                        </a>
                    </div>
                    <div class="col-md-6 right">
                        <% int w = 1;%>

                        <a 
                            class="btn btn-primary icon-btn" href="#" id="navigateposts" style="padding-left: 20px;">
                            <!--                            <i class="fa fa-plus"></i>-->
                            SEARCH IN POSTS
                        </a>
                    </div>



                    <!--                        <div class="modal fade" id="myModal" role="dialog">
                        <div class="modal-dialog">
                        
                           Modal content
                          <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title">NAVIGATE THROUGH DESIGNATION</h4>
                              <button type="button" class="close" data-dismiss="modal">&times;</button>          
                            </div>
                            <div class="modal-body">
                              <div class="" id="searchPostdiv">
                                                        </div>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                          </div>
                          
                        </div>
                      </div>-->

                    <div class="col-md-12">
                        <fieldset style="min-height:100px; margin-top: 1%;">
                            <div class="col-md-12" id="desigCat">
                                <div class="tile">
                                    <div class="tile-body">
                                        <%@include file="designationstable.jsp" %>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<div class="row">
    <div class="col-sm-12">
        <div id="adddesignations">
            <div class="modal fade col-sm-12" id="adddesig" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content" style="width:140%">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">
                                &times;
                            </button>
                        </div>
                        <div class="modal-body">
                            <%@include file="../form/adddesignations.jsp" %>
                        </div>

                        <div class="modal-body">
                            <%@include file="../form/searchposts.jsp" %>
                        </div>


                        <div class="modal-footer">
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    breadCrumb();
    $(document).ready(function () {
        $('#adddesigna').click(function () {
            $('#adddesig').modal('show');
        });

        $('#viewpostsearch').click(function () {
            ajaxSubmitData('postsandactivities/searchdesignation.htm', 'postsearch', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
        });
    });

    function addUniversalFacilityDomain(id) {
        var facilitydomainid = $("#facilitydomainids").val();
        var domainname = $("#domainnames").val();

        var tableData1 = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        document.getElementById('facilitydomainid').value = facilitydomainid;
        document.getElementById('domainname').value = domainname;
        $('#adddesig').modal('show');
    }

    function addUniversalPost(id) {
        var tableData = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');

        document.getElementById('designationcategoryid').value = tablerowid;
        document.getElementById('postdesignation').value = tableData[1];

        $('#addpost').modal('show');
    }

    $('#savedesignation').click(function () {
        var validdesignationname = $("#categoryname").val();
        if (validdesignationname === '') {
            $('#mc_msg').html('Please Enter Designation Name!!');
        } else {

            swal({
                title: "Save Designation Category?",
                type: "warning",
                showCancelButton: true,
                confirmButtonText: "Cancel",
                cancelButtonText: "Save",
                closeOnConfirm: true,
                closeOnCancel: false
            }
            ,
                    function (isConfirm) {
                        if (isConfirm) {

                            document.getElementById('categoryname').value = "";
                            document.getElementById('description').value = "";

                            swal("Deleted!", );
                        } else {
                            $('.close').click();
                            var categoryname = $('#categoryname').val();
                            var facilitydomainid = $('#facilitydomainid').val();
                            var description = $('#description').val();
                            $.ajax({
                                type: 'POST',
                                data: {categoryname: categoryname, facilitydomainid: facilitydomainid, description: description},
                                dataType: 'text',
                                url: "postsandactivities/saveDesignations.htm",
                                success: function (data) {
                                    swal("Saved", "Designation Category Added", "success");
                                    ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'workpane', '', 'GET');
                                }
                            });
                        }
                    });
        }
    });

    $('#navigateposts').on('click', function () {
     debugger
     
  $.ajax({
            type: 'GET',
            url: 'postsandactivities/searchInpostspane.htm',
            success: function (data) {
                debugger
                $.confirm({
                    title: 'NAVIGATE THROUGH DESIGNATION',
                    type: 'purple',
                    typeAnimated: true,
                    boxWidth: '30%',
                    closeIcon: true,
                    useBootstrap: false,
                    content: data,
                    onContentReady: function () {
//                        this.$content.find('#searcheddesignationnamesj').on('input', function(){
//                            debugger
//                            checksdesigname(this);
//                        });
                    },
                    buttons: {
                        ok: {
                            text: 'Check',
                            btnClass: 'btn btn-purple',
                            action: function () {
                                debugger
                                var designation = this.$content.find('#searcheddesignationnamesj').val();
                                checksdesigname(designation);
                            }
                        }
                    }
                });
            }
        });
    });
    
       
  function checksdesigname(val) {
        debugger
        var designationname = val;
        
        if (designationname.length > 0) {
            $.ajax({
                type: 'GET',
                data: {designationname: designationname},
                url: "postsandactivities/searchInposts.htm",
                success: function (response, textStatus, jqXHR) {
                    debugger
                    var result = JSON.parse(response);                    
                    var categoryname= result.category;                    
                        $.alert({
                            title: 'Alert!',
                            content: designationname + ' is located in ' + categoryname
                        });
                }
            });
        }
   
    }
  


  


</script>
