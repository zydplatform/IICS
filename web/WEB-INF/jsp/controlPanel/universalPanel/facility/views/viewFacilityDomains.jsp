<%-- 
    Document   : viewFacilityDomains
    Created on : Mar 23, 2018, 2:29:08 AM
    Author     : Grace-K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<fieldset>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                        <thead class="col-md-12">
                            <tr>
                                <th class="center">No</th>
                                <th>Domain Name</th>
                                <th class="center">Levels</th>
                                <th>Designation Category</th>
                                <th class="center">Status</th>
                                <th class="center">More Info</th>
                                <th class="center">Update</th>
                            </tr>
                        </thead>
                        <tbody class="col-md-12" id="tableFacilityDomain">
                            <% int d = 1;%>
                            <% int k = 1;%>
                            <c:forEach items="${faclilityDomainList}" var="a">
                                <tr id="${a.facilitydomainid}">
                                    <td class="center"><%=k++%></td>
                                    <td>${a.domainname}</td>
                                    <td class="hide">${a.description}</td>
                                    <td class="center">
                                        <c:if test="${a.faclilityDomainLevelCount == 0}">
                                            <a href="#" data-domainid="${a.facilitydomainid}" data-domainname="${a.domainname}" class="add-new-facility-domain"><font color="blue">Pending</font></a>
                                            </c:if>
                                        <a href="#" onClick="" data-domainid2="${a.facilitydomainid}" data-domainname2="${a.domainname}" class="view-facility-domains">
                                            <c:if test="${a.faclilityDomainLevelCount == 1}">${a.faclilityDomainLevelCount} Level</c:if>
                                            <c:if test="${a.faclilityDomainLevelCount > 1}">${a.faclilityDomainLevelCount} Levels</c:if>
                                            </a>
                                        </td>

                                        <td>
                                        <c:if test="${a.facilityDesignationCategoryCount == 0}">
                                            <a href="#" data-domainidcat1="${a.facilitydomainid}" data-domainnamecat1="${a.domainname}" class="add-new-domain-category"><font color="blue">Pending</font></a>
                                            </c:if>
                                        <a href="#" onClick="" data-domainidcat2="${a.facilitydomainid}" data-domainnamecat2="${a.domainname}" class="view-domain-categories">
                                            <c:if test="${a.facilityDesignationCategoryCount == 1}">${a.facilityDesignationCategoryCount} Category</c:if>
                                            <c:if test="${a.facilityDesignationCategoryCount > 1}">${a.facilityDesignationCategoryCount} Categories</c:if>
                                            </a>
                                        </td>

                                        <td class="center">
                                        <c:if test="${a.status==true}">Active</c:if>
                                        <c:if test="${a.status==false}">Disabled</c:if>
                                        </td>

                                        <td class="center"><a id="" data-container="body" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="${a.description}" data-original-title="${a.domainname}" href="#"> <i class="fa fa-fw fa-lg fa-dedent"></i></a></td>
                                    <td class="center"><a href="#" onclick="updateFacilityDomain(this.id);" id="up2<%=d++%>"><i class="fa fa-fw fa-lg fa-edit"></i></a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div id="addnew-pane"></div>
                </div>
            </div>
        </div>
    </div>
</fieldset>

<!-- ADD NEW DOMAIN LEVELS -->           
<div class="modal fade col-md-12" id="addNewDomainLevels" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 250%; margin-left: -66%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">
                    <a href="#" id="" class="linkAddLevels"> Add New Level</a>&nbsp;
                    <span style="height: 26px; border-left: 3px solid black;"></span> &nbsp;
                    <a id="" class="linkUpdateLevels" href="#"> Update Domain Levels</a>&nbsp;
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body" id="facilityLevelContentsNew">
                                    <%@include file="../../facility/forms/addNewDomainLevels.jsp"%>
                                </div>
                                <div class="tile-footer">
                                    <div class="row">
                                        <div class="col-md-8 col-md-offset-3">
                                            <button id="saveNewDomainLevel" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseNewDomainLevel" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
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

<!-- ADD NEW DOMAIN CATEGORY -->           
<div class="modal fade col-md-12" id="addNewDomainCategory" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 250%; margin-left: -66%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">
                    <a href="#" id="" class="linkAddCategory"> Add New Category</a>&nbsp;
                    <span style="height: 26px; border-left: 3px solid black;"></span> &nbsp;
                    <a id="" class="linkUpdateCategory" href="#"> Update Domain Categories</a>&nbsp;
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body" id="facilityCategoryContentsNew">
                                    <%@include file="../../facility/forms/addNewDomainCategory.jsp"%>
                                </div>
                                <div class="tile-footer">
                                    <div class="row">
                                        <div class="col-md-offset-3">
                                            <button id="btnCloseNewDomainCategory" class="btn btn-secondary pull-right" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</button>
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

<!-- VIEW DOMAIN LEVELS -->           
<div class="modal fade col-md-12" id="viewDomainLevels" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 250%; margin-left: -66%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">
                    <a href="#" class="linkUpdateLevels2" onclick="">View Domain Levels</a>&nbsp;
                    <span style="height: 26px; border-left: 3px solid black;"></span> &nbsp;
                    <a href="#" class="linkAddLevels2" onclick=""> Add New Level</a>&nbsp;
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body" id="facilityLevelContentsUpdate">
                                    <%@include file="../../facility/views/viewFacilityLevels.jsp"%>
                                </div>
                                <div class="tile-footer">
                                    <div class="row">
                                        <div class="">
                                            <a id="btnCloseUpdateDomainLevel" class="btn btn-secondary pull-right" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
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

<!-- VIEW DOMAIN CATEGORIES -->           
<div class="modal fade col-md-12" id="viewDomainCategories" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 250%; margin-left: -66%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">
                    <a href="#" class="linkUpdateCategory2" onclick="">View Domain Categories</a>&nbsp;
                    <span style="height: 26px; border-left: 3px solid black;"></span> &nbsp;
                    <a href="#" class="linkAddCategory2" onclick=""> Add New Categories</a>&nbsp;
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body" id="facilityCategoryContentsUpdate">
                                    <%@include file="../../facility/views/viewDomainCategories.jsp"%>
                                </div>
                                <div class="tile-footer">
                                    <div class="row">
                                        <div class="">
                                            <a id="btnCloseUpdateDomainLevel" class="btn btn-secondary pull-right" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
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
<script>
    $(document).ready(function () {
        $('.bs-component [data-toggle="popover"]').popover();
    });

    function updateFacilityDomain(id) {
        var tableData1 = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        document.getElementById('facilitydomainid').value = tablerowid;
        document.getElementById('updatedomainname').value = tableData1[1];
        document.getElementById('updatedescription2').value = tableData1[2];
        $('#updateFacilityDomain').modal('show');
    }

    $('#saveUpdateFacilityDomain').click(function () {
        var updatedomainname = $('#updatedomainname').val();
        var updatedescription2 = $('#updatedescription2').val();
        var facilitydomainid = $('#facilitydomainid').val();

        var data = {
            updatedomainname: updatedomainname,
            updatedescription2: updatedescription2,
            facilitydomainid: facilitydomainid
        };
        $.ajax({
            type: "POST",
            cache: false,
            url: "facility/updatefacilitydomain.htm",
            data: data,
            success: function (response) {
                ajaxSubmitData('facility/viewfacilitydomains.htm', 'facliltyDomainContent', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
            }
        });
        $('#updateFacilityDomain').modal('hide');
    });

    $('.add-new-facility-domain').click(function () {
        var domainid = $(this).data('domainid');
        var facilitydomainname = $(this).data('domainname');

        $('#addNewDomainLevels').modal('show');
        document.getElementById('domainid').value = domainid;
        document.getElementById('facilitydomainname').value = facilitydomainname;
        $('.linkUpdateLevels').removeClass("highlight");
        $('.linkAddLevels').removeClass("unhighlight");
        $('.linkUpdateLevels').addClass("unhighlight");
        $('.linkAddLevels').addClass("highlight");

        $('.linkAddLevels').click(function () {
            $('.linkUpdateLevels').removeClass("highlight");
            $('.linkAddLevels').removeClass("unhighlight");

            $('.linkAddLevels').addClass("highlight");
            $('.linkUpdateLevels').addClass("unhighlight");
            ajaxSubmitData('facility/addnewdomainlevel.htm', 'facilityLevelContentsNew', 'domainid=' + domainid + '&domainname=' + facilitydomainname + '&act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
        });

        $('.linkUpdateLevels').click(function () {
            $('.linkUpdateLevels').removeClass("unhighlight");
            $('.linkAddLevels').removeClass("highlight");

            $('.linkUpdateLevels').addClass("highlight");
            $('.linkAddLevels').addClass("unhighlight");
            ajaxSubmitData('facility/viewfacilitylevel.htm', 'facilityLevelContentsNew', 'domainid=' + domainid + '&domainname=' + facilitydomainname + '&act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
        });

    });

    $('.view-facility-domains').click(function () {
        var domainid2 = $(this).data('domainid2');
        var facilitydomainname2 = $(this).data('domainname2');

        $('#viewDomainLevels').modal('show');
        $('.linkUpdateLevels2').removeClass("unhighlight");
        $('.linkAddLevels2').removeClass("highlight");

        $('.linkUpdateLevels2').addClass("highlight");
        $('.linkAddLevels2').addClass("unhighlight");
        ajaxSubmitData('facility/viewfacilitylevel.htm', 'facilityLevelContentsUpdate', 'domainid=' + domainid2 + '&domainname=' + facilitydomainname2 + '&act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');

        $('.linkAddLevels2').click(function () {
            $('.linkUpdateLevels2').removeClass("highlight");
            $('.linkAddLevels2').removeClass("unhighlight");

            $('.linkAddLevels2').addClass("highlight");
            $('.linkUpdateLevels2').addClass("unhighlight");
            ajaxSubmitData('facility/addnewdomainlevel.htm', 'facilityLevelContentsUpdate', 'domainid=' + domainid2 + '&domainname=' + facilitydomainname2 + '&act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');

        });
        $('.linkUpdateLevels2').click(function () {
            $('.linkUpdateLevels2').removeClass("unhighlight");
            $('.linkAddLevels2').removeClass("highlight");

            $('.linkUpdateLevels2').addClass("highlight");
            $('.linkAddLevels2').addClass("unhighlight");
            ajaxSubmitData('facility/viewfacilitylevel.htm', 'facilityLevelContentsUpdate', 'domainid=' + domainid2 + '&domainname=' + facilitydomainname2 + '&act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
        });

    });

    $('#btnCloseFacilityDomainUpdate').click(function () {
        $('#updateFacilityDomain').modal('hide');
        $('#saveUpdateFacilityDomain').click(null);
    });

    $('#btnCloseNewDomainLevel').click(function () {
        $('#addNewDomainLevels').modal('hide');
        $('#saveNewDomainLevel').click(null);
    });

    $('#btnCloseNewDomainCategory').click(function () {
        $('#addNewDomainCategory').modal('hide');
    });

    $('#btnCloseUpdateDomainLevel').click(function () {
        $('#viewDomainLevels').modal('hide');
    });

    $('.add-new-domain-category').click(function () {
        var domainidcat1 = $(this).data('domainidcat1');
        var domainnamecat1 = $(this).data('domainnamecat1');

        $('#addNewDomainCategory').modal('show');
        document.getElementById('domainid').value = domainidcat1;
        document.getElementById('facilitydomainnamecat').value = domainnamecat1;
        $('.linkUpdateCategory').removeClass("highlight");
        $('.linkAddCategory').removeClass("unhighlight");
        $('.linkUpdateCategory').addClass("unhighlight");
        $('.linkAddCategory').addClass("highlight");

        $('.linkAddCategory').click(function () {
            $('.linkUpdateCategory').removeClass("highlight");
            $('.linkAddCategory').removeClass("unhighlight");

            $('.linkAddCategory').addClass("highlight");
            $('.linkUpdateLevels').addClass("unhighlight");
              ajaxSubmitData('facility/addnewdomaincategory.htm', 'facilityCategoryContentsNew', 'domainid=' + domainidcat1 + '&domainname=' + domainnamecat1 + '&act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
        });

        $('.linkUpdateCategory').click(function () {
            $('.linkUpdateCategory').removeClass("unhighlight");
            $('.linkAddCategory').removeClass("highlight");

            $('.linkUpdateCategory').addClass("highlight");
            $('.linkAddCategory').addClass("unhighlight");
            ajaxSubmitData('facility/viewfacilitycategories.htm', 'facilityCategoryContentsNew', 'domainid=' + domainidcat1 + '&domainname=' + domainnamecat1 + '&act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
        });
    });

    $('.view-domain-categories').click(function () {
        var domainidcat2 = $(this).data('domainidcat2');
        var domainnamecat2 = $(this).data('domainnamecat2');

        $('#viewDomainCategories').modal('show');
        $('.linkUpdateCategory2').removeClass("unhighlight");
        $('.linkAddCategory2').removeClass("highlight");

        $('.linkUpdateCategory2').addClass("highlight");
        $('.linkAddCategory2').addClass("unhighlight");
        ajaxSubmitData('facility/viewfacilitycategories.htm', 'facilityCategoryContentsUpdate', 'domainid=' + domainidcat2 + '&domainname=' + domainnamecat2 + '&act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');

        $('.linkAddCategory2').click(function () {
            $('.linkUpdateCategory2').removeClass("highlight");
            $('.linkAddCategory2').removeClass("unhighlight");

            $('.linkAddCategory2').addClass("highlight");
            $('.linkUpdateCategory2').addClass("unhighlight");
            ajaxSubmitData('facility/addnewdomaincategory.htm', 'facilityCategoryContentsUpdate', 'domainid=' + domainidcat2 + '&domainname=' + domainnamecat2 + '&act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');

        });
        $('.linkUpdateCategory2').click(function () {
            $('.linkUpdateCategory2').removeClass("unhighlight");
            $('.linkAddCategory2').removeClass("highlight");

            $('.linkUpdateCategory2').addClass("highlight");
            $('.linkAddCategory2').addClass("unhighlight");
            ajaxSubmitData('facility/viewfacilitycategories.htm', 'facilityCategoryContentsUpdate', 'domainid=' + domainidcat2 + '&domainname=' + domainnamecat2 + '&act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
        });

    });

</script>