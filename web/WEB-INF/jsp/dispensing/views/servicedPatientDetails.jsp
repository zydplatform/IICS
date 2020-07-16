<%-- 
    Document   : servicedPatientDetails
    Created on : Jun 5, 2019, 2:16:15 PM
    Author     : IICS TECHS
--%>
<%@include file="../../include.jsp" %>

<div class="row">
    <div class="col-md-12">
        <hr />
        <h6> 
            <span class="span-size-15">Patient Name: </span><span class="span-size-15 patient-name" style="color: #0000ff;"></span> &nbsp; &nbsp;    
            <c:if test="${telephone != null}">                
                <span class="span-size-15">Phone Number: </span><span class="span-size-15"><font color="blue">${telephone}</font></span> &nbsp; &nbsp;
            </c:if>
            <c:if test="${telephone == null}">                
                <span class="span-size-15">Next Of Kin: </span><span class="span-size-15"><font color="blue">${nextofkinname}</font></span> &nbsp; &nbsp;
                <span class="span-size-15">Phone Number: </span><span class="span-size-15"><font color="blue">${nextofkincontact}</font></span> &nbsp; &nbsp;
                <span class="span-size-15">Relationship: </span><span class="span-size-15"><font color="blue">${relationship}</font></span> &nbsp; &nbsp;
            </c:if>
        </h6>
        <hr />
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <c:if test="${prescriptionitems.size() > 0}">
            <div class="tile">
            <div class="tile-title"></div>
            <div class="tile-body">
                <table class="table table-bordered" id="prescription-items-table">
                    <thead>
                        <th style="width:4%;">No</th>
                        <th>Item Name</th>
                        <th style="width:6%;">Dosage</th>                       
                        <th style="width:12%;">Frequency</th>
                        <th>Duration</th>
<!--                        <th>Special Instructions</th>-->
                        <th>Reason</th>
                        </thead>
                    <tbody>
                        <% int x = 1;%>
                        <c:forEach items="${prescriptionitems}" var="item">
                            <tr>
                                <td><%=x++%></td>
                                <td>${item.itemname}
                                    <c:if test="${item.ismodified == Boolean.TRUE}"> &nbsp;
                                        <a href="#" class="modified-item fa fa-info-circle" data-prescription-items-id="${item.newprescriptionitemsid}" 
                                           data-item-name="${item.itemname}" style="color:#ff0000; font-size: larger;">
                                        </a>
                                    </c:if>
                                </td>
                                <td>${item.dose}</td>
                                <td>${item.dosage}</td>
                                <td>${item.days} ${item.daysname}</td>
                                <td>${item.notes}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot></tfoot>
                </table>
            </div>
            <div class="tile-footer"></div>
        </div>
        </c:if>
        <hr />                      
    </div>
</div>


<%--<div class="row">
    <div class="col-md-12">
        <hr />
        <h6> 
            <span class="span-size-15">Patient Name: </span><span class="span-size-15 patient-name" style="color: #0000ff;"></span> &nbsp; &nbsp;    
            <c:if test="${telephone != null}">                
                <span class="span-size-15">Phone Number: </span><span class="span-size-15"><font color="blue">${telephone}</font></span> &nbsp; &nbsp;
            </c:if>
            <c:if test="${telephone == null}">                
                <span class="span-size-15">Next Of Kin: </span><span class="span-size-15"><font color="blue">${nextofkinname}</font></span> &nbsp; &nbsp;
                <span class="span-size-15">Phone Number: </span><span class="span-size-15"><font color="blue">${nextofkincontact}</font></span> &nbsp; &nbsp;
                <span class="span-size-15">Relationship: </span><span class="span-size-15"><font color="blue">${relationship}</font></span> &nbsp; &nbsp;
            </c:if>
        </h6>
        <hr />
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <c:if test="${originalprescriptionitems.size() > 0}">
            <div class="tile">
            <div class="tile-title">
                <h5>Original Prescription Items</h5>
            </div>
            <div class="tile-body">
                <table class="table table-bordered" id="original-prescription-items-table">
                    <thead>
                        <th style="width:4%;">No</th>
                        <th>Item Name</th>
                        <th style="width:6%;">Dosage</th>                       
                        <th style="width:12%;">Frequency</th>
                        <th>Duration</th>
                        <th>Special Instructions</th>
                        </thead>
                    <tbody>
                        <% int x = 1;%>
                        <c:forEach items="${originalprescriptionitems}" var="item">
                            <tr>
                                <td><%=x++%></td>
                                <td>${item.itemname}</td>
                                <td>${item.dose}</td>
                                <td>${item.dosage}</td>
                                <td>${item.days} ${item.daysname}</td>
                                <td>${item.notes}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot></tfoot>
                </table>
            </div>
            <div class="tile-footer"></div>
        </div>
        </c:if>
        <hr />
        <c:if test="${modifiedprescriptionitems.size() > 0}">
            <div class="tile">
            <div class="tile-title">
                <h5>Modified Prescription Items</h5>
            </div>
            <div class="tile-body">
                <table class="table table-bordered" id="modified-prescription-items-table">
                    <thead>
                        <th style="width:4%;">No</th>
                        <th>Item Name</th>
                        <th style="width:6%;">Dosage</th>                       
                        <th style="width:12%;">Frequency</th>
                        <th>Duration</th>
                        <th>Special Instructions</th>
                    </thead>
                    <tbody>
                        <% int y = 1;%>
                        <c:forEach items="${modifiedprescriptionitems}" var="item">
                            <tr>
                                <td><%=y++%></td>                                
                                <td>${item.itemname}</td>
                                <td>${item.dose}</td>
                                <td>${item.days} ${item.daysname}</td>
                                <td>${item.dosage}</td>
                                <td>${item.reason}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot></tfoot>
                </table>
            </div>
            <div class="tile-footer"></div>
        </div>
        </c:if>                        
    </div>
</div>--%>

<script>
    $('.modified-item').on('click', function(e){
        e.stopPropagation();
        e.preventDefault();
        var prescriptionItemsId = $(this).data('prescription-items-id');
        var newName = $(this).data('item-name');
        $.ajax({
            type: 'GET',
            data: { prescriptionitemsid: prescriptionItemsId },
            url: 'dispensing/modifiedserviceditems.htm',
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                      icon: '',
                      title: 'ORIGINAL PRESCRIPTION ITEMS',
                      content: '' + data,
                      boxWidth: '70%',
                      useBootstrap: false,
                      type: 'purple',
                      typeAnimated: true,
                      closeIcon: true,
                      onContentReady: function(){
                        this.$content.find('.new-name').text(newName);  
                      },
                      buttons: {
                          OK: {
                              text: 'OK',
                              btnClass: 'btn-purple',
                              action: function () {
                              }
                          } 
                      }
                });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                  console.log(jqXHR);
                  console.log(textStatus);
                  console.log(errorThrown);
            }
        });
      });
</script>