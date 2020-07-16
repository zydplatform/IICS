<%-- 
    Document   : updatelanguage
    Created on : Sep 28, 2019, 5:46:07 PM
    Author     : EARTHQUAKER
--%>

<%@include file="../../../../include.jsp"%>
<div class="tile-body">
    <div class="row">
        <div class="col-md-12">
            <form class="form-horizontal">

                <div class="form-group row">
                    <input class="form-control myform" id="languageid" value="" type="hidden">
                    <label class="control-label col-md-4" for="description2">Language Name</label>
                    <div class="col-md-8">
                        
                        <input class="form-control" id="languagenamex" name="languagenamexx">
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>
<div class="tile-footer">
    <button class="btn btn-primary" id="updatelangugage" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Update Language</button>
    <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
</div>



<script>
    
//    var update = $('#name').val(namex);
//       $("#languagenamex").val(update);
    $('#updatelangugage').click(function () {
        var Existinglanguage = ${jsonCreatedlanguage};
        var ExistinglanguageNameSet = new Set();
        for (var x in Existinglanguage) {
            if (Existinglanguage.hasOwnProperty(x)) {

                ExistinglanguageNameSet.add(Existinglanguage[x].languagename);
            }
        }
        var namx =  $("#languagenamex").val();
        var languagename = namx.charAt(0).toUpperCase() + namx.substr(1).toLowerCase();
        var languageid = $('#languageid').val();
        var regex = /^[a-zA-Z\s]*$/;
        var testname = regex.test(languagename);
        if (testname !== true) {
            $.alert({
                title: 'Alert!',
                content: 'Language format not allowed'
            });
            $("#languagenamex").val('');
        } else {
            if (ExistinglanguageNameSet.has(languagename)) {
                $('#languagenamex').focus();
                $('#languagenamex').addClass('error');
                $.alert({
                    title: 'Alert!',
                    content: languagename + ' Already Exists'
                });
                $('#languagenamex').val('');
            } else if (languagename.trim().length === 0) {
                $.alert({
                    title: 'Alert!',
                    content: 'Input cannot be empty'
                });
                return false;
            } else
            {
                $.confirm({
                    title: 'Message!',
                    content: 'Update language' + ' ' + languagename,
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Yes',
                            btnClass: 'btn-green',
                            action: function () {
                                $('.close').click();
                                $.ajax({
                                    type: 'POST',
                                    cache: false,
                                    dataType: 'text',
                                    data: {languagename: languagename, languageid: languageid},
                                    url: "spokenlanguages/updatespokenlanguage.htm",
                                    success: function (data) {
                                        $.toast({
                                            heading: 'Success',
                                            text: 'language updated Successfully.',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'top-center'
                                        });
                                        $('#addlanguage').modal('hide');
                                        $('.body').removeClass('modal-open');
                                        $('.modal-backdrop').remove();
                                        ajaxSubmitData('spokenlanguages/managespokenlanguages.htm', 'workpane', '', 'GET');
                                    }
                                });
                            }
                        },
                        cancel: function () {
                            $('#addlanguage').modal('hide');
                            $('.body').removeClass('modal-open');
                            $('.modal-backdrop').remove();
                            $('.close').click();
                            ajaxSubmitData('spokenlanguages/managespokenlanguages.htm', 'workpane', '', 'GET');
                        }
                    }
                });
            }
        }
    });

</script>
