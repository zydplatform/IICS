<%-- 
    Document   : item
    Created on : Jul 11, 2018, 8:23:06 AM
    Author     : IICS
--%>

<div class="row">
    <div class="col-md-4">
        <div class="row" style="overflow: auto; height: 350px;" >
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Enter Item Details</h4>
                    <div class="tile-body">
                        <form id="entryform">
                            <div class="form-group">
                                <label class="control-label">Item Classification</label>
                                <input class="form-control" type="text" >
                            </div>
                            <div class="form-group">
                                <label class="control-label">Item Category</label>
                                <input class="form-control" type="text" >
                            </div>
                            <div class="form-group">
                                <label class="control-label">Item Name</label>
                                <input class="form-control" id="itemname" type="text" placeholder="Item Name">
                            </div>
                            <div class="form-group">
                                <label class="control-label">Item Code</label>
                                <input class="form-control" id="itemcode" type="text" placeholder="Item Code">
                            </div>
                            <div class="form-group">
                                <label class="control-label">Item Form</label>
                                <input class="form-control" type="text" >
                            </div>
                            <div class="form-group">
                                <label class="control-label">Administering Type</label>
                                <input class="form-control" type="text" >
                            </div>
                            <div class="form-group">
                                <label>Item Strength</label>
                                <input type="text" placeholder="Your Item Name" class="itemstrength form-control" required />
                            </div>
                            <div class="form-group">
                                <label>Select Level here</label>
                                <select class="uselevels form-control" required>
                                    <c:forEach items="${levelsFound}" var="c">
                                        <option value="${c.facilitylevelid}">${c.shortname}</option>   
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Select Class here</label>
                                <select class="useclassform form-control" required>
                                    <option value="Vital">Vital(V)</option>
                                    <option value="Essential">Essential(E)</option>
                                    <option value="Necessary">Necessary(N)</option>
                                </select>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-md-4">Is Special</label>
                                <div class="col-md-8">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" style="font-weight: normal !important;"  type="radio" name="inlineRadioSpecial" id="inlineRadioisspecial1" value="true">
                                        <label class="form-check-label">Yes</label>
                                    </div>

                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" checked="true"  type="radio" name="inlineRadioSpecial" id="inlineRadioisspecial2" value="false">
                                        <label class="form-check-label">No</label>
                                    </div>
                                </div>
                            </div>       
                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="captureItem" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Add Item
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-8">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Entered Items.</h4>
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Item Name</th>
                                <th>Code</th>
                                <th>Category</th>
                                <th>Form</th>
                                <th>Admin Type</th>
                                <th>Item Strength</th>
                                <th>Level</th>
                                <th>Class</th>
                                <th>Is Special</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredItemsBody">

                        </tbody>
                    </table>
                </div>
                <div class="form-group">
                    <div class="col-sm-12 text-right">
                        <button type="button" class="btn btn-primary" id="saveItems">
                            Finish
                        </button>
                    </div>
                </div>
                <div class="form-group"></div>
            </div>
        </div>
    </div>
</div>