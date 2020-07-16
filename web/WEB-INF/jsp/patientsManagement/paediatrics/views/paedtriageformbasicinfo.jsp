<%-- 
    Document   : paedtriageformbasicinfo
    Created on : Oct 19, 2018, 8:44:55 AM
    Author     : user
--%>

<%@include file="../../../include.jsp" %>
<div class="card">
    <header class="card-header">
        <a href="#" data-toggle="collapse" data-target="#collapse11" aria-expanded="true" class="">
            <i class="icon-action fa fa-chevron-down"></i>
            <c:if test="${years == 0}">
                <span class="title badge badge-patientinfo patientConfirmFont"><span>Name:${name}</span>&nbsp;&nbsp;&nbsp;<span>Age:${months}&nbsp;Month(s)</span></span>
            </c:if>
            <c:if test="${years > 0}">
                <c:if test="${months == 0}">
                    <span class="title badge badge-patientinfo patientConfirmFont"><span>Name:${name}</span>&nbsp;&nbsp;&nbsp;<span>Age:${years}&nbsp;year(s)</span></span>
                </c:if>
                <c:if test="${months != 0}">
                    <span class="title badge badge-patientinfo patientConfirmFont"><span>Name:${name}</span>&nbsp;&nbsp;&nbsp;<span>Age:${years}&nbsp;year(s),${months}&nbsp;Month(s)</span></span>
                </c:if>

            </c:if>

        </a>
    </header>
    <input type="hidden" value="${total_months}" id="totalmonths">
    <input type="hidden" value="${years}" id="years">
    <div class="collapse show" id="collapse11" style="">
        <article class="card-body">
            <fieldset>
                <table class="col-md-12">
                    <tbody>
                        <tr class="row">
                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">Patient No:</label>
                                    <input class="form-control form-control-sm" value="${patientno}" type="text" disabled="">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">Visit No:</label>
                                    <input class="form-control form-control-sm col-md-12" type="text" id="newpatientvisitnumber" value="${visitnumber}" disabled="">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm">Gender:</label>
                                    <input class="form-control form-control-sm" id="gender" value="${gender}" name="" disabled="">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">Next Of Kin Tel:</label>
                                    <input class="form-control form-control-sm" value="${nextofkincontact}" type="text" name="" disabled="">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">Current Address:</label>
                                    <input class="form-control form-control-sm" value="${village}" type="text" disabled="">
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </fieldset>
        </article>
    </div>
</div>
<script>
    $(document).ready(function () {
        var gender = $('#gender').val();
        var totalmonths = $('#totalmonths').val();
        var years = $('#years').val();
        document.getElementById('monthsintotal').value = totalmonths;
        if (years <= 5) {
            if (gender === 'Male') {
                $('#zscoresForBoys').show();
            }
            if (gender === 'Female') {
                $('#zscoresForGirls').show();
            }
        } else {
            if (gender === 'Male') {
                $('#BMIboys').show();
            }
            if (gender === 'Female') {
                $('#BMIgirls').show();
            }
        }


    });
</script>