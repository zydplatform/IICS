<%-- 
    Document   : storagetype
    Created on : Mar 28, 2018, 2:38:50 PM
    Author     : IICSRemote
--%>
<%@include file="../../../../include.jsp" %>
<div>
    <div class="row">
        <div class="col-md-12">
            <div class="btn-group pull-right">
                <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Create Storage Space
                </button>
                <div class="dropdown-menu">
                    <a class="dropdown-item btn btn-secondary" id="createzones">
                        Single Storage Space
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item btn btn-secondary" id="multiplezones">
                        Multiple Storage Space
                    </a>
                </div>
            </div>
        </div>
    </div><br>
    <!--<div>
        <button class="btn btn-primary" id="createzones"><i class="fa fa-plus-circle"></i>&nbsp;Create Storage Space</button>
    </div><br>-->
    <fieldset>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body" id="changetableview">
                        <table class="table table-hover table-bordered" id="storetype">
                            <thead>
                                <tr>
                                    <th>No:</th>
                                    <th class="center">Zone</th>
                                    <th class="center">Storage Typed Cells</th>
                                    <th class="center">Storage Un-Typed Cells</th>
                                    <th class="center">Manage Storage Type</th>                                    
                                    <th class="center">Update</th>
                                    <th class="center">Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%int i = 1;%>
                                <c:forEach items="${CreatedZone}" var="cZone">
                                    <tr>
                                        <td data-label="No:"><%=i++%></td>
                                        <td data-label="Zone">${cZone.zoneName}</td>
                                        <td data-label="Storage Typed Cells" align="center"><button class="btn btn-sm  btn-success" id="${cZone.zoneid}" onclick="showTyped(this.id)">${cZone.storageTyped}</button></td>
                                        <td data-label="Storage Un-Typed Cells" align="center"><button class="btn btn-sm  btn-secondary" id="${cZone.zoneid}" onclick="showUnTyped(this.id)">${cZone.unstorageTyped}</button></td>
                                        <td data-label="Manage Storage Type" align="center"><button class="btn btn-sm  btn-primary" data-name="${cZone.zoneName}" id="${cZone.zoneid}" onclick="showStorageTypeview(this.id, $(this).attr('data-name'))"><i class="fa fa-lg fa-dedent"></i></button></td>
                                        <td data-label="Update" align="center">
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_UPDATEZONELABEL')">
                                                <a href="#" id="${cZone.zoneid}" data-name="${cZone.zoneName}" onclick="updatezonelabel(this.id, $(this).attr('data-name'))"><i class="fa fa-lg fa-edit"></i></a>
                                                </security:authorize> 
                                        </td> 
                                        <td data-label="Delete" align="center">
                                            <a href="#" id="${cZone.zoneid}" data-name="${cZone.zoneName}" onclick="deletezone(this.id, $(this).attr('data-name'))"><i class="fa fa-lg fa-times btn btn-sm btn-danger"></i></a>   
                                        </td>
                                    </tr>
                                </c:forEach>                       
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>  
</div>
<div class="row">
    <div class="col-md-12">
        <div id="createzonesx" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" onclick="closemanage()">X</a>
                    <h2 class="modalDialog-title">Create Storage Space</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">                        
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <%@include file="createZone.jsp" %>     
                                    </div>                                        
                                </div>                                                               
                            </div>                                
                        </div>
                    </div>                        
                </div>
            </div>

        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="multiplezonesx" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" onclick="closemanage()">X</a>
                    <h2 class="modalDialog-title">Create Multiple Storage Space</h2>
                    <hr>
                </div>
                <div class="row scrollbar multipletest" id="content">           
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <%@include file="multiplezones.jsp" %>  
                                    </div>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div> 
<div class="row">
    <div class="col-md-12">
        <div id="Addbaysx01" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Create Storage Space</h2>
                    <hr>
                </div>
                <div class="row scrollbar multipletest" id="content">           
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">                                        
                                        <%@include file="addNewbays.jsp" %> 
                                    </div>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="storageTypeAll" class="registerSupplier">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Manage Storage Types</h2>
                    <hr>
                </div>
                <div class="row scrollbar multipletest" id="content">           
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">  
                                        <div id="showtreeView"></div>
                                    </div>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div> 
<!------Displays  Storage Types Lists--------->
<div class="hidedisplaycontent">
    <div id="storagetypelistcontent"></div>
</div>
<Script>
    var ExistingZoneNameSet = new Set();
    $(document).ready(function () {
        var Existingzone = ${jsonCreatedzone};
      
        for (var x in Existingzone) {
            if (Existingzone.hasOwnProperty(x)) {
                ExistingZoneNameSet.add(Existingzone[x].zoneName);
            }
        }
          console.log(ExistingZoneNameSet)
        $('#storetype').DataTable();
        $('#createzones').click(function () {
            if(ExistingZoneNameSet.size >0){
                $.confirm({
                title: 'Single Storage Space',
                content: 'Select Storage Space',
                type: 'purple',
                typeAnimated: true,
                icon:'fa fa-list',
                buttons: {
                    zone: {
                        text: 'Create Zone',
                        btnClass: 'btn-primary',
                        action: function () {
                            window.location = '#createzonesx';
                            initDialog('supplierCatalogDialog');
                        }
                    },
                    bay: {
                        text: 'Create Bay',
                        btnClass: 'btn-success',
                        action: function () {
                            $('#captureSelectedBay option').prop('selected', function () {
                                return this.defaultSelected;
                            });
                            $('#capturebayNumber').hide();
                            $('#zonebaysListV2').hide();
                            $('#addnewBayStep2').hide();
                            $('#addnewBayStep3').hide();
                            window.location = '#Addbaysx01';
                            initDialog('supplierCatalogDialog');
                        }
                    },
                    close: function () {
                    }
                }
            });
            }else{
                 $.confirm({
                title: 'Create Storage Space',
                content: 'Do you wish to create zone?',
                type: 'purple',
                typeAnimated: true,
                icon:'fa fa-list',
                buttons: {
                    zone: {
                        text: 'Yes',
                        btnClass: 'btn-primary',
                        action: function () {
                            window.location = '#createzonesx';
                            initDialog('supplierCatalogDialog');
                        }
                    },
                    No: function () {
                    }
                }
            });
            }
           
        });
        $('#multiplezones').click(function () {
            if(ExistingZoneNameSet.size >0){
                $.confirm({
                title: 'Multiple Storage Space',
                content: 'Select Storage Space',
                type: 'purple',
                typeAnimated: true,
                icon:'fa fa-list',
                buttons: {
                    zone: {
                        text: 'Create Zone',
                        btnClass: 'btn-primary',
                        action: function () {
                            $.confirm({
                                title: 'Create Multiple Zones!',
                                content: '' +
                                        '<div id="msgerror"></div>' +
                                        '<form action="" class="formName">' +
                                        '<div class="form-group">' +
                                        '<label>Enter Number of Zones</label>' +
                                        '<input type="text" maxlength="1"  placeholder="Number of zones" class="name form-control" required onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57"/>' +
                                        '</div>' +
                                        '</form>',
                                buttons: {
                                    formSubmit: {
                                        text: 'Create',
                                        btnClass: 'btn-success',
                                        action: function () {
                                            var name = this.$content.find('.name').val();
                                            if (!name) {
                                                $('#msgerror').html('<span style="color:red;">*Error Zone Number Required!!!</span>');
                                                return false;
                                            } else if (name <= 0) {
                                                $('#msgerror').html('<span style="color:red;">*Error Enter a Zone Valid Number!!!</span>');
                                                return false;
                                            }
                                            //$.alert('Your name is ' + name);
                                            $('#totalnumber').html(name);
                                            $('#counttotal').html(name);
                                            window.location = '#multiplezonesx';
                                            initDialog('supplierCatalogDialog');
                                        }
                                    },
                                    cancel: function () {
                                        //close;
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
                    },
                    bay: {
                        text: 'Create Bay',
                        btnClass: 'btn-success',
                        action: function () {
                            $('#captureSelectedBay option').prop('selected', function () {
                                return this.defaultSelected;
                            });
                            $('#capturebayNumber').hide();
                            $('#zonebaysListV2').hide();
                            $('#addnewBayStep2').hide();
                            $('#addnewBayStep3').hide();
                            window.location = '#Addbaysx01';
                            initDialog('supplierCatalogDialog');
                        }
                    },
                    close: function () {
                    }
                }
            });
            }else{
                $.confirm({
                title: 'Create Storage Space',
                content: 'Do you wish to create Multiple zones?',
                icon:'fa fa-list',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    zone: {
                        text: 'Yes',
                        btnClass: 'btn-primary',
                        action: function () {
                            $.confirm({
                                title: 'Create Multiple Zones!',
                                content: '' +
                                        '<div id="msgerror"></div>' +
                                        '<form action="" class="formName">' +
                                        '<div class="form-group">' +
                                        '<label>Enter Number of Zones</label>' +
                                        '<input type="text" maxlength="1"  placeholder="Number of zones" class="name form-control" required onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57"/>' +
                                        '</div>' +
                                        '</form>',
                                buttons: {
                                    formSubmit: {
                                        text: 'Create',
                                        btnClass: 'btn-primary',
                                        action: function () {
                                            var name = this.$content.find('.name').val();
                                            if (!name) {
                                                $('#msgerror').html('<span style="color:red;">*Error Zone Number Required!!!</span>');
                                                return false;
                                            } else if (name <= 0) {
                                                $('#msgerror').html('<span style="color:red;">*Error Enter a Zone Valid Number!!!</span>');
                                                return false;
                                            }
                                            //$.alert('Your name is ' + name);
                                            $('#totalnumber').html(name);
                                            $('#counttotal').html(name);
                                            window.location = '#multiplezonesx';
                                            initDialog('supplierCatalogDialog');
                                        }
                                    },
                                    cancel: function () {
                                        //close;
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
                    },
                    No: function () {
                    }
                }
            });
            }
            
        });
    });
    function updatezonelabel(id, zonelabel) {
        // alert(id + '' + zonelabel);
        $.confirm({
            title: 'Update Zone Label!',
            type: 'purple',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<div id="errorMSG"></div>' +
                    '<label>Zone Label</label>' +
                    '<input type="text" placeholder="Enter zone Label here" id="' + zonelabel + '" value="' + zonelabel + '" class="name form-control" required  oninput="checkzoneName(this.id)"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Update',
                    btnClass: 'btn-primary',
                    action: function () {
                        var name = this.$content.find('.name').val().toUpperCase();
                        if (!name) {
                            $('#errorMSG').html('<span class="text-danger">*Error Zone Label Required</span>');
                            return false;
                        } else if (trim(name) === trim(zonelabel)) {
                            $('#errorMSG').html('<span class="text-danger">*Error Zone Label must be different</span>');
                            return false;
                        } else if (ExistingZoneNameSet.has(trim(name))) {
                            $('#errorMSG').html('<span style="color:red;">*Error Zone ' + trim(name) + ' Already Exists!!!</span>');
                            return false;
                        }
                        $('#errorMSG').html('');
                        $.confirm({
                            title: 'Confirm Update!',
                            icon: 'fa fa-check-circle',
                            content: 'Change Zone Label From <strong class="text-danger">' + zonelabel + '</strong>  to  <strong class="text-success">' + trim(name) + '</strong>',
                            type: 'green',
                            buttons: {
                                formSubmit: {
                                    text: 'Confirm Update',
                                    btnClass: 'btn-success',
                                    action: function () {
                                        // $.alert('Confirmed!' + trim(name));
                                        $.ajax({
                                            type: 'GET',
                                            cache: false,
                                            dataType: 'text',
                                            data: {zoneid: id, zonelabel: trim(name)},
                                            url: "localsettigs/updatezoneLabel.htm",
                                            success: function (data) {
                                                if (data === 'success') {
                                                    ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                } else if (data === 'containsitems') {
                                                    $.confirm({
                                                        title: 'Error Updating!',
                                                        icon: 'fa fa-warning',
                                                        content: '<strong class="text-success">' + zonelabel + '</strong> &nbsp; <span class="text-danger">already has Items cannot be Updated!!!</span>',
                                                        type: 'red',
                                                        buttons: {
                                                            formSubmit: {
                                                                text: 'OK',
                                                                btnClass: 'btn-red',
                                                                action: function () {
                                                                },
                                                            },
                                                        }
                                                    });
                                                }
                                            }
                                        });
                                    }
                                },
                                cancel: function () {
                                }
                            }
                        });
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
    function checkzoneName(id, zonelabelv) {
        var inputzone = $('#' + id).val().toUpperCase();
        if (ExistingZoneNameSet.has(inputzone)) {
            $('#errorMSG').html('<span style="color:red;">*Error Zone ' + inputzone + ' Already Exists!!!</span>');
        } else {
            $('#errorMSG').html('');
        }
    }
    function trim(x) {
        return x.replace(/^\s+|\s+$/gm, '');
    }
    function showStorageTypeview(zoneid, ztypename) {
        $('#zoneNameq').html(ztypename);
        ajaxSubmitData('localsettigs/fetchzoneCellsfortreeview.htm', 'showtreeView', 'selectedzoneid=' + zoneid + '&selectedzone=' + ztypename + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        window.location = '#storageTypeAll';
        initDialog('registerSupplier');
    }

    function showTyped(id) {
        $('#storagetypelistcontent').html('');
        $.ajax({
            type: 'GET',
            cache: false,
            dataType: 'text',
            data: {zoneid: id, type: 1},
            url: "localsettigs/fetchstoragelistTypedorUntyped.htm",
            success: function (data) {
                var jsonData = JSON.parse(data);
                for (index in jsonData) {
                    var datax = jsonData[index];
                    var count = parseInt(index) + 1;
                    $('#storagetypelistcontent').append('<div class="row">' +
                            '<table><tr>' +
                            '<td>' + count + ').&nbsp;Cell Label:<strong class="text-success">' + datax.cell + '</strong></td></tr>' +
                            '<tr><td>&nbsp;Storage Type:<strong class="text-danger">' + datax.stypeName + '</strong></td>' +
                            '</tr>' +
                            '</table>' +
                            '</div><hr>');
                }
                var showdatax = $('#storagetypelistcontent').html();
                $.dialog({
                    title: 'Storage Typed Cells!',
                    content: '' + showdatax,
                    type: 'purple',
                    draggable: true
                });
            }
        });
    }
    function showUnTyped(id) {
        $('#storagetypelistcontent').html('');
        $.ajax({
            type: 'GET',
            cache: false,
            dataType: 'text',
            data: {zoneid: id, type: 2},
            url: "localsettigs/fetchstoragelistTypedorUntyped.htm",
            success: function (data) {
                var jsonData = JSON.parse(data);
                for (index in jsonData) {
                    var datax = jsonData[index];
                    var count = parseInt(index) + 1;
                    $('#storagetypelistcontent').append('<div>' +
                            '<table><tr>' +
                            '<td>' + count + ').&nbsp;Cell Label:<strong class="text-success">' + datax.cell + '</strong></td></tr>' +
                            '<tr><td>&nbsp;Storage Type:<strong class="text-danger"> Storage Type Missing</strong></td>' +
                            '</tr>' +
                            '</table>' +
                            '</div><hr>');
                }
                var showdatax = $('#storagetypelistcontent').html();
                $.dialog({
                    title: 'Storage Un-Typed Cells',
                    content: '' + showdatax,
                    type: 'purple',
                    draggable: true
                });
            }
        });
    }
    function deletezone(id, zonelabel) {
        $.confirm({
            title: 'Delete zone ' + zonelabel + '!',
            icon: 'fa fa-warning',
            content: 'Do you wish to continue?',
            type: 'red',
            buttons: {
                formSubmit: {
                    text: 'Yes',
                    btnClass: 'btn-danger',
                    action: function () {
                        $.ajax({
                            type: 'GET',
                            cache: false,
                            dataType: 'text',
                            data: {zoneid: id},
                            url: "localsettigs/deletezoneLabel.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                } else if (data === 'containsitems') {
                                    $.confirm({
                                        title: 'Error Deleting!',
                                        icon: 'fa fa-warning',
                                        content: '<strong class="text-success">' + zonelabel + '</strong> &nbsp; <span class="text-danger">already has Items cannot be Updated!!!</span>',
                                        type: 'red',
                                        buttons: {
                                            formSubmit: {
                                                text: 'OK',
                                                btnClass: 'btn-red',
                                                action: function () {
                                                },
                                            },
                                        }
                                    });
                                } else {
                                    $.toast({
                                        heading: 'Error',
                                        text: 'An unexpected error occured while trying to Deleting zone ' + zonelabel.toString().toUpperCase() + '.',
                                        icon: 'error'
                                    });
                                }
                            }
                        });
                    }
                },
                No: function () {
                }
            }
        });
    }
</script>