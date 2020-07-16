<%-- 
    Document   : viewcelllabels
    Created on : Jul 11, 2018, 12:25:39 PM
    Author     : user
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="showprintPDF1x">
    <h5 class="hidedisplaycontent" id="zoneTitlex">${zName}</h5>
    <div>
        <button type="button" class="pull-right btn btn-secondary" id="printcellLabelsx"><i class="fa fa-print"></i> Print All</button>
        <button type="button" class="pull-right btn btn-secondary hidedisplaycontent" id="printselectedcellsx" data-id="${zName}" onclick="printuserselectCellx($(this).attr('data-id'))"><i class="fa fa-print"></i> Print&nbsp;(<span id="addcellscountx"></span>)cell label(s)</button>
    </div><br><br>
    <div class="tile-body" id="">                                
        <table class="table table-hover table-bordered" id="sampleTablex">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Cell Label</th>
                    <th>Print Cell Label(s)</th>
                </tr>
            </thead>
            <tbody>
                <% int v = 1;%>
                <c:forEach items="${selectedcellDetails}" var="b">
                    <tr id="">
                        <td><%=v++%></td>
                        <td align="center">${b.celllabel}</td>
                        <td align="center"><input type="checkbox" name="selectedCells[]" value="${b.celllabel}" onchange="if (this.checked) {
                                checkedoruncheckedcellElement(this.value, 'checked');
                            } else {
                                checkedoruncheckedcellElement(this.value, 'unchecked');
                            }"/>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table> 
    </div>                                
</div>
<div id="showprintcontentx" style="height: 450px;"></div>
<script>
    var printingSet =  new Set();
    $(document).ready(function () {
        $('#sampleTablex').DataTable();
        $('#printcellLabelsx').click(function () {
            var jsoncellLabels = ${jsonselectedCell};
            console.log(jsoncellLabels);
            var zoneName = $('#zoneTitlex').html();
            for(var index in jsoncellLabels){
                var data = jsoncellLabels[index];
                if(printingSet.has(data.celllabel)){                    
                }else{
                    printingSet.add(data.celllabel);
                }
            }
            if(printingSet.size !== 0){
               $.ajax({
                type: 'GET',
                cache: false,
                dataType: 'text',
                data: {Tags: JSON.stringify(Array.from(printingSet)), zonetitle: zoneName},
                url: "localsettigs/printzoneTagsALL.htm",
                success: function (textStatus) {
                    printingSet.clear();
                    $.toast({
                        heading: 'Success',
                        text: 'CeLL Labels Printed Successfully.',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    var objbuilder = '';
                    objbuilder += ('<object width="100%" height="100%" data="data:application/pdf;base64,');
                    objbuilder += (textStatus);
                    objbuilder += ('" type="application/pdf" class="internal">');
                    objbuilder += ('<embed src="data:application/pdf;base64,');
                    objbuilder += (textStatus);
                    objbuilder += ('" type="application/pdf"  />');
                    objbuilder += ('</object>');
                    $('#showprintPDF1x').hide();
                    $('#showprintcontentx').html(objbuilder);
                    //$('#showprintcontentx').html('<button class="btn btn-secondary" onclick="gobacktolistview();"><i class="fa fa-arrow-left"></i>Back</button><br><br>'+objbuilder);
                    }, error: function (textStatus) {

                }
             });  
            }           
        });
    });
    function gobacktolistview(){
        $('#showprintPDF1x').show();
        $('#showprintcontentx').hide();
    }
    var selecteduserlistSet = new Set();
    function checkedoruncheckedcellElement(value, status) {
        var jsoncellLabels = ${jsonselectedCell};
        var cellsize = jsoncellLabels.length;
        $('#printcellLabelsx').hide();
        if (status === 'checked') {
            selecteduserlistSet.add(value);
        } else if (status === 'unchecked') {
            selecteduserlistSet.delete(value);
        } else {
        }
        if (parseInt(selecteduserlistSet.size) === 0) {
            document.getElementById('printselectedcellsx').style.display = 'none';
            document.getElementById('printcellLabelsx').style.display = 'block';
        } else if (parseInt(selecteduserlistSet.size) > 0 && parseInt(selecteduserlistSet.size) !== parseInt(cellsize)) {
            document.getElementById('addcellscountx').innerHTML = selecteduserlistSet.size;
            document.getElementById('printselectedcellsx').style.display = 'block';
        } else if (parseInt(selecteduserlistSet.size) === parseInt(cellsize)) {
            document.getElementById('printselectedcellsx').style.display = 'none';
            document.getElementById('printcellLabelsx').style.display = 'block';
        }
    }
    var userselectObj = [];
    function printuserselectCellx(zoneName) {
        if (parseInt(selecteduserlistSet.size) !== 0) {
            var SelectedcellsObj = Array.from(selecteduserlistSet);
            for (var x in SelectedcellsObj) {
                userselectObj.push({
                    celllabel: SelectedcellsObj[x]
                });
            }
            $.ajax({
                type: 'GET',
                cache: false,
                dataType: 'text',
                data: {Tags: JSON.stringify(userselectObj), zonetitle: zoneName},
                url: "localsettigs/printselectedcellLabels.htm",
                success: function (textStatus) {
                    userselectObj = [];
                    $.toast({
                        heading: 'Success',
                        text: 'CeLL Labels Printed Successfully.',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    //console.log(textStatus);
                    var objbuilder = '';
                    objbuilder += ('<object width="100%" height="100%" data="data:application/pdf;base64,');
                    objbuilder += (textStatus);
                    objbuilder += ('" type="application/pdf" class="internal">');
                    objbuilder += ('<embed src="data:application/pdf;base64,');
                    objbuilder += (textStatus);
                    objbuilder += ('" type="application/pdf"  />');
                    objbuilder += ('</object>');
                    $('#showprintPDF1x').hide();
                    $('#showprintcontentx').html(objbuilder);
                   // $('#showprintcontentx').html('<button class="btn btn-secondary" onclick="gobacktolistview();"><i class="fa fa-arrow-left"></i>Back</button><br><br>'+objbuilder);
                }, error: function (textStatus) {

                }
            });

        }
    }
</script>