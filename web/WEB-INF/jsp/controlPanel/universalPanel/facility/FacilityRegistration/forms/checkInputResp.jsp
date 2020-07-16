<%-- 
    Document   : checkInputResp
    Created on : May 14, 2018, 4:12:55 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>


<c:if test="${model.act=='a'}">
    <script>
        if(${model.codeResp}===false){
            showWarningSuccess('Code Verification', 'Code: ${model.b} Is Already In Use!', 'warning', 'codeChkResp');
        }else{
            //showWarningSuccess('Code Verification', 'Code: ${model.b} Is Available For This Entry!', 'success', 'codeChkResp');
        }
        $('#codeChk').val(${model.codeResp});
    </script>
</c:if>
<c:if test="${model.act=='b'}">
    <script>
        if(${model.nameResp}===false){
            showWarningSuccess('Facility Name Verification', 'Name: ${model.b} Is Already In Use!', 'warning', 'nameChkResp');
        }else{
            //showWarningSuccess('Facility Name Verification', 'Name: ${model.b} Is Available For This Entry!', 'success', 'nameChkResp');
        }
        $('#nameChk').val(${model.nameResp});
    </script>
</c:if>    