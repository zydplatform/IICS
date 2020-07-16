<%-- 
    Document   : viewOrManageOrder
    Created on : May 17, 2018, 11:03:32 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<br>
<div id="createdordersdiv">
    <fieldset style="width: 90%">
        <legend>Created Orders</legend>
        <div style="width: auto; height: 100%;">     
            <table style="margin: 10px 10px 10px 107px; border: solid 1px #CCCCCC; border-width: 0px 0px 1px 0px;" width="75%" cellspacing="0" border="0" align="center">                                                
                <tbody><tr>
                        <td colspan="2" rowspan="2">
                            <label> ${facilityunitname} has (${totalinternalorders}) Internal order(s).</label>
                        </td>
                        <td width="43%">
                            <label>
                                (${internalordersincomplete}) Incomplete order(s)
                                <c:if test="${internalordersincomplete !=0}">
                                    (<a href="#" onclick="internalordersview('incomplete');">
                                        <span class="">VIEW</span></a>)
                                    </c:if>
                            </label>
                        </td>
                    </tr>                                                
                    <tr>
                        <td>
                            <label>
                                (${internalorderscomplete}) Complete order(s)
                                <c:if test="${internalorderscomplete !=0}">
                                    (<a href="#" onclick="internalordersview('complete');">
                                        <span class="">VIEW</span></a>)
                                    </c:if>
                            </label>
                        </td>
                    </tr>
                </tbody></table>


            <table style="margin: 10px 10px 10px 107px; border: solid 1px #CCCCCC; border-width: 0px 0px 0px 0px;" width="75%" cellspacing="0" border="0" align="center">                                                                                                
                <tbody><tr>
                        <td colspan="2" rowspan="2">                                    
                            <label>${facilityunitname} has (${totalexternalorders}) External order(s).  </label>
                        </td>
                        <td width="43%">
                            <label>
                                (${externalordersincomplete}) Incomplete order(s) 
                                <c:if test="${externalordersincomplete !=0}">
                                    (<a href="#" onclick="externalOrdersViews('incomplete');">
                                        <span class="">VIEW</span></a>)
                                    </c:if>
                            </label>
                            </a></td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                (${externalorderscomplete}) Complete order(s)
                                <c:if test="${externalorderscomplete !=0}">
                                    (<a href="#" onclick="externalOrdersViews('complete');">
                                        <span class="">VIEW</span></a>)
                                    </c:if>

                            </label>
                        </td>
                    </tr>                                                
                </tbody></table>

        </div>  
    </fieldset>
</div>
<script>
    function internalordersview(type) {
        if (type === 'incomplete') {
            ajaxSubmitData('ordersmanagement/internalordersview.htm', 'createdordersdiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        } else {
            ajaxSubmitData('ordersmanagement/internalordersview.htm', 'createdordersdiv', 'act=b&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    }
    function externalOrdersViews(type) {
        if (type === 'incomplete') {
            ajaxSubmitData('extordersmanagement/externalordersview.htm', 'createdordersdiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        } else {
            ajaxSubmitData('extordersmanagement/externalordersview.htm', 'createdordersdiv', 'act=b&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }

    }
</script>