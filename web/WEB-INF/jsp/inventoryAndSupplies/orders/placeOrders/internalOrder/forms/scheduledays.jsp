<%-- 
    Document   : scheduledays
    Created on : May 22, 2018, 12:51:31 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% int y = 1;%>
<c:forEach items="${daysFound}" var="a">
    <div class="form-check">
        <label class="form-check-label">
            <input type="checkbox" class="form-check-input" id="supsch<%=y++%>" onchange="if (this.checked) {
                        setselecteddayofsup(this.value, 'checked', this.id);
                    } else {
                        setselecteddayofsup(this.value, 'unchecked', this.id);
                    }" value="${a.date}">${a.day}(${a.date})
        </label>
    </div>  
</c:forEach>


<script>
    function getselectedday() {
        if (selecteddayofsupply.size > 0) {
            selecteddayofsupply.forEach(function (item) {
               document.getElementById('dateneeded').value = item; 
            });
            selecteddayofsupply.clear();
            document.getElementById('yourscheduleddatediv').style.display='none';
        } else {
            $.confirm({
                title: 'Choose!',
                icon: 'fa fa-warning',
                content: 'Choose The Date !!',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Choose',
                        btnClass: 'btn-red',
                        action: function () {

                        }
                    }
                }
            });
        }
    }
    function setselecteddayofsup(value, type, id) {
        if (type === 'checked' && selecteddayofsupply.size === 0) {
            selecteddayofsupply.add(value);
        } else if (type === 'unchecked' && selecteddayofsupply.size > 0) {
            selecteddayofsupply.delete(value);
        } else if (type === 'checked' && selecteddayofsupply.size > 0) {
            $('#' + id).prop('checked', false);
        } else {
            $('#' + id).prop('checked', false);
        }
    }
</script>