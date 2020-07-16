<%-- 
    Document   : viewFacilityDetail
    Created on : Nov 29, 2017, 8:40:27 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div id="updateDiv">
    <c:set var="titleAct" value="Add New"></c:set>    
    <c:if test="${not empty model.facObj}"><c:set var="titleAct" value="Update"></c:set></c:if>

            <fieldset style="width:95%; margin: 0 auto;">
                <legend> 
                    <div style="float:left" align="left"><a id="back" href="#"  onClick="${model.returnURL}"> <i class="fa fa-backward"></i></a></div>
            &nbsp;&nbsp;&nbsp;
            Details For Facility: ${model.facObj.facilityname} 
            &nbsp;&nbsp;&nbsp;
            <a href="#" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit/Update" onClick="ajaxSubmitData('orgFacilitySettings.htm', 'updateDiv', 'act=c&i=${model.facObj.facilityid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-edit"></i></a>
            <a href="#" class="btn btn-xs btn-bricky tooltips" data-placement="top" data-original-title="Remove" onClick="discardFacility('${model.facObj.facilityid}','${model.facObj.facilityname}'); 
                    return false;
                    ajaxSubmitData('orgFacilitySettings.htm', 'updateDiv', 'act=g&i=${model.facObj.facilityid}&b=${model.b}&c=${model.c}&d=0&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-fw fa-lg fa-cut"></i></a>
        </legend>
        <div class="box box-color box-bordered" id="updateDiv">
            <div class="row tile" id="facInfoDiv">
                <div class="col-md-4">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <div id="horizontalwithwords"><span class="pat-form-heading">FACILITY DETAILS</span></div>
                                    <div class="form-group">
                                        <label class="control-label" for="fLevel">Level Of Facility:</label>
                                        <c:if test="${not empty model.facObj.facilitylevelid.facilitylevelname}">${model.facObj.facilitylevelid.facilitylevelname}</c:if>
                                        <c:if test="${empty model.facObj.facilitylevelid.facilitylevelname}"><span class="text2">Pending</span></c:if>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Code</label>
                                        <c:if test="${not empty model.facObj.facilitycode}">${model.facObj.facilitycode}</c:if>
                                        <c:if test="${empty model.facObj.facilitycode}"><span class="text2">Pending</span></c:if>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                Facility Name
                                            </label>
                                        <c:if test="${not empty model.facObj.facilityname}">${model.facObj.facilityname}</c:if>
                                        <c:if test="${empty model.facObj.facilityname}"><span class="text2">Pending</span></c:if>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                Short Name
                                            </label>
                                        <c:if test="${not empty model.facObj.shortname}">${model.facObj.shortname}</c:if>
                                        <c:if test="${empty model.facObj.shortname}"><span class="text2">Pending</span></c:if>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                Facility Owner:
                                            </label>
                                        <c:if test="${not empty model.facObj.facilityownerid.ownername}">${model.facObj.facilityownerid.ownername}</c:if>
                                        <c:if test="${empty model.facObj.facilityownerid.ownername}"><span class="text2">Pending</span></c:if>
                                            <div id="ownerChkResp"></div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                Description: <span class="required symbol"></span>
                                            </label>
                                        <c:if test="${not empty model.facObj.description}">${model.facObj.description}</c:if>
                                        <c:if test="${empty model.facObj.description}"><span class="text2">Pending</span></c:if>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">

                                    <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">LOCATION</span></div>
                                    <div class="form-group">
                                        <label class="control-label">Region:</label>
                                    <c:if test="${not empty model.facObj.village.parishid.subcountyid.countyid.districtid.regionid}">${model.facObj.village.parishid.subcountyid.countyid.districtid.regionid.regionname}</c:if>
                                    <c:if test="${empty model.facObj.village.parishid.subcountyid.countyid.districtid.regionid}"><span class="text2">Pending</span></c:if>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">
                                            District:
                                        </label>
                                    <c:if test="${not empty model.facObj.village.parishid.subcountyid.countyid.districtid}">${model.facObj.village.parishid.subcountyid.countyid.districtid.districtname}</c:if>
                                    <c:if test="${empty model.facObj.village.parishid.subcountyid.countyid.districtid}"><span class="text2">Pending</span></c:if> 
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">
                                            County:
                                        </label>
                                    <c:if test="${not empty model.facObj.village.parishid.subcountyid.countyid.countyname}">${model.facObj.village.parishid.subcountyid.countyid.countyname}</c:if>
                                    <c:if test="${empty model.facObj.village}"><span class="text2">Pending</span></c:if> 
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">
                                            Village:
                                        </label>
                                    <c:if test="${not empty model.facObj.village}">${model.facObj.village.villagename}</c:if>
                                    <c:if test="${empty model.facObj.village}"><span class="text2">Pending</span></c:if> 
                                    </div>  
                                    <div class="form-group">
                                        <label class="control-label">
                                            Street/LC:
                                        </label>
                                    <c:if test="${not empty model.facObj.location}">${model.facObj.location}</c:if>
                                    <c:if test="${empty model.facObj.location}"><span class="text2">Pending</span></c:if>   
                                    </div> 
                                    <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">CONTACT DETAILS</span></div>

                                    <div class="form-group">
                                        <label class="control-label">Phone Contact:</label>
                                    <c:if test="${not empty model.facObj.phonecontact}">${model.facObj.phonecontact}</c:if>
                                    <c:if test="${empty model.facObj.phonecontact}"><span class="text2">Pending</span></c:if>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Email Address:</label>
                                    <c:if test="${not empty model.facObj.emailaddress}">${model.facObj.emailaddress}</c:if>
                                    <c:if test="${empty model.facObj.emailaddress}"><span class="text2">Pending</span></c:if>
                                    </div> 
                                    <div class="form-group">
                                        <label class="control-label">Web Site:</label>
                                    <c:if test="${not empty model.facObj.website}">${model.facObj.website}</c:if>
                                    <c:if test="${empty model.facObj.website}"><span class="text2">Pending</span></c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">

                                    <div id="horizontalwithwords"><span class="pat-form-heading">OTHER DETAILS</span></div>
                                    <div class="form-group">
                                        <label class="control-label" for="status">Status:</label>
                                    <c:if test="${not empty model.facObj.active}">
                                        <c:if test="${model.facObj.active==true}">Active</c:if>
                                        <c:if test="${model.facObj.active==false}"><span style="color:red">Inactive</span></c:if>
                                    </c:if>
                                    <c:if test="${empty model.facObj.active}"><span class="text2">Pending</span></c:if>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label" for="status">Has Departments:</label>
                                    <c:if test="${not empty model.facObj.hasdepartments}">
                                        <c:if test="${model.facObj.hasdepartments==true}">Yes</c:if>
                                        <c:if test="${model.facObj.hasdepartments==false}">No</c:if>
                                    </c:if>
                                    <c:if test="${empty model.facObj.hasdepartments}"><span class="text2">Pending</span></c:if>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label" for="status">Added By:</label>
                                    <c:if test="${not empty model.facObj.person2.firstname}">${model.facObj.person2.firstname} ${model.facObj.person2.lastname}</c:if>
                                    <c:if test="${empty model.facObj.person2.firstname}"><span class="text2">Pending</span></c:if> <br>
                                    <fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${model.facObj.dateadded}"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label" for="status">Approved By:</label>
                                    <c:if test="${not empty model.facObj.person1.firstname}">${model.facObj.person1.firstname} ${model.facObj.person1.lastname}</c:if>
                                    <c:if test="${empty model.facObj.person1.firstname}"><span class="text2">Pending</span></c:if> <br>
                                    <fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${model.facObj.dateapproved}"/>
                                </div>
                                <div id="horizontalwithwords">
                                    <span class="pat-form-heading">POLICIES</span> 
                                    <a href="#" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit/Update" onClick="ajaxSubmitData('orgFacilitySettings.htm', 'updateDiv', 'act=e&i=${model.facObj.facilityid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-edit"></i></a>
                                </div>
                                <div class="form-group">
                                    <c:if test="${not empty model.policyList}">
                                        <c:forEach items="${model.policyList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                            <div class="form-group">
                                                <label class="control-label">${list.category} - ${list.policyname}</label>
                                                <ul>
                                                    <c:forEach items="${list.facilitypolicyoptionsList}" var="list2">
                                                        <li><i>${list2.name}</i></li>
                                                            </c:forEach>
                                                </ul>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty model.policyList}">
                                        <label class="control-label">No Polcies Attached To This Facility</label>
                                    </c:if>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!--<div class="">
        <c:if test="${model.formActivity=='a'}">
            <button class="btn btn-primary pull-right" id="delFacility" type="button"><i class="fa fa-fw fa-lg fa-cut"></i>Delete</button>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button class="btn btn-primary pull-right" id="editFacility" type="button"><i class="fa fa-fw fa-lg fa-edit"></i>Update</button>
        </c:if>
    </div>
        -->
    </fieldset>
</div>

<script>
    function discardFacility(fid, name) {
        $.confirm({
            title: 'Are You Sure You Want Facility: ' + name + '?',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {fId: fid},
                            url: "deleteSelectedFacility.htm",
                            success: function (data, textStatus, jqXHR) {
                                //console.log("faciliyid:::::::::::::" + fid);
                                if (data === 'success') {
                                    $.confirm({
                                        title: 'Deleted/Discarded ' + name + 'Successfully',
                                        type: 'orange',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                ${model.returnURL}
                                            }
                                        }
                                    });
                                } else {
                                    $.confirm({
                                        title: 'Delete/Discard ' + name,
                                        content: ''+data+'',
                                        type: 'red',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'OK',
                                                btnClass: 'btn-red',
                                                action: function () {
                                                }
                                            },
                                            NO: function () {
                                            }
                                        }
                                    });
                                }
                            }
                        });

                    }
                },
                NO: function () {

                }
            }
        });
    }
</script>