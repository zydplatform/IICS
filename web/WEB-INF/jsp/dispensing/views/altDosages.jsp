<%-- 
    Document   : altDosages
    Created on : Apr 12, 2019, 9:43:12 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp"%>
<c:if test="${items.size() > 0}">
    <table class="table table-bordered table-striped" id="alt-dosages-table">
        <thead>
            <th>Item Name</th>
            <th>Dosage</th>
            <th>Item Form</th>
            <th>Qty In Stock</th>
            <th>Qty Booked</th>
            <th>Qty Available</th>
            <th>Include</th>
        </thead>
        <tbody>
            <c:forEach items="${items}" var="item">
                <tr>
                    <td>${item.itemname}</td>
                    <td>${item.dosage}</td>
                    <td>${item.itemform}</td>
                    <td>${item.qtyinstock}</td>
                    <td>${item.qtybooked}</td>
                    <td>${item.qtyavailable}</td>
                    <td>
                        <div class="toggle-flip">
                            <label>
                                <input type="checkbox" value="" class="item-toggle" 
                                       data-prescriptionitemsid="${prescriptionitemsid}" data-item-id="${item.itemid}" 
                                       data-dosage="${item.dosage}" data-current-dosage="${currentDosage}" <c:if test="${item.exists == true}">checked="checked"</c:if>/>
                                <span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                            </label>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
        <tfoot></tfoot>
    </table>
    <hr />
    <button></button>
</c:if>
<c:if test="${items.size() == 0}">
    <h3 class="text-center text-primary">No Alternate Dosages.</h3>
</c:if>
<script>
    $('input.item-toggle').on('change', function(e){
        console.log(e);        
        if(e.currentTarget.checked){   
            var self = $(this);
            var data = {
                prescriptionitemsid: self.data("prescriptionitemsid"), 
                itemid: self.data("item-id"),
                dosage: self.data("dosage"),
                currentdosage: self.data("current-dosage"),
                initialrequest: true,
                forcesave: false
            };
            console.log(data);
            $.ajax({
                type: 'POST',
                data: data,
                url: "dispensing/savealternatedosages.htm",
               success: function (result, textStatus, jqXHR) {
                   if(result.toString().toLowerCase() === "success"){
                       altDoseSelected = true;
                       $.toast({
                            heading: 'Success',
                            text: 'Operation Successful!',
                            icon: 'success',
                            hideAfter: 4000,
                            position: 'mid-center'
                        });          
                   } else if(result.toString().toUpperCase() === "The dosage will be split into 4. Do you want to continue?".toUpperCase()){
                       $.confirm({
                            title: '',
                            content: result.toString(),
                            boxWidth: '35%',
                            useBootstrap: false,
                            type: 'purple',
                            typeAnimated: true,
                            closeIcon: true,
                            theme: 'modern',
                            buttons:{
                                Yes:{
                                text: 'Yes',
                                btnClass: 'btn-red',
                                keys: ['enter', 'shift'],
                                action: function (){
                                    data.initialrequest = false;
                                    $.ajax({type: 'POST',
                                    data: data,
                                    url: "dispensing/savealternatedosages.htm",
                                   success: function (result, textStatus, jqXHR){
                                       if(result.toString().toLowerCase() === "success"){
                                           altDoseSelected = true;
                                            $.toast({
                                                 heading: 'Success',
                                                 text: 'Operation Successful!',
                                                 icon: 'success',
                                                 hideAfter: 4000,
                                                 position: 'mid-center'
                                             });          
                                        }
                                   },error: function (jqXHR, textStatus, errorThrown) {
                                       console.log(jqXHR);
                                       console.log(errorThrown);
                                   }});
                                } 
                            },
                            No:{
                                text: 'No',
                                btnClass: 'btn-purple',
                                keys: ['enter', 'shift'],
                                action: function (){                                    
                                }
                            }
                        }
                       });
                   }else if(result.toString() === "This item already has an alternate dosage. Do you want to save anyway?"){
                       $.confirm({
                            title: '',
                            content: result.toString(),
                            boxWidth: '35%',
                            useBootstrap: false,
                            type: 'purple',
                            typeAnimated: true,
                            closeIcon: true,
                            theme: 'modern',
                            buttons:{
                                Yes:{
                                text: 'Yes',
                                btnClass: 'btn-red',
                                keys: ['enter', 'shift'],
                                action: function (){
                                    data.forcesave = true;
                                    data.initialrequest = false;
                                    $.ajax({type: 'POST',
                                    data: data,
                                    url: "dispensing/savealternatedosages.htm",
                                   success: function (result, textStatus, jqXHR){
                                       if(result.toString().toLowerCase() === "success"){
                                           altDoseSelected = true;
                                            $.toast({
                                                 heading: 'Success',
                                                 text: 'Operation Successful!',
                                                 icon: 'success',
                                                 hideAfter: 4000,
                                                 position: 'mid-center'
                                             });          
                                        }
                                   },error: function (jqXHR, textStatus, errorThrown) {
                                       console.log(jqXHR);
                                       console.log(errorThrown);
                                   }});
                                } 
                            },
                            No:{
                                text: 'No',
                                btnClass: 'btn-purple',
                                keys: ['enter', 'shift'],
                                action: function (){                                    
                                }
                            }
                        }
                       });
                   }else {
                       $.toast({
                            heading: 'Error',
                            text: result.toString(),
                            icon: 'error',
                            hideAfter: 5000,
                            position: 'mid-center'
                        });                    
                   }
               },
               error: function (jqXHR, textStatus, errorThrown) {
                   console.log(jqXHR);
                   console.log(textStatus);
                   console.log(errorThrown);
               }
            });
        }else { // Remove Item
            var data = {prescriptionitemsid: $(this).data("prescriptionitemsid"), itemid: $(this).data("item-id")};
            $.ajax({
                type: 'POST',
                data: data,
                url: "dispensing/deletealternatedosage.htm",
               success: function (result, textStatus, jqXHR) {
                   if(result.toString().toLowerCase() === "success"){
                       $.toast({
                            heading: 'Success',
                            text: 'Operation Successful!',
                            icon: 'success',
                            hideAfter: 4000,
                            position: 'mid-center'
                        }); 
                    }else if(result.toString().toLowerCase() === "failure") {
                        $.toast({
                            heading: 'Error',
                            text: "Operation Failed. Please Try Again.",
                            icon: 'error',
                            hideAfter: 4000,
                            position: 'mid-center'
                        }); 
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR);    
                    cosole.log(textStatus);
                    console.log(errorThrown);
                }                
            });
        }
    });
</script>

