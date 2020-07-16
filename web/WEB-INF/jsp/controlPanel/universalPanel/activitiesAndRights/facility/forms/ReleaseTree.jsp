<%-- 
    Document   : componentTree
    Created on : Mar 23, 2018, 4:05:33 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../../include.jsp" %>
<style type="text/css">

    .treeview ul{ /*CSS for Simple Tree Menu*/
        margin: 0;
        padding: 0;
        font-size: 16px;
    }

    .treeview li{ /*Style for LI elements in general (excludes an LI that contains sub lists)*/
        background: white url(static/images/list1.png) no-repeat left center;
        list-style-type: none;
        padding-left: 22px;
        margin-bottom: 3px;
        font-size: 16px;
    }

    .treeview li.submenu{ /* Style for LI that contains sub lists (other ULs). */
        background: white url(static/images/closed.jpg) no-repeat left 1px;
        cursor: hand !important;
        cursor: pointer !important;
        font-size: 16px;
        min-height: 20px;
        margin-left: auto;
    }


    .treeview li.submenu ul{ /*Style for ULs that are children of LIs (submenu) */
        display: none; /*Hide them by default. Don't delete. */
    }

    .treeview .submenu ul li{ /*Style for LIs of ULs that are children of LIs (submenu) */
        cursor: default;
        background-color: #FBFBEF;
    }

</style>
<form name="submitForm" id="submitForm">
    <fieldset class="ContentPaneX" style="text-align:left;">
        <div class="ChildContentPaneX">
            <h5 class="CustH2" >RELEASE ACTIVITIES</h5>
            <hr style="border: none; height: 1px; color: blue; background: blue;" />
            <div style="margin-left: 20px;">
                <a href="javascript:ddtreemenu.flatten('treemenu1', 'expand')">Expand All</a> | <a href="javascript:ddtreemenu.flatten('treemenu1', 'contact')">Contract All</a>                
                <br/><br/>
                <fieldset style="
                          margin-left: 20px; 
                          background-color: #FFFFFF; /*Applying CSS 3radius*/   
                          -moz-border-radius: 4px;
                          -webkit-border-radius: 4px;
                          border-radius: 4px;
                          /*Applying CSS3 box shadow*/
                          -moz-box-shadow: 0 0 2px #DDDDDD;
                          -webkit-box-shadow: 0 0 2px #DDDDDD;
                          box-shadow: 0 0 2px #DDDDDD; border: 
                          solid 0px #ffffff;">    

                    <ul id="treemenu1" class="treeview">
                        <c:forEach items="${model.customList}" var="list" varStatus="status" begin="0" end="${model.size}">
                            <li><span class="CustH4">${status.count}: <c:if test="${list.assigned==false}"><img src="static/images/disabledsmall.png" title="${list.systemmodule.componentname} Not Assigned To ${model.groupname}!"/></c:if>
                                    <c:if test="${list.assigned==true}"><img src="static/images/authorisedsmall.png" title="${list.systemmodule.componentname} Assigned To ${model.groupname}"/></c:if>
                                    ${list.systemmodule.componentname} <span style="font-size:10px"> [${list.systemmodule.activity}]</span>
                                    <c:if test="${list.systemmodule.hasprivilege==true && list.systemmodule.activity=='Activity'}">

                                        <c:if test="${list.assigned==false}"><span style="font-size:10px; color:#006600"><b><i>Add</i></b></span></c:if>
                                        <c:if test="${list.assigned==true}"><span style="font-size:10px; color:#D82222"><b><i>Discard</i></b></span> </c:if>
                                        <input <c:if test="${list.systemmodule.hasprivilege==false}">disabled="disabled"</c:if> <c:if test="${list.selected==true}">checked="checked"</c:if> type="checkbox" <c:if test="${list.assigned==true}">checked="checked"</c:if> name="manageObj${status.count}" id="manageObj${status.count}" value="${list.systemmodule.privilegeid}" onChange="if (this.checked) {
                                                    checkedoruncheckprivReleaseFacility('checked', this.value, ${list.assigned});
                                                } else {
                                                    checkedoruncheckprivReleaseFacility('unchecked', this.value, ${list.assigned});
                                                }"/>
                                    </c:if></span>
                                    <c:if test="${list.submodules>0}">
                                    <ul id="treemenu2" class="treeview">
                                        <c:forEach items="${list.customSystemmoduleList}"  var="list2" varStatus="status">
                                            <li style="background-color: #FFCCFF; margin-top: 3px; margin-bottom: 3px; font-size: 14px"><span style="color: #08088A; font-size: 16px">${status.count}: <c:if test="${list2.assigned==false}"><img src="static/images/disabledsmall.png" title="${list2.systemmodule.componentname} Not Assigned To ${model.groupname}!"/></c:if>
                                                    <c:if test="${list2.assigned==true}"><img src="static/images/authorisedsmall.png" title="${list2.systemmodule.componentname} Assigned To ${model.groupname}"/></c:if>
                                                    ${list2.systemmodule.componentname} <span style="font-size:10px"> [${list2.systemmodule.activity}]</span>
                                                    <c:if test="${list2.systemmodule.hasprivilege==true && list2.systemmodule.activity=='Activity'}">

                                                        <c:if test="${list2.assigned==false}"><span style="font-size:10px; color:#006600"><b><i>Add</i></b></span></c:if>
                                                        <c:if test="${list2.assigned==true}"><span style="font-size:10px; color:#D82222"><b><i>Discard</i></b></span> </c:if>
                                                        <input <c:if test="${list2.systemmodule.hasprivilege==false}">disabled="disabled"</c:if> <c:if test="${list2.selected==true}">checked="checked"</c:if> type="checkbox" <c:if test="${list2.assigned==true}">checked="checked"</c:if> name="manageObj${status.count}" id="manageObj${status.count}" value="${list2.systemmodule.privilegeid}" onChange="if (this.checked) {
                                                                    checkedoruncheckprivReleaseFacility('checked', this.value, ${list2.assigned});
                                                                } else {
                                                                    checkedoruncheckprivReleaseFacility('unchecked', this.value, ${list2.assigned});
                                                                }"/>
                                                    </c:if></span>
                                                    <c:if test="${list2.submodules>0}">
                                                    <ul>
                                                        <c:forEach items="${list2.customSystemmoduleList}"  var="list3" varStatus="status">
                                                            <li style="background-color: #ECE0F8;"><span style="color: #006600; font-size: 15px; font-style: italic;"><c:if test="${list3.assigned==false}"><img src="static/images/disabledsmall.png" title="${list3.systemmodule.componentname} Not Assigned To ${model.groupname}!"/></c:if>
                                                                    <c:if test="${list3.assigned==true}"><img src="static/images/authorisedsmall.png" title="${list3.systemmodule.componentname} Assigned To ${model.groupname}"/></c:if>
                                                                    ${list3.systemmodule.componentname} <span style="font-size:10px"> [${list3.systemmodule.activity}]</span>
                                                                    <c:if test="${list3.systemmodule.hasprivilege==true && list3.systemmodule.activity=='Activity'}">

                                                                        <c:if test="${list3.assigned==false}"><span style="font-size:10px; color:#006600"><b><i>Add</i></b></span></c:if>
                                                                        <c:if test="${list3.assigned==true}"><span style="font-size:10px; color:#D82222"><b><i>Discard</i></b></span> </c:if>
                                                                        <input <c:if test="${list3.systemmodule.hasprivilege==false}">disabled="disabled"</c:if> <c:if test="${list3.selected==true}">checked="checked"</c:if> type="checkbox" <c:if test="${list3.assigned==true}">checked="checked"</c:if> name="manageObj${status.count}" id="manageObj${status.count}" value="${list3.systemmodule.privilegeid}" onChange="if (this.checked) {
                                                                                    checkedoruncheckprivReleaseFacility('checked', this.value, ${list3.assigned});
                                                                                } else {
                                                                                    checkedoruncheckprivReleaseFacility('unchecked', this.value, ${list3.assigned});
                                                                                }"/>
                                                                    </c:if></span>
                                                                    <c:if test="${list3.submodules>0}">
                                                                    <ul>
                                                                        <c:forEach items="${list3.customSystemmoduleList}"  var="list4" varStatus="status">
                                                                            <li style="background-color: #F8EFFB; margin-top: 3px; margin-bottom: 3px; font-size: 14px"><span style="color: #2E2EFE;"><c:if test="${list4.assigned==false}"><img src="static/images/disabledsmall.png" title="${list4.systemmodule.componentname} Not Assigned To ${model.groupname}!"/></c:if>
                                                                                    <c:if test="${list4.assigned==true}"><img src="static/images/authorisedsmall.png" title="${list4.systemmodule.componentname} Assigned To ${model.groupname}"/></c:if>
                                                                                    ${list4.systemmodule.componentname} <span style="font-size:10px"> [${list4.systemmodule.activity}]</span>
                                                                                    <c:if test="${list4.systemmodule.hasprivilege==true && list4.systemmodule.activity=='Activity'}">

                                                                                        <c:if test="${list4.assigned==false}"><span style="font-size:10px; color:#006600"><b><i>Add</i></b></span></c:if>
                                                                                        <c:if test="${list4.assigned==true}"><span style="font-size:10px; color:#D82222"><b><i>Discard</i></b></span> </c:if>
                                                                                        <input <c:if test="${list4.systemmodule.hasprivilege==false}">disabled="disabled"</c:if> <c:if test="${list4.selected==true}">checked="checked"</c:if> type="checkbox" <c:if test="${list4.assigned==true}">checked="checked"</c:if> name="manageObj${status.count}" id="manageObj${status.count}" value="${list4.systemmodule.privilegeid}" onChange="if (this.checked) {
                                                                                                    checkedoruncheckprivReleaseFacility('checked', this.value, ${list4.assigned});
                                                                                                } else {
                                                                                                    checkedoruncheckprivReleaseFacility('unchecked', this.value, ${list4.assigned});
                                                                                                }"/>
                                                                                    </c:if></span>
                                                                                    <c:if test="${list4.submodules>0}">
                                                                                    <ul>
                                                                                        <c:forEach items="${list4.customSystemmoduleList}"  var="list5" varStatus="status">
                                                                                            <li style="background-color: #FFCCFF; margin-top: 3px; margin-bottom: 3px; font-size: 14px"><span style="color: #191919; font-style: italic;"><c:if test="${list5.assigned==false}"><img src="static/images/disabledsmall.png" title="${list5.systemmodule.componentname} Not Assigned To ${model.groupname}!"/></c:if>
                                                                                                    <c:if test="${list5.assigned==true}"><img src="static/images/authorisedsmall.png" title="${list5.systemmodule.componentname} Assigned To ${model.groupname}"/></c:if>
                                                                                                    ${list5.systemmodule.componentname} <span style="font-size:10px"> [${list5.systemmodule.activity}]</span>
                                                                                                    <c:if test="${list5.systemmodule.hasprivilege==true && list5.systemmodule.activity=='Activity'}">

                                                                                                        <c:if test="${list5.assigned==false}"><span style="font-size:10px; color:#006600"><b><i>Add</i></b></span></c:if>
                                                                                                        <c:if test="${list5.assigned==true}"><span style="font-size:10px; color:#D82222"><b><i>Discard</i></b></span> </c:if>
                                                                                                        <input <c:if test="${list5.systemmodule.hasprivilege==false}">disabled="disabled"</c:if> <c:if test="${list5.selected==true}">checked="checked"</c:if> type="checkbox" <c:if test="${list5.assigned==true}">checked="checked"</c:if> name="manageObj${status.count}" id="manageObj${status.count}" value="${list5.systemmodule.privilegeid}" onChange="if (this.checked) {
                                                                                                                    checkedoruncheckprivReleaseFacility('checked', this.value, ${list5.assigned});
                                                                                                                } else {
                                                                                                                    checkedoruncheckprivReleaseFacility('unchecked', this.value, ${list5.assigned});
                                                                                                                }"/>
                                                                                                    </c:if></span>
                                                                                                    <c:if test="${list5.submodules>0}">
                                                                                                    <ul>
                                                                                                        <c:forEach items="${list5.customSystemmoduleList}"  var="list6" varStatus="status">
                                                                                                            <li style="background-color: #ECE0F8; margin-top: 3px; margin-bottom: 3px; font-size: 14px"><span style="color: #006600; font-style: italic;"><c:if test="${list6.assigned==false}"><img src="static/images/disabledsmall.png" title="${list6.systemmodule.componentname} Not Assigned To ${model.groupname}!"/></c:if>
                                                                                                                    <c:if test="${list6.assigned==true}"><img src="static/images/authorisedsmall.png" title="${list6.systemmodule.componentname} Assigned To ${model.groupname}"/></c:if>
                                                                                                                    ${list6.systemmodule.componentname} <span style="font-size:10px"> [${list6.systemmodule.activity}]</span>
                                                                                                                    <c:if test="${list6.systemmodule.hasprivilege==true && list6.systemmodule.activity=='Activity'}">

                                                                                                                        <c:if test="${list6.assigned==false}"><span style="font-size:10px; color:#006600"><b><i>Add</i></b></span></c:if>
                                                                                                                        <c:if test="${list6.assigned==true}"><span style="font-size:10px; color:#D82222"><b><i>Discard</i></b></span> </c:if>
                                                                                                                        <input <c:if test="${list6.systemmodule.hasprivilege==false}">disabled="disabled"</c:if> <c:if test="${list6.selected==true}">checked="checked"</c:if> type="checkbox" <c:if test="${list6.assigned==true}">checked="checked"</c:if> name="manageObj${status.count}" id="manageObj${status.count}" value="${list6.systemmodule.privilegeid}" onChange="if (this.checked) {
                                                                                                                                    checkedoruncheckprivReleaseFacility('checked', this.value, ${list6.assigned});
                                                                                                                                } else {
                                                                                                                                    checkedoruncheckprivReleaseFacility('unchecked', this.value, ${list6.assigned});
                                                                                                                                }"/>
                                                                                                                    </c:if></span>
                                                                                                                    <c:if test="${list6.submodules>0}">
                                                                                                                    <ul>
                                                                                                                        <c:forEach items="${list6.customSystemmoduleList}"  var="list7" varStatus="status">
                                                                                                                            <li style="background-color: #F8EFFB; margin-top: 3px; margin-bottom: 3px; font-size: 14px"><span style="color: #006600; font-style: italic;"><c:if test="${list7.assigned==false}"><img src="static/images/disabledsmall.png" title="${list7.systemmodule.componentname} Not Assigned To ${model.groupname}!"/></c:if>
                                                                                                                                    <c:if test="${list7.assigned==true}"><img src="static/images/authorisedsmall.png" title="${list7.systemmodule.componentname} Assigned To ${model.groupname}"/></c:if>
                                                                                                                                    ${list7.systemmodule.componentname} <span style="font-size:10px"> [${list7.systemmodule.activity}]</span>
                                                                                                                                    <c:if test="${list7.systemmodule.hasprivilege==true && list7.systemmodule.activity=='Activity'}">

                                                                                                                                        <c:if test="${list7.assigned==false}"><span style="font-size:10px; color:#006600"><b><i>Add</i></b></span></c:if>
                                                                                                                                        <c:if test="${list7.assigned==true}"><span style="font-size:10px; color:#D82222"><b><i>Discard</i></b></span> </c:if>
                                                                                                                                        <input <c:if test="${list7.systemmodule.hasprivilege==false}">disabled="disabled"</c:if> <c:if test="${list7.selected==true}">checked="checked"</c:if> type="checkbox" <c:if test="${list7.assigned==true}">checked="checked"</c:if> name="manageObj${status.count}" id="manageObj${status.count}" value="${list7.systemmodule.privilegeid}" onChange="if (this.checked) {
                                                                                                                                                    checkedoruncheckprivReleaseFacility('checked', this.value, ${list7.assigned});
                                                                                                                                                } else {
                                                                                                                                                    checkedoruncheckprivReleaseFacility('unchecked', this.value, ${list7.assigned});
                                                                                                                                                }"/>
                                                                                                                                    </c:if></span>
                                                                                                                                    <c:if test="${list7.submodules>0}">
                                                                                                                                    <ul>
                                                                                                                                        <c:forEach items="${list7.customSystemmoduleList}"  var="list8" varStatus="status">
                                                                                                                                            <li style="background-color: #FFCCFF; margin-top: 3px; margin-bottom: 3px; font-size: 14px"><span style="color: #006600; font-style: italic;"><c:if test="${list8.assigned==false}"><img src="static/images/disabledsmall.png" title="${list8.systemmodule.componentname} Not Assigned To ${model.groupname}!"/></c:if>
                                                                                                                                                    <c:if test="${list8.assigned==true}"><img src="static/images/authorisedsmall.png" title="${list8.systemmodule.componentname} Assigned To ${model.groupname}"/></c:if>
                                                                                                                                                    ${list8.systemmodule.componentname} <span style="font-size:10px"> [${list8.systemmodule.activity}]</span>
                                                                                                                                                    <c:if test="${list8.systemmodule.hasprivilege==true && list8.systemmodule.activity=='Activity'}">

                                                                                                                                                        <c:if test="${list8.assigned==false}"><span style="font-size:10px; color:#006600"><b><i>Add</i></b></span></c:if>
                                                                                                                                                        <c:if test="${list8.assigned==true}"><span style="font-size:10px; color:#D82222"><b><i>Discard</i></b></span> </c:if>
                                                                                                                                                        <input <c:if test="${list8.systemmodule.hasprivilege==false}">disabled="disabled"</c:if> <c:if test="${list8.selected==true}">checked="checked"</c:if> type="checkbox" <c:if test="${list8.assigned==true}">checked="checked"</c:if> name="manageObj${status.count}" id="manageObj${status.count}" value="${list8.systemmodule.privilegeid}" onChange="if (this.checked) {
                                                                                                                                                                    document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) + 1;
                                                                                                                                                                    checkedoruncheckprivReleaseFacility('checked', this.value, ${list8.assigned});
                                                                                                                                                                } else {
                                                                                                                                                                    checkedoruncheckprivReleaseFacility('unchecked', this.value, ${list8.assigned});
                                                                                                                                                                }"/>
                                                                                                                                                    </c:if></span>
                                                                                                                                                    <c:if test="${list8.submodules>0}">
                                                                                                                                                    <ul>
                                                                                                                                                        <c:forEach items="${list8.customSystemmoduleList}"  var="list9" varStatus="status">
                                                                                                                                                            <li style="background-color: #ECE0F8; margin-top: 3px; margin-bottom: 3px; font-size: 14px"><span style="color: #006600; font-style: italic;">
                                                                                                                                                                    <c:if test="${list9.assigned==false}"><img src="static/images/disabledsmall.png" title="${list9.systemmodule.componentname} Not Assigned To ${model.groupname}!"/></c:if>
                                                                                                                                                                    <c:if test="${list9.assigned==true}"><img src="static/images/authorisedsmall.png" title="${list9.systemmodule.componentname} Assigned To ${model.groupname}"/></c:if>
                                                                                                                                                                    ${list9.systemmodule.componentname} <span style="font-size:10px"> [${list9.systemmodule.activity}]</span>
                                                                                                                                                                    <c:if test="${list9.systemmodule.hasprivilege==true && list9.systemmodule.activity=='Activity'}">

                                                                                                                                                                        <c:if test="${list9.assigned==false}"><span style="font-size:10px; color:#006600"><b><i>Add</i></b></span></c:if>
                                                                                                                                                                        <c:if test="${list9.assigned==true}"><span style="font-size:10px; color:#D82222"><b><i>Discard</i></b></span> </c:if>
                                                                                                                                                                        <input <c:if test="${list9.systemmodule.hasprivilege==false}">disabled="disabled"</c:if> <c:if test="${list9.selected==true}">checked="checked"</c:if> type="checkbox" <c:if test="${list9.assigned==true}">checked="checked"</c:if> name="manageObj${status.count}" id="manageObj${status.count}" value="${list9.systemmodule.privilegeid}" onChange="if (this.checked) {
                                                                                                                                                                                    checkedoruncheckprivReleaseFacility('checked', this.value, ${list9.assigned});
                                                                                                                                                                                } else {
                                                                                                                                                                                    checkedoruncheckprivReleaseFacility('unchecked', this.value, ${list9.assigned});
                                                                                                                                                                                }"/>
                                                                                                                                                                    </c:if></span>
                                                                                                                                                                    <c:if test="${list9.submodules>0}">
                                                                                                                                                                    <ul>
                                                                                                                                                                        <c:forEach items="${list9.customSystemmoduleList}"  var="list10" varStatus="status">
                                                                                                                                                                            <li style="background-color: #F8EFFB; margin-top: 3px; margin-bottom: 3px; font-size: 14px"><span style="color: #006600; font-style: italic;">
                                                                                                                                                                                    <c:if test="${list10.assigned==false}"><img src="static/images/disabledsmall.png" title="${list10.systemmodule.componentname} Not Assigned To ${model.groupname}!"/></c:if>
                                                                                                                                                                                    <c:if test="${list10.assigned==true}"><img src="static/images/authorisedsmall.png" title="${list10.systemmodule.componentname} Assigned To ${model.groupname}"/></c:if>
                                                                                                                                                                                    ${list10.systemmodule.componentname} <span style="font-size:10px"> [${list10.systemmodule.activity}]</span>
                                                                                                                                                                                    <c:if test="${list10.systemmodule.hasprivilege==true && list10.systemmodule.activity=='Activity'}">

                                                                                                                                                                                        <c:if test="${list10.assigned==false}"><span style="font-size:10px; color:#006600"><b><i>Add</i></b></span></c:if>
                                                                                                                                                                                        <c:if test="${list10.assigned==true}"><span style="font-size:10px; color:#D82222"><b><i>Discard</i></b></span> </c:if>
                                                                                                                                                                                        <input <c:if test="${list10.systemmodule.hasprivilege==false}">disabled="disabled"</c:if> <c:if test="${list10.selected==true}">checked="checked"</c:if> type="checkbox" <c:if test="${list10.assigned==true}">checked="checked"</c:if> name="manageObj${status.count}" id="manageObj${status.count}" value="${list10.systemmodule.privilegeid}" onChange="if (this.checked) {
                                                                                                                                                                                                    checkedoruncheckprivReleaseFacility('checked', this.value, ${list10.assigned});
                                                                                                                                                                                                } else {
                                                                                                                                                                                                    checkedoruncheckprivReleaseFacility('unchecked', this.value, ${list10.assigned});
                                                                                                                                                                                                }"/>
                                                                                                                                                                                    </c:if></span></li>
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
                                                                                                                                </c:if>
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
                                                                                </c:if>
                                                                            </li>
                                                                        </c:forEach>
                                                                    </ul>
                                                                </c:if>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </c:if>
                                            </li>
                                            <li style="display: none;">Item 2x</li>
                                            </c:forEach> 
                                    </ul>
                                </c:if>
                            </li>
                        </c:forEach>
                    </ul>
                </fieldset>
                <c:if test="${model.size>0}">
                    <br>
                    <table align="right" width="80%">
                        <tr>
                            <td colspan="2" align="right">
                                <input type="hidden" id="facilitygrprid" name="rid" value="${model.facilityid}"/>
                                <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
                                <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="addreleaserightsdiv" style="display: none;">
                                    <label class="formLabelTxt">Add:&nbsp;<Strong id="addreleaserightsdivitems"></Strong> &nbsp; Privileges </label> &nbsp;&nbsp;&nbsp;

                                </div>
                            </td>
                            <td>
                                <div id="removereleaserightsdiv" style="display: none;">
                                    <label class="formLabelTxt">Remove:&nbsp;<Strong id="removerightsdivitems"></Strong> &nbsp; Privileges </label> &nbsp;&nbsp;&nbsp;

                                </div>
                            </td>
                        </tr>
                    </table>
                </c:if>

            </div>
            <br/>
            <hr style="border: none; height: 1px; color: blue; background: blue;" />
            <br/>
            <table align="left" width="80%">
                <tr>
                    <td colspan="2" align="center">
                        <div id="savereleaseassignmentordesignment" style="display: none;">
                            <div class="row">
                                <button onclick="savereleasedassignmentordesignment();" class="btn btn-primary pull-right" id="savereleasedassignmentordesignmentbtn" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save</button>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
            <script type="text/javascript">
                //ddtreemenu.createTree(treeid, enablepersist, opt_persist_in_days (default is 1))
                ddtreemenu.createTree("treemenu1", true)
                ddtreemenu.createTree("treemenu2", false)

            </script>

        </div>
    </fieldset>
</form>
<script>
    var serverDate = '${serverdate}';
    var persisteduls = new Object()
    var ddtreemenu = new Object()

    ddtreemenu.closefolder = "static/images/tree/closed.png" //set image path to "closed" folder image
    ddtreemenu.openfolder = "static/images/tree/open.png" //set image path to "open" folder image

    //////////No need to edit beyond here///////////////////////////

    ddtreemenu.createTree = function (treeid, enablepersist, persistdays) {
        var ultags = document.getElementById(treeid).getElementsByTagName("ul")
        if (typeof persisteduls[treeid] == "undefined")
            persisteduls[treeid] = (enablepersist == true && ddtreemenu.getCookie(treeid) != "") ? ddtreemenu.getCookie(treeid).split(",") : ""
        for (var i = 0; i < ultags.length; i++)
            ddtreemenu.buildSubTree(treeid, ultags[i], i)
        if (enablepersist == true) { //if enable persist feature
            var durationdays = (typeof persistdays == "undefined") ? 1 : parseInt(persistdays)
            ddtreemenu.dotask(window, function () {
                ddtreemenu.rememberstate(treeid, durationdays)
            }, "unload") //save opened UL indexes on body unload
        }
    }

    ddtreemenu.buildSubTree = function (treeid, ulelement, index) {
        ulelement.parentNode.className = "submenu"
        if (typeof persisteduls[treeid] == "object") { //if cookie exists (persisteduls[treeid] is an array versus "" string)
            if (ddtreemenu.searcharray(persisteduls[treeid], index)) {
                ulelement.setAttribute("rel", "open")
                ulelement.style.display = "block"
                ulelement.parentNode.style.backgroundImage = "url(" + ddtreemenu.openfolder + ")"
            } else
                ulelement.setAttribute("rel", "closed")
        } //end cookie persist code
        else if (ulelement.getAttribute("rel") == null || ulelement.getAttribute("rel") == false) //if no cookie and UL has NO rel attribute explicted added by user
            ulelement.setAttribute("rel", "closed")
        else if (ulelement.getAttribute("rel") == "open") //else if no cookie and this UL has an explicit rel value of "open"
            ddtreemenu.expandSubTree(treeid, ulelement) //expand this UL plus all parent ULs (so the most inner UL is revealed!)
        ulelement.parentNode.onclick = function (e) {
            var submenu = this.getElementsByTagName("ul")[0]
            if (submenu.getAttribute("rel") == "closed") {
                submenu.style.display = "block"
                submenu.setAttribute("rel", "open")
                ulelement.parentNode.style.backgroundImage = "url(" + ddtreemenu.openfolder + ")"
            } else if (submenu.getAttribute("rel") == "open") {
                submenu.style.display = "none"
                submenu.setAttribute("rel", "closed")
                ulelement.parentNode.style.backgroundImage = "url(" + ddtreemenu.closefolder + ")"
            }
            ddtreemenu.preventpropagate(e)
        }
        ulelement.onclick = function (e) {
            ddtreemenu.preventpropagate(e)
        }
    }

    ddtreemenu.expandSubTree = function (treeid, ulelement) { //expand a UL element and any of its parent ULs
        var rootnode = document.getElementById(treeid)
        var currentnode = ulelement
        currentnode.style.display = "block"
        currentnode.parentNode.style.backgroundImage = "url(" + ddtreemenu.openfolder + ")"
        while (currentnode != rootnode) {
            if (currentnode.tagName == "UL") { //if parent node is a UL, expand it too
                currentnode.style.display = "block"
                currentnode.setAttribute("rel", "open") //indicate it's open
                currentnode.parentNode.style.backgroundImage = "url(" + ddtreemenu.openfolder + ")"
            }
            currentnode = currentnode.parentNode
        }
    }

    ddtreemenu.flatten = function (treeid, action) { //expand or contract all UL elements
        var ultags = document.getElementById(treeid).getElementsByTagName("ul")
        for (var i = 0; i < ultags.length; i++) {
            ultags[i].style.display = (action == "expand") ? "block" : "none"
            var relvalue = (action == "expand") ? "open" : "closed"
            ultags[i].setAttribute("rel", relvalue)
            ultags[i].parentNode.style.backgroundImage = (action == "expand") ? "url(" + ddtreemenu.openfolder + ")" : "url(" + ddtreemenu.closefolder + ")"
        }
    }

    ddtreemenu.rememberstate = function (treeid, durationdays) { //store index of opened ULs relative to other ULs in Tree into cookie
        var ultags = document.getElementById(treeid).getElementsByTagName("ul")
        var openuls = new Array()
        for (var i = 0; i < ultags.length; i++) {
            if (ultags[i].getAttribute("rel") == "open")
                openuls[openuls.length] = i //save the index of the opened UL (relative to the entire list of ULs) as an array element
        }
        if (openuls.length == 0) //if there are no opened ULs to save/persist
            openuls[0] = "none open" //set array value to string to simply indicate all ULs should persist with state being closed
        ddtreemenu.setCookie(treeid, openuls.join(","), durationdays) //populate cookie with value treeid=1,2,3 etc (where 1,2... are the indexes of the opened ULs)
    }

    ////A few utility functions below//////////////////////

    ddtreemenu.getCookie = function (Name) { //get cookie value
        var re = new RegExp(Name + "=[^;]+", "i"); //construct RE to search for target name/value pair
        if (document.cookie.match(re)) //if cookie found
            return document.cookie.match(re)[0].split("=")[1] //return its value
        return ""
    }

    ddtreemenu.setCookie = function (name, value, days) { //set cookei value
        var expireDate = new Date(serverDate)
        //set "expstring" to either future or past date, to set or delete cookie, respectively
        var expstring = expireDate.setDate(expireDate.getDate() + parseInt(days))
        document.cookie = name + "=" + value + "; expires=" + expireDate.toGMTString() + "; path=/";
    }

    ddtreemenu.searcharray = function (thearray, value) { //searches an array for the entered value. If found, delete value from array
        var isfound = false
        for (var i = 0; i < thearray.length; i++) {
            if (thearray[i] == value) {
                isfound = true
                thearray.shift() //delete this element from array for efficiency sake
                break
            }
        }
        return isfound
    }

    ddtreemenu.preventpropagate = function (e) { //prevent action from bubbling upwards
        if (typeof e != "undefined")
            e.stopPropagation()
        else
            event.cancelBubble = true
    }

    ddtreemenu.dotask = function (target, functionref, tasktype) { //assign a function to execute to an event handler (ie: onunload)
        var tasktype = (window.addEventListener) ? tasktype : "on" + tasktype
        if (target.addEventListener)
            target.addEventListener(tasktype, functionref, false)
        else if (target.attachEvent)
            target.attachEvent(tasktype, functionref)
    }

    ddtreemenu.flatten('treemenu1', 'contact');
</script>
<script>
    var releasePriv = new Set();
    function checkedoruncheckprivReleaseFacility(type, privilegeid, status) {
        if (type === 'checked') {
            releasePriv.add(privilegeid);
        } else {
            releasePriv.delete(privilegeid);
        }
        if (releasePriv.size > 0) {
            document.getElementById('addreleaserightsdiv').style.display = 'block';
            document.getElementById('addreleaserightsdivitems').innerHTML = releasePriv.size;
            document.getElementById('savereleaseassignmentordesignment').style.display = 'block';
        } else {
            document.getElementById('addreleaserightsdiv').style.display = 'none';
            document.getElementById('savereleaseassignmentordesignment').style.display = 'none';
        }
    }
    function savereleasedassignmentordesignment() {
        var facility = $('#facilitygrprid').val();
        var systemmodulesid = $('#releasefacilitycomponentid').val();
        document.getElementById('savereleasedassignmentordesignmentbtn').disabled=true;
        $.ajax({
            type: 'POST',
            data: {facility: facility, privilegs: JSON.stringify(Array.from(releasePriv))},
            url: "activitiesandaccessrights/savereleasedfacilityprivileges.htm",
            success: function (data, textStatus, jqXHR) {
                document.getElementById('savereleasedassignmentordesignmentbtn').disabled=false;
               $('#defaltCompntselected'+systemmodulesid).remove();
               document.getElementById('releasecomponentsforfacilitytree').innerHTML='';
               $("#releasefacilitycomponentid option[id='defaltselectedrelasefacilitycomponentsid']").attr("selected", "selected");
            }
        });
    }
</script>