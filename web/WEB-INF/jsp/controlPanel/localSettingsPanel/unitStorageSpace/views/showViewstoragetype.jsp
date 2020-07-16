<%-- 
    Document   : showViewstoragetype
    Created on : Jun 1, 2018, 4:16:06 PM
    Author     : user
--%>

<%@include file="../../../../include.jsp" %>
<div>
    <div class="row">
        <div class="col-md-12">
            <div class="btn-group pull-right">
                <button class="btn btn-primary" type="button" id="all" data-status="Add" data-name="" onclick="addorEditStoragetype(this.id, $(this).attr('data-status'), $(this).attr('data-name'))"><i class="fa fa-plus-circle"></i>&nbsp;Create Storage Type</button>
            </div>
        </div>
    </div><br>
    <fieldset>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body" id="changetableview">
                        <table class="table table-hover table-bordered" id="storetypezz">
                            <thead>
                                <tr>
                                    <th>No:</th>
                                    <th class="center">Storage Type</th>
                                    <th class="center">Cells Attached</th>
                                    <th class="center">Manage</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%int i = 1;%>
                                <c:forEach items="${storagespaceList}" var="cZ">
                                    <tr>
                                        <td data-label="No:"><%=i++%></td>  
                                        <td data-label="Storage Type">${cZ.stypeName}</td>                                                 
                                        <td data-label="Cells Attached" align="center"><button class="btn btn-sm btn-secondary btn-circle" id="${cZ.stypeid}" data-name="${cZ.stypeName}" onclick="showTypedxStorage(this.id, $(this).attr('data-name'))">${cZ.stypecount}</button></td>
                                        <td data-label="Manage" align="center">
                                      <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EDITSTORAGETYPE')">
                                        <a href="#" id="${cZ.stypeid}" data-status="Edit" data-name="${cZ.stypeName}" onclick="addorEditStoragetype(this.id, $(this).attr('data-status'), $(this).attr('data-name'))"><i class="fa fa-lg fa-edit"></i></a> 
                                      <!--a href="#"><i class="fa fa-lg fa-trash"></i></a-->
                                     </security:authorize>
                                      </td> 
                                    </tr>
                                <div class="hidedisplaycontent" id="show${cZ.stypeid}">
                                    <%int jk = 1;%>
                                    <ul class="list-group">
                                        <c:forEach items="${cZ.stypeCells}" var="k"> 
                                          <li class="list-group-item list-group-item-action"><%=jk++%>).&nbsp;${k.cellLabelx}</li>
                                        </c:forEach>                                        
                                    </ul>                                    
                                </div>                                    
                            </c:forEach>                       
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>  
</div>
<script>
    var ExistingStorageTypeSet = new Set();
    var ExistingStorageTypeSet2 = new Set();
    $(document).ready(function () {
        var jsonstoragetype = ${jsonstoragespaceList};
        for (var x in jsonstoragetype) {
            if (jsonstoragetype.hasOwnProperty(x)) {
                ExistingStorageTypeSet.add(jsonstoragetype[x].stypeName.split(' ')[0].toUpperCase());
                ExistingStorageTypeSet.add(jsonstoragetype[x].stypeName.toUpperCase());
            }
        }
        var jsonchecklabels = ${jsonchecklabelslist};
        if(jsonchecklabels.length > 0){
            for (var n in jsonchecklabels) {
                var zone= jsonchecklabels[n].zonelabel.toString().toUpperCase();
                var bay = jsonchecklabels[n].baylabel.toString().toUpperCase();
                var row = jsonchecklabels[n].rowlabel.toString().toUpperCase();
                var cell = jsonchecklabels[n].celllabel.toString().toUpperCase();
                if(ExistingStorageTypeSet2.has(zone) || ExistingStorageTypeSet2.has(bay) || ExistingStorageTypeSet2.has(row)|| ExistingStorageTypeSet2.has(cell)){
                }else{                
                    ExistingStorageTypeSet2.add(zone);
                    ExistingStorageTypeSet2.add(bay);
                    ExistingStorageTypeSet2.add(row);
                    ExistingStorageTypeSet2.add(cell);
                }
            }
        }
        $('#storetypezz').DataTable();
    });
    function addorEditStoragetype(id, status, selectedEditname) {
        $.confirm({
            title: '',
            type: 'purple',
            draggable: true,
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Storage Type</label>' +
                    '<div id="errormsgx"></div>' +
                    '<input type="text" placeholder="Storage Type" value="' + selectedEditname + '" class="name form-control" required id="storetypevalue" oninput="checkStorageType(this.id)"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: '' + status,
                    btnClass: 'btn-primary',
                    action: function () {
                        var name = this.$content.find('.name').val();
                        var inputstoreNamex = this.$content.find('.name').val().toUpperCase();
                        if (!name) {
                            $('#errormsgx').html('<strong class="text-danger">*Field Required.*</strong>');
                            document.getElementById('storetypevalue').style.borderColor = "red";
                            return false;
                        } else if (ExistingStorageTypeSet.has(trim(inputstoreNamex))) {
                            document.getElementById('storetypevalue').style.borderColor = "red";
                            $('#errormsgx').html('<span class="text-danger">*Error Storage Type ' + inputstoreNamex + ' Already Exists!!!</span>');
                            return false;
                        }else if(ExistingStorageTypeSet2.has(trim(inputstoreNamex))){
                                document.getElementById('storetypevalue').style.borderColor = "red";
                                $('#errormsgx').html('<span class="text-danger">*Error Zone Label,Bay Label ,Row Label and Cell Label cannot be a Storage Type!!!</span>');
                                return false;
                        }
                        var nameEdited = trim(name).charAt(0).toUpperCase() + trim(name).slice(1);
                        document.getElementById('storetypevalue').style.removeProperty('border');
                        if (id === 'all' && status === 'Add') {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {storageTypename: nameEdited, type: 1},
                                url: "localsettigs/addStoragetypeorEdit.htm",
                                success: function (data) {
                                    if (data === 'success') {
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Storage Type Created Successfully.',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'bottom-center'
                                        });
                                        ajaxSubmitData('localsettigs/storagetypeshow.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    } else {
                                        $.toast({
                                            heading: 'Error',
                                            text: 'An unexpected error occured while trying to add Storage Type.',
                                            icon: 'error'
                                        });
                                    }
                                }
                            });
                        } else {
                            if (trim(selectedEditname).toLowerCase() === trim(name).toLowerCase()) {
                                $('#errormsgx').html('<span class="text-danger">*Error Storage Type must be different!!!</span>');
                                return false;
                            } else if (ExistingStorageTypeSet.has(trim(inputstoreNamex))) {
                                document.getElementById('storetypevalue').style.borderColor = "red";
                                $('#errormsgx').html('<span class="text-danger">*Error Storage Type ' + inputstoreNamex + ' Already Exists!!!</span>');
                                return false;
                            }else if(ExistingStorageTypeSet2.has(trim(inputstoreNamex))){
                                document.getElementById('storetypevalue').style.borderColor = "red";
                                $('#errormsgx').html('<span class="text-danger">*Error Zone Label,Bay Label ,Row Label and Cell Label cannot be a Storage Type!!!</span>');
                                return false;
                            }
                            var dataEdit = [];
                            dataEdit.push({
                                stypename: nameEdited,
                                stypeid: id
                            });
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {storageTypename: JSON.stringify(dataEdit), type: 2},
                                url: "localsettigs/addStoragetypeorEdit.htm",
                                success: function (data) {
                                    if (data === 'success') {
                                        dataEdit = [];
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Storage Type Edited Successfully.',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'bottom-center'
                                        });
                                        ajaxSubmitData('localsettigs/storagetypeshow.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    } else {
                                        dataEdit = [];
                                        $.toast({
                                            heading: 'Error',
                                            text: 'An unexpected error occured while trying to Edit a Storage Type.',
                                            icon: 'error'
                                        });
                                    }
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
    function checkStorageType(id) {
        var inputstoreName = $('#' + id).val().toUpperCase();
        if (ExistingStorageTypeSet.has(trim(inputstoreName))) {
            $('#errormsgx').html('<span class="text-danger">*Error Storage Type ' + inputstoreName + ' Already Exists!!!</span>');
            document.getElementById(id).style.borderColor = "red";
        } else if(ExistingStorageTypeSet2.has(trim(inputstoreName))){
            document.getElementById('storetypevalue').style.borderColor = "red";
            $('#errormsgx').html('<span class="text-danger">*Error Zone Label,Bay Label ,Row Label and Cell Label cannot be a Storage Type!!!</span>');
            return false;
        }else {
            $('#errormsgx').html('');
            document.getElementById(id).style.removeProperty('border');
        }
    }
    function trim(x) {
        return x.replace(/^\s+|\s+$/gm, '');
    }
    function showTypedxStorage(id, name) {
        var datastore = $('#show' + id).html();
        $.dialog({
            title: 'Cells marked as <span style="color:green">' + name + '</span>',
            content: '' + datastore,
            type: 'purple',
            draggable: true
        });
    }
</script>