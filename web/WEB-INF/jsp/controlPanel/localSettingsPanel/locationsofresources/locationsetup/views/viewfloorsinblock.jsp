<%-- 
    Document   : viewfloorsinblock
    Created on : Jun 25, 2018, 11:22:10 AM
    Author     : RESEARCH
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <div class="row">
            <div class="col-md-6" id="enterFac">
                <div class="form-group">
                    <input class="form-control" id="buildingid" type="hidden" value="${buildingid}">
                    <input class="form-control" id="buildingname" type="hidden" value="${buildingname}">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label">Select Block:</label>
                    <div>
                        <select class="form-control myform" id="selectBlock" onchange="selectNewBlock()" name="selectblocks">
                            <option class="textbolders" value="0" onclick="viewAllFloors()">ALL</option>
                            <c:forEach items="${viewFloorsList}" var="b">
                                <option class="textbolder" value="${b.facilityblockid}">${b.blockname}</option>
                            </c:forEach>
                        </select>  
                    </div>
                </div>            
            </div>
        </div>
        <div class="tile">
            <div class="tile-body" id="filteredFloors">
                <fieldset>
                    <table class="table table-hover table-bordered" id="FloorTable">
                        <thead>
                            <tr>
                                <th class="center">No.</th>
                                <th class="center">Floor Name</th>
                                <th class="center">Edit Floor</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% int n = 1;%>
                            <% int d = 1;%>
                            <% int b = 1;%>
                            <% int t = 1;%>
                            <c:forEach items="${viewBlockFloorsList}" var="h">
                                <tr id="${h.blockfloorid}">
                                    <td class="center"><%=n++%></td>
                                    <td class="center">${h.floorname}</td>
                                    <td class="center">
                                        <a href="#!" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit" onclick="editflrname(${h.blockfloorid});" id="editbld<%=b++%>"><i class="fa fa-edit"></i></a>
                                    </td>
                                </tr> 
                            </c:forEach>
                        </tbody>
                    </table>
                </fieldset>
            </div>
        </div>
    </div>
</div>
<script>
    $('#FloorTable').DataTable();

    function selectNewBlock() {
        var facilityblockid = document.getElementById("selectBlock").value;
        var buildingid = $('#buildingid').val();
        var buildingname = $('#buildingname').val();

        console.log("--------------facilityblockid1111" + facilityblockid);
        ajaxSubmitData('locationofresources/viewfloors.htm', 'filteredFloors', 'facilityblockid=' + facilityblockid + '&buildingId=' + buildingid + '&buildingname=' + buildingname + '&nvb=0', 'GET');

    }

    function editflrname(value) {
        var tablerowid = $('#' + value).closest('tr').attr('id');
        var tableData = $('#' + tablerowid).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();

        $.confirm({
            title: 'Edit Floor Name!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Floor Name</label>' +
                    '<input oninput="checkfloornames();"  id="editedflrname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Room Name Here" class="name form-control myform" required />' +
                    '<input  id="editedblkrmid" type="hidden" value="' + tablerowid + '" placeholder="Please Enter Building Name Here" class="name myform form-control" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {

                        var name = this.$content.find('.name').val();
                        if (!name) {
                            $('#editedblkrmname').addClass('error');
                            $.alert('Please Enter Floor Name');
                            return false;
                        }
                        //var facilityblockid = $('#buildingid').val();
                        var floorid = $('#editedblkrmid').val();
                        var floorname = $('#editedblkrmname').val();

                        var data = {
                            // buildingid: buildingid,
                            floorid: floorid,
                            floorname: floorname

                        };

                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "locationofresources/Updateblockfloor.htm",
                            data: data,
                            success: function (response) {
                                window.location = '#close';
                                ajaxSubmitData('locationofresources/managebuilding.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }

                        });

                        $.alert('New Floor Name Is ' + name);
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

    function checkfloornames() {
        var blockid = $('#blockid').val();
        var floorname = $('#editedblkrmname').val();
        if (floorname.size > 0) {
            $.ajax({
                type: 'POST',
                data: {blockid: blockid, floorname: floorname},
                url: "locationofresources/checkEditedFloorNames.htm",
                success: function (data) {
                    console.log("-----data--------" + data)
                    if (data === 'existing') {
                        $('#editedblkrmname').addClass('error');
                        $.alert({
                            title: 'Alert!',
                            content: floorname + ' Already Exists',
                        });
                    } else {
                        $('#editedblkrmname').removeClass('error');
                    }
                }
            });
        }
    }
    function addroomstofloor(value) {

        var tableData = $('#' + value).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + value).closest('tr').attr('id');

        window.location = '#addFacBLKrooms';
        initDialog('supplierCatalogDialog');

        ajaxSubmitData('locationofresources/addthefloorroom.htm', 'levelroomcontents', 'tablerowid=' + tablerowid + '&tableData=' + tableData[1] + '&buildingid=${buildingid}&buildingname=${buildingname}&a=${blkid}&b=${blkname}' + '&nvb=0', 'GET');

    }

    function viewroomsinfloor(id, name) {

        ajaxSubmitData('locationofresources/viewFloorrooms.htm', 'viewblkrooms', 'act=a&floorId=' + id + '&floorName=' + name + '&a=${blkid}&b=${blkname}&c=${buildingid}&d=${buildingname}', 'GET');
    }

</script>
