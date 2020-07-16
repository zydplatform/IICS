<%-- 
    Document   : dutiesTable
    Created on : Jul 31, 2019, 3:22:13 PM
    Author     : USER 1
--%>
<%@include file="../../../../include.jsp"%>
<div id="config_table">
    <div style="align:left">
        <!--    <button class="btn btn-primary icon-btn pull-left" id="saveConfiguration" onclick="savenewDuty();" data-caller="">
                                    <i class="fa fa-save"></i>Add New Duty
            </button>-->
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
            <i class="fa fa-save"></i>Add New Duty
        </button>
        <br>

    </div>
    <div >
        <table class="table table-hover  col-md-12" id="sampleTables">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Duties and responsibilities</th>
                    <th>Edit Duty</th>
                </tr>
            </thead>
            <tbody class="col-md-12" id="domaindesignation">
                <% int q = 1;%>
                <c:forEach items="${dutieslist}" var="ac">
                    <tr id="">
                        <td><%=q++%></td>
                        <td id="${ac.designationid}">${ac.duty}</td>   
                        <td class="center"><a href="#" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit" onclick="updateduty(${ac.designationid}, '${ac.duty}',${ac.dutyid})"><i class="fa fa-edit"></i></a>
                            <span class="btn btn-xs" style="background-color: red; color: white;" onclick="deleteduty(${ac.designationid}, ${ac.dutyid});"><i class="fa fa-fw fa-lg fa-times"></i></span>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add new Duty</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!--        <div id="editor">
                          <p>Hello World!</p>
                          <p>Some initial <strong>bold</strong> text</p>
                          <p><br></p>
                        </div>-->


                <form>
                    <input id="x" type="hidden" name="content">
                    <trix-editor input="x"></trix-editor>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="savenewDuty();">Save</button>
            </div>
        </div>
    </div>
</div>

<script>


//                  var quill = new Quill('#editor', {
//                    theme: 'snow'
//                  });

    $('#sampleTables').DataTable();
    function savenewDuty() {        
        var duty = $('#x').val();
        var designationid = ${designationid};
//
        if (duty === '') {
            $('#editor').css('border-color', '#ff0000');
            return false;
        }

        data = {
            designationid: designationid,
            duty: duty
        };        
        $.ajax({
            type: 'POST',
            data: data,
            url: 'postsandactivities/saveDuties.htm',
            success: function () {
                $('#exampleModal').hide();
                $('body').removeClass('modal-open');
                $('.modal-backdrop').remove();
                ajaxSubmitData('postsandactivities/fetchDuties.htm', 'config_table', 'designationid=' + designationid, 'GET');
            }
        });
    }

    function updateduty(designationid, duty, dutyid) {
        var data = {
            designationid: designationid,
            duty: duty,
            dutyid: dutyid
        };        
        $.ajax({
            data: data,
            type: 'GET',
            url: "postsandactivities/fetchupdateduty.htm",
            success: function (response) {                
                $.confirm({
                    icon: '',
                    title: 'Update Duty/Responsibility',
                    content: '' + response,
                    type: 'purple',
                    typeAnimated: true,
                    boxWidth: '45%',
                    useBootstrap: false,
                    onContentReady: function () {                        
                        this.$content.find('#dutyids').val(data.dutyid);
                        this.$content.find('#editDuty')[0].value = data.duty;
                        this.$content.find('trix-editor').children('div').children('strong').html(data.duty);
                    },
                    buttons: {
                        save: {
                            text: 'Save',
                            btnClass: 'btn btn-success',
                            action: function () {                                
                                var duty = this.$content.find('#editDuty').val().trim();
                                var dutyid = this.$content.find('#dutyids').val().trim();

                                if (duty === '') {
                                    this.$content.find('#editDuty').css('border-color', '#ff0000');
                                    return false;
                                }

                                data = {
                                    dutyid: dutyid,
                                    duty: duty,
                                };
                                $.ajax({
                                    type: 'GET',
                                    url: 'postsandactivities/updateDuty.htm',
                                    data: data,
                                    success: function () {
                                        ajaxSubmitData('postsandactivities/fetchDuties.htm', 'config_table', 'designationid=' + designationid, 'GET');
                                    }
                                });
                            }

                        },
                        cancel: {
                            text: 'Cancel',
                            btnClass: 'btn-purple',
                            action: function () {
                                $(this).prop('checked', false);
                            }
                        }
                    }
                });
            }
        });


    }


    function deleteduty(designationid, dutyid) {        
        $.confirm({
            icon: '',
            title: 'Are you sure you want ot delete this Duty?',
            content: '',
            type: 'purple',
            typeAnimated: true,
            boxWidth: '40%',
            useBootstrap: false,
            onContentReady: function () {

            },
            buttons: {
                save: {
                    text: 'Yes',
                    btnClass: 'btn btn-success',
                    action: function () {                        
                        $.ajax({
                            type: 'POST',
                            url: 'postsandactivities/deleteduty.htm',
                            data: {designationid: designationid, dutyid: dutyid},
                            success: function () {                                
                                ajaxSubmitData('postsandactivities/fetchDuties.htm', 'config_table', 'designationid=' + designationid, 'GET');
                            }
                        });
                    }

                },
                cancel: {
                    text: 'No',
                    btnClass: 'btn-purple',
                    action: function () {
                        $(this).prop('checked', false);
                    }
                }
            }
        });


    }

</script>
