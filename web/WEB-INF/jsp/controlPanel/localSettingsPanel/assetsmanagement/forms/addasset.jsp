<%-- 
    Document   : addasset
    Created on : Jun 7, 2018, 2:20:20 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<style>
    .error
    {
        border:2px solid red;
    }

</style>
<div class="col-md-4">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Enter Asset Details</h4>
                <div class="tile-body">
                    <form id="assetentryform">
                        <div class="form-group">
                            <label class="control-label">Asset Classification Name:</label>
                            <input class="form-control" id="classname" value="${classificationname}" type="text" readonly="true">
                            <input class="form-control" id="classid" value="${classificationid}" type="hidden">

                        </div>
                        <div class="form-group">
                            <label class="control-label">Asset Name</label>
                            <input class="form-control" id="assetname" type="text" placeholder="Enter Asset Name">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Asset Identifier</label>
                            <input class="form-control" id="assetidentity" type="text" placeholder="Enter Asset Identifier">
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="captureAsset" type="button">
                        <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                        Add Asset
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
                <h4 class="tile-title">Entered Asset(s).</h4>
                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Asset Classification</th>
                            <th>Asset Name</th>
                            <th>Asset Identifier</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody id="enteredAssetsBody">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="saveAssets">
                        Finish
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var assetnames = [];
    var assetSet = new Set();
    var assetList = new Set();
    var assetObjectList = [];
    
    $('#captureAsset').click(function () {
        var classId = $('#classid').val();
        var className = $('#classname').val();
        var assetName = $('#assetname').val();
        var assetIdentity= $('#assetidentity').val();
        var count = $('#incrementx').html();
        console.log("iddddddddd"+classId);
        document.getElementById('classid').value = classId;
        document.getElementById('classname').value = className;

        document.getElementById('assetname').value = "";
        document.getElementById('assetidentity').value = "";

        if (assetIdentity !== '') {
            var AssetIdentityUpper = assetIdentity.toUpperCase()
            if (assetSet.has(AssetIdentityUpper)) {
                $.alert({
                    title: '',
                    content: '<div class="center">' + '<font size="5">' + '<strong class="text-danger">' + assetIdentity + '</strong> &nbsp;Already Exists!!</font></div>',
                    type: 'red',
                    typeAnimated: true,
                });
            } else {
                document.getElementById('captureAsset').disabled = false;
                var xcount = parseInt(count) + 1;
                ;
                $('#incrementx').html(xcount);
                $('#enteredAssetsBody').append(
                        '<tr id="rowfg' + classId + '">' +
                        '<td class="center">' + className + '</td>' +
                        '<td class="center">' + assetName + '</td>' +
                        '<td class="center">' + assetIdentity + '</td>' +
                        '<td class="center">' +
                        '<span class="badge badge-danger icon-custom" onclick="remove(\'' + classId + '\')">' +
                        '<i class="fa fa-trash-o"></i></span></td></tr>'
                        );
                document.getElementById("assetentryform").reset();
                $('#classid').css('border', '2px solid #6d0a70');
                $('#assetname').css('border', '2px solid #6d0a70');
                $('#assetidentity').css('border', '2px solid #6d0a70');

                var data = {
                    assetName: assetName,
                    assetIdentity: assetIdentity,
                    classId: classId,
                    className: className
                };
                assetSet.add(AssetIdentityUpper);
                assetList.add(classId);
                assetObjectList.push(data);

            }

        } else {

            $('#assetidentity').focus();
            $('#assetidentity').css('border', '2px solid #f50808c4');


        }
    });
    
     $('#saveAssets').click(function () {
         var classId = $('#classid').val();
        $.confirm({
            title: 'Message!',
            content: 'Save Asset',
            type: 'blue',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {
                        if (assetObjectList.length > 0) {
                            var data = {
                                assets: JSON.stringify(assetObjectList),
                                classId: classId
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'assetsmanagement/saveassets.htm',
                                success: function (res) {

                                    document.getElementById('assetname').value = "";
                                    $('#enteredAssetsBody').html('');
                                    assetObjectList = [];
                                    ajaxSubmitData('assetsmanagement/assetmanagementPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }

                    }
                },
                NO: function () {
                    document.getElementById('assetname').value = "";
                    $('#enteredAssetsBody').html('');
                    assetObjectList = [];

                }
            }
        });
    });

</script>