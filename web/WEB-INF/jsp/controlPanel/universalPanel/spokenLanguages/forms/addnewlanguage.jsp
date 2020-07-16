<%-- 
    Document   : addnewlanguage
    Created on : Sep 27, 2019, 4:05:24 PM
    Author     : EARTHQUAKER
--%>
<%@include file="../../../../include.jsp"%>
<div class="tile-body">
    <div class="row">
        <div class="col-md-12">
            <form class="form-horizontal">

                <div class="form-group row">
                    <label class="control-label col-md-4" for="description2">Language Name</label>
                    <div class="col-md-8">
                        <input class="form-control" id="languagename" name="languagenamex">
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>
<div class="tile-footer">
    <button class="btn btn-primary" id="savelangugage" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save Language</button>
    <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
</div>



<script>
    var languageArray = [];
    $('#savelangugage').click(function () {
        var Existinglanguage = ${jsonCreatedlanguage};
        var ExistinglanguageNameSet = new Set();
        for (var x in Existinglanguage) {
            if (Existinglanguage.hasOwnProperty(x)) {

                ExistinglanguageNameSet.add(Existinglanguage[x].languagename);
            }
        }
        var lang =  $('#languagename').val(); 
        var languagename = lang.charAt(0).toUpperCase() + lang.substr(1).toLowerCase();
        var regex = /^[a-zA-Z\s]*$/;
        var testname = regex.test(languagename);
        if (testname !== true) {
            $.alert({
                title: 'Alert!',
                content: 'Language format not allowed'
            });
            $('#languagename').focus();
            $('#languagename').addClass('error');
            $('#languagename').val('');
        } else {
            if (ExistinglanguageNameSet.has(languagename)) {
                $('#languagename').focus();
                $('#languagename').addClass('error');
                $.alert({
                    title: 'Alert!',
                    content: languagename + ' Already Exists',
                });
                $('#languagename').val('');
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
                    content: 'Do you want to add more languages?',
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Yes',
                            btnClass: 'btn-green',
                            action: function () {
                                languageArray.push({
                                    languagename: languagename
                                });
                                $('#languagename').val('');
                                $('#addlanguage').modal('show');
                            }
                        },
                        No: function () {
                            languageArray.push({
                                languagename: languagename
                            });
                            $.ajax({
                                type: 'POST',
                                cache: false,
                                dataType: 'text',
                                data: {languages: JSON.stringify(languageArray)},
                                url: "spokenlanguages/savespokenlanguage.htm",
                                success: function (data) {
                                    $.toast({
                                        heading: 'Success',
                                        text: 'language added Successfully.',
                                        icon: 'success',
                                        hideAfter: 2000,
                                        position: 'top-center'
                                    });
                                    $('#addlanguage').modal('hide');
                                    $('.modal-backdrop').remove();
                                    $('.close').click();
                                    $('body').removeClass('modal-open');
                                    ajaxSubmitData('spokenlanguages/managespokenlanguages.htm', 'workpane', '', 'GET');
                                }
                            });

                           
                            
                        }
                    }
                });
            }
        }

    });

</script>
