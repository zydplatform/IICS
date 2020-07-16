/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function showCopyRight(){
                var date = new Date().getFullYear();
                var copyright = "&copy;"+ date +" IICS. All Rights Reserved.";    
                $("#copyright").html(copyright);
               // $("#copyright").css({'font-weight':'bold', 'margin-top':'2%'});
               $("#copyright").css({'font-weight':'bold'});
            } 

/**
 *
 *Show or hide a div
 *
 */

function showDiv(id) {
    var div = document.getElementById(id);
    if ( div ) {
        div.style.display = "";
    }
}

function hideDiv(id) {
    var div = document.getElementById(id);
    if ( div ) {
        div.style.display = "none";
    }
}

function clearDiv(id) {
    var div = document.getElementById(id);
    if ( div ) {
        document.getElementById(id).innerHTML = "";
    }
}


function selectToggleCheckBox(toggle, fieldId, count) {
    var counter=parseInt(count);
    for( var i=1; i <= counter; i++ ) { 
        if(toggle) {
            document.getElementById(fieldId + i).checked = "checked";
        } 
        else {
            document.getElementById(fieldId + i).checked = "";
        }
    }
}

function selectToggleItems(toggle, fieldId, count) {
    var counter=parseInt(count);
    for( var i=1; i <= counter; i++ ) { 
        if(toggle) {
            if(document.getElementById(fieldId+"["+i+"]")!=null){
                document.getElementById(fieldId+"["+i+"]").checked = "checked";
            }
            else{
                document.getElementById(fieldId+i).checked = "checked";
            }
        } 
        else {
            if(document.getElementById(fieldId+"["+i+"]")!=null){
                document.getElementById(fieldId+"["+i+"]").checked = "";
            }
            else{
                document.getElementById(fieldId+i).checked = "";
            }
        }
    }
}

function initSorterTableId(tableid){    
    sorter = new TINY.table.sorter('sorter', tableid,{
        headclass:'head',
        ascclass:'asc',
        descclass:'desc',
        evenclass:'evenrow',
        oddclass:'oddrow',
        evenselclass:'evenselected',
        oddselclass:'oddselected',
        paginate:true,
        size:10,
        colddid:'columns',
        currentid:'currentpage',
        totalid:'totalpages',
        startingrecid:'startrecord',
        endingrecid:'endrecord',
        totalrecid:'totalrecords',
        hoverid:'selectedrow',
        pageddid:'pagedropdown',
        navid:'tablenav',
        sortcolumn:1,
        sortdir:1,
        sum:[8],
        avg:[6,7,8,9],
        columns:[{
            index:7,
            format:'%',
            decimals:1
        },{
            index:8,
            format:'$',
            decimals:0
        }],
        init:true
    });
}

function checkGender(result){
    document.getElementById("gender").value=result;
}

/**
 *Ensure only number are entered in the text field e.g for age
 *
 */
function isNumberKey(evt)
{
    var charCode = (evt.which) ? evt.which : evt.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

    return true;
}

function isDoubleNumberKey(evt)
{
    var charCode = (evt.which) ? evt.which : evt.keyCode
    if ((charCode > 31 && charCode!=46) && ((charCode < 48 && charCode!=46) || charCode > 57))
        return false;

    return true;
}

/**
 *Ensure only alphabetic letter are entered in the text field i.e [a-z][A-Z]
 *
 */
function isLetterKey(evt)
{
    var charCode = (evt.which) ? evt.which : evt.keyCode
    if (charCode > 31 && (charCode < 65 || charCode > 90) &&
        (charCode < 97 || charCode > 122))
        return false;
    
    return true;
}