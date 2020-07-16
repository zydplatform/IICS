<%-- 
    Document   : setUpFacility
    Created on : Dec 8, 2017, 11:22:47 AM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<script src="static/mainpane/plugins/bootstrap-fileupload/bootstrap-fileupload.min.js"></script>
<link rel="stylesheet" href="static/mainpane/plugins/bootstrap-fileupload/bootstrap-fileupload.min.css">
<link rel="stylesheet" href="static/mainpane/css/autoCompleteDropList.css">
<script type="text/javascript" src="static/js/fileupload/uploadAttachments.js"></script>

<br>
<div class="box box-color box-bordered">    
    <div class="box-title">
        <h3>
            <i class="fa fa-home"></i>
            Facility Settings - Set Up Facility Under Domain: ${model.domainRef.domainname}
        </h3>
    </div>

    <div class="row">
        <div class="col-md-12">
            <!-- start: FORM VALIDATION 1 PANEL -->
            <div class="panel panel-default">
                <fieldset style="width: 99%">
                    <div class="panel-heading" style="display:none">
                        <h4><i class="fa fa-pencil-square teal"></i> New Facility Registration </h4>
                    </div>
                    <div class="panel-body" id="orgResponse-pane">
                        <form name="submitData" id="submitData">              
                            <div class="row tile" id="facInfoDiv">
                                <div class="col-md-4">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="tile">
                                                <div class="tile-body">
                                                    <div id="horizontalwithwords"><span class="pat-form-heading">FACILITY DETAILS</span></div>

                                                    <div class="form-group required">
                                                        <label class="control-label" for="fLevel">Select Level Of Facility:</label>
                                                        <select class="form-control" id="level" name="level">
                                                            <option value="0">--Select Facility Level--</option>
                                                            <c:forEach items="${model.levels}" var="level">                                
                                                                <option value="${level[0]}">${level[1]}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label required">
                                                            Code <span class="symbol required"></span>
                                                        </label>
                                                        <input id="facilitycode" class="form-control" value="${model.facObj.facilitycode}" placeholder="${model.facilitycode} [Code]" name="facilitycode" maxlength="8" onChange="ajaxSubmitData('facilityRegCheck.htm', 'codeChkResp', 'act=a&i=0&b=' + this.value + '&c=a&d=0', 'GET');"/>
                                                        <div id="codeChkResp"></div>
                                                        <input type="hidden" id="codeChk" value="true"/>
                                                    </div>
                                                    <div class="form-group required">
                                                        <label class="control-label">
                                                            Facility Name
                                                        </label>
                                                        <input id="facilityval" class="form-control" value="${model.facObj.facilityname}" placeholder="Facility Name" name="facilityname" onChange="ajaxSubmitData('facilityRegCheck.htm', 'nameChkResp', 'act=b&i=0&b=' + this.value + '&c=a&d=0', 'GET');"/> 
                                                        <div id="nameChkResp"></div>
                                                        <input type="hidden" id="nameChk" value="true"/>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label">
                                                            Short Name
                                                        </label>
                                                        <input id="shortname" class="form-control" value="${model.facObj.shortname}" placeholder="Short Name" name="shortname"/> 
                                                    </div>
                                                    <div class="form-group required">
                                                        <label class="control-label">
                                                            Facility Owner:
                                                        </label>
                                                        <select class="form-control" id="fowner" name="owner" onChange="if (this.value == 0) {
                                                                    return false;
                                                                }">
                                                            <option value="0" <c:if test="${empty model.facObj.facilityownerid}">selected="selected"</c:if>>--Select Ownership--</option>
                                                            <c:if test="${empty model.ownerListArr}">
                                                                <option value="${model.facObj.facilityownerid.facilityownerid}" <c:if test="${not empty model.facObj.facilityownerid}">selected="selected"</c:if>>${model.facObj.facilityownerid.ownername}</option>
                                                            </c:if>
                                                            <c:forEach items="${model.ownerListArr}" var="owners">                                
                                                                <option value="${owners[0]}" <c:if test="${model.facObj.facilityownerid.facilityownerid==owners[0]}">selected="selected"</c:if>>${owners[1]}</option>
                                                            </c:forEach>
                                                        </select>
                                                        <div id="ownerChkResp"></div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label">
                                                            Description: <span class="required symbol"></span>
                                                        </label>
                                                        <textarea name="description" id="descriptionval" placeholder="About Facility" class='form-control'>${model.facObj.description}</textarea>
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

                                                <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">LOCATION/CONTACT DETAILS</span></div>
                                                <div class="form-group required">
                                                    <label class="control-label">Location</label>
                                                    <select class="form-control select-district" id="districtlist">
                                                        <option value="0">-Select Facility District-</option>
                                                    </select>
                                                
                                                    <select class="form-control select-village" id="fvillage" name="village">
                                                        <option value="0">-Select Facility Village-</option>
                                                    </select>
                                                    <div id="vilChkResp"></div>
                                                    <textarea name="location" id="locationval" placeholder="Street, LC" class='form-control'>${model.facObj.location}</textarea>
                                                        <div id="locChkResp"></div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label" for="phoneno">Phone No.</label>
                                                    <input class="form-control" id="telContact" name="telContact" type="text" placeholder="Active Primary Telephone/Mobile Phone Contact"/>
                                                    <input class="form-control" id="telContact2" name="telContact2" type="text" placeholder="Secondary Contact"/>
                                                    <input type="hidden" id="phoneChk" value="true"/>
                                                    <div id="phoneChkResp"></div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label" for="emailContact">
                                                        Email Contact:<span class="symbol required">
                                                    </label>
                                                    <textarea name="emailContact" id="emailContact" placeholder="Separate Facility Email Addresses With Comma" class='form-control' onChange="commafyEmail(this.value);">${model.facObj.emailaddress}</textarea>
                                                    <input type="hidden" id="emailChk" value="true"/>
                                                    <div id="emailChkResp"></div>
                                                </div> 
                                                <div class="form-group">
                                                    <label class="control-label" for="website">
                                                        Website:<span class="symbol required">
                                                    </label>
                                                    <textarea name="website" id="website" class='form-control' placeholder="e.g. https://www.ss.com [Separate With Comma]" onChange="commafyWebsite(this.value);">${model.facObj.website}</textarea>
                                                    <input type="hidden" id="websiteChk" value="true"/>
                                                    <div id="websiteChkResp"></div>
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
                                                    <label class="control-label">
                                                        Status: <span class="symbol required"></span>
                                                    </label>
                                                    Active: <input type="radio" name="status" id="fstatus" <c:if test="${model.facObj.active==true}">checked="checked"</c:if> value="true"/>
                                                        &nbsp;&nbsp;
                                                        Inactive: <input type="radio" name="status" id="tstatus" <c:if test="${model.facObj.active==false || empty model.facObj}">checked="checked"</c:if> value="false"/>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label">
                                                            Has Departments: <span class="symbol required"></span>
                                                        </label>
                                                        Yes: <input type="radio" name="hasDept" id="hasDeptY" <c:if test="${model.facObj.hasdepartments==true}">checked="checked"</c:if>  value="true" onChange="showDiv('selectBranch');
                                                                $('#school').val('');"/>
                                                        &nbsp;&nbsp;
                                                        No: <input type="radio" name="hasDept" id="hasDeptN" <c:if test="${model.facObj.hasdepartments==false || empty model.facObj}">checked="checked"</c:if>  value="false" onChange="hideDiv('selectBranch');
                                                                $('#school').val('');"/> 
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label" for="postaddress">
                                                            Postal Address:
                                                        </label>
                                                        <textarea name="postaddress" id="postaddress" placeholder="i.e. P.O. Box 000 Kla-Uganda" class='form-control'>${model.facObj.postaddress}</textarea>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label" for="facilitylogo">
                                                        Facility Logo Upload
                                                    </label>
                                                    <div class="fileupload fileupload-new" data-provides="fileupload">
                                                        <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;"><img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA?text=no+image" alt=""/>
                                                        </div>
                                                        <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
                                                        <div>
                                                            <span class="btn btn-light-grey btn-file"><span class="fileupload-new"><i class="fa fa-picture-o"></i> Select image</span><span class="fileupload-exists"><i class="fa fa-picture-o"></i> Change</span>
                                                                <input type="file" id="browsed" accept=".jpg, .jpeg, .png">
                                                                <input type="hidden" id="urlPathSet">
                                                            </span>
                                                            <a href="#" class="btn fileupload-exists btn-light-grey" data-dismiss="fileupload">
                                                                <i class="fa fa-times"></i> Remove
                                                            </a>
                                                            <a href="#" class="btn fileupload-exists btn-light-grey" onClick="uploadAttachment('uploadUserPhoto.htm', 'FacilityLogo', 'urlPathSet', 'browsed');">
                                                                <i class="fa fa-picture"></i> Upload
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="row" id="submitBtns">
                                                <div class="col-sm-12">
                                                    <div class="form-actions" >
                                                        <input type="hidden" name="cref" id="cref" value="${model.facObj.facilityid}"/>
                                                        <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                                        <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                                        <div align="left" style="alignment-adjust: central;">
                                                            <div id="btnSaveHide">
                                                                <input type="button" name="button" class='btn btn-primary icon-btn' value="<c:if test="${empty model.facObj}">Save</c:if><c:if test="${not empty model.facObj}">Update</c:if> Facility" onClick="var resp = validateB4SubmitFacility();
                                                                        if (resp === false) {return false;} ajaxSubmitForm('registerFacility.htm', 'orgResponse-pane', 'submitData');"/>
                                                                &nbsp;&nbsp;
                                                                <input name="" type="reset" value="Reset" class="btn" onClick="$(this.form)[0].reset()">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>  
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>


<script>

    function commafyPhone(str) {
        var newStr = '';
        if (str.length > 10) {
            var str_array = str.split(",");
            for (var i = 0; i < str_array.length; i++) {
                newStr += str_array[i].replace(/(\d{10})/g, '$1,');
            }
            return newStr;
        }
        return str;
    }
    function commafyEmail(str) {
        var resp = true;
        if (str.length > 1) {
            var str_array = str.split(",");
            for (var i = 0; i < str_array.length; i++) {
                //newStr+=str_array[i].replace(/(\d{10})/g,'$1,');
                var checkEmail = validateEmail(str_array[i]);
                if (checkEmail === false) {
                    resp = false;
                    showWarningSuccess('INVALID EMAIL', 'Invalid Email Address:' + str_array[i] + '!', 'warning', 'emailChkResp');
                }
            }
        }
        $('#emailChk').val(resp);
        return resp;
    }
    function commafyWebsite(str) {
        var resp = true;
        if (str.length > 1) {
            var str_array = str.split(",");
            for (var i = 0; i < str_array.length; i++) {
                var regex = /(http|https):\/\/(\w+:{0,1}\w*)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%!\-\/]))?/;
                if (!regex.test(str_array[i])) {
                    showWarningSuccess('INVALID WEBSITE', 'Invalid Website Address:' + str_array[i] + '!', 'warning', 'websiteChkResp');
                    resp = false;
                }
            }
        }
        $('#websiteChk').val(resp);
        return resp;
    }

    $('#facSetUpByDesc').modal('show');

    function validateB4SubmitFacility() {
        var facilityname = document.getElementById('facilityval').value;
        var level = document.getElementById('level').value;
        var owner = document.getElementById('fowner').value;
        var village = document.getElementById('fvillage').value;
        var location = document.getElementById('locationval').value;
        var description = document.getElementById('descriptionval').value;
        var codeChk = document.getElementById('codeChk').value;
        var nameChk = document.getElementById('nameChk').value;
        var phone = document.getElementById('phoneChk').value;
        var email = document.getElementById('emailChk').value;
        var website = document.getElementById('websiteChk').value;
        //alert('facilityname:'+facilityname);
        var email = document.getElementById('emailContact').value;

        if (facilityname === null || facilityname === '' || nameChk === false || owner === null || owner === '0' || owner === '' || 
                level === null || level === '0' || level === '' || village === null || village === '0' || village === '' || location === '' || location === null
                || phone === false || email === false || website === false || codeChk === false) {//owner==null || owner=='' || 
            if (level === null || level === '' || level === '0') {
                //alert('Facility Owner Missing!');
                showWarningSuccess('MISSING DETAILS', 'Facility Level Missing!', 'warning', 'ownerChkResp');
            }
            if (owner === null || owner === '' || owner === '0') {
                //alert('Facility Owner Missing!');
                showWarningSuccess('MISSING DETAILS', 'Facility Owner Missing!', 'warning', 'ownerChkResp');
            }
            if (facilityname === null || facilityname === '') {
                //alert('Facility Name Missing!');
                showWarningSuccess('MISSING DETAILS', 'Facility Name Missing!', 'warning', 'nameChkResp');
            }
            if (village === null || village === '' || village === '0') {
                //alert('Facility Village Missing!');
                showWarningSuccess('MISSING DETAILS', 'Facility Village Location Missing!', 'warning', 'vilChkResp');
            }
            if (location === null || location === '') {
                //alert('Facility Location Description Missing!');
                showWarningSuccess('MISSING DETAILS', 'Facility Location Description/LC Missing!', 'warning', 'locChkResp');
            }
            if (nameChk === false) {
                showWarningSuccess('Name Verification', 'Name Supplied Is Already In Use!', 'warning', 'nameChkResp');
            }
            if (codeChk === false) {
                showWarningSuccess('Code Verification', 'Code Supplied Is Already In Use!', 'warning', 'codeChkResp');
            }
            if (phone === false) {
                showWarningSuccess('INVALID DETAILS', 'Wrong Facility Phone Contact!', 'warning', 'phoneChkResp');
            }
            if (email === false) {
                showWarningSuccess('INVALID DETAILS', 'Wrong Facility Email Address!', 'warning', 'emailChkResp');
            }
            if (website === false) {
                showWarningSuccess('INVALID DETAILS', 'Wrong Facility Website Address!', 'warning', 'websiteChkResp');
            }
            return false;
        }
        if (email !== null && email !== '') {
            if (commafyEmail(email) !== true) {
                //alert('Invalid Email Address!');
                showWarningSuccess('MISSING DETAILS', 'Invalid Email Address!', 'warning', 'emailChkResp');
                return false;
            }
        }
        return true;
    }

    function validateEmail(email) {
        var atpos = email.indexOf("@");
        var dotpos = email.lastIndexOf(".");
        if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
            return false;
        }
        return true;
    }

    function showWarningSuccess(title, message, type, div) {
        $.toast({
            heading: title,
            text: message,
            icon: type,
            hideAfter: 6000,
            //position: 'mid-center'
            element: '#' + div,
            position: 'mid-center',
        });

    }

    $(document).ready(function () {
        breadCrumb();

        $('#telContact').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });
        $('#telContact2').usPhoneFormat({
            format: '(xxx) xxx-xxxx'
        });

        $('.select2').css('width', '100%');

        $('#districtlist').click(function () {
            //alert('xxxxxxxxxx');
            $.ajax({
                type: 'POST',
                url: 'locations/fetchDistricts.htm',
                success: function (data) {
                    var res = JSON.parse(data);
                    if (res !== '' && res.length > 0) {
                        for (i in res) {
                            $('#districtlist').append('<option class="textbolder" id="' + res[i].id + '" data-districtname="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                        }
                        var districtid = parseInt($('#districtlist').val());
                        $.ajax({
                            type: 'POST',
                            url: 'locations/fetchDistrictVillages.htm',
                            data: {districtid: districtid},
                            success: function (data) {
                                var res = JSON.parse(data);
                                if (res !== '' && res.length > 0) {
                                    for (i in res) {
                                        $('#fvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename="' + res[i].village + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                    }
                                }
                            }
                        });
                    }
                }
            });
            $('.select-district').select2();
            $('.select-village').select2();
            $('.select2').css('width', '100%');

            $('#districtlist').change(function () {
                $('#fvillage').val(null).trigger('change');
                var districtid = parseInt($('#districtlist').val());
                $.ajax({
                    type: 'POST',
                    url: 'locations/fetchDistrictVillages.htm',
                    data: {districtid: districtid},
                    success: function (data) {
                        var res = JSON.parse(data);
                        if (res !== '' && res.length > 0) {
                            $('#fvillage').html('');
                            for (i in res) {
                                console.log(res[i].village);
                                $('#fvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename="' + res[i].village + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                            }
                        }
                    }
                });
            });
        });
    });



</script>

<div id="TempDialogDiv"></div>
