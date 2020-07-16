<%-- 
    Document   : approvedItems
    Created on : 07-May-2018, 14:08:08
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<div class="row">
    <div class="col-md-4">
        <form>
            <div class="form-group">
                <select class="form-control" id="groupid">
                    <option value="0" selected="true">Medicines</option>
                    <option value="1">Supplies</option>
                </select>
            </div>
        </form>
    </div>
</div>
<div class="row">
    <div class="col-md-12" id="catContent"></div>
</div>
<script>
    $(document).ready(function () {
        $('#groupid').select2();
        $('.select2').css('width', '100%');
        var issupplies = parseInt($('#groupid').val()) === 1;
        fetchCategoryItems(issupplies);
        
        $('#groupid').change(function () {
            $('#catContent').html('');
            issupplies = parseInt($('#groupid').val()) === 1;
            fetchCategoryItems(issupplies);
        });
    });

    function fetchCategoryItems(issupplies) {
        ajaxSubmitData('catalogue/fetchUnitCatalogueApprovedItems.htm', 'catContent', '&issupplies=' + issupplies, 'GET');
    }
</script>