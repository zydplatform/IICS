<%-- 
    Document   : patientfilePages
    Created on : May 25, 2018, 3:49:17 PM
    Author     : IICS
--%>
<%-- 
    Document   : patientfilePages
    Created on : May 25, 2018, 3:49:17 PM
    Author     : IICS
--%>








<%@include file="../../../include.jsp"%>
<div class="row">
    <div class="col-md-12">
        <div class="btn-group pull-right">
           <a class=" btn btn-primary"style="margin-right:10px;color:white;" onclick="openFileScanDialog('${filelength}')">
                                            Scan File
           </a>
       </div>
</div>
</div><br>
<input type="hidden" col-md-3 value="${fileno}" name="fileNovalue"/>

<input type="hidden" col-md-3 value="${filelength}" name="filelengthValue"/>
<table class="table table-hover" id="documentRef">
    <thead>
        <tr>
        <tr>
            <th class="center"></th>
            <th class="center">Page Title</th>
             <th class="center">view details</th>
              <th class="center">open</th>
            <th class="center">Page No</th>
        </tr>
    </thead>
    <tbody>
        <% int p = 1;%>
        <c:forEach items="${filePages}" var="filePage">
            <tr>
               <td><%=p++%></td>
                <td style="color:#0099cc;"><a class="card-link" href="#">${filePage.description}</a></td>  
                 <td class="center">
                     <a data-date="${filePage.datecreated}" onclick="viewPageDetails($(this).attr('data-date'), '${filePage.staffdetails}','${filePage.documentid}', '${filePage.description}','${filelength}')" href="#">
                    <button class="btn btn-sm btn-secondary">
                    0</button></a>
                 </td>
                  <td class="center">
                     <a data-date="${filePage.datecreated}" onclick="openPages('${filePage.documentid}', '${filePage.description}',$(this).attr('data-date'),'${filelength}')" href="#">
                   <button class="btn btn-sm btn-primary">
                   0</button></a>
                 </td>
                <td class="center" style="width:30px;">${filePage.pageNo}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    var buttonText = "Next";
    var totalPages;
    var currentPageNumber = 0;
    var descriptionPage;
    var pageNameField;
    var filelengthValue=0;
    $(document).ready(function () {
        $('#documentRef').DataTable();
    });

    function viewPageDetails(datecreated,staffdetails,documentid,description,filelength) {


        $.confirm({
            title: 'More Details',
            content: '' +
                    '<form action="" class="formName"><hr/>' +
                    '<div class="form-group row">'+
                    '<label class="col-md-6">Created By: </label>' +
                    '<label class="col-md-6">' +  staffdetails + '</label>' +
                    '</div>' + 
                    '<label class="col-md-6">Created On: </label>' +
                    '<label class="col-md-6">' +datecreated  + '</label>' + '</div>' +
                    '<div class="form-group row">'+
                    '</form>',
            buttons: {
              close: function () {
                },
            }
        });
    }
     function openPages(documentid,description,datecreated,filelength) {
            showPageDetails('files/pagedetail.htm',documentid,description,datecreated,filelength, 'GET');
    }
    function openFileScanDialog(filelength) {
        $.confirm({
            title: 'Scan Document',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Page Title</label>' +
                    '<input type="text" id="pageNameField" class=" form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Number Of Pages</label>' +
                    '<input id="pageNumbers" type="number" min="1" max="20" class=" form-control" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Start',
                    btnClass: 'btn-primary',
                    action: function () {
                        pageNameField = $('#pageNameField').val();
                        totalPages = $('#pageNumbers').val();
                        currentPageNumber = 1;
                        filelengthValue=filelength;
                        var data = {filename: pageNameField, pageNumber: currentPageNumber, totalPages: totalPages,filelength:filelengthValue};
                        ajaxSubmitStartScanning('files/scandocumentorimage.htm', 'GET', data);
                    }
                },
                cancel: function () {
                    //close
                },
            },
            onContentReady: function () {
                $('#updateReturnDate').datepicker({
                    format: "dd/mm/yyyy",
                    autoclose: true
                });
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
    function openNextFileScanDialog(resp) {
        $.confirm({
            title: 'Scan File',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Description</label>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label >Number Of Pages Scanned: ' + resp + '</label>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: buttonText,
                    btnClass: 'btn-primary',
                    action: function () {
                        if (resp == totalPages - 1) {
                            buttonText = 'FINISH';
                           }
                        if (resp < totalPages) {
                            currentPageNumber = resp
                            currentPageNumber++;
                            filelengthValue++;
                            var data = {filename: pageNameField, pageNumber: currentPageNumber, totalPages: totalPages,filelength:filelengthValue};
                            ajaxSubmitStartScanning('files/scandocumentorimage.htm', 'GET', data);
                        }else{
                     fetchPatientFilePagesOrIssueOrViewUsers('files/pagelist.htm', 'patientFilePages', 'GET');
                     }
                    }
                },
                cancel: function () {
                    //close
                },
            },
            onContentReady: function () {
                if (totalPages === 1) {
                            buttonText = 'FINISH';
                     }
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


    function showPageDetails(Url, documentid, description, datecreated,filelength, method) {
        var data = {documentid: documentid, description: description, datecreated: datecreated,filelength:filelength};
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            timeout: 98000,
            success: function (resp) {
                    $.confirm({
                        title: '<h3><font color="purple">Patient File Pages</font></h3>',
                        content: '' +
                                '<div class="col-md-12">'+
                            '<div class="tile"><div class="tile-body">'+
                             '<div id="patientFilePages">'+resp+
                            '</div>'+
                            '</div></div>'+
                        '</div>',
                        columnClass: 'col-md-10 col-md-offset-1',
                        containerFluid: true, // this will add 'container-fluid' instead of 'container'
                 
            buttons: {
        Close: function () {
            //close
        },
    },
            });
                
            },
            error: function (jqXHR, error, errorThrown) {
                if (Url !== 'checkUserNotification.htm') {
                    if (jqXHR.status && jqXHR.status === 400) {
                        alert('Server returned an Error, contact admin');
                    } else if (error === "timeout") {
                        alert("Request timed out, contact admin");
                    } else {
                    alert("Something went wrong, contact system admin");
                    }
                }
            }
        });


    }
    function ajaxSubmitStartScanning(Url, method, data) {
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            success: function (resp) {
                openNextFileScanDialog(resp);
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
    function ajaxSubmitNewpage(Url, method) {
        doAjax();
    }
    function doAjax() {
// Get form
        var form = $('#fileUploadForm')[0];
        var data = new FormData(form);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: 'files/multipleFileUpload',
            data: data,
            processData: false, //prevent jQuery from automatically transforming the data into a query string
            contentType: false,
            cache: false,
            success: function (data) {
                alert(data);
            },
            error: function (e) {
                alert(e.responseText);
            }
        });
    }
</script>