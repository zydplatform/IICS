<%-- 
    Document   : supplierItems
    Created on : Apr 5, 2018, 8:11:39 PM
    Author     : IICS
--%>

<%-- 
    Document   : itemsTable
    Created on : Mar 24, 2018, 8:19:32 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<fieldset>
    <table class="table table-hover table-bordered" id="itemsTable">
        <thead>
            <tr>
                <th>No</th>
                <th>Item</th>
                <th class="center">Restricted</th>
                <th class="right">Code</th>
                <th class="right">Pack Size</th>
                <th class="right">Unit Cost</th>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EDITSUPPLIERCATALOGUEITEM')">
                     <th class="center">Edit</th>
                </security:authorize>               
            </tr>
        </thead>
        <tbody id="bodyItems">
            <% int l = 1;%>
            <c:forEach items="${items}" var="item">
                <tr>
                    <td><%=l++%></td>
                    <td>${item.name}</td>
                    <td class="center">
                        <c:if test="${item.res == true}">
                            Yes
                        </c:if>
                        <c:if test="${item.res == false}">
                            No
                        </c:if>
                    </td>
                    <td class="right">${item.code}</td>
                    <td class="right">${item.pack}</td>
                    <td class="right">${item.cost}</td>
                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EDITSUPPLIERCATALOGUEITEM')">
                        <td class="center">
                            <a href="#!" onclick="editItem(${item.id}, '${item.name}', '${item.code}', '${item.pack}', '${item.cost}'.replace(',', ''), ${item.res})">
                                <i class="fa fa-fw fa-lg fa-edit"></i>
                            </a>
                        </td>
                    </security:authorize>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</fieldset>
<script>
    $(document).ready(function () {
        $('#itemsTable').DataTable();
    });
    function filterItemList(supplierid) {
        $.confirm({
            title: 'Filter Catalog Item!',
            content: '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label for="itemClassificationSelect">Select Classification</label>' +
                    '<select class="form-control" id="itemClassificationSelect">' +
                    '<option value="0">All Classifications</option>' +
                    '<c:forEach items="${classifications}" var="classification">' +
                    '<option id="class${classification.id}" data-name="${classification.name}" value="${classification.id}">${classification.name}</option>' +
                    '</c:forEach></select></div>' +
                    '<div class="form-group" id="catGroup">' +
                    '<label for="filtercategory">Select Category</label>' +
                    '<select class="form-control" id="filtercategory">' +
                    '<option value="0">All Categories</option>' +
                    '</select></div>' +
                    '</form>',
            boxWidth: '40%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                formSubmit: {
                    text: 'Filter Items',
                    btnClass: 'btn-purple',
                    action: function () {
                        $('#catalogContent').html('');
                        var cat = parseInt(this.$content.find('#filtercategory').val());
                        var cla = parseInt(this.$content.find('#itemClassificationSelect').val());
                        if (cla === 0) {
                            ajaxSubmitData('externalsuppliers/fetchSupplierItems.htm', 'catalogContent', '&supplierid=' + supplierid, 'GET');
                        } else {
                            if (cat > 0 || cat === 0) {
                                $.ajax({
                                    type: 'POST',
                                    data: {supplierid: supplierid, cla: cla, cat: cat},
                                    url: 'externalsuppliers/filterCatalogItems.htm',
                                    success: function (data) {
                                        $('#catalogContent').html(data);
                                    }
                                });
                            }
                        }
                    }
                },
                close: {
                    text: 'Close',
                    btnClass: 'btn-blue',
                    action: function () {

                    }
                }
            },
            onContentReady: function () {
                // bind to events
                var catgroup = this.$content.find('#catGroup');
                var cat = this.$content.find('#filtercategory');
                var cla = this.$content.find('#itemClassificationSelect');
                catgroup.hide();
                cla.change(function () {
                    var classification = parseInt(cla.val());
                    if (!(classification === 0)) {
                        catgroup.show();
                        $.ajax({
                            type: 'POST',
                            data: {supplierid: supplierid, classification: classification},
                            url: 'externalsuppliers/fetchClassificationCategories_json.htm',
                            success: function (data) {
                                var res = JSON.parse(data);
                                if (res !== '' && res.length > 0) {
                                    cat.html('<option value="0">All Categories</option>');
                                    for (i in res) {
                                        cat.append('<option id="cat' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                    }
                                } else {
                                    cat.html('<option value="-0">--No Categories Set--</option>');
                                }
                            }
                        });
                    } else {
                        catgroup.hide();
                    }
                });
            }
        });
    }
</script>
