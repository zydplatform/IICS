<%-- 
    Document   : viewspokenlanguages
    Created on : Sep 27, 2019, 3:58:07 PM
    Author     : EARTHQUAKER
--%>
<%@include file="../../../../include.jsp" %>
<div class="row user">
    <div class="col-md-12">
        <div class="">
            <div class="tab-pane active" id="classifications">
                <div class="tile user-settings">
                    <div class="tile-body">
                        <p>

                            <a class="btn btn-primary icon-btn" id="addnewlanguage" href="#">
                                <i class="fa fa-plus"></i>
                                Add language
                            </a>
                        </p>

                        <fieldset>
                            <div id="forexPane">
                                <table class="table table-hover table-bordered col-md-12" id="languagetable">
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>Language Name</th>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN')">
                                                <th class="center">Update</th>
                                                </security:authorize> 
                                                <security:authorize access="hasRole('ROLE_ROOTADMIN')">
                                                <th class="center">Remove</th>
                                                </security:authorize>                                           
                                        </tr>
                                    </thead>
                                    <tbody class="col-md-12" id="languagetable">
                                        <% int c = 1;%>
                                        <% int uc = 1;%>
                                        <% int rc = 1;%>
                                        <c:forEach items="${languagelist}" var="l">
                                            <tr id="${l.languageid}">
                                                <td><%=c++%></td>
                                                <td>${l.languagename}</td>
                                                  <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_REMOVECURRENCY')">
                                                    <td class="center"><a href="#" onclick="updatelanguage(${l.languageid});" id="" class="btn btn-xs btn-teal tooltips" style="background-color: purple; color: white"><i class="fa fa-edit"></i></a></td>
                                                 </security:authorize> 
                                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_REMOVECURRENCY')">
                                                    <td class="center"><a href="#" onclick="removeLanguages(${l.languageid});" id="" class="btn btn-xs btn-teal tooltips" style="background-color: purple; color: white"><i class="fa fa-remove"></i></a></td>
                                                 </security:authorize>                                                
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="modal fade" id="addlanguage">
        <div class="modal-dialog">
            <div class="modal-content" style="width: 100%;">
                <div class="modal-header">
                    <h3 class="tile-title">ADD NEW LANGUAGE &nbsp;</h3>
                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile" id="addlanguages">
                                <%@include file="../forms/addnewlanguage.jsp" %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="modal fade" id="updatelanguage">
        <div class="modal-dialog">
            <div class="modal-content" style="width: 100%;">
                <div class="modal-header">
                    <h3 class="tile-title">UPDATE EXISTING LANGUAGE &nbsp;</h3>
                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile" id="update">
                                <%@include file="../forms/updatelanguage.jsp"%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    $('#languagetable').DataTable();
    

    $('#addnewlanguage').click(function () {
        $('#addlanguage').modal('show');
    });

  var namex ="";

    function removeLanguages(id) {
        $.confirm({
            title: 'Message!',
            content: 'Delete Language?',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        var tablerowid = $('#' + id).closest('tr').attr('id');
                        $.ajax({
                            type: 'POST',
                            data: {languageid: tablerowid},
                            url: "spokenlanguages/deletespokenlanguage",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    $.alert({
                                        title: 'Alert!',
                                        content: 'Language Successfully Removed',
                                    });
                                    $('#' + tablerowid).remove();

                                    ajaxSubmitData('spokenlanguages/managespokenlanguages.htm', 'workpane', '', 'GET');
                                }
                            }

                        });
                    }
                },
                No: function () {
                    ajaxSubmitData('spokenlanguages/managespokenlanguages.htm', 'workpane', '', 'GET');
                }
            }
        });
    }
    
    function updatelanguage(id){
        $('#languageid').val(id);
          var tableData = $('#'+ id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
                namex = tableData[1];
                $('#languagenamex').val(namex);
         $('#updatelanguage').modal('show');
    }

</script>

