<%-- 
    Document   : transferredorderitems
    Created on : Aug 14, 2018, 4:55:15 PM
    Author     : SAMINUNU
--%>
<%@include file="../../../../../../../include.jsp" %>
<div class="col-md-12">
    <div class="tile-body">
        <fieldset>
            <div class="tile">
                <table class="table table-hover table-striped" id="externalOrdersTable">
                    <thead>
                        <tr>
                            <th class="center">#</th>
                            <th>Facility Order Number</th>
                            <th>No. Of Items</th>
                            <th class="">Consolidator</th>
                            <th class="center">Date Consolidated</th>
                            <th class="center">Submit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="center">1</td>
                            <td class="">MULAGO/001</td>
                            <td><a><font color="blue"><strong>20</strong></font></a></td>
                            <td class="">SAMIRA ZEIN</td>
                            <td class="center">20-08-2018</td>
                            <td align="center">
                                <div class="toggle-flip">
                                    <label>
                                        <input checked="checked" value="" id="" type="checkbox" onchange="if (this.checked) {
                                    } else {
                                    }"><span class="flip-indecator"  style="height: 10px !important;width:  32px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                                    </label>
                                </div>

                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>
    </div>
</div>