<%-- 
    Document   : addassetclassification
    Created on : Jun 7, 2018, 2:19:59 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>
<style>
    .error
    {
        border:2px solid red;
    }

    .myform{
        width: 100% !important;
    }
</style>
<div class="col-md-4">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Enter Asset Classification Details</h4>
                <div class="tile-body">
                    <form id="classificationentryforms">
                        <div class="form-group">
                            <label class="control-label">Current Facility</label>
                            <input class="form-control myform" id="facilityidz" value="${FacilityList.facilityid}" type="hidden">
                            <input class="form-control myform" id="facilitynamez" value="${FacilityList.facilityname}" type="text" readonly="true">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Asset Classification Name</label>
                            <input class="form-control myform" id="classificationname" type="text" placeholder="Enter Building Name">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Classification Allocation Type</label>
                            <select class="form-control myform" id="selectedclassification">
                                <option value="Both">Both</option>
                                <option value="Person">Person</option>
                                <option value="Room">Room</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="captureClassification" type="button">
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
                <h4 class="tile-title">Entered Asset Classification(s).</h4>
                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Asset Classification</th>
                            <th>Classification Allocation Type</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody id="enteredAssetClassification">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="saveclassification">
                        Finish
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    //document.querySelector('input').setAttribute('autofocus', 'autofocus');
    var classificationList = new Set();
    var classificationObjectList = [];
    var OneNameArray = [];
    var OneNameArrays = [];
    var OneNameArrayes = [];
    //document.getElementById('saveclassification').disabled = true;
    //document.getElementById('captureClassification').disabled = true;

    var classificationnames = [];
    var classificationSet = new Set();
    $('#captureClassification').click(function () {
        var facId = $('#facilityidz').val();
        var facName = $('#facilitynamez').val();
        var classificationName = $('#classificationname').val();
        var allocationType = document.getElementById('selectedclassification').value;
        var count = $('#incrementx').html();
        document.getElementById('facilityidz').value = facId;
        document.getElementById('facilitynamez').value = facName;

        document.getElementById('classificationname').value = "";

        if (classificationName !== '') {
            var ClassificationNameUpper = classificationName.toUpperCase()
            if (classificationSet.has(ClassificationNameUpper)) {
                $.alert({
                    title: '',
                    content: '<div class="center">' + '<font size="5">' + '<strong class="text-danger">' + classificationName + '</strong> &nbsp;Already Exists!!</font></div>',
                    type: 'red',
                    typeAnimated: true,
                });
            } else {
                document.getElementById('captureClassification').disabled = false;
                var xcount = parseInt(count) + 1;
                ;
                $('#incrementx').html(xcount);
                $('#enteredAssetClassification').append(
                        '<tr id="rowfg' + facId + '">' +
                        '<td class="center">' + classificationName + '</td>' +
                        '<td class="center" >' + '<a>' + allocationType + '</a>' + '</td>' +
                        '<td class="center">' +
                        '<span class="badge badge-danger icon-custom" onclick="remove(\'' + facId + '\')">' +
                        '<i class="fa fa-trash-o"></i></span></td></tr>'
                        );
                document.getElementById("classificationentryforms").reset();
                $('#facilityidz').css('border', '2px solid #6d0a70');
                $('#classificationname').css('border', '2px solid #6d0a70');
                $('#selectedclassification').css('border', '2px solid #6d0a70');

                var data = {
                    classificationName: classificationName,
                    facilityid: facId,
                    facilityname: facName,
                    allocationtype: allocationType
                };
                classificationSet.add(ClassificationNameUpper);
                classificationList.add(facId);
                classificationObjectList.push(data);

            }

        } else {

            $('#classificationname').focus();
            $('#classificationname').css('border', '2px solid #f50808c4');


        }
    });

    $('#saveclassification').click(function () {
        $.confirm({
            title: 'Message!',
            content: 'Save Asset Classification',
            type: 'blue',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {
                        if (classificationObjectList.length > 0) {
                            var data = {
                                classifications: JSON.stringify(classificationObjectList)
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'assetsmanagement/saveclassifications.htm',
                                success: function (res) {

                                    document.getElementById('classificationname').value = "";
                                    document.getElementById('selectedclassification').value = "";
                                    $('#enteredAssetClassification').html('');
                                    classificationObjectList = [];
                                    ajaxSubmitData('assetsmanagement/assetmanagementPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }

                    }
                },
                NO: function () {
                    document.getElementById('classificationname').value = "";
                    document.getElementById('selectedclassification').value = "";
                    $('#enteredAssetClassification').html('');
                    classificationObjectList = [];

                }
            }
        });
    });


</script>
