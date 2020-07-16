<%-- 
    Document   : laboratoryTests
    Created on : Aug 18, 2018, 5:13:37 PM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<hr style="border:1px dashed #dddddd;">
<c:if test="${act=='a'}">
    <div class="row">
        <c:forEach items="${laboratorytestclassificationsList}" var="a" varStatus="theCount">

            <c:if test="${theCount.count %2 !=0}">
                <div class="col-md-6" style="margin-top: 16px;">
                    <div class="card">
                        <header class="card-header">
                            <div class="row">
                                <div class="col-md-12">
                                    <a href="#" data-toggle="collapse" data-target="#collapse${a.labtestclassificationid}" aria-expanded="true" class="">
                                        <i class="icon-action fa fa-chevron-down"></i>
                                        <span class="title badge badge-patientinfo patientConfirmFont">${a.labtestclassificationname} </span>
                                    </a> 
                                </div>
                            </div>
                        </header>
                        <div class="collapse show" id="collapse${a.labtestclassificationid}" style="">
                            <article class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="tile">
                                            <form id="formdata1">
                                                <div id="horizontalwithwords"><span class="pat-form-heading">${theCount.count}</span></div> 
                                                    <c:if test="${a.size >0}">
                                                        <c:forEach items="${a.labaratorytestsList}" var="b">
                                                        <div class="custom-control custom-checkbox">
                                                            <input type="checkbox" class="custom-control-input" onchange="if (this.checked) {
                                                                        checkedLabTest(${b.laboratorytestid}, 'checked');
                                                                    } else {
                                                                        checkedLabTest(${b.laboratorytestid}, 'unchecked');
                                                                    }" id="defaultUnchecked${b.laboratorytestid}">
                                                            <label class="custom-control-label" for="defaultUnchecked${b.laboratorytestid}">${b.testname}</label>
                                                        </div>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${a.size <1}">
                                                    <h4 style="display: block"><span class="badge badge-danger"><strong>No Tests Under This Classification</strong></span></h4> 
                                                </c:if>
                                            </form>  
                                        </div>
                                    </div>
                                </div>
                            </article> 
                        </div> 
                    </div> 
                </div>
            </c:if>
            <c:if test="${theCount.count %2 ==0}">
                <div class="col-md-6" style="margin-top: 16px;">
                    <div class="card">
                        <header class="card-header">
                            <div class="row">
                                <div class="col-md-12">
                                    <a href="#" data-toggle="collapse" data-target="#collapse${a.labtestclassificationid}" aria-expanded="true" class="">
                                        <i class="icon-action fa fa-chevron-down"></i>
                                        <span class="title badge badge-patientinfo patientConfirmFont">${a.labtestclassificationname} </span>
                                    </a> 
                                </div>
                            </div>
                        </header>
                        <div class="collapse show" id="collapse${a.labtestclassificationid}" style="">
                            <article class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="tile">
                                            <form id="formdata1">
                                                <div id="horizontalwithwords"><span class="pat-form-heading">${theCount.count}</span></div> 
                                                    <c:if test="${a.size >0}">
                                                        <c:forEach items="${a.labaratorytestsList}" var="b">
                                                        <div class="custom-control custom-checkbox">
                                                            <input type="checkbox" class="custom-control-input" onchange="if (this.checked) {
                                                                        checkedLabTest(${b.laboratorytestid}, 'checked');
                                                                    } else {
                                                                        checkedLabTest(${b.laboratorytestid}, 'unchecked');
                                                                    }" id="defaultUnchecked${b.laboratorytestid}">
                                                            <label class="custom-control-label" for="defaultUnchecked${b.laboratorytestid}">${b.testname}</label>
                                                        </div>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${a.size <1}">
                                                    <h4 style="display: block"><span class="badge badge-danger"><strong>No Any Tests Under This Classification</strong></span></h4> 
                                                </c:if>
                                            </form>  
                                        </div>
                                    </div>
                                </div>
                            </article> 
                        </div> 
                    </div> 
                </div> 
            </c:if>
        </c:forEach>

    </c:if>
    <c:if test="${act=='b'}">
        <div class="col-md-12" style="margin-top: 16px;">
            <div class="card">
                <header class="card-header">
                    <div class="row">
                        <div class="col-md-12">
                            <a href="#" data-toggle="collapse" data-target="#collapseLabTests" aria-expanded="true" class="">
                                <i class="icon-action fa fa-chevron-down"></i>
                                <span class="title badge badge-patientinfo patientConfirmFont">Select Lab Tests </span>
                            </a> 
                        </div>
                    </div>
                </header>
                <div class="collapse show" id="collapseLabTests" style="">
                    <article class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div >
                                    <form id="formdata1">
                                        <div id="horizontalwithwords"><span class="pat-form-heading">1</span></div> 
                                        <div class="row">
                                            <div class="col-md-12">
                                                <c:if test="${not empty laboratorytestclassificationsList}">

                                                    <c:forEach items="${laboratorytestclassificationsList}" var="b" varStatus="theCount">


                                                        <div class="custom-control custom-checkbox">
                                                            <input type="checkbox" <c:if test="${b.assigned==true}">checked="true"</c:if> class="custom-control-input" onchange="if (this.checked) {
                                                                        checkedLabTest(${b.laboratorytestid}, 'checked', '${classification}', '${b.testname}');
                                                                    } else {
                                                                        checkedLabTest(${b.laboratorytestid}, 'unchecked', '${classification}', '${b.testname}');
                                                                    }" id="defaultUnchecked${b.laboratorytestid}">
                                                            <label class="custom-control-label" for="defaultUnchecked${b.laboratorytestid}">${b.testname}</label>
                                                        </div>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${empty laboratorytestclassificationsList}">
                                                    <h4 style="display: block"><span class="badge badge-danger"><strong>No Tests Under This Classification</strong></span></h4> 
                                                </c:if>
                                            </div>

                                        </div>
                                    </form>  
                                </div>
                            </div>
                        </div>
                    </article> 
                </div> 
            </div> 
        </div> 
    </c:if>
    <hr style="border:1px dashed #dddddd;">
</div> 
<script>
    function checkedLabTest(laboratorytestid, type, classification, testname) {
        if (type === 'checked') {
            patientLabTests.add(laboratorytestid);

            $('#addedpatientLaboratoryTests').append('<tr id="labTestAdded' + laboratorytestid + '"><td>' + testname + '</td>' +
                    '<td>' + classification + '</td>' +
                    '<td align="center"><span  title="Delete Of This Item." onclick="deletePatientLabTest(' + laboratorytestid + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');

        } else {
            patientLabTests.delete(laboratorytestid);
            $('#labTestAdded' + laboratorytestid).remove();
        }
        if (patientLabTests.size > 0) {
            document.getElementById('sendPatientsLabTstReq').style.display = 'block';
        } else {
            document.getElementById('sendPatientsLabTstReq').style.display = 'none';
        }
    }
    function deletePatientLabTest(laboratorytestid) {
        patientLabTests.delete(laboratorytestid);
        $('#labTestAdded' + laboratorytestid).remove();

        if (patientLabTests.size > 0) {
            document.getElementById('sendPatientsLabTstReq').style.display = 'block';
        } else {
            document.getElementById('sendPatientsLabTstReq').style.display = 'none';
        }
        $('#defaultUnchecked'+laboratorytestid).prop('checked',false);
    }
</script>