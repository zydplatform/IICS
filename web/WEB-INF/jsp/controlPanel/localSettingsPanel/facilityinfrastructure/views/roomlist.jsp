<%-- 
    Document   : roomlist
    Created on : Sep 24, 2019, 8:18:20 AM
    Author     : USER 1
--%>

<%@include file = "../../../../include.jsp" %>

<div class="row">
    <div class="col-md-12">
        <div class="form-group">
            <input class="form-control" id="floorid" type="hidden" value="${floorid}">
            <input class="form-control" id="floorname" type="hidden" value="${floorname}">
        </div>
    </div>
</div>

<div class="tile">
    <div class="tile-body">
        <fieldset>
            <table class="table table-hover table-bordered col-md-12" id="blockTablesx">
                <thead>
                    <tr>
                        <th class="center">No</th>
                        <th class="center">Room Name</th>
                        <th class="center">Rename Room</th>
                    </tr>
                </thead>
                <tbody class="col-md-12" id="viewblocktable">
                    <% int i = 1;%>                 
                    <c:forEach items="${roomlist}" var="a">
                        <tr id="${a.roomid}">
                            <td><%=i++%></td>
                            <td class="center">${a.roomname}</td>
                            <td class="center">    
                                <a  class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit" onclick="editroom(${a.roomid},${floorid});" ><i class="fa fa-edit"></i></a> 
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table> 
        </fieldset>
    </div>
</div>

<script>
    $('#floorid').val();
    $('[data-toggle="popover"]').popover();
    $('#blockTablesx').DataTable();


    function editroom(value, floorid) {
        var tableData = $('#' + value).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + value).closest('tr').attr('id');
        $('#roomid').val(value);
        $('#floorid').val(floorid);
        $.confirm({
            title: 'Change Room Name!',
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
                    '<label>Enter Room Name</label><br>' +
                    '<span id="errormessage" style="color: red"><strong><strong></span>' +
                    '<input  id="editedRoomname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Room Name Here" class="name form-control myform" required oninput="checkregexxx(this)" />' +
                    '<span id= "errors">'+
                    '</span>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                      var roomid = value;
                       var roomname = $('#editedRoomname').val();
                        var roomchangecase = roomname.charAt(0).toUpperCase() + roomname.substr(1).toLowerCase();
                         if(roomchangecase.trim().length ===0 || roomchangecase ===undefined){
                             $('#errors').html('<span style="color:red">*Field Required.*</span>');
                            $('#editedRoomname').focus(); 
                            return false;
                           }
                           else{
                        $.ajax({
                            type: 'POST',
                            cache: false,
                            data: {roomid: roomid, roomname: roomchangecase},
                            url: "facilityinfrastructure/updateroom.htm",
                            success: function () {
                                 $.toast({
                                    heading: 'Success',
                                    text: 'Room Updated Successfully.',
                                    icon: 'success',
                                    hideAfter: 2000,
                                    position: 'top-center'
                                });
                                 updateroomdialog.close();
                                 updateroom(${buildingid});
                                
                            }
                        });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
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
    
    
    function checkregexxx(obj){
        var roomlabel = $(obj).val();
        var regex = /^([a-zA-Z])[a-zA-Z_-]*[\w_-]*[\S]$|^([a-zA-Z])[0-9_-]*[\S]$|^[a-zA-Z]*[\S]$/;
        var testname = regex.test(roomlabel);
        if (testname != true) {
            $.confirm({
                        title: 'Info',
                        content: 'Room name format not allowed',
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

</script>
