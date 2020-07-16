<%@include file="../../../include.jsp"%>
<div class="col-md-12">
    <div class="bs-component">
          <div class="card">
              <div class="row card-header">
                <hr>  
                <h4 class="col-md-12 card-text text-center">${description}</h4>
               <hr>
               <br>
               <br>
                <h6 class="col-md-6 card-text text-muted pull-left" ><a class="card-link" href="#">Patient Name: ${pname}</a></h6>
                <h6 class="col-md-6 card-text  text-muted  pull-right"><a class="card-link" href="#">File Number: ${fileno}</a></h6>
              </div>
          <c:forEach items="${filePageDetailList}" var="filePageDetail">
               <div class="row">
                </div>
                <img id="img${filePageDetail.counter}" src="<c:url value="${filePageDetail.filename}" />" alt="Chania" style="margin:5px;"width="800" height="800"/>
           <div class="row">
                  <div class="col-md-4 pull-left card-footer text-muted"><a class="card-link" href="#">Created On: ${datecreated}</a></div>
                  <div class="col-md-4 pull-left card-footer text-muted">
                  <button class="btn btn-blue" type="button" onclick="updateScannedPage('${filePageDetail.filename}','${filePageDetail.pagenumber}','${fileno}','${filePageDetail.pageid}')"><i class="fa fa-edit" aria-hidden="true"></i></button>
                  <button class="btn btn-primary" type="button" onclick="rotateImgClockwise(${filePageDetail.counter})" style="margin-left:10px;"><i class="fa fa-repeat" aria-hidden="true"></i></button>
                  <button class="btn btn-success" type="button" onclick="rotateImgAntiClockwise(${filePageDetail.counter})"><i class="fa fa-undo" aria-hidden="true"></i></button></div>
                  <div class="col-md-4 pull-right card-footer text-muted"><a class="card-link" href="#">page: ${filePageDetail.pagenumber} of ${filelength}</a></div>
               </div>
           </c:forEach>
           </div>
    </div>
</div>
              
<script>
    var angle=0;
  function rotateImgClockwise(imageId){
     angle += 90
   $("#img"+imageId).css('transform', 'rotate('+angle+'deg)');
} 
  function rotateImgAntiClockwise(imageId){
  angle -= 90;
    $("#img"+imageId).css('transform', 'rotate('+angle+'deg)');
    } 
  function updateScannedPage(filename,pagenumber,fileno,pageid) {
                        var data = {filename: filename,fileno:fileno,pageNumber:pagenumber, pageid:pageid};
                        ajaxSubmitUpdateScanning('files/rescandocumentorimage.htm', 'GET', data);
                    
    }
        function ajaxSubmitUpdateScanning(Url, method, data) {
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            success: function (resp) {
                alert(resp);
            },
            error: function (jqXHR) {
                if (Url !== 'checkUserNotification.htm') {
                    if (jqXHR.status && jqXHR.status === 400) {
                        alert('Server returned an Error, contact admin');
                    }
                }
            }
        });
    }

</script>