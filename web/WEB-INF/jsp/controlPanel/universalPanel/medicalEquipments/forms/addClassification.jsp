<%-- 
    Document   : addClassification
    Created on : Oct 29, 2018, 10:45:22 AM
    Author     : IICS
--%>
<style>
    .error
    {
        border:2px solid red;
    }

    .myform{
        width:100% !important;
    }
</style>
<div class="col-md-4">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Enter Classification Details</h4>
                <div class="tile-body">
                    <form id="classificationentryform">
                        <div class="form-group">
                            <label class="control-label">Classification Name</label>
                            <input class="form-control myform"  oninput="checkClassName()" id="classificationname" type="text" placeholder="Enter Classification Name">
                            <h6 id='classificationresults'></h6>
                        </div>
                        <div class="form-group">
                            <label class="control-label">More Information</label>
                            <textarea class="form-control myform" rows="4" id="classDescription" type="text" placeholder="Enter More Info. About Classification"></textarea>
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="captureClassDetails" type="button">
                        <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                        Add Classification
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="col-md-8">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Entered Classification(s).</h4>
                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Classification Name</th>
                            <th>More Information</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody id="enteredClassificationsBody">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="saveClassifications" disabled="true">
                        <i class="fa fa-save"></i>
                        Save
                    </button>
                </div>
            </div>
            <span id="incrementx" class="hidedisplaycontent">0</span>
        </div>
    </div>
</div>
<script>
    var classificationList = new Set();
    var classificationObjectList = [];
    var classnamestestSet = new Set();
    $('#captureClassDetails').click(function () {
        var className = $('#classificationname').val();
        var description = $('#classDescription').val();
        var count = $('#incrementx').html();

        if (className !== '') {
            if (classnamestestSet.has(className)) {
                $.alert({
                    title: '',
                    content: '<div class="center">' + '<font size="5">' + '<strong class="text-danger">' + className + '</strong> &nbsp;Already Exists!!</font></div>',
                    type: 'red',
                    typeAnimated: true,
                });
            } else {
                document.getElementById('saveClassifications').disabled = false;
                var xcount = parseInt(count) + 1;
                $('#incrementx').html(xcount);
                $('#enteredClassificationsBody').append(
                        '<tr id="rowfg' + count + '">' +
                        '<td class="center">' + className + '</td>' +
                        '<td class="center" >' + description + '</td>' +
                        '<td class="center">' +
                        '<span class="badge badge-danger icon-custom" onclick="remove(\'' + count + '\')">' +
                        '<i class="fa fa-trash-o"></i></span></td></tr>'
                        );
                document.getElementById("classificationentryform").reset();
                $('#classificationname').css('border', '2px solid #6d0a70');
                $('#classDescription').css('border', '2px solid #6d0a70');
                var data = {
                    className: className,
                    description: description,
                    buildingxid: xcount
                };
                classnamestestSet.add(count);
                classificationList.add(className);
                classificationObjectList.push(data);
            }

        } else {

            $('#classificationname').focus();
            $('#classificationname').css('border', '2px solid #f50808c4');
            $('#classDescription').focus();
            $('#classDescription').css('border', '2px solid #f50808c4');
        }
    });

    function remove(count) {
        $('#rowfg' + count).remove();
        classnamestestSet.delete(count);
    }

    //CHECKING CLASSIFICATION

    function checkClassName() {
        var classificationname = $('#classificationname').val();
        var classificationresults = $("#classificationresults");
        var size = classificationname.length;
        if (size >= 3) {
            $.ajax({
                type: "POST",
                cache: false,
                url: "medicalandnonmedicalequipment/checkMedicalClassificationName.htm",
                data: {searchValue: classificationname},
                success: function (data) {
                    if (data === "exists") {
                        $('#classificationname').addClass('error');
                        classificationresults.css("color", "red");
                        classificationresults.text(classificationname + " Already Exists");
                    } else {
                        $('#classificationname').removeClass('error');
                        classificationresults.css("color", "green");
                        classificationresults.text(" ");
                    }
                }
            });
        }
    }


    //SAVING CLASSIFICATIONS
    $('#saveClassifications').click(function () {
        if (classificationObjectList.length > 0) {
            var data = {
                classifications: JSON.stringify(classificationObjectList)
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'medicalandnonmedicalequipment/saveClassification.htm',
                success: function (res) {
                    if (res === "Success") {
                        document.getElementById('classificationname').value = "";
                        document.getElementById('classDescription').value = "";
                        $.toast({
                            heading: 'Success',
                            text: 'Classification Added Successfully.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        ajaxSubmitData('medicalandnonmedicalequipment/medicalEquipmentPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        window.location = '#close';
                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'An Unexpected Error Occured While Trying To Add Classification.',
                            icon: 'error'
                        });
                        ajaxSubmitData('medicalandnonmedicalequipment/medicalEquipmentPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        window.location = '#close';

                    }
                }
            });
        }
    });


</script>