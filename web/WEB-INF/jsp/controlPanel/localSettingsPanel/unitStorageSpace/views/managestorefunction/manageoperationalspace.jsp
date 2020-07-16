<%-- 
    Document   : manageoperationalspace
    Created on : Apr 17, 2018, 8:17:13 AM
    Author     : IICSRemote
--%>

<%@include file="../../../../../include.jsp" %>
<div class="col-md-12" id="transactionload">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered" id="operationalfunctions">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Zone</th>
                                    <th>Transaction Limit</th>
                                    <th>Pick List Search</th>
                                </tr>
                            </thead>
                            <tbody id="tablex">
                                <%int i = 1;%>
                                <c:forEach items="${Zonespace}" var="a">
                                    <tr>
                                        <td><%=i++%></td>
                                        <td>${a.zoneName}</td>
                                        <td align="center"><button class="btn btn-sm btn-primary" id="${a.zoneid}" data-name="${a.zoneName}" onclick="getcellswithLimits(this.id, $(this).attr('data-name'))"><i class="fa fa-lg fa-dedent"></i></button></td>
                                        <!--<td  align="center"><a href="#" id="${a.CellLimit}" data-id="${a.zoneid}" data-id2="${a.zoneName}" onclick="cellLimitEdit($(this).attr('data-id2'), $(this).attr('id'), $(this).attr('data-id'))">${a.CellLimit}</a></td>--->
                                <span id="zoneid" style="display:none;">${a.zoneName},${a.zoneid}</span>
                               
                                <c:if test="${a.Searchlist == true}">                                            
                                    <td align="center">
                                 <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DENYZONEPICKLIST')">
            
                                        <a class="btn btn-sm btn-success ${a.zoneid}" id="${a.zoneid}"  data-id="${a.zoneName}" data-status="Allowed" onclick="searchstatusT(this.id, $(this).attr('data-id'))" href="#"><span id="schstatus${a.zoneid}">Allowed</span></a></td> 
                                </security:authorize>
                                </c:if>
                                <c:if test="${a.Searchlist == false}">
                                    <td align="center">
                                   <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DENYZONEPICKLIST')">
                                   <a class="btn btn-sm btn-danger ${a.zoneid}" id="${a.zoneid}"  data-id="${a.zoneName}" data-status="Denied" onclick="searchstatusF(this.id, $(this).attr('data-id'))" href="#"><span id="schstatus2${a.zoneid}">Denied</span></a></td> 
                                </security:authorize>
                                    </c:if>  
                                    
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
<!----START:---Important Donot modify or Remove--------->
<div class="hidedisplaycontent">
    <ul class="list-group">
        <span id="showcellscontent"></span>
    </ul>                                    
</div>
<!----END:---Important Donot modify or Remove--------->
<script>
    $(document).ready(function () {
        $('#operationalfunctions').DataTable();
    });
    function searchstatusT(zoneid, zonename) {
        var status = $('#schstatus' + zoneid).html();
        if (status === 'Allowed') {
            $.confirm({
                title: 'Message',
                icon: 'fa fa-warning',
                content: "Deny Pick List Search on Zone  " + zonename + "!",
                type: 'red',
                typeAnimated: true,
                buttons: {
                    Yes: {
                        text: 'Yes',
                        btnClass: 'btn-danger',
                        action: function () {
                            $('#schstatus' + zoneid).html('Denied');
                            var state = false;
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {searchstatus: state, zoneid: zoneid},
                                url: "localsettigs/updatesearchstatus.htm",
                                success: function (data, textStatus, jqXHR) {
                                    $('.' + zoneid).toggleClass('btn-success btn-danger');
                                }
                            });
                        }
                    },
                    No: function () {}
                }
            });
        } else if (status === 'Denied') {
            $.confirm({
                title: 'Message',
                icon: 'fa fa-info-circle',
                content: "Allow Pick List Search on Zone  " + zonename + "!",
                type: 'green',
                typeAnimated: true,
                buttons: {
                    Yes: {
                        text: 'Yes',
                        btnClass: 'btn-success',
                        action: function () {
                            $('#schstatus' + zoneid).html('Allowed');
                            var state = true;
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {searchstatus: state, zoneid: zoneid},
                                url: "localsettigs/updatesearchstatus.htm",
                                success: function (data, textStatus, jqXHR) {
                                    $('.' + zoneid).toggleClass('btn-danger btn-success');
                                }
                            });
                        }
                    },
                    No: function () {}
                }
            });
        }
    }
    function searchstatusF(zoneid, zonename) {
        var status = $('#schstatus2' + zoneid).html();
        if (status === 'Denied') {
            $.confirm({
                title: 'Message',
                icon: 'fa fa-info-circle',
                content: "Allow Pick List Search on Zone  " + zonename + "!",
                type: 'green',
                typeAnimated: true,
                buttons: {
                    Yes: {
                        text: 'Yes',
                        btnClass: 'btn-success',
                        action: function () {
                            $('#schstatus2' + zoneid).html('Allowed');
                            var state = true;
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {searchstatus: state, zoneid: zoneid},
                                url: "localsettigs/updatesearchstatus.htm",
                                success: function (data, textStatus, jqXHR) {
                                    $('.' + zoneid).toggleClass('btn-danger btn-success');
                                }
                            });

                        }
                    },
                    No: function () {}
                }
            });

        } else if (status === 'Allowed') {
            $.confirm({
                title: 'Message',
                icon: 'fa fa-warning',
                content: "Deny Pick List Search on Zone  " + zonename + "!",
                type: 'red',
                typeAnimated: true,
                buttons: {
                    Yes: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $('#schstatus2' + zoneid).html('Denied');
                            var state = false;
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {searchstatus: state, zoneid: zoneid},
                                url: "localsettigs/updatesearchstatus.htm",
                                success: function (data, textStatus, jqXHR) {
                                    $('.' + zoneid).toggleClass('btn-success btn-danger');
                                }
                            });
                        }
                    },
                    No: function () {}
                }
            });
        }
    }
    function cellLimitEdit(content) {
        var id = content.split(',**')[0];
        var cellLimit = content.split(',**')[1];
        var zonename = content.split(',**')[2];
        var zoneid =content.split(',**')[3];
        $.confirm({
            title: '',
            content: '' +
                    '<label>Update Transaction limit of <span style="color:green;">' + zonename + '<span> </label>' +
                    '<div id="msgerror1"></div>' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<input type="text" maxlength="3"  value="' + cellLimit + '" class="name form-control" required onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Update',
                    btnClass: 'btn-primary',
                    action: function () {
                        var inputcelllimt = this.$content.find('.name').val();
                        if (!inputcelllimt) {
                            $('#msgerror1').html('<span style="color:red;">*Error Field Empty!!!</span>');
                            return false;
                        } else if (parseInt(inputcelllimt) <= 0) {
                            $('#msgerror1').html('<span style="color:red;">*Error Enter a Valid Value!!!</span>');
                            return false;
                        }else if (parseInt(inputcelllimt) > 100) {
                            $('#msgerror1').html('<span class="text-danger">*Required value must be between [ 1-100 ]</span>');
                            return false;
                        }
                        //$.alert('Your name is ' + inputcelllimt);
                        //
                        $.ajax({
                            type: 'GET',
                            cache: false,
                            dataType: 'text',
                            data: {id: id, celllimit: inputcelllimt},
                            url: "localsettigs/updatecellLimit.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.toast({
                                        heading: 'Success',
                                        text: 'Transaction Limit Updated Successfully.',
                                        icon: 'success',
                                        hideAfter: 2000,
                                        position: 'bottom-center'
                                    });
                                    getcellswithLimits(zoneid, zonename);
                                    ajaxSubmitData('localsettigs/Operationalspace.htm', 'transactionload', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                } else {
                                    $.toast({
                                        heading: 'Error',
                                        text: 'An unexpected error occured while trying to Update Cell Transaction Limit.',
                                        icon: 'error'
                                    });
                                }
                            }
                        });
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
    function getcellswithLimits(id, zname) {
        $('#showcellscontent').html('');
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            data: {zoneid: id},
            url: "localsettigs/getcells.htm",
            success: function (data) {
                if (data.length !== 0) {
                    for (var x in data) {
                        var content = data[x];
                        x = parseInt(x) + 1;
                        $('#showcellscontent').append('<li class="list-group-item list-group-item-action">' + x + ').&nbsp;' + content.cellLabel + '<span class="pull-right"><b id="cellxxxp'+content.bayrowcellid + '">' + content.cellLmt + '</b>&nbsp;&nbsp;<i id="' + content.bayrowcellid + ',**' + content.cellLmt + ',**' + content.cellLabel + ',**'+id+'" onclick="cellLimitEdit(this.id)" class="fa fa-edit text-danger"></i></span></li>');
                    }
                    var datares = $('#showcellscontent').html();
                    $.dialog({
                        title: 'Cell Limits for zone&nbsp;<span class="text-success">' + zname + '</span>',
                        content: '' + datares,
                        type: 'purple',
                        draggable: true                        
                    });
                } else {
                    $.dialog({
                        title: 'Cell Limits for zone&nbsp;<span class="text-success">' + zname + '</span>',
                        content: '<strong class="text-danger">No cells with transactional Limit to display!!!!</strong>',
                        type: 'red',
                        icon: 'fa fa-warning',
                        draggable: true
                    });
                }
            }
        });
    }
</script>   