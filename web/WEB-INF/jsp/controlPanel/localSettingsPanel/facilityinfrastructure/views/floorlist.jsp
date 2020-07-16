<%-- 
    Document   : floorlist
    Created on : Sep 24, 2019, 8:18:09 AM
    Author     : USER 1
--%>



<%@include file = "../../../../include.jsp" %>
<style>
    body {
        font-family: 'Merriweather Sans', arial, verdana;
    }

    .locationsbreadcrumb  {
        /*centering*/
        display: inline-block;
        box-shadow: 0 0 15px 1px rgba(0, 0, 0, 0.35);
        overflow: hidden;
        border-radius: 5px;
        /*Lets add the numbers for each link using CSS counters. flag is the name of the counter. to be defined using counter-reset in the parent element of the links*/
        counter-reset: flag; 
    }

    .locationsbreadcrumb a {
        text-decoration: none;
        outline: none;
        display: block;
        float: left;
        font-size: 12px;
        line-height: 36px;
        color: white;
        /*need more margin on the left of links to accomodate the numbers*/
        padding: 0 10px 0 60px;
        background: #666;
        background: linear-gradient(#666, #333);
        position: relative;
    }
    /*since the first link does not have a triangle before it we can reduce the left padding to make it look consistent with other links*/
    .locationsbreadcrumb a:first-child {
        padding-left: 46px;
        border-radius: 5px 0 0 5px; /*to match with the parent's radius*/
    }
    .locationsbreadcrumb a:first-child:before {
        left: 14px;
    }
    .locationsbreadcrumb a:last-child {
        border-radius: 0 5px 5px 0; /*this was to prevent glitches on hover*/
        padding-right: 20px;
    }

    /*hover/active styles*/
    .locationsbreadcrumb a.active, .locationsbreadcrumb a:hover{
        background: #800080;
        background: linear-gradient(#800080, #800080);
    }
    .locationsbreadcrumb a.active:after, .locationsbreadcrumb a:hover:after {
        background: #800080;
        background: linear-gradient(135deg, #BA55D3, #000);
    }

    /*adding the arrows for the breadcrumbs using rotated pseudo elements*/
    .locationsbreadcrumb a:after {
        content: '';
        position: absolute;
        top: 0; 
        right: -18px; /*half of square's length*/
        /*same dimension as the line-height of .breadcrumb a */
        width: 36px; 
        height: 36px;
        /*as you see the rotated square takes a larger height. which makes it tough to position it properly. So we are going to scale it down so that the diagonals become equal to the line-height of the link. We scale it to 70.7% because if square's: 
        length = 1; diagonal = (1^2 + 1^2)^0.5 = 1.414 (pythagoras theorem)
        if diagonal required = 1; length = 1/1.414 = 0.707*/
        transform: scale(0.707) rotate(45deg);
        /*we need to prevent the arrows from getting buried under the next link*/
        z-index: 1;
        /*background same as links but the gradient will be rotated to compensate with the transform applied*/
        background: #666;
        background: linear-gradient(135deg, #666, #333);
        /*stylish arrow design using box shadow*/
        box-shadow: 
            2px -2px 0 2px rgba(0, 0, 0, 0.4), 
            3px -3px 0 2px rgba(255, 255, 255, 0.1);
        /*
                5px - for rounded arrows and 
                50px - to prevent hover glitches on the border created using shadows*/
        border-radius: 0 5px 0 50px;
    }
    /*we dont need an arrow after the last link*/
    .locationsbreadcrumb a:last-child:after {
        content: none;
    }
    /*we will use the :before element to show numbers*/
    .locationsbreadcrumb a:before {
        content: counter(flag);
        counter-increment: flag;
        /*some styles now*/
        border-radius: 100%;
        width: 20px;
        height: 20px;
        line-height: 20px;
        margin: 8px 0;
        position: absolute;
        top: 0;
        left: 30px;
        background: #444;
        background: linear-gradient(#444, #222);
        font-weight: bold;
    }


    .flat a, .flat a:after {
        background: white;
        color: black;
        transition: all 0.5s;
    }
    .flat a:before {
        background: white;
        color: white;
        box-shadow: 0 0 0 1px #ccc;
    }
    .flat a:hover, .flat a.active, 
    .flat a:hover:after, .flat a.active:after{
        background: #800080;

    }
</style>
<div class="row">
    <div class="col-md-12">
        <div class="form-group">
            <input class="form-control" id="buildingid" type="hidden" value="${buildingidz}">
            <input class="form-control" id="buildingname" type="hidden" value="${buildingname}">
        </div>
    </div>
</div>

<div class="tile">
    <div class="tile-body">
        <fieldset>
            <table class="table table-hover table-bordered col-md-12" id="blockTables">
                <thead>
                    <tr>
                        <th class="center">No</th>
                        <th class="center">Floor Name</th>
                        <th class="center">Rename Floor</th>
                    </tr>
                </thead>
                <tbody class="col-md-12" id="viewblocktable">
                    <% int i = 1;%>
                    <% int u = 1;%>
                    <% int x = 1;%>
                    <% int y = 1;%>
                    <% int j = 1;%>
                    <c:forEach items="${FloorsList}" var="a">
                        <tr id="${a.floorid}">
                            <td><%=i++%></td>
                            <td class="center">${a.floorname}</td>
                            <td class="center">    
                                <a  class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit" onclick="editfloor(${a.floorid});" ><i class="fa fa-edit"></i></a>
                            </td>
                        </tr>
                   
                </c:forEach>
                </tbody>
            </table> 
        </fieldset>
    </div>
</div>


<script>
    $('[data-toggle="popover"]').popover();
    $('#blockTables').DataTable();
  
    function editfloor(value) {
        var tableData = $('#' + value).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + value).closest('tr').attr('id');
        $('#floorid').val(value);
       
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
                    '<input  id="editedFloorname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Floor Name Here" class="name form-control myform" required  oninput="checkregexx(this);"/>' +
                    '<span id= "errorxx">'+
                    '</span>' +
                    '</div>'+
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                          var floorid = value;
                           var floorname = $('#editedFloorname').val();
                           if(floorname.trim().length ===0 || floorname ===undefined){
                             $('#errorxx').html('<span style="color:red">*Field Required.*</span>');
                            $('#editedFloorname').focus(); 
                            return false;
                           }
                           else{
                        $.ajax({
                            type: 'POST',
                            cache: false,
                            data: {floorid: floorid, floorname: floorname},
                            url: "facilityinfrastructure/updatefloor.htm",
                            success: function () {
                                 $.toast({
                                    heading: 'Success',
                                    text: 'Floor Updated Successfully.',
                                    icon: 'success',
                                    hideAfter: 2000,
                                    position: 'top-center'
                                });
                                updatefloordialog.close();
                              updatefloor(${buildingid});
                            
                           
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

    
    
    function checkregexx(obj){
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
</script>
