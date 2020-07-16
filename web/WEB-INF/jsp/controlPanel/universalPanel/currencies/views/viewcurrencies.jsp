<%-- 
    Document   : viewcurrencies
    Created on : Apr 13, 2018, 8:08:20 AM
    Author     : SAMINUNU
--%>
<%@include file="../../../../include.jsp" %>
<div class="row user">
    <div class="col-md-12">
        <div class="">
            <div class="tab-pane active" id="classifications">
                <div class="tile user-settings">
                    <div class="tile-body">
                        <p>
<!--                            <a class="btn btn-primary icon-btn" id="addnewcurrencys" href="#" onclick="document.getElementById('addnewcurrencys').style.visibility = 'hidden'; document.getElementById('viewupdatedcurrencys').style.visibility = 'visible';">
                                <i class="fa fa-plus"></i>
                                Import Forex
                            </a>-->
                            <a class="btn btn-primary icon-btn" id="addnewcurrency" href="#">
                                <i class="fa fa-plus"></i>
                                Add Currency
                            </a>
                            <a class="btn btn-primary icon-btn" id="viewupdatedcurrencys" href="#" onclick="document.getElementById('addnewcurrencys').style.visibility = 'hidden'; ajaxSubmitData('currencysystemsettings/currencypane.htm', 'workpane', '', 'GET');">
                                View Currencies List
                            </a>
                        </p>

                        <fieldset>
                            <div id="forexPane">
                                <table class="table table-hover table-bordered col-md-12" id="currencytable">
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>Country Name</th>
                                            <th>Currency Name</th>
                                            <th>Currency Rates</th>
                                            <th>More Details</th>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_REMOVECURRENCY')">
                                                <th class="center">Remove</th>
                                            </security:authorize>                                           
                                        </tr>
                                    </thead>
                                    <tbody class="col-md-12" id="countrycureencytable">
                                        <% int c = 1;%>
                                        <% int uc = 1;%>
                                        <% int rc = 1;%>
                                        <c:forEach items="${model.currenciesList}" var="cc">
                                            <tr id="${cc.currencyid}">
                                                <td><%=c++%></td>
                                                <td>${cc.country}</td>
                                                <td>${cc.currencyname}</td>
                                                <td>${cc.currencyrate}</td>
                                                <td class="center">
                                                    <a data-toggle="popover" data-abbreviation="${cc.abbreviation}" data-dateupdated="${cc.dateupdated}" data-trigger="hover" data-popover-position="top" data-container="body" data-currencyid="${cc.currencyid}" data-placement="top" data-html="true" href="#"><span class="glyphicon glyphicon-list"><i class="fa fa-fw fa-lg fa-dedent"></i></span></a>
                                                </td>
                                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_REMOVECURRENCY')">
                                                    <td class="center"><a href="#" onclick="removeCurrencies(this.id);" id="up5<%=rc++%>" class="btn btn-xs btn-teal tooltips" style="background-color: purple; color: white"><i class="fa fa-remove"></i></a></td>
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
    <div class="modal fade" id="addcurrency">
        <div class="modal-dialog">
            <div class="modal-content" style="width: 100%;">
                <div class="modal-header">
                    <h3 class="tile-title">ADD NEW CURRENCY &nbsp;</h3>
                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile" id="addcurrencies">
                                <%@include file="../forms/addcurrency.jsp" %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="viewdetails" class="hide">
    <div class="row">
        <form>
            <div id="horizontalwithwords">
                <span class="pat-form-heading">Currency Details</span>
            </div>
            <div class="form-group bs-component">
                <label>Currency Abbreviation</label>
                <span class="control-label pat-form-heading patientConfirmFont" id="abbrv"></span>
            </div>
            <div class="form-group bs-component">
                <label>Date Updated</label>
                <span class="control-label pat-form-heading patientConfirmFont" id="updatedate"></span>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    $('#currencytable').DataTable();
    document.getElementById('viewupdatedcurrencys').style.visibility = 'hidden';

    $('#addnewcurrency').click(function () {
        $('#addcurrency').modal('show');
    });

    $("[data-toggle=popover]").each(function (i, obj) {
        $(this).popover({
            html: true,
            content: function () {
                var id = $(this).attr('id');
                console.log(id);
                var abbreviation = $(this).attr('data-abbreviation');
                var dateupdated = $(this).attr('data-dateupdated');


                $('#abbrv').html(abbreviation);
                $('#updatedate').html(dateupdated);
                var popup = $('#viewdetails').html();
                return popup;

            }
        });
    });

    var currencyratesset = new Set();
    function checkedoruncheckedcurrentrates(value, type) {
        console.log("currencyratesset"+currencyratesset);
        if (currencyratesset !== 0) {
            if (type === 'checked') {
                currencyratesset.add(value);

                showDiv('selectObjBtn');

                hideDiv('selectoption');
            } else {

                if (currencyratesset.has(value)) {
                    currencyratesset.delete(value);
                }
            }

        } else {
            hideDiv('selectObjBtn');
        }

    }
    var updatedcurrencies = [];

    function updatecurrencies() {
        var table = document.getElementById("tableFacilities");
        var x = document.getElementById("tableFacilities").rows.length;
        for (var i = 0; i < x; i++) {
            var row = table.rows[i];
            var ids = row.id;
            var tableData = $('#' + ids).closest('tr')
                    .find('td')
                    .map(function () {
                        return $(this).text();
                    }).get();
            if (currencyratesset.has(ids)) {
                updatedcurrencies.push({
                    currencyid: ids,
                    currencyrate: tableData[4]
                });
            }

        }

        if (updatedcurrencies.length !== 0) {
            $.ajax({
                type: 'GET',
                data: {currencyvalues: JSON.stringify(updatedcurrencies)},
                url: "currencysystemsettings/updatecurrencyrates.htm",
                success: function (data, textStatus, jqXHR) {

                    $.alert({
                        title: 'Alert!',
                        content: 'Currency Rates Successfully Updated',
                    });

                    ajaxSubmitData('currencysystemsettings/currencypane.htm', 'workpane', '', 'GET');
                }
            });
        } else {

        }
    }

    function removeCurrencies(id) {
        $.confirm({
            title: 'Message!',
            content: 'Delete Currency?',
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
                            data: {currencyid: tablerowid},
                            url: "currencysystemsettings/removecurrency",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    $.alert({
                                        title: 'Alert!',
                                        content: 'Currency Successfully Removed',
                                    });
                                    $('#' + tablerowid).remove();

                                    ajaxSubmitData('currencysystemsettings/currencypane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }

                        });
                    }
                },
                No: function () {
                    ajaxSubmitData('currencysystemsettings/currencypane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            }
        });
    }

</script>
