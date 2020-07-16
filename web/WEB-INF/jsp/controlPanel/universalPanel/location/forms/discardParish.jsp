<%-- 
    Document   : discardParish
    Created on : Jun 26, 2018, 5:06:11 PM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp"%>

<div class="modal fade col-md-12" id="discardPane" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 170%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Manage Parish</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  onClick="ajaxSubmitData('locations/manageParish.htm','regionContent','act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET'); clearDiv('response-pane');">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container" id="transfer-pane">
                    <fieldset><legend>Discard Parish: <span color="red">${model.checkObj[1]}</span></legend>
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile-body">
                                        <h3>${model.successmessage}</h3>
                                        <c:set var="i" value="0"></c:set>
                                        <c:forEach items="${model.customList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                            <tr id="${model.parish.parishid}">
                                                <td>
                                                    ${status.count}
                                                    <c:set var="i" value="${status.count}"/>
                                                </td>
                                                <td>${model.parish.parishid} </td>
                                                <td align="center">
                                                    <c:if test="${list.deleted==true}"><span class="text5">Deleted</span></c:if>
                                                    <c:if test="${list.deleted==false}"><span class="text4">Failed</span></c:if>
                                                    </td>

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
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#discardPane').modal('show');
    });
    $('.modal-backdrop').remove();
</script>