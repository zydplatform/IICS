<%-- 
    Document   : formAddLevels
    Created on : Dec 5, 2017, 2:45:35 PM
    Author     : samuelwam
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


                <div>
                    <c:if test="${model.activity=='add' && model.resp==true && model.levels>0}">
                        <form name="submitData" id="submitData" class="form-horizontal">
                            <div class="row">
                                <div class="panel-body">
                                    <c:set var="count" value="0" />
                                    <c:forEach varStatus="status" begin="1" end="${model.levels}">
                                        <c:set var="count" value="${count+1}" />
                                        <div class="form-group">
                                            <div class="col-sm-1">${count}</div>
                                            <div class="col-sm-3">
                                                <input type="text"  placeholder="Type ${count} Name" class="form-control" id="levelname${count}" name="levelname${count}">
                                            </div>
                                            <div class="col-sm-3">
                                                <input type="text"  placeholder="Short ${count} Name" class="form-control" id="shortname${count}" name="shortname${count}">
                                            </div>
                                            <div class="col-sm-5">
                                                <textarea name="description${count}" id="description${count}" cols="2" class='form-control'  placeholder="Enter Description!"></textarea>
                                            </div>
                                        </div>                                                
                                    </c:forEach>   
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-actions" align="center">
                                        <input type="hidden" name="cref" id="cref" value="${model.catObj.categoryid}"/>
                                        <input type="hidden" name="itemSize" id="levels" value="${model.levels}"/>
                                        <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                        <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                        <div align="left" style="alignment-adjust: central;">
                                            <div id="btnSaveHide">
                                                <input type="button" id="saveButton" name="button" class="btn btn-purple" value='<c:if test="${empty model.catObjArr}">Save</c:if><c:if test="${not empty model.catObjArr}">Update</c:if> Type/Level' onClick="var resp = validateB4Submit();
                                                        if (resp === false) {
                                                            return false;
                                                        }
                                                        ajaxSubmitForm('regCategoryLevels.htm', 'levelResponsePane', 'submitData');"/> 
                                                    &nbsp;&nbsp;
                                                    <input name="" type="reset" value="Reset" class="btn">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>


                            <!-- /.modal-content -->



                            <script>
                                function validateB4Submit() {
                                    //To be implemented
                                    return true;
                                }
                            </script>
                    </c:if>
                    <c:if test="${model.activity=='update'}">
                        <c:if test="${model.mainActivity=='Facility Level Category'}">
                            <c:if test="${not empty model.catList}">   
                                <table class="table table-bordered table-hover" id="sample-table-1">
                                    <thead>
                                        <tr>
                                            <th class="center"></th>
                                            <th>Name</th>
                                            <th>Description</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${model.catList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                            <tr>
                                                <td align="left">&nbsp;</td>
                                                <td align="left">${list.categoryname}</td>
                                                <td align="left">${list.description}</td>                                            
                                                <td align="center"><c:if test="${list.active==true}">Active</c:if><c:if test="${list.active==false}">Disabled</c:if></td>
                                                </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                        </c:if>
                    </c:if>
                </div>
            