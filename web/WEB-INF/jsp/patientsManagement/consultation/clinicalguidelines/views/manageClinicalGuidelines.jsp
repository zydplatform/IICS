<%--
    Document   : manageClinicalGuidelines
    Created on : Aug 6, 2018, 2:19:55 PM
    Author     : IICS-GRACE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-body">
                <fieldset>
                    <div class="row">
                        <div class="col-md-12 right">
                            <button onclick="functionNewDiseaseClassification();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add Classification</button>
                        </div>
                    </div>
                    <div style="margin:1%;"></div>
                    <div class="easyui-layout" style="width:auto;height:400px;">
                        <div data-options="region:'west',split:true" title="Items" style="width:300px;"><br>
                            <ul id="my-trees">
                                <c:forEach items="${diseaseClassificationList}" var="classif">
                                    <li>
                                        <div><span id="class${classif.diseaseclassificationid}" onclick="manageDiseaseClassification('${classif.diseaseclassificationid}', '${classif.classifficationname}');">${classif.classifficationname}</span></div>
                                            <c:if test="${classif.diseaseCategoriessize > 0}">
                                            <ul>
                                                <c:forEach items="${classif.diseaseCategories}" var="cat">
                                                    <li>
                                                        <div><span id="categoryid${cat.diseasecategoryid}" onclick="manageDiseaseCategoriesFunction('${cat.diseasecategoryid}', '${cat.diseasecategoryname}')">${cat.diseasecategoryname}</span></div>
                                                            <c:if test="${cat.diseaseClassificationCategoryDiseaseListsize > 0}">
                                                            <ul id="diseaselistdata${cat.diseasecategoryid}">
                                                                <c:forEach items="${cat.diseaseClassificationCategoryDiseaseList}" var="dis">
                                                                    <li id="diseaselist${dis.diseaseid}">
                                                                        <div><span id="diseaseiid${dis.diseaseid}" onclick="functionDiseaseComponents('${dis.diseasename}', '${dis.diseaseid}', '${dis.diseasecode}', '${cat.diseasecategoryid}')" >${dis.diseasename}</span></div>
                                                                    </li>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </ul>

                        </div>
                        <div data-options="region:'center',title:'Title',iconCls:'icon-ok'" style="width:985px;"><br>

                            <div id="diseasecategoryItemsDivs"><br><br>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="tile">
                                            <h3 class="tile-title center">Uganda Clinical Guidelines</h3>
                                            <div class="tile-body">
                                                <medium class="center"><strong>The National Guidelines for Management of Common Conditions.</strong></medium>
                                                <p> The UCG aims to provide easy-to-use, practical, complete,
                                                    and useful information on how to correctly diagnose and
                                                    manage all common conditions you are likely to encounter.
                                                    This will ensure that patients receive the best possible clinical
                                                    services and obtain prompt and effective relief from or cure of
                                                    their complaint, thereby making the most appropriate use of
                                                    scarce diagnostic and clinical resources, including medicines.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>

<script>
    function functionNewDiseaseClassification() {
        $.confirm({
            title: 'Add New Classification!',
            content: '' +
                    '<div class="form-group required">' +
                    '<label>Classification Name</label>' +
                    '<input type="text" class="form-control" id="diseaseclassification"/>' +
                    '</div>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-purple',
                    action: function () {
                        var diseaseclassification = this.$content.find('#diseaseclassification').val();
                        if (!diseaseclassification) {
                            $.alert('Please Enter Classification Name!');
                            return false;

                        } else {
                            //SUBMIT Classification
                            var data = {
                                diseaseclassification: diseaseclassification
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "consultation/submitDiseaseClassification.htm",
                                data: data,
                                success: function (rep) {
                                    ajaxSubmitData('consultation/consultationhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    }
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

    function manageDiseaseClassification(diseaseclassificationid, diseaseclassificationname) {
        ajaxSubmitData('consultation/managediseaseclassificationcategories.htm', 'diseasecategoryItemsDivs', 'diseaseclassificationid=' + diseaseclassificationid + '&diseaseclassificationname=' + diseaseclassificationname + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }

    function manageDiseaseCategoriesFunction(categoryid, categoryname) {
        ajaxSubmitData('consultation/manageDiseaseCategories.htm', 'diseasecategoryItemsDivs', 'categoryid=' + categoryid + '&categoryname=' + categoryname + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }

    function functionDiseaseComponents(diseasename, diseaseid, diseasecode, categoryid) {
        ajaxSubmitData('consultation/manageDiseaseComponents.htm', 'diseasecategoryItemsDivs', 'diseasename=' + diseasename + '&diseaseid=' + diseaseid + '&diseasecode=' + diseasecode + '&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>