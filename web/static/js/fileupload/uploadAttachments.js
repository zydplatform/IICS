/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function uploadAttachment(url, uploadCategory, respField, fileInput) {
    var fileInput = document.getElementById('' + fileInput + '');
    var file = fileInput.files[0];
    var formData = new FormData();
    formData.append('file', file);
    formData.append('type', uploadCategory);
    $.ajax({
        url: url,
        data: formData,
        processData: false,
        contentType: false,
        type: 'POST',
        success: function (data) {
            $('#' + respField + '').val('true');
        },
        error: function (err) {
            alert(err);
            $('#' + respField + '').val('false');
        }
    });
}

