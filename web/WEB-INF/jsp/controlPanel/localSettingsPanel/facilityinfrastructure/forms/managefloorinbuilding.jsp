<%-- 
    Document   : managefloorinbuilding
    Created on : Aug 27, 2019, 11:52:40 AM
    Author     : USER 1
--%>

<%@include file="../../../../include.jsp" %>
<style>
    .error
    {
        border:2px solid red;
    }

</style>
<div class="col-md-6">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <form id="buildingentryform">
                        <div class="form-group">
                            <label class="control-label">Current Building</label>
                            <input class="form-control myform" id="buildingidz" value="${BuildingLists.buildingid}" type="hidden">
                            <input class="form-control myform" id="buildingnamez" value="${BuildingLists.buildingname}" type="text" readonly="true">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Number Of Floors</label>
                            <input class="form-control myform" id="floornumber" type="number" placeholder="Enter Number Of Floors" oninput="showfloorlabelsz();">
                        </div>
                    </form>
                    <div class="tile">
                        <p class="tile-title">Floor labels for  <span id = "floorlabelxx"></span>  </p>
                        <div id ="floorformz" style="overflow: auto; max-height: 100px">


                        </div>
                    </div> 
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="capturetheFloor" type="button">
                        <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                        Add Floor
                    </button>
                </div>
            </div>floornumber
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Entered Floor(s).</h4>
                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Building</th>
                            <th>Floor Name</th>
                            <th>Default room</th>
                            <th>Rename Floor</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody id="enteredTheFloorsBody">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="savethefloors">
                        Finish
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var buildingId = ${BuildingLists.buildingid};
    var roomList = new Set();
    var floorSet = new Set();
    var floorList = [];
    var floorObjectLists = [];
    var defaultroomArray = [];
    document.getElementById('savethefloors').disabled = true;
    $(document).ready(function () {
        document.getElementById('capturetheFloor').disabled = true;
        var buildingnamexx = $('#buildingnamez').val();
        $('#floorlabelxx').html(buildingnamexx);
        $('#capturetheFloor').click(function () {
            var numberofthefloors = $('#floornumber').val();
            var buildingid = $('#buildingidz').val();
            var buildingname = $('#buildingnamez').val();
            var i;
            $.ajax({
                type: 'GET',
                data: {buildingid: buildingid, tableData: buildingname},
                url: "facilityinfrastructure/checkfloornames.htm",
                success: function (results) {
                    console.log(results);
                    floorList = JSON.parse(results);
                    var set = new Set(floorList);
                    var j = 1;
                    for (i = 1; i <= numberofthefloors; i++) {
                        var floorNameUpper = ('FLOOR' + ' ' + i);
                        if (set.has(floorNameUpper)) {
                            for (i = Number(numberofthefloors) + Number(j); i <= Number(numberofthefloors) + Number(numberofthefloors); i++) {
                                document.getElementById('savethefloors').disabled = false;

                                $('#enteredTheFloorsBody').append(
                                        '<tr id="rowrm' + i + '">' +
                                        '<td class="center">' + floorname + '</td>' +
                                        '<td class="center" >FLOOR' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editfloorname(\'floorggg' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('floornumber').value = "";

                            }

                        } else {
                            for (i = 1; i <= numberofthefloors; i++) {
                                var buildingname = $('#buildingnamez').val();

                                var floorformlabelz = $('#floorformlabelz' + i).val();
                                document.getElementById('savethefloors').disabled = false;
                                $('#enteredTheFloorsBody').append(
                                        '<tr id="rowrm' + i + '">' +
                                        '<td class="center">' + buildingname + '</td>' +
                                        '<td class="center" >' + floorformlabelz + '</td>' +
                                        '<td class = "center">Room 1</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editfloorname(\'rowrm' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('floornumber').value = "";
                            }

                        }
                    }

                }

            });

            $('#' + i).parent().remove();
        });
    });
    function remove(i) {
        $('#rowrm' + i).remove();
        roomList.delete(i);
    }

    function editfloorname(id) {
        var tableData = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        $.confirm({
            title: 'Change Floor Name!',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            theme: 'modern',
            icon: 'fa fa-question-circle',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Floor Name</label><br>' +
                    '<span id="errormessage" style="color: red"><strong><strong></span>' +
                    '<input  id="editedFloornamez" type="text" value="' + tableData[1] + '" placeholder="Please Enter Floor Name Here" class="name form-control myform" oninput="checkregex(this);" required />' +
                    '<span id= "errorxx">'+
                    '</span>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                        var name = this.$content.find('.name').val();
                         if(name.trim().length ===0 || name ===undefined){
                             $('#errorxx').html('<span style="color:red">*Field Required.*</span>');
                            $('#editedFloornamez').focus(); 
                            return false;
                           }
                           else{
                        if (!name) {
                            $('#editedFloornamez').addClass('error');
                            $.alert('Please Enter Floor Name');
                            return false;
                        }
                        $.alert('New Floor Name Is ' + name);

                        var x = document.getElementById('enteredTheFloorsBody').rows;
                        var y = x[id].cells;
                        y[1].innerHTML = name;
                    }
                }
                },
                cancel: function () {
                    //close
                },
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    function checkfloorlabelnames(obj) {
        var buildingid = $('#buildingidz').val();
        var buildingname = $('#buildingnamez').val();
        var numberofthefloorsx = $('#floornumber').val();
        for (i = 1; i <= numberofthefloorsx; i++) {
            var floorname = $(obj).val();
            var regex = /^([a-zA-Z])[a-zA-Z_-]*[\w_-]*[\S]$|^([a-zA-Z])[0-9_-]*[\S]$|^[a-zA-Z]*[\S]$/;
            var testname = regex.test(floorname);
            if (testname !== true) {
                 $.confirm({
                            title: 'Info',
                            content: 'Floor format not allowed',
                            boxWidth: '35%',
                            useBootstrap: false,
                            type: 'purple',
                            typeAnimated: true,
                            closeIcon: true,
                            theme: 'modern',
                            buttons: {
                                OK: {
                                    text: 'Ok',
                                    btnClass: 'btn-purple',
                                    keys: ['enter', 'shift'],
                                    action: function () {
                                       $(obj).val('');
                                    }
                                }
                            }
                        });
                $(obj).addClass('error');

                document.getElementById('capturetheFloor').disabled = true;
            } else {
                document.getElementById('capturetheFloor').disabled = false;
                $(obj).removeClass('error');
                $.ajax({
                    type: 'GET',
                    data: {buildingid: buildingid, tableData: buildingname},
                    url: "facilityinfrastructure/checkfloornames.htm",
                    success: function (results) {
                        console.log(results);
                        floorList = JSON.parse(results);
                        var set = new Set(floorList);

                        var floorname = $(obj).val();
                        if (set.has(floorname)) {
                            $(obj).addClass('error');
                            $.alert('Floor Name' + ' ' + '<strong>' + floorname + '</strong>' + ' ' + 'Already Exists');
                        } else {
                            $(obj).removeClass('error');
                        }
                    }
                });

            }

        }
    }


    function checkfloornamesz() {
        var floorname = $('#editedFloornamez').val();
        var regex = /^[a-zA-Z0-9_-\s]*$/;
        var testname = regex.test(floorname);
        if (testname != true) {
            $.toast({
                heading: 'Error',
                text: 'Only letters and numbers allowed!.',
                icon: 'error',
                hideAfter: 2000,
                position: 'top-center'
            });
            $('#editedFloornamez').addClass('error');

        } else {
            if (floorSet.has(floorname)) {
                $('#editedFloornamez').addClass('error');
                $.alert('Floor Name' + ' ' + '<strong>' + floorname + '</strong>' + ' ' + 'Already Exists');
            } else {
                $('#editedFloornamez').removeClass('error');
            }
        }
    }

    function showfloorlabelsz() {
        var buildingnamexx = $('#buildingnamez').val();
        var i;
        var numberofthefloors = $('#floornumber').val();
        $('#floorformz').html('');
        if (numberofthefloors > 20) {
            $.confirm({
                title: 'Info',
                content: 'Maximum floor number is 20',
                boxWidth: '35%',
                useBootstrap: false,
                type: 'purple',
                typeAnimated: true,
                closeIcon: true,
                theme: 'modern',
                buttons: {
                    OK: {
                        text: 'Ok',
                        btnClass: 'btn-purple',
                        keys: ['enter', 'shift'],
                        action: function () {

                        }
                    }
                }
            });
        } else {
            for (i = 1; i <= numberofthefloors; i++) {
                $('#floorformz').append(
                        '<form action="" class="formName" "frm' + i + '">' +
                        '<div class="form-group">' +
                        '<label>Floor label ' + i + ' for ' + buildingnamexx + '</label><br>' +
                        '<span id="errormessage" style="color: red"><strong><strong></span>' +
                        '<input  id="floorformlabelz' + i + '" type="text" placeholder="Please Enter Floor Name Here" class="name form-control myform" oninput="checkfloorlabelnames(this);" required />' +
                        '</div>' +
                        '</form>'


                        );

            }

        }
    }
    
    function checkregex(obj){
        var floorlabel = $(obj).val();
        var regex = /^([a-zA-Z])[a-zA-Z_-]*[\w_-]*[\S]$|^([a-zA-Z])[0-9_-]*[\S]$|^[a-zA-Z]*[\S]$/;
        var testname = regex.test(floorlabel);
        if (testname != true) {
            $.confirm({
                            title: 'Info',
                            content: 'Floor format not allowed',
                            boxWidth: '35%',
                            useBootstrap: false,
                            type: 'purple',
                            typeAnimated: true,
                            closeIcon: true,
                            theme: 'modern',
                            buttons: {
                                OK: {
                                    text: 'Ok',
                                    btnClass: 'btn-purple',
                                    keys: ['enter', 'shift'],
                                    action: function () {
                                       $(obj).val('');
                                    }
                                }
                            }
                        });
             $(obj).addClass('error')
            //$(obj).attr("disabled", "disabled");
        }else{
            $(obj).removeClass('error');
        }
    }

    //SAVING ROOMS TO A FLOOR
    $('#savethefloors').click(function () {
        var buildingid = $('#buildingidz').val();
        var tablebody = document.getElementById("enteredTheFloorsBody");
        var f = document.getElementById("enteredTheFloorsBody").rows.length;
        for (var i = 0; i < f; i++) {
            var rowed = tablebody.rows[i];
            var ided = rowed.id;
            var tableData = $('#' + ided).closest('tr')
                    .find('td')
                    .map(function () {
                        return $(this).text();
                    }).get();
            floorObjectLists.push({
                rowid: i,
                floornamed: tableData[1],
                floorxid: i
            });
            for (var x in floorObjectLists) {
                defaultroomArray.push({
                    floorid: floorObjectLists[x].floorxid,
                    roomnamex: tableData[2]

                });

            }
        }

        console.log(JSON.stringify(floorObjectLists));
        console.log(JSON.stringify(defaultroomArray));
        $.ajax({
            type: 'POST',
            cache: false,
            data: {floorObjectLists: JSON.stringify(floorObjectLists), buildingid: buildingid, roomx: JSON.stringify(defaultroomArray)},
            url: "facilityinfrastructure/savefloors.htm",
            success: function (results) {
                console.log(results);
                var messages = JSON.parse(results);
                if (messages.length !== 0) {
                    var display = '';
                    for (var message in messages) {
                        display += messages[message] + '<br/>';
                    }

                    $.confirm({
                        title: 'Info',
                        content: display,
                        boxWidth: '35%',
                        useBootstrap: false,
                        type: 'purple',
                        typeAnimated: true,
                        closeIcon: true,
                        theme: 'modern',
                        buttons: {
                            OK: {
                                text: 'Ok',
                                btnClass: 'btn-purple',
                                keys: ['enter', 'shift'],
                                action: function () {
                                    ajaxSubmitData('facilityinfrastructure/manageinfrastructure.htm', 'workpane', '', 'GET');
                                }
                            }
                        }
                    });//                                        
                } else {
                    document.getElementById('floornumber').value = "";
                    floorObjectLists = [];
                    $('#enteredTheFloorsBody').html('');
                    $.toast({
                        heading: 'Success',
                        text: 'Floors Added Successfully.',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'top-center'
                    });
                    ajaxSubmitData('facilityinfrastructure/manageinfrastructure.htm', 'workpane', '', 'GET');
                    window.location = '#close';
                }
            }
        });
    });


</script>
