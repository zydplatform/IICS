<%-- 
    Document   : manageroominfloor
    Created on : Aug 27, 2019, 12:13:16 PM
    Author     : USER 1
--%>

<%@include file= "../../../../include.jsp" %>

<style>
    .error
    {
        border:2px solid red;
    }
    .myform{
        width: 100% !important;
    }
    .select2-container{
        z-index: 999999999 !important;
    }
</style>
<div class="col-md-12">

    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <form id="buildingentryform">
                        <input class="form-control myform" id="floorid" type="hidden" value="${BuildingList.buildingname}" readonly="true">
                        <input class="form-control myform" id="floorname" type="hidden" value="${BuildingList.buildingid}">
                        <div class="form-group">
                            <label class="control-label">Select Floor:</label>

                            <select class="form-control myform select" id="selectedfloors">
                                <c:forEach items="${floorlists}" var="r">               
                                    <option value="${r.floorid}">${r.floorname}</option>         
                                </c:forEach>            
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Select rooms in <span id = "roomlabelz"></span> </label>
                            <select class="form-control select" id="enteredrooms" multiple="multiple"></select>
                        </div>
                        <div class="form-group">
                            <label class="control-label">New merged room label</label>
                            <input class="form-control myform"  id="mergedlabel" type="text" placeholder="Enter room name">
                        </div>
                    </form>

                </div>

            </div>
        </div>
    </div>
</div>

<script>


    $(document).ready(function () {
        $('#enteredrooms').select2();
        $('#roomlabelz').html($('#selectedfloors option:selected').html());
        var floorid_floorname = document.getElementById('selectedfloors').value;
        var floorid = $('#selectedfloors option:selected').val();

        $.ajax({
            type: 'POST',
            url: 'facilityinfrastructure/loadrooms.htm',
            data: {floorid: floorid},
            success: function (data) {
                console.log(data);
//                $('#enteredrooms').append(
//                        
//                        '<select class=" form-control">' +
//                        '<option value="">'+data+'</option>' +
//                        '</select>'
//
//                        );
                var res = JSON.parse(data);
                if (res !== '' && res.length > 0) {
                    $('#enteredrooms').html('');
                    for (i in res) {
//                                        $('#village').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename="' + res[i].village + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
//                                        $('#enteredrooms').append('<option class="classvillage" id="' + res[i].roomid + '" value="' + res[i].roomid + '" data-villagename="' + res[i].roomname + ' ">' + res[i].roomname + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
//                        $('#enteredrooms').append('<option id="' + res[i].roomid + '" value="' + res[i].roomid + '">' + res[i].roomname + '</option>');
                        var newOption = new Option(res[i].roomname, res[i].roomid, false, false);
                        $('#enteredrooms').append(newOption).trigger('change');
                    }
                }
            }
        });
    });





    //SAVING ROOMS 

    $('#selectedfloors').change(function () {
        $('#roomlabelz').html($('#selectedfloors option:selected').html());
        var floorid = $('#selectedfloors option:selected').val();


        $.ajax({
            type: 'POST',
            url: 'facilityinfrastructure/loadrooms.htm',
            data: {floorid: floorid},
            success: function (data) {
                console.log(data);
                var res = JSON.parse(data);
                if (res !== '' && res.length > 0) {
                    $('#enteredrooms').html('');
                    for (i in res) {
//                                        $('#village').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename="' + res[i].village + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
//                                        $('#enteredrooms').append('<option class="classvillage" id="' + res[i].roomid + '" value="' + res[i].roomid + '" data-villagename="' + res[i].roomname + ' ">' + res[i].roomname + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                        var newOption = new Option(res[i].roomname, res[i].roomid, false, false);
                        $('#enteredrooms').append(newOption).trigger('change');
                    }
                }

            }
        });

    });
    $('#mergedlabel').on('blur', function () {
        collectRoomIds();
    });
    function collectRoomIds() {
        var data = $('#enteredrooms').select2('data');
        var mergedroomname = $('#mergedlabel').val();
        var floorid = $('#selectedfloors option:selected').val();
         for (var i in data) {
            roomIds.push({
                    roomid:data[i].id});
           
        }
        if(mergedroomname.trim().length >0){
        roomarray.push({
            roomid: 1,
            mergedroomname: mergedroomname,
            floorid: floorid
        });
       
        
        } else {
            
            
        } 
    }
</script>