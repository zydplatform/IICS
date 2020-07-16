<%-- 
    Document   : expiredItemsPane
    Created on : Oct 6, 2018, 5:22:15 PM
    Author     : IICS
--%>
<fieldset>
    <div class="row" id="expiredItems">

    </div>
</fieldset>
<script>
    $(document).ready(function () {
        $.ajax({
            type: 'POST',
            url: "expiryAndDamages/fetchExpiredItems.htm",
            success: function (data) {
                $('#expiredItems').html(data);
            }
        });
    });
</script>