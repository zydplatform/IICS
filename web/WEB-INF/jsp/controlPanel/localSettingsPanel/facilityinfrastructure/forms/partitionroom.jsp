<%-- 
    Document   : partitionroom
    Created on : Sep 25, 2019, 7:53:41 AM
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

</style>
<div class="col-md-12">

    <div class="row">
        <div class="col-md-12">
            <form id="buildingentryform">
                <input class="form-control myform" id="floorid" type="hidden" value="${BuildingList.buildingname}" readonly="true">
                <input class="form-control myform" id="floorname" type="hidden" value="${BuildingList.buildingid}">
                <div class="form-group">
                    <label class="control-label">Select Floor:</label>

                    <select class="form-control myform" id="selectedfloors">
                        <c:forEach items="${floorlists}" var="r">               
                            <option value="${r.floorid}">${r.floorname}</option>         
                        </c:forEach>            
                    </select>
                </div>
                <div class="form-group">
                    <label class="control-label">Select Room to partition:</label>

                    <select class="form-control myform" id="partitionroom">

                    </select>
                </div>
                <div class="form-group">
                    <label class="control-label">Number Of Partitions</label>
                    <input class="form-control myform" id="roomnumbers" type="number" placeholder="Enter Number Of partitions" oninput="showroomlabels(this);">
                </div>
            </form>

            <div class="tile">
                <p class="tile-title">labels for new rooms in <span id = "roomlabelz"></span>  </p>
                <div id ="roomformz" style="overflow: auto; max-height: 100px; overflow-y: scroll;">


                </div>
            </div>
        </div>


    </div>
</div>

<script>

var partitionedroomlabels =[];
    $(document).ready(function () {
        $('#roomlabelz').html($('#selectedfloors option:selected').html());
        var floorid_floorname = document.getElementById('selectedfloors').value;
        var floorid = $('#selectedfloors option:selected').val();

        $.ajax({
            type: 'POST',
            url: 'facilityinfrastructure/loadrooms.htm',
            data: {floorid: floorid},
            success: function (data) {
                console.log(data);
                var res = JSON.parse(data);
                if (res !== '' && res.length > 0) {
                    $('#partitionroom').html('');
                    for (i in res) {
                        var newOption = new Option(res[i].roomname, res[i].roomid, false, false);
                        $('#partitionroom').append(newOption).trigger('change');
                    }
                }
            }
        });


    });




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
                    $('#partitionroom').html('');
                    for (i in res) {

                        var newOption = new Option(res[i].roomname, res[i].roomid, false, false);
                        $('#partitionroom').append(newOption).trigger('change');
                    }
                }

            }
        });



    });
    function showroomlabels(obj) {
        var roomnumber = $(obj).val();
        if (roomnumber > 5) {
            $.confirm({
                title: 'Info',
                content: 'Room number partition limit is 5',
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
        } else if(roomnumber ===null) {
            $('#roomformz').hide();

            }else{
                $('#roomformz').html('');
                for (var i = 1; i <= roomnumber; i++) {
                $('#roomformz').append(
                        '<label class="col-md-6">Partitioned room name: '+i+'</label>' +
                        '<input maxlength="10"  required type="text" id="part' + i + '"  class="col-md-6"  style="padding:10px;" onblur="collectroomlabels(this)"/><hr>');
                        $(obj).val('');          
            }
       
                
        }
        
        
    }
   
    function collectroomlabels(obj) {
        var roomnumber = $('#roomnumbers').val();
        var floorid = $('#selectedfloors option:selected').val();
        var roomx = $('#partitionroom option:selected').val();
        var roomname = $('#partitionroom option:selected').html();
            roomids.push({ 
                roomid:roomx,
                roomname: roomname
      
      
  });
//       for (var i = 1; i < roomnumber; i++){

        var partitionedroolabel = $(obj).val();
        roomarrayss.push({
            roomid: i,
            roomname:partitionedroolabel ,
            floorid: floorid
        });
       
        
        
//       }
    }

</script>