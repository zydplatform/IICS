<%-- 
    Document   : unservicedOrdersItems
    Created on : Jul 17, 2019, 11:08:48 AM
    Author     : IICS TECHS
--%>

<%@include file="../../../../include.jsp" %>

<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-title">
                <div style="font-size: 0.59em; display: inline-block; margin-right: 1%;"><span> Order: </span><a href="#" style="color: #0000ff;" id="order"></a></div>
                <div style="font-size: 0.59em; display: inline-block; margin-right: 1%;"><span> Recorded By: </span><a href="#" style="color: #0000ff;" id="recorded-by"></a></div>                
                <div style="font-size: 0.59em; display: inline-block"><span>  Date Recorded: </span><a href="#" style="color: #0000ff;" id="date-recorded"></a></div>
            </div>
            <div class="tile-body">
                <table id="unserviced-order-items-table" class="table table-bordered">
                    <thead>
                        <th></th>
                        <th>Item Name</th>
                    </thead>
                    <tbody>
                        <c:forEach items="${orderitems}" var="item">
                            <tr>
                                <td></td>
                                <td>${item.itemname}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot></tfoot>
                </table>
            </div>
            <div class="tile-footer"></div>
        </div>        
    </div>
</div>