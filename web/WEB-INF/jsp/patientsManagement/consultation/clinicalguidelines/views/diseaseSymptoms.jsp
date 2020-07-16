<%-- 
    Document   : diseaseSymptoms
    Created on : Oct 26, 2018, 7:52:23 AM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<style>
    .autocomplete-suggestions { border: 1px solid #999; width: 54% !important; background: ghostwhite; cursor: default; overflow: auto; z-index: 99999999 !important; }
    .autocomplete-suggestion { padding: 1%; width: 100% !important; font-size: 1.2em; white-space: normal; overflow: hidden; z-index: 99999999 !important;}
    .autocomplete-selected { background: #f0f0f0; }
    .autocomplete-suggestions strong { font-weight: normal; color: #3399ff; }
</style>

<div class="tile" id="disease-symptoms-component">
    <div class="tile-body">
        <section class="module">
            <div class="row">
                <div id="content" class="col-md-10">
                    <div id="searchfield">
                        <form><input type="text" placeholder="Enter Clinical Feature" name="currency"  class="form-control biginput" oninput="setinputvaluestatus(this.value);" id="autocompletesymbol"></form>
                    </div><br>
                    <div id="outputbox">
                        <p id="outputcontent" style="display: none;"></p>
                    </div>
                </div>
                <div class=" col-md-2">
                    <button onclick="functionAddSymptomToDisease('${diseaseid}', '${diseasename}', '${diseasecode}')" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-plus-circle"></i>Add</button> 
                </div>
            </div>
            <h1 class="module__heading module__heading--c">Clinical Features</h1>

            <ol class="custom-bullet custom-bullet--c">
                <c:choose>
                    <c:when test="${diseaseSymptomListsize > 0}">
                        <c:forEach items="${diseaseSymptomList}" var="s">
                            <li>* <span id="symptom${s.symptomid}">${s.symptomname}</span> <span onclick="updateDiseaseSymptom('${s.symptomid}', '${diseasename}', '${diseaseid}', '${diseasecode}');" title="Edit Of Disease Symptom."  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span> | <span onclick="deleteDiseaseSymptom('${s.symptomid}', '${s.diseasesymptomid}', '${diseasename}', '${diseaseid}', '${diseasecode}');" title="Delete Of Disease Symptom."  class="badge badge-danger icon-custom"><i class="fa fa-times"></i></span></li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                        <p class="center">No Clinical Features attached</p>
                    </c:otherwise>
                </c:choose>
            </ol>
        </section>
    </div>
</div>

<script src="static/res/js/jquery.autocomplete.min.js"></script>
<script>
                                var globalDiseaseSymptoms = [];
                                var symptomid;
                                var inputcheck;
                                    $.ajax({
                                        type: 'POST',
                                        data: {},
                                        url: "consultation/diseaseSymptomsSearched.htm",
                                        success: function (data) {
                                            var response = JSON.parse(data);
                                            for (index in response) {
                                                var results = response[index];
                                                globalDiseaseSymptoms.push({
                                                    value: results["value"],
                                                    symptomid: results["symptomid"]
                                                });
                                            }
                                        }
                                    });

                                    $('#autocompletesymbol').autocomplete({
                                        lookup: globalDiseaseSymptoms,
                                        onSelect: function (suggestion) {
                                            inputcheck = 1;
                                            symptomid = suggestion.symptomid;
                                        }
                                    });

                                function functionAddSymptomToDisease(diseaseid, diseasename, diseasecode) {
                                    var symptomInput = $('#autocompletesymbol').val();
                                    if (symptomInput.toString().length < 1) {
                                        document.getElementById('autocompletesymbol').focus();
                                    } else {
                                        if (inputcheck === 1) {
                                            $.ajax({
                                                type: "POST",
                                                cache: false,
                                                url: "consultation/addDiseaseSymptom.htm",
                                                data: {diseaseid: diseaseid, symptom: symptomInput, type: inputcheck, symptomid: symptomid},
                                                success: function (rep) {
                                                    if (rep === 'success') {
                                                        ajaxSubmitData('consultation/manageDiseaseComponents.htm', 'diseasecategoryItemsDivs', 'diseasename=' + diseasename + '&diseaseid=' + diseaseid + '&diseasecode=' + diseasecode + '&ofst=1&maxR=100&sStr=', 'GET');
                                                    }
                                                    if (rep === 'exists') {
                                                        ajaxSubmitData('consultation/manageDiseaseComponents.htm', 'diseasecategoryItemsDivs', 'diseasename=' + diseasename + '&diseaseid=' + diseaseid + '&diseasecode=' + diseasecode + '&ofst=1&maxR=100&sStr=', 'GET');
                                                    }
                                                }
                                            });
                                        }

                                        if (inputcheck === 0) {
                                            $.ajax({
                                                type: "POST",
                                                cache: false,
                                                url: "consultation/addDiseaseSymptom.htm",
                                                data: {diseaseid: diseaseid, symptom: symptomInput, type: inputcheck},
                                                success: function (rep) {
                                                    if (rep === 'success') {
                                                        ajaxSubmitData('consultation/manageDiseaseComponents.htm', 'diseasecategoryItemsDivs', 'diseasename=' + diseasename + '&diseaseid=' + diseaseid + '&diseasecode=' + diseasecode + '&ofst=1&maxR=100&sStr=', 'GET');
                                                    }
                                                }
                                            });
                                        }
                                    }
                                }

                                function setinputvaluestatus() {
                                    inputcheck = 0;
                                }

                                function updateDiseaseSymptom(symptomid, diseasename, diseaseid, diseasecode) {
                                    var diseasesymptomname = $('#symptom' + symptomid).text();
                                    $.confirm({
                                        title: 'Update Disease Symptom!',
                                        typeAnimated: true,
                                        type: 'purple',
                                        content: '' +
                                                '<div class="form-group">' +
                                                '<label>Symptom Name</label>' +
                                                '<textarea class="form-control" id="diseasesymptomid" rows="">' + diseasesymptomname + '</textarea>' +
                                                '</div>',
                                        buttons: {
                                            formSubmit: {
                                                text: 'Update',
                                                btnClass: 'btn-purple',
                                                action: function () {
                                                    var name = this.$content.find('#diseasesymptomid').val();
                                                    if (!name) {
                                                        $.alert('Please provide a valid name');
                                                        return false;
                                                    }
                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {symptomid: symptomid, diseasesymptomname: name},
                                                        url: "consultation/updateDiseaseSymptom.htm",
                                                        success: function (response) {
                                                            if (response === 'success') {
                                                                $('#symptom' + symptomid).text(name);
                                                                ajaxSubmitData('consultation/manageDiseaseComponents.htm', 'diseasecategoryItemsDivs', 'diseasename=' + diseasename + '&diseaseid=' + diseaseid + '&diseasecode=' + diseasecode + '&ofst=1&maxR=100&sStr=', 'GET');
                                                            }
                                                        }
                                                    });
                                                }
                                            },
                                            cancel: function () {
                                                //close
                                            }
                                        },
                                        onContentReady: function () {
                                            // bind to events
                                            var jc = this;
                                            this.$content.find('form').on('submit', function (e) {
                                                // if the user submits the form by pressing enter in the field.
                                                e.preventDefault();
                                                jc.$$formSubmit.trigger('click'); // reference the button and click it
                                            });
                                        }
                                    });
                                }

                                function deleteDiseaseSymptom(symptomid, diseasesymptomid, diseasename, diseaseid, diseasecode) {
                                    var diseasesymptomname = $('#symptom' + symptomid).text();
                                    $.confirm({
                                        title: 'Delete Disease Symptom!',
                                        typeAnimated: true,
                                        type: 'purple',
                                        content: diseasesymptomname,
                                        buttons: {
                                            formSubmit: {
                                                text: 'Delete',
                                                btnClass: 'btn-purple',
                                                action: function () {
                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {diseasesymptomid: diseasesymptomid},
                                                        url: "consultation/deleteDiseaseSymptom.htm",
                                                        success: function (response) {
                                                            if (response === 'deleted') {
                                                                ajaxSubmitData('consultation/manageDiseaseComponents.htm', 'diseasecategoryItemsDivs', 'diseasename=' + diseasename + '&diseaseid=' + diseaseid + '&diseasecode=' + diseasecode + '&ofst=1&maxR=100&sStr=', 'GET');
                                                            }
                                                        }
                                                    });
                                                }
                                            },
                                            cancel: function () {
                                                //close
                                            }
                                        },
                                        onContentReady: function () {
                                            // bind to events
                                            var jc = this;
                                            this.$content.find('form').on('submit', function (e) {
                                                // if the user submits the form by pressing enter in the field.
                                                e.preventDefault();
                                                jc.$$formSubmit.trigger('click'); // reference the button and click it
                                            });
                                        }
                                    });
                                }
</script>
