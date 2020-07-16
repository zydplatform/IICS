<%-- 
    Document   : viewdonordetails
    Created on : Sep 1, 2018, 11:31:23 PM
    Author     : SAMINUNU
--%>
<%@include file="../../../../include.jsp" %>
<style>
    .cl{color: #465cba;}
</style>
<div>
    <div class="container" id="firstexternaldiv">
        <div class="row center">
            <table border="0" align="center">
                <tbody>
                    <tr>
                        <td align="left"><span class="style101">Donor Program Start Date:</span>&nbsp;&nbsp;&nbsp;<b class="cl">${startdate}</b></td>
                    </tr>
                    <tr>
                        <td align="left"><span class="style101">Donor Program End Date:</span>&nbsp;&nbsp;&nbsp;<b class="cl">${enddate}</b></td>
                    </tr>
                    <tr>
                        <td align="left"><span class="style101">Email Address:</span>&nbsp;&nbsp;&nbsp;<b class="cl">${email}</b></td>
                    </tr>
                    <tr>
                        <td align="left"><span class="style101">Tel No.:</span>&nbsp;&nbsp;&nbsp;<b class="cl">${telno}</b></td>
                    </tr>
                    <tr>
                        <td align="left"><span class="style101">Fax:</span>&nbsp;&nbsp;&nbsp;<b class="cl">${fax}</b></td>
                    </tr>
                </tbody>
            </table>

        </div>
    </div>
</div>
