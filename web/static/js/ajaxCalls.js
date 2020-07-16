/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var tagID = "";
var _data = "";
var arr = new Array();
var items = new Array();
var items2 = new Array();
var itemsStr = '';
var sampletxt = '';
var samplestate = false;
var orderid = 0;
var activebt = 0;
var xyz = 1;

function ajaxSubmitForm(Url, respDiv, formid) {
    popup(1, 0);
    var data = $('#' + formid).serialize();
    //alert(data);
    $.ajax({
        type: 'post',
        data: data,
        cache: false,
        url: Url,
        success: function (resp) {
            $('#' + respDiv).html(resp).trigger('create');
            popup(0, 0);
        }
    });
}

function ajaxSubmitId(Url, respDiv, id) {
    popup(1, 0);
    var data = 'id=' + id;
    $.ajax({
        type: 'post',
        data: data,
        cache: false,
        url: Url,
        success: function (resp) {
            $('#' + respDiv).html(resp).trigger('create');
            popup(0, 0);
        }
    });
}

function ajaxSubmitData(Url, respDiv, data, method) {
    popup(1, 0);
    $.ajax({
        type: method,
        data: data,
        cache: false,
        url: Url,
        timeout: 98000,
        success: function (resp) {
            $('#' + respDiv).html('').trigger('create');
            $('#' + respDiv).html(resp).trigger('create');
            popup(0, 0);
        },
        error: function (jqXHR, error, errorThrown) {
            //alert(jqXHR.status);
                if (jqXHR.status && jqXHR.status === 400) {
                    alert('Server returned an Error, contact admin');
                }
                else if (jqXHR.status && jqXHR.status === 404) {

                }
                else if (jqXHR.status && jqXHR.status === 500) {

                }
                else if (error === "timeout") {
                    alert("Request timed out, contact admin");
                } else {
                    alert("Something went wrong, contact system admin");
                }
                jQuery('#preloader').delay(1000).fadeOut('slow');
                $("#workPane").load("errorPage.htm?a="+jqXHR.status);
            popup(0, 0);
        }
    });
}

function ajaxSubmitDataNoLoader(Url, respDiv, data, method) {
    //    alert(data);    
    $.ajax({
        type: method,
        data: data,
        cache: false,
        url: Url,
        success: function (resp) {
            //alert(resp);
            $('#' + respDiv).html('').trigger('create');
            $('#' + respDiv).html(resp).trigger('create');
        },
        error: function (jqXHR, error, errorThrown) {
            popup(0, 0);
        }
    });
}

function ajaxSubmitSearch(Url, respDiv, data, method, id) {
    if ($('#' + id).val() == '') {
        document.getElementById(respDiv).innerHTML = "";
    } else {
        loadSearchIcon(id, 1);
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            success: function (resp) {
                $('#' + respDiv).html(resp).trigger('create');
                loadSearchIcon(id, 0);
            },
        error: function (jqXHR, error, errorThrown) {
            if(Url!== 'checkUserNotification.htm') {
                    if (jqXHR.status && jqXHR.status == 400) {
                        alert('Server returned an Error, contact admin');
                    } else if (error === "timeout") {
                        alert("Request timed out, contact admin");
                    } else {
                        alert("Something went wrong, contact system admin");
                    }
                }
            popup(0, 0);
        }
        });
    }
}



function ajaxSubmitSearch3(Url, respDiv, data, method, id) {
    //if($('#'+id).val() == ''){
    document.getElementById(respDiv).innerHTML = "";
    // } else{
    loadSearchIcon(id, 1);
    $.ajax({
        type: method,
        data: data,
        cache: false,
        url: Url,
        success: function (resp) {
            $('#' + respDiv).html(resp).trigger('create');
            loadSearchIcon(id, 0);
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        }
    });
    // }
}


function loadSearchIcon(id, r) {
    if (r == 1) {
        $('#' + id).css("background-image", "url(static/images/loadingsearch1.gif)");
    } else {
        $('#' + id).css("background-image", "url(static/images/searchimg.png)");
    }
}

//AJAX calls
//By Bwamie
var myDialog = '';

function showMeasurementsPopupxx(measurementDiv, title, width, height) {
    myDialog = dhtmlwindow.open('divbox', 'div', measurementDiv, title, 'width=' + width + ',' +
            'height=' + height + ',left=200px,top=150px,resize=1,scrolling=0,center=1');
}

function closeDialogDragable() {
    //    alert(myDialog);
    dhtmlwindow.close(myDialog);
}

function closeDialogDragable(id, Urlx) {
    popup(1, 0);
    var data = 'dcid=' + id;
    //alert(data);
    $.ajax({
        type: 'get',
        data: data,
        cache: false,
        url: Urlx,
        success: function (resp) {
            $('#PostDataTable').html(resp).trigger("create");
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        },
        complete: function (resp) {
            popup(0, 0);
        },
        dataType: 'html'
    });
    try {
    } catch (ex) {
        popup(0, 0);
        alert("Some error occured while processing.");
    }
    dhtmlwindow.close(myDialog);
}

function ajaxReqDialogForm(Url, data, title, method, msgDiv, respDiv, width, height) {
    try {
        popup(1, 0);
        $.ajax({
            type: method,
            data: data,
            cache: false,
            url: Url,
            success: function (resp) {
                //closeDialogDragable();
                //myDialog = '';
                if (myDialog != '') {
                    //alert(myDialog);
                    //closeDialogDragable();
                    $('#divBox').html("").trigger("create");
                }
                $('#' + respDiv).html("").trigger("create");
                $('#' + respDiv).html(resp).trigger("create");
            },
            complete: function (resp) {
                showMeasurementsPopupxx(respDiv, title, width, height);
                popup(0, 0);
            },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        },
            dataType: 'html'
        });
    } catch (ex) {
        popup(0, 0);
        alert("Some error occured while processing.");
    }
}

function ajaxSubmitDialogForm(Url, form, method, msgDiv, respDiv) {
    popup(1, 0);
    var data = $('#' + form).serialize();
    //            alert(data);

    $.ajax({
        type: method,
        data: data,
        cache: false,
        url: Url,
        success: function (resp) {
            $('#' + respDiv).html(resp).trigger("create");
        },
        complete: function (resp) {
            if (Url == 'savePostForm.htm') {
                var idx = $('#dcid').val();
                closeDialogDragable(idx, 'postsHome.htm');
            }
            if (Url == 'updateNewRole.htm') {
                //var idx = $('#selectDcat').val();
                //closeDialogDragable(idx, 'postsHome.htm');
            }
            if (Url == 'updateNewPrivilege.htm') {

            } else {
                dhtmlwindow.close(myDialog);
                //closeDialogDragable();
            }
            popup(0, 0);
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        },
        dataType: 'html'
    });
    try {
    } catch (ex) {
        popup(0, 0);
        alert("Some error occured while processing.");
    }
}

function ajaxReqPage(Url, msgDiv, respDiv) {
    popup(1, 0);
    var data = '';
    $.ajax({
        type: 'get',
        data: data,
        cache: false,
        url: Url,
        success: function (resp) {
            $('#' + respDiv).html(resp).trigger("create");
        },
        complete: function (resp) {
            popup(0, 0);
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        },
        dataType: 'html'
    });
    try {
    } catch (ex) {
        popup(0, 0);
        alert("Some error occured while processing.");
    }
}

function ajaxReqPageDialog2(Url, method, respDiv, data, dialogDiv) {
    popup(1, 0);
    $.ajax({
        type: method,
        data: data,
        cache: false,
        url: Url,
        success: function (resp) {
            $('#' + respDiv).html(resp).trigger("create");
        },
        complete: function (resp) {
            popup(1, dialogDiv);
            popup(0, 0);
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        },
        dataType: 'html'
    });
    try {
    } catch (ex) {
        popup(0, 0);
        alert("Some error occured while processing.");
    }
}

function ajaxReqPageWithData(Url, method, respDiv, data) {
    popup(1, 0);
    //          alert(data);
    $.ajax({
        type: method,
        data: data,
        cache: false,
        url: Url,
        success: function (resp) {
            $('#' + respDiv).html(resp).trigger("create");
        },
        complete: function (resp) {
            popup(0, 0);
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        },
        dataType: 'html'
    });
    try {
    } catch (ex) {
        popup(0, 0);
        alert("Some error occured while processing.");
    }
}


function ajaxReqPageWithData2(Url, method, respDiv, data) {
    popup(1, 0);
    //          alert(data);
    $.ajax({
        type: method,
        data: data,
        cache: false,
        url: Url,
        success: function (resp) {
            $('#' + respDiv).html(resp).trigger("create");
        },
        complete: function (resp) {
            popup(0, 0);
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        },
        dataType: 'html'
    });
    try {
    } catch (ex) {
        popup(0, 0);
        alert("Some error occured while processing.");
    }
}

function ajaxReqPageWithData(Url, method, respDiv, dcid, roleid) {
    popup(1, 0);
    //          alert(data);
    $.ajax({
        type: method,
        data: {
            dcfid: dcid,
            roleid: roleid
        },
        cache: false,
        url: Url,
        success: function (resp) {
            $('#' + respDiv).html(resp).trigger("create");
        },
        complete: function (resp) {
            popup(0, 0);
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        },
        dataType: 'html'
    });
    try {
    } catch (ex) {
        popup(0, 0);
        alert("Some error occured while processing.");
    }
}

function ajaxReqPageWithData2(Url, method, respDiv, data) {
    popup(1, 0);
    //              alert(data);
    $.ajax({
        type: method,
        data: data,
        cache: false,
        url: Url,
        success: function (resp) {
            $('#' + respDiv).html(resp).trigger("create");
        },
        complete: function (resp) {
            popup(0, 0);
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        },
        dataType: 'html'
    });
    try {
    } catch (ex) {
        popup(0, 0);
        alert("Some error occured while processing.");
    }
}
//AJAX Calls By Bwamie ends here


var refreshUrl = '';
var refreshData = '';
var refreshResDiv = '';


//***************OVERLAY****************
function ShowDialog(modal)
{
    $("#overlay").show();
    $("#dialog").fadeIn(300);

    if (modal)
    {
        $("#overlay").unbind("click");
    }
    else
    {
        $("#overlay").click(function (e)
        {
            HideDialog();
        });
    }
}

function HideDialog()
{
    $("#overlay").hide();
    $("#dialog").fadeOut(300);
}

function ajaxSubmitDataWithDialog(Url, data, method, popupSizeParam, headerText, secondPopup) {
    //alert(data);    
    var popupSizeParams = popupSizeParam;
    var true2Nd = secondPopup;
    var popupSizeParamArray = popupSizeParams.split(','); //array size 6
    popup(1, 0);
    $.ajax({
        type: method,
        data: data,
        cache: false,
        url: Url,
        success: function (resp) {
            popup(0, 0);
            //            ShowDialog(true);
            if (true2Nd) {
                openWithPopUpDispense(Url, headerText, popupSizeParamArray[0], popupSizeParamArray[1], popupSizeParamArray[2], popupSizeParamArray[3], popupSizeParamArray[4], popupSizeParamArray[5]);
            } else {
                openWithPopUp(Url, headerText, popupSizeParamArray[0], popupSizeParamArray[1], popupSizeParamArray[2], popupSizeParamArray[3], popupSizeParamArray[4], popupSizeParamArray[5]);
            }
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        }
    });
}

function validateB4Submit2(paramsx, params, Url, returnDiv, formID) {
    var params2 = params;
    var parameters = params2.split(',');

    var params2x = paramsx;
    var parametersx = params2x.split(',');

    if (params2.length > 0) {
        for (var i = 0; i < parameters.length; i++) {
            isEmptyField(parameters[i]);
        }
    }

    if (params2x.length > 0) {
        for (var ix = 0; ix < parametersx.length; ix++) {
            validateSelection(parametersx[ix], parametersx[ix] + 'x');
        }
    }

    if (!valError) {
        valError = false;
        $('#valError-pane').css('display', 'none');
        ajaxSubmitData(Url, returnDiv, $('#' + formID).serialize(), 'POST');
    } else {
        alert('Sorry, fields not filled correctly!');
        valError = false;
        return false;
    }
}

function validateOnchange(paramsx, params) {

    var params2 = params;
    var parameters = params2.split(',');

    var params2x = paramsx;
    var parametersx = params2x.split(',');

    if (params2.length > 0) {
        for (var i = 0; i < parameters.length; i++) {
            isEmptyField(parameters[i]);
        }
    }

    if (params2x.length > 0) {
        for (var ix = 0; ix < parametersx.length; ix++) {
            validateSelection(parametersx[ix], parametersx[ix] + 'x');
        }
    }

    if (!valError) {
        valError = false;
        $('#valError-pane').css('display', 'none');
    } else {
        valError = false;
        return false;
    }
}

function validateB4Submit() {
    isEmptyField('name');
    //{name: $('#name').val()}
    if (!valError) {
        valError = false;
        $('#valError-pane').css('display', 'none');
        ajaxSubmitData('saveSpecialcasetype.htm', 'successDiv', $('#addSpecialcasetype').serialize(), 'POST');
    } else {
        alert('Sorry, fields not filled correctly!');
        valError = false;
        return false;
    }
}


function ajaxSubmitJsonData(Url, respDiv, data, method, dataType) {
    //    alert(data);    
    popup(1, 0);
    $.ajax({
        type: method,
        dataType: dataType,
        data: data,
        url: Url,
        contentType: 'application/json',
        mimeType: 'application/json',
        success: function (resp) {
            alert(JSON.stringify(resp));
            $('#' + respDiv).html(JSON.stringify(resp)).trigger('create');
            popup(0, 0);
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        }
    });
}


function setOrder(a) {
    orderid = a;
}

function activateNow(count) {    
    var check = document.getElementById('sample' + count).checked;
    if (check) {
        samplestate = false;
        sampletxt = "";
    }
    if (check) {
        popupX(1, count);
    } else {
        popupX(1, count);
    }
}

function CheckDiscripancy2(field0, field, field2, req, rec) {
    var disc = req - rec;
    $(field).val(disc);
    $(field2).val(disc);
    if (disc > 0) {
        $(field).css('color', 'red');
    }

    if (disc < 0) {
        alert("Sorry, You can not verify more than what was dispatched.\nRe-enter correct value.");
        $(field0).val("");
        return false;
    }

    if (disc == 0) {
        $(field).css('color', 'blue');
    }
}

function activateNow(count) {
    var check = document.getElementById('sample' + count).checked;
    if (check) {
        samplestate = false;
        sampletxt = "";
    }
    if (check) {
        popupX(1, count);
    } else {
        popupX(1, count);
    }
}

function verifySelectedItem(Url, respDiv, stockid, count) {

    if (Url == 'externalOrderItemReturnForm.htm') {
        popup(1, 105);
        return false;
    }

    if ($('#cqtyr' + count).val() == 0 && $('#cqtyrr' + count).val() > 0) {
        alert("Can not verify Zero(0) Quantity.");
        return false;
    }

    if ($('#sampletxt' + count).val() == 'Click Sample and type Sampling report here.') {
        document.getElementById('sampletxt2r').innerHTML = "";
    }

    var data = 'stockid=' + stockid + '&descripacydel=' + $('#descripacydel' + count).val() + '&descripacydisp=' + $('#descripacydisp' + count).val() +
            '&sampled=' + document.getElementById('sample' + count).checked + '&sampletxt=' + $('#sampletxt' + count).val() +
            '&cqty=' + $('#cqtyr' + count).val();

    document.getElementById("MsgDivV").innerHTML = "";
    document.getElementById("MsgDivV").innerHTML = "Please Wait, Still Processing...";

    popup(1, 0);
    //popup(0, 103);
    $.ajax({
        type: 'post',
        data: data,
        cache: false,
        url: Url,
        success: function (resp) {
            //document.getElementById(respDiv).innerHTML = resp;
            // popup(0, 101);
            document.getElementById("MsgDivU").innerHTML = "";
            document.getElementById("RecieverDiv2").innerHTML = "";

            $('#RecieverDiv2').html("").trigger("create");
            $('#RecieverDiv2').html(resp).trigger("create");
        },
        complete: function (resp) {
            popup(0, 0);
            //popup(1, 103);
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        }
    });
}

function popupX(sw, count) {
    if (sw == 1) {
        document.getElementById('blackout' + count).style.visibility = 'visible';
        document.getElementById('divpopup' + count).style.visibility = 'visible';
        document.getElementById('blackout' + count).style.display = 'block';
        document.getElementById('divpopup' + count).style.display = 'block';
    } else {
        document.getElementById('blackout' + count).style.visibility = 'hidden';
        document.getElementById('divpopup' + count).style.visibility = 'hidden';
        document.getElementById('blackout' + count).style.display = 'none';
        document.getElementById('divpopup' + count).style.display = 'none';
    }
}

function returnItemsFunc(stockid1, itemcode, batchno, genericname, quantityordered, quantityreceived, expirydate, count) {
    this.stockid = stockid1;
    var qtyx = 0;
    if ($('#cqtyr' + count).val() != '') {
        qtyx = parseInt($('#cqtyr' + count).val());
    }
    document.getElementById('itemcode').innerHTML = itemcode
    document.getElementById('batchno').innerHTML = batchno;
    document.getElementById('expirydate').innerHTML = expirydate;
    document.getElementById('genericname').innerHTML = genericname;
    $('#quantityordered').val(quantityordered);
    $('#quantityreceived').val(quantityreceived);
    $('#descripacydel2r').val((parseInt(quantityordered) - parseInt(quantityreceived)) + 'U');
    $('#descripacydel3r').val((parseInt(quantityordered) - parseInt(quantityreceived)));
    //$('#descripacydisp2r').val(0);
    $('#cqty2r').val(qtyx);
    $('#descripacydisp2r').val($('#descripacydispr' + count).val());
    isClear = false;
    //popup(1, 123);
    //popup(0, 103);
}
function clearReturnForm() {
    clearField('reason2r');
    $('#quantityreturned2r').val('');
}

function sampleTxt(txt, a, count) {
    if (a == 0) {
        $('#' + txt).val('');
    }

    if (a == 1) {
        sampletxt = $('#' + txt).val();
        samplestate = document.getElementById('sample' + count).checked;
    }

    if (a == 2) {
        $('#' + txt).val(sampletxt);
        document.getElementById('sample' + count).checked = samplestate;
    }
}

function validateVerification(count) {
    if ($('#cqtyr' + count).val() == 0 && $('#cqtyrr' + count).val() > 0) {
        alert("Can not verify Zero(0) Quantity.");
        return false;
    }

    if ($('#sampletxt' + count).val() == 'Click Sample and type Sampling report here.') {
        document.getElementById('sampletxt2r').innerHTML = "";
    }
    return true;
}

function popup2(sw) {

    if (sw == 1) {
        // Show popup
        document.getElementById('blackout2').style.visibility = 'visible';
        document.getElementById('divpopup2').style.visibility = 'visible';
        document.getElementById('blackout2').style.display = 'block';
        document.getElementById('divpopup2').style.display = 'block';
    } else {
        // Hide popup
        document.getElementById('blackout2').style.visibility = 'hidden';
        document.getElementById('divpopup2').style.visibility = 'hidden';
        document.getElementById('blackout2').style.display = 'none';
        document.getElementById('divpopup2').style.display = 'none';
    }
}

function emptyDiv(div) {
    document.getElementById(div).innerHTML = "";
}

function fillDiv(div, msg) {
    document.getElementById(div).innerHTML = msg;
}

function ajaxReq(Url, respDiv) {
    popup(1, 0);
    $.ajax({
        type: 'post',
        data: 'data=' + 'hello',
        cache: false,
        url: Url,
        success: function (resp) {

            if (Url == 'bulkStorageTransitItems.htm') {
                //document.getElementById(respDiv).innerHTML = resp;
                $('#' + respDiv).html(resp).trigger("create");
                resetItems2();
            }

            if (Url == 'receiverAcceptanceVeificationForm.htm') {
                document.getElementById(respDiv).innerHTML = resp;
                emptyDiv("MsgDivX");
                popup2(0);
                popup3(1);


                // ajaxReqWithComplete('submitItems.htm', 'AjaxContent', items);
            }
            if (Url == 'receiverAcceptanceVeification.htm') {

                /**/
                for (var count = 0; count < items.length; count++) {
                    if (itemsStr != "") {
                        itemsStr = itemsStr + "|#$" + JSON.stringify(items[count]);
                    } else {
                        itemsStr = itemsStr + JSON.stringify(items[count]);
                    }
                }
                ajaxReqWithComplete('submitItems.htm', 'AjaxContent', items);
            }
            if (Url == 'verifiedExternalUnitOrders.htm') {
                $('#' + respDiv).html(resp).trigger("create");
            }

            if (Url == 'verifiedExternalOrders.htm') {
                $('#' + respDiv).html(resp).trigger("create");
            }

            if (Url == 'returnedExternalOrdersItems.htm' || Url == 'returnedExternalOrdersItems2.htm') {
                $('#' + respDiv).html(resp).trigger("create");
            }
            if (Url == 'releasedItems.htm') {
                $('#' + respDiv).html(resp).trigger("create");
            }
        },
        complete: function (resp) {
            popup(0, 0);
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        }
    });
}

function popup3(sw) {
    if (sw == 1) {
        // Show popup
        document.getElementById('blackout3').style.visibility = 'visible';
        document.getElementById('divpopup3').style.visibility = 'visible';
        document.getElementById('blackout3').style.display = 'block';
        document.getElementById('divpopup3').style.display = 'block';
    } else {
        // Hide popup
        document.getElementById('blackout3').style.visibility = 'hidden';
        document.getElementById('divpopup3').style.visibility = 'hidden';
        document.getElementById('blackout3').style.display = 'none';
        document.getElementById('divpopup3').style.display = 'none';
    }
}

function changeQty(c) {
    if (parseInt(($('#quantityverified' + c).val() - $('#quantity' + c).val())) < 0) {
        alert("Quantity entered great than available.");
        $('#quantity' + c).val("");
        $('#' + c + 'toissue').attr('checked', 'false');
        return false;
    } else {
        $('#newbalance' + c).val($('#quantityverified' + c).val() - $('#quantity' + c).val());
        $('#' + c + 'toissue').attr('checked', 'true');

    }
}

function showHideButton(size) {
    var siz = size;
    var count = 0;
    for (var i = 1; i <= siz; i++) {
//        if (i == 1) {
//            count = 0;
//        }
        if (document.getElementById(i+'toissue').checked) {//if ($('#' + i + 'toissue').prop('checked')) {
            //count = true;
            count += 1;
            
            //break;
        } else if (!document.getElementById(i+'toissue').checked) {
            //alert('Subtracted');
            if(count>0)
            count -= 1;
        
            //count = false;
        }
    }
    //alert(count);
    if (count===siz) {
        
        $('#releaseBtn').css("display", "inline");
        //$('#releaseBtn2').css("display", "inline");
    } else {        
        
        $('#releaseBtn').css("display", "none");
        //$('#releaseBtn2').css("display", "none");
    }
}
function showHideButton2(size) {
    var siz = $('#counts').val();//size;
    var checks = $('#checks').val();
    var count = $('#checksCount').val();
//    alert(checks+"~~"+count+" AND "+siz);
//    for (var i = 1; i <= siz; i++) {        
//        if (document.getElementById('cellidfordelete'+i).checked) {//if ($('#cellidfordelete' + i).prop('checked')) {            
//            count += 1;
//        } else if (!document.getElementById('cellidfordelete'+i).checked) {
//            if(count>0)
//            count -= 1;
//        }
//    }
    //alert(count);
    if (count===siz) {
        $('#serviceOrder').css("display", "inline");
        //$('#releaseBtn2').css("display", "inline");
    } else {  
        $('#serviceOrder').css("display", "none");
        //$('#releaseBtn2').css("display", "none");
    }
}
function activateNowX(count) {
    //stockid, itemcode, batchno, expirydate, description, uom, quantity, 
    if ($('#quantity' + count).val() == "") {
        //alert("Empty Quantity Field.\nYou must fill in the quantity to issue before adding item to handover list.");
        document.getElementById(count + 'toissue').checked = false;
        return false;
    }
    var index = 0;
    var check = document.getElementById(count + 'toissue').checked;
//    if($('#quantity' + count).val() == 0) {
//        var iszero = confirm('Are you sure Quantity released for: ' + $('#genericname' + count).val() + "(Batch: " + $('#batchno' + count).val() + ") is: " + $('#quantityverified' + count).val());
//        if (!iszero) {
//            return false;
//        }
//    }
    if (check) {
        //alert(count + " :" + $('#itemcode'+count).val());
        document.getElementById('quantity' + count).disabled = false;
        //document.getElementById('descripancy' + count).disabled = false;
        //document.getElementById('approve' + count).disabled = false;
        if (addToArray(arr, $('#' + count + 'toissue').val() + '#' + count))
            var ct = false;

        for (var x = 0; x < items.length; x++) {
            index = x;
            if (items[x].count == count) {
                ct = true;
                break;
            } else {
                ct = false;
            }
        }
        if (!ct) {
            //alert('Added New Item');            
            items[items.length] = {
                stockid: $('#stockid' + count).val(),
                itemcode: $('#itemcode' + count).val(),
                batchno: $('#batchno' + count).val(),
                expirydate: $('#expirydate' + count).val(),
                description: $('#genericname' + count).val(),
                uom: $('#uom' + count).val(),
                quantity: $('#quantity' + count).val(),
                count: count,
                quantityverified: $('#quantityverified' + count).val()
            };
        } else {
            //alert('Updated Old Item');
            items[index].quantity = $('#quantity' + count).val();
        }
    } else {
        $('#' + 'newbalance' + count).val($('#' + 'quantityverified' + count).val());
        $('#' + 'quantity' + count).val("");
        $('#' + 'descripancy' + count).val("");
//        items.remove(index);
        items.splice(index, 1);
    }

//    if (!check) {
//        $('#' + 'newbalance' + count).val($('#' + 'quantityverified' + count).val());
//        for (var x = 0; x < items.length; x++) {
//            if (items[x].count == count) {
//                items.remove(x);
//            }
//        }
//    }
    showBtn();
}

function resetItems() {
    for (var x = items.length; x > 0; x--) {
        items.splice(0, 1);
    }
    items = new Array();
    showBtn();
}

function resetItems2() {
    items = new Array();
}

function updateItems(count) {
    for (var x = 0; x < items.length; x++) {
        if (items[x].count == count) {
            items[x].quantity = $('#quantity' + count).val();
        }
    }
}

function numericFilter(txb) {
    txb.value = txb.value.replace(/[^\0-9]/ig, "");
}

function setOrder(a) {
    orderid = a;
}

function addToArray(arr, elt) {
    var ln = arr.length;
    arr[ln] = elt;
    //alert(arr[arr.length - 1]);
    return true;
}

function sendJson(Url) {
    popup(1, 0);
    if (items.length < 1) {
        alert("Atleast one item must be selected before proceeding.");
        popup(0, 0);
        return false;
    }

    var itemsStr = "";
    for (var count = 0; count < items.length; count++) {
        if (itemsStr != "") {
            itemsStr = itemsStr + "|#$" + JSON.stringify(items[count]);
        } else {
            itemsStr = itemsStr + JSON.stringify(items[count]);
        }
    }

    if (Url == 'releaseItems.htm') {
        //popup(0, 106);
        itemsStr = "";
        for (var count = 0; count < items.length; count++) {
            items2[items2.length] = {stockid: items[count].stockid, itemcode: items[count].itemcode, batchno: items[count].batchno, expirydate: items[count].expirydate, quantity: items[count].quantity, count: items[count].count, quantityverified: items[count].quantityverified};
        }

        for (var count = 0; count < items2.length; count++) {
            if (itemsStr != "") {
                itemsStr = itemsStr + "|#$" + JSON.stringify(items2[count]);
            } else {
                itemsStr = itemsStr + JSON.stringify(items2[count]);
            }
        }
    }

    ajaxSubmitData(Url, 'itemsDIV', {itemsStr: itemsStr, fuid: $('#fuid').val(), source: $('#source').val()}, 'POST');
    items.splice(0, items.length);
    items2.splice(0, items2.length);
    itemsStr = '';
//    $.ajax({
//        type: 'post',
//        data: {itemsStr: itemsStr, fuid: $('#fuid').val(), source: $('#source').val()},
//        cache: false,
//        url: Url,
//        success: function (resp) {
//            if (Url == 'releaseItems.htm') {
//                popup(0, 106);
//                $('#TempDiv').html("").trigger("create");
//                $('#ItemsToRelease').html(resp).trigger("create");
//                showReleasedItemsTable();
//                var z = $('#IssuedItemsTable').css('height');
//                z = z.replace(/\D/g, '');
//                var n = (parseInt(z) + 130) + 'px';
//                $('#ModifiedDix').css("height", z + 'px');
//                $('#ReleasedItemsDiv').css("height", z + 'px');
//                $('#ParentDiv').css("height", n);
//                document.getElementById('IssuingItemsH1').innerHTML = "Successfully Released Items:";
//            }
//            else {
//                //alert("Hello");
//            }
//        },
//        complete: function (resp) {
//            popup(0, 0);
//        }
//    });

}

function showItemsToRelease() {

    if (items.length == 0) {
        alert("No selected items yet.");
        return false;
    }

    var txt = document.getElementById("IssuedItems");
    txt.innerHTML =
            '<div style="width: 90%" id="tablewrapper">'
            + '<table id="IssuedItemsTable" class="tinytable" width="100%">'
            + '<thead>'
            + '<tr valign="top">'
            + '<th><h3>No</h3></th>'
            + '<th><h3>Item Code:</h3></th>'
            + '<th><h3>Batch No</h3></th>'
            + '<th><h3>Expiry Date</h3></th>'
            + '<th><h3>Description</h3></th>'
            + '<th><h3>Remaining Balance</h3></th>'
            + '<th><h3>Picked Quantity</h3></th>'
            + '</tr>'
            + '<thead>'
            + '<tbody>'
            + '</tbody>'
            + '</table>'
            + '</div>';
    //Loop thru JSON items object.
    $.each(items, function (i, item) {
        if (item.quantity > 0) {
            addRow(item.stockid, item.itemcode, item.batchno, item.expirydate, item.description, item.quantityverified, item.quantity);
        }
    });
    $('.OddTr').css("background", "#EFEFEF");
    $('.EvenTr').css("background", "#E5E5E5");
    $('.EvenTr').bind("mouseover", function () {
        var color = $(this).css("background-color");
        $(this).css("background", "#F5A9BC");
        $(this).bind("mouseout", function () {
            $(this).css("background", color);
        })
    })

    $('.OddTr').bind("mouseover", function () {
        var color = $(this).css("background-color");
        $(this).css("background", "#F5A9BC");
        $(this).bind("mouseout", function () {
            $(this).css("background", color);
        })
    })
}

popup(1, 106);
initSorterTableId('IssuedItemsTable');
function showItemsToRelease2(msg) {
    if (items.length == 0) {
        alert("No selected items yet.");
        return false;
    }
    openWithPopUp('displayItemsForRelease.htm?x=' + items, msg, 1400, 600, 50, 50, 1, 1);
}

function ajaxReq(Url, respDiv) {
    popup(1, 0);
    $.ajax({
        type: 'post',
        data: 'data=' + 'hello',
        cache: false,
        url: Url,
        success: function (resp) {

            if (Url == 'bulkStorageTransitItems.htm') {
                //document.getElementById(respDiv).innerHTML = resp;
                $('#' + respDiv).html(resp).trigger("create");
                resetItems2();
            }

            if (Url == 'receiverAcceptanceVeificationForm.htm') {
                document.getElementById(respDiv).innerHTML = resp;
                emptyDiv("MsgDivX");
                popup2(0);
                popup3(1);
                // ajaxReqWithComplete('submitItems.htm', 'AjaxContent', items);
            }
            if (Url == 'receiverAcceptanceVeification.htm') {

                /**/
                for (var count = 0; count < items.length; count++) {
                    if (itemsStr != "") {
                        itemsStr = itemsStr + "|#$" + JSON.stringify(items[count]);
                    } else {
                        itemsStr = itemsStr + JSON.stringify(items[count]);
                    }
                }
                ajaxReqWithComplete('submitItems.htm', 'AjaxContent', items);
            }
            if (Url == 'verifiedExternalUnitOrders.htm') {
                $('#' + respDiv).html(resp).trigger("create");
            }

            if (Url == 'verifiedExternalOrders.htm') {
                $('#' + respDiv).html(resp).trigger("create");
            }

            if (Url == 'returnedExternalOrdersItems.htm' || Url == 'returnedExternalOrdersItems2.htm') {
                $('#' + respDiv).html(resp).trigger("create");
            }
            if (Url == 'releasedItems.htm') {
                $('#' + respDiv).html(resp).trigger("create");
            }
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        },
        complete: function (resp) {
            popup(0, 0);
        }
    });
}

function ajaxReqWithComplete(Url, respDiv, items) {
    popup(1, 0);
    $.ajax({
        type: 'post',
        data: 'items=' + items,
        cache: false,
        url: Url,
        success: function (resp) {
            document.getElementById(respDiv).innerHTML = resp;
            if (Url == 'bulkStorageTransitItems.htm') {
                alert("XXXXXXXXXXXXX2");
                //loadItems(); 
            }

            if (Url == 'authenticateIssuing.htm') {
                //alert(items);
                popup2(1);
            }

            if (Url == 'witnessItemsVerification.htm') {
                document.getElementById('DialogHeader').innerHTML = 'Verification Process: ';
                document.getElementById('RespiratoryExamination').style.display = 'block';
                document.getElementById('RespiratoryExamination').style.position = 'absolute';
                //RespiratoryExamination
                alert("shf wsf");
            }

            if (Url == 'submitItems.htm') {
                popup3(0);
            }


        },
        complete: function (resp) {
            popup(0, 0);
        },
        error: function (jqXHR, error, errorThrown) {
            if (jqXHR.status && jqXHR.status == 400) {
                alert('Server returned an Error, contact admin');
            }else if (error === "timeout") {
                alert("Request timed out, contact admin");
            } else {
//                alert("Something went wrong, contact system admin");                
            }
            popup(0, 0);
        }
    });
}

//function loadItems() {
//    var x = 0;
//            < c:forEach items = "${model.itemsL}"  var = "items" varStatus = "status" begin = "0" end = "${model.size}" >
//            items[x] = {stockid: "${items.stockid}", itemcode: "${items.itemcode}", desc: "${items.description}", batchno: "${items.batchno}", expirydate: "${items.expirydate}", quantity: "${items.quantityverified}", quantityissue: "", descripancy: ""};
//    x = x + 1;
//    alert(items.length);
//            < /c:forEach>             
//}
//
//function loadItems() {
//    var x = 0;
//            < c:forEach items = "${model.itemsL}"  var = "items" varStatus = "status" begin = "0" end = "${model.size}" >
//            items[x] = {stockid: "${items.stockid}", itemcode: "${items.itemcode}", desc: "${items.description}", batchno: "${items.batchno}", expirydate: "${items.expirydate}", quantity: "${items.quantityverified}", quantityissue: "", descripancy: ""};
//    x = x + 1;
//    alert(items.length);
//            < /c:forEach>            
//}


function addToJson(a, b, c) {
    $('#newbalance' + a).val(c - b);
    if ((c - b) < 0) {
        alert('You exceeded available items, input must not be greater than ' + items[x].quantity + '. Correct your input!');
        $('#quantity' + a).val('');
        return true;
    }
}

function showBtn() {
    if (items.length > 0) {
        $('#releaseBtn').css("display", "inline-table");
    } else {
        $('#releaseBtn').css("display", "none");
    }
}

function addRow(stockid, itemcode, batchno, expirydate, description, quantityverified, quantityissued) {

    var table = document.getElementById('IssuedItemsTable');
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
    if (rowCount % 2 == 0) {
        row.setAttribute('class', 'EvenTr');
    } else {
        row.setAttribute('class', 'OddTr');
    }
    row.setAttribute('id', rowCount - 1);
    //Cell 1
    var cell1 = row.insertCell(0);
    cell1.innerHTML = rowCount;
    //Cell2
    var cell2 = row.insertCell(1);
    cell2.innerHTML = '<div align="right">' + itemcode + '</div>';
    //Cell3
    var cell3 = row.insertCell(2);
    cell3.innerHTML = '<div align="right">' + batchno + '</div>';
    //Cell4
    var cell4 = row.insertCell(3);
    cell4.innerHTML = '<div align="right">' + expirydate + '</div>';
    //Cell5
    var cell5 = row.insertCell(4);
    cell5.innerHTML = description;
    //Cell6
    var cell6 = row.insertCell(5);
    cell6.innerHTML = '<div align="right">' + (quantityverified - quantityissued) + '</div>';
    //Cell7
    var cell7 = row.insertCell(6);
    cell7.innerHTML = '<div align="right">' + quantityissued + '</div>';
}

var showbat = true;
function setMissmatch(itemid, toShowDiv, toHideDiv) {
    $('#' + toShowDiv).css('display', 'inline');
    $('#submitButton').css('display', 'inline');
    //$('#'+toHideDiv).css('display', 'none');
//    if (t == 'batch' && showBat) {
//        $('#batchDiv').css('display', 'inline');
//        showBat = false;
//    } else {
//        $('#batchDiv').css('display', 'none');
//        showBat = true;
//    }
}

function validateExpiryDate() {
    var today = new Date();

    var textfieldDate = document.getElementById('expiry123').value;
    var tokenizedDate = new Array();
    tokenizedDate = textfieldDate.split('-');
//        alert('todaymonth= '+(today.getMonth()+1)+' todayDay= '+today.getDate()+' todayYear '+today.getFullYear());
//        alert('month= '+tokenizedDate[0]+' Day= '+tokenizedDate[1]+' Year '+tokenizedDate[2]);
//        alert('todays date='+today);
    // alert('textfieldDate= '+textFieldDate +' todays date='+dd);
    if (tokenizedDate[2] < today.getFullYear()) {
        alert("Entered year can not be less than current year");
        document.getElementById('expiry123').value = null;
    } else if (tokenizedDate[2] == today.getFullYear() && tokenizedDate[0] == (today.getMonth() + 1) && tokenizedDate[1] < today.getDate()) {
        alert("Invalid Expiry Date");
        document.getElementById('expiry123').value = null;
    } else if (tokenizedDate[2] == today.getFullYear() && tokenizedDate[0] < (today.getMonth() + 1) && tokenizedDate[1] < today.getDate()) {
        alert("Invalid Expiry Date");
        document.getElementById('expiry123').value = null;
    } else if (tokenizedDate[2] == today.getFullYear() && tokenizedDate[0] < (today.getMonth() + 1) && tokenizedDate[1] == today.getDate()) {
        alert("Invalid Expiry Date");
        document.getElementById('expiry123').value = null;
    }
}

function enableVerify() {
    if (document.getElementById('verify2r').checked) {
        $('#ShowVerify').css("display", 'inline');
        $('#divpopup105').css("margin-left", '-425px');
        document.getElementById('sampletxt2r').innerHTML = "Click Sample and type Sampling report here.";
    } else {
        $('#ShowVerify').css("display", 'none');
        $('#divpopup105').css("margin-left", '-280px');
        document.getElementById('sampletxt2r').innerHTML = "Click Sample and type Sampling report here.";
    }
}

function enableSample() {

    if (document.getElementById('sampled2r').checked) {
        $("#sampletxt2r").removeAttr("disabled");
        document.getElementById('sampletxt2r').innerHTML = '';
    }

    if (!document.getElementById('sampled2r').checked) {
        $("#sampletxt2r").attr("disabled", true);
    }
    //
}

function checkVerifiedQty(elt) {
    var Qty = parseInt($('#quantityreceived').val());
    var QtyV = 0;
    var QtyR = 0;

    if ($('#cqty2r').val() == "") {
        QtyV = 0;
    } else {
        QtyV = parseInt($('#cqty2r').val());
    }
    if ($('#quantityreturned2r').val() == "") {
        QtyR = 0;
    } else {
        QtyR = parseInt($('#quantityreturned2r').val());
    }

    if (Qty < (QtyR + QtyV)) {
        alert("Quantity exceeded valid quantity.\n" + "Quantity Verified plus Quantity Returned must not exceed " + Qty);
        $('#' + elt).val("");
    } else {
        $('#descripacydisp2r').val(Qty - (QtyR + QtyV));
    }
}

function selectReason() {

    if ($('#reasonA').val() == 1 || $('#reasonA').val() == 4 || $('#reasonA').val() == 6) {
        $("#reason2r").attr("disabled", false);
        document.getElementById('reason2r').innerHTML = "Type reason for returning item(s) here.";
        $('#reason2r').css("background", "#FFFFFF");

    } else {
        $("#reason2r").attr("disabled", true);
        document.getElementById('reason2r').innerHTML = "";
        $('#reason2r').css("background", "#EFEFEF");
        $('#reason2r').val("");
    }
}

function sendForm(Url, respDiv, val) {
    if ($('#reasonA').val() == 0) {
        alert("Select reason for returning items before saving.");
        return false;
    }

    if ($('#quantityreturned2r').val() == '' || $('#quantityreturned2r').val()<1) {
        alert("Enter Quantity of returned items first before saving.");
        return false;
    }

    var data = "";
    if ($('#reasonA').val() == 1 || $('#reasonA').val() == 4 || $('#reasonA').val() == 6) {
        $("#reason2r").attr("disabled", false);
        document.getElementById('reason2r').innerHTML = "Type reason for returning item(s) here.";
    }
    if (Url == 'externalOrderItemReturn.htm') {        
        if ($('#reasonA').val() == 1 || $('#reasonA').val() == 4 || $('#reasonA').val() == 6) {
            //Pass
        } else {
            if ($('#sampletxt2r').val() == 'Click Sample and type Sampling report here.') {
                document.getElementById('sampletxt2r').innerHTML = "";
            }

            if ($('#reason2r').val() == 'Type reason for returning item(s) here.') {
                alert("Enter reason for returning before submitting.");
                return false;
            }
        }
        data = 'stockid=' + $('#stockid').val() + '&descripacydel=' + $('#descripacydel3r').val() + '&descripacydisp=' + $('#descripacydisp2r').val() + '&reasonA=' + $('#reasonA option:selected').text() +
                '&sampled=' + document.getElementById('sampled2r').checked + '&sampletxt=' + $('#sampletxt2r').val() +
                '&cqty=' + $('#cqty2r').val() + '&quantityreturned=' + $('#quantityreturned2r').val() + '&reason=' + $('#reason2r').val() + '&verify=' + document.getElementById('verify2r').checked;
    }
    ajaxSubmitData(Url, respDiv, data, 'POST');
}

function clearField(id) {
    if ($('#reason2r').val() == 'Type reason for returning item(s) here.') {
        document.getElementById(id).innerHTML = "";
        isClear = true;
    }

}
